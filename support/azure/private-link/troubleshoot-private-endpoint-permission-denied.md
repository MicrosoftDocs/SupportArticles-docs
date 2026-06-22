---
title: Troubleshoot AuthorizationFailed errors for Azure private endpoints
description: Fix AuthorizationFailed errors when you create or approve an Azure private endpoint. Identify missing RBAC permissions, and apply the least-privilege role to resolve it.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.date: 6/12/2026
ms.custom: sap:Private Endpoints
ai.hint.symptom-tags:
  - authorization-failed
  - access-denied
  - rbac-permission-denied
  - private-endpoint-create-denied
  - subnet-join-denied
  - private-dns-zone-denied
  - private-endpoint-approval-denied
  - private-endpoint-autoapprove-denied
  - cross-tenant-private-endpoint
  - cross-tenant-approval
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Authorization/roleAssignments/read
  - Microsoft.Authorization/roleAssignments/write
  - Microsoft.Network/privateEndpoints/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - VNET_NAME
  - SUBNET_NAME
  - PRIVATE_DNS_ZONE_ID
  - TARGET_RESOURCE_ID
  - PRINCIPAL
---

# Troubleshoot AuthorizationFailed and permission errors for Azure private endpoints

## Summary

This article helps you diagnose and resolve role-based access control (RBAC) permission errors that cause `AuthorizationFailed` errors when you create a private endpoint or a private endpoint DNS zone group, or you approve a pending private endpoint connection. 

These permission errors occur when you try to create a private endpoint, create a DNS zone group, or approve a pending connection. The operation then fails with `AuthorizationFailed` or **Access Denied** errors. 

Four distinct RBAC scenarios cause these errors, and each has a different scope: 

- The requester lacks `Microsoft.Network/privateEndpoints/write` permissions at the private-endpoint resource group. 
- The requester lacks `Microsoft.Network/virtualNetworks/subnets/join/action` permissions on the target subnet. This condition is common if the virtual network (VNet) is owned by a separate network team. 
- The requester lacks Azure Private DNS Zone Contributor permissions on the Azure Private DNS zone or its resource group. Therefore, the A record or virtual network link can't be written. 
- The approver in the target tenant or subscription lacks `Microsoft.<RP>/<resource>/privateEndpointConnections/write` permissions on the target platform-as-a-service (PaaS) resource. This condition is the most common cause of the error in cross-tenant scenarios.

The exact Azure Resource Manager (ARM) error from the failed operation names the missing action, and then routes you to the best least-privilege fix.

## Symptoms

You experience one or more of the following symptoms:

- `az network private-endpoint create` fails and returns an `AuthorizationFailed` error message and a message that cites `Microsoft.Network/privateEndpoints/write`.
- The same create operation fails and returns an `AuthorizationFailed` error message and a message that cites `Microsoft.Network/virtualNetworks/subnets/join/action`, even though you can read the subnet.
- The private endpoint is created, but `az network private-endpoint dns-zone-group create` fails and returns an `AuthorizationFailed` error message that cites `Microsoft.Network/privateDnsZones/A/write` or `Microsoft.Network/privateDnsZones/virtualNetworkLinks/write`.
- A cross-tenant or cross-team request occurs. In this situation, the connection on the target storage account, Key Vault, SQL server, or other PaaS resource is in a `Pending` state, and the resource owner who tries to approve receives an `AuthorizationFailed` error message that cites `Microsoft.<RP>/.../privateEndpointConnections/write`.
- Private endpoint creation returns a `LinkedAuthorizationFailed` error message that cites a `*/PrivateEndpointConnectionsApproval/action` on the target resource, even though the requester has Network Contributor permission on the VNet.

## Prerequisites

To troubleshoot effectively, you must have the following prerequisite items:

