---
title: Troubleshoot private endpoint DNS resolution failure in Azure Private Link
description: Learn to resolve private endpoint DNS issues where FQDNs resolve to public IPs or return NXDOMAIN. Follow our step-by-step diagnostics guide.
ms.service: azure-private-link
ms.topic: troubleshooting
ms.custom: sap:Private Endpoints
ms.date: 6/12/2026
ai.hint.symptom-tags:
  - dns-resolution-failure
  - private-endpoint-public-ip
  - nxdomain
  - private-dns-zone-not-linked
  - missing-a-record
  - conditional-forwarder-misconfigured
  - privatelink-zone-override
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateEndpoints/read
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/write
  - Microsoft.Network/privateDnsZones/A/write
  - Microsoft.Network/networkInterfaces/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - PE_NAME
  - DNS_ZONE_NAME
  - VNET_NAME
  - FQDN
---

# Troubleshoot private endpoint DNS resolution failure in Azure Private Link

## Summary

This article provides step-by-step diagnostics to identify and resolve problems where a private endpoint fully-qualified domain name (FQDN) resolves to a public IP or returns NXDOMAIN from a virtual network (VNet) or on-premises network. 

A private endpoint FQDN resolving to a public IP (or returning NXDOMAIN) is usually caused by these reasons: 

- The private DNS zone isn't linked to the querying VNet (the most common reason). 
- The A record is missing or stale. 
- Custom Domain Name System (DNS) or conditional forwarders aren't forwarding `privatelink.*` queries to Azure DNS (for example, `168.63.129.16`). 
- The private DNS zone overrides the entire namespace causing NXDOMAIN for resources without A records. 

## Symptoms

You might encounter one or more of the following symptoms:

