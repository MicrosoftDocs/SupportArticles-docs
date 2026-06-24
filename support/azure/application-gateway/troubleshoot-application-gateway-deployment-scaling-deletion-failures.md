---
title: Troubleshoot Application Gateway deployment, scaling, and deletion failures
description: Diagnose and resolve Azure Application Gateway deployment, scaling, and deletion failures by using step-by-step guidance for RBAC, locks, subnet, and Key Vault issues.
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.custom: sap:Issues with Create, Update and Delete (CRUD)
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - deployment-failed
  - provisioning-error
  - scaling-failed
  - deletion-stuck
  - resource-lock
  - rbac-permission-denied
  - subnet-misconfiguration
  - orphaned-reference
  - key-vault-access-denied
  - operation-not-allowed
  - scope-locked
  - updating-stuck
  - autoscaling-capacity
  - autoscaling-unexpected-scale
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/applicationGateways/read
  - Microsoft.Network/applicationGateways/write
  - Microsoft.Network/virtualNetworks/subnets/read
  - Microsoft.Network/virtualNetworks/subnets/join/action
  - Microsoft.Authorization/roleAssignments/read
  - Microsoft.Authorization/locks/read
  - Microsoft.Resources/deployments/read
  - Microsoft.Resources/deployments/operationStatuses/read
  - Microsoft.KeyVault/vaults/read
  - Microsoft.ManagedIdentity/userAssignedIdentities/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - VNET_NAME
  - SUBNET_NAME
---

# Troubleshoot Application Gateway deployment, scaling, and deletion failures

## Summary 

This article provides step-by-step guidance to diagnose and resolve failures that occur when you deploy, scale, or delete Azure Application Gateway. 

Application Gateway deployment, scaling, and deletion operations might fail for several reasons, including: 