- **Permissions required**: `Owner`, `User Access Administrator`, or any custom role that grants `Microsoft.Authorization/roleAssignments/write` at the scope that you're assigning at (the private-endpoint resource group, the VNet, the Private DNS zone, or the target PaaS resource). The diagnostic steps in this guide are read-only and require only `Microsoft.Authorization/roleAssignments/read` plus Reader permissions on the affected resources.
- **Tools**: Azure CLI 2.50 or later, or an AI agent with Azure MCP or Azure CLI access.
- **Required variables and examples of those variables, as shown in the following table**:

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Subscription that the failing operation runs in (for cross-tenant approval, this subscription is the **target**). | `00000000-0000-0000-0000-000000000000` |
| `{RESOURCE_GROUP}` | Resource group of the private endpoint, the Private DNS zone, or the target PaaS resource. | `myResourceGroup` |
| `{PE_NAME}` | Name of the private endpoint that's involved. | `myPrivateEndpoint` |
| `{VNET_NAME}` | Virtual network that contains the target subnet. | `myVNet` |
| `{SUBNET_NAME}` | Subnet that the private endpoint network adapter is placed in. | `pe-subnet` |
| `{PRIVATE_DNS_ZONE_ID}` | Resource ID of the Private DNS zone that the endpoint registers into. | `/subscriptions/.../privateDnsZones/privatelink.blob.core.windows.net` |
| `{TARGET_RESOURCE_ID}` | Resource ID of the PaaS resource that the endpoint connects to. | `/subscriptions/.../Microsoft.Storage/storageAccounts/mystorage` |
| `{PRINCIPAL}` | The user, service principal, or group whose permissions are missing (User Principal Name (UPN), app ID, or object ID). | `alice@contoso.com` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps to identify missing RBAC permissions

|Follow these steps to identify which RBAC permission is missing and the least-privilege role assignment that resolves it. Each step captures a specific piece of information that narrows down the root cause and routes you to the appropriate resolution.

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Capture the exact ARM error from the failing operation, including the specific action the principal is missing. The missing action string (`Microsoft.Network/privateEndpoints/write`, `.../subnets/join/action`, `.../privateDnsZones/...`, or `.../privateEndpointConnections/write`) is the discriminating signal that determines which of the following resolutions apply. Rerun your failing command with `--debug` to capture the full error *or* use the failed event from the activity log if you don't want to retrigger the operation.

Run the following commands in Azure CLI:

**Option 1: Rerun the failing operation with debug logging**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:           " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:            " RG

# Rerun *only the command that failed* with --debug appended. Example below
# is the private-endpoint create. For a DNS zone-group create or a connection
# approve, substitute that command. The point is to capture the full error.
#
# az network private-endpoint create ... --debug 2>&1 | tee /tmp/pe-auth.log
#
# Then extract the AuthorizationFailed payload:
grep -A 6 -i "AuthorizationFailed\|does not have authorization to perform action" /tmp/pe-auth.log
```

**Option 2: Read the failed event from the activity log (no rerun needed)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az monitor activity-log list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --status Failed \
  --offset 1h \
  --max-events 50 \
  --query "[?contains(operationName.value, 'privateEndpoint') || contains(operationName.value, 'subnets/join') || contains(operationName.value, 'privateDnsZones') || contains(operationName.value, 'privateEndpointConnections')].{time:eventTimestamp, op:operationName.localizedValue, sub:subStatus.localizedValue, caller:caller, msg:properties.statusMessage}" \
  --output json
```

