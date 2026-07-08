---
title: Troubleshoot a private endpoint connection stuck in Pending state
description: Diagnose and fix a private endpoint connection stuck in Pending in Azure, including manual approval, RBAC, and auto-approval settings. Resolve it now.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - pending-approval
  - private-endpoint-connection
  - private-endpoint-pending
  - manual-approval
  - cross-subscription
  - cross-tenant
  - auto-approval
  - service-managed-private-endpoint
  - front-door-private-endpoint
  - authorization-failed-approve
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateLinkServices/privateEndpointConnections/read
  - Microsoft.Network/privateLinkServices/privateEndpointConnections/write
  - Microsoft.Network/privateLinkServices/read
  - Microsoft.Network/privateLinkServices/write
  - Microsoft.Authorization/roleAssignments/read
  # Service-specific approve data-action on the target resource, for example:
  - Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action
  - Microsoft.KeyVault/vaults/privateEndpointConnectionsApproval/action
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - TARGET_RESOURCE_ID
  - TARGET_SUBSCRIPTION_ID
  - APPROVER
---

# Troubleshoot a private endpoint connection stuck in the Pending state

## Summary

This article helps you troubleshoot a private endpoint connection that is stuck in the `Pending` state on the target resource. 

A private endpoint reports `provisioningState: Succeeded` on the consumer side, but `privateLinkServiceConnectionState.status` is `Pending` and no traffic flows. The primary reasons for this state are: 

- A cross-subscription or cross-tenant connection that isn't on the target's auto-approval allow list and is waiting on a manual approval from the target resource owner. 
- The source private endpoint is created by a managed Azure service Azure Front Door Premium, Azure App Service, Azure Synapse, or Azure Data Factory, and these connections never auto-approve regardless of subscription. 
- The approver lacks the target's service-specific `privateEndpointConnectionsApproval/action` data action (for example `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action`) so the approve call returns `AuthorizationFailed` and the portal hides the **Approve** button. 
- The connection is expected to auto-approve but the target's allow list doesn't include the consumer subscription, so the request needs manual approval.

## Symptoms

You might experience one or more of the following symptoms:

- The consumer-side private endpoint shows `"provisioningState": "Succeeded"` but `"privateLinkServiceConnectionState": { "status": "Pending", ... }`.
- The [Azure portal](https://portal.azure.com) displays the connection on the target resource's **Private endpoint connections** blade in the `Pending` state.
- Traffic to the target's private IP times out or returns a connection-refused error from a client in the consumer virtual network (VNet), even though the Domain Name System (DNS) resolves to the private IP and network security group (NSG) and the route table checks are clean.
- An `az network private-endpoint-connection approve` call returns `AuthorizationFailed` and names a `*/privateEndpointConnectionsApproval/action` data action.
- The portal's **Approve** button on the target resource's **Private endpoint connections** blade is grayed out or missing.
- A Front Door Premium origin, App Service VNet integration, Azure Synapse-managed VNet, or Azure Data Factory-managed VNet shows a private endpoint in `Pending` on the target side and isn't progressing automatically.

## Prerequisites

To troubleshoot this issue, you need:

- **Permissions required:** On the **consumer** side, `Reader` role on the private endpoint resource group (to run [Step 1](#step-1)). On the **target** side, the service-specific approve data action permissions (for example `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action` for storage, and `Microsoft.KeyVault/vaults/privateEndpointConnectionsApproval/action` for Key Vault) or built-in roles that include the action vary by service. For auto-approval changes on a Private Link service ([Resolution D](#resolution-d)), `Microsoft.Network/privateLinkServices/write` permissions on the Private Link service scope.
- **Tools:** Azure CLI 2.50 or later, or an AI agent with Azure MCP or CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Subscription where the private endpoint (consumer side) lives. | `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e` |
| `{RESOURCE_GROUP}` | Resource group of the private endpoint (consumer side). | `myResourceGroup` |
| `{PE_NAME}` | Name of the private endpoint. | `myPrivateEndpoint` |
| `{TARGET_RESOURCE_ID}` | Full resource ID of the target the endpoint connects to (like storage account, key vault, SQL server, and Private Link service). | `/subscriptions/.../resourceGroups/rg-target/providers/Microsoft.Storage/storageAccounts/mystorage` |
| `{TARGET_SUBSCRIPTION_ID}` | Subscription that owns the target resource (can differ from the consumer subscription). | `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa` |
| `{APPROVER}` | Object ID (GUID) of the principal expected to approve the connection on the target side. You can also use a User Principal Name (UPN), but if the CLI returns `Insufficient privileges to complete the operation` when resolving the UPN using Microsoft Graph API, use the object ID instead (find it under **Microsoft Entra ID** > **Users** > *user* > **Object ID**). | `aaaabbbb-0000-cccc-1111-dddd2222eeee` |
| `{CONSUMER_SUBSCRIPTION_ID}` | Subscription that owns the source private endpoint, used when adding it to an auto-approval allow-list. | `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Confirm the connection state from the consumer side and capture the target resource ID, the original request message, and whether the source private endpoint is a user-created `Microsoft.Network/privateEndpoints` resource or one created by a managed service. The signal is `privateLinkServiceConnectionState.status` plus which connection array the entry sits in (`manualPrivateLinkServiceConnections` for manual-approval requests and `privateLinkServiceConnections` for auto-approval-attempted requests).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID (consumer): " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (consumer):  " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name:      " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{
      pe:name,
      provisioningState:provisioningState,
      manualConnections:manualPrivateLinkServiceConnections[].{
        name:name,
        target:privateLinkServiceId,
        groupIds:groupIds,
        status:privateLinkServiceConnectionState.status,
        requestMessage:privateLinkServiceConnectionState.requestMessage,
        actionsRequired:privateLinkServiceConnectionState.actionsRequired
      },
      autoConnections:privateLinkServiceConnections[].{
        name:name,
        target:privateLinkServiceId,
        groupIds:groupIds,
        status:privateLinkServiceConnectionState.status,
        requestMessage:privateLinkServiceConnectionState.requestMessage,
        actionsRequired:privateLinkServiceConnectionState.actionsRequired
      }
    }" \
  --output json
```

Record the following values from the output:

- `provisioningState` should be `Succeeded`. If it isn't, this scenario doesn't apply. The private endpoint failed to create. For more information, see [Troubleshoot private endpoint creation failure](troubleshoot-private-endpoint-creation-failed.md).
- `status` on the relevant connection should be `Pending`. If `Approved`, the issue isn't approval. Go to the [Decision map](#decision-map).
- The `target` resource ID: This is `$TARGET_RESOURCE_ID` for later steps.
- Whether the entry is under `manualConnections` (created with `--manual-request true`, meaning manual approval contract) or `autoConnections` (auto-approval was attempted).

> [!NOTE]
> If you don't have access to run `az network private-endpoint show` (for example, the source private endpoint is created by a managed service like Azure Front Door Premium, Azure App Service VNet integration, Azure Synapse-managed VNet, or Data Factory-managed VNet, and the private endpoint lives in a Microsoft-managed resource group you can't read), go to [Step 2](#step-2) and identify the connection from the target side instead.

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `provisioningState` is `Succeeded` and the connection `status` is `Pending`. | Confirmed `Pending` state. Continue diagnostics from the target side. | Perform [Step 2](#step-2). |
| `provisioningState` is `Succeeded` and the connection `status` is `Approved`. | Connection isn't pending approval. The issue isn't in scope for this guidance. | See the generic [Private Link connectivity TSG](/troubleshoot/azure/private-link/troubleshoot-private-link-connectivity) guidance. |
| `provisioningState` isn't `Succeeded`. | The private endpoint itself failed to create. This is a different scenario. | See [Troubleshoot private endpoint creation failure](troubleshoot-private-endpoint-creation-failed.md). |
| `ResourceNotFound`, or you can't read the source private endpoint (it lives in a Microsoft-managed resource group belonging to a service-managed private endpoint). | Skip the consumer-side check and identify the connection from the target side. | Perform [Step 2](#step-2). |

### Step 2

List every private endpoint connection on the target resource and confirm that the row for your endpoint is `Pending` from the target's perspective. Also capture the full `connection-id` (used by every approve or reject command), the source `privateEndpoint.id`, and the source subscription or tenant. The source `privateEndpoint.id` is the most reliable signal for whether the connection originates from a service-managed private endpoint. Managed services place the source private endpoint in a Microsoft-owned or service-owned resource group whose name usually starts with a service-specific prefix.

Run these commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION" \
  --query "[].{
      connectionId:id,
      name:name,
      status:properties.privateLinkServiceConnectionState.status,
      description:properties.privateLinkServiceConnectionState.description,
      actionsRequired:properties.privateLinkServiceConnectionState.actionsRequired,
      sourcePeId:properties.privateEndpoint.id
    }" \
  --output json
```

Record the following values from the output:

- The full `connectionId` for the Pending row. This is `$CONNECTION_ID` for every approve or reject command in the following steps.
- The `sourcePeId`. Extract the source resource group (the segment between `/resourceGroups/` and `/providers/`) and the source subscription (the segment after `/subscriptions/`). 

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| A row whose `sourcePeId` matches your private endpoint with `status: Pending`. | Confirmed `Pending` on the target side. | Perform [Step 3](#step-3). |
| A row whose `sourcePeId` matches your private endpoint with `status: Approved` or `status: Rejected`. | The target side already responded and the consumer view in [Step 1](#step-1) might be stale or the connection was approved or rejected after [Step 1](#step-1) ran. | Re-run [Step 1](#step-1). If it's still `Pending` on the consumer side after several minutes, open an Azure support request as a control-plane inconsistency. |
| No row matches the source private endpoint. | The connection request never reached the target. This is a private endpoint creation or configuration problem, not an approval problem. | See [Troubleshoot private endpoint creation failure](troubleshoot-private-endpoint-creation-failed.md). |
| `sourcePeId` points to a resource group with a service-managed prefix (for example `AzureFrontDoor-*`, `*-managed-rg-*`, `synapseworkspace-managedrg-*`, or `adf-managed-vnet-*`.) Confirm the canonical managed-resource group prefix names per service (for example, Front Door, App Service, Azure Synapse, Data Factory) against current Microsoft Learn documentation. | The source private endpoint is created by a managed Azure service. | Perform [Step 3](#step-3). |
| `AuthorizationFailed` when listing on the target. | You don't have read permissions on the target resource. Get the target resource owner to run this step, or grant Reader permissions on the target. | Get access and re-run [Step 2](#step-2). |

### Step 3

Check whether the target resource's auto-approval allow-list includes the consumer subscription. If the target is a Private Link service, the allow-list is `properties.autoApproval.subscriptions` on the Private Link service. For first-party Azure services exposed through Private Link (like Azure Storage, Key Vault, and SQL) the equivalent allow-list is a service-specific property on the target resource. A consumer subscription that isn't on the allow-list is an indicator of the problem.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$CONSUMER_SUBSCRIPTION" ] && read -rp "Consumer Subscription ID:  " CONSUMER_SUBSCRIPTION

# 1. If the target is a Private Link Service, read its auto-approval list directly.
# 2. Otherwise the target is a first-party service (storage, Key Vault, SQL, etc.);
#    the equivalent allow-list is a service-specific property and there is no
#    single CLI surface that returns it. Fall back to `az resource show` against
#    the target resource ID and inspect the JSON for an `autoApprovedSubscriptions`
#    / `subscriptions` property under the service's private-link config.
case "$TARGET_RESOURCE_ID" in
  */privateLinkServices/*)
    echo "── PLS autoApproval allow-list ──"
    az network private-link-service show \
      --ids "$TARGET_RESOURCE_ID" \
      --query "{
          autoApprovalSubs:autoApproval.subscriptions,
          visibilitySubs:visibility.subscriptions
        }" \
      --output json
    echo "── Is the consumer subscription on the autoApproval list? ──"
    az network private-link-service show \
      --ids "$TARGET_RESOURCE_ID" \
      --query "contains(autoApproval.subscriptions, '$CONSUMER_SUBSCRIPTION')" \
      --output tsv
    ;;
  *)
    echo "── First-party target — dumping full resource JSON for inspection ──"
    echo "── Look for an autoApproval / autoApprovedSubscriptions / allowedSubscriptions property on the target's private-link config ──"
    # <!-- VERIFY: confirm the exact property path per first-party service.
    #     The auto-approval surface is not uniform across services; some services
    #     (for example Azure Managed Grafana, API Management) expose an
    #     autoApprovedSubscriptions array on the service config, others do not
    #     expose any auto-approval at all (Front Door Premium never auto-approves). -->
    az resource show \
      --ids "$TARGET_RESOURCE_ID" \
      --subscription "$TARGET_SUBSCRIPTION" \
      --output json
    ;;
esac
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Target is a Private Link service, `autoApproval.subscriptions` is empty or doesn't contain `$CONSUMER_SUBSCRIPTION`, and the `contains(...)` check returns `false`. | Auto-approval was expected but the consumer subscription isn't on the allow list. | Perform [Resolution D](#resolution-d). |
| Target is a first-party service, no `autoApproval`. / `autoApprovedSubscriptions` property exists on the target's private-link configuration and the source private endpoint in [Step 2](#step-2) isn't a managed-service private endpoint. | Auto-approval isn't configured or supported on this service. The connection is correctly waiting for manual approval. | Perfrom [Step 4](#step-4). |
| Target is a first-party service and the inspection shows an `autoApprovedSubscriptions` or equivalent property that doesn't include `$CONSUMER_SUBSCRIPTION`. Verify the property name and shape per service. | Auto-approval was expected but the consumer subscription isn't on the allow list. | Perform [Resolution D](#resolution-d). |
| The allow list does include `$CONSUMER_SUBSCRIPTION` but the connection is still `Pending`. | Allow list is correct. Auto-approval isn't the cause. Either the connection predates the allow list change (existing `Pending` rows still need a manual approve) or another constraint is blocking things. | Perform [Step 4](#step-4). If Step 4 is also clean, go to [Resolution A](#resolution-a) and approve manually. |

### Step 4

Check whether the principal expected to approve has the service-specific `privateEndpointConnectionsApproval/action` data action at the target resource scope. The exact action string depends on the target service. For example, `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action` for Azure Storage, `Microsoft.KeyVault/vaults/privateEndpointConnectionsApproval/action` for Key Vault. Missing this action is an indicator for the problem when the approve call returns `AuthorizationFailed` and the portal's **Approve** button is hidden.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$APPROVER" ] && read -rp "Approver (UPN or object ID): " APPROVER

# 1. List every role assignment the approver has at or above the target resource scope.
#    --include-inherited surfaces assignments inherited from RG / subscription / MG.
echo "── Role assignments for $APPROVER affecting $TARGET_RESOURCE_ID ──"
az role assignment list \
  --assignee "$APPROVER" \
  --scope "$TARGET_RESOURCE_ID" \
  --include-inherited \
  --subscription "$TARGET_SUBSCRIPTION" \
  --query "[].{role:roleDefinitionName, scope:scope, principalType:principalType}" \
  --output table

# 2. Resolve each assigned role to its permission list and search for the approve action.
#    The action lives under the role's dataActions (a data plane action), not actions.
echo "── Permissions on each assigned role (look for *privateEndpointConnectionsApproval/action) ──"
for role in $(az role assignment list \
                --assignee "$APPROVER" \
                --scope "$TARGET_RESOURCE_ID" \
                --include-inherited \
                --subscription "$TARGET_SUBSCRIPTION" \
                --query "[].roleDefinitionName" \
                --output tsv | sort -u); do
  echo "── $role ──"
  az role definition list \
    --name "$role" \
    --subscription "$TARGET_SUBSCRIPTION" \
    --query "[].{name:roleName, actions:permissions[].actions[], dataActions:permissions[].dataActions[], notActions:permissions[].notActions[]}" \
    --output json
done
```

Search for the substring `privateEndpointConnectionsApproval/action`. It appears under either `actions` or `dataActions` depending on the service's role-based access control (RBAC) model. 

> [!IMPORTANT]
> Confirm whether the approve action is modeled as an `action` or a `dataAction` per service against the [Azure built-in roles reference](/azure/role-based-access-control/built-in-roles). Behavior differs between Azure Storage, Key Vault, Azure Cosmos DB, and Private Link service.

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| No role on `$APPROVER` lists any `*/privateEndpointConnectionsApproval/action` permission for the target's resource provider. | Approver lacks the service-specific approve data action permissions. | Perform [Resolution C](#resolution-c). |
| A role on `$APPROVER` includes the correct `*/privateEndpointConnectionsApproval/action` and the source private endpoint in [Step 2](#step-2) is a user-created private endpoint. | Cross-subscription or cross-tenant connection that requires a manual approve. | Perform [Resolution A](#resolution-a). |
| A role on `$APPROVER` includes the correct `*/privateEndpointConnectionsApproval/action` and the source private endpoint in [Step 2](#step-2) is service-managed (Front Door, App Service, Azure Synapse, Data Factory) | Service-managed source. The target owner must approve manually. | Perform [Resolution B](#resolution-b). |
| `az role assignment list` returns `AuthorizationFailed` for the approver lookup. | You can't read role assignments on the target. Get the target subscription's `User Access Administrator` permissions or owner to run this step. | Recover access and re-run [Step 4](#step-4). |

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

## Decision map

| Diagnostic result | Root cause | Next actions |
|---|---|---|
| [Step 3](#step-3) shows the consumer subscription isn't on the target's auto-approval allow-list (Private Link service `autoApproval.subscriptions` or first-party equivalent). | Auto-approval allow-list missing the consumer subscription. | Perform [Resolution D](#resolution-d). |
| [Step 4](#step-4) shows the approver lacks the target's `*/privateEndpointConnectionsApproval/action` data action permissions. |Approver RBAC missing. | Perform [Resolution C](#resolution-c). |
| [Step 2](#step-2) source private endpoint is service-managed (Front Door Premium, App Service, Azure Synapse-managed VNet, Data Factory-managed VNet) and [Step 3](#step-3) and [Step 4](#step-4) are clean. | Service-managed source, target owner must manually approve. | Perform [Resolution B](#resolution-b). |
| [Step 2](#step-2) source private endpoint is a user-created `Microsoft.Network/privateEndpoints` resource, the source is cross-subscription or cross-tenant from the target, and [Step 3](#step-3) and [Step 4](#step-4) are clean. | Manual approval required across the trust boundary. | Perform [Resolution A](#resolution-a). |
| [Step 2](#step-2) shows no `Pending` row for the source private endpoint on the target. | Not an approval problem. | See [Troubleshoot private endpoint creation failure](troubleshoot-private-endpoint-creation-failed.md) |
| All `Approved` on both sides ([Step 1](#step-1) and [Step 2](#step-2) both show `Approved`), but traffic still fails. | Approval isn't the cause. This is a connectivity, DNS, NSG, or firewall problem instead. | See [Troubleshoot Private Link connectivity](troubleshoot-private-link-connectivity.md). |

## Resolution A

The private endpoint is a user-created `Microsoft.Network/privateEndpoints` resource whose request crosses a subscription or tenant boundary into a target resource that doesn't auto-approve from the consumer subscription. The connection sits in `Pending` until a principal with the target's service-specific approve data action permissions runs `az network private-endpoint-connection approve` against the connection on the target side. The consumer can't fix this from their own subscription. The approver must run the commands on the target subscription.

Run the following commands in Azure CLI.

1. Discover the exact `connectionId` of the `Pending` connection on the target. Use `$TARGET_RESOURCE_ID` from [Step 2](#step-2) and the source private endpoint name from [Step 1](#step-1).

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$SOURCE_PE_NAME" ] && read -rp "Source PE Name (from Step 1): " SOURCE_PE_NAME

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION" \
  --query "[?ends_with(properties.privateEndpoint.id, '/privateEndpoints/$SOURCE_PE_NAME')].{
      connectionId:id,
      status:properties.privateLinkServiceConnectionState.status,
      description:properties.privateLinkServiceConnectionState.description,
      requestMessage:properties.privateLinkServiceConnectionState.requestMessage
    }" \
  --output json
```

Copy the `connectionId` value. It's the full Azure Resource Manager (ARM) resource ID of the connection and is the only argument the approve command needs.

2. Approve the connection. Run this as the approver signed in to the target subscription.

> [!IMPORTANT]
> This command approves the `Pending` private endpoint connection on the target resource. After approval succeeds, the consumer's `privateLinkServiceConnectionState.status` flips to `Approved`, the connection becomes active, and traffic begins to flow over the private IP. No other resource is modified.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$CONNECTION_ID" ] && read -rp "Connection ID (from A.1):  " CONNECTION_ID
[ -z "$APPROVE_DESCRIPTION" ] && read -rp "Approval description (free text): " APPROVE_DESCRIPTION

az network private-endpoint-connection approve \
  --id "$CONNECTION_ID" \
  --description "$APPROVE_DESCRIPTION" \
  --subscription "$TARGET_SUBSCRIPTION"
```

1. Re-run [Step 1](#step-1) from the consumer side. `privateLinkServiceConnectionState.status` should now read `Approved` and `actionsRequired` should be `None`. Re-run [Step 2](#step-2) from the target side as a cross-check. Both views should show `Approved`.

If the approve call returned `AuthorizationFailed` on a `*/privateEndpointConnectionsApproval/action`, the approver doesn't have the required data action. Go to [Resolution C](#resolution-c). If both sides now show `Approved` but traffic still fails, it isn't an approval problem. See [Troubleshoot Private Link connectivity](troubleshoot-private-link-connectivity.md).

## Resolution B

A managed Azure service creates the source private endpoint, such as Front Door Premium, App Service VNet integration, Azure Synapse-managed VNet, or Data Factory-managed VNet. These services never auto-approve connections, regardless of subscription or auto-approval allow-list configuration. Front Door Premium specifically requires an explicit approval on the target resource for every origin (see [Stack Overflow #77273621](https://stackoverflow.com/questions/77273621) and [Microsoft Learn: Secure your origin with Private Link](/azure/frontdoor/private-link) for more details). The fix is the same approve API as [Resolution A](#resolution-a), but the approver is the target resource owner, not the owner of the managed service (like with Front Door, App Service, Azure Synapse, and Data Factory). Adding the consumer subscription to an auto-approval list doesn't clear these connections.

Run the following commands in Azure CLI.

1. Confirm the source private endpoint is service-managed by inspecting `sourcePeId` from [Step 2](#step-2). 

Service-managed source private endpoints live in a Microsoft-owned resource group whose name typically encodes the service (for example, a resource group starting with `AzureFrontDoor-` for Front Door Premium origins, or a workspace-prefixed managed resource group for Azure Synapse and Data Factory). The source `subscriptionId` segment of the resource ID is also commonly a Microsoft-owned subscription that the consumer can't read.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION" \
  --query "[?properties.privateLinkServiceConnectionState.status=='Pending'].{
      connectionId:id,
      sourcePeId:properties.privateEndpoint.id,
      requestMessage:properties.privateLinkServiceConnectionState.requestMessage
    }" \
  --output json
```

Confirm the `sourcePeId` matches the managed service you enabled (for example, a Front Door Premium origin onboarding flow). If `sourcePeId` instead points to a private endpoint your team created directly in your own subscription, return to [Resolution A](#resolution-a).

2. Approve the connection on the target. The signed-in principal must be the target resource owner with the target's approve data action permissions.

> [!IMPORTANT]
> This action approves the `Pending` connection from the managed service on the target resource. After approval, the managed service (like Front Door, App Service, Azure Synapse, and Data Factory) can begin sending traffic over the private endpoint. The managed service itself isn't modified. The change is only on the target resource's connection list.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$CONNECTION_ID" ] && read -rp "Connection ID (from B.1):  " CONNECTION_ID
[ -z "$APPROVE_DESCRIPTION" ] && read -rp "Approval description (e.g. 'Approved for Front Door Premium origin'): " APPROVE_DESCRIPTION

az network private-endpoint-connection approve \
  --id "$CONNECTION_ID" \
  --description "$APPROVE_DESCRIPTION" \
  --subscription "$TARGET_SUBSCRIPTION"
```

3. Re-run [Step 2](#step-2) from the target side. The connection's `status` should now read `Approved`. For Front Door Premium, the origin's **Private endpoint status** in the Front Door portal blade also flips to `Approved` once propagation completes (usually minutes).

If the approve call returned `AuthorizationFailed`, see [Resolution C](#resolution-c). If you have to repeat this approval frequently because the managed service recreates the connection (for example, after a Front Door origin reconfiguration), this is expected. Managed-service private endpoints don't benefit from auto-approval allow-lists and every recreate requires a fresh manual approve.

## Resolution C

The approver doesn't have the target's service-specific `privateEndpointConnectionsApproval/action` data action permissions at or above the target resource scope. The approve call returns `AuthorizationFailed` naming the missing action (for example, `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action`), and the Azure portal hides the **Approve** button. Granting a role that contains the missing action (either a service-specific built-in role or a custom role with the action under `actions` or `dataActions`, depending on the service) unblocks the approve.

Run the following commands in Azure CLI.

1. Identify the exact action string the approve call needs by finding the most recent `AuthorizationFailed` error from a re-attempted approve, or by checking the service's built-in role reference. The action follows the pattern `Microsoft.<Provider>/<resourceType>/privateEndpointConnectionsApproval/action`. The following are examples:

- Storage: `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action`
- Key Vault: `Microsoft.KeyVault/vaults/privateEndpointConnectionsApproval/action`
- Private Link service: `Microsoft.Network/privateLinkServices/privateEndpointConnections/write` 

> [!IMPORTANT]
> Confirm the exact Private Link service approve action. Some services key off of `privateEndpointConnections/write`, others off of `privateEndpointConnectionsApproval/action`. Validate against `az provider operation show --namespace <ns>`. 

Confirm the action isn't already granted to the approver:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$APPROVER" ] && read -rp "Approver (UPN or object ID): " APPROVER
[ -z "$APPROVE_ACTION" ] && read -rp "Approve action string (e.g. Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action): " APPROVE_ACTION

# Re-derive the role list (same logic as Step 4) and search for the action.
for role in $(az role assignment list \
                --assignee "$APPROVER" \
                --scope "$TARGET_RESOURCE_ID" \
                --include-inherited \
                --subscription "$TARGET_SUBSCRIPTION" \
                --query "[].roleDefinitionName" \
                --output tsv | sort -u); do
  hit=$(az role definition list \
          --name "$role" \
          --subscription "$TARGET_SUBSCRIPTION" \
          --query "[].permissions[].(actions[] || dataActions[])" \
          --output tsv 2>/dev/null | grep -F "$APPROVE_ACTION" || true)
  if [ -n "$hit" ]; then
    echo "GRANTED via role: $role"
  fi
done
echo "(If no GRANTED line printed, the approver is missing the action.)"
```

2. Assign a role that includes the missing action. Replace `$BUILT_IN_ROLE` with the smallest built-in role that contains the action for your target service (or use a custom role with just the approve action if available).

> [!IMPORTANT]
> This step grants the approver a service-specific built-in role that includes the `privateEndpointConnectionsApproval/action` data action, scoped to the target resource only. Resource-scoped assignment limits the radius and the approver gains the approve capability on just this one target. For example, **Storage Account Contributor** grants the storage approve action on storage. For Key Vault, the equivalent is **Key Vault Contributor**. For Private Link service, **Network Contributor**. 

> [!IMPORTANT]
> Confirm the smallest built-in role that includes the approve action per service. For some services, a custom role with just the approve action is preferable to avoid granting too many permissions.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$APPROVER" ] && read -rp "Approver (UPN or object ID): " APPROVER
[ -z "$BUILT_IN_ROLE" ] && read -rp "Built-in role name (e.g. 'Storage Account Contributor'): " BUILT_IN_ROLE

az role assignment create \
  --assignee "$APPROVER" \
  --role "$BUILT_IN_ROLE" \
  --scope "$TARGET_RESOURCE_ID" \
  --subscription "$TARGET_SUBSCRIPTION"
```

3. Wait for the role assignment to propagate. 

 > [!NOTE]
> Propagation typically completes within minutes but can take up to 30 minutes in some scenarios. 

1. Re-run [Step 4](#step-4). The approver should now show the service-specific approve action under one of the assigned roles. Then run [Resolution A](#resolution-a) if the source is service-managed to retry the approve. The approve call should succeed and the connection's `status` should change to `Approved` on both sides.

If the approve call still returns `AuthorizationFailed` after propagation, the action string in the error doesn't match the action included in the role you assigned. Confirm both against `az provider operation show --namespace <provider>` and assign a different role or a custom role with the exact action.

## Resolution D

Auto-approval is expected for the consumer subscription, but the target's auto-approval allow list doesn't include it, so the request needs manual approval. Adding the consumer subscription to the allow list makes new connection requests auto-approve. Existing `Pending` connections still need a one-time manual approve ([Resolution A](#resolution-a) or [Resolution B](#resolution-b) depending on the source type). Updating the allow list doesn't retroactively approve connections that are already in `Pending`.

Run the following commands in Azure CLI.

1. Re-read the current allow list from [Step 3](#step-3) so you know exactly what's there before you change it.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:        " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION

case "$TARGET_RESOURCE_ID" in
  */privateLinkServices/*)
    az network private-link-service show \
      --ids "$TARGET_RESOURCE_ID" \
      --query "{
          autoApprovalSubs:autoApproval.subscriptions,
          visibilitySubs:visibility.subscriptions
        }" \
      --output json
    ;;
  *)
    echo "── First-party target — dumping resource JSON; locate the auto-approval property ──"
    # <!-- VERIFY: the exact property path for adding a subscription to the auto-approval
    #     allow-list differs per first-party service (Managed Grafana, API Management,
    #     etc.) and is not always exposed by a typed `az <service>` subcommand. For
    #     unsupported services, use `az resource update --set properties.<path>=...`. -->
    az resource show \
      --ids "$TARGET_RESOURCE_ID" \
      --subscription "$TARGET_SUBSCRIPTION" \
      --output json
    ;;
esac
```

1. This command replaces the target Private Link service's auto-approval subscription list with the values you supply. Connections from any subscription on this list auto-approve in the future. Connections currently in `Pending` aren't affected by this change. To preserve existing entries, include them along with the new consumer subscription in `$AUTO_APPROVAL_SUBS` (space-separated). `--visibility` controls which subscriptions can see the Private Link service as a target. It's also updated here so the consumer can re-create a connection if needed.

Update the auto-approval list on a Private Link Service target:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID (must be a Private Link Service): " TARGET_RESOURCE_ID
[ -z "$TARGET_SUBSCRIPTION" ] && read -rp "Target Subscription ID:    " TARGET_SUBSCRIPTION
[ -z "$AUTO_APPROVAL_SUBS" ] && read -rp "Auto-approval subscription IDs (space-separated, include existing + new): " AUTO_APPROVAL_SUBS
[ -z "$VISIBILITY_SUBS" ] && read -rp "Visibility subscription IDs (space-separated, include existing + new): " VISIBILITY_SUBS

az network private-link-service update \
  --ids "$TARGET_RESOURCE_ID" \
  --auto-approval $AUTO_APPROVAL_SUBS \
  --visibility $VISIBILITY_SUBS
```

> [!NOTE]
> For first-party targets (like Azure Storage, Key Vault, Azure Managed Grafana, and Azure API Management) there's no uniform `az <service> update --auto-approval` flag. Use the service-specific update command if one exists, or use `az resource update --ids "$TARGET_RESOURCE_ID" --set properties.<auto-approval-path>='["<sub-id>"]'` with the path you identified in step 1. 

3. Re-run [Step 3](#step-3) to confirm `$CONSUMER_SUBSCRIPTION` now appears in the auto-approval list.
4. After the connection is approved, re-run [Step 1](#step-1) from the consumer side. `status` should read `Approved` and traffic should flow.

> [!NOTE]
> The existing Pending connection isn't retroactively approved by the allow list change. Clear it by using one of the following options:
> 
> - Approve it manually by using [Resolution A](#resolution-a) (for user-created source) or [Resolution B](#resolution-b) (for service-managed source). This method is fastest.
> - Recreate the connection from the consumer side. Delete the source private endpoint and re-create it. The new request auto-approves because the allow list now includes the consumer subscription. (Recreate has higher impact but only use it if a manual approve isn't possible.)

## References

- [Manage private endpoint connections](/azure/private-link/manage-private-endpoint)
- [Approval workflow for Private Link Service](/azure/private-link/private-link-service-overview#control-service-access)
- [Secure your origin with Private Link in Azure Front Door Premium](/azure/frontdoor/private-link)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Troubleshoot Azure Private Link connectivity](troubleshoot-private-link-connectivity.md)
- [Troubleshoot private endpoint creation that fails or stalls](troubleshoot-private-endpoint-creation-failed.md)
