---
title: "Troubleshoot Private Link service and resource limits or scale ceilings reached in Azure Private Link"
description: "Step-by-step diagnostics to identify and resolve Azure Private Link failures caused by the per-virtual-network private endpoint ceiling, the auto-approval connection cap, and the one-Private-Link-Service-per-load-balancer-frontend-IP limit."
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Configure, Set up, or Manage
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - private-endpoint-limit-reached
  - private-endpoint-quota-exceeded
  - per-vnet-private-endpoint-cap
  - private-endpoint-connection-pending
  - auto-approval-limit-exceeded
  - private-link-service-frontend-ip-in-use
  - one-pls-per-frontend-ip
  - service-limit-reached
  - scale-ceiling-reached
ai.hint.scope: subscription-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateEndpoints/write
  - Microsoft.Network/privateLinkServices/read
  - Microsoft.Network/privateLinkServices/write
  - Microsoft.Network/privateLinkServices/privateEndpointConnections/read
  - Microsoft.Network/loadBalancers/read
  - Microsoft.Network/loadBalancers/write
  - Microsoft.Network/register/action
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - VNET_NAME
  - TARGET_RESOURCE_ID
  - LB_NAME
---

# Troubleshoot Private Link service and resource limits or scale ceilings reached in Azure Private Link

## Summary

This article helps you troubleshoot and resolve failures in Azure Private Link that are caused by reaching a service limit or scale ceiling.

A Private Link create operation or connection operation fails or stalls because a service limit or scale ceiling is reached. The three root-cause categories are: 

- The target virtual network reaches its default cap of 1,000 private endpoints (or the subscription is near its 65,536 per-region private endpoint ceiling). Therefore, a new private endpoint create operation fails and generates a limit error. 
- The subscription is at or over its autoapproval cap. Therefore, a correctly configured new private endpoint connection stays in the `Pending` state instead of being autoapproved. 
- You try to bind a second Private Link Service to a load balancer front-end IP that's already in use. This action is then blocked because only one Private Link Service is allowed per load balancer front-end IP. 

## Symptoms

You might experience one or more of the following issues:

- An `az network private-endpoint create` operation fails with a message referencing `limit`, `quota`, `cap`, `exceeded`, or `maximum number of private endpoints`.
- A newly created private endpoint connection stays in `Pending` indefinitely even though the configuration is correct, instead of moving to `Approved` automatically.
- An `az network private-link-service create` operation fails with a message indicating the load balancer front-end IP configuration is already in use, or that only one Private Link Service is allowed per front-end IP.
- The count of private endpoints in a virtual network is at or near 1,000.
- The portal shows a subscription-level `auto-approval limit` or `connection limit` message when a connection is requested.

## Prerequisites

To troubleshoot effectively, you must have the following prerequisite items:

- **Permissions required**: 
  - `Network Contributor` role on the resource group hosting the private endpoint, the target virtual network, the Private Link Service, and the load balancer; 
  - `Microsoft.Network/register/action` permissions (for example, using `Contributor` permissions at a subscription scope) to register a feature flag or resource provider. 
  - The ability to read and approve connections on the target resource.