The activity log records the exact `action` string the principal was missing in `properties.statusMessage`. If you don't see your failure, widen the `--offset` value (for example `--offset 24h`) or remove `--resource-group` to search at subscription scope.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The error cites `Microsoft.Network/privateEndpoints/write`. | The requester can't create the private endpoint object itself. | Perform [Step 2](#step-2) and then [Resolution A](#resolution-a). |
| The error cites `Microsoft.Network/virtualNetworks/subnets/join/action`.| The requester can't attach a network interface to the target subnet. | Perform [Step 2](#step-2) and then [Resolution B](#resolution-b). |
| `(LinkedAuthorizationFailed)` cites `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` (for example `Microsoft.Storage/storageAccounts/PrivateEndpointConnectionsApproval/action`) on the linked scope of the **target** PaaS resource (like storage account, key vault, SQL server, or Azure Cosmos DB account). | The requester has network rights, but the target's autoapprove policy requires the requester to also hold a role granting private endpoint approval on the target. | Perform [Step 3](#step-3) and then [Resolution E](#resolution-e) or use `--manual-request true` so that an approver in the target tenant handles approval separately (see [Resolution E](#resolution-e) for more details). |
| The error cites `Microsoft.Network/privateDnsZones/A/write`, `.../privateDnsZones/virtualNetworkLinks/write`, or any other `Microsoft.Network/privateDnsZones/...` action. | The requester can't write to the Private DNS zone. | Perform [Step 2](#step-2) and then [Resolution C](#resolution-c). |
| The error cites `Microsoft.Storage/storageAccounts/privateEndpointConnections/write`, `Microsoft.KeyVault/vaults/privateEndpointConnections/write`, `Microsoft.Sql/servers/privateEndpointConnections/write`, or any `Microsoft.<RP>/<resource>/privateEndpointConnections/write` value. | The approver on the target PaaS resource is missing the approve action permissions. | Perform [Step 3](#step-3) and then [Resolution D](#resolution-d). |
| The error isn't `AuthorizationFailed`. For example `PrivateEndpointAlreadyExists`, `PrivateEndpointCreationNotAllowedAsSubnetIsDelegated`, `MissingSubscriptionRegistration`, or a quota error. | The failure isn't an RBAC problem. This guidance isn't applicable to your situation. | `Use [Troubleshoot private endpoint creation that fails or stalls](/azure/private-link/troubleshoot-private-endpoint-creation-failed) instead.` |
| No failed event matches in the window. | The operation never reached ARM (this situation indicates either a network or CLI issue), or you searched the wrong scope or time window .| Widen the `--offset` value and rerun, or run the failing CLI command again with the `--debug` value. |

### Step 2

Verify which roles the failing principal already has at the scope where the missing action lives, so that the fixes in [Resolution A](#resolution-a), [B](#resolution-b), or [C](#resolution-c) grant the least-privilege role that adds the missing action and don't overwrite an existing higher-privilege role. 

Use the scope that matches the routing decision from [Step 1](#step-1): The private-endpoint resource group, the VNet (or its resource group), or the Private DNS zone (or its resource group).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:                                                  " SUBSCRIPTION
[ -z "$PRINCIPAL" ] && read -rp "Principal (UPN, app ID, or object ID):                            " PRINCIPAL
[ -z "$SCOPE" ] && read -rp "Scope to check (RG ID, VNet ID, or Private DNS zone ID):           " SCOPE

az role assignment list \
  --assignee "$PRINCIPAL" \
  --scope "$SCOPE" \
  --include-inherited \
  --include-groups \
  --subscription "$SUBSCRIPTION" \
  --query "[].{role:roleDefinitionName, scope:scope, principalType:principalType}" \
  --output table
```

Pass the **full resource ID** as `$SCOPE`. Examples include:

- Resource group: `/subscriptions/<sub>/resourceGroups/<rg>`
- VNet: `/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>`
- Private DNS zone: `/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/privateDnsZones/<zone>`
`--include-inherited` returns assignments inherited from parent scopes, and `--include-groups` includes roles granted through group membership.

### Interpret the results

| Observation | Meaning | Next step |
|---|---|---|
| No role for the principal covers the missing action from [Step 1](#step-1). For example, no `Network Contributor`, `Contributor`, or `Owner` when the missing action is `Microsoft.Network/privateEndpoints/write` or `.../subnets/join/action` and no `Private DNS Zone Contributor`, `Contributor`, or `Owner` when the missing action is `Microsoft.Network/privateDnsZones/...`. | This condition confirms an RBAC problem. | Apply [Resolution A](#resolution-a), [B](#resolution-b), or [C](#resolution-c) as per [Step 1](#step-1). |
| The principal already has `Owner` or `Contributor` roles (or the matching `*Contributor` roles) but the operation still fails with `AuthorizationFailed` for the same action. | The role assignment is at the wrong scope, or an ARM **deny assignment** is blocking the action. | Recheck the scope. Verify that `$SCOPE` exactly matches the resource the action targets (the private endpoint resource group), the VNet or subnet, or the zone. Then, get a list of deny assignments: `az rest --method get --url "https://management.azure.com$SCOPE/providers/Microsoft.Authorization/denyAssignments?api-version=2022-04-01"`. |
| [Step 1](#step-1) is routed to [Resolution D](#resolution-d) or [Resolution E](#resolution-e). This situation indicates that the missing action is on a target PaaS resource like `privateEndpointConnections/write` or `PrivateEndpointConnectionsApproval/action`. | [Step 2](#step-2) doesn't apply. RBAC scoping is on the target resource, not the requester's network resources. | Perform [Step 3](#step-3). |

### Step 3

Verify that the approver signs in to the target tenant (the tenant that owns the PaaS resource) and not the requester's tenant for cross-tenant approvals. The most common reason that an approver encounters `AuthorizationFailed` on `privateEndpointConnections/write` is that the CLI session authenticates to the wrong tenant. The role assignment is correct, but it's evaluated against the wrong identity.

Run the following commands in Azure CLI:

```azurecli-interactive
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID (the PaaS resource hosting the pending connection): " TARGET_RESOURCE_ID

# 1. Which tenant is the current CLI session signed into?
echo "── Current CLI session ──"
az account show \
  --query "{tenantId:tenantId, subscription:id, user:user.name}" \
  --output json

# 2. Which tenant owns the target subscription?
TARGET_SUB=$(echo "$TARGET_RESOURCE_ID" | awk -F'/' '{print $3}')
echo "── Tenant that owns target subscription $TARGET_SUB ──"
az account show \
  --subscription "$TARGET_SUB" \
  --query "tenantId" \
  --output tsv 2>/dev/null \
  || echo "Not signed into target subscription. Run: az login --tenant <target-tenant-id>"

# 3. List pending connections on the target resource so that you have the connection name for approval.
echo "── Pending connections on target resource ──"
az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[?properties.privateLinkServiceConnectionState.status=='Pending'].{name:name, id:id, requester:properties.privateEndpoint.id, status:properties.privateLinkServiceConnectionState.status}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The current session `tenantId` matches the target subscription's `tenantId` *and* at least one connection is `Pending`. | This tenant is the correct one. The failure is a missing approve role on the target resource. | Perform [Resolution D](#resolution-d). |
| The current session `tenantId` matches the target subscription's `tenantId` *and* the missing action from [Step 1](#step-1) is `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` (autoapprove cascade hit from the requester's own `az network private-endpoint create`, not an approver workflow). | The requester is hitting the target's autoapprove policy and needs a role on the target that grants private endpoint approval. | Perform [Resolution E](#resolution-e). |
| The current session `tenantId` doesn't match the target subscription's `tenantId`. | The CLI signs in to the requester tenant. Any approve call evaluates against the wrong identity and returns `AuthorizationFailed` regardless of RBAC. | Sign in to the target tenant as a first step: `az login --tenant <target-tenant-id>`. See [Resolution D](#resolution-d) for the full sequence. |
| `az account show --subscription "$TARGET_SUB"` errors with **subscription not found**. | Your account has no access to the target subscription. You have to be added as a guest in the target tenant and granted the approve role. | Perform [Resolution D](#resolution-d) for cross-tenant onboarding. |
| The pending-connections list is empty. | The connection is already approved or rejected, or the requester used a different target resource ID. | Verify that the `$TARGET_RESOURCE_ID` value with the requester and relist. |

## Decision map for resolving AuthorizationFailed errors

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Root cause | Next action |
|---|---|---|
| [Step 1](#step-1) error cites `Microsoft.Network/privateEndpoints/write`. | The requester can't create the private endpoint. | Perform [Resolution A](#resolution-a) to create a Network Contributor at the private endpoint resource group level. |
| [Step 1](#step-1) error cites `Microsoft.Network/virtualNetworks/subnets/join/action`. | The requester can't join the target subnet. | Perform [Resolution B](#resolution-b) to create a Network Contributor (or custom role) on the VNet. |
| [Step 1](#step-1) error cites `Microsoft.Network/privateDnsZones/...` (including `.../A/write` and `.../virtualNetworkLinks/write`). | The requester can't write the Private DNS zone. | Perform [Resolution C](#resolution-c) to create a Private DNS Zone Contributor role on the zone, plus a Network Contributor role on the linked VNet if you create a VNet link. |
| [Step 1](#step-1) error cites `Microsoft.<RP>/<resource>/privateEndpointConnections/write` and [Step 3](#step-3) shows the tenants match. | The approver in the target tenant lacks the approve role. | Perform [Resolution D](#resolution-d) to create an approve role on the target resource. |
| [Step 1](#step-1) error cites `Microsoft.<RP>/<resource>/privateEndpointConnections/write` and [Step 3](#step-3) shows tenants don't match. | The approver is signed into the wrong tenant. | Perform [Resolution D](#resolution-d) to sign in to the target tenant first. |
| [Step 1](#step-1) error cites `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` (the requester is hitting the target's autoapprove policy from their own side). | The requester lacks private endpoint approval rights on the target. | Perform [Resolution E](#resolution-e) to create a role propagation-specific role on the target resource, or use `--manual-request true` to defer to [Resolution D](#resolution-d). |
| [Step 1](#step-1) error isn't `AuthorizationFailed`. | This error isn't an RBAC failure. | `Perform the steps in [Troubleshoot private endpoint creation that fails or stalls](/azure/private-link/troubleshoot-private-endpoint-creation-failed).` |
| You applied the routed resolution and the same `AuthorizationFailed` action still appears. | There's a role propagation lag, the wrong scope, or a deny assignment blocker. | Wait 5–10 minutes for role propagation, then rerun [Step 1](#step-1). If this still fails, recheck [Step 2](#step-2)'s scope and search for deny assignments. |

## Resolution A

The principal running `az network private-endpoint create` doesn't have `Microsoft.Network/privateEndpoints/write` permissions at the resource group or subscription level where you're creating the private endpoint.

The least-privilege built-in role that includes this action is **Network Contributor**. Assign it at the **resource-group** scope of the private endpoint. Don't assign it at the subscription scope unless the requester needs to operate across many resource groups in the same subscription.

1. Verify that the resource group exists and you have the IDs you need. This step is read-only.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:                                       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group hosting the private endpoint:           " RG
[ -z "$PRINCIPAL" ] && read -rp "Principal (UPN, app ID, or object ID):                 " PRINCIPAL

RG_ID=$(az group show --name "$RG" --subscription "$SUBSCRIPTION" --query id --output tsv)
echo "Resource group scope: $RG_ID"
echo "Principal:            $PRINCIPAL"
```

1. Collect the role assignments that the principal already has at the resource group scope to verify the least-privilege role to assign.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This operation grants the **Network Contributor** role on the private endpoint's resource group. Network Contributor grants management of all `Microsoft.Network/*` resources in that resource group. Verify that this scope is acceptable before applying.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:                              " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group hosting the private endpoint: " RG
[ -z "$PRINCIPAL" ] && read -rp "Principal (UPN, app ID, or object ID):        " PRINCIPAL

RG_ID=$(az group show --name "$RG" --subscription "$SUBSCRIPTION" --query id --output tsv)

az role assignment create \
  --assignee "$PRINCIPAL" \
  --role "Network Contributor" \
  --scope "$RG_ID"
```

> [!NOTE]
> If your tenant blocks `--assignee` Microsoft Graph lookups, replace it with `--assignee-object-id <objectId> --assignee-principal-type User|Group|ServicePrincipal`.

1. Wait 5–10 minutes for the role assignment to propagate, then have the requester rerun the create operation.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. 

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
  --connection-name "$CONN_NAME"
```

If you see values like `"provisioningState": "Succeeded"` and not `AuthorizationFailed`, the operation was successful. If the create operation now fails on `Microsoft.Network/virtualNetworks/subnets/join/action`, the subnet is in a different resource group or VNet that's owned by another team. Go to [Resolution B](#resolution-b).

## Resolution B

The principal can create the private endpoint object but lacks `Microsoft.Network/virtualNetworks/subnets/join/action` permissions on the target subnet. This permission gap is most common when the VNet and the private endpoint are in different resource groups. This situation can happen because a central network team owns the VNet.

The least-privilege built-in role that contains the join action is **Network Contributor** scoped to the VNet (or just the subnet to constrain it further). A custom role with only `Microsoft.Network/virtualNetworks/subnets/join/action` and `Microsoft.Network/virtualNetworks/subnets/read` permissions is also acceptable when you can't grant Network Contributor.

1. Identify the exact VNet that owns the target subnet. This step is read-only.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the VNet: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Resource Group of the VNet:      " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:                       " VNET_NAME

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)
echo "VNet scope to assign at: $VNET_ID"
```

2. Check existing role assignments on the VNet for the principal to verify the least-privilege role to assign.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

> [!NOTE]
> This step grants Network Contributor permissions on the VNet that owns the target subnet. The requester gains the ability to join network interfaces to any subnet in this VNet. If that's too broad, use the custom-role variant in the following step instead.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the VNet: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Resource Group of the VNet:      " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:                       " VNET_NAME
[ -z "$PRINCIPAL" ] && read -rp "Principal:                       " PRINCIPAL

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az role assignment create \
  --assignee "$PRINCIPAL" \
  --role "Network Contributor" \
  --scope "$VNET_ID"
```

3. Create a custom role with only the two actions required to join a subnet and assign it on the subnet itself. Use this option when you need a tighter least-privilege permission than Network Contributor.  

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the VNet: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Resource Group of the VNet:      " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:                       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:                     " SUBNET_NAME
[ -z "$PRINCIPAL" ] && read -rp "Principal:                       " PRINCIPAL

SUBNET_ID=$(az network vnet subnet show \
  --name "$SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

# 1. Create the custom role (run one time per subscription).
cat > /tmp/pe-subnet-join.json <<EOF
{
  "Name": "Private Endpoint Subnet Join",
  "IsCustom": true,
  "Description": "Allows attaching a private endpoint network interface to a subnet.",
  "Actions": [
    "Microsoft.Network/virtualNetworks/subnets/read",
    "Microsoft.Network/virtualNetworks/subnets/join/action"
  ],
  "NotActions": [],
  "AssignableScopes": [ "/subscriptions/$SUBSCRIPTION" ]
}
EOF

az role definition create --role-definition /tmp/pe-subnet-join.json

# 2. Assign the custom role on the subnet scope.
az role assignment create \
  --assignee "$PRINCIPAL" \
  --role "Private Endpoint Subnet Join" \
  --scope "$SUBNET_ID"
```

4. Wait 5–10 minutes for propagation, then rerun [Resolution A](#resolution-a) step 3 to retry the private endpoint create operation. A successful operation has values like `"provisioningState": "Succeeded"`.

If the create operation succeeds but the DNS zone group creation now fails on `Microsoft.Network/privateDnsZones/...`, go to [Resolution C](#resolution-c).

## Resolution C

You create the private endpoint, but you don't have the permissions to register the A record in the Private DNS zone or to create the virtual network link from the zone to the VNet. The missing actions are in `Microsoft.Network/privateDnsZones/`, specifically `.../A/write` for the A record and `.../virtualNetworkLinks/write` for a VNet link.

The least-privilege built-in role is **Private DNS Zone Contributor** scoped to the Private DNS zone or to the resource group that owns the zone if you have to manage multiple zones. For VNet-link creation, you also need `Microsoft.Network/virtualNetworks/join/action` permissions on the linked VNet.

1. Identify the Private DNS zone scope. This step is read-only.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the Private DNS zone: " SUBSCRIPTION
[ -z "$DNS_RG" ] && read -rp "Resource Group of the Private DNS zone:      " DNS_RG
[ -z "$DNS_ZONE" ] && read -rp "Private DNS zone name (e.g. privatelink.blob.core.windows.net): " DNS_ZONE

DNS_ZONE_ID=$(az network private-dns zone show \
  --name "$DNS_ZONE" \
  --resource-group "$DNS_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)
echo "DNS zone scope: $DNS_ZONE_ID"
```

2. Check existing role assignments on the Private DNS zone for the principal to verify the least-privilege role to assign.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the Private DNS zone: " SUBSCRIPTION
[ -z "$DNS_RG" ] && read -rp "Resource Group of the Private DNS zone:      " DNS_RG
[ -z "$DNS_ZONE" ] && read -rp "Private DNS zone name:                       " DNS_ZONE
[ -z "$PRINCIPAL" ] && read -rp "Principal:                                   " PRINCIPAL

DNS_ZONE_ID=$(az network private-dns zone show \
  --name "$DNS_ZONE" \
  --resource-group "$DNS_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az role assignment create \
  --assignee "$PRINCIPAL" \
  --role "Private DNS Zone Contributor" \
  --scope "$DNS_ZONE_ID"
```

3. If the missing action is `Microsoft.Network/privateDnsZones/virtualNetworkLinks/write` and the linked VNet lives in a different resource group, grant Network Contributor permissions on the linked VNet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription that owns the linked VNet: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "Resource Group of the linked VNet:      " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:                              " VNET_NAME
[ -z "$PRINCIPAL" ] && read -rp "Principal:                              " PRINCIPAL

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az role assignment create \
  --assignee "$PRINCIPAL" \
  --role "Network Contributor" \
  --scope "$VNET_ID"
```

4. Wait 5–10 minutes for propagation, then re-create the DNS zone group on the private endpoint.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription containing the private endpoint: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group of the private endpoint:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name:                         " PE_NAME
[ -z "$ZONE_GROUP_NAME" ] && read -rp "DNS zone group name (e.g. default):            " ZONE_GROUP_NAME
[ -z "$PRIVATE_DNS_ZONE_ID" ] && read -rp "Private DNS zone resource ID:                  " PRIVATE_DNS_ZONE_ID

az network private-endpoint dns-zone-group create \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --endpoint-name "$PE_NAME" \
  --name "$ZONE_GROUP_NAME" \
  --private-dns-zone "$PRIVATE_DNS_ZONE_ID" \
  --zone-name privatelink
```

A successful operation has the command returning a JSON payload with a value like `"provisioningState": "Succeeded"` and not `AuthorizationFailed`. If you see an error on `Microsoft.Network/privateEndpoints/privateDnsZoneGroups/write` instead, the requester also needs write permissions on the private endpoint itself. Perform [Resolution A](#resolution-a) at the private endpoint resource group level.

## Resolution D

The current principal can't approve the pending `privateEndpointConnections` on the target PaaS resource (like storage account, Key Vault, SQL server, Cosmos account, and App Service) because they lack `Microsoft.<RP>/<resource>/privateEndpointConnections/write` permissions on that resource. This permission issue is the most common cross-tenant failure mode. The requester needs no RBAC in the target tenant, only the approver does.

> [!IMPORTANT]
> For a cross-tenant private endpoint, the requester needs *only* the target resource ID or Azure Private Link service alias from the resource owner. They don't need any role in the target tenant or subscription. The resource owner (approver) is the one who needs the approve role, and they must be signed in to the target tenant when they run the approve command. If you skip [Step 3](#step-3), a correct role assignment can still be exposed as `AuthorizationFailed` because the CLI session was authenticated to the wrong tenant.

The least-privilege approve role depends on the target resource type. See the following table for details.

| Target resource type | Built-in role that includes `privateEndpointConnections/write` |
|---|---|
| Azure Storage account (`Microsoft.Storage/storageAccounts`) | Storage Account Contributor |
| Azure Key Vault (`Microsoft.KeyVault/vaults`) | Key Vault Contributor |
| Azure SQL server (`Microsoft.Sql/servers`) | SQL Server Contributor |
| Azure Cosmos DB account (`Microsoft.DocumentDB/databaseAccounts`) | DocumentDB Account Contributor |
| Azure Container Registry (`Microsoft.ContainerRegistry/registries`) | Contributor on the registry (no narrower built-in role) |
| Azure App Service or Function app (`Microsoft.Web/sites`) | Website Contributor |
| Any other resource type | Owner on the resource, or a custom role granting only `Microsoft.<RP>/<resource>/privateEndpointConnections/read` and `.../privateEndpointConnections/write` |

1. If you're an approver in a different tenant than the requester, sign in to the target tenant first. Skip this step if you're already in the right tenant. See [Step 3](#step-3).

Run the following commands in Azure CLI:

```azurecli-interactive
[ -z "$TARGET_TENANT_ID" ] && read -rp "Target tenant ID (the tenant that owns the PaaS resource): " TARGET_TENANT_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target subscription ID:                                    " TARGET_SUBSCRIPTION

az login --tenant "$TARGET_TENANT_ID"
az account set --subscription "$TARGET_SUBSCRIPTION"
az account show --query "{tenantId:tenantId, subscription:id, user:user.name}" --output json
```

2. Grant the least-privilege role that includes `privateEndpointConnections/write` on the target resource to the approver principal. 

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

> [!NOTE]
> This role grants the approve role on the target PaaS resource only. The requester (who's in a different tenant or team) needs nothing in this tenant.
> 
Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target subscription ID:                                   " TARGET_SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID (Storage / KV / SQL / etc.):           " TARGET_RESOURCE_ID
[ -z "$APPROVER" ] && read -rp "Approver principal (UPN, app ID, or object ID):           " APPROVER
[ -z "$APPROVE_ROLE" ] && read -rp "Role name from the table above (e.g. Storage Account Contributor): " APPROVE_ROLE

az role assignment create \
  --assignee "$APPROVER" \
  --role "$APPROVE_ROLE" \
  --scope "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION"
```

3. Approve the pending connection.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

 The `--id` form here works for any target resource type. For Storage, Key Vault, and Cosmos DB, the service-specific `az storage account private-endpoint-connection approve`, `az keyvault private-endpoint-connection approve`, and `az cosmosdb private-endpoint-connection approve` commands are also available. For Azure SQL Database (`az sql server`), App Service (`az webapp`), and most other resource types, no service-specific approve verb is published. Use the universal `az network private-endpoint-connection approve --id` form in the following commands.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target subscription ID:                       " TARGET_SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:                           " TARGET_RESOURCE_ID

# 1. List pending connections, capture the connection ID of the one to approve.
echo "── Pending connections ──"
az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[?properties.privateLinkServiceConnectionState.status=='Pending'].{name:name, id:id, requester:properties.privateEndpoint.id}" \
  --output table

[ -z "$CONNECTION_ID" ] && read -rp "Connection ID to approve (from the list above): " CONNECTION_ID
[ -z "$APPROVAL_NOTE" ] && read -rp "Approval note (free text):                       " APPROVAL_NOTE

# 2. Approve.
az network private-endpoint-connection approve \
  --id "$CONNECTION_ID" \
  --description "$APPROVAL_NOTE"
```

4. Verify the connection is now `Approved`.

Run the following commands in Azure CLI:

```azurecli-interactive
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID: " TARGET_RESOURCE_ID

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[].{name:name, status:properties.privateLinkServiceConnectionState.status, description:properties.privateLinkServiceConnectionState.description}" \
  --output table
```

The operation succeeded if the `status` value equals `Approved` for the connection you just acted on. The requester can now see the same status from their side and start sending traffic over the private endpoint.

If approval still returns `AuthorizationFailed` errors, rerun [Step 3](#step-3). 

## Resolution E

The requester's own `az network private-endpoint create` operation returns a `LinkedAuthorizationFailed` error that cites `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` on the target PaaS resource. The requester already has network rights (Network Contributor on the VNet and `privateEndpoints/write` on the private endpoint resource group), but the target's autoapprove policy requires the requester to also hold a role on the target that grants the private endpoint approval action. Otherwise, the autoapprove cascade fails and the create operation can't complete.

Follow this guidance when the requester is creating their own private endpoint with the default autoapprove path and hits a `PrivateEndpointConnectionsApproval/action` denial on the target resource. This guidance doesn't apply when an approver in the target tenant is processing a `Pending` connection (for this, see [Resolution D](#resolution-d)).

1. Identify the target resource's resource provider and pick the matching built-in role that grants `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` permissions. Use the following mapping:

- Storage account (`Microsoft.Storage/storageAccounts`) - **Storage Account Contributor**
- Key Vault (`Microsoft.KeyVault/vaults`) - **Key Vault Contributor**
- SQL server (`Microsoft.Sql/servers`) - **SQL Server Contributor**
- Cosmos DB account (`Microsoft.DocumentDB/databaseAccounts`) - **Cosmos DB Operator** (or **Contributor**)
- App Service or Function app (`Microsoft.Web/sites`) - **Website Contributor**
- Any other resource provider - Look up the built-in role whose `actions` list contains both `Microsoft.<RP>/<resource>/privateEndpointConnections/write` and `Microsoft.<RP>/<resource>/PrivateEndpointConnectionsApproval/action` values, or create a custom role containing only those two actions.

2. Grant the identified role to the requester principal on the target resource.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

> [!NOTE]
> This role grants the requester a role propagation-specific role on the target PaaS resource so that the autoapprove cascade succeeds. The role name and the resource type embedded in `--scope` must match the target's resource provider according to the step 1 mapping (for example, swap `Storage Account Contributor` or `Microsoft.Storage/storageAccounts` for `Key Vault Contributor` or `Microsoft.KeyVault/vaults` when the target is a Key Vault).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target subscription ID:                                              " TARGET_SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID (Storage / KV / SQL / Cosmos / Web / etc.):       " TARGET_RESOURCE_ID
[ -z "$REQUESTER" ] && read -rp "Requester principal (UPN, app ID, or object ID):                     " REQUESTER
[ -z "$APPROVE_ROLE" ] && read -rp "Role name from the E.1 mapping (e.g. Storage Account Contributor):    " APPROVE_ROLE

az role assignment create \
  --assignee "$REQUESTER" \
  --role "$APPROVE_ROLE" \
  --scope "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION"
```

The equivalent fixed-value shape is:

```
az role assignment create \
  --assignee <requester-principal-object-id> \
  --role "Storage Account Contributor" \
  --scope /subscriptions/<sub-id>/resourceGroups/<target-rg>/providers/Microsoft.Storage/storageAccounts/<target-storage-account>
```

3. Wait 5–10 minutes for the role assignment to propagate, then retry the autoapprove private endpoint create. Reuse the same `az network private-endpoint create` shape from [Resolution A](#resolution-a), step 3. No new flags are required.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

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
  --connection-name "$CONN_NAME"
```

The operation succeeded if the `privateLinkServiceConnectionState.status` value is `Approved` **and** `provisioningState` is `Succeeded`.

4. If the create process still fails on `PrivateEndpointConnectionsApproval/action`, rerun the following commands to verify that the role assignment is correct and propagated. If it succeeds but the connection is still `Pending` in the target resource, have the approver in the target tenant manually approve it by using [Resolution D](#resolution-d).

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

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
[ -z "$REQUEST_MSG" ] && read -rp "Request message for the approver: " REQUEST_MSG

az network private-endpoint create \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME" \
  --private-connection-resource-id "$TARGET_RESOURCE_ID" \
  --group-id "$GROUP_ID" \
  --connection-name "$CONN_NAME" \
  --manual-request true \
  --request-message "$REQUEST_MSG"
```

**Alternative option — bypass autoapprove entirely with `--manual-request true`**. Use this method when the requester can't or shouldn't have approval permissions on the target (true cross-tenant scenarios, separation of duties, or a target whose owner refuses to grant the requester any role on the resource). The connection is created in a `Pending` state, and an approver in the target tenant then completes approval by using [Resolution D](#resolution-d).

## References

- `[Troubleshoot private endpoint creation that fails or stalls](/azure/private-link/troubleshoot-private-endpoint-creation-failed)`
- [Azure built-in roles — Networking](/azure/role-based-access-control/built-in-roles/networking)
- [Manage a Private Endpoint connection](/azure/private-link/manage-private-endpoint)
- [Cross-tenant private endpoints](/azure/private-link/private-endpoint-overview#private-link-and-dns-integration)
