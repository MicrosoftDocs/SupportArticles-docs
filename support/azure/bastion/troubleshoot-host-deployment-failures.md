---
title: Troubleshoot Azure Bastion host deployment failures
description: Resolve Azure Bastion deployment failures with step-by-step diagnostics for subnet configuration, capacity issues, RBAC permissions, and orphaned resources. Learn how to fix AzureBastionSubnet sizing and troubleshoot deployment errors.
ms.service: azure-bastion
ms.topic: troubleshooting
ms.custom: sap:Configuration and setup
ms.date: 07/09/2026
ai.hint.symptom-tags:
  - bastion-deployment-failed
  - bastion-create-failed
  - bastion-update-failed
  - azurebastionsubnet-too-small
  - azurebastionsubnet-not-dedicated
  - azurebastionsubnet-missing
  - allocation-failed
  - zonal-allocation-failed
  - sku-not-available
  - bastion-stuck-updating
  - bastion-failed-state
  - authorization-failed
  - subnet-join-denied
  - public-ip-prerequisite
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/bastionHosts/read
  - Microsoft.Network/bastionHosts/write
  - Microsoft.Network/bastionHosts/delete
  - Microsoft.Network/virtualNetworks/read
  - Microsoft.Network/virtualNetworks/subnets/read
  - Microsoft.Network/virtualNetworks/subnets/write
  - Microsoft.Network/virtualNetworks/subnets/join/action
  - Microsoft.Network/publicIPAddresses/read
  - Microsoft.Network/publicIPAddresses/join/action
  - Microsoft.Authorization/roleAssignments/read
  - Microsoft.Insights/eventtypes/values/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - VNET_NAME
---

# Troubleshoot Azure Bastion host deployment failures

## Summary

This article provides step-by-step diagnostics to resolve Azure Bastion deployments that fail or get stuck because of subnet, capacity, zone, or permission prerequisites. 

The most common reasons for these problems are:

- `AzureBastionSubnet` is missing, smaller than `/26`, or shares the subnet with other resources. 
- The target region or availability zone has no capacity for the requested Azure Bastion SKU and zone set.
- A previous deployment left the host in a `Failed` or `Updating` state and a clean redeploy is needed.
- The deploying identity lacks `Microsoft.Network/virtualNetworks/subnets/join/action` on the Azure Bastion subnet or `Microsoft.Network/publicIPAddresses/join/action` on the public IP.

## Symptoms

You might encounter one or more of the following symptoms:

