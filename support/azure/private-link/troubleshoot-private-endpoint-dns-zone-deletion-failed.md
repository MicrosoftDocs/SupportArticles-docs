---
title: Troubleshoot private endpoint or Private DNS zone deletion that fails or is stuck in Azure Private Link
description: Diagnose and fix Azure private endpoint and Private DNS zone deletion failures caused by locks or stale virtual network links.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - private-endpoint-deletion-failed
  - private-dns-zone-deletion-failed
  - resource-deletion-failed
  - stuck-deletion
  - resource-lock-blocking-delete
  - stale-vnet-link
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Authorization/locks/read
  - Microsoft.Authorization/locks/delete
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateEndpoints/delete
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/delete
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/delete
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - RESOURCE_TYPE  # privateEndpoint | privateDnsZone
---

# Troubleshoot private endpoint or Private DNS zone deletion that fails or is stuck in Azure Private Link

## Summary

This article helps you troubleshoot and resolve Azure private endpoint and Private DNS zone deletion failures.

The Delete process of a private endpoint or Private DNS zone returns `ResourceDeletionFailed`, stops responding in a long-running state, or appears to succeed although the resource remains visible. The  most common root causes are: 

- A resource or management lock at the resource, resource-group, or subscription scope (often recreated mid-delete by `Terraform/Bicep/Policy automation`).
- A stale Private DNS zone virtual network (VNet) link that references a VNet that no longer exists. This condition includes *ghost* links that the standard `az network private-dns link vnet list` command doesn't surface. 

## Symptoms

You might encounter one or more of the following symptoms:

- A delete operation of a private endpoint or a Private DNS zone returns `ResourceDeletionFailed`, `ScopeLocked`, `BadRequest`, `DependentResource*`, or `ResourceGroupBeingDeleted` values.
- The Activity Log shows the delete operation as `Failed` and a reason description such as, "The scope ... cannot perform delete operation because following scope(s) are locked" or "Linked virtual network is not found".
- The [Azure portal](https://portal.azure.com) **Delete** action finishes, but the resource still appears in the resource list or in `az resource list` output.
- `az network private-endpoint delete` or `az network private-dns zone delete` stops responding for more than a few minutes, and eventually fails.
- An automation pipeline (such as Terraform, Bicep, or Azure Policy `DeployIfNotExists`) re-creates a lock that you just removed.
- A Private DNS zone delete operation fails and returns `InUseLinkedDnsZone` or a `virtualNetworkLinks` reference error message even after VNet links appear to be removed from the Azure portal.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required:** `Network Contributor` role on the private endpoint, target resource, and Private DNS zone, `User Access Administrator` or `Owner` role to remove resource locks, and the ability to read the subscription and resource group scopes
- **Tools:** Azure CLI 2.50 or later, or an AI agent with Azure MCP access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID hosting the stuck resource | `8aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e` |
| `{RESOURCE_GROUP}` | Resource group containing the stuck resource | `myResourceGroup` |
| `{RESOURCE_NAME}` | Name of the stuck private endpoint or Private DNS zone | `myPrivateEndpoint` / `privatelink.blob.core.windows.net` |
| `{RESOURCE_TYPE}` | Either `privateEndpoint` or `privateDnsZone` — determines which diagnostic branches apply | `privateEndpoint` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Rerun the delete operation with `--verbose` so that you capture the exact Azure Resource Manager (ARM) error code, message, and `x-ms-correlation-request-id`. The error text is the strongest single data point for routing.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Resource Name (PE or DNS zone): " RESOURCE_NAME
[ -z "$RESOURCE_TYPE" ] && read -rp "Resource Type (privateEndpoint | privateDnsZone): " RESOURCE_TYPE

if [ "$RESOURCE_TYPE" = "privateEndpoint" ]; then
  az network private-endpoint delete \
    --name "$RESOURCE_NAME" \
    --resource-group "$RG" \
    --subscription "$SUBSCRIPTION" \
    --verbose 2>&1 | tee /tmp/pe-delete.log
elif [ "$RESOURCE_TYPE" = "privateDnsZone" ]; then
  az network private-dns zone delete \
    --name "$RESOURCE_NAME" \
    --resource-group "$RG" \
    --subscription "$SUBSCRIPTION" \
    --yes \
    --verbose 2>&1 | tee /tmp/zone-delete.log
else
  echo "RESOURCE_TYPE must be 'privateEndpoint' or 'privateDnsZone'."
fi
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Delete finishes without errors, and the resource disappears from `az resource list`. | Resource is gone. | Done. No further action required. |
| Error contains `ScopeLocked`, `cannot perform delete operation because following scope(s) are locked`, or `MissingSubscriptionRegistration` and a `lock id`. | A resource or management lock is blocking the delete operation. | Perform [Step 2](#step-2). |
| Error contains `InUseLinkedDnsZone`, `linked virtual network is not found`, `LinkedVnetNotFound`, or references `virtualNetworkLinks`. | A VNet link on the zone is stale or blocking the delete operation. | Perform [Step 3](#step-3). |
| Error contains `CannotDeleteResource` and cites a nested resource ID ending in `/virtualNetworkLinks/<name>` | The zone still has a `virtualNetworkLinks` child (often a stale or ghost link), and current ARM versions return this code instead of the legacy `InUseLinkedDnsZone`. Record the `<name>` from the error text for future steps. | Perform [Step 3](#step-3). |
| Delete operation returns `Accepted` or `200 OK`, but the resource still appears in `az resource list` after five minutes. | Provisioning state is stale on ARM, or one of the conditions cited in this table exists, but ARM didn't expose the error in this operation. | Perform [Step 2](#step-2). |
| Any other error. | Capture the error code and `x-ms-correlation-request-id`, and then proceed through [Step 2](#step-2) and [Step 3](#step-3), in that order. | Perform [Step 2](#step-2). |

Record the `x-ms-correlation-request-id` from the verbose log. You need the correlation ID if you open a support case.

### Step 2

Check whether a `CanNotDelete` or `ReadOnly` lock exists at the resource, resource-group, or subscription scope. A lock at any of these three scopes blocks every delete operation underneath it.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Resource Name (PE or DNS zone): " RESOURCE_NAME
[ -z "$RESOURCE_TYPE" ] && read -rp "Resource Type (privateEndpoint | privateDnsZone): " RESOURCE_TYPE

if [ "$RESOURCE_TYPE" = "privateEndpoint" ]; then
  RES_TYPE="Microsoft.Network/privateEndpoints"
else
  RES_TYPE="Microsoft.Network/privateDnsZones"
fi

echo "── Subscription-scope locks ──"
az lock list \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(id,'/subscriptions/$SUBSCRIPTION/providers/Microsoft.Authorization/locks/')].{name:name, level:level, notes:notes, id:id}" \
  --output table

echo "── Resource-group-scope locks ──"
az lock list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table

echo "── Resource-scope locks ──"
az lock list \
  --resource "$RESOURCE_NAME" \
  --resource-type "$RES_TYPE" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| One or more locks that are listed at any scope and show `level: CanNotDelete` or `level: ReadOnly`. | A lock is blocking the delete operation. | Perform [Resolution A](#resolution-a). |
| All three scopes return empty values (no rows). | No lock is active. Rule out the next causes. | Perform [Step 3](#step-3). |
| `AuthorizationFailed` on `az lock list`. | You don't have `Microsoft.Authorization/locks/read` permissions at that scope. Ask someone who has the Owner role to run this step or grant `User Access Administrator`. | Rerun after permissions are granted. |

> [!NOTE]
> Watch for automation-re-created locks. If you remove a lock, and the article's later steps still report that a lock exists, a `Terraform/Bicep/Azure Policy` `DeployIfNotExists` is re-creating it. [Resolution A](#resolution-a) discusses how to pause the automation.

### Step 3

When you delete a Private DNS zone, this step lists every `virtualNetworkLinks` child on the zone, and flags any link whose `virtualNetwork.id` no longer resolves to an existing VNet. A stale link blocks zone deletion even though the link looks valid in the portal.

> [!NOTE]
> Skip this step if `RESOURCE_TYPE` is `privateEndpoint`. VNet links live on zones, not on endpoints. If [Step 2](#step-2) found no lock, file an Azure support request by including the correlation ID from [Step 1](#step-1).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Private DNS Zone Name (e.g. privatelink.blob.core.windows.net): " RESOURCE_NAME

# 1. List every VNet link on the zone.
echo "── VNet links on zone ──"
az network private-dns link vnet list \
  --zone-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, vnetId:virtualNetwork.id, registrationEnabled:registrationEnabled, provisioningState:provisioningState, linkState:virtualNetworkLinkState}" \
  --output table

# 2. For each link, attempt to resolve the referenced VNet. Any link whose VNet
#    returns 'NotFound' is stale and is the root cause.
echo "── Stale-link probe (NotFound = stale) ──"
for vid in $(az network private-dns link vnet list \
              --zone-name "$RESOURCE_NAME" \
              --resource-group "$RG" \
              --subscription "$SUBSCRIPTION" \
              --query "[].virtualNetwork.id" --output tsv); do
  state=$(az resource show --ids "$vid" --query "id" --output tsv 2>/dev/null || echo "NotFound")
  printf "%-110s  %s\n" "$vid" "$state"
done

# 3. Ghost-link fallback. The `link vnet list` API does NOT surface a link
#    whose target VNet was deleted or that was created against a non-existent
#    VNet (ARM persists the link record but it is invisible to the name-based
#    list API). The only signal of a ghost link is the Step 1 zone-delete
#    error message itself. Cross-check: if Step 1 named a link in its
#    `CannotDeleteResource` error that the list above did NOT print, that link
#    is a ghost — capture its name from the Step 1 error text and continue.
echo "── Ghost-link cross-check ──"
echo "From Step 1, the zone-delete error may have named a nested resource of the form"
echo "  Microsoft.Network/privateDnsZones/$RESOURCE_NAME/virtualNetworkLinks/<link-name>."
echo "If <link-name> is NOT in the list above, it is a ghost link — record the name and"
echo "use Resolution B against it."
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Every linked VNet ID resolves (the second block reports the VNet's resource ID for every link). | No stale links on this zone. | If the delete operation still fails after you run the preceding steps, file an Azure support request by including the correlation ID from [Step 1](#step-1). |
| One or more linked VNet IDs report `NotFound` in the second block, or any link has `provisioningState: Failed` or `virtualNetworkLinkState: Disconnected` values.| A stale or failed VNet link is blocking zone deletion. | Perform [Resolution B](#resolution-b). |
| The first block returned no rows or didn't list the link name that [Step 1](#step-1)'s `CannotDeleteResource` error called out, but [Step 1](#step-1) named `virtualNetworkLinks/<link-name>`. | A ghost link exists in ARM but is invisible to the name-based list API. Use `<link-name>` from the [Step 1](#step-1) error text. | Perform [Resolution B](#resolution-b) against the named link. |
| `AuthorizationFailed` listing links. | You need `Network Contributor` permissions on the zone. | Rerun after permissions are granted. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Root cause | Next actions |
|---|---|---|
| [Step 2](#step-2) finds a `CanNotDelete` or `ReadOnly` lock at resource, resource group, or subscription scope. | A resource or management lock. | Perform [Resolution A](#resolution-a). |
| [Step 3](#step-3) finds a `virtualNetworkLinks` child whose `virtualNetwork.id` returns `NotFound`, has `provisioningState: Failed` or `virtualNetworkLinkState: Disconnected` values, or is named only in the [Step 1](#step-1) `CannotDeleteResource` error text (ghost link). | There's a stale or ghost Private DNS zone VNet link. | Perform [Resolution B](#resolution-b). |
| All steps are performed but the delete operation still fails. | None of the two known causes are at fault. | File an Azure support request with the correlation ID from [Step 1](#step-1). |

## Resolution A

A `CanNotDelete` or `ReadOnly` lock at the resource, resource group, or subscription scope blocks the delete operation. A common variant is when Terraform, Bicep, or Azure Policy `DeployIfNotExists` re-creates the lock mid-delete. The lock comes back as soon as you remove it.

Run the following commands in Azure CLI (when applicable).

1. Confirm the `lock id`, level, and scope that you intend to remove. Copy the `lock id` value from [Step 2](#step-2)'s output:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
read -rp "Full lock id (from Step 2): " LOCK_ID

az lock show --ids "$LOCK_ID" --output json
```

Record the lock's `name`, `level`, `notes`, and the scope (`subscription`, `resourceGroup`, or `resource id`) that's embedded in the `lock id`. If `notes` reference a Continuous Integration (CI) and Continuous Deployment (CD) pipeline, Infrastructure-as-Code (IaC) stack, or Azure Policy assignment, that automation re-creates the lock unless you pause it first.

2. Pause any automation that re-creates the lock. If you don't pause it, the lock returns within minutes, and the delete operation fails again.

Common pauses include:

- Terraform or Bicep stack. Comment out the `azurerm_management_lock` or `Microsoft.Authorization/locks` resource, or set the pipeline to skip the next apply.
- Azure Policy `DeployIfNotExists` value for locks. Create a temporary policy exemption at the resource or resource group scope.

The exemption or pause must be in place before you perform the next step, or the lock returns within minutes.

3. Remove the lock at the scope that's reported in step 1.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$LOCK_ID" ] && read -rp "Full lock id (from Step 2): " LOCK_ID

az lock delete --ids "$LOCK_ID" --verbose
```

4. Rerun [Step 1](#step-1). 

The delete operation should now succeed and not return `ScopeLocked` or `cannot perform delete operation because following scope(s) are locked` errors.

If [Step 2](#step-2) still reports a lock after Step 3, the automation pause in Step 2 didn't take effect. Go back to Step 2 before you retry.

## Resolution B

A `virtualNetworkLinks` child on the Private DNS zone references a VNet that you removed. Therefore, the link is in a `Failed` or `Disconnected` provisioning state. ARM blocks zone deletion until every child link is in a deletable state. To fix the problem, update the stale link (to forces ARM to re-evaluate its state), delete it, and then delete the zone.

Run the following commands in Azure CLI (if applicable):

1. Verify which links are stale. Copy the stale link `name` values from [Step 3](#step-3)'s output (those whose VNet probe returned `NotFound`, or whose `provisioningState` is `Failed`):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Private DNS Zone Name: " RESOURCE_NAME
read -rp "Stale link name (from Step 3): " STALE_LINK_NAME

az network private-dns link vnet show \
  --zone-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$STALE_LINK_NAME" \
  --output json
```

1. Update and delete the stale link. The patch operation forces ARM to re-evaluate the link's `provisioningState`. In many stale-link cases, this action alone enables the subsequent delete operation to succeed.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Private DNS Zone Name: " RESOURCE_NAME
[ -z "$STALE_LINK_NAME" ] && read -rp "Stale link name: " STALE_LINK_NAME

# Build the link's full ARM resource ID. The name-based
# `az network private-dns link vnet update|delete` commands fail with NotFound
# against ghost links (links whose target VNet was deleted and the link itself
# is no longer surfaced by the name-based API), so this resolution uses the
# generic `az resource` commands against the full ID — that form works on both
# healthy and ghost links.
LINK_ID="/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/privateDnsZones/$RESOURCE_NAME/virtualNetworkLinks/$STALE_LINK_NAME"

# 1. Resync the stale link's ARM state with an empty tag update.
az resource update \
  --ids "$LINK_ID" \
  --set tags.resync=$(date -u +%Y%m%dT%H%M%SZ) \
  --verbose

# 2. Delete the stale link.
az resource delete \
  --ids "$LINK_ID" \
  --verbose
```

Repeat steps 1-2 for every stale link that's reported by [Step 3](#step-3).

3. Delete the zone.

> [!IMPORTANT]
> This action is irreversible. It deletes the Private DNS zone and every remaining record in it. These commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Private DNS Zone Name: " RESOURCE_NAME

az network private-dns zone delete \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --yes \
  --verbose
```

4. Rerun [Step 3](#step-3). 

The zone should return `ResourceNotFound`, and `az network private-dns zone list -g $RG` should no longer include the zone name.

## References

- [What is Azure Private Link?](/azure/private-link/private-link-overview)
- [Manage Azure resource locks](/azure/azure-resource-manager/management/lock-resources)
- [What is a Private DNS zone virtual network link?](/azure/dns/private-dns-virtual-network-links)
