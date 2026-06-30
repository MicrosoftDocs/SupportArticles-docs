---
title: Troubleshoot an Azure Load Balancer that can't be deleted 
description: Find why an Azure Load Balancer or its resource group can't be deleted, then follow these steps to remove blockers and complete the deletion.
ms.service: azure-load-balancer
ms.topic: troubleshooting
ms.custom: sap:Management
ms.date: 6/17/2026
ai.hint.symptom-tags:
  - cannot-delete-load-balancer
  - delete-failed
  - resource-in-use
  - dependent-resources
  - deny-assignment
  - resource-lock
  - scope-locked
  - policy-deny
  - managed-load-balancer
  - aks-load-balancer
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/loadBalancers/read
  - Microsoft.Network/loadBalancers/delete
  - Microsoft.Network/privateLinkServices/read
  - Microsoft.Authorization/locks/read
  - Microsoft.Authorization/locks/delete
  - Microsoft.Authorization/denyAssignments/read
  - Microsoft.Authorization/policyAssignments/read
  - Microsoft.Authorization/policyExemptions/write
  - Microsoft.Insights/eventtypes/values/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
---

# Troubleshoot an Azure Load Balancer that can't be deleted

## Summary

This article helps you troubleshoot why you can't delete an Azure Load Balancer or the resource group that contains it. 

You usually can't delete an Azure Load Balancer or the resource group that contains it for one of these reasons: 

- Dependent resources still reference the Load Balancer, so you must remove them first. These resources include an Azure Private Link service, a backend-pool network interface card (NIC) association, outbound rules, load-balancing or inbound-Network Address Translation (NAT) rules, or probes. 
- A deny assignment blocks the delete because the Load Balancer is platform-managed (created by Azure Kubernetes Service (AKS), Azure Container Apps, or another managed service) or left behind by a failed resource move. 
- An Azure resource lock or Azure Policy with a deny effect that prevents deletion. 

## Symptoms

You might experience one or more of the following symptoms:

- Deleting a Load Balancer in the [Azure portal](https://portal.azure.com), with a command line interface (CLI) tool, or as part of a resource group delete returns a failure and the resource remains.
- CLI returns an error like `Cannot delete resource ... because it is in use` or `InUseLoadBalancerCannotBeDeleted`.
- CLI returns `CannotDeleteLoadBalancerWithPrivateLinkService` with a message like `...since it is referenced by private link service ... Please delete private link service prior to deleting load balancer`.
- CLI returns `ScopeLocked` with a message like `The scope '...' cannot perform delete operation because following scope(s) are locked`.
- CLI returns `RequestDisallowedByPolicy` naming an Azure Policy assignment.
- CLI returns an authorization error stating the action is blocked **because of a deny assignment**.
- A resource group delete fails and the only resource that won't delete is the Load Balancer.
- The Load Balancer lives in a node resource group named `MC_*` (AKS) or is owned by another managed service.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required:** `Network Contributor` role on the Load Balancer's resource group to remove dependencies and the Load Balancer, `User Access Administrator` or `Owner` permissions to remove a resource lock or create a policy exemption, or reader access to the Activity Log to inspect deny assignments.
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the Load Balancer | `myResourceGroup` |
| `{RESOURCE_NAME}` | Load Balancer resource name | `myLoadBalancer` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

The problem is identified by running four independent read-only checks in this priority order: resource lock, then Azure Policy, then deny assignment, then dependent resources. Control-plane blockers (like lock, policy, deny assignment) prevent the delete regardless of dependencies, so the process checks them first. Try to fix the first blocker found.

### Step 1

Check the exact error code returned by the failed delete. The error code is the primary signal that tells you which blocker you're facing. If you already have the error text from the Azure portal or a previous CLI or Terraform run, use it here. Otherwise, the read-only checks in [Step 2](#step-2)-[Step 5](#step-5) confirm the blocker without re-running the delete operation.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

# Read-only: confirm the Load Balancer still exists and capture its ID for later steps.
az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{id:id, provisioningState:provisioningState}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Delete error code `ScopeLocked` or the message `scope(s) are locked`. | A resource lock blocks deletion. | Perform [Step 2](#step-2). |
| Delete error code `RequestDisallowedByPolicy`. | An Azure Policy deny effect blocks deletion. | Perform [Step 3](#step-3). |
| Delete error mentions `deny assignment` (for example, `...does not have authorization...because of a deny assignment`). | A deny assignment blocks deletion. | Perform [Step 4](#step-4). |
| Delete error like `InUseLoadBalancerCannotBeDeleted`, `CannotDeleteLoadBalancerWithPrivateLinkService` (with the message `...referenced by private link service ... Please delete private link service prior to deleting load balancer`), or `Cannot delete resource ... in use`. | Dependent resources still reference the Load Balancer | Perform [Step 5](#step-5). |
| You don't have the error text, or it's unclear. | Run the following read-only checks in [Step 2](#step-2)-[Step 5](#step-5) in order to find the blocker | Perform [Step 2](#step-2). |
| `ResourceNotFound` | The Load Balancer is already deleted. | No action needed. |

> [!NOTE]
> Even if you have an error code from the preceding list, complete the matching read-only checks in [Step 2](#step-2)-[Step 5](#step-5) to confirm the blocker before making any changes.

### Step 2

Check whether a management lock (`CanNotDelete` or `ReadOnly`) exists on the Load Balancer, its resource group, or an inherited parent scope. Locks are inherited downward, so a lock on the resource group or subscription can block deletion.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

echo "── Locks on the Load Balancer resource ──"
az lock list \
  --resource "$RESOURCE_NAME" \
  --resource-type "Microsoft.Network/loadBalancers" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, level:level, notes:notes}" \
  --output json

echo "── Locks inherited from the resource group ──"
az lock list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, level:level, notes:notes}" \
  --output json

echo "── Locks inherited from the subscription ──"
az lock list \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, level:level, notes:notes}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Any lock with `"level": "CanNotDelete"` or `"level": "ReadOnly"` at any previously listed scope. | A lock blocks deletion. This is the blocker. | Perform [Resolution C](#resolution-c). |
| All three lists return `[]` (no locks). | Locks aren't the blocker. | Perform [Step 3](#step-3). |

### Step 3

Check whether an Azure Policy assignment with a `deny` effect at the resource group, subscription, or an inherited management-group scope is blocking the delete operation. A policy that blocks a delete operation returns `RequestDisallowedByPolicy` and names the policy assignment and definition.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG

# List policy assignments that apply to this resource group, including those
# inherited from the subscription and parent management groups.
az policy assignment list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --disable-scope-strict-match \
  --query "[].{name:name, displayName:displayName, policyDefinitionId:policyDefinitionId, scope:scope}" \
  --output json
```

If your delete error is `RequestDisallowedByPolicy`, the error text contains the policy assignment name and policy definition ID that blocked it. Match that name against the previous list. The error names the exact assignment and this list confirms its scope.

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| The delete error was `RequestDisallowedByPolicy` and the named assignment appears in this list. | An Azure Policy `deny` effect is the blocker. | Perform [Resolution D](#resolution-d). |
| No `RequestDisallowedByPolicy` error and no relevant `deny` policy applies. | Azure Policy isn't the blocker. | Perform [Step 4](#step-4). |

### Step 4

Check whether a deny assignment blocks the delete. Azure-managed services create deny assignments, such as AKS and Container Apps, to protect resources they own. A failed or partial resource move can leave behind a deny assignment. Unlike role assignments, you can't override a deny assignment by granting yourself a role. You must remove the source.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG

# Deny assignments have no dedicated 'az' command; query the ARM API directly.
az rest \
  --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Authorization/denyAssignments?api-version=2022-04-01" \
  --query "value[].{name:properties.denyAssignmentName, isSystemProtected:properties.isSystemProtected, principals:properties.principals[].displayName, excludePrincipals:properties.excludePrincipals[].displayName, actions:properties.permissions[].actions}" \
  --output json
```

### Interpret the result

| If you see... | Meaning | Next steps |
|---|---|---|
| One or more entries where `isSystemProtected` is `true` and `actions` includes `*`, `*/delete`, or `Microsoft.Network/loadBalancers/delete`. | A platform-managed deny assignment owns this Load Balancer. | Perform [Resolution B](#resolution-b). |
| A deny assignment that doesn't name a system principal (likely left over from a failed move). | A stale deny assignment is the blocker. | Perform [Resolution B](#resolution-b). |
| `value` is empty (`[]`). | Deny assignments aren't the blocker. | Perform [Step 5](#step-5). |
| `AuthorizationFailed` on the query itself. | You don't have `Microsoft.Authorization/denyAssignments/read` permissions. Request them. | Re-run the step after permissions are granted. |

### Step 5

Check which dependent resources still reference the Load Balancer. A Load Balancer can't be deleted while a Private Link service, an outbound rule, a load-balancing or inbound-NAT rule, a probe, or a backend-pool NIC association still points to it. This step enumerates all of them so you know exactly what to remove and in what order.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

echo "── Load Balancer rule, probe, and backend-pool inventory ──"
az network lb show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{outboundRules:outboundRules[].name, loadBalancingRules:loadBalancingRules[].name, inboundNatRules:inboundNatRules[].name, probes:probes[].name, backendPools:backendAddressPools[].name, backendNicAssociations:backendAddressPools[].loadBalancerBackendAddresses[].networkInterfaceIPConfiguration.id, backendIpConfigCount:length(backendAddressPools[0].backendIPConfigurations || [])}" \
  --output json

echo "── Private Link Services that front-end this Load Balancer ──"
az network private-link-service list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(to_string(loadBalancerFrontendIpConfigurations), '$RESOURCE_NAME')].{name:name, fipConfigs:loadBalancerFrontendIpConfigurations[].id}" \
  --output json
```

### Interpret the results

Record every non-empty list. These are the dependencies you must remove and the order they are fixed (the Private Link service first and Load Balancer last).

| If you see... | Meaning | Next steps |
|---|---|---|
| One or more Private Link services, rules, probes, or backend NIC associations listed. | These dependencies block the delete operation. | Perform [Resolution A](#resolution-a). |
| All lists empty and `backendIpConfigCount` is `0`, but [Step 2](#step-2)-[Step 4](#step-4) found nothing. | No blocker identified. Re-run the delete operation. If it still fails, open an Azure support request. | Go to the [Decision map](#decision-map). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results. Route to the first matching row in this order (control-plane blockers before dependencies).

| Diagnostic result | Next actions |
|---|---|
| [Step 2](#step-2) found a `CanNotDelete` or `ReadOnly` lock. | Perform [Resolution C](#resolution-c). |
| [Step 3](#step-3) found a blocking Azure Policy (`RequestDisallowedByPolicy`). | Perform [Resolution D](#resolution-d). |
| [Step 4](#step-4) found a deny assignment (system-protected or stale). | Perform [Resolution B](#resolution-b). |
| [Step 5](#step-5) found a Private Link Service, rules, probes, or backend NIC associations. | Perform [Resolution A](#resolution-a). |
| There's no lock, no policy, no deny assignment, or dependency, but the delete operation still fails. | Open an Azure support request. |

## Resolution A

Dependent resources still reference the Load Balancer. Azure refuses the delete until you remove every reference. Remove the references in this dependency order: **Private Link service > outbound rules > load-balancing > inbound-NAT rules > probes > backend pool (NIC associations) > Load Balancer.**

Run the following commands in Azure CLI.

1. Re-run the inventory from [Step 5](#step-5) and record every Private Link service, rule, probe, backend pool, and backend NIC association name. You reference these names in the following steps. Don't proceed until you have the full list.

2. Delete each Private Link service that front-ends this Load Balancer. A Private Link service holds the strongest reference, so remove it first.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. Deleting a Private Link service disconnects any private endpoints consuming it.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
read -rp "Private Link Service Name (from A.1): " PLS_NAME

az network private-link-service delete \
  --name "$PLS_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

Repeat for each Private Link service listed in step 1.

3. Delete each outbound rule.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
read -rp "Outbound Rule Name (from A.1): " OUTBOUND_RULE_NAME

az network lb outbound-rule delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$OUTBOUND_RULE_NAME"
```

Repeat for each outbound rule listed in step 1.

4. Delete each load-balancing rule and each inbound-NAT rule.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
read -rp "Load-balancing Rule Name (from A.1): " LB_RULE_NAME

az network lb rule delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$LB_RULE_NAME"
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
read -rp "Inbound NAT Rule Name (from A.1): " NAT_RULE_NAME

az network lb inbound-nat-rule delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$NAT_RULE_NAME"
```

Repeat each command for every rule listed in step 1.

5. Delete each probe.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
read -rp "Probe Name (from A.1): " PROBE_NAME

az network lb probe delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$PROBE_NAME"
```

Repeat for each probe listed in step 1.

6. Remove every NIC association from the backend pool, then delete the backend pool. The backend NIC association IDs are captured in step 1 as `backendNicAssociations` (or as `backendIPConfigCount` on a classic pool). Each ID has the form `.../networkInterfaces/<nicName>/ipConfigurations/<ipConfigName>`.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name (from A.1): " BACKEND_POOL_NAME
read -rp "NIC Name (from a backend association ID): " NIC_NAME
read -rp "IP Config Name (from the same ID):        " IP_CONFIG_NAME

az network nic ip-config address-pool remove \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --nic-name "$NIC_NAME" \
  --ip-config-name "$IP_CONFIG_NAME" \
  --lb-name "$RESOURCE_NAME" \
  --address-pool "$BACKEND_POOL_NAME"
```

Repeat for every NIC association ID from step 1. Once the pool has no members, delete it:

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name (from A.1): " BACKEND_POOL_NAME

az network lb address-pool delete \
  --lb-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_POOL_NAME"
```

7. With every dependency removed, delete the Load Balancer.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME

az network lb delete \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

8. Re-run [Step 1](#step-1). A successful delete operation returns a `ResourceNotFound` value for the Load Balancer. If the delete still fails with an in-use error, re-run [Step 5](#step-5) as a dependency was missed. Remove it and repeat step 7.

## Resolution B

A deny assignment owns the Load Balancer. This ownership is normal for a Load Balancer that a platform service creates and manages. For example, AKS or Container Apps creates a system-protected deny assignment so customers can't delete resources out from under it. An Azure deployment stack with a `denyDelete` or `denyWriteAndDelete` deny setting, or an Azure managed application (the deny assignment protects the managed resource group) also owns the Load Balancer. A stale deny assignment left by a failed resource move can also own the Load Balancer. You can't delete the Load Balancer directly. You must remove the source of the deny assignment. The deny-assignment name returned by [Step 4](#step-4) usually names that source directly (for example `created by Deployment Stack ...` or `created by managed application ...`).

Run the following commands in Azure CLI.

1. Identify the source. Inspect the deny assignment principals from [Step 4](#step-4), and then check the Activity Log for the operation that created the resource or deny assignment.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG

az monitor activity-log list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --offset 30d \
  --query "[?contains(to_string(authorization.action), 'loadBalancers') || contains(to_string(operationName.value), 'denyAssignment')].{time:eventTimestamp, caller:caller, op:operationName.localizedValue, status:status.value}" \
  --output json
```

Determine which managed service owns the Load Balancer:

- A node resource group named `MC_<rg>_<cluster>_<region>` and a caller identity for AKS indicate an AKS-managed Load Balancer.
- A `Microsoft.App` caller indicates a Container Apps-managed Load Balancer.
- A non-service principal with a `Failed` move operation indicates a stale deny assignment from a partial resource move.

2. Locate the parent managed resource that owns the Load Balancer. For an AKS-managed Load Balancer, the cluster is the owner and the Load Balancer lives in the cluster's node resource group.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION

# Find AKS clusters whose node resource group matches the LB's resource group.
[ -z "$RG" ] && read -rp "Load Balancer Resource Group: " RG

az aks list \
  --subscription "$SUBSCRIPTION" \
  --query "[?nodeResourceGroup=='$RG'].{cluster:name, clusterResourceGroup:resourceGroup, nodeResourceGroup:nodeResourceGroup}" \
  --output json
```

| If you see... | Meaning | Next steps |
|---|---|---|
| A cluster is returned. | The Load Balancer is AKS-managed. Delete the cluster, not the Load Balancer. | Go to step 3. |
| No cluster, but [Step 4](#step-4) showed a `Microsoft.App` principal. | The Load Balancer is Container Apps-managed. Delete the Container Apps environment that owns it. | Decommission the Container Apps environment and then re-run [Step 1](#step-1). |
| No cluster, but the [Step 4](#step-4) deny assignment name reads `created by Deployment Stack ...` or `created by managed application ...`. | The Load Balancer is owned by an Azure deployment stack or managed application. | Decommission the owner (like `az stack group delete --name <stack> --resource-group <rg> --action-on-unmanage deleteAll --yes` or `az managedapp delete --name <app> --resource-group <rg>`) and then re-run [Step 1](#step-1). |
| No cluster and the deny assignment is stale (failed move). | Open an Azure support request to remove the orphaned deny assignment. You can't remove it yourself. | Open an Azure support request. |

3. Decommission the owning AKS cluster. Deleting the cluster removes the deny assignment and the platform-managed Load Balancer together.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This action deletes the entire AKS cluster and all workloads running on it. Confirm the cluster is safe to remove before running.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
read -rp "Cluster Resource Group (from B.2): " CLUSTER_RG
read -rp "AKS Cluster Name (from B.2):       " CLUSTER_NAME

az aks delete \
  --name "$CLUSTER_NAME" \
  --resource-group "$CLUSTER_RG" \
  --subscription "$SUBSCRIPTION" \
  --yes
```

4. Re-run [Step 1](#step-1). The Load Balancer should now return `ResourceNotFound`. If a deny assignment remains after the parent service is gone, it's orphaned. Open an Azure support request to have it removed.

## Resolution C

A management lock (`CanNotDelete` or `ReadOnly`) on the Load Balancer, its resource group, or an inherited parent scope blocks the delete operation. You must remove the lock before the delete operation can proceed.

Run the following commands in Azure CLI.

1. Confirm the lock scope and name from [Step 2](#step-2). Note whether the lock is on the Load Balancer, the resource group, or the subscription. You must delete it at the scope where you defined it.

2. Delete the lock. Use the scope that [Step 2](#step-2) reported the lock on.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Removing a lock also removes protection from every resource under that scope. Re-create the lock after the delete if it's still needed elsewhere.

For a lock on the **Load Balancer resource**:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Load Balancer Name: " RESOURCE_NAME
[ -z "$LOCK_NAME" ] && read -rp "Lock Name (from Step 2): " LOCK_NAME

az lock delete \
  --name "$LOCK_NAME" \
  --resource "$RESOURCE_NAME" \
  --resource-type "Microsoft.Network/loadBalancers" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

For a lock on the **resource group**:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$LOCK_NAME" ] && read -rp "Lock Name (from Step 2): " LOCK_NAME

az lock delete \
  --name "$LOCK_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

For a lock on the **subscription**:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$LOCK_NAME" ] && read -rp "Lock Name (from Step 2): " LOCK_NAME

az lock delete \
  --name "$LOCK_NAME" \
  --subscription "$SUBSCRIPTION"
```

3. Re-run [Step 2](#step-2) to confirm no locks remain, and then retry the delete operation from [Step 1](#step-1). If the delete operation now fails with a different error, return to the [Decision map](#decision-map) and determine your best course. A lock can mask a dependency that surfaces only after the lock is removed.

## Resolution D

An Azure Policy assignment with a `deny` effect (possibly inherited from a parent management group) is blocking the delete operation. Resolve it by adding a policy exemption for the resource group (or the specific resource), or by adjusting the assignment if you own it.

Run the following commands in Azure CLI.

1. Confirm the blocking assignment from [Step 3](#step-3). You need the policy assignment ID (or its full resource ID). Capture it in the following commands:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
read -rp "Policy Assignment Name (from Step 3 / error): " POLICY_ASSIGNMENT_NAME

az policy assignment show \
  --name "$POLICY_ASSIGNMENT_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{id:id, scope:scope, policyDefinitionId:policyDefinitionId}" \
  --output json
```

If the assignment is scoped to a management group, the error message and the `scope` field show the management-group path. Capture the full assignment ID for the exemption.

2. Create a policy exemption for the resource group so the delete operation is allowed. Use the assignment ID from step 1.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. A `Waiver` exemption suppresses the policy for the exempted scope. Scope it as narrowly as possible (resource group, not subscription) and remove it after the delete if the policy must continue to apply.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
read -rp "Policy Assignment ID (from D.1): " POLICY_ASSIGNMENT_ID
[ -z "$EXEMPTION_NAME" ] && read -rp "Exemption Name:     " EXEMPTION_NAME

az policy exemption create \
  --name "$EXEMPTION_NAME" \
  --policy-assignment "$POLICY_ASSIGNMENT_ID" \
  --exemption-category "Waiver" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

3. Retry the delete from [Step 1](#step-1). If the delete operation now fails with a different error, return to the [Decision map](#decision-map) and determine your best course. If `RequestDisallowedByPolicy` persists, the blocking assignment is at a higher scope than your exemption. Re-run [Step 3](#step-3), identify the parent (management-group) assignment, and exempt at the correct scope or ask the policy owner to adjust it.

## References

- [Manage Azure Load Balancer resources](/azure/load-balancer/manage)
- [Lock your resources to protect your infrastructure](/azure/azure-resource-manager/management/lock-resources)
- [Understand Azure deny assignments](/azure/role-based-access-control/deny-assignments)
- [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure)
- [Delete an AKS cluster and its node resource group](/azure/aks/concepts-clusters-workloads)
