---
title: Troubleshoot Azure DNS
description: Troubleshoot Azure DNS zones, records, Private DNS, Private Resolver, DNS forwarding, and name resolution issues. Follow these steps to restore service.
services: dns
author: kaushika-msft
ms.author: kaushika
ms.review: allensu
manager: dcscontentpm
ms.service: azure-dns
ms.topic: troubleshooting
ms.date: 07/31/2026
# Customer intent: As a DNS administrator, I want to troubleshoot Azure DNS issues so that I can restore reliable name resolution.
---
# Troubleshoot Azure DNS

## Summary

This article helps DNS admins troubleshoot common Azure DNS issues with zones, records, and name resolution so they can restore DNS service.

## Related design guidance

Before troubleshooting DNS architecture, review the following design guidance:

- For help choosing between Azure-provided DNS, Private DNS zones, Private Resolver, custom DNS servers, and Traffic Manager-based options for hybrid and multiregion designs, see [Hybrid DNS infrastructure on Azure](/azure/architecture/hybrid/hybrid-dns-infra).
- For Private Endpoint DNS integration patterns, including single virtual network, hub-and-spoke, on-premises, and custom DNS scenarios, see [Azure Private Endpoint DNS integration scenarios](/azure/private-link/private-endpoint-dns-integration).

You can also use Microsoft Copilot in Azure from the Azure portal to help troubleshoot DNS resolution issues. For example, try a prompt such as *"Can you help me troubleshoot DNS resolution issues in Azure?"* Copilot can use your resource context and guide you through the steps in this article. For more information, see [What is Microsoft Copilot in Azure?](/azure/copilot/overview) and [example prompts](/azure/copilot/example-prompts).

## Azure DNS products

