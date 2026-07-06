---
title: Troubleshoot DNS resolution failures in Azure
description: Diagnose and fix DNS resolution failures in Azure caused by conditional forwarder, custom DNS, or Private Resolver ruleset issues. Start troubleshooting now.
ms.service: azure-dns
ms.topic: troubleshooting
ms.date: 6/17/2026
ai.hint.symptom-tags:
  - dns-resolution-failure
  - conditional-forwarder
  - private-endpoint-dns
  - nslookup-timeout
  - nxdomain
  - private-resolver
  - dns-proxy
  - custom-dns-server
  - forwarding-ruleset
  - port-53-blocked
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/virtualNetworks/read
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/dnsResolvers/read
  - Microsoft.Network/dnsForwardingRulesets/read
  - Microsoft.Network/dnsForwardingRulesets/forwardingRules/read
  - Microsoft.Network/networkSecurityGroups/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - VNET_NAME
  - DNS_ZONE_NAME
  - FQDN_TO_RESOLVE
---

# Troubleshoot DNS resolution failures caused by conditional forwarder misconfiguration in Azure

## Summary

This article provides step-by-step diagnostics to identify and resolve DNS resolution failures caused by misconfigured conditional forwarders, custom DNS servers, or Azure DNS Private Resolver forwarding rulesets. 

DNS resolution failures for private endpoint names, custom domains, or Azure-hosted services most commonly happen due to these reasons: 

- Custom DNS servers (like Active Directory Domain Services (AD DS), Azure Firewall DNS Proxy, or non-Microsoft appliances) don't forward private-zone queries to Azure DNS or Azure DNS Private Resolver.
- On-premises resolvers attempt to query 168.63.129.16 directly (even though that address is only reachable from inside an Azure virtual network (VNet)). 
- Firewalls, network security groups (NSGs), or routing rules block User Datagram Protocol (UDP) or Transmission Control Protocol (TCP) 53 between the querying host and its configured Domain Name System (DNS) target.

## Symptoms

You might encounter one or more of the following symptoms:

- `nslookup` or `dig` for a private endpoint fully qualified domain name (FQDN) (for example, `myaccount.blob.core.windows.net`) returns `NXDOMAIN` or the public IP instead of the expected private IP.
- DNS queries from virtual machines (VMs) using custom DNS servers time out or return `SERVFAIL`.
- On-premises hosts can't resolve Azure private-zone names despite a VPN or ExpressRoute connection being established.
- Resolution works from Azure Cloud Shell (which uses Azure-provided DNS) but fails from a VM in the same VNet.
- Azure Firewall DNS proxy logs show forwarding failures or upstream timeouts.
- Intermittent DNS failures occur. Some queries succeed while others time out or return incorrect answers.

## Prerequisites

To troubleshoot this issue, you need the following items:

- **Permissions required:** `Reader` role on the VNet resource group and Private DNS zone resource group, or equivalent read permissions.
- **Tools:** Azure CLI 2.x or an AI agent with Azure CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `$RG` | Resource group containing the VNet where resolution fails | `myNetworkRG` |
| `$VNET_NAME` | Virtual network name where the querying VM resides | `myVNet` |
| `$DNS_ZONE_RG` | Resource group containing the Private DNS zone | `myDnsRG` |
| `$DNS_ZONE_NAME` | Private DNS zone name (for example, `privatelink.blob.core.windows.net`) | `privatelink.blob.core.windows.net` |
| `$FQDN` | The FQDN that fails to resolve | `myaccount.blob.core.windows.net` |


> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check what DNS servers the VNet is configured to use, either Azure-provided (168.63.129.16) or custom DNS servers.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (VNet): " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name: " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, dnsServers:dhcpOptions.dnsServers}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `"dnsServers": []` or `"dnsServers": null`. | VNet uses Azure-provided DNS (168.63.129.16). Forwarding isn't the issue. | Perform [Step 2a](#step-2a) to check Private DNS zone links. |
| `"dnsServers": ["10.x.x.x", ...]`. | VNet uses custom DNS servers. All queries go to these IPs first. | Perform [Step 3a](#step-3a) to check if custom DNS forwards correctly. |
| `ResourceNotFound` error. | Subscription, resource group, or VNet name is incorrect. | Verify your variables and re-run. |

### Step 2a

Check whether the Private DNS zone that should answer the query is linked to the querying VNet.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Resource Group (DNS Zone): " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME

az network private-dns link vnet list \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, vnetId:virtualNetwork.id, registrationEnabled:registrationEnabled, provisioningState:provisioningState}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Your VNet appears in the list with `provisioningState: Succeeded`. | Zone is linked to the querying VNet. | Perform [Step 2b](#step-2b) to verify the A record exists. |
| Your VNet doesn't appear in the list. | The zone isn't linked. Azure DNS can't serve this zone to your VNet. | Perform [Resolution B](#resolution-b). |
| All links show `provisioningState: Failed`. | Zone links are broken. | Perform [Resolution B](#resolution-b). |

### Step 2b

Check whether the expected A record exists in the Private DNS zone for the queried hostname.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Resource Group (DNS Zone): " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$FQDN" ] && read -rp "FQDN to resolve: " FQDN

# Extract the record name (hostname minus the zone suffix)
# Handles both public FQDN (myaccount.blob.core.windows.net) and
# privatelink FQDN (myaccount.privatelink.blob.core.windows.net)
if [[ "$FQDN" == *".$DNS_ZONE_NAME" ]]; then
  RECORD_NAME="${FQDN%%.$DNS_ZONE_NAME}"
else
  RECORD_NAME="${FQDN%%.*}"
fi

az network private-dns record-set a show \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RECORD_NAME" \
  --query "{name:name, fqdn:fqdn, ipAddresses:aRecords[].ipv4Address, ttl:ttl}" \
  --output json 2>&1
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Record returned with correct private IP (for example, `10.x.x.x`). | Record exists and zone configuration is correct. The issue is in the forwarding path. | Perform [Step 3a](#step-3a). |
| `ResourceNotFound` error. | The A record doesn't exist in this zone. | Create the missing A record or verify the private endpoint DNS zone group is configured. |
| Record exists but IP is wrong. | Record is stale or points to the wrong endpoint. | Update the A record to the correct private IP. |

### Step 3a

Check whether an Azure DNS Private Resolver and forwarding ruleset are deployed and whether the ruleset is linked to the querying VNet.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (VNet): " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name: " VNET_NAME

az dns-resolver forwarding-ruleset list \
  --resource-group "$RG" \
  --virtual-network-name "$VNET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json 2>&1
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Non-empty JSON array containing one or more objects with an `id` field. | A forwarding ruleset is linked to this VNet. Note the ruleset name from the last segment of the `id` path. | Perform [Step 4](#step-4) to inspect forwarding rules. |
| `[]` (empty array) or error `No registered resource provider found`. | No forwarding ruleset is linked to this VNet. | Perform [Step 3b](#step-3b) to check if an Azure DNS Private Resolver exists at all. |

### Step 3b

Check whether an Azure DNS Private Resolver exists in the resource group and is operational.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (Resolver): " RG

az dns-resolver list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, vnet:virtualNetwork.id}" \
  --output table 2>&1
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| Azure DNS Private Resolver listed with `state: Succeeded`. | Azure DNS Private Resolver exists and is healthy. | Perform [Resolution C](#resolution-c) as the ruleset isn't linked to the querying VNet. |
| Empty result. | No Azure DNS Private Resolver deployed in this resource group. | Perform [Resolution A](#resolution-a). The custom DNS isn't forwarding to any Azure DNS target. |
| `state: Failed`. | Azure DNS Private Resolver deployment is broken. | Redeploy Azure DNS Private Resolver. |

### Step 4

Check whether the forwarding ruleset contains a rule for the domain namespace you're trying to resolve and whether the target DNS servers in that rule are correct and reachable.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (Ruleset): " RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name (from Step 3): " RULESET_NAME

az dns-resolver forwarding-rule list \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, domain:domainName, state:forwardingRuleState, targets:targetDnsServers[].{ip:ipAddress, port:port}}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| A rule exists for the failing domain (for example, `blob.core.windows.net.`) with `state: Enabled` and targets point to reachable IPs. | Forwarding rule is configured and enabled. | Perform [Step 5](#step-5) to test reachability to target DNS servers. |
| No rule matches the failing domain namespace. | No forwarding rule covers this domain. Queries fall through to default resolution. | Perform [Resolution A](#resolution-a). |
| Rule exists but `state: Disabled`. | Rule is disabled and queries aren't forwarded. | Perform [Resolution A](#resolution-a) to enable the rule. |
| Rule targets point to `168.63.129.16`. | Rule forwards to Azure-provided DNS (valid only from within Azure VNets). | Perform [Step 5](#step-5) to test reachability to target DNS servers. |
| Rule targets point to on-premises IPs. | Rule is forwarding to on-premises instead of Azure DNS. | Perform [Resolution A](#resolution-a) to correct the target. |

### Step 5

Check whether UDP or TCP port 53 is open between the querying subnet and the DNS target servers identified in the forwarding rule or custom DNS configuration. This check also verifies if any NSG rules block DNS traffic.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (VNet): " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name: " VNET_NAME

# List NSGs associated with subnets in this VNet
az network vnet subnet list \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{subnet:name, nsg:networkSecurityGroup.id}" \
  --output table
```

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_RG" ] && read -rp "Resource Group (NSG): " NSG_RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name (from above): " NSG_NAME

az network nsg rule list \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --include-default \
  --query "[?destinationPortRange=='53' || destinationPortRange=='*'].{name:name, priority:priority, access:access, direction:direction, protocol:protocol, source:sourceAddressPrefix, dest:destinationAddressPrefix}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| No `Deny` rules match port 53 outbound from the querying subnet. | NSG isn't blocking DNS traffic. | Perform [Step 6](#step-6). |
| A `Deny` rule with higher priority blocks port 53 outbound. | NSG is blocking DNS queries. | Perform [Resolution D](#resolution-d). |
| No explicit `Allow` for port 53 and a low-priority `DenyAll` exists. | DNS traffic is implicitly blocked. | Perform [Resolution D](#resolution-d). |

### Step 6

Check whether the Azure DNS Private Resolver inbound endpoints are healthy and have IP addresses assigned. This check confirms that forwarding targets are reachable from the Azure side.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp "Resource Group (Resolver): " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "DNS Resolver Name: " RESOLVER_NAME

az dns-resolver inbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, ip:ipConfigurations[0].privateIpAddress, subnet:ipConfigurations[0].subnet.id}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next step |
|---|---|---|
| Endpoints listed with `state: Succeeded` and a private IP assigned. | Inbound endpoints are healthy. | If all prior steps pass, the forwarding chain is intact. Verify the querying VM's DNS client settings and flush its cache. |
| `state: Failed` or no IP assigned. | Inbound endpoint is broken. | Redeploy the inbound endpoint or check subnet delegation. |
| Empty result. | No inbound endpoints exist. | Perform [Resolution C](#resolution-c) to deploy an inbound endpoint. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| VNet uses Azure-provided DNS, the zone is linked, and a record exists. | Forwarding isn't the issue. Flush your DNS cache and retest. |
| VNet uses custom DNS and there's no forwarding rule for the domain. | Perform [Resolution A](#resolution-a). |
| VNet uses custom DNS and the forwarding rule targets 168.63.129.16 from outside of Azure. | Perform [Resolution A](#resolution-a). |
| Private DNS zone not linked to querying VNet. | Perform [Resolution B](#resolution-b). |
| Azure DNS Private Resolver exists but ruleset isn't linked to querying VNet. | Perform [Resolution C](#resolution-c). |
| No Azure DNS Private Resolver or inbound endpoint deployed. | Perform [Resolution C](#resolution-c).|
| An NSG or firewall is blocking port 53. | Perform [Resolution D](#resolution-d). |
| Forwarding rule targets include unhealthy upstream servers. | Perform [Resolution A](#resolution-a). |

## Resolution A

Custom DNS servers, Active Directory DNS, Azure Firewall DNS Proxy, or a non-Microsoft DNS appliance aren't forwarding queries for the private namespace to a target that can reach the Azure-provided DNS (168.63.129.16). Either no conditional forwarder exists, the forwarding rule targets are incorrect, or the targets are unhealthy.

Common causes include the following conditions:

- No forwarding rule exists for the `privatelink.*` namespace.
- Forwarding rule targets an on-premises server that can't reach 168.63.129.16.
- Forwarding rule targets include both healthy and unhealthy upstream IPs (intermittent failures).
- Azure Firewall DNS proxy is enabled but its upstream DNS is misconfigured.

Run the following commands in Azure CLI.

1. Confirm the domain name that needs a forwarding rule and identify the correct target IPs.

 The target must be either:

- An Azure DNS Private Resolver **inbound endpoint** private IP (if one is deployed).
- A DNS forwarder VM inside an Azure VNet that can reach 168.63.129.16.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp "Resource Group (Resolver): " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "DNS Resolver Name: " RESOLVER_NAME

# Get inbound endpoint IPs — these are valid forwarding targets
az dns-resolver inbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, ip:ipConfigurations[0].privateIpAddress}" \
  --output table
```

Record the private IPs from the output. These IPs are the correct forwarding targets.

2. Create or update the forwarding rule in the DNS forwarding ruleset to point to the correct target.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (Ruleset): " RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name: " RULESET_NAME
[ -z "$DOMAIN_NAME" ] && read -rp "Domain to forward (with trailing dot, e.g., blob.core.windows.net.): " DOMAIN_NAME
[ -z "$TARGET_IP" ] && read -rp "Target DNS IP (inbound endpoint IP from A.1): " TARGET_IP

az dns-resolver forwarding-rule create \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "forward-$(echo "$DOMAIN_NAME" | tr '.' '-' | sed 's/-$//')" \
  --domain-name "$DOMAIN_NAME" \
  --forwarding-rule-state "Enabled" \
  --target-dns-servers "[{ip-address:$TARGET_IP,port:53}]"
```

3. If the forwarding rule already exists but targets unhealthy IPs, update it to remove the bad targets.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (Ruleset): " RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name: " RULESET_NAME
[ -z "$RULE_NAME" ] && read -rp "Forwarding Rule Name (from Step 4): " RULE_NAME
[ -z "$TARGET_IP" ] && read -rp "Correct Target DNS IP: " TARGET_IP

az dns-resolver forwarding-rule update \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --target-dns-servers "[{ip-address:$TARGET_IP,port:53}]"
```

4. Re-run [Step 4](#step-4) to confirm the forwarding rule now shows the correct, healthy targets. Then test the resolution:

```bash
# Test from the affected VM or Cloud Shell
[ -z "$FQDN" ] && read -rp "FQDN to test: " FQDN
nslookup "$FQDN"
```

If the correct private IP is returned, the issue is resolved.

## Resolution B

The Private DNS zone isn't linked to the virtual network where the resolution is failing. Without a virtual network link, the Azure-provided DNS (168.63.129.16) can't serve zone records to hosts in that virtual network.

Run the following commands in Azure CLI.

1. Confirm which virtual network needs to be linked:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group (VNet): " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name: " VNET_NAME

az network vnet show \
  --name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, id:id}" \
  --output json
```

Record the virtual network resource ID from the output.

2. Create the virtual network link on the Private DNS zone.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$DNS_ZONE_RG" ] && read -rp "Resource Group (DNS Zone): " DNS_ZONE_RG
[ -z "$DNS_ZONE_NAME" ] && read -rp "Private DNS Zone Name: " DNS_ZONE_NAME
[ -z "$VNET_ID" ] && read -rp "VNet Resource ID (from B.1): " VNET_ID
[ -z "$LINK_NAME" ] && read -rp "Link Name (e.g., link-to-myvnet): " LINK_NAME

az network private-dns link vnet create \
  --zone-name "$DNS_ZONE_NAME" \
  --resource-group "$DNS_ZONE_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$LINK_NAME" \
  --virtual-network "$VNET_ID" \
  --registration-enabled false
```

3. Re-run [Step 2a](#step-2a). The new link should appear with `provisioningState: Succeeded`. Then test the resolution:

```bash
[ -z "$FQDN" ] && read -rp "FQDN to test: " FQDN
nslookup "$FQDN"
```

## Resolution C

The DNS forwarding ruleset isn't linked to the virtual network where queries originate, or you didn't deploy an inbound endpoint for the Azure DNS Private Resolver. Without the ruleset virtual network link, queries from that virtual network aren't subject to the forwarding rules.

Run the following commands in Azure CLI.

1. Identify the forwarding ruleset that should apply:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp "Resource Group (Resolver): " RESOLVER_RG

az dns-resolver forwarding-ruleset list \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, id:id}" \
  --output table
```

Record the ruleset name.

2. Link the forwarding ruleset to the querying virtual network.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp "Resource Group (Ruleset): " RESOLVER_RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name (from C.1): " RULESET_NAME
[ -z "$VNET_ID" ] && read -rp "VNet Resource ID to link: " VNET_ID
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (e.g., link-spoke-vnet): " LINK_NAME

az dns-resolver vnet-link create \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$LINK_NAME" \
  --id "$VNET_ID"
```

3. Re-run [Step 3a](#step-3a). The ruleset should now appear when listing rulesets for the querying virtual network. Then test the resolution:

```bash
[ -z "$FQDN" ] && read -rp "FQDN to test: " FQDN
nslookup "$FQDN"
```

## Resolution D

A NSG, Azure Firewall rule, or user-defined route is blocking UDP or TCP port 53 traffic between the querying host and its configured DNS target.

Run the following commands in Azure CLI.

1. Identify the specific NSG `Deny` rule blocking port 53:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_RG" ] && read -rp "Resource Group (NSG): " NSG_RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name: " NSG_NAME

az network nsg rule list \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --include-default \
  --query "[?access=='Deny' && direction=='Outbound'].{name:name, priority:priority, destPort:destinationPortRange, dest:destinationAddressPrefix, protocol:protocol}" \
  --output table
```

Look for rules that block destination port 53 (or a range including 53) in the outbound direction.

2. Add an `Allow` rule for DNS traffic with higher priority than the blocking rule.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_RG" ] && read -rp "Resource Group (NSG): " NSG_RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name: " NSG_NAME
[ -z "$DNS_TARGET_IP" ] && read -rp "DNS Target IP (resolver or custom DNS): " DNS_TARGET_IP
[ -z "$PRIORITY" ] && read -rp "Rule Priority (lower number = higher priority): " PRIORITY

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-DNS-Outbound \
  --priority "$PRIORITY" \
  --direction Outbound \
  --destination-address-prefix "$DNS_TARGET_IP" \
  --destination-port-range 53 \
  --protocol "*" \
  --access Allow
```

3. Re-run [Step 5](#step-5). The new `Allow` rule should appear with a lower priority number than the `Deny` rule. Then test the resolution:

```bash
[ -z "$FQDN" ] && read -rp "FQDN to test: " FQDN
nslookup "$FQDN"
```

## References

- [Azure DNS Private Resolver overview](/azure/dns/dns-private-resolver-overview)
- [What is a virtual network link?](/azure/dns/private-dns-virtual-network-links)
- [Azure DNS Private Resolver endpoints and rulesets](/azure/dns/private-resolver-endpoints-rulesets)
- [Private endpoint DNS integration](/azure/private-link/private-endpoint-dns-integration)
- [Set up DNS for hybrid network with Azure DNS Private Resolver](/azure/dns/private-resolver-hybrid-dns)
