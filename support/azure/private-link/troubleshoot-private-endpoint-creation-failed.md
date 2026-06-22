---
title: Troubleshoot private endpoint creation that fails or stalls in Azure Private Link
description: Follow step-by-step diagnostics to identify and resolve Azure private endpoint create or deploy failures caused by subnet delegation conflicts, conflicting endpoints, unregistered resource providers, and service limits."
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - private-endpoint-creation-failed
  - private-endpoint-deployment-failed
  - private-endpoint-already-exists
  - subnet-rejected
  - subnet-delegation-conflict
  - provisioning-state-failed
  - provider-not-registered
  - region-not-available
  - private-endpoint-quota-exceeded
  - service-limit-reached
ai.hint.scope: subscription-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateEndpoints/write
  - Microsoft.Network/privateEndpoints/delete
  - Microsoft.Network/virtualNetworks/subnets/read
  - Microsoft.Network/virtualNetworks/subnets/write
  - Microsoft.Network/privateLinkServices/read
  - Microsoft.Network/register/action
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - VNET_NAME
  - SUBNET_NAME
  - TARGET_RESOURCE_ID
---

# Troubleshoot private endpoint creation that fails or stalls in Azure Private Link

## Summary

This article helps you diagnose and resolve problems that occur when the create process for an Azure private endpoint fails, conflicts with an existing endpoint, or stalls in a non-`Succeeded` `provisioningState`. 

These problems have four root-cause categories: 

- The target subnet is delegated to another Azure service (for example, `Microsoft.Web/serverFarms` or `Microsoft.Sql/managedInstances`), and a delegated subnet can't host a private endpoint network adapter (also known as a network interface card or NIC).
- A conflicting or leftover private endpoint object from an earlier delete or a rapid re-create race is exposed as `PrivateEndpointAlreadyExists`. 
- The `Microsoft.Network` resource provider isn't registered on the subscription, or the chosen region isn't enabled for private endpoints.
- A service limit or quota is reached, such as the per-VNet or per-subscription private endpoint cap or the private-endpoint-to-Private-Link-Service association limit. 

## Symptoms

You experience one or more of the following symptoms:

- The `az network private-endpoint create` call fails, or the deployed endpoint shows a `"provisioningState": "Failed"` state instead of `"Succeeded"`.
- The create call returns a `PrivateEndpointAlreadyExists` value or reports that an endpoint or its network adapter that has the same name already exists.
- The portal or command-line interface (CLI) tool rejects the chosen subnet and returns a message that references a delegation, for example, `PrivateEndpointCreationNotAllowedAsSubnetIsDelegated` ("... cannot be created as subnet ... is delegated").
- The create call fails and returns `MissingSubscriptionRegistration`, `SubscriptionNotRegistered`, `NoRegisteredProviderFound`, or `LocationNotAvailableForResourceType` states.
- The create call fails and returns a message that references a `limit`, `quota`, `cap`, `exceeded`, or `maximum number of private endpoints`.
- A newly created private endpoint never leaves the `Updating` or `Provisioning` states, and eventually fails.
- A `terraform apply` or Bicep file deployment that deletes and immediately re-creates a private endpoint that has the same name fails intermittently.

## Prerequisites

To troubleshoot effectively, you must have the following prerequisite items:

- **Permissions required**: 
    - `Network Contributor` role on the resource group that hosts the private endpoint and the target subnet's virtual network
    -  `Microsoft.Network/register/action` permissions (for example, using `Contributor` permissions at a subscription scope) to register the resource provider
    - The ability to read the target resource that the endpoint connects to.
- **Tools**: Azure CLI 2.50 or later, or an AI agent with Azure MCP or Azure CLI access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID where the private endpoint is created | `897f8215-ca14-442a-9a1b-408d8fef053a` |
| `{RESOURCE_GROUP}` | Resource group for the private endpoint | `myResourceGroup` |
| `{PE_NAME}` | Name of the private endpoint you're trying to create | `myPrivateEndpoint` |
| `{VNET_NAME}` | Virtual network that contains the target subnet | `myVNet` |
| `{SUBNET_NAME}` | Subnet that the private endpoint network adapter is placed in | `pe-subnet` |
| `{TARGET_RESOURCE_ID}` | Resource ID of the resource the endpoint connects to (like Azure Storage account, Azure Key Vault, SQL server, or Azure Private Link service) | `/subscriptions/.../providers/Microsoft.Storage/storageAccounts/mystorage` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