- The deploying identity lacks required role-based access control (RBAC) permissions. 
- The resource locks block lifecycle operations. 
- The Application Gateway subnet is misconfigured (wrong size, conflicting delegations, or a universal user-defined route (UDR) as the default route that doesn't point to the internet). 
- Orphaned configuration references exist and prevent scaling or deletion. 
- Azure Key Vault certificate access is denied. 


## Symptoms

You might encounter one or more of the following symptoms:

- Azure Resource Manager (ARM) deployment fails and returns `"code": "AuthorizationFailed"` and the following message: 

   > `The client '{OBJECT_ID}' with object id '{OBJECT_ID}' doesn't have authorization to perform 'Microsoft.Network/applicationGateways/write' over scope '/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.Network/applicationGateways/{RESOURCE_NAME}'`.
- Deployment or deletion fails and returns `"code": "ScopeLocked"` and the following message:

   > `The scope '/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}' or a parent scope has a delete lock. Remove the lock before performing the delete operation.`.
- Deployment or update fails amd returns `"code": "OperationNotAllowed"` and a message that references a locked resource.
- The provisioning state is stuck at `Updating` or `Failed`, and the gateway is unresponsive to further configuration changes.
- Deployment fails and returns `"code": "SubnetTooSmall"` or the following message:

   > `Application Gateway V2 requires a subnet of at least /24 size`.
- Deployment fails and returns `"code": "InvalidSubnet"` and the following message:

   > `Subnet '{SUBNET_NAME}' is delegated to a different service and can't be used by Application Gateway`.
- Deployment fails and returns `"code": "ApplicationGatewaySubnetCannotHaveOtherResourceTypes"`, and other resources (such as virtual machines (VMs) and private endpoints) exist in the Application Gateway subnet.
- Deployment or network security group (NSG) attach fails and returns `"code": "ApplicationGatewaySubnetInboundTrafficBlockedByNetworkSecurityGroup"` and the following message:

   > `Network security group ... blocks incoming internet traffic on ports 65200 - 65535 ... This isn't permitted for Application Gateways that have V2 Sku.`.
- Scaling or deletion fails and returns `"code": "InternalServerError"` and details that reference an orphaned path-map rule, back-end pool, or HTTP settings that reference a deleted resource.
- Deployment fails and returns the following message:

   > `The default route in the Application Gateway subnet must have a next hop type of 'Internet'`.
- Deployment or update fails and returns `"code": "LinkedAccessCheckFailed"` and the following message that references Key Vault:

   > `The user, group, or application... doesn't have secrets get permission on key vault...`.
- Deployment fails and returns `"code": "ApplicationGatewayKeyVaultSecretException"` and the following message:

   > `Unable to retrieve certificate '{CERT_NAME}' from Key Vault '{VAULT_NAME}'`.
- Deletion appears to stop responding, and the [Azure portal](https://portal.azure.com) shows a deletion in progress for more than 30 minutes.
- `az network application-gateway show` returns `"provisioningState": "Failed"` without a clear error message.
- Deployment fails and returns `"code": "ResourceProviderNotRegistered"` and the following message:

   > `The subscription isn't registered to use namespace 'Microsoft.Network'`.
- Application Gateway autoscales to many more instances than expected. This problem causes cost spikes or capacity concerns. No deployment error occurs. However, unexpected scaling behavior occurs.

## Prerequisites

To troubleshoot Application Gateway deployment, scaling, and deletion failures, you need the following items:

- **Permissions required:** `Contributor` role on the resource group (or `Owner` role for RBAC assignment operations), `Network Contributor` role for subnet operations.
- **Tools:** Azure CLI 2._x_, or an AI agent that has Azure MCP access
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing (or targeted for) the Application Gateway | `myResourceGroup` |
| `{RESOURCE_NAME}` | Application Gateway resource name (existing or desired) | `myAppGateway` |
| `{VNET_NAME}` | Virtual network containing the Application Gateway subnet | `myVNet` |
| `{SUBNET_NAME}` | Subnet dedicated to the Application Gateway | `appgw-subnet` |

> [!TIP]
> Verify all variables before you run any commands. If the Application Gateway doesn't yet exist (such as for a new deployment failure), `{RESOURCE_NAME}` is the name from the failed deployment template. If `{VNET_NAME}` or `{SUBNET_NAME}` are unknown, you can discover them in [Step 4a](#step-4a).

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the deployment succeeded, failed, or is stuck. Also, check the specific error code and message from the ARM deployment operation.

Run the following commands in Azure CLI:

**Option 1: Application Gateway already exists (update, scale, or delete failures)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, operationalState:operationalState, sku:sku, autoscale:autoscaleConfiguration}" \
  --output json
```

> [!IMPORTANT]
> **Capture the failed lifecycle operation's error code**. The previous commands report the gateway's current state only. They don't expose the error code that's returned by a failed delete or update operation. Record the exact error code from the operation that failed. A delete or update operation that you issue by using Azure CLI sends the error code directly in the terminal (for example, `ScopeLocked` or `OperationNotAllowed`). If the operation was submitted as an ARM deployment, retrieve its error code by using the `az deployment operation group list` command, as shown in the following new-deployment path commands. Match that error code against the interpretation table.

**Option 2: A new deployment that failed**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az deployment group list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?properties.provisioningState=='Failed'].{name:name, timestamp:properties.timestamp, error:properties.error}" \
  --output json
```

To get detailed error information from a specific failed deployment:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$DEPLOYMENT_NAME" ] && read -rp "Deployment Name: " DEPLOYMENT_NAME

az deployment operation group list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$DEPLOYMENT_NAME" \
  --query "[?properties.provisioningState=='Failed'].{resource:properties.targetResource.resourceType, statusCode:properties.statusCode, errorCode:properties.statusMessage.error.code, errorMessage:properties.statusMessage.error.message}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `provisioningState: "Succeeded"` and the reported symptom is no longer occurring. | The gateway is healthy, and the reported issue was transient or already resolved. | Verify that the symptom is gone. If it is, no further action is needed. If the symptom persists, perform [Step 9](#step-9). |
| `provisioningState: "Succeeded"`, and the symptom is unexpectedly autoscaling or you're experiencing a cost or instance-count spike. | A `Succeeded` state doesn't rule out unbounded autoscaling because the `autoscale` bounds returned by this command must be interpreted. | Perform [Step 9](#step-9). |
| `provisioningState: "Failed"`. | The gateway is in a failed state. Check the error details. | Examine the following error codes, and then perform [Step 2](#step-2). |
| `provisioningState: "Updating"` for more than 30 minutes. | The gateway is stuck in a long-running operation. | Wait up to one hour. If it's still updating, file an Azure support request. |
| Error code `AuthorizationFailed`. | The deploying identity lacks required permissions. | Perform [Step 3](#step-3). |
| Error code `ScopeLocked` or `OperationNotAllowed` and a lock reference. | A resource lock is blocking the operation. | Perform [Step 5](#step-5). |
| Error code `SubnetTooSmall` or `InvalidSubnet`. | Subnet configuration issue. | Perform [Step 4a](#step-4a). |
| Error code `ApplicationGatewaySubnetInboundTrafficBlockedByNetworkSecurityGroup`. | An NSG on the Application Gateway subnet blocks the required `GatewayManager` inbound management traffic (ports 65200–65535 for v2). | Perform [Step 4a](#step-4a). |
| Error code `ApplicationGatewaySubnetUserDefinedRouteNotAllowed`. | A UDR on the Application Gateway subnet has a `0.0.0.0/0` route and a next hop type other than `Internet`. | Perform [Step 6](#step-6). |
| Error code `ResourceProviderNotRegistered`. | The `Microsoft.Network` provider isn't registered. | Perform [Step 2](#step-2). |
| Error code `LinkedAccessCheckFailed` or `ApplicationGatewayKeyVaultSecretException`. | A Key Vault access issue exists. | Perform [Step 7](#step-7). |
| Error code `InvalidResourceReference` and a reference to a path map, back-end pool, HTTP settings, or listener. | This mentiuon is an orphaned configuration reference. A configuration element references a resource that was deleted or doesn't exist. | Perform [Step 8](#step-8). |
| Error code `InternalServerError` and a reference to path map, back-end pool, or HTTP settings. | This mention is an orphaned configuration reference (alternative error format). | Perform [Step 8](#step-8). |
| `ResourceNotFound` error. | A subscription, resource group, or gateway name is incorrect. | Verify your variables, and rerun. |

---

### Step 2

Check whether the `Microsoft.Network` resource provider is registered in the subscription. Unregistered providers cause all network resource deployments to fail.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query "{registrationState:registrationState, namespace:namespace}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `"registrationState": "Registered"`. | The provider is registered. | Perform [Step 3](#step-3). |
| `"registrationState": "NotRegistered"` or `"Unregistered"`. | The provider must be registered before any network resources can be deployed. | Perform [Resolution A](#resolution-a). |
| `"registrationState": "Registering"`. | Registration is in progress. Wait 2–5 minutes, and then recheck. | Rerun this step. |

### Step 3

Check whether the identity that performs the deployment (user, service principal, or managed identity) has the required permissions to create or modify Application Gateway resources and join the subnet.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az role assignment list \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG" \
  --subscription "$SUBSCRIPTION" \
  --include-inherited \
  --query "[].{principal:principalName, role:roleDefinitionName, scope:scope}" \
  --output table
```

> [!IMPORTANT]
> The `--include-inherited` flag is required. Without it, the commands return empty for an identity whose Owner or Contributor role is inherited from the subscription (or a management group). This empty result makes a correctly-permissioned identity look unpermissioned and can cause misdiagnosis of the problem. By having the flag, an inherited role is listed as having a `scope` at the subscription (`/subscriptions/{id}`) instead of the resource group.

To check the specific identity that failed, use the `{OBJECT_ID}` from the `AuthorizationFailed` error message:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$OBJECT_ID" ] && read -rp "Identity Object ID: " OBJECT_ID

az role assignment list \
  --assignee "$OBJECT_ID" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG" \
  --subscription "$SUBSCRIPTION" \
  --include-inherited \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table
```

### Required permissions for Application Gateway lifecycle operations

| Operation | Required permissions |
|---|---|
| Create or update Application Gateway | `Microsoft.Network/applicationGateways/write`, `Microsoft.Network/virtualNetworks/subnets/join/action` |
| Delete Application Gateway | `Microsoft.Network/applicationGateways/delete` |
| Read Application Gateway | `Microsoft.Network/applicationGateways/read` |
| Assign public IP | `Microsoft.Network/publicIPAddresses/join/action` |
| Use Key Vault certificates | `Microsoft.KeyVault/vaults/secrets/read` (on the Key Vault), `Microsoft.ManagedIdentity/userAssignedIdentities/assign/action` |
| Use managed identity | `Microsoft.ManagedIdentity/userAssignedIdentities/read` |

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Identity has `Contributor` or `Network Contributor` roles listed, including a role whose `scope` is the subscription (an inherited role shown only because `--include-inherited` was used). | You have sufficient permissions for most operations. | Perform [Step 4a](#step-4a). |
| Identity has `Reader` role only (no Contributor or Owner role at any scope, inherited or direct). | You have insufficient permissions, and can't create, modify, or delete resources. | Perform [Resolution B](#resolution-b). |
| Identity has `Network Contributor` role, but not at the virtual network (VNet) or subnet scope. | This role might lack `subnets/join/action` permissions if the VNet is in a different resource group. | Check role assignments at VNet scope, too. |
| No role assignments at all in the `--include-inherited` output. There's no direct and no inherited Owner, Contributor, or Network Contributor roles. | Identity has no access to this resource group. | Perform [Resolution B](#resolution-b). |

### Step 4a

Check whether the Application Gateway subnet meets all requirements, including minimum size, no conflicting delegations, no other resource types present, and correct network configuration.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network vnet subnet show \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{addressPrefix:addressPrefix, delegations:delegations[].serviceName, ipConfigurations:ipConfigurations[].id, routeTable:routeTable.id, networkSecurityGroup:networkSecurityGroup.id, serviceEndpoints:serviceEndpoints[].service, privateEndpointNetworkPolicies:privateEndpointNetworkPolicies}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `addressPrefix` is `/24` or larger (for example, `/24`, `/23`) for v2 SKU. | Subnet size meets the recommended minimum. | Perform the other following checks. |
| `addressPrefix` is smaller than `/24` for v2 SKU | Subnet might be capacity-constrained. At least `/24` is recommended for v2 so autoscaling has IP headroom. A smaller subnet can provision initially but might not scale out under load. | Perform [Resolution C](#resolution-c). |
| `addressPrefix` is `/26` or smaller for v1 SKU. | Subnet might be too small, depending on instance count. v1 requires enough IPs for all instances. | Perform [Resolution C](#resolution-c). |
| `delegations` contains a service other than empty or `Microsoft.Network/applicationGateways`. | Subnet has a conflicting delegation. | Perform [Resolution C](#resolution-c). |
| `ipConfigurations` contains non-Application Gateway resources (such as VMs and private endpoints). | Other resources occupy the subnet. Application Gateway requires a dedicated subnet. | Perform [Resolution C](#resolution-c). |
| `routeTable` isn't null | A UDR is attached, and you must verify the default route. | Perform [Step 6](#step-6). |
| `networkSecurityGroup` isn't null. | An NSG is attached, and you must verify management port rules. | Perform [Step 4a](#step-4a). |
| All subnet checks pass. | Subnet configuration is correct. | Perform [Step 5](#step-5). |

> [!NOTE]
> Use `/24` for Application Gateway v2 to accommodate autoscaling. Current Azure configurations might accept and begin provisioning a v2 gateway on a subnet that's smaller than `/24`. Therefore, a smaller subnet doesn't guarantee an immediate, deterministic `SubnetTooSmall` error at the time of deployment. The risk is that the gateway later fails to scale out when it runs out of addresses. Use `/24` for all new deployments.

### Step 4b

Check whether the NSG on the Application Gateway subnet allows the required inbound management traffic from the `GatewayManager` service tag.

Extract the NSG name from the [Step 4a](#step-4a) output, then run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name:        " NSG_NAME

az network nsg rule list \
  --nsg-name "$NSG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, direction:direction, access:access, priority:priority, sourcePrefix:sourceAddressPrefix, destPorts:destinationPortRange}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| An Inbound Allow rule for source `GatewayManager` on port range `65200-65535` (v2) or `65503-65534` (v1). | Management traffic is allowed. | Perform [Step 5](#step-5). |
| No such rule exists, an explicit Deny rule has higher priority, or attaching or deploying surfaced `ApplicationGatewaySubnetInboundTrafficBlockedByNetworkSecurityGroup`. | Management traffic is blocked. Application Gateway can't communicate with the platform. | Perform [Resolution D](#resolution-d) |

### Step 5

Check whether any delete or read-only locks exist on the resource group or individual resources that block deployment, update, scaling, or deletion operations.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az lock list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

To also check subscription-level locks:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az lock list \
  --subscription "$SUBSCRIPTION" \
  --query "[?level=='Subscription'].{name:name, level:level, lockLevel:properties.level, notes:notes}" \
  --output table
```

### Interpret the result

| Observation | Meaning | Next steps |
|---|---|---|
| No locks found. | No lock-related blocking exists. | Perform [Step 6](#step-6). |
| `CanNotDelete` lock is on the resource group | Delete operations are blocked. This lock prevents deletion and might block some update operations that require resource re-creation. | Perform [Resolution E](#resolution-e). |
| `ReadOnly` lock is on the resource group. | All write operations are blocked, and deployment, scaling, updates, and deletion all fail. | Perform [Resolution E](#resolution-e). |
| Lock is at the subscription level. | A subscription-level lock affects all resource groups in the subscription. | Perform [Resolution E](#resolution-e). |
| Lock is on a specific resource (for example, the public IP, VNet, or NSG associated with Application Gateway). | Modifying that specific resource is blocked. This condition might prevent Application Gateway operations that depend on it. | Perform [Resolution E](#resolution-e). |

### Step 6

Check whether a UDR on the Application Gateway subnet has a `0.0.0.0/0` default route that points to the internet. Application Gateway v2 requires that the default route next hop is the internet. Routing through a network virtual appliance (NVA) or VPN gateway causes deployment and health probe failures.

If [Step 4a](#step-4a) showed a route table attached to the subnet, extract the route table name from the resource ID, and then run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$ROUTE_TABLE_NAME" ] && read -rp "Route Table Name: " ROUTE_TABLE_NAME

az network route-table route list \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, addressPrefix:addressPrefix, nextHopType:nextHopType, nextHopIp:nextHopIpAddress}" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| No route for `0.0.0.0/0`. | Default system route configuration applies (the next hop is the internet). | Perform [Step 7](#step-7). |
| `0.0.0.0/0` with `nextHopType: Internet`. | The explicit default route is to the internet. | Perform [Step 7](#step-7). |
| `0.0.0.0/0` with `nextHopType: VirtualAppliance`. | Default traffic is routed through an NVA. This breaks Application Gateway v2, | Perform [Resolution F](#resolution-f) |
| `0.0.0.0/0` with `nextHopType: VirtualNetworkGateway`. | Default traffic is routed through a VPN or ExpressRoute Gateway. This breaks Application Gateway v2. | Perform [Resolution F](#resolution-f). |
| `0.0.0.0/0` with `nextHopType: None`. | Default traffic is dropped and Application Gateway can't reach the internet or Azure management plane. | Perform [Resolution F](#resolution-f). |
| Multiple routes for `0.0.0.0/0`. | The most specific prefix or lowest-priority route wins.  Verify the most effective route. | Check effective routes on an Application Gateway network interface card (NIC) if possible. |

> [!IMPORTANT]
> Application Gateway v2 requires symmetric routing. It receives management traffic from the internet and must respond the same way. Forcing this traffic through an NVA breaks the control-plane communication and causes deployment failures.

### Step 7

Check whether the Application Gateway's managed identity has the required permissions to read certificates from Key Vault, and whether the Key Vault network configuration allows access from the Application Gateway subnet.

> [!NOTE]
> This step applies only if the Application Gateway uses Key Vault for Transport Layer Security (TLS) certificate management. If Key Vault integration isn't used, go to [Step 8](#step-8).

Run the following commands in Azure CLI:

1. Identify the managed identity that's assigned to the Application Gateway:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "identity" \
  --output json
```

2. Record the `{MANAGED_IDENTITY_PRINCIPAL_ID}` from `identity.userAssignedIdentities.<id>.principalId`.
3. Check the Key Vault access policy or RBAC for that identity:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:  " VAULT_NAME

az keyvault show \
  --name "$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{enableRbacAuthorization:properties.enableRbacAuthorization, enableSoftDelete:properties.enableSoftDelete, networkAcls:properties.networkAcls}" \
  --output json
```

4. If Key Vault uses access policies (`enableRbacAuthorization` is `false`), check the access policy for the managed identity:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:        " VAULT_NAME
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID: " IDENTITY_PRINCIPAL_ID

az keyvault show \
  --name "$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "properties.accessPolicies[?objectId=='$IDENTITY_PRINCIPAL_ID'].{objectId:objectId, secretPermissions:permissions.secrets, certificatePermissions:permissions.certificates}" \
  --output json
```

5. If Key Vault uses RBAC (`enableRbacAuthorization` is `true`), check the role assignments for the managed identity:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID:    " IDENTITY_PRINCIPAL_ID
[ -z "$KV_RG" ] && read -rp "Key Vault Resource Group: " KV_RG
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:           " VAULT_NAME

az role assignment list \
  --assignee "$IDENTITY_PRINCIPAL_ID" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$KV_RG/providers/Microsoft.KeyVault/vaults/$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{role:roleDefinitionName}" \
  --output table
```

6. Check Key Vault network access:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:  " VAULT_NAME

az keyvault network-rule list \
  --name "$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the result

| Observation | Meaning | Next steps |
|---|---|---|
| Identity has `Get` permission on secrets and certificates (access policy) or `Key Vault Secrets User` role (RBAC). | Key Vault permissions are sufficient. | Check network access in the following steps. |
| Identity is missing from access policies or has no RBAC role on Key Vault. | Application Gateway can't read the certificate. | Perform [Resolution G](#resolution-g). |
| `networkAcls.defaultAction` is `Deny` and Application Gateway subnet isn't in the allowed virtual network rules. | Key Vault firewall blocks the Application Gateway. | Perform [Resolution G](#resolution-g). |
| `networkAcls.defaultAction` is `Allow` | Key Vault allows access from all networks. | Perform [Step 8](#step-8). |
| Key Vault `enableSoftDelete` is `false` | Not directly related to access, but a soft-delete is recommended and might be required for some configurations. | Note this situation for follow-up. It doesn't block Key Vault access. |
| Managed identity is `null` on the Application Gateway. | No identity is assigned. Key Vault integration can't work without a managed identity. | Perform [Resolution G](#resolution-g). |

### Step 8

Check whether the Application Gateway configuration contains references to deleted or nonexistent back-end pools, HTTP settings, probes, or certificates that prevent scaling, updates, or deletion.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json > appgw-config.json
```

Inspect the configuration for cross-reference integrity. 

**Option 1: Check the URL path maps for orphaned back-end references**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{pathMaps:urlPathMaps[].{name:name, defaultBackend:defaultBackendAddressPool.id, defaultHttpSettings:defaultBackendHttpSettings.id, rules:pathRules[].{path:paths, backend:backendAddressPool.id, httpSettings:backendHttpSettings.id}}, backends:backendAddressPools[].{name:name, id:id}, httpSettings:backendHttpSettingsCollection[].{name:name, id:id}}" \
  --output json
```

**Option 2: Check routing rules for orphaned listener or back-end references**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "requestRoutingRules[].{name:name, ruleType:ruleType, listener:httpListener.id, backendPool:backendAddressPool.id, backendSettings:backendHttpSettings.id, urlPathMap:urlPathMap.id}" \
  --output json
```

#### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| All `backendAddressPool.id` and `backendHttpSettings.id` values in path maps and routing rules reference existing pools and settings. | There are no orphaned references. | Go to the [Decision Map](#decision-map). |
| A path map rule references a back-end pool ID that doesn't appear in `backendAddressPools`. | This mention is an orphaned back-end pool reference. It blocks updates and might cause scaling failures. | Perform [Resolution H](#resolution-h). |
| A path map rule references HTTP settings that don't appear in `backendHttpSettingsCollection`. | this mention is an orphaned HTTP settings reference. It blocks updates and might cause scaling failures. | Perform [Resolution H](#resolution-h). |
| A routing rule references a listener that doesn't exist in `httpListeners`. | this mention is an orphaned listener reference. It blocks updates and might cause scaling failures. | Perform [Resolution H](#resolution-h). |
| A redirect configuration references a target listener that's been deleted. | this mention is an orphaned redirect reference. It blocks updates and might cause scaling failures. | Perform [Resolution H](#resolution-h). |
| The `appgw-config.json` output contains any resource ID that returns `404` when queried directly. | this mention is an external resource that was deleted, but Application Gateway still references it. It blocks updates, and might cause scaling failures. | Perform [Resolution H](#resolution-h). |

### Step 9

Check whether autoscaling is configured to have effective minimum and maximum instance bounds. A gateway can report `provisioningState: "Succeeded"` while still scaling beyond expectations because no maximum capacity is set. This step exposes the discriminating items (the `sku` tier and the `autoscaleConfiguration` bounds) that separate an unbounded-autoscaling cost spike from a genuinely healthy gateway.

> [!NOTE]
> This step is read-only. The remediation that sets autoscale bounds is performed in [Resolution I](#resolution-i).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{tier:sku.tier, capacity:sku.capacity, autoscaleConfiguration:autoscaleConfiguration}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `autoscaleConfiguration` shows `minCapacity: 0` and `maxCapacity` is `null` or absent. | Autoscaling has no effective upper bound. The gateway can scale to the platform maximum (125 instances). This condition produces the cost or instance-count spike. | Perform [Resolution I](#resolution-i). |
| `autoscaleConfiguration.maxCapacity` is set to an unexpectedly high value relative to expected traffic. | The maximum bound is configured but set too high, and autoscaling is allowed to exceed expected capacity. | Perform [Resolution I](#resolution-i). |
| `autoscaleConfiguration` shows `minCapacity` and `maxCapacity` both set to expected values. | Autoscale bounds are configured correctly. | Bounds are configured. If the symptom persists, file an Azure support request. |
| `autoscaleConfiguration` is `null` and `sku.capacity` is a fixed number. | The gateway uses a fixed instance count, and autoscaling isn't enabled. Unbounded scaling isn't the cause. | Bounds aren't the cause. If the symptom persists, file an Azure support request. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next action |
|---|---|
| `Microsoft.Network` resource provider isn't registered [Step 2](#step-2). | Perform [Resolution A](#resolution-a). |
| Deploying identity lacks required RBAC permissions [Step 3](#step-3). | Perform [Resolution B](#resolution-b). |
| Subnet too small, has conflicting delegations, or contains other resources [Step 4a](#step-4a). | Perform [Resolution C](#resolution-c). |
| NSG blocks Application Gateway management traffic [Step 4b](#step-4b). | Perform [Resolution D](#resolution-d). |
| Resource lock prevents lifecycle operation [Step 5](#step-5). | Perform [Resolution E](#resolution-e). |
| UDR default route doesn't point to internet [Step 6](#step-6). | Perform [Resolution F](#resolution-f). |
| Key Vault access denied or network blocked [Step 7](#step-7). | Perform [Resolution G](#resolution-g). |
| Orphaned configuration references [Step 8](#step-8). | Perform [Resolution H](#resolution-h). |
| Unbounded autoscaling confirmed [Step 9](#step-9). | Perform [Resolution I](#resolution-i). |
| Provisioning state stuck at `Updating` for over one hour. | File an Azure support request. |
| All diagnostics pass, issue persists. | File an Azure support request. |

## Resolution A

The `Microsoft.Network` resource provider isn't registered in the subscription. All Azure networking resource deployments (including Application Gateway) require this provider to be registered.

Run the following commands in Azure CLI:

1. Register the provider:

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This registration adds the `Microsoft.Network` resource provider to your subscription, which is required for creating any Azure networking resources. This registration doesn't create any resources or incur charges.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az provider register \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION"
```

2. Wait for the registration to complete (1-5 minutes). After five minutes, check the status:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION

az provider show \
  --namespace Microsoft.Network \
  --subscription "$SUBSCRIPTION" \
  --query registrationState \
  --output tsv
```

3. Wait until the output shows `Registered`.
4. Rerun the deployment. 

The `ResourceProviderNotRegistered` error shouldn't occur.

If the deployment still fails with a different error, return to [Step 1](#step-1) and continue diagnosis.

## Resolution B

The identity performing the Application Gateway deployment (user account, service principal, or managed identity) doesn't have sufficient permissions to create, update, or delete the Application Gateway resource and join the subnet.

Common contributing causes include:

- The service principal used in Continuous Integration (CI) and Continuous Delivery (CD) has `Reader` instead of `Contributor` permissions.
- The managed identity used in infrastructure-as-code (IaC) hasn't been assigned a role on the target resource group.
- The VNet is in a different resource group and the identity lacks `Network Contributor` permissions on that resource group.
- A custom role definition is missing for `Microsoft.Network/virtualNetworks/subnets/join/action`.

Run the following commands in Azure CLI:

1. Identify the deployment scenario and the minimum role required for the identity performing the deployment.

| Deployment scenario | Minimum role required | Scope |
|---|---|---|
| New deployment (Application Gateway and all components in the same resource group). | `Contributor` permissions on the resource group. | Resource group. |
| New deployment (VNet in a different resource group). | `Network Contributor` permissions on the VNet resource group and `Contributor` permissions on the Application Gateway resource group. | Both resource groups. |
| Update or scale existing Application Gateway. | `Network Contributor` permissions on the resource group. | Resource group. |
| Delete Application Gateway. | `Contributor` permissions on the resource group. | Resource group. |
| Application Gateway with Key Vault certificates. | `Key Vault Secrets User` permissions on the Key Vault and `Contributor` permissions on the Application Gateway resource group. | Both resources. |

2. Assign the required roles to the identity performing the deployment.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This assigns the 
> `{ROLE_NAME}` role to the identity `{OBJECT_ID}` at the resource group scope. This allows the identity to perform deployment and management operations on Application Gateway. The  role can be scoped more narrowly if needed.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$OBJECT_ID" ] && read -rp "Identity Object ID: " OBJECT_ID
[ -z "$ROLE_NAME" ] && read -rp "Role Name:          " ROLE_NAME

az role assignment create \
  --assignee "$OBJECT_ID" \
  --role "$ROLE_NAME" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG" \
  --subscription "$SUBSCRIPTION"
```

If the VNet is in a different resource group, assign it to the correct one:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:     " SUBSCRIPTION
[ -z "$OBJECT_ID" ] && read -rp "Identity Object ID:  " OBJECT_ID
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group: " VNET_RG

az role assignment create \
  --assignee "$OBJECT_ID" \
  --role "Network Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$VNET_RG" \
  --subscription "$SUBSCRIPTION"
```

3. Wait five minutes for the RBAC role assignments to propagate.
4. Rerun the deployment. 

The `AuthorizationFailed` error should no longer occur.

If the deployment still fails with a different error, return to [Step 1](#step-1) and continue diagnosis.

## Resolution C

The Application Gateway subnet doesn't  meet one or more of the following requirements:

- **Size**: Microsoft recommends at least `/24` (256 addresses) for v2 so autoscaling has IP headroom. v1 requires enough IPs for the configured instance count plus five. A v2 subnet smaller than `/24` might provision initially but can later fail to scale out.
- **Dedication**: The subnet must contain only Application Gateway resources and no VMs, private endpoints, or other NICs.
- **Delegations**: The subnet must not have a service delegation to another service (for example, `Microsoft.Sql/managedInstances` or `Microsoft.Web/serverFarms`).

Run the following commands in Azure CLI (when applicable).

1. Review the output from [Step 4a](#step-4a) to identify which condition isn't met.
2. If the subnet is too small, create a new subnet with a larger address prefix and deploy the Application Gateway into that subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This process creates a new subnet with a `/24` address prefix in your existing virtual network. You need to deploy the Application Gateway into this new subnet. The new subnet address range must not overlap with any existing subnets in the VNet.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:   " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:    " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:         " VNET_NAME
[ -z "$NEW_SUBNET_NAME" ] && read -rp "New Subnet Name:   " NEW_SUBNET_NAME
[ -z "$NEW_SUBNET_PREFIX" ] && read -rp "New Subnet Prefix: " NEW_SUBNET_PREFIX

az network vnet subnet create \
  --vnet-name "$VNET_NAME" \
  --name "$NEW_SUBNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --address-prefixes "$NEW_SUBNET_PREFIX"
```

> [!NOTE]
> The new address prefix (for example, `10.0.2.0/24`) must not overlap with existing subnets. Use `az network vnet subnet list` to see currently allocated ranges.

3. If the subnet has a conflicting delegation, remove the delegation from the subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Only remove the delegation if the subnet isn't actively used by the delegated service. Removing a delegation that's in use breaks that service.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network vnet subnet update \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --remove delegations
```

4. If the subnet contains VMs, private endpoints, or other NICs, identify each `ipConfigurations` entry from [Step 4a](#step-4a) and determine which resource it belongs to.

> [!IMPORTANT]
> You must migrate these resources to a different subnet before Application Gateway can use this subnet. This migration might involve downtime for those resources. 

5. Rerun the deployment targeting the corrected or new subnet. 

The `SubnetTooSmall`, `InvalidSubnet`, or `ApplicationGatewaySubnetCannotHaveOtherResourceTypes` errors shouldn't occur.

If the deployment still fails with a different error, return to [Step 1](#step-1) and continue diagnosis.

## Resolution D

The NSG on the Application Gateway subnet blocks inbound management traffic on ports `65200`–`65535` (v2) or `65503`–`65534` (v1) from the `GatewayManager` service tag. Azure infrastructure requires this traffic to communicate with Application Gateway instances.

Run the following commands in Azure CLI (when applicable).

1. Determine if the NSG is blocking management traffic.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step adds an NSG rule to allow Azure's management traffic to reach the Application Gateway instances. Without this rule, the Application Gateway can't be provisioned, scaled, or managed. The source is the `GatewayManager` service tag (Azure infrastructure only), not public internet.

**For Application Gateway v2**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name:        " NSG_NAME

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-AppGW-V2-Management \
  --priority 100 \
  --direction Inbound \
  --source-address-prefix GatewayManager \
  --destination-port-range "65200-65535" \
  --protocol Tcp \
  --access Allow
```

**For Application Gateway v1**

Replace the destination port range with `65503`-`65534`.

2. Configure the NSG to allow inbound traffic on the listener ports (typically 80 and 443) if the Application Gateway has a public frontend IP.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name:        " NSG_NAME

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-HTTP-HTTPS \
  --priority 200 \
  --direction Inbound \
  --source-address-prefix Internet \
  --destination-port-ranges 80 443 \
  --protocol Tcp \
  --access Allow
```

3. Rerun [Step 4a](#step-4a). 

The management port rule should now appear. Retry the deployment or wait for the gateway to recover.

## Resolution E

A `CanNotDelete` or `ReadOnly` lock on the resource group (or on an individual resource like the public IP, VNet, or NSG) prevents the Application Gateway lifecycle operation from completing.

- `CanNotDelete` locks prevent deletion and some updates that require resource recreation.
- `ReadOnly` locks prevent all write operations including deployment, scaling, configuration updates, and deletion.

1. Review the output from [Step 5](#step-5) and record the `{LOCK_NAME}` and the scope (resource group or specific resource).
2. Remove the lock from the resource group or resource.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This action removes the resource lock `{LOCK_NAME}` from the resource group, allowing the Application Gateway operation to proceed. After the operation completes, reapply the lock to maintain governance controls. This action requires the `Microsoft.Authorization/locks/delete` permission (Owner role).

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LOCK_NAME" ] && read -rp "Lock Name:       " LOCK_NAME

az lock delete \
  --name "$LOCK_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

If the lock is on a specific resource:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$LOCK_NAME" ] && read -rp "Lock Name:            " LOCK_NAME
[ -z "$LOCKED_RESOURCE_NAME" ] && read -rp "Locked Resource Name: " LOCKED_RESOURCE_NAME
[ -z "$LOCKED_RESOURCE_TYPE" ] && read -rp "Locked Resource Type: " LOCKED_RESOURCE_TYPE

az lock delete \
  --name "$LOCK_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --resource-name "$LOCKED_RESOURCE_NAME" \
  --resource-type "$LOCKED_RESOURCE_TYPE"
```

3. Rerun the deployment, update, scaling, or deletion operation that previously failed.
4. After the operation completes successfully, reapply the lock to maintain governance controls.

> [!IMPORTANT]
> Always reapply the lock after the operation completes.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LOCK_NAME" ] && read -rp "Lock Name:       " LOCK_NAME
[ -z "$LOCK_TYPE" ] && read -rp "Lock Type (CanNotDelete or ReadOnly): " LOCK_TYPE

az lock create \
  --name "$LOCK_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --lock-type "$LOCK_TYPE"
```

5. Verify that the operation completed successfully (check `provisioningState` via [Step 1](#step-1)) and that the lock is reapplied (rerun [Step 5](#step-5)).

## Resolution F

The route table attached to the Application Gateway subnet has a `0.0.0.0/0` (default) route value with a next hop type other than `Internet`. Application Gateway v2 requires symmetric routing as management traffic arrives from the internet and the response must go back the same way. Routing the default route through an NVA, VPN gateway, or dropping it (`None`) breaks this communication.

1. Review the output from [Step 6](#step-6) to identify the route table and default route that needs to be updated.

> [!IMPORTANT]
> Review the following command and understand what it does before running it. This command updates the default route (`0.0.0.0/0`) in the route table to use the internet as the next hop, which is required for Application Gateway v2. If you have a forced-tunneling requirement for other subnets, consider using a separate route table for the Application Gateway subnet. The Application Gateway subnet shouldn't share a route table with subnets that require NVA or VPN-forced tunneling.

**Option 1: Re-create the default route with Internet as the next hop**

A `0.0.0.0/0` route that currently points to a `VirtualAppliance` can't simply be updated with `--next-hop-type Internet` as this change doesn't clear the inherited next-hop IP address. This condition causes the update to fail with `NextHopIpAddressNotAllowed`. The `--next-hop-ip-address ""` parameter is also rejected. Delete the default route and re-create it with no next-hop IP.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$ROUTE_TABLE_NAME" ] && read -rp "Route Table Name:   " ROUTE_TABLE_NAME
[ -z "$DEFAULT_ROUTE_NAME" ] && read -rp "Default Route Name: " DEFAULT_ROUTE_NAME

az network route-table route delete \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$DEFAULT_ROUTE_NAME"

az network route-table route create \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name default-internet \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type Internet
```

**Option 2: Create a dedicated route table for the Application Gateway subnet**

If the existing route table is shared with other subnets that require forced tunneling, create a new route table with the default route to Internet and associate it only with the Application Gateway subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network route-table create \
  --name appgw-route-table \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"

az network route-table route create \
  --route-table-name appgw-route-table \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name default-internet \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type Internet

az network vnet subnet update \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --route-table appgw-route-table
```

2. Add specific routes for your back-end subnets or on-premises networks through the NVA while keeping the `0.0.0.0/0` default route to the internet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$ROUTE_TABLE_NAME" ] && read -rp "Route Table Name:      " ROUTE_TABLE_NAME
[ -z "$BACKEND_SUBNET_PREFIX" ] && read -rp "Backend Subnet Prefix: " BACKEND_SUBNET_PREFIX
[ -z "$NVA_IP" ] && read -rp "NVA IP Address:        " NVA_IP

az network route-table route create \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name to-backend-via-nva \
  --address-prefix "$BACKEND_SUBNET_PREFIX" \
  --next-hop-type VirtualAppliance \
  --next-hop-ip-address "$NVA_IP"
```

3. Rerun [Step 6](#step-6). 

The default route should now show `nextHopType: Internet`. Retry the deployment or wait for the gateway provisioning to recover.

## Resolution G

The Application Gateway's user-assigned managed identity either doesn't exist or isn't associated with the gateway, doesn't have `Get` permissions on Key Vault secrets and certificates, or the Key Vault network firewall blocks access from the Application Gateway subnet.

Run the following commands in Azure CLI (when applicable):

1. Create a user-assigned managed identity and assign it to the Application Gateway.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step is necessary only if the Application Gateway has no managed identity assigned ([Step 7](#step-7) showed `identity: null`).

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG

az identity create \
  --name appgw-identity \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

2. Record the `{IDENTITY_RESOURCE_ID}` from the output (the full resource ID) and `{IDENTITY_PRINCIPAL_ID}` (the `principalId`).
3. Assign the identity to the Application Gateway:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:     " RESOURCE_NAME
[ -z "$IDENTITY_RESOURCE_ID" ] && read -rp "Identity Resource ID: " IDENTITY_RESOURCE_ID

az network application-gateway identity assign \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --identity "$IDENTITY_RESOURCE_ID"
```

4. Grant the managed identity `Get` permissions on Key Vault secrets and certificates.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. Use the appropriate command, depending on whether the Key Vault uses access policies or RBAC.

**If Key Vault uses access policies**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:        " VAULT_NAME
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID: " IDENTITY_PRINCIPAL_ID

az keyvault set-policy \
  --name "$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --object-id "$IDENTITY_PRINCIPAL_ID" \
  --secret-permissions get \
  --certificate-permissions get
```

**If Key Vault uses RBAC**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:          " SUBSCRIPTION
[ -z "$IDENTITY_PRINCIPAL_ID" ] && read -rp "Identity Principal ID:    " IDENTITY_PRINCIPAL_ID
[ -z "$KV_RG" ] && read -rp "Key Vault Resource Group: " KV_RG
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:           " VAULT_NAME

az role assignment create \
  --assignee "$IDENTITY_PRINCIPAL_ID" \
  --role "Key Vault Secrets User" \
  --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$KV_RG/providers/Microsoft.KeyVault/vaults/$VAULT_NAME" \
  --subscription "$SUBSCRIPTION"
```

5. If the Key Vault has a network firewall enabled, add the Application Gateway subnet to the Key Vault's allowed network rules.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This step is necessary only if Key Vault has a network firewall enabled (`defaultAction: Deny`).

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:  " VAULT_NAME

az keyvault network-rule add \
  --name "$VAULT_NAME" \
  --subscription "$SUBSCRIPTION" \
  --subnet "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG/providers/Microsoft.Network/virtualNetworks/$VNET_NAME/subnets/$SUBNET_NAME"
```

> [!NOTE]
> The Application Gateway subnet must have the `Microsoft.KeyVault` service endpoint enabled in order for VNet rules to work.

6. If the subnet doesn't have the Key Vault service endpoint enabled, enable it:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$SUBNET_NAME" ] && read -rp "Subnet Name:     " SUBNET_NAME

az network vnet subnet update \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --service-endpoints Microsoft.KeyVault
```

7. Rerun [Step 7](#step-7).

The managed identity now has the required permissions and network access. Retry the deployment or update.

8. If the issue persists, verify that the certificate that's referenced in the Application Gateway SSL configuration actually exists in the Key Vault:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$VAULT_NAME" ] && read -rp "Key Vault Name:   " VAULT_NAME
[ -z "$CERT_NAME" ] && read -rp "Certificate Name: " CERT_NAME

az keyvault certificate show \
  --vault-name "$VAULT_NAME" \
  --name "$CERT_NAME" \
  --query "{name:name, enabled:attributes.enabled, expires:attributes.expires}" \
  --output json
```

## Resolution H

The Application Gateway configuration contains references to back-end pools, HTTP settings, probes, listeners, or SSL certificates that you deleted or are in an inconsistent state. This condition commonly occurs if you:

- Delete a back-end pool by using the Azure portal or an ARM template, but a URL path map still references it.
- Remove HTTP settings, but a routing rule or path map still points to them.
- Delete a listener but a redirect configuration that references it.
- Partially update an ARM template and remove some components but leave cross-references intact.

Run the following commands in Azure CLI (when applicable).

1. Review the output from [Step 8](#step-8). For each orphaned reference or record:

- Where it's referenced, including the path map name, routing rule name, or redirect configuration name.
- What's referenced, including the back-end pool name or ID, HTTP settings name or ID, or listener name or ID that no longer exists.

2. Decide whether to delete the orphaned reference or re-create the missing resource in place.

> [!TIP]
> Use this deletion approach only if the gateway has more than one routing rule. It removes the URL path map rule that references a deleted back-end pool. Traffic matching that path then goes to the default backend of the path map. If the orphaned reference lives in the gateway's only routing rule, don't try to delete it. Instead, go to step 3 to re-create the referenced resource in place.

Begin by verifying how many routing rules the gateway has. The deletion approach is only viable if at least one *other* routing rule remains:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway rule list \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].name" \
  --output json
```

**Interpret the results**

| Observation | Meaning | Next steps |
|---|---|---|
| More than one routing rule listed. | Another routing rule remains, so removing the orphaned path map rule (or its routing rule) is allowed. | Continue with the following delete commands.|
| Exactly one routing rule listed. | The orphaned reference is in the gateway's only routing rule. A gateway must keep at least one routing rule, so `az network application-gateway rule delete` fails with `ApplicationGatewayMustHaveAtleastOneResourceOfType`, and `az network application-gateway url-path-map delete` fails with `InvalidResourceReference` while the rule still references the map. Deletion is impossible. | Skip deletion and go to step 3 to re-create the referenced resource in place. |

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
[ -z "$PATH_MAP_NAME" ] && read -rp "Path Map Name:      " PATH_MAP_NAME
[ -z "$ORPHANED_RULE_NAME" ] && read -rp "Orphaned Rule Name: " ORPHANED_RULE_NAME

az network application-gateway url-path-map rule delete \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --path-map-name "$PATH_MAP_NAME" \
  --name "$ORPHANED_RULE_NAME"
```

> [!IMPORTANT]
> If the orphaned rule is the only path rule in its path map, the prior commands fail and return `ApplicationGatewayUrlPathMapMustSpecifyPathRules`. A URL path map must always retain at least one path rule. When another routing rule remains on the gateway, you can, instead, delete the routing rule that references the path map and then the path map itself. Delete the routing rule first. A path map can't be removed while a rule still references it. The gateway must have at least one other routing rule or this `rule delete` fails and returns `ApplicationGatewayMustHaveAtleastOneResourceOfType`. If this rule is the sole routing rule, re-create the referenced resource by using step 3 instead, or add a second routing rule so that you can remove this rule.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:       " RESOURCE_NAME
[ -z "$PATH_MAP_NAME" ] && read -rp "Path Map Name:          " PATH_MAP_NAME
[ -z "$ROUTING_RULE_NAME" ] && read -rp "Routing Rule Name:      " ROUTING_RULE_NAME

az network application-gateway rule delete \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$ROUTING_RULE_NAME"

az network application-gateway url-path-map delete \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$PATH_MAP_NAME"
```

3. If the orphaned reference is in the gateway's only routing rule, re-create the missing resource in place.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This path is the primary path for an orphaned reference and the only working path if the orphaned reference is in the gateway's sole routing rule. Recreating the missing resource clears the orphaned reference in place without deleting any routing rules so it never encounters `ApplicationGatewayMustHaveAtleastOneResourceOfType` or `InvalidResourceReference`. Re-create the missing back-end pool using the same name the path map rule references.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:       " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:     " RESOURCE_NAME
[ -z "$MISSING_BACKEND_POOL_NAME" ] && read -rp "Missing Backend Pool: " MISSING_BACKEND_POOL_NAME
[ -z "$BACKEND_IP_OR_FQDN" ] && read -rp "Backend IP or FQDN:   " BACKEND_IP_OR_FQDN

az network application-gateway address-pool create \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$MISSING_BACKEND_POOL_NAME" \
  --servers "$BACKEND_IP_OR_FQDN"
```

4. If a routing rule references a deleted listener or back-end pool, run the following commands:

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name:   " RESOURCE_NAME
[ -z "$ORPHANED_RULE_NAME" ] && read -rp "Orphaned Rule Name: " ORPHANED_RULE_NAME

az network application-gateway rule delete \
  --gateway-name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$ORPHANED_RULE_NAME"
```

5. If multiple orphaned references exist, and individual cleanup is impractical, export the resource group as an ARM template.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This option should be used as a last resort. It exports the resource group as an ARM template, allows manual fixes to the JSON, and redeploys it. This process is disruptive and should only be used after attempts to remove individual orphaned references have failed.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG

az group export \
  --name "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json > appgw-template.json
```

6. To remove the orphaned references, edit `appgw-template.json`. 
7. Before you redeploy, apply the following mandatory edits (the raw `az group export` output isn't redeployable verbatim):

- Remove the Application Gateway's top-level `dependsOn` array. `az group export` omits a circular dependency for Application Gateway resources. Therefore, the redeployment fails and returns `InvalidTemplate: Circular dependency detected`. ARM infers the correct ordering from the `resourceId(...)` property references. Therefore, you can delete the top-level `dependsOn` on the `Microsoft.Network/applicationGateways` resource to resolve it.
- Supply values for the exported resource-name parameters. `az group export` creates name parameters (for example, the gateway, virtual network, and public IP name parameters) without any `defaultValue`. Therefore, the redeployment stalls in a `stdin` state as it waits for input unless you pass them. Provide a value for each exported name parameter by using `--parameters <paramName>=<value>` on the redeploy command (see the following commands).

8. Redeploy the edited template. Supply a value for each exported name parameter.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:        " VNET_NAME
[ -z "$PUBLIC_IP_NAME" ] && read -rp "Public IP Name:   " PUBLIC_IP_NAME

# Pass a value for each exported name parameter. Inspect the
# "parameters" block of appgw-template.json and add a matching
# --parameters <name>=<value> for every name parameter it declares.
az deployment group create \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --template-file appgw-template.json \
  --mode Incremental \
  --parameters applicationGateways_${RESOURCE_NAME}_name="$RESOURCE_NAME" \
  --parameters virtualNetworks_${VNET_NAME}_name="$VNET_NAME" \
  --parameters publicIPAddresses_${PUBLIC_IP_NAME}_name="$PUBLIC_IP_NAME"
```

9. Rerun [Step 8](#step-8).

All references should now resolve to existing resources. Retry the scaling, update, or deletion operation.

## Resolution I

Application Gateway v2 that has autoscaling enabled has no minimum or maximum instance count configured. Therefore, it scales aggressively in response to traffic spikes. This configuration can cause unexpected cost increases or reach subscription capacity limits.

Run the following commands in Azure CLI (when applicable):

1. Review the current autoscaling configuration and SKU capacity.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{sku:sku, autoscaleConfiguration:autoscaleConfiguration}" \
  --output json
```

**Interpret the results**

| Observation | Meaning |
|---|---|
| `autoscaleConfiguration` is null and `sku.capacity` is set. | There's a fixed instance count with no autoscaling.|
| `minCapacity: 0` and `maxCapacity: null` or very high. | Autoscaling has no effective bounds and can scale to 125 instances. |
| `minCapacity` and `maxCapacity` are both set to expected values. | Bounds are configured. |

2. If `minCapacity` and `maxCapacity` aren't set, configure them to appropriate values.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. This action sets minimum and maximum instance counts for autoscaling. The minimum ensures baseline capacity for expected traffic. The maximum caps costs and prevents runaway scaling. Typical values include `minCapacity 2`–`4` and `maxCapacity 10`–`20` depending on traffic patterns.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$RESOURCE_NAME" ] && read -rp "App Gateway Name: " RESOURCE_NAME

az network application-gateway update \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --min-capacity 2 \
  --max-capacity 10
```

> [!NOTE]
> To establish baseline and peak traffic patterns, review Application Gateway metrics (`CurrentCapacity`, `CapacityUnits`, and `ComputeUnits`) over the past 30 days. Set `minCapacity` above the baseline and `maxCapacity` above the peak by allowing some headroom.

3. Rerun step 1, and verify that `minCapacity` and `maxCapacity` are set.
4. To verify scaling stays within bounds, Monitor `CurrentCapacity` metric over the next 24–48 hours.

## References

- [Application Gateway infrastructure configuration requirements](/azure/application-gateway/configuration-infrastructure)
- [Application Gateway v2 subnet requirements](/azure/application-gateway/configuration-infrastructure#size-of-the-subnet)
- [Supported Azure resource providers and types](/azure/azure-resource-manager/management/resource-providers-and-types)
- [Azure built-in roles for networking](/azure/role-based-access-control/built-in-roles#network-contributor)
- [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources)
- [Application Gateway TLS policy overview and Key Vault integration](/azure/application-gateway/key-vault-certs)
- [Troubleshoot Azure Application Gateway](/azure/application-gateway/application-gateway-troubleshooting-502)
- [Application Gateway v2 autoscaling and zone-redundancy](/azure/application-gateway/application-gateway-autoscaling-zone-redundant)
