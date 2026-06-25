---
title: Troubleshoot 403 access denied errors for Azure Storage or Azure Key Vault through an approved private endpoint
description: Resolve 403 errors when you access Azure Storage or Key Vault through private endpoints. Learn diagnostic steps and DNS solutions to fix firewall rejections.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints.
ms.date: 6/16/2026
ai.hint.symptom-tags:
  - 403-forbidden
  - access-denied
  - private-endpoint
  - dns-resolution
  - storage-firewall
  - keyvault-firewall
  - public-network-access-disabled
  - tcp-connection-not-allowed
  - private-dns-zone
  - vnet-link-missing
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Storage/storageAccounts/read
  - Microsoft.KeyVault/vaults/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/write
  - Microsoft.Network/privateEndpoints/privateDnsZoneGroups/write
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - SERVICE_FQDN
---

# Troubleshoot "403" access denied errors for Azure Storage or Azure Key Vault through a private endpoint

## Summary

This article provides step-by-step diagnostics to identify and resolve "403" access denied errors that occur when you access Azure Storage or Key Vault through a private endpoint. The result is firewall rejections. The most common cause is DNS resolution problems in which the FQDN resolves to the public IP instead of the private endpoint IP.

When you encounter a "403 — This TCP connection does not allow access to {host}" error when you access Azure Storage or Key Vault through a private endpoint, the situation is almost always a Domain Name System (DNS) problem in disguise. The client believes that it's connecting over the private endpoint. However, DNS resolves the fully qualified domain name (FQDN) to the public IP. The service firewall then rejects the request because traffic arrives on the public endpoint from an IP that's not in the allowlist. 

## Symptoms

You might encounter one or more of the following symptoms:

- `403 Forbidden` errors when you call Azure Storage (Blob, File, Queue, or Table operations) or Key Vault data-plane operations from a workload that's inside a virtual network (VNet) and has a private endpoint.
- Error message: `This request is not authorized to perform this operation` (Azure Storage).
- Error message: `Client address is not authorized and caller is not a trusted service` (Azure Storage that has a firewall).
- Error message: `Public access is disabled and the request was not made from a trusted service or via an approved private link` (Key Vault).
- Error message: `This TCP connection does not allow access to vault.azure.net on port 443` (Key Vault).
- Access works from outside the VNet (public internet) but fails from inside the VNet (where the private endpoint should be active).
- Access worked before a VNet or DNS configuration change.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required**: `Reader` role on the private endpoint resource group, `Reader` role on the target Azure Storage account or Key Vault (for diagnostics). Write operations require `Network Contributor` or `Private DNS Zone Contributor` permissions.
- **Tools**: Azure CLI 2._x_ or an AI agent that has Azure CLI access. The workload virtual machine (VM) or Cloud Shell must be in (or routable to) the VNet where the private endpoint is deployed to run `nslookup`.
- **Required variables and examples of those variables, as shown in the following table.**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `$RG` | Resource group containing the private endpoint | `myPEResourceGroup` |
| `$PE_NAME` | Private endpoint resource name | `pe-storage-blob` |
| `$SERVICE_FQDN` | FQDN of the target service | `mystorageacct.blob.core.windows.net` or `myvault.vault.azure.net` |
| `$SERVICE_RG` | Resource group of the target service (Azure Storage or Key Vault) | `myServiceRG` |
| `$SERVICE_NAME` | Name of the Azure Storage account or Key Vault | `mystorageacct` or `myvault` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the FQDN resolves to the private endpoint IP (for example, `10._x.x.x_`) or the public IP. This check is the single most important diagnostic step. Roughly 70 percent of cases are caused by DNS resolving to the public endpoint.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SERVICE_FQDN" ] && read -rp "Service FQDN (e.g. mystorageacct.blob.core.windows.net): " SERVICE_FQDN

echo "=== DNS resolution from this client ==="
nslookup "$SERVICE_FQDN" 2>&1