- The Azure Bastion create or update operation fails in the [Azure portal](https://portal.azure.com) with `Deployment failed` and a red error banner.
- The Azure Bastion host shows `provisioningState: "Failed"` or stays in the `provisioningState: "Updating"` state for an extended period after the operation should have completed.
- Error: `The subnet AzureBastionSubnet is too small. It must be /26 or larger.`
- Error: `The subnet name 'AzureBastionSubnet' is required for Azure Bastion.`
- Error: `Subnet AzureBastionSubnet is not empty. Bastion requires a dedicated subnet.`
- Error: `AllocationFailed` or `ZonalAllocationFailed` or `SkuNotAvailable` or `Zone '<n>' is not supported for resource type 'bastionHosts' in location '<region>'`.
- Error: `AuthorizationFailed: The client '...' does not have authorization to perform action 'Microsoft.Network/virtualNetworks/subnets/join/action'`.
- Error: `The public IP address ... must be Standard SKU and Static allocation` (Azure Bastion Basic, Standard, or Premium).
- A previous Azure Bastion resource can't connect or be updated. Only deleting and redeploying recovers it.

## Prerequisites

To troubleshoot this problem, you need the following items:

- **Permissions required:** `Reader` permissions on the subscription and the target virtual network (VNet) for diagnostics, plus `Network Contributor` (or an equivalent custom role) on the VNet, `AzureBastionSubnet`, and the public IP to apply fixes. For [Resolution D](#resolution-d), you also need `User Access Administrator` or `Owner` permissions on the target scope to add role assignments.
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access. The `bastion` CLI extension is installed automatically on first use.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing (or intended to contain) the Azure Bastion host | `myResourceGroup` |
| `{RESOURCE_NAME}` | Azure Bastion host resource name | `myBastion` |
| `{VNET_NAME}` | Virtual network the Azure Bastion host is deployed into | `myVNet` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether an Azure Bastion host already exists in the target resource group, and if so, its provisioning state. This check determines whether you're debugging a brand-new create operation that never produced a resource, a failed create operation that left an orphaned resource, or an update operation that broke a previously healthy host.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, sku:sku.name, location:location, zones:zones, bastionSubnetId:ipConfigurations[0].subnet.id, publicIpId:ipConfigurations[0].publicIPAddress.id}" \
  --output json 2>&1
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `provisioningState: "Succeeded"`. | The Azure Bastion host is healthy right now. If the failure was a recent update, see the activity-log error in [Step 3](#step-3). | Perform [Step 2](#step-2). |
| `provisioningState: "Failed"`. | The deployment partially created an Azure Bastion host and left it broken. | Perform [Step 2](#step-2). |
| `provisioningState: "Updating"`. | An operation is in progress. If [Step 2](#step-2) and [Step 3](#step-3) don't surface a fixable cause, the Azure Bastion host is stuck. | Perform [Step 2](#step-2). |
| Error `ResourceNotFound` (`The Resource ... was not found`). | No resource was created. The deployment failed before a persistent state happened. The activity log still records the attempt. | Perform [Step 2](#step-2). |
| Error `SubscriptionNotFound` or `ResourceGroupNotFound`. | The subscription or resource group name is wrong. | Verify your `$SUBSCRIPTION` and `$RG` values and re-run. |

Record the returned `bastionSubnetId`, `publicIpId`, and `zones` values (if any) as [Step 2](#step-2) and [Step 3](#step-3) reference them.

### Step 2

Check whether the `AzureBastionSubnet` exists in the VNet with the exact required name, has at least a value of `/26`, and is dedicated to Azure Bastion and no other resources. 

> [!NOTE]
> These prerequisites are mandatory. If any one of them is wrong, create or update operations for the host fail.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet subnet list \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, prefix:addressPrefix, prefixes:addressPrefixes, ipConfigCount:length(ipConfigurations || \`[]\`), delegations:delegations[].serviceName}" \
  --output json
```

Then inspect `AzureBastionSubnet` specifically (skip this step if the prior commands indicate it's absent):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet subnet show \
  --name AzureBastionSubnet \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, prefix:addressPrefix, ipConfigs:ipConfigurations[].id}" \
  --output json 2>&1
```

### Interpret the results

Determine the subnet's prefix length from `addressPrefix` (the number after `/`). A `/26` value allows 64 addresses. Smaller prefixes (like `/27`, `/28`, and so on) are too small.

| If you see... | Meaning | Next steps |
|---|---|---|
| `ResourceNotFound` for `AzureBastionSubnet`, or the list shows the subnet is named anything other than exactly `AzureBastionSubnet` (case-sensitive). | The required subnet is missing. Azure Bastion only deploys into a subnet with that exact name. | Perform [Resolution A](#resolution-a). |
| `addressPrefix` ends in `/27`, `/28`, `/29`, or smaller. | The subnet is below the `/26` minimum. | Perform [Resolution A](#resolution-a). |
| `ipConfigs` is non-empty and the existing IPs belong to anything other than this Azure Bastion host (like network interface cards (NICs), other gateways, or private endpoints). | The subnet isn't dedicated to Azure Bastion. | Perform [Resolution A](#resolution-a). |
| The subnet exists, prefix is `/26` or larger, and has either no IPs or only this Azure Bastion host's IPs. | The subnet envelope is correct. | Go to [Step 3](#step-3). |

> [!NOTE]
> A `/26` value is the minimum supported subnet size for every current Azure Bastion SKU. Plan a larger range (for example, `/25` or `/24`) if you intend to scale up host instances later. Scaling fails with the same allocation errors covered in [Resolution B](#resolution-b) when the subnet runs out of room.

### Step 3

Check the most recent failed write against `Microsoft.Network/bastionHosts` in the resource group. The activity log error message is used to determine between capacity failures, permission failures, and platform failures.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az monitor activity-log list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --status Failed \
  --offset 7d \
  --max-events 50 \
  --query "[?contains(resourceType.value, 'bastionHosts')].{time:eventTimestamp, op:operationName.localizedValue, sub:subStatus.localizedValue, caller:caller, msg:properties.statusMessage}" \
  --output json
```

If the list is empty, broaden the window:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az monitor activity-log list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --status Failed \
  --offset 30d \
  --max-events 100 \
  --query "[?contains(resourceType.value, 'bastionHosts') || contains(resourceType.value, 'publicIPAddresses') || contains(resourceType.value, 'virtualNetworks')].{time:eventTimestamp, op:operationName.localizedValue, type:resourceType.value, sub:subStatus.localizedValue, msg:properties.statusMessage}" \
  --output json
```

### Interpret the results

The `msg` field contains a JSON-stringified error from Azure Resource Manager (ARM). Search the most recent entry for the substrings in the following table. Match them in this order. The first row that matches takes priority.

| If the error message contains... | Meaning | Next steps |
|---|---|---|
| `AuthorizationFailed`, `does not have authorization to perform action`, `subnets/join/action`, or `publicIPAddresses/join/action`. | The deploying identity is missing one of the required permissions on the VNet, subnet, or public IP. | Perform [Resolution D](#resolution-d). |
| `Subnet AzureBastionSubnet is too small`, `must be /26 or larger`, `Subnet name 'AzureBastionSubnet' is required`, `Subnet ... is not empty`, or `DedicatedSubnetForBastion`. | A subnet prerequisite is unmet ([Step 2](#step-2) likely already flagged this). | Perform [Resolution A](#resolution-a). |
| `PublicIPAddress ... must be Standard SKU`, `must be Static`, `PublicIPSkuMismatch`, `BasicSkuPublicIpNotSupportedForBastion`, or `PublicIPMustBeInSameRegion`. | The bring-your-own public IP doesn't meet Azure Bastion's prerequisites. | Perform [Resolution A](#resolution-a). |
| `AllocationFailed`, `ZonalAllocationFailed`, `OutOfCapacity`, `SkuNotAvailable`, `Zone '...' is not supported`, `AvailabilityZone`, or `RegionNotAvailable`. | A regional or zonal capacity constraint blocked the SKU or zone you requested. | Perform [Resolution B](#resolution-b). |
| `ResourceDeploymentFailure`, `InternalServerError`, generic `Conflict`, or `msg` is empty and [Step 1](#step-1) reported `Failed` or `Updating`. | The deployment left an orphaned or stuck resource that needs to be removed and redeployed. | Perform [Resolution C](#resolution-c). |
| The list is empty at 30 days and [Step 1](#step-1) reported `Failed` or `Updating`. | Activity log retention aged out the error but the resource is still broken. | Perform [Resolution C](#resolution-c). |
| The list is empty and [Step 1](#step-1) reported `ResourceNotFound`. | No record of an Azure Bastion deployment in this resource group. Check that you targeted the right `$RG` or `$SUBSCRIPTION`. | Re-run [Step 1](#step-1) against the correct scope. |

> [!NOTE]
> ARM activity log entries are retained for 90 days, but `az monitor activity-log list` is capped at 90 days. If the failure is older than that, trigger a fresh deployment attempt to reproduce a current error to use for diagnostic purposes.

### Step 4

Check whether the deploying identity holds the role assignments required to create or update an Azure Bastion host. Run this check only when [Step 3](#step-3) points to permissions [Resolution D](#resolution-d) or returns no useful error. In this case, you need to rule permissions in or out before doing a destructive cleanup.

Identify the principal that attempted the failing deployment. The `caller` field from [Step 3](#step-3) is the authoritative answer for the failed attempt. Use the currently signed-in user only as a fallback.

Run these commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$DEPLOYER" ] && read -rp "Deployer (caller from Step 3, UPN, or principal object ID): " DEPLOYER

az role assignment list \
  --assignee "$DEPLOYER" \
  --all \
  --include-inherited \
  --include-groups \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table
```

Then check whether that principal has effective rights at the VNet, subnet, and public IP scopes:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$DEPLOYER" ] && read -rp "Deployer: " DEPLOYER

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

SUBNET_ID="${VNET_ID}/subnets/AzureBastionSubnet"

az role assignment list \
  --assignee "$DEPLOYER" \
  --scope "$VNET_ID" \
  --include-inherited \
  --include-groups \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table

az role assignment list \
  --assignee "$DEPLOYER" \
  --scope "$SUBNET_ID" \
  --include-inherited \
  --include-groups \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `Network Contributor`, `Owner`, or `Contributor` at subscription, resource group, VNet, or subnet scope. | The principal has subnet-join rights through a built-in role. | Permissions aren't the problem. Return to the matching row in [Step 3](#step-3). |
| Only `Reader` and Azure Bastion-specific roles, no `*/write` or `subnets/join/action` granting role. | The principal can't join the subnet or create the Azure Bastion host. | Perform [Resolution D](#resolution-d). |
| No assignments returned at any scope. | The principal has no access to the resource group or VNet. | Perform [Resolution D](#resolution-d). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| `AzureBastionSubnet` missing, misnamed, smaller than `/26`, or contains non-Azure Bastion resources ([Step 2](#step-2)). | Perform [Resolution A](#resolution-a). |
| Activity log error mentions public IP SKU, allocation method, or region mismatch ([Step 3](#step-3)). | Perform [Resolution A](#resolution-a). |
| Activity log error contains `AllocationFailed`, `ZonalAllocationFailed`, `SkuNotAvailable`, `OutOfCapacity`, or zone-not-supported ([Step 3](#step-3)). | Perform [Resolution B](#resolution-b). |
| [Step 1](#step-1) shows `Failed` or `Updating` and [Step 2](#step-2)–[Step 4](#step-4) surface no fixable cause. | Perform [Resolution C](#resolution-c). |
| Activity log error contains `AuthorizationFailed`, `subnets/join/action`, or `publicIPAddresses/join/action`, or [Step 4](#step-4) shows the deployer lacks join rights. | Perform [Resolution D](#resolution-d). |
| All diagnostics pass but deployment still fails. | File an Azure support request. |

## Resolution A

The deployment can't proceed because `AzureBastionSubnet` is missing, has the wrong name, is smaller than the required `/26`, isn't dedicated to Azure Bastion, or the bring-your-own public IP doesn't meet the SKU, allocation, or region prerequisites. 

> [!NOTE]
> These prerequisites are mandatory. If any one of them is wrong, create or update operations for the host fail.

Common contributing causes include:

- You created the subnet with a different name (for example, `BastionSubnet` or `azurebastionsubnet`). The required name is exactly `AzureBastionSubnet` and is case-sensitive.
- You created the subnet at `/27` to save addresses, but Azure Bastion requires `/26` minimum.
- You placed a test NIC, gateway, or private endpoint in `AzureBastionSubnet`, which is dedicated to Azure Bastion.
- You attached an Azure Bastion Basic SKU or dynamic public IP. Azure Bastion (Basic, Standard, and Premium) require a Standard SKU and static allocation in the same region.

Run the following commands in Azure CLI.

1. Capture the current subnet definition and any existing public IP so you have a record before changing anything.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query "{addressSpace:addressSpace.addressPrefixes, subnets:subnets[].{name:name, prefix:addressPrefix}}" \
  --output json
```

Identify a free `/26` (or larger) range inside the VNet's address space. Confirm it doesn't overlap any existing subnet.

If you brought your own public IP, validate it:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PIP_NAME" ] && read -rp "Public IP Name:  " PIP_NAME

az network public-ip show \
  --name "$PIP_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query "{name:name, sku:sku.name, allocation:publicIPAllocationMethod, location:location, zones:zones}" \
  --output json
```

The public IP must report `sku: "Standard"`, `allocation: "Static"`, and the same `location` as the Azure Bastion host you intend to deploy. Zones, if set, must match the Azure Bastion `zones` you intend to use.

2. If the subnet has the wrong name, delete the misnamed one (only if it is empty) and create a correctly named subnet:

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. These write operations modify your virtual network and can delete or recreate the `AzureBastionSubnet`.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$WRONG_NAME" ] && read -rp "Misnamed subnet to delete (or leave blank to skip): " WRONG_NAME

if [ -n "$WRONG_NAME" ]; then
  az network vnet subnet delete \
    --name "$WRONG_NAME" \
    --vnet-name "$VNET_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION"
fi
```

Create (or resize using delete-then-create operations) the correctly named `AzureBastionSubnet`:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$BASTION_PREFIX" ] && read -rp "AzureBastionSubnet prefix (must be /26 or larger, e.g. 10.0.1.0/26): " BASTION_PREFIX

az network vnet subnet create \
  --name AzureBastionSubnet \
  --vnet-name "$VNET_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --address-prefixes "$BASTION_PREFIX"
```

If the existing `AzureBastionSubnet` is too small but already contains the Azure Bastion host, you can't resize it in place. Delete the Azure Bastion host first (see [Resolution C](#resolution-c)), delete and recreate the subnet at `/26` or larger, and then redeploy the host.

If the subnet contains a stray resource (like NIC, private endpoint, or gateway), remove or move that resource before retrying. Azure Bastion can't deploy into a shared subnet.

If the public IP is wrong, create a new compliant one:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$REGION" ] && read -rp "Region (same as Bastion): " REGION
[ -z "$NEW_PIP_NAME" ] && read -rp "New Public IP Name:   " NEW_PIP_NAME

az network public-ip create \
  --name "$NEW_PIP_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --location "$REGION" \
  --sku Standard \
  --allocation-method Static \
  --version IPv4
```

3. Redeploy the Azure Bastion host now that the subnet and public IP prerequisites are correct.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME
[ -z "$NEW_PIP_NAME" ] && read -rp "Public IP Name (Standard, Static): " NEW_PIP_NAME

az network bastion create \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --public-ip-address "$NEW_PIP_NAME"
```

Re-run [Step 1](#step-1). The Azure Bastion host should now show `provisioningState: "Succeeded"`. If the create still fails with the same subnet or public IP error, revisit the new activity log entry from [Step 3](#step-3). A different prerequisite might still be unmet.

If the new error is capacity-related, go to [Resolution B](#resolution-b).

## Resolution B

The requested combination of SKU, region, and availability zones doesn't currently have capacity in Azure, or the region doesn't support availability zones for `bastionHosts`. Capacity failures surface as `AllocationFailed`, `ZonalAllocationFailed`, `OutOfCapacity`, `SkuNotAvailable`, or `Zone '<n>' is not supported for resource type 'bastionHosts' in location '<region>'`. These errors aren't fixable by retry alone. You must change the zone selection, the SKU, or the region.

Run the following commands in Azure CLI.

1. Confirm which zones (if any) `bastionHosts` supports in your target region.


```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$REGION_DISPLAY" ] && read -rp "Region display name (e.g. 'East US 2', not 'eastus2'): " REGION_DISPLAY

az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "resourceTypes[?resourceType=='bastionHosts'] | [0].zoneMappings[?location=='$REGION_DISPLAY']" \
  --output json
```

> [!NOTE]
> `zoneMappings[].location` carries the region's display name (`East US 2`), not the region code (`eastus2`). Enter the display name exactly as shown in the Azure portal region picker. The `| [0]` projection is required. Without it, the JMESPath filter flattens to `[]` for every region.

**Interpret the results**

| If you see... | Meaning | Next steps |
|---|---|---|
| A non-empty array like `[{"location":"East US 2","zones":["1","2","3"]}]`. | The region supports zonal Azure Bastion. You can deploy zonal or non-zonal. | Go to the next step. |
| An empty array `[]`. | The region doesn't support availability zones for Azure Bastion. Deploy non-zonal in this region, or pick a different region. | Go to the next step. |

2. Redeploy without the `--zone` parameter if the failure was zonal (for example `ZonalAllocationFailed` or `Zone '...' is not supported`).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME
[ -z "$NEW_PIP_NAME" ] && read -rp "Public IP Name (Standard, Static, no zones for non-zonal): " NEW_PIP_NAME

az network bastion create \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --public-ip-address "$NEW_PIP_NAME"
```

If you already have an orphaned `Failed` or `Updating` Azure Bastion host blocking the redeploy, run [Resolution C](#resolution-c) first to remove it.

If the failure was regional (like `AllocationFailed`, `SkuNotAvailable`, or `OutOfCapacity`) and a non-zonal retry also fails, deploy into another region in the same VNet's geography. Azure Bastion is per-VNet, so a new region requires a new VNet.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$ALT_REGION" ] && read -rp "Alternate region (e.g. eastus2): " ALT_REGION
[ -z "$ALT_VNET_NAME" ] && read -rp "Alternate VNet Name: " ALT_VNET_NAME
[ -z "$ALT_VNET_PREFIX" ] && read -rp "Alternate VNet prefix (e.g. 10.10.0.0/16): " ALT_VNET_PREFIX

az network vnet create \
  --name "$ALT_VNET_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --location "$ALT_REGION" \
  --address-prefixes "$ALT_VNET_PREFIX" \
  --subnet-name AzureBastionSubnet \
  --subnet-prefixes "${ALT_VNET_PREFIX%/*}/26"
```

Then create the Azure Bastion host in the alternate region without zones as shown in the prior commands.

3. Re-run [Step 1](#step-1) and [Step 3](#step-3). The Azure Bastion host should reach `Succeeded` and no new `AllocationFailed` or `ZonalAllocationFailed` events should appear. If allocation still fails in a second region, open an Azure support request and reference the latest correlation IDs from the activity log query in [Step 3](#step-3).

## Resolution C

A previous create or update operation left the Azure Bastion host in a `Failed` state or stuck in `Updating`. The resource provider rejects in-place updates against a broken backend, so the only reliable recovery is to delete the host and redeploy from a known-good configuration.

Run the following commands in Azure CLI.

1. Confirm the current state and capture the configuration you want to preserve.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --output json
```

Record the `sku.name`, `enableTunneling`, `enableIpConnect`, `enableFileCopy`, `enableShareableLink`, `scaleUnits`, `zones`, and the IDs of the subnet and public IP. You'll need them for step 3.

2. Delete the broken Azure Bastion host.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

> [!NOTE]
> Deleting the Azure Bastion host disconnects any active sessions. The `AzureBastionSubnet` and the public IP aren't deleted by this command. They're needed for step 3.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion delete \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION"
```

If the delete operation fails or hangs (the host stays present after the command returns), the resource is genuinely orphaned at the backend level. Open an Azure support request, attach the activity-log output from [Step 3](#step-3), and reference the resource ID.

3. Recreate the Bastion host with the same configuration (or a corrected one if [Resolution A](#resolution-a) or [Resolution B](#resolution-b) showed a prerequisite needed to change first).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME
[ -z "$PIP_NAME" ] && read -rp "Public IP Name:  " PIP_NAME
[ -z "$SKU" ] && read -rp "SKU (Basic / Standard / Premium): " SKU
SKU=${SKU:-Standard}

az network bastion create \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --public-ip-address "$PIP_NAME" \
  --sku "$SKU"
```

If your previous Azure Bastion host had tunneling, IP-based connect, file copy, shareable link, or extra scale units enabled, re-enable them after the create operation completes:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion update \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --enable-tunneling true \
  --enable-ip-connect true
```

4. Re-run [Step 1](#step-1). The host should report `provisioningState: "Succeeded"` and the configuration you specified. 

Try a test connection to a virtual machine (VM) in the same VNet to confirm the data plane is healthy. If the create operation still produces a `Failed` state, return to [Step 3](#step-3) and use the new error for further diagnostics. The underlying cause isn't only an orphaned resource.

## Resolution D

The identity attempting the deployment lacks one or more of the Azure role-based access control (RBAC) permissions Azure Bastion needs at create or update time. Azure Bastion's create call performs writes against the Azure Bastion host resource, joins the `AzureBastionSubnet`, and joins the public IP. Each of those actions requires its own data-plane permission, and missing any one prevents the whole deployment with an `AuthorizationFailed` error.

The Azure Bastion-deployment permissions are:

| Action | Required scope |
|---|---|
| `Microsoft.Network/bastionHosts/write` | Resource group (or subscription) |
| `Microsoft.Network/virtualNetworks/subnets/join/action` | `AzureBastionSubnet` (or parent VNet) |
| `Microsoft.Network/publicIPAddresses/join/action` | Public IP used by Azure Bastion |
| `Microsoft.Network/virtualNetworks/read` | VNet |
| `Microsoft.Network/publicIPAddresses/read` | Public IP |

The built-in `Network Contributor` role grants all of these permissions at its scope. `Owner` and `Contributor` do too, by virtue of `*/write` and `*/action` wildcards.

Run the following commands in Azure CLI.

1. Confirm the identity you want to grant. If the deployment was triggered by an automation principal (like service principal, managed identity, or GitHub Actions OpenID Connect (OIDC)), use its object ID. The `caller` value from [Step 3](#step-3) is the authoritative answer.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$DEPLOYER" ] && read -rp "Deployer UPN or principal object ID: " DEPLOYER

az ad sp show --id "$DEPLOYER" --query "{displayName:displayName, id:id, appId:appId}" --output json 2>/dev/null \
  || az ad user show --id "$DEPLOYER" --query "{displayName:displayName, id:id, upn:userPrincipalName}" --output json 2>/dev/null \
  || echo "Could not resolve $DEPLOYER as a user or service principal — verify the value."
```

2. Grant `Network Contributor` permissions at the resource group scope. This covers VNet, subnet, public IP, and the Azure Bastion host.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

> [!NOTE]
> Assigning roles requires `User Access Administrator` or `Owner` permissions on the target scope. Use the narrowest scope that satisfies the deployment, usually the resource group containing the VNet and Azure Bastion resource.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$DEPLOYER" ] && read -rp "Deployer principal object ID: " DEPLOYER

az role assignment create \
  --assignee-object-id "$DEPLOYER" \
  --assignee-principal-type ServicePrincipal \
  --role "Network Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG"
```

> [!NOTE]
> Change `--assignee-principal-type` to `User` when granting access to a user account or `Group` when granting access to a security group. The flag is required for non-Microsoft Graph-resolvable IDs and avoids a propagation race for newly created service principals.

If the public IP or VNet lives in a different resource group than the Azure Bastion host, repeat this for the other resource group as well, or scope a single assignment at the subscription level.

3. Role assignments can take up to five minutes to propagate. Wait and then re-run [Step 4](#step-4). After that, the new role should appear in the principal's assignments. 

Then retry the Azure Bastion deployment from the original tool (the Azure portal, Azure CLI, ARM, Azure Bicep, or Terraform).

Re-run [Step 1](#step-1) and [Step 3](#step-3) after the retry to confirm `provisioningState: "Succeeded"` and no new `AuthorizationFailed` event.

If the retry still fails with `AuthorizationFailed` but for a different action than before, the deployment needs another permission. Assign the role at a broader scope (subscription) or add `User Access Administrator` if the deployment also creates role assignments.

## References

- [About Azure Bastion configuration settings (subnet, SKU, zones)](/azure/bastion/configuration-settings)
- [Quickstart: Deploy Azure Bastion using default settings](/azure/bastion/quickstart-host-portal)
- [Reliability in Azure Bastion](/azure/reliability/reliability-bastion)
- [Azure built-in roles — Network Contributor](/azure/role-based-access-control/built-in-roles#network-contributor)
- [Resolve errors for SKU not available](/azure/azure-resource-manager/templates/error-sku-not-available)