| Product | Role | Listening surface |
|---|---|---|
| **[Azure-provided DNS](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)** | Default recursive resolver for every VNet | VIP **[168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16)** (per-VNet, reachable only from inside the VNet) |
| **Azure Public DNS** | Authoritative for internet-facing zones | Public Azure name servers (`ns1-0?.azure-dns.com/.net/.org/.info`) |
| **Azure Private DNS Zone** | Authoritative for private zones, scoped via **VNet links** | Resolved through 168.63.129.16 in any **linked** VNet |
| **Private Endpoint + `privatelink.*` zone** | Maps a service FQDN to the PE's private IP | Authoritative records auto-registered (or manual) in a [Private DNS zone](/azure/private-link/private-endpoint-dns) |
| **Azure DNS Private Resolver — Inbound Endpoint** | Lets **on-prem / peered VNets** query Azure DNS via a routable IP | Private IP in a delegated subnet (resolves any zone the VNet can see, including linked Private DNS zones) |
| **Azure DNS Private Resolver — Outbound Endpoint** | Source for Azure-initiated queries when a **DNS forwarding ruleset** matches | Private IP in a delegated subnet (forwards to on-prem / 3rd-party DNS) |
| **DNS Forwarding Ruleset** | Per-domain conditional forwarding rules | Linked to one or more VNets; consulted for queries from those VNets |
| **Custom DNS server (IaaS)** | DNS VM (BIND, Windows DNS, AD DS, NVA) in a VNet | Set on VNet [`dnsServers`](/azure/virtual-network/manage-virtual-network#change-dns-servers) or per-NIC; usually forwards to 168.63.129.16 |
| **Azure DNS Resolver Policy** | Per-VNet allow/block/redirect rules applied before recursion | Enforced by Azure-provided DNS at 168.63.129.16 |


## Resolution priority inside Azure recursion

When Azure-provided DNS (168.63.129.16) or a Private Resolver endpoint receives a query, it doesn't just hand the name to public recursion. It walks through several authoritative and policy sources in a fixed order and returns the first match. Knowing this order lets you predict *which* answer a VM gets when the same name exists in more than one place (for example, a `privatelink` zone, a DNS forwarding ruleset, and public DNS).

The diagram below shows that evaluation order. Read it top-to-bottom:

- **[Azure DNS Resolver Policy](/azure/dns/dns-security-policy)** acts as a filter on every query. A **Block** rule stops the lookup before any zone or ruleset answers. **Allow** and **Alert** rules pass the query through (with logging) to the steps below.
- **Linked Private DNS zones** (including `privatelink.*` zones registered by Private Endpoints) are checked next, which is why a Private Endpoint "wins" over the public record for the same FQDN.
- **DNS forwarding rulesets** then match on suffix and send the query to on-prem or a third-party resolver via the Outbound Endpoint.
- Anything that doesn't match falls through to **public Azure DNS / internet recursion**.

Use this order when you're trying to explain why a client got an unexpected IP. Typically, it means a higher-priority source (an Azure DNS Resolver Policy rule, a linked private zone, or a forwarding rule) matched before recursion ever reached the public answer.

:::image type="content" source="./media/troubleshoot-dns/dns-resolution-flow.png" alt-text="Screenshot of the Azure DNS resolution flow." lightbox="./media/troubleshoot-dns/dns-resolution-flow.png":::

For more information, see [Azure DNS Private Resolver overview](/azure/dns/dns-private-resolver-overview#how-azure-dns-private-resolver-works).

## General DNS troubleshooting tools

Most Azure DNS problems fall into one of two categories: the **content** the resolver returns (wrong record, missing record, stale cache) or the **network path** to the resolver (NSG, route table, firewall, or NVA blocking UDP/TCP 53). Effective troubleshooting separates these two concerns before going deep on any product-specific behavior.

A reliable approach:

1. **Establish what the client is doing today.** Identify which resolver the client is actually querying (`Get-DnsClientServerAddress`, `resolvectl status`, `ipconfig /all`) before assuming it's `168.63.129.16` or your custom DNS.
1. **Compare the failing query against a known-good source.** Run the same query against the suspect resolver and against a reference resolver (`168.63.129.16`, a Private Resolver inbound endpoint, `1.1.1.1`, or an Azure name server directly). If the answers differ, the problem is with the DNS record itself (wrong value, stale cache, or broken zone delegation). If both time out, the problem is the network path to the resolver.
1. **Isolate the network path with a non-DNS probe.** `Test-NetConnection -Port 53` confirms whether UDP/TCP 53 reaches the resolver at all, separating a routing/NSG/firewall problem from a DNS-content problem.
1. **Eliminate caching before drawing conclusions.** Flush the local cache (`Clear-DnsClientCache`, `ipconfig /flushdns`, `sudo resolvectl flush-caches`) and, when validating public zones, use an external tester such as `digwebinterface` so corporate proxies and recursive caches don't mask the live answer.
1. **Use Azure-side signals last, not first.** The Activity log on the zone, resolver, or policy explains *control-plane* failures (create or update errors, quota, conflicts); Network Watcher *Connection troubleshoot* explains *data-plane* path failures. Both are most useful after the steps above have narrowed the problem.

Pick the tool that matches the layer you're testing - query content, port reachability, cache state, or the Azure control plane - using the following table.

### Choose the appropriate tool

| Tool | OS | What it's used for | Where to use it |
|---|---|---|---|
| [`Resolve-DnsName`](/powershell/module/dnsclient/resolve-dnsname) | Windows PowerShell | Issuing DNS queries with full control over server, record type, transport, and DNSSEC: `-Server`, `-Type A\|AAAA\|CNAME\|NS\|SOA\|TXT\|MX\|SRV`, `-NoHostsFile -DnsOnly`, `-TcpOnly`, `-DnssecOk`. | From any Windows client or Azure Windows VM with line-of-sight to the resolver being tested. |
| `nslookup` | Windows / Linux | Returning the answer a specific DNS server provides for a name. Interactive mode (`nslookup`, then `server <ip>` and `set type=cname`) supports walking a resolution chain. **Note:** `nslookup` ***does not use the operating system's local Domain Name System resolver library*** - it bypasses the local DNS cache, the `hosts` file, and the **NRPT**. If those layers matter, use [`Resolve-DnsName`](/powershell/module/dnsclient/resolve-dnsname) instead. | From any client or VM where a quick, portable check is needed and PowerShell or `dig` is unavailable. |
| `dig` | Linux / WSL | Authoritative resolution, full delegation trace (`+trace`), DNSSEC validation (`+dnssec`), TCP fallback (`+tcp`), and concise output (`+short`, `+noall +answer`). | From a Linux VM, a WSL session, or a jumpbox used to validate public zones and DNSSEC chains. |
| [`Test-NetConnection -Port 53`](/powershell/module/nettcpip/test-netconnection) | Windows PowerShell | Verifying UDP/TCP 53 reachability to a resolver IP. Returns `TcpTestSucceeded : True` or a timeout. | From a Windows client or VM when resolution times out and you need to isolate a network-path failure from a DNS-content failure. |
| [`ipconfig /flushdns`](/windows-server/administration/windows-commands/ipconfig), [`Clear-DnsClientCache`](/powershell/module/dnsclient/clear-dnsclientcache) | Windows | Clearing the local resolver cache before re-testing a record whose value changed. | On the affected Windows client or VM after a record update or a switch to a different DNS server. |
| `sudo resolvectl flush-caches` | Linux (systemd-resolved) | Clearing the local resolver cache. `resolvectl status` confirms which DNS server the host is using. | On the affected Linux client or VM after a record update. |
| Web-based DNS tester (for example, [digwebinterface](https://digwebinterface.com/)) | Browser | Running queries from outside your network when a local client or corporate DNS proxy might be returning cached results. Supports targeting Azure name servers (`ns1-01.azure-dns.com.`, and so on) directly. | From any browser when validating Azure Public DNS records or delegation from the public internet's perspective. |
| [Azure portal — Activity log](/azure/azure-monitor/essentials/activity-log) on the DNS zone, resolver, or policy | Azure portal | Surfacing the exact error returned by the resource provider when a create or update operation fails (for example, "Zone is not available", quota errors, or record set conflicts). | In the Azure portal on the affected DNS resource (or at the subscription scope for failed zone creation). |
| [Azure portal — zone **Recordsets** and **Properties** blades](/azure/dns/dns-operations-recordsets-portal) | Azure portal | Confirming the zone name, the current record set count against the quota, and individual record values. | In the Azure portal on the DNS zone being validated. |
| [Azure Network Watcher — *Connection troubleshoot*](/azure/network-watcher/network-watcher-connectivity-overview) | Azure portal | End-to-end path test from a VM NIC. Confirms whether the NSG and UDR path to a DNS server (`168.63.129.16`, a Private Resolver inbound endpoint, or on-premises DNS) permits the connection. | In the Azure portal targeting the source VM, when DNS timeouts suggest a network-path problem. |

### Check DNS resolution

Follow these steps for any DNS failure before moving to a product-specific section. The examples in the following sections show common usage of the tools. For full command and resource details, see the preceding table. If you use Linux commands, consult your distribution's documentation for the correct command syntax and package availability, because commands and options can vary by distribution.

1. Identify which resolver the client is using.

   a. On Windows:

      ```powershell
      Get-DnsClientServerAddress -AddressFamily IPv4
      ipconfig /all | Select-String "DNS Servers"
      ```

   b. On Linux:

      ```bash
      resolvectl status
      cat /etc/resolv.conf
      ```

   - In Azure VMs with default settings, you see `168.63.129.16`. If you see a custom IP, you're going through a custom DNS server or servers.

1. Query the default resolver.

   a. Windows:

      ```powershell
      Resolve-DnsName www.contoso.com
      ```

   b. Linux:

      ```bash
      nslookup www.contoso.com
      dig www.contoso.com +noall +answer
      ```

1. Bypass the default resolver to isolate the problem. Point directly at the upstream you want to test.

   a. Windows:

      ```powershell
      # Query Azure-provided DNS directly
      Resolve-DnsName www.contoso.com -Server 168.63.129.16

      # Query a Private Resolver inbound endpoint
      Resolve-DnsName db.contoso.com -Server 10.10.0.4

      # Query a public resolver to compare what the internet sees
      Resolve-DnsName www.contoso.com -Server 1.1.1.1
      ```

   b. Linux:

      ```bash
      dig @168.63.129.16 www.contoso.com
      dig @10.10.0.4 db.contoso.com
      dig @1.1.1.1 www.contoso.com
      ```

1. Confirm UDP/TCP 53 reachability to whichever server you targeted.

   ```powershell
   Test-NetConnection 168.63.129.16 -Port 53
   Test-NetConnection 10.10.0.4 -Port 53
   ```

1. Flush caches before retesting when records were recently changed.

   a. Windows:

      ```powershell
      ipconfig /flushdns
      Clear-DnsClientCache
      ```

   b. Linux:

      ```bash
      sudo resolvectl flush-caches
      ```

### NSG, Azure Firewall, or NVA blocking UDP/TCP 53


#### Symptom
DNS queries time out (`Resolve-DnsName : timed out`, `dig` shows `connection timed out; no servers could be reached`). This problem often appears immediately after introducing an NSG rule, route table change, Azure Firewall, or NVA in the egress path.

#### Steps

1. Identify the **destination IP** the client is querying.

   - Common targets: `168.63.129.16`, a Private Resolver inbound endpoint, a custom DNS VM, or a public resolver.
   - Use Step 1 of *Check DNS resolution* to confirm.

1. Test raw reachability on port 53.

   ```powershell
   Test-NetConnection 168.63.129.16 -Port 53
   ```

1. Review effective NSG rules on the client NIC.

   a. In the portal, open the client VM → **Networking → your NIC → Help → Effective security rules**.

   b. Confirm an outbound rule allows **UDP 53** *and* **TCP 53** to the destination IP.

1. Review effective routes on the same NIC.

   - Per Microsoft, [`168.63.129.16` is not subject to user-defined routes](/azure/virtual-network/what-is-ip-address-168-63-129-16#scope-of-azure-ip-address-1686312916), so a UDR targeting that address specifically doesn't apply.
   - However, an NSG rule that denies the [`AzurePlatformDNS`](/azure/virtual-network/service-tags-overview#available-service-tags) service tag can block traffic to Azure-provided DNS.

1. If Azure Firewall is in the path, make sure it allows DNS traffic.

   a. In most cases, add a [network rule](/azure/firewall/rule-processing) that allows **UDP/TCP 53** from the client subnet to the resolver IP.

   b. Only if you also want the firewall to handle DNS itself (for example, to use [FQDN filtering in network rules](/azure/firewall/fqdn-filtering-network-rules)), enable [**DNS proxy**](/azure/firewall/dns-settings#dns-proxy) on the firewall and point VNet `dnsServers` at the firewall's private IP.

1. For NVAs (Network Virtual Appliances), confirm the NVA forwards DNS unmodified and that its own outbound rules permit 53.

1. Re-test after each change.

   ```powershell
   Resolve-DnsName www.contoso.com -Server 168.63.129.16
   ```

#### Recommended articles
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [Azure Firewall DNS settings](/azure/firewall/dns-settings)
- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)

## Private DNS zone groups

When you integrate a Private Endpoint with a Private DNS zone, Azure creates a **Private DNS zone group**. This binding resource connects the Private Endpoint to one or more Private DNS zones. The zone group keeps the `privatelink.*` `A` records in the zone synchronized with the Private Endpoint as it changes (regions added or removed, endpoint deleted). Without the zone group, you need to manually update zones and `A` records.

Keep these zone group limits and behaviors in mind:

- A zone group can hold up to **5** Private DNS zones.
- Only **one** Private DNS zone per zone name per zone group. For example, you can't bind two `privatelink.blob.core.windows.net` zones to the same group.
- A Private Endpoint supports **only one** zone group.
- The **Azure Traffic Manager and DNS** resource provider performs delete and update operations on the records. This behavior is normal platform behavior, not an unrelated service.

Reference: [Azure Private Endpoint DNS integration scenarios — Private DNS zone group](/azure/private-link/private-endpoint-dns-integration#private-dns-zone-group).

### Check whether a Private Endpoint has a DNS zone group

Run the following steps from a session signed in to the subscription containing the Private Endpoint.

- **Azure PowerShell** — [`Get-AzPrivateDnsZoneGroup`](/powershell/module/az.network/get-azprivatednszonegroup):

```powershell
Get-AzPrivateDnsZoneGroup `
  -ResourceGroupName <rg> `
  -PrivateEndpointName <pe-name>
```

An empty result means the Private Endpoint has **no** zone group bound. Name resolution to the Private Endpoint isn't automatically maintained in any Private DNS zone, and clients must resolve the FQDN some other way (manual `A` record, custom DNS, hosts file).

- **Azure CLI** — [`az network private-endpoint dns-zone-group list`](/cli/azure/network/private-endpoint/dns-zone-group#az-network-private-endpoint-dns-zone-group-list):

```bash
az network private-endpoint dns-zone-group list \
  --resource-group <rg> \
  --endpoint-name <pe-name>
```

To inspect which zones a specific group is bound to, use [`az network private-endpoint dns-zone-group show`](/cli/azure/network/private-endpoint/dns-zone-group#az-network-private-endpoint-dns-zone-group-show):

```bash
az network private-endpoint dns-zone-group show \
  --resource-group <rg> \
  --endpoint-name <pe-name> \
  --name <zone-group-name>
```

#### Recommended articles
- [Azure Private Endpoint DNS integration scenarios](/azure/private-link/private-endpoint-dns-integration)
- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)

## I can't create a DNS zone

To resolve common issues, try one or more of the following steps:

1. Review the Azure DNS audit logs to find the failure reason.
1. Each DNS zone name must be unique within its resource group. That is, two DNS zones with the same name can't share a resource group. Try using a different zone name, or a different resource group.
1. You might see an error that says "You reached or exceeded the maximum number of zones in subscription {subscription ID}." Either use a different Azure subscription, delete some zones, or contact Azure Support to raise your subscription limit.
1. You might see an error that says "The zone '{zone name}' isn't available." This error means that Azure DNS was unable to allocate name servers for this DNS zone. Try using a different zone name. Or, if you're the domain name owner, you can contact Azure support to allocate name servers for you.

### Recommended articles

- [DNS zones and records](/azure/dns/dns-zones-records)
- [Create a DNS zone](/azure/dns/dns-getstarted-portal)

## I can't create a DNS record

To resolve common issues, try one or more of the following steps:

1. Review the Azure DNS audit logs to find the failure reason.
1. Does the record set already exist? Azure DNS manages records by using record *sets*, which are the collection of records that have the same name and the same type. If a record with the same name and type already exists, you need to edit the existing record set to add another record.
1. Are you trying to create a record at the DNS zone apex (the 'root' of the zone)? If so, the DNS convention is to use the '@' character as the record name. Also, note that the DNS standards don't permit CNAME records at the zone apex.
1. Do you have a CNAME conflict? The DNS standards don't allow a CNAME record with the same name as a record of any other type. If you have an existing CNAME, creating a record with the same name of a different type fails. Likewise, creating a CNAME fails if the name matches an existing record of a different type. Remove the conflict by removing the other record or choosing a different record name.
1. Did you reach the limit on the number of record sets permitted in a DNS zone? The Azure portal shows the current number of record sets and the maximum number of record sets, under the 'Properties' for the zone. If you reached this limit, delete some record sets or contact Azure Support to raise your record set limit for this zone, and then try again.

### Recommended articles

- [DNS zones and records](/azure/dns/dns-zones-records)
- [Create a DNS zone](/azure/dns/dns-getstarted-portal)

## I can't resolve my DNS record

DNS name resolution is a multistep process, which can fail for many reasons. The following steps help you investigate why DNS resolution is failing for a DNS record in a zone hosted in Azure DNS.

1. Confirm that the DNS records are configured correctly in Azure DNS. Review the DNS records in the Azure portal, checking that the zone name, record name, and record type are correct.
1. Confirm that the DNS records resolve correctly on the Azure DNS name servers.

   - If you make DNS queries from your local PC, you might see cached results that don't reflect the current state of the name servers. Also, corporate networks often use DNS proxy servers, which prevent DNS queries from being directed to specific name servers. To avoid these problems, use a web-based name resolution service such as [digwebinterface](https://digwebinterface.com/).
   - Be sure to specify the correct name servers for your DNS zone, as shown in the Azure portal.
   - Check that the DNS name is correct (you have to specify the fully qualified name, including the zone name) and the record type is correct.

1. Confirm that the DNS domain name is correctly [delegated to the Azure DNS name servers](/azure/dns/dns-domain-delegation). There are [many non-Microsoft web sites that offer DNS delegation validation](https://www.bing.com/search?q=dns+check+tool). This test is a *zone* delegation test, so you should only enter the DNS zone name and not the fully qualified record name.
1. After you complete the preceding steps, your DNS record should now resolve correctly. To verify, you can again use [digwebinterface](https://digwebinterface.com/), this time using the default name server settings.

### Recommended articles

- [Delegate a domain to Azure DNS](/azure/dns/dns-domain-delegation)

## How do I specify the service and protocol for an SRV record?

Azure DNS manages DNS records as record sets - the collection of records with the same name and the same type. For an SRV record set, you specify the service and protocol as part of the record set name. You specify the other SRV parameters ('priority', 'weight', 'port', and 'target') separately for each record in the record set.

Example SRV record names (service name 'sip', protocol 'tcp'):

- _sip._tcp (creates a record set at the zone apex)
- _sip._tcp.sipservice (creates a record set named 'sipservice')

### Recommended articles

- [DNS zones and records](/azure/dns/dns-zones-records)
- [Create DNS record sets and records by using the Azure portal](/azure/dns/dns-getstarted-portal)
- [SRV record type (Wikipedia)](https://en.wikipedia.org/wiki/SRV_record)

## Next steps

- Learn about [Azure DNS zones and records](/azure/dns/dns-zones-records).
- To start using Azure DNS, learn how to [create a DNS zone](/azure/dns/dns-getstarted-portal) and [create DNS records](/azure/dns/dns-getstarted-portal).
- To migrate an existing DNS zone, learn how to [import and export a DNS zone file](/azure/dns/dns-import-export).