- **Tools** Azure CLI 2.50 or later, or an AI agent with Azure MCP or CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID where the resources live | `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e` |
| `{RESOURCE_GROUP}` | Resource group for the private endpoint, Private Link Service, or load balancer | `myResourceGroup` |
| `{VNET_NAME}` | Virtual network that hosts the private endpoint network interface cards (NICs) | `myVNet` |
| `{TARGET_RESOURCE_ID}` | Resource ID of the resource the endpoint connects to (like Azure Storage account, Azure Key Vault, SQL server, or Private Link Service) | `/subscriptions/.../providers/Microsoft.Storage/storageAccounts/mystorage` |
| `{LB_NAME}` | Standard load balancer that fronts the Private Link Service | `myStandardLB` |
| `{REGION}` | Azure region short code for the resources | `eastus` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are for strictly for discovery ("read-only") save [Step 1](#step-1). They don't make changes to your environment.> 
 
### Step 1

Re-run the exact operation that failed (like a private endpoint create or a Private Link Service create operation) using `--debug` so the precise Azure Resource Manager (ARM) error code, message, and `x-ms-correlation-request-id` are captured. The error text (and whether a new private endpoint connection lands in `Pending`) is the strongest single signal for routing.

Use the first cmd block if a private endpoint create operation failed or its connection stalled. Use the second block if a Private Link Service create operation failed.

Run the following commands in Azure CLI.

**Private endpoint create operation**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:             " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:           " SUBNET_NAME
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID:    " TARGET_RESOURCE_ID
[ -z "$GROUP_ID" ] && read -rp "Group ID (e.g. blob, vault, sqlServer): " GROUP_ID
[ -z "$CONN_NAME" ] && read -rp "Connection Name:       " CONN_NAME

# --debug surfaces the x-ms-correlation-request-id response header (NOT --verbose).
az network private-endpoint create \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME" \
  --private-connection-resource-id "$TARGET_RESOURCE_ID" \
  --group-id "$GROUP_ID" \
  --connection-name "$CONN_NAME" \
  --debug 2>&1 | tee /tmp/pl-scale.log

echo "── Correlation ID (quote this in any support request) ──"
grep -i "x-ms-correlation-request-id" /tmp/pl-scale.log | tail -n 1
```

**Private Link Service create operation**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$PLS_NAME" ] && read -rp "Private Link Service Name: " PLS_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:              " VNET_NAME
[ -z "$PLS_SUBNET_NAME" ] && read -rp "PLS NAT Subnet Name:    " PLS_SUBNET_NAME
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name:     " LB_NAME
[ -z "$LB_FE_NAME" ] && read -rp "LB Frontend IP config name to bind: " LB_FE_NAME

# --debug surfaces the x-ms-correlation-request-id response header (NOT --verbose).
az network private-link-service create \
  --name "$PLS_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$PLS_SUBNET_NAME" \
  --lb-name "$LB_NAME" \
  --lb-frontend-ip-configs "$LB_FE_NAME" \
  --debug 2>&1 | tee /tmp/pl-scale.log

echo "── Correlation ID (quote this in any support request) ──"
grep -i "x-ms-correlation-request-id" /tmp/pl-scale.log | tail -n 1
```

Record the `x-ms-correlation-request-id`. This header is emitted at `debug`-level only. You need the correlation ID if you open a support case.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The private endpoint create operation fails with text referencing `limit`, `quota`, `cap`, `exceeded`, or `maximum number of private endpoints` | A per-virtual network (VNet) or per-subscription private endpoint ceiling might be reached. | Perform [Step 2](#step-2). |
| The private endpoint create operation succeeds (or already succeeded), but the connection never autoapproves, and remains in a `Pending` state. | The subscription moight be at its auto-approval cap. | Perform [Step 3](#step-3). |
| The Private Link Service create operation fails with the code `PrivateLinkServiceCannotReferenceFrontendIpConfigurationReferencedByDifferentPrivateLinkService` (the front-end IP configuration is already referenced by another Private Link Service). | A second Private Link Service is already bound to an in-use front-end IP. | Perform [Step 4](#step-4). |
| Any other error. | The failure isn't one of the three known scale limits that were previously mentioned. Perform every check in the given order. | Perform [Step 2](#step-2). |

### Step 2

Check whether the target virtual network reached its default ceiling of 1,000 private endpoints, and how close the subscription is to the 65,536 per-region private endpoint ceiling. This check also reports whether the High-Scale Private Endpoints feature is already registered because that flag raises the per-VNet ceiling. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$REGION" ] && read -rp "Region (e.g. eastus): " REGION

# 1. Private endpoints whose NIC is in this VNet (per-VNet ceiling = 1,000 default).
echo "── Private endpoints in VNet '$VNET_NAME' (ceiling 1,000) ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length([?contains(subnet.id, '/virtualNetworks/$VNET_NAME/')])" \
  --output tsv

# 2. Regional per-subscription private endpoint usage vs limit (ceiling 65,536).
echo "── Private Endpoints usage in region '$REGION' (ceiling 65,536) ──"
az network list-usages \
  --location "$REGION" \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(name.value, 'PrivateEndpoint')].{name:name.localizedValue, current:currentValue, limit:limit}" \
  --output json

# 3. Is High-Scale Private Endpoints already enabled (it raises the per-VNet ceiling)?
echo "── High-Scale Private Endpoints feature state ──"
az feature show \
  --namespace Microsoft.Network \
  --name EnableMaxPrivateEndpointsVia64kPath \
  --subscription "$SUBSCRIPTION" \
  --query "properties.state" \
  --output tsv 2>/dev/null || echo "NotRegistered"
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| The VNet private endpoint count is greater than 1,000 (or within a few of 1,000) and the High-Scale feature state isn't `Registered`. | The per-VNet 1,000-endpoint ceiling is reached. | Perform [Resolution A](#resolution-a). |
| The regional `Private Endpoints` `current` value is at or near its `limit` of 65,536. | The per-subscription per-region private endpoint ceiling is reached. | Perform [Resolution A](#resolution-a). |
| The VNet count is below 1,000 and the regional usage is below 65,536. | Private endpoint count ceiling isn't the problem. | Perform [Step 3](#step-3). |

---

### Step 3

Check whether a newly requested private endpoint connection is sitting in `Pending` on the target resource because of being autoapproved. When a subscription exceeds its auto-approval cap, correctly configured connections aren't rejected or experiencing errors. They simply wait in `Pending` for manual approval. A connection whose state reads `Pending` (not `Approved`) indicates this scenario.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID: " TARGET_RESOURCE_ID

# List the private endpoint connections on the target resource and their approval state.
az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[].{connection:name, state:properties.privateLinkServiceConnectionState.status, description:properties.privateLinkServiceConnectionState.description}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| One or more connections with the `state` value as `Pending` (the `description` field carries the requester's request message, which is often empty and there's no system-generated **auto-approval cap** text. The `Pending` value is the indicator). | The connection is awaiting manual approval. This is consistent with the subscription auto-approval cap being reached. | Perform [Resolution B](#resolution-b). |
| All connections show the `state` value as `Approved`. | The connection was approved. The auto-approval cap isn't the cause. | Perform [Step 4](#step-4). |
| A connection shows the `state` value as `Rejected`. | The connection was explicitly rejected. This is a denial, not a scale limit problem. Re-request the connection or contact the resource owner. | File an Azure support request and include the correlation ID from [Step 1](#step-1). |


### Step 4

Check whether every front-end IP configuration on the load balancer is already bound to an existing Private Link Service that leaves no free front-end IP for a new one. Because only one Private Link Service is allowed per load balancer front-end IP, a second Private Link Service can be created only against a front-end IP that no existing Private Link Service references. A load balancer whose every front-end IP is already consumed by a Private Link Service is the indicator.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

# 1. Frontend IP configurations that exist on the load balancer.
echo "── Frontend IP configs on '$LB_NAME' ──"
az network lb frontend-ip list \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{frontend:name, id:id}" \
  --output json

# 2. Frontend IP config IDs already consumed by existing Private Link Services in this RG.
echo "── Frontend IP configs already bound to a Private Link Service ──"
az network private-link-service list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{pls:name, boundFrontendIpConfigs:loadBalancerFrontendIpConfigurations[].id}" \
  --output json
```

### Interpret the results

Compare the front-end IP configuration IDs from list 1 against the IDs in `boundFrontendIpConfigs` from list 2.

| Observation | Meaning | Next steps |
|---|---|---|
| Every front-end IP configuration ID on the load balancer also appears in an existing Private Link Service `boundFrontendIpConfigs` value (there's no free front-end IP). | All front-end IPs are consumed. A new Private Link Service has no front-end IP to bind to. | Perform [Resolution C](#resolution-c). |
| At least one front-end IP configuration ID isn't referenced by any existing Private Link Service. | A free front-end IP exists. The one-Private Link Service-per-frontend-IP limit isn't the cause. Bind the new Private Link Service to the free front-end IP and re-run [Step 1](#step-1). | File an Azure support request if the create operation still fails with the free front-end IP. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Root cause | Next actions |
|---|---|---|
| [Step 2](#step-2) shows the VNet private endpoint count as greater than 1,000 with High-Scale not registered, or regional usage near 65,536. | The private endpoint count ceiling is reached. | Perform [Resolution A](#resolution-a). |
| [Step 3](#step-3) shows a private endpoint connection in a `Pending` state (not `Approved`). | The auto-approval cap is exceeded. | Perform [Resolution B](#resolution-b). |
| [Step 4](#step-4) shows every load balancer front-end IP already bound to a Private Link Service. | The one Private Link Service per front-end IP limit is reached. | Perform [Resolution C](#resolution-c). |
| All steps are successful, but the operation still fails. | None of the three known scale limits are to blame. | File an Azure support request with the correlation ID from [Step 1](#step-1). |

## Resolution A

The target virtual network reached its default ceiling of 1,000 private endpoints or the subscription is at its **65,536** private-endpoints-per-region ceiling. A new private endpoint create operation then fails with a limit or quota error. The fix is to raise the applicable ceiling. Enable **High-Scale Private Endpoints** to lift the per-VNet ceiling toward the regional maximum, or submit a limit-increase support request for the per-subscription per-region ceiling.

1. Verify which ceiling you reach. Reread the counts from [Step 2](#step-2) against the fixed ceilings: 1,000 per virtual network (default) and 65,536 per region per subscription.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$REGION" ] && read -rp "Region (e.g. eastus): " REGION

echo "── Private endpoints in VNet '$VNET_NAME' (ceiling 1,000) ──"
az network private-endpoint list \
  --subscription "$SUBSCRIPTION" \
  --query "length([?contains(subnet.id, '/virtualNetworks/$VNET_NAME/')])" \
  --output tsv

echo "── Regional Private Endpoints usage (ceiling 65,536) ──"
az network list-usages \
  --location "$REGION" \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(name.value, 'PrivateEndpoint')].{name:name.localizedValue, current:currentValue, limit:limit}" \
  --output json
```

- If the `VNet count` is at the 1,000 ceiling, continue to step 2 to enable the High-Scale Private Endpoints feature.
- If the `regional usage` is at the 65,536 ceiling, skip to step 3 to submit a limit-increase request (the High-Scale Private Endpoints feature doesn't raise the regional ceiling).

2. Register the High-Scale Private Endpoints feature and then reregister the provider.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Registering the High-Scale Private Endpoints feature is a subscription-level change. It is idempotent, but requires `Microsoft.Network/register/action` permissions (for example, `Contributor` at the subscription scope). Feature registration can take several minutes to move from `Registering` to `Registered`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az feature register \
  --namespace Microsoft.Network \
  --name EnableMaxPrivateEndpointsVia64kPath \
  --subscription "$SUBSCRIPTION" \
  --verbose

# Re-register the provider so the feature flag takes effect.
az provider register \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --wait \
  --verbose
```

Verify that the feature is `Registered` before you retry:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az feature show \
  --namespace Microsoft.Network \
  --name EnableMaxPrivateEndpointsVia64kPath \
  --subscription "$SUBSCRIPTION" \
  --query "properties.state" \
  --output tsv
```

Repeat until the state reads `Registered`.

3. If you reach the per-subscription per-region ceiling (65,536), or the High-Scale Private Endpoints feature doesn't apply to your scenario, submit a limit-increase support request.

The [Azure portal](https://portal.azure.com) is the supported route as there's no Private Link quota type in the `az support` CLI extension and that extension isn't installed by default. 

a. In the Azure portal, go to **Help + support** > **Create a support request**.
b. Specify the issue type as **Service and subscription limits (quotas)**. 
c. Select the **Private Link** or private endpoint quota, and include the regional `current`and `limit` values from step 1 and the `x-ms-correlation-request-id` from [Step 1](#step-1).

4. After the feature is `Registered` (per-VNet) or the support request is fulfilled (per-region), rerun [Step 2](#step-2) to verify headroom and then rerun [Step 1](#step-1) to re-create the private endpoint. It should reach the `provisioningState: Succeeded` state.

## Resolution B

The subscription is at or over its auto-approval cap. Therefore, a correctly configured new private endpoint connection isn't autoapproved and stays in a `Pending` state. The connection isn't failed or rejected. It simply needs manual approval. The fix is to approve the pending connection on the target resource.

1. Identify the pending connection name on the target resource. Use the `TARGET_RESOURCE_ID` from [Step 3](#step-3).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID: " TARGET_RESOURCE_ID

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[?properties.privateLinkServiceConnectionState.status=='Pending'].{connection:name, id:id}" \
  --output json
```

Record the `connection` name (and full `ID`) of the pending connection that you want to approve.

2. Approve the pending connection. Use the full connection resource `ID` from step 1.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$PEC_ID" ] && read -rp "Pending connection ID (from B.1): " PEC_ID

az network private-endpoint-connection approve \
  --id "$PEC_ID" \
  --description "Approved beyond auto-approval cap" \
  --verbose
```
3. Verify that the connection is now `Approved`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$TARGET_RESOURCE_ID" ] && read -rp "Target Resource ID: " TARGET_RESOURCE_ID

az network private-endpoint-connection list \
  --id "$TARGET_RESOURCE_ID" \
  --query "[].{connection:name, state:properties.privateLinkServiceConnectionState.status}" \
  --output json
```

The connection should now read `Approved`. If new connections keep landing in a `Pending` state, manual approval remains required for each one until the auto-approval cap is raised. Submit a limit-increase request as in [Resolution A](#resolution-a), step 3, and select the Private Link autoapproval quota.

## Resolution C

Only one Private Link Service is allowed per load balancer front-end IP configuration. Every front-end IP on the load balancer is already bound to an existing Private Link Service. Therefore, a second Private Link Service has no front-end IP to attach to, and the create operation fails. The fix is to add an additional front-end IP configuration to the load balancer, and bind the new Private Link Service to that distinct front-end IP.

1. Verify that there is no free front-end IP. Reread the two lists from [Step 4](#step-4). Every front-end IP configuration ID on the load balancer should also appear in an existing Private Link Service's bound configurations.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

echo "── Frontend IP configs on the load balancer ──"
az network lb frontend-ip list \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{frontend:name, id:id}" \
  --output json

echo "── Frontend IP configs already bound to a Private Link Service ──"
az network private-link-service list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{pls:name, boundFrontendIpConfigs:loadBalancerFrontendIpConfigurations[].id}" \
  --output json
```

2. Add a new front-end IP configuration to the load balancer.

 [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. It adds a new front-end IP configuration to the standard load balancer. Select a private IP in the load balancer's subnet that isn't already in use, or attach an existing public IP. Adding a front-end IP doesn't affect existing front-ends or workloads.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$NEW_FE_NAME" ] && read -rp "New Frontend IP config name: " NEW_FE_NAME
[ -z "$LB_VNET_NAME" ] && read -rp "LB VNet Name:       " LB_VNET_NAME
[ -z "$LB_SUBNET_NAME" ] && read -rp "LB Subnet Name:     " LB_SUBNET_NAME
[ -z "$NEW_FE_IP" ] && read -rp "New Frontend private IP (e.g. 10.0.1.10): " NEW_FE_IP

az network lb frontend-ip create \
  --name "$NEW_FE_NAME" \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$LB_VNET_NAME" \
  --subnet "$LB_SUBNET_NAME" \
  --private-ip-address "$NEW_FE_IP" \
  --verbose
```

3. Create the new Private Link Service that's bound to the new front-end IP.

 [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. They create the Private Link Service that's bound to the distinct front-end IP that's added in step 2. The Network Address Translation (NAT) subnet must have `privateLinkServiceNetworkPolicies` disabled.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$PLS_NAME" ] && read -rp "New Private Link Service Name: " PLS_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:              " VNET_NAME
[ -z "$PLS_SUBNET_NAME" ] && read -rp "PLS NAT Subnet Name:    " PLS_SUBNET_NAME
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name:     " LB_NAME
[ -z "$NEW_FE_NAME" ] && read -rp "New Frontend IP config name (from C.2): " NEW_FE_NAME

az network private-link-service create \
  --name "$PLS_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$PLS_SUBNET_NAME" \
  --lb-name "$LB_NAME" \
  --lb-frontend-ip-configs "$NEW_FE_NAME" \
  --verbose
```

4. Verify that the new Private Link Service is created and is bound to the new front-end IP.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$PLS_NAME" ] && read -rp "New Private Link Service Name: " PLS_NAME

az network private-link-service show \
  --name "$PLS_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, boundFrontendIpConfigs:loadBalancerFrontendIpConfigurations[].id}" \
  --output json
```

The `provisioningState` value should read `Succeeded`, and `boundFrontendIpConfigs` should reference the new front-end IP from step 2.

## References

- [Manage private endpoints in Azure Private Link](/azure/private-link/manage-private-endpoint)
- [What is Azure Private Link service?](/azure/private-link/private-link-service-overview)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits)
- [Azure Private Link limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#private-link-limits)
- [What is Azure Private Link?](/azure/private-link/private-link-overview)