echo ""
echo "=== Expected: CNAME to *.privatelink.* then A record to 10.x.x.x ==="
echo "=== If you see a public IP (20.x, 52.x, etc.) the PE DNS is not working ==="
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| CNAME chain includes `*.privatelink.*` and final IP is `10.x.x.x` or `172.16.x.x` (RFC 1918). | DNS correctly resolves through the private DNS zone to the private endpoint network adapter (also known as a network interface card (NIC)) IP. | Perform [Step 2](#step-2). |
| CNAME chain includes `*.privatelink.*`, but the final IP is public, and the DNS server shown isn't `168.63.129.16` (for example, `8.8.8.8`, `10.x.x.x` corporate forwarder, or internet service provider (ISP) resolver). | The private DNS zone exists and works for VNet-linked clients, but this caller is outside the VNet, and it can't use the private zone. | Perform [Resolution D](#resolution-d). |
| Final IP is a public IP and CNAME chain doesn't include `*.privatelink.*`. | No private DNS zone is configured. DNS has no path to resolve to the private endpoint IP. | Perform [Resolution A](#resolution-a). |
| Final IP is a public IP, DNS server is `168.63.129.16`, and CNAME includes `*.privatelink.*` | Azure DNS is responding but the A record is missing or stale in the private zone. | Perform [Resolution A](#resolution-a). |
| `*** server can't find` or `NXDOMAIN`. | DNS can't resolve the FQDN at all. A zone or forwarder misconfiguration exists. | Perform [Resolution A](#resolution-a). |
| IP is `10.x.x.x` but NOT the expected private endpoint IP (check against [Step 2](#step-2) output). | Multiple private endpoints might exist, and a wrong one is resolving the IP. | Perform [Resolution A](#resolution-a). |

### Step 2

Check whether the private endpoint connection to the target resource is in the `Approved` state. A `Pending` or `Disconnected` connection means traffic can't flow.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, connections:privateLinkServiceConnections[].{name:name, status:privateLinkServiceConnectionState.status, description:privateLinkServiceConnectionState.description}, manualConnections:manualPrivateLinkServiceConnections[].{name:name, status:privateLinkServiceConnectionState.status, description:privateLinkServiceConnectionState.description}, nicIp:networkInterfaces[0].id}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `"status": "Approved"` in `connections` or `manualConnections`. | Connection is approved and traffic can flow. | Perform [Step 3](#step-3). |
| `"status": "Pending"`. | Connection isn't approved by the resource owner. | Perform [Resolution B](#resolution-b). |
| `"status": "Disconnected"` or `"status": "Rejected"`. | Connection is rejected or disconnected. | Perform [Resolution B](#resolution-b). |
| `ResourceNotFound` error. | Private endpoint name, resource group, or subscription is incorrect. | Verify your variables and rerun. |

### Step 3

Check the service firewall configuration on the target resource. If `publicNetworkAccess` is disabled and DNS is correctly routing through the private endpoint, the "403" errors aren't a network issue. It's a data-plane role-based access control (RBAC) or access policy problem.

Run the following commands in Azure CLI:

**Azure Storage**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Storage Account Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Storage Account Name: " SERVICE_NAME

az storage account show \
  --name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{publicNetworkAccess:publicNetworkAccess, defaultAction:networkRuleSet.defaultAction, ipRules:networkRuleSet.ipRules[].ipAddressOrRange, virtualNetworkRules:networkRuleSet.virtualNetworkRules[].id, bypass:networkRuleSet.bypass}" \
  --output json
```

**Key Vault**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Key Vault Name: " SERVICE_NAME

az keyvault show \
  --name "$SERVICE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{publicNetworkAccess:properties.publicNetworkAccess, defaultAction:properties.networkAcls.defaultAction, ipRules:properties.networkAcls.ipRules[].value, virtualNetworkRules:properties.networkAcls.virtualNetworkRules[].id, bypass:properties.networkAcls.bypass}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `publicNetworkAccess: "Disabled"` and [Step 1](#step-1) shows private IP. | Firewall blocks all public access. Since DNS is correct, the "403" errors are a data-plane authentication issue. | Perform [Step 4](#step-4). |
| `publicNetworkAccess: "Enabled"`, `defaultAction: "Deny"`, and [Step 1](#step-1) shows public IP. | Caller is reaching the public endpoint and isn't in the allow list. | Perform [Resolution A](#resolution-a) to fix DNS so traffic goes through the private endpoint. |
| `publicNetworkAccess: "Enabled"` and `defaultAction: "Allow"`. | Firewall allows all public traffic. "403" errors aren't a network or firewall issue. | Perform [Step 4](#step-4). |
| `publicNetworkAccess: "Disabled"` and the caller is a portal user, pipeline agent, or tool outside the VNet. | The management client itself is outside the VNet and can't reach the resource. | Perform [Resolution D](#resolution-d). |

### Step 4

Check whether the calling identity has data-plane permission to the resource. This step applies when DNS resolution and network connectivity are correct but the "403" errors persist.

Run the following commands in Azure CLI: 

**Azure Storage**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Storage Account Name: " SERVICE_NAME

echo "=== Attempting to list blobs (data-plane read) ==="
echo "(If you have no container name, first run: az storage container list --account-name $SERVICE_NAME --subscription $SUBSCRIPTION)"
[ -z "$CONTAINER_NAME" ] && read -rp "Container name to test: " CONTAINER_NAME

az storage blob list \
  --account-name "$SERVICE_NAME" \
  --container-name "$CONTAINER_NAME" \
  --auth-mode login \
  --subscription "$SUBSCRIPTION" \
  --query "[].name" \
  --output tsv 2>&1

echo ""
echo "=== Check current identity ==="
az ad signed-in-user show --query "{upn:userPrincipalName, objectId:id}" --output json 2>&1 || \
  az account show --query "{identity:user.name, type:user.type}" --output json
```

**Key Vault**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Key Vault Name: " SERVICE_NAME

echo "=== Attempting to list secrets (data-plane read) ==="
az keyvault secret list \
  --vault-name "$SERVICE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, enabled:attributes.enabled}" \
  --output table 2>&1

echo ""
echo "=== Check current identity ==="
az ad signed-in-user show --query "{upn:userPrincipalName, objectId:id}" --output json 2>&1 || \
  az account show --query "{identity:user.name, type:user.type}" --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Data-plane operation succeeds (blobs and secrets listed). | The "403" errors might be specific to the original client identity or SDK token, not the CLI identity. | Confirm the original calling identity matches this one. If different, perform [Resolution C](#resolution-c). |
| `You do not have the required permissions needed to perform this operation` or `AuthorizationPermissionMismatch` (Azure Storage). | Identity lacks a AzureStorage data-plane role (for example, `Storage Blob Data Reader`) | Perform [Resolution C](#resolution-c). |
| `AccessDenied` or `Forbidden` and `SecretList` or `KeyList` (Key Vault). | Identity lacks Key Vault data-plane permission (access policy or RBAC). | Perform [Resolution C](#resolution-c). |
| `403` error and network-related message, even though [Step 1](#step-1) showed a private IP. | This error is rare because a secondary FQDN (DFS Namespaces (DFS-N) or queue) might not have a matching private endpoint or DNS entry. | Rerun [Step 1](#step-1) by using the exact FQDN your application uses. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| [Step 1](#step-1): FQDN resolves to public IP, no `*.privatelink.*` CNAME. | Perform [Resolution A](#resolution-a). |
| [Step 1](#step-1): FQDN resolves to public IP, `*.privatelink.*` CNAME present, DNS server is `168.63.129.16`. | Perform [Resolution A](#resolution-a) (a record is missing or stale). |
| [Step 1](#step-1): FQDN resolves to public IP, `*.privatelink.*` CNAME present, DNS server isn't `168.63.129.16`. | Perform [Resolution D](#resolution-d) (caller is outside VNet). |
| [Step 1](#step-1): NXDOMAIN or can't resolve IP. | Perform [Resolution A](#resolution-a). |
| [Step 2](#step-2): Connection status is `Pending`, `Disconnected`, or `Rejected`. | Perform [Resolution B](#resolution-b). |
| [Step 3](#step-3): Public access disabled and caller is outside the VNet. | Perform [Resolution D](#resolution-d). |
| [Step 3](#step-3): Default action is Deny and [Step 1](#step-1) showed public IP. | Perform [Resolution A](#resolution-a). |
| [Step 4](#step-4): Data-plane operation returns permission error. | Perform [Resolution C](#resolution-c). |
| All diagnostics pass but problems persist. | File an Azure support request and include the nslookup output, private endpoint connection state, and the exact error message. |

## Resolution A

The FQDN resolves to the public endpoint IP instead of the private endpoint IP. The most common causes are: 

- The private DNS zone `privatelink.blob.core.windows.net` or `privatelink.vaultcore.azure.net` doesn't exist. 
- The zone exists but isn't linked to your VNet. 
- The A record for the resource is missing from the zone. 
- A custom DNS server isn't forwarding `privatelink.*` queries to Azure DNS (`168.63.129.16`).

Run the following commands in Azure CLI.

1. Identify the required private DNS zone, and check whether it exists:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_FQDN" ] && read -rp "Service FQDN (e.g. mystorageacct.blob.core.windows.net): " SERVICE_FQDN

# Derive the expected private DNS zone name from the FQDN
# Storage blob: privatelink.blob.core.windows.net
# Key Vault:    privatelink.vaultcore.azure.net
echo "=== Looking for private DNS zones matching privatelink.* ==="
az network private-dns zone list \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(name,'privatelink')].{name:name, resourceGroup:resourceGroup, numberOfRecordSets:numberOfRecordSets}" \
  --output table
```

If the expected zone (for example, `privatelink.blob.core.windows.net` for Azure Storage Blob or `privatelink.vaultcore.azure.net` for Key Vault) is missing entirely, go to step 4 to create it.

If the zone exists, note its resource group, and go to the next step.

2. Check whether the private DNS zone is linked to the client's VNet:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Private DNS Zone Resource Group (from A.1): " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name (e.g. privatelink.blob.core.windows.net): " DNS_ZONE_NAME

az network private-dns link vnet list \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, vnetId:virtualNetwork.id, linkState:virtualNetworkLinkState, registrationEnabled:registrationEnabled}" \
  --output table
```

**Interpret the results**

| Observation | Meaning | Next steps |
|---|---|---|
| The client's VNet appears in the list together with `linkState: Completed`. | VNet link exists. The problem is likely a missing A record. | Go to the next step. |
| The client's VNet isn't in the list. | The VNet isn't linked and DNS queries from that VNet don't reach this zone. | Perform step 5. |

3. Check whether the A record for the resource exists in the private DNS zone:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Private DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$SERVICE_NAME" ] && read -rp "Service resource name (short name, e.g. mystorageacct): " SERVICE_NAME

az network private-dns record-set a show \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --name "$SERVICE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{fqdn:fqdn, ipAddresses:aRecords[].ipv4Address, ttl:ttl}" \
  --output json 2>&1
```

**Interpret the results**

| Observation | Meaning | Next steps |
|---|---|---|
| A record exists and has the private endpoint, network adapter IP (for example, `10.0.1.4`). | DNS zone has the correct record. The problem might be a custom DNS forwarder that doesn't forward to Azure DNS. | Check the VNet's custom DNS server configuration, and make sure that it conditionally forwards `privatelink.*` to `168.63.129.16`. |
| `ResourceNotFound` or record doesn't exist | The private endpoint's DNS zone group isn't configured or didn't register. | Perform step 6. |
| A record IP doesn't match the private endpoint network adapter IP from [Step 2](#step-2) | Stale or incorrect record, possibly from a deleted or re-created private endpoint. | Perform step 6.  |

4. Create the missing private DNS zone.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Resource Group for DNS Zone: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Zone Name (e.g. privatelink.blob.core.windows.net): " DNS_ZONE_NAME

az network private-dns zone create \
  --name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

After creating the zone, go to the next step to link the VNet, and then step 6 to register the A record.

5. Link the private DNS zone to your VNet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Private DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$VNET_ID" ] && read -rp "Client VNet Resource ID (full /subscriptions/.../virtualNetworks/...): " VNET_ID
[ -z "$LINK_NAME" ] && read -rp "Link name (e.g. link-to-my-vnet): " LINK_NAME

az network private-dns link vnet create \
  --name "$LINK_NAME" \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --virtual-network "$VNET_ID" \
  --registration-enabled false \
  --subscription "$SUBSCRIPTION" \
  --output json
```

6. To autoregister the A record, create or re-create the DNS zone group on the private endpoint.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME
[ -z "$DNS_ZONE_RG" ] && read -rp "Private DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME

# Get the full zone ID
ZONE_ID=$(az network private-dns zone show \
  --name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az network private-endpoint dns-zone-group create \
  --endpoint-name "$PE_NAME" \
  --resource-group "$RG" \
  --name "default" \
  --private-dns-zone "$ZONE_ID" \
  --zone-name "privatelink" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

7. Verify the fix, and then rerun [Step 1](#step-1).

```azurecli-interactive
[ -z "$SERVICE_FQDN" ] && read -rp "Service FQDN: " SERVICE_FQDN

echo "=== Verifying DNS now resolves to private IP ==="
nslookup "$SERVICE_FQDN" 2>&1
```

The FQDN now shows a CNAME for `*.privatelink.*`, and resolves to the private endpoint network adapter IP (for example, `10._x.x.x_`). If the problem continues, and you use a custom DNS server, make sure that it forwards `privatelink.*` queries to Azure DNS at `168.63.129.16`.

## Resolution B

The private endpoint connection is in a `Pending`, `Rejected`, or `Disconnected` state. Traffic can't flow through a private endpoint until the resource owner approves the connection.

Run the following commands in Azure CLI.

1. List the private endpoint connections on the target resource to identify the connection name:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Service Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Service Name (Storage account or Key Vault): " SERVICE_NAME
[ -z "$SERVICE_TYPE" ] && read -rp "Service Type (Microsoft.Storage/storageAccounts or Microsoft.KeyVault/vaults): " SERVICE_TYPE

az network private-endpoint-connection list \
  --name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --type "$SERVICE_TYPE" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, status:properties.privateLinkServiceConnectionState.status, description:properties.privateLinkServiceConnectionState.description, peId:properties.privateEndpoint.id}" \
  --output table
```

Note the connection `name` that shows `Pending` or `Rejected`.

2. Approve the private endpoint connection.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Service Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Service Name: " SERVICE_NAME
[ -z "$SERVICE_TYPE" ] && read -rp "Service Type (Microsoft.Storage/storageAccounts or Microsoft.KeyVault/vaults): " SERVICE_TYPE
[ -z "$PE_CONN_NAME" ] && read -rp "PE Connection Name (from B.1): " PE_CONN_NAME

az network private-endpoint-connection approve \
  --name "$PE_CONN_NAME" \
  --resource-name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --type "$SERVICE_TYPE" \
  --description "Approved via AEGT troubleshooting" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

3. Verify the fix and then rerun [Step 2](#step-2):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "PE Resource Group: " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "privateLinkServiceConnections[].privateLinkServiceConnectionState.status" \
  --output tsv 2>&1 || \
az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "manualPrivateLinkServiceConnections[].privateLinkServiceConnectionState.status" \
  --output tsv
```

The expected output is `Approved`. If the connection still shows `Pending`, the approving identity might lack `Microsoft.Storage/storageAccounts/privateEndpointConnectionsApproval/action` or `Microsoft.KeyVault/vaults/privateEndpointConnectionsApproval/action` permissions.

## Resolution C

Network connectivity through the private endpoint is working correctly (DNS resolves to private IP and the connection is `Approved`), but the calling identity lacks data-plane permission. For Azure Storage, this condition means that a role is missing, such as `Storage Blob Data Reader` or `Storage Blob Data Contributor`. For Key Vault, this condition means the identity isn't in the access policy or lacks a Key Vault RBAC role.

Run the following commands in Azure CLI.

1. Choose and run the appropriate fix.

**Option 1: Check the permission model and access policies (Key Vault):**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Key Vault Name: " SERVICE_NAME

echo "=== Permission model (vault access policy vs. RBAC) ==="
az keyvault show \
  --name "$SERVICE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{enableRbacAuthorization:properties.enableRbacAuthorization, accessPolicies:properties.accessPolicies[].{objectId:objectId, tenantId:tenantId, permissions:permissions}}" \
  --output json
```

**Option 2: Check RBAC roles for the calling identity (Azure Storage)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Storage Account Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Storage Account Name: " SERVICE_NAME
[ -z "$CALLER_OBJECT_ID" ] && read -rp "Calling identity Object ID: " CALLER_OBJECT_ID

STORAGE_ID=$(az storage account show \
  --name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

echo "=== Role assignments on this Storage account for the caller ==="
az role assignment list \
  --scope "$STORAGE_ID" \
  --assignee "$CALLER_OBJECT_ID" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{role:roleDefinitionName, scope:scope}" \
  --output table
```

2. Assign the appropriate data-plane role.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

**Azure Storage**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Storage Account Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Storage Account Name: " SERVICE_NAME
[ -z "$CALLER_OBJECT_ID" ] && read -rp "Calling identity Object ID: " CALLER_OBJECT_ID
[ -z "$DATA_ROLE" ] && read -rp "Role to assign (e.g. Storage Blob Data Reader): " DATA_ROLE

STORAGE_ID=$(az storage account show \
  --name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az role assignment create \
  --role "$DATA_ROLE" \
  --assignee-object-id "$CALLER_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --scope "$STORAGE_ID" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

**Key Vault**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Key Vault Name: " SERVICE_NAME
[ -z "$CALLER_OBJECT_ID" ] && read -rp "Calling identity Object ID: " CALLER_OBJECT_ID

az keyvault set-policy \
  --name "$SERVICE_NAME" \
  --object-id "$CALLER_OBJECT_ID" \
  --secret-permissions get list \
  --key-permissions get list \
  --subscription "$SUBSCRIPTION" \
  --output json
```

3. Verify the fix, and then rerun [Step 4](#step-4) for the data-plane read. 

Allow up to 5 minutes for RBAC propagation before you test.

## Resolution D

The calling client (such as the Azure portal, a Continuous Integration (CI) and Continuous Delivery (CD) pipeline agent, or a developer workstation) is outside the VNet and `publicNetworkAccess` is disabled on the target resource. The service correctly blocks all traffic that doesn't arrive through a private endpoint.

Run the following commands in Azure CLI.

1. *Determine which access pattern applies:

| Scenario | Recommended fix |
|---|---|
| Developer accessing from local workstation. | Use an Azure Bastion jump-server or Azure Bastion VM inside the VNet, or add your client IP to the firewall temporarily. |
| CI or CD pipeline agent (Azure DevOps hosted). | Use a self-hosted agent deployed inside the VNet that has private endpoint connectivity. |
| Azure portal operations. | Enable **Allow trusted Microsoft services** bypass (this doesn't compromise private endpoint security). |

2. Choose and run the appropriate fix.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

**Option 1: Temporarily add a client IP to the firewall (Azure Storage)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_RG" ] && read -rp "Storage Account Resource Group: " SERVICE_RG
[ -z "$SERVICE_NAME" ] && read -rp "Storage Account Name: " SERVICE_NAME
[ -z "$CLIENT_IP" ] && read -rp "Client public IP to allow (x.x.x.x): " CLIENT_IP

az storage account network-rule add \
  --account-name "$SERVICE_NAME" \
  --resource-group "$SERVICE_RG" \
  --ip-address "$CLIENT_IP" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

**Option 2: Enable trusted services bypass (Key Vault)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$SERVICE_NAME" ] && read -rp "Key Vault Name: " SERVICE_NAME

az keyvault update \
  --name "$SERVICE_NAME" \
  --bypass AzureServices \
  --subscription "$SUBSCRIPTION" \
  --output json
```

3. Verify the fix, and then retry the data-plane operation from the external client. Allow up to five minutes for `Storage IP` rules to propagate before testing. If access is now working, consider migrating to a long-term architecture (such as a self-hosted agent inside VNet or Azure Bastion jump-servers) instead of leaving the IP exception permanently configured.

## References

- [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview)
- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)
- [Troubleshoot Azure Private Endpoint connectivity problems](/azure/private-link/troubleshoot-private-endpoint-connectivity)
- [Configure Azure Storage firewalls and virtual networks](/azure/storage/common/storage-network-security)
- [Configure Azure Key Vault networking settings](/azure/key-vault/general/how-to-azure-key-vault-network-security)