Follow these steps to identify the root cause of the private endpoint creation failure. 

> [!NOTE]
> These steps are strictly for discovery ("read-only"), except [Step 1](#step-1). They don't make changes to your environment.

### Step 1

Rerun the create operation by using `--verbose` so you can capture the exact Azure Resource Manager (ARM) error code, message, and `x-ms-correlation-request-id`. The error code and message often directly indicate the root cause. The correlation ID is essential for Azure support if you need to open a case.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:            " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:             " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name:      " PE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:                  " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:                " SUBNET_NAME
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:         " TARGET_RESOURCE_ID
[ -z "$GROUP_ID" ] && read -rp "Group ID (e.g. blob, vault, sqlServer): " GROUP_ID
[ -z "$CONN_NAME" ] && read -rp "Connection Name:            " CONN_NAME

az network private-endpoint create \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME" \
  --private-connection-resource-id "$TARGET_RESOURCE_ID" \
  --group-id "$GROUP_ID" \
  --connection-name "$CONN_NAME" \
  --verbose 2>&1 | tee /tmp/pe-create.log
```

Record the `x-ms-correlation-request-id`. This header is emitted at the *debug* level, not by `--verbose`. You can also add `--debug` to the command earlier (or replace `--verbose` with `--debug`) and look for the `x-ms-correlation-request-id` line in the response headers. You need it if you open a support case.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The create operation completes and the `provisioningState` value is `Succeeded`. | The endpoint was created. | No further action is needed. |
| The error code is `PrivateEndpointCreationNotAllowedAsSubnetIsDelegated`. The message reads `Private endpoint ... cannot be created as subnet ... is delegated`. | The target subnet is delegated to another service and can't host a private endpoint network adapter. | Perform [Step 2](#step-2). |
| The error is `PrivateEndpointAlreadyExists` or references an endpoint or network adapter that has the same name that already exists. | A conflicting or leftover endpoint exists. | Perform [Step 3](#step-3). |
| The error references `MissingSubscriptionRegistration`, `SubscriptionNotRegistered`, `NoRegisteredProviderFound`, or `LocationNotAvailableForResourceType`. | The provider isn't registered or the region isn't available. | Perform [Step 4](#step-4). |
| The error references `limit`, `quota`, `cap`, `exceeded`, or `maximum number of private endpoints`. | A service limit was reached. | Perform [Step 5](#step-5). |
| Any other error, or the create operation returns `Accepted` but the endpoint later shows `provisioningState: Failed`. | The cause isn't obvious from the error. Perform every check in order. | Perform [Step 2](#step-2). |

### Step 2

Check whether the target subnet is delegated to another Azure service. A subnet that carries a service delegation (for example to `Microsoft.Web/serverFarms`, `Microsoft.Sql/managedInstances`, or `Microsoft.ContainerInstance/containerGroups`) is reserved for that service and can't host a private endpoint network adapter. The create operation fails. A usable private endpoint subnet has an empty `delegations` array.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network vnet subnet show \
  --name "$SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{subnet:name, delegations:delegations[].serviceName}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `delegations` is a nonempty array (for example `["Microsoft.Web/serverFarms"]`). | The subnet is delegated to another service and can't host a private endpoint network adapter. | Perform [Resolution A](#resolution-a). |
| `delegations` is `[]` (empty). | Subnet delegation isn't the cause. | Perform [Step 3](#step-3). |
| `ResourceNotFound` is the value for the subnet or virtual network (VNet). | The subnet or VNet name is wrong. The create operation rejected the subnet because it doesn't exist. | Verify the `VNET_NAME` and `SUBNET_NAME`, and then rerun [Step 1](#step-1). |

### Step 3

Check whether a private endpoint that has the same name already exists in the resource group, and what `provisioningState` it's in. A leftover endpoint from an earlier delete, or one that's created by a concurrent or rapid-re-create operation, produces a `PrivateEndpointAlreadyExists` value and blocks a new endpoint that has the same name.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

# 1. Is there already an endpoint with this exact name in the resource group?
echo "── Endpoint with the target name ──"
az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, subnet:subnet.id, nic:networkInterfaces[0].id}" \
  --output json 2>/dev/null || echo "No endpoint named '$PE_NAME' in resource group '$RG'."

# 2. List every endpoint in the resource group so you can spot a name collision
#    or a stuck endpoint left behind by a prior operation.
echo "── All endpoints in the resource group ──"
az network private-endpoint list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, provisioningState:provisioningState, subnet:subnet.id}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| An endpoint that's named exactly `$PE_NAME` already exists, in any `provisioningState` (including `Deleting`, `Failed`, `Updating`, or `Succeeded`). | A conflicting or leftover endpoint is causing `PrivateEndpointAlreadyExists`. | Perform [Resolution B](#resolution-b). |
| No endpoint that's named `$PE_NAME` exists, and [Step 2](#step-2) shows that the subnet has an empty `delegations` array (not delegated). | Name collision is ruled out. | Perform [Step 4](#step-4). |
| `No endpoint named ...` appears but your create error was `PrivateEndpointAlreadyExists`. | A delete is still in flight at the control plane (the object is gone from list but ARM still tracks it). | Perform [Resolution B](#resolution-b). |

### Step 4

Check whether the `Microsoft.Network` resource provider is `Registered` on the subscription and whether the target region is listed for the `privateEndpoints` resource type. An unregistered provider or an unavailable region causes the create operation to fail before any subnet or quota check.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$LOCATION" ] && read -rp "Target Region display name (e.g. East US): " LOCATION

# 1. Is the Microsoft.Network provider registered?
echo "── Microsoft.Network registration state ──"
az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "registrationState" \
  --output tsv

# 2. Is the target region available for the privateEndpoints resource type?
echo "── Regions where privateEndpoints is available ──"
az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "resourceTypes[?resourceType=='privateEndpoints'].locations | [0]" \
  --output json

echo "── Is '$LOCATION' in that list? ──"
az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "resourceTypes[?resourceType=='privateEndpoints'].locations | [0] | contains(@, '$LOCATION')" \
  --output tsv
```

The `locations` array returns region display names (for example `East US`, `West US 2`), *not* short codes (`eastus`). Because the `contains` check compares against that array, enter the region in display-name form at the prompt (for example, a short code such as `eastus` returns a `false` value even for a fully available region). If you have only the short code, match it to the display name that's listed in the check that was most recently performed before you conclude that the region is unavailable.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `registrationState` has a value of `NotRegistered` or `Registering`. | The `Microsoft.Network` provider isn't fully registered. | Perform [Resolution C](#resolution-c). |
| `registrationState` has a value of  `Registered`, but the target region isn't in the `privateEndpoints` `locations` array. | The region isn't enabled for private endpoints on this subscription.| Perform [Resolution C](#resolution-c). |
| `registrationState` has a value of `Registered` and the target region is in the `locations` array. | The provider and region are fine. | Perform [Step 5](#step-5) |

### Step 5

Check whether you are at or near a documented service limit (the number of private endpoints in the VNet and subscription) and the number of endpoint connections on that service when you connect to a Private Link service. If you reach either ceiling, this condition causes the create operation to fail and generate a limit or quota error.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID: " TARGET_RESOURCE_ID

# 1. Private endpoints in this subscription (subscription-scope cap).
echo "── Private endpoints in subscription ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length(@)" \
  --output tsv

# 2. Private endpoints whose network adapter is in this VNet (per-VNet cap).
echo "── Private endpoints in VNet '$VNET_NAME' ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length([?contains(subnet.id, '/virtualNetworks/$VNET_NAME/')])" \
  --output tsv

# 3. If the target is a Private Link Service, count its endpoint connections
#    (PE-to-PLS association cap). Skipped automatically for non-PLS targets.
case "$TARGET_RESOURCE_ID" in
  */privateLinkServices/*)
    echo "── Endpoint connections on the target Private Link Service ──"
    az network private-link-service show \
      --ids "$TARGET_RESOURCE_ID" \
      --query "length(privateEndpointConnections)" \
      --output tsv
    ;;
  *)
    echo "Target is not a Private Link Service; PLS association cap does not apply."
    ;;
esac
```

### Interpret the results

Compare each count to the documented ceiling. The current ceilings are:
 
- A maximum of 65,536 private endpoints per region, per subscription (the regional quota shown as `Private Endpoints` by `az network list-usages --location <region>`).
- A default of 1,000 private endpoints per virtual network (increased by enabling the High-Scale Private Endpoints feature. For more information, see [Resolution D](#resolution-d)). 
- A maximum of 1,000 private endpoint connections per Private Link service. A count at or within a few units of the relevant ceiling, combined with a `limit`/`quota` error in Step 1, confirms root cause **i4**.

| Observation | Meaning | Next steps |
|---|---|---|
| Subscription or VNet endpoint count is at or near the documented per-subscription or per-VNet ceiling. | The per-subscription or per-VNet private endpoint cap is reached. | Perform [Resolution D](#resolution-d). |
| The Private Link service endpoint-connection count is at or near the documented association ceiling. | The private endpoint-to-Private Link service association cap is reached. | Perform [Resolution D](#resolution-d). |
| Every count is below its documented ceiling. | Service limit isn't the problem. | → File an Azure support request (include the `x-ms-correlation-request-id` from [Step 1](#step-1)). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Root cause | Next actions |
|---|---|---|
| [Step 2 ](#step-2)shows that the subnet has a nonempty `delegations` array .| The subnet is delegated and can't host a private endpoint network adapter. | Perform [Resolution A](#resolution-a). |
| [Step 3](#step-3) finds an existing endpoint that has the same name, or a delete is still in flight, behind `PrivateEndpointAlreadyExists`. | A conflicting or leftover endpoint exists. | Perform [Resolution B](#resolution-b). |
| [Step 4](#step-4) shows that `registrationState` is either `NotRegistered` or `Registering`, or the region is missing from the `privateEndpoints` locations. | The provider isn't registered or the region isn't available. | Perform [Resolution C](#resolution-c). |
| [Step 5](#step-5) shows an endpoint or Private Link service-association count at or near a documented limit. | The service limit or quota is reached. | Perform [Resolution D](#resolution-d). |
| All steps are without problems, but a create operation still fails. | None of the four known causes are at fault. | File an Azure support request by including the `correlation ID` from [Step 1](#step-1). |

## Resolution A

The target subnet is delegated to another Azure service (for example, `Microsoft.Web/serverFarms`, `Microsoft.Sql/managedInstances`, or `Microsoft.ContainerInstance/containerGroups`). A delegated subnet is reserved for the delegated service's resources. ARM can't place a private endpoint network adapter into it, and the create operation fails. Fix this problem by putting the private endpoint into a dedicated, nondelegated subnet. You usually can't remove an existing delegation while the delegated service has resources in the subnet. Therefore, the safest and most reliable solution is to create or select a separate nondelegated subnet.

1. Verify the delegation on the target subnet. Use the `VNET_NAME` and `SUBNET_NAME` from [Step 2](#step-2).

Run the following commands in Azure CLI:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network vnet subnet show \
  --name "$SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{subnet:name, delegations:delegations[].serviceName}" \
  --output json
```

Note the `serviceName` of the delegation (for example, `Microsoft.Web/serverFarms`). This value confirms that the subnet is reserved for another service and can't host a private endpoint.

2. Create a dedicated, nondelegated subnet for the private endpoint.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. They create a new, dedicated subnet that has no delegation for the private endpoint. Choose an `--address-prefixes` range that doesn't overlap any existing subnet in the VNet. Creating a subnet doesn't affect existing workloads.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$PE_SUBNET_NAME" ] && read -rp "New PE Subnet Name (non-delegated): " PE_SUBNET_NAME
[ -z "$PE_SUBNET_PREFIX" ] && read -rp "New PE Subnet address prefix (e.g. 10.0.4.0/24): " PE_SUBNET_PREFIX

az network vnet subnet create \
  --name "$PE_SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --address-prefixes "$PE_SUBNET_PREFIX" \
  --verbose
```

3. Verify that the new subnet has no delegation before you use it.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$PE_SUBNET_NAME" ] && read -rp "New PE Subnet Name (non-delegated): " PE_SUBNET_NAME

az network vnet subnet show \
  --name "$PE_SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{subnet:name, delegations:delegations[].serviceName}" \
  --output json
```

**Note:** `delegations` should have a value of `[]`. If you already have another nondelegated subnet in the VNet, you can skip the create operation and use that subnet's name instead.

4. Re-create the endpoint, but answer the **Subnet Name** prompt by using the nondelegated subnet from step 2 (set `SUBNET_NAME` to the new `PE_SUBNET_NAME` value, or open a fresh session so that the prompt asks again). The endpoint should now reach `provisioningState: Succeeded`.

If the create operation still fails after you move it to a nondelegated subnet, go to [Step 3](#step-3).

If you're deploying a Private Link service and not a private endpoint, and the deployment fails because you can't select the source network address translation (NAT) IP or subnet, it's likely because `privateLinkServiceNetworkPolicies` is set to `Enabled` on that NAT subnet. This network policy still blocks Private Link service creation. This policy doesn't apply to private endpoint creation. Fix it only for the Private Link service NAT subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "PLS NAT Subnet Name: " SUBNET_NAME

az network vnet subnet update \
  --name "$SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --disable-private-link-service-network-policies true \
  --verbose
```

## Resolution B

A private endpoint that has the same name already exists, or the control plane is still processing an earlier delete. A rapid delete-then-re-create operation (common in infrastructure as code (IaC) pipelines) affects the asynchronous cleanup. Therefore, the new creation triggers the `PrivateEndpointAlreadyExists` error.

1. Verify the conflicting endpoint and its `provisioningState`. Use the name from [Step 3](#step-3).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, subnet:subnet.id, connections:privateLinkServiceConnections[].{name:name, target:privateLinkServiceId, state:privateLinkServiceConnectionState.status}}" \
  --output json 2>/dev/null || echo "No endpoint object found — a delete is still in flight at the control plane. Skip B.2 and go straight to B.3 (wait)."
```

- If an endpoint object is returned and it's the wrong or leftover one, go to the next step to delete it.
- If no object is returned but [Step 1](#step-1) reported `PrivateEndpointAlreadyExists`, the deletion is still being processed. In this case, skip step 2 and go to step 3.

2. Delete the conflicting endpoint.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This operation permanently deletes the conflicting private endpoint. Before you do this step, verify that you're targeting the leftover or wrong endpoint and not one that's in active use.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint delete \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --verbose
```

3. Verify that the name is fully released.

> [!IMPORTANT]
> **Wait at least 20 minutes before re-creating.** Private endpoint deletion is asynchronous at the control plane. The network adapter, DNS records, and the connection on the target resource are cleaned up after the `delete` call returns. Re-creating immediately reraces that cleanup and reproduces `PrivateEndpointAlreadyExists`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "name" \
  --output tsv 2>/dev/null && echo "Still present — keep waiting." || echo "Name released — safe to recreate."
```

Repeat until the command displays `Name released — safe to recreate.`

4. Rerun [Step 1](#step-1) to re-create the endpoint. It should now reach `provisioningState: Succeeded` without any `PrivateEndpointAlreadyExists` error.

If the conflict returns immediately on every retry, an automation pipeline (such as Terraform, Bicep, or a deployment loop) is re-creating the old endpoint. Pause that automation before recreating.

## Resolution C

The `Microsoft.Network` resource provider isn't registered on the subscription, or the target region isn't enabled for the `privateEndpoints` resource type. Either condition causes the create operation to fail before subnet or quota checks run.

1. Verify the registration state and region availability. Use the region from [Step 4](#step-4).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$LOCATION" ] && read -rp "Target Region display name (e.g. East US): " LOCATION

az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "{registrationState:registrationState, privateEndpointRegions:resourceTypes[?resourceType=='privateEndpoints'].locations | [0]}" \
  --output json
```

2. Register the provider.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Registering a resource provider is a subscription-level change. This change is safe and important, but it requires `Microsoft.Network/register/action` permissions (for example, `Contributor` permissions at the subscription scope level).

 The `--wait` flag blocks other operations until the registration finishes.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az provider register \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --wait \
  --verbose
```

3. Rerun [Step 4](#step-4). `registrationState` should read `Registered`.

- If registration is now `Registered`, and your target region appears in the `privateEndpoints` locations array, rerun [Step 1](#step-1) to re-create the endpoint.
- If registration is `Registered` but your target region is still not in the locations array, the region isn't enabled for private endpoints on this subscription. Select a region that's listed, or open an Azure support request to request region enablement (quote the `x-ms-correlation-request-id` from [Step 1](#step-1)).

4. After a successful create operation, verify this value: `provisioningState: Succeeded`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "provisioningState" \
  --output tsv
```

## Resolution D

You reach a documented service limit: Either the per-subscription or per-VNet private endpoint cap or the private-endpoint-to-Private-Link-service association cap. The create operation fails and generates a `limit`, `quota`, or `exceeded` error and the matching count from [Step 5](#step-5) sits at or near its ceiling.

1. Verify which ceiling you reach. Re-read the counts from [Step 5](#step-5) against the current documented limits.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

echo "── Endpoints in subscription ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length(@)" \
  --output tsv

echo "── Endpoints in VNet '$VNET_NAME' ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length([?contains(subnet.id, '/virtualNetworks/$VNET_NAME/')])" \
  --output tsv
```

The ceilings to compare against are:

 - 65,536 private endpoints per region per subscription
 - A default 1,000 connections per virtual network
 - 1,000 connections per Private Link service

 See [Step 5](#step-5) for the full list.

4. If you reach the per-VNet private endpoint cap, and your scenario qualifies, enable High-Scale Private Endpoints to raise the per-VNet ceiling up to the regional maximum (65,536). This feature is gated by the subscription feature flag, `Microsoft.Network/EnableMaxPrivateEndpointsVia64kPath`.

Register the feature, and reregister the provider so that the changes take effect. Feature registration can take several minutes to move from `Registering` to `Registered`.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az feature register \
  --namespace Microsoft.Network \
  --name EnableMaxPrivateEndpointsVia64kPath \
  --subscription "$SUBSCRIPTION" \
  --verbose

# Re-register the provider so the feature flag propagates.
az provider register \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --wait \
  --verbose
```

3. If High-Scale Private Endpoints doesn't apply (for example, you reach the per-subscription or the private endpoint-to-Private Link service association cap), submit a quota or limit-increase support request. 

The [Azure portal](https://portal.azure.com) is the supported route because no Private Link quota type exists in the `az support` CLI extension, and that extension isn't installed by default. 

a. In the Azure portal, go to **Help + support** > **Create a support request**.
b. Specify the issue type as **Service and subscription limits (quotas)**. 
c. Select the **Private Link** or private endpoint quota, and include the `x-ms-correlation-request-id` from [Step 1](#step-1) plus the counts from step 1.

4. After the limit is raised (feature registered, or the support request is fulfilled), rerun [Step 5](#step-5) to verify headroom. Then, rerun [Step 1](#step-1) to re-create the endpoint. It should reach `provisioningState: Succeeded`.

## References

- `[Manage private endpoints in Azure Private Link](/azure/private-link/manage-private-endpoint)`
- `[Disable network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy)`
- [Azure resource providers and types](/azure/azure-resource-manager/management/resource-providers-and-types)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits)
- [What is Azure Private Link?](/azure/private-link/private-link-overview)