- `nslookup` or `dig` values for a private endpoint FQDN return a public IP instead of a private IP (for example, `10.x`, `172.16–31.x`, or `192.168.x`).
- `nslookup` returns `** server can't find [FQDN]: NXDOMAIN` from inside the VNet.
- The application receives `403 Forbidden` or `TCP connection does not allow access` errors when connecting to a platform-as-a-service (PaaS) that has firewall rules denying public access. The FQDN then resolves to the public endpoint.
- The [Azure portal](https://portal.azure.com) shows the private endpoint status as **Approved** but connectivity from the VNet still fails.
- On-premises clients can't reach the private endpoint even though the VPN or Azure ExpressRoute link is healthy.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required**: `Reader` role on the private endpoint resource group and private DNS zone, and `Private DNS Zone Contributor` permissions for write operations.
- **Tools**: Azure CLI 2.x or an AI agent with Azure MCP or Azure CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the private endpoint | `myResourceGroup` |
| `{PE_NAME}` | Private endpoint resource name | `myPrivateEndpoint` |
| `{DNS_ZONE_NAME}` | Private DNS zone name (for example, `privatelink.blob.core.windows.net`) | `privatelink.blob.core.windows.net` |
| `{VNET_NAME}` | VNet that needs DNS resolution | `myVNet` |
| `{FQDN}` | The FQDN that should resolve to the private endpoint IP | `mystorageaccount.blob.core.windows.net` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check what IP address the FQDN currently resolves to. Determine whether the problem is confirmed, and whether it resolves to public, private, or not at all.

Run the following commands in Azure CLI or a command line interface (CLI) tool:

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$FQDN" ] && read -rp "FQDN to resolve (e.g. mystorageaccount.blob.core.windows.net): " FQDN

echo "--- Resolving $FQDN ---"
nslookup "$FQDN"
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Response contains a public IP (not in `10.x`, `172.16–31.x`, or `192.168.x` ranges). | DNS is resolving to the public endpoint. Private DNS isn't used. | Perform [Step 2](#step-2) |
| Response contains a private IP (in `10.x`, `172.16–31.x`, or `192.168.x` ranges). | DNS resolution is correct. The problem is elsewhere (such as routing, network security groups (NSGs), or a service firewall). | DNS is working. Investigate network connectivity separately. |
| `** server can't find [FQDN]: NXDOMAIN`. | The DNS zone is intercepting the query but has no matching A record. | Perform [Step 2](#step-2). |
| `connection timed out; no servers could be reached`. | DNS server itself is unreachable. | Verify your DNS server configuration (custom DNS virtual machine (VM) may be down). |

### Step 2

Check whether the private endpoint exists, is in Approved state, and what private IP is assigned to it.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, connectionStatus:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status, nicId:networkInterfaces[0].id, customDnsConfigs:customDnsConfigs}" \
  --output json
```

Then, retrieve the private IP from the network adapter (also known as a network interface card (NIC)):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

NIC_ID=$(az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkInterfaces[0].id" \
  --output tsv)

az network nic show \
  --ids "$non_ID" \
  --query "ipConfigurations[].{name:name, privateIpAddress:privateIPAddress, fqdns:privateLinkConnectionProperties.fqdns}" \
  --output json
```

Record the private IP (for example, `10.0.1.5`). This is the IP that the FQDN should resolve to.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `connectionStatus: "Approved"`. and a private IP is listed. | Private endpoint is healthy. DNS configuration is the problem. | Perform [Step 3](#step-3). |
| `connectionStatus: "Pending"`. | Private endpoint connection not yet approved by the resource owner. | Approve the connection on the target resource and then retest DNS. |
| `connectionStatus: "Rejected"`. | Private endpoint was explicitly rejected. | Contact the resource owner to approve the connection. |
| `ResourceNotFound` error. | Private endpoint name or resource group is incorrect.| Verify your variables and rerun. |

### Step 3

Check whether a private DNS zone exists for the correct `privatelink.*` namespace and whether it contains an A record pointing to the private endpoint IP.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group (may differ from PE RG): " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name (e.g. privatelink.blob.core.windows.net): " DNS_ZONE_NAME

az network private-dns record-set a list \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{Name:name, TTL:ttl, IPv4Address:aRecords[0].ipv4Address}" \
  --output table
```

Look for an A record whose name matches the short name of the failing FQDN (the part before `.privatelink.*`). For example, if the failing FQDN is `mystorageaccount.blob.core.windows.net`, look for an A record that's named `mystorageaccount`.

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| A record exists for the failing FQDN's short name and IP matches the private endpoint IP from [Step 2](#step-2). | DNS record is correct. The zone might not be linked to the querying VNet. | Perform [Step 4](#step-4). |
| A record exists but IP doesn't match the private endpoint IP. | Stale or incorrect A record. | Perform [Resolution B](#resolution-b). |
| No A record exists for the failing FQDN's short name but other A records exist in the zone for different resources. | The zone intercepts the entire namespace but has no record for this specific resource. There's a namespace override. | Perform  [Resolution D](#resolution-d). |
| No A records exist at all in the zone. | A record was never created or was autodeleted. | Perform  [Resolution B](#resolution-b). |
| `ResourceNotFound`. Zone doesn't exist. | Private DNS zone doesn't exist in this resource group. | Search across all resource groups: `az network private-dns zone list --subscription "$SUBSCRIPTION" --output table`. If the zone is still missing, perform [Resolution B](#resolution-b). |

### Step 4

Check whether the private DNS zone is linked to the VNet from which DNS queries originate.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME

az network private-dns link vnet list \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| Your querying VNet appears in the list with `virtualNetworkLinkState: Completed`. | Zone is linked to this VNet. If problems persist, the VNet is using a custom DNS. | Perform [Step 5](#step-5). |
| Your querying VNet isn't in the list. | Zone isn't linked to the querying VNet and queries bypass private DNS. | Perform [Resolution A](#resolution-a). |
| List is empty (no VNet links at all). | Zone has no VNet links and can't serve any queries. | Perform [Resolution A](#resolution-a). |
| `virtualNetworkLinkState: InProgress`. | Link is still provisioning. | Wait 1–2 minutes and rerun. |

### Step 5

Check whether the VNet uses custom DNS servers (instead of Azure-provided DNS) and whether those custom servers forward `privatelink.*` queries to Azure DNS (168.63.129.16).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group: " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, dnsServers:dhcpOptions.dnsServers}" \
  --output json
```

### Interpret the results

| Observation | Meaning | Next steps |
|---|---|---|
| `"dnsServers": []` or `"dnsServers": null` and [Step 1](#step-1) returned NXDOMAIN. | VNet uses Azure-provided DNS and zone is linked, but the FQDN still returns NXDOMAIN. The zone is overriding the namespace for a resource without an A record. | Perform [Resolution D](#resolution-d). |
| `"dnsServers": []` or `"dnsServers": null` and [Step 1](#step-1) returned a public IP. | VNet uses Azure-provided DNS. Zone link and A record are correct but resolution still returns public IP. Flush local DNS cache (`ipconfig /flushdns`) and rerun [Step 1](#step-1) from a VM inside this VNet. | Flush DNS cache and retest. If public IP still returns after flush, file an Azure support request. |
| `"dnsServers": ["10.x.x.x", ...]` (custom DNS IPs). | VNet uses custom DNS. Those servers must forward `privatelink.*` to `168.63.129.16`. | Perform [Resolution C](#resolution-c). |
| `"dnsServers": ["168.63.129.16"]`. | VNet explicitly uses Azure DNS. This configuration is equivalent to the default. Zone links should work. | Rerun [Step 1](#step-1). If NXDOMAIN persists, perform [Resolution D](#resolution-d). If public IP persists, file an Azure support request. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| [Step 1](#step-1): FQDN resolves to private IP. | DNS is correct. Investigate network path separately. |
| [Step 1](#step-1): FQDN resolves to public IP and [Step 4](#step-4): VNet not linked to zone. | Perform [Resolution A](#resolution-a). |
| [Step 1](#step-1): NXDOMAIN and [Step 3](#step-3): No A records exist at all. | Perform [Resolution B](#resolution-b). |
| [Step 1](#step-1): NXDOMAIN and [Step 3](#step-3): No A record for failing FQDN, but other records exist in zone. | Perform [Resolution D](#resolution-d). |
| [Step 1](#step-1): FQDN resolves to public IP and [Step 3](#step-3): A record IP mismatch. | Perform [Resolution B](#resolution-b). |
| [Step 1](#step-1): FQDN resolves to public IP and [Step 4](#step-4): VNet linked and [Step 5](#step-5): Custom DNS configured. | Perform [Resolution C](#resolution-c). |
| [Step 1](#step-1): NXDOMAIN and [Step 3](#step-3): A record exists for failing FQDN and [Step 4](#step-4): VNet linked and [Step 5](#step-5): Azure DNS (default). | Perform [Resolution D](#resolution-d). |
| [Step 1](#step-1): FQDN resolves to public IP and [Step 4](#step-4): VNet linked and [Step 5](#step-5): Azure DNS and cache flushed. | File an Azure support request. |
| [Step 2](#step-2): Private endpoint connection Pending/Rejected. | Approve or re-create the private endpoint connection. |
| All diagnostics pass but problems persist. | File an Azure support request. |

## Resolution A

The private DNS zone exists and contains the correct A record, but it isn't linked to the VNet from which DNS queries originate. Without a VNet link, Azure DNS can't consult the private zone, and returns the public IP from the service's public DNS.

Run the following commands in Azure CLI (when applicable).

1. Verify the VNet resource ID:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group: " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" \
  --output tsv
```

Record the VNet resource ID.

2. Create the VNet link on the private DNS zone.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group:   " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:             " VNET_NAME
[ -z "$LINK_NAME" ] && read -rp "Link Name (e.g. link-to-myVNet): " LINK_NAME

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az network private-dns link vnet create \
  --name "$LINK_NAME" \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --virtual-network "$VNET_ID" \
  --registration-enabled false
```

> [!NOTE]
> Set `--registration-enabled false` for private endpoint zones. Autoregistration is designed for VM DNS records, not private endpoints.

3. Verify the fix, and then rerun [Step 1](#step-1):

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$FQDN" ] && read -rp "FQDN to resolve: " FQDN

nslookup "$FQDN"
```

The FQDN should now resolve to the private IP from [Step 2](#step-2). If it still resolves to a public IP, allow 1–2 minutes for propagation and retry.

If the VNet uses custom DNS servers, this fix alone is insufficient. Go to [Resolution C](#resolution-c).

## Resolution B

The A record in the private DNS zone is missing, stale (pointing to a deleted endpoint's IP), or was never created. This problem occurs when you create the private endpoint without a DNS zone group, delete a sibling endpoint that shared the zone and triggered autocleanup, or manually create the zone without adding the record.

Run the following commands in Azure CLI (as applicable).

1. Get the private endpoint's expected private IP and FQDN:

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME

az network private-endpoint show \
  --name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "customDnsConfigs[].{fqdn:fqdn, ipAddresses:ipAddresses}" \
  --output json
```

Record the FQDN (the short name before `privatelink.*`) and the IP address.

For example, if the target is `mystorageaccount.blob.core.windows.net`:

- The A record name in zone `privatelink.blob.core.windows.net` is `mystorageaccount`.
- The IP is the private IP from the NIC (for example, `10.0.1.5`).

2. Add the A record to the private DNS zone.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

**Option 1: Create the  A record manually (immediate fix)**

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$RECORD_NAME" ] && read -rp "A Record Name (e.g. mystorageaccount): " RECORD_NAME
[ -z "$PE_PRIVATE_IP" ] && read -rp "Private Endpoint IP (from B.1): " PE_PRIVATE_IP

az network private-dns record-set a add-record \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --record-set-name "$RECORD_NAME" \
  --ipv4-address "$PE_PRIVATE_IP"
```

**Option 2: Create a DNS zone group (recommended for ongoing automanagement)**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$PE_NAME" ] && read -rp "Private Endpoint Name: " PE_NAME
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME

DNS_ZONE_ID=$(az network private-dns zone show \
  --name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az network private-endpoint dns-zone-group create \
  --endpoint-name "$PE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "default" \
  --zone-name "$DNS_ZONE_NAME" \
  --private-dns-zone "$DNS_ZONE_ID"
```

A DNS zone group automatically creates and manages A records when you create the private endpoint or change its IP. This approach is recommended for new deployments.

3. Verify the fix, and then rerun [Step 1](#step-1).

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$FQDN" ] && read -rp "FQDN to resolve: " FQDN

nslookup "$FQDN"
```

The FQDN should now resolve to the private endpoint IP. If it still returns NXDOMAIN or a public IP, check the VNet link ([Step 4](#step-4)). The zone might not be linked.

## Resolution C

The VNet uses custom DNS servers, such as Active Directory domain controllers, on-premises DNS servers, or a custom DNS VM. These custom servers don't forward `privatelink.*` queries to Azure DNS (`168.63.129.16`), so the private DNS zone is never consulted.

This issue is the most common cause of problems for on-premises clients that connect through VPN or ExpressRoute.

Run the following commands in Azure CLI (when applicable).

1. Identify the custom DNS servers:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group: " VNET_RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "dhcpOptions.dnsServers" \
  --output json
```

Record the custom DNS server IPs.

2. Configure conditional forwarders on the custom DNS server.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

This step is performed on the custom DNS server (not by using Azure CLI). Configure a conditional forwarder for the `privatelink.*` zone that forwards to `168.63.129.16`:

**Windows DNS Server**

1. Open DNS Manager.
2. Right-click **Conditional Forwarders** > **New Conditional Forwarder**.
3. For **DNS Domain**, enter the private link zone name, such as `privatelink.blob.core.windows.net`.
4. For **IP address**, enter `168.63.129.16`.
5. Select **OK**.

**BIND (Linux)**

Add the following to `/etc/bind/named.conf.local` (or your site-specific configuration file):

```text
zone "privatelink.blob.core.windows.net" {
    type forward;
    forwarders { 168.63.129.16; };
};
```

> [!IMPORTANT]
> The IP `168.63.129.16` is only reachable from within an Azure VNet. If your DNS server is on-premises (not in Azure), you need an Azure DNS Private Resolver inbound endpoint or a DNS forwarder VM inside the VNet that can reach `168.63.129.16`.

**Alternative - Deploy Azure DNS Private Resolver (recommended for hybrid scenarios)**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp "Resolver Resource Group: " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "DNS Resolver Name: " RESOLVER_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:       " VNET_NAME
[ -z "$VNET_RG" ] && read -rp "VNet Resource Group: " VNET_RG
[ -z "$INBOUND_SUBNET" ] && read -rp "Inbound Endpoint Subnet Name: " INBOUND_SUBNET

VNET_ID=$(az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

SUBNET_ID=$(az network vnet subnet show \
  --name "$INBOUND_SUBNET" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az dns-resolver create \
  --name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --location $(az network vnet show --name "$VNET_NAME" --resource-group "$VNET_RG" --subscription "$SUBSCRIPTION" --query "location" --output tsv) \
  --id "$VNET_ID"

az dns-resolver inbound-endpoint create \
  --name "inbound-endpoint" \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --ip-configurations "[{private-ip-allocation-method:Dynamic,id:$SUBNET_ID}]"
```

After you deploy the inbound endpoint, configure on-premises DNS to forward `privatelink.*` queries to the inbound endpoint's private IP (retrieve with `az dns-resolver inbound-endpoint show`).

3. Verify the fix, and then rerun [Step 1](#step-1) from the affected client.

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$FQDN" ] && read -rp "FQDN to resolve: " FQDN

nslookup "$FQDN"
```

The FQDN should now resolve to the private endpoint IP. On Windows clients, flush the DNS cache by running `ipconfig /flushdns`.

## Resolution D

A private DNS zone for the `privatelink.*` namespace is linked to the VNet and overrides all names in that namespace. Resources that don't have an A record in the zone return NXDOMAIN instead of passing through to a public DNS. This condition commonly occurs when you create the zone for one private endpoint, but other resources in the same service namespace (that aren't private endpoints) also have to resolve.

Run the following commands in Azure CLI (when applicable).

1. List all A records in the zone and identify which resource is missing:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME

az network private-dns record-set a list \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{Name:name, TTL:ttl, IPv4Address:aRecords[0].ipv4Address}" \
  --output table
```

Identify the resource FQDN that's returning NXDOMAIN. If it's a resource that should resolve publicly (not a private endpoint), it won't have an A record here.

2. Use one of the following fixes, as appropriate:

**Option 1: Enable NxDomainRedirect on the VNet link (recommended)**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (from Step 4 output): " LINK_NAME

az network private-dns link vnet update \
  --name "$LINK_NAME" \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --resolution-policy NxDomainRedirect
```

With `NxDomainRedirect`, if a query to the private DNS zone returns NXDOMAIN, Azure DNS falls back to public resolution. This approach allows nonprivate endpoint resources in the same namespace to resolve normally.

**Option 2: Add explicit A records for nonprivate endpoint resources that need to resolve**

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:      " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "DNS Zone Resource Group: " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$RECORD_NAME" ] && read -rp "Record Name (e.g. otherresource): " RECORD_NAME
[ -z "$PUBLIC_IP" ] && read -rp "Public IP of the resource: " PUBLIC_IP

az network private-dns record-set a add-record \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --record-set-name "$RECORD_NAME" \
  --ipv4-address "$PUBLIC_IP"
```

> [!NOTE]
> **Option 2** requires manual maintenance when resource IPs change. **Option 1** (`NxDomainRedirect`) is preferred.

3. Verify the fix, and then rerun [Step 1](#step-1) for the affected FQDN.

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$FQDN" ] && read -rp "FQDN to resolve: " FQDN

nslookup "$FQDN"
```

The resource should now resolve correctly. Private endpoints resolve to their private IP, and nonprivate endpoint resources resolve through public DNS fallback.

## References

- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)
- [Azure Private DNS zone overview](/azure/dns/private-dns-overview)
- [Azure DNS Private Resolver](/azure/dns/dns-private-resolver-overview)
- [Integrate Private Link with Azure DNS Private Resolver](/azure/private-link/private-endpoint-dns-integration)
- [Virtual network links on private DNS zones](/azure/dns/private-dns-virtual-network-links)
- [Troubleshoot Azure Private Endpoint connectivity problems](/azure/private-link/troubleshoot-private-endpoint-connectivity)
