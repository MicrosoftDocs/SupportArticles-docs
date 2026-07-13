---
title: Troubleshoot hybrid DNS resolution failures with Azure DNS Private Resolver
description: Hybrid DNS resolution failures with Azure DNS Private Resolver often have four root causes. Learn checks and fixes to restore inbound and outbound DNS quickly.
ms.service: azure-dns
ms.topic: troubleshooting
ms.date: 07/10/2026
ms.author: kaushika
ms.reviewer: chadmat
ai.hint.symptom-tags:
  - hybrid-dns
  - private-resolver
  - inbound-endpoint
  - outbound-endpoint
  - forwarding-ruleset
  - on-premises-dns
  - cross-cloud-dns
  - dns-referral
  - mtu-fragmentation
  - dnssec-truncation
  - 168-63-129-16
  - expressroute-dns
  - vpn-dns
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/dnsResolvers/read
  - Microsoft.Network/dnsResolvers/inboundEndpoints/read
  - Microsoft.Network/dnsResolvers/outboundEndpoints/read
  - Microsoft.Network/dnsForwardingRulesets/read
  - Microsoft.Network/dnsForwardingRulesets/forwardingRules/read
  - Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks/read
  - Microsoft.Network/dnsForwardingRulesets/write
  - Microsoft.Network/virtualNetworks/read
  - Microsoft.Network/privateDnsZones/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOLVER_RG
  - RESOLVER_NAME
  - CLIENT_VNET_RG
  - CLIENT_VNET_NAME
  - PRIVATE_ZONE_NAME
  - FQDN_TO_RESOLVE
  - ON_PREM_RESOLVER_IP
---

# Troubleshoot hybrid DNS resolution failures with Azure DNS Private Resolver

## Summary

This article explains how to diagnose and resolve hybrid DNS resolution failures involving Azure DNS Private Resolver, on-premises DNS, and cross-cloud DNS scenarios.

Hybrid DNS failures - on-premises hosts that can't resolve Azure private namespaces, or Azure VMs that can't resolve on-premises or cross-cloud names through Azure DNS Private Resolver - almost always fall into four root causes: on-premises (or cross-cloud) DNS doesn't forward Azure private namespaces to a Private Resolver **inbound** endpoint (often because it's configured to query `168.63.129.16` directly, which is unreachable from outside an Azure VNet); the Private Resolver **outbound** endpoint and its forwarding ruleset are attached to the wrong VNet so Azure clients never use the rules; the upstream resolver returns a **referral** (NS records in the AUTHORITY section) instead of a fully recursive answer; or **MTU/fragmentation** on the VPN or NVA path drops large DNS responses such as TXT records and DNSSEC-signed answers. This guide isolates the failure direction first, then routes you to the exact fix.

> [!NOTE]
> **Scope.** This guide covers the cross-boundary path between on-premises (or another cloud) and an Azure VNet through Azure DNS Private Resolver. For misconfigured custom DNS servers or conditional forwarders **inside a single Azure VNet**, see [Troubleshoot DNS resolution failures caused by conditional forwarder misconfiguration](troubleshoot-azure-dns-resolution-fails-conditional-forwarder-misconfiguration.md). For Private DNS zone deletion, migration, or orphaned link issues, see the zone management troubleshooter.

## Symptoms

- A host **outside Azure** (on-premises, AWS, Oracle Cloud, GCP) can't resolve an Azure private FQDN such as `myaccount.blob.core.windows.net`, `mykv.vault.azure.net`, or a custom record in a linked Private DNS zone, while resolution from inside the Azure VNet works.
- An Azure VM **inside a VNet** can't resolve an on-premises or third-party private FQDN, even though the on-premises resolver answers it correctly when queried directly.
- `nslookup` or `dig` against `168.63.129.16` from an on-premises host times out - `168.63.129.16` is an Azure-internal address and is never reachable across ExpressRoute, VPN, or the public Internet.
- Resolution works for short answers (`A`, `AAAA`) but fails for `TXT`, `DNSKEY`, `RRSIG`, or other large responses; `dig +tcp` succeeds where `dig` (UDP) returns truncation or timeout.
- Cross-cloud lookups (for example, AWS Route 53 private hosted zones reached through a Private Resolver outbound rule) return `SERVFAIL` or NXDOMAIN, and a packet capture on the upstream shows a response containing only `AUTHORITY` (`NS`) records, not an `ANSWER` section.
- An outbound forwarding ruleset is created but no Azure VNet appears to use it - Azure clients still send queries directly to `168.63.129.16` and ignore the configured upstream.

## Prerequisites

- **Permissions required:** `Reader` on the Private Resolver, forwarding ruleset, client VNet, and Private DNS zone (the `Microsoft.Network/dnsResolvers/*/read`, `Microsoft.Network/dnsForwardingRulesets/*/read`, and `Microsoft.Network/virtualNetworks/read` actions). To apply remediation, `DNS Resolver Contributor` (or `Microsoft.Network/dnsForwardingRulesets/*/write`) is required on the ruleset.
- **Tools:** Azure CLI 2.x (or an AI agent with Azure CLI access), plus `dig` (or `Resolve-DnsName`) on a host on the on-premises side of the tunnel and on a test VM in the affected Azure VNet.
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Azure subscription ID | `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e` |
| `$RESOLVER_RG` | Resource group containing the Private Resolver | `hub-dns-rg` |
| `$RESOLVER_NAME` | Private Resolver name | `hub-private-resolver` |
| `$CLIENT_VNET_RG` | Resource group of the VNet where resolution fails (Azure-side) | `app-spoke-rg` |
| `$CLIENT_VNET_NAME` | VNet where the failing Azure client lives | `app-spoke-vnet` |
| `$PRIVATE_ZONE_NAME` | Private DNS zone the on-prem client is trying to reach | `privatelink.blob.core.windows.net` |
| `$FQDN` | The FQDN that fails to resolve | `myaccount.blob.core.windows.net` |
| `$ON_PREM_RESOLVER_IP` | On-premises (or cross-cloud) DNS server IP being used | `10.10.0.4` |
| `$INBOUND_IP` | Private Resolver inbound endpoint IP (discovered in [Step 2](#step-2)) | `10.0.0.4` |
| `$UPSTREAM_DNS_IP` | Upstream DNS server an outbound rule forwards to | `10.20.0.10` |

> [!TIP]
> Each script below prompts you for the required values interactively - just select **Try It** to open Cloud Shell and answer the prompts. The session caches values, so you only enter them once.

---

## Diagnostic steps

> [!NOTE]
> **These steps are read-only. They don't make any changes to your environment.**

---

### Step 1

**What this check does:** It checks which **direction** the hybrid path fails in. The fix for an on-premises host that can't resolve an Azure private name is different from the fix for an Azure VM that can't resolve an on-premises name. Confirm the direction before running any further checks.

| Observation | Direction | Next step |
|---|---|---|
| A host **outside Azure** (on-premises, another cloud) can't resolve an Azure private FQDN; resolution succeeds from inside the Azure VNet | **Inbound** path failure (external → Azure) | → [Step 2](#step-2) |
| A VM **inside an Azure VNet** can't resolve an on-premises or cross-cloud FQDN; resolution succeeds when the on-premises resolver is queried directly | **Outbound** path failure (Azure → external) | → [Step 4](#step-4) |
| Both directions fail | Walk inbound first, then outbound | → [Step 2](#step-2) |
| Short queries (`A`, `AAAA`) succeed end-to-end but `TXT`, `DNSKEY`, or DNSSEC-related queries fail or are truncated | Suspect MTU/fragmentation regardless of direction | → [Step 6](#step-6) |

---

### Step 2

**What this check does:** It verifies that a Private Resolver exists in the hub VNet, has at least one **inbound** endpoint, and that you have the inbound endpoint's private IP - the address that on-premises DNS servers must forward to.

#### Run this command

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp  "Resolver Resource Group: " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "Resolver Name:           " RESOLVER_NAME

az dns-resolver inbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, subnet:ipConfigurations[0].subnet.id, ip:ipConfigurations[0].privateIpAddress}" \
  --output json
```

<!-- VERIFY: ipConfigurations[0].privateIpAddress is the documented JSONPath; confirm with `az dns-resolver inbound-endpoint show` against a real resolver before publish. -->

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| One or more inbound endpoints with `"state": "Succeeded"` and an `"ip"` value | A reachable inbound endpoint exists. Record the IP as `$INBOUND_IP`. | → [Step 3](#step-3) |
| `[]` (empty list) - no inbound endpoint | The resolver has no inbound endpoint, so on-prem traffic has nowhere to land. | → [Resolution A](#resolution-a) |
| `ResourceNotFound` on the resolver itself | No Private Resolver exists in the named resource group. | → [Resolution A](#resolution-a) |
| Endpoint exists but `"state"` is `Failed` or `Updating` | Endpoint provisioning is incomplete - wait for it to settle, or re-create. | Re-run after 5 minutes; if still failing, → [Resolution A](#resolution-a) |
| `AuthorizationFailed` | The signed-in identity lacks read on `Microsoft.Network/dnsResolvers`. | Grant `Reader` on the resolver and re-run. |

---

### Step 3

**What this check does:** It checks whether the on-premises (or cross-cloud) DNS server is configured to forward queries for the Azure namespace to the Private Resolver inbound endpoint IP. **The most common antipattern is on-premises DNS pointing at `168.63.129.16` directly — that address only routes inside an Azure VNet and is never reachable across VPN/ExpressRoute.**

#### Run this command

Run this command from any host on the **on-premises side** of the tunnel (this check is intentionally not an Azure CLI block - the configuration being inspected is on the customer-managed resolver, not in Azure):

**Linux/macOS (`dig`)**

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$ON_PREM_RESOLVER_IP" ] && read -rp "On-prem DNS server IP:       " ON_PREM_RESOLVER_IP
[ -z "$INBOUND_IP" ] && read -rp        "Private Resolver inbound IP: " INBOUND_IP
[ -z "$FQDN" ] && read -rp              "FQDN that fails to resolve:  " FQDN

# 3a — Query the on-prem resolver directly. Capture which server actually answered.
dig @"$ON_PREM_RESOLVER_IP" "$FQDN" +noall +answer +comments +stats

# 3b — Bypass on-prem and query the inbound endpoint directly from on-prem.
#      This proves whether the inbound endpoint itself is reachable and authoritative.
dig @"$INBOUND_IP" "$FQDN" +noall +answer +comments +stats +time=5
```

**Windows PowerShell (`Resolve-DnsName`)**

```powershell
# Collect inputs (cached if already set in this session)
if (-not $env:ON_PREM_RESOLVER_IP) { $env:ON_PREM_RESOLVER_IP = Read-Host "On-prem DNS server IP" }
if (-not $env:INBOUND_IP) { $env:INBOUND_IP = Read-Host "Private Resolver inbound IP" }
if (-not $env:FQDN) { $env:FQDN = Read-Host "FQDN that fails to resolve" }

# 3a - Query the on-prem resolver directly.
Resolve-DnsName -Name $env:FQDN -Server $env:ON_PREM_RESOLVER_IP -Type A -DnsOnly

# 3b - Query the inbound endpoint directly.
Resolve-DnsName -Name $env:FQDN -Server $env:INBOUND_IP -Type A -DnsOnly
```

If `Resolve-DnsName` isn't available, use `nslookup "$env:FQDN" "$env:ON_PREM_RESOLVER_IP"` and `nslookup "$env:FQDN" "$env:INBOUND_IP"`.

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| 3a returns NXDOMAIN or `SERVFAIL`; 3b returns the correct private IP in the `ANSWER SECTION` | The inbound endpoint is healthy. The on-prem resolver is missing a conditional forwarder for this namespace, or the forwarder targets the wrong IP (frequently `168.63.129.16`). | → [Resolution A](#resolution-a) |
| 3a and 3b both return the public IP (or NXDOMAIN), and the on-prem resolver's configured forwarder for this namespace is `168.63.129.16` | Direct-to-`168.63.129.16` antipattern. That address isn't routable from outside an Azure VNet, so the on-prem resolver silently falls back to public DNS. | → [Resolution A](#resolution-a) — specifically [A.2](#a2) |
| 3b times out (no answer at all) but 3a returns a public IP | The on-prem network can't reach the inbound endpoint IP on UDP/TCP 53. Check the route, NSG on the inbound subnet, on-prem firewall, and ExpressRoute/VPN routing for the resolver subnet. | → [Step 5](#step-5) |
| 3b returns the correct private IP for **short** records but times out or shows `;; Truncated, retrying in TCP mode` for `TXT`/`DNSKEY` queries | The path works but is dropping large UDP responses. Classic VPN/NVA MTU symptom. | → [Step 6](#step-6) |
| 3b returns the correct private IP but 3a still returns a different / public IP | On-prem resolver has a conditional forwarder for this namespace pointing somewhere else (a stale forwarder, a competing zone, or a parent-domain forwarder that overrides). | → [Resolution A](#resolution-a) — specifically [A.3](#a3) |

---

### Step 4

**What this check does:** It verifies that the Private Resolver has an **outbound** endpoint, that a forwarding ruleset is linked to the **VNet where the failing Azure client lives**, and that a forwarding rule covers the namespace being queried. The most common outbound-path defect is a ruleset that exists but is linked only to the resolver's own VNet, not to the consumer (spoke) VNet. Azure clients in the spoke never see the rules and keep sending queries to `168.63.129.16`.

#### Run this command

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp     "Subscription ID:                  " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp      "Resolver Resource Group:          " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp    "Resolver Name:                    " RESOLVER_NAME
[ -z "$CLIENT_VNET_RG" ] && read -rp   "Client VNet Resource Group:       " CLIENT_VNET_RG
[ -z "$CLIENT_VNET_NAME" ] && read -rp "Client VNet Name (failing spoke): " CLIENT_VNET_NAME

echo "── 4a: Outbound endpoints on the resolver ──"
az dns-resolver outbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, subnet:subnet.id}" \
  --output json

echo "── 4b: Forwarding rulesets attached to the CLIENT VNet ──"
az dns-resolver forwarding-ruleset list \
  --resource-group "$CLIENT_VNET_RG" \
  --virtual-network-name "$CLIENT_VNET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| 4a returns `[]` — no outbound endpoint exists | The resolver can't forward any queries out of Azure. | → [Resolution B](#resolution-b) |
| 4a shows an outbound endpoint with `"state": "Succeeded"`, but 4b returns `[]` for the failing client VNet | An outbound endpoint exists, but no forwarding ruleset is linked to the VNet where the client lives. Azure clients in this VNet don't use any forwarding rules - they query Azure DNS only. | → [Resolution B](#resolution-b) |
| 4a healthy and 4b returns one or more rulesets | A ruleset is linked to the failing VNet. Confirm a rule covers the failing namespace. | → [Step 4a](#step-4a) |

---

### Step 4a

**What this check verifies:** That a forwarding rule on the linked ruleset matches the namespace you're querying and points to a reachable upstream DNS server.

#### Run this command

Replace `RULESET_RG` and `RULESET_NAME` with the values from Step 4b output.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp  "Subscription ID:           " SUBSCRIPTION
[ -z "$RULESET_RG" ] && read -rp    "Ruleset Resource Group:    " RULESET_RG
[ -z "$RULESET_NAME" ] && read -rp  "Forwarding Ruleset Name:   " RULESET_NAME

az dns-resolver forwarding-rule list \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RULESET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, domain:domainName, state:forwardingRuleState, targets:targetDnsServers[].ipAddress}" \
  --output json
```

<!-- VERIFY: targetDnsServers[].ipAddress and domainName are the documented schema fields; confirm with `az dns-resolver forwarding-rule show --help` before publish. -->

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| A rule whose `domain` matches the FQDN's parent zone (for example, `corp.contoso.com.` covers `app1.corp.contoso.com`), `state: Enabled`, and one or more `targets` IPs | The ruleset appears correct. Test whether the upstream actually answers recursively. | → [Step 5](#step-5) |
| No rule matches the FQDN's namespace | A ruleset is linked but doesn't cover this namespace. | → [Resolution B](#resolution-b) — specifically [B.3](#b3) |
| A matching rule exists but `state: Disabled` | The rule is suppressed. | → [Resolution B](#resolution-b) — specifically [B.3](#b3) |
| A matching rule lists `targets` such as `168.63.129.16`, `8.8.8.8`, or any public recursive resolver instead of your on-prem DNS | Wrong upstream - the outbound path tries to use Azure-internal or public DNS for a private namespace. | → [Resolution B](#resolution-b) — specifically [B.3](#b3) |

---

### Step 5

**What this check does:** It checks whether the upstream DNS server returns a **fully recursive answer** (with the requested record in the `ANSWER` section and the `ra` flag set) or a **referral** (only `NS` records in the `AUTHORITY` section). Azure DNS Private Resolver doesn't continue iteration on referrals. It expects the configured upstream to behave as a recursive resolver and return final answers.

#### Run this command

Run this command from a VM **inside the failing Azure VNet** (so the path traverses the same network as the failing application). This step is intentionally not an Azure CLI block:

**Linux/macOS (`dig`)**

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$UPSTREAM_DNS_IP" ] && read -rp "Upstream DNS IP from Step 4a target: " UPSTREAM_DNS_IP
[ -z "$FQDN" ] && read -rp            "FQDN that fails to resolve:          " FQDN

# Query the upstream directly. Inspect flags and which section carries the data.
dig @"$UPSTREAM_DNS_IP" "$FQDN" +noall +answer +authority +comments +stats +time=5
```

**Windows PowerShell (`nslookup -debug`)**

```powershell
# Collect inputs (cached if already set in this session)
if (-not $env:UPSTREAM_DNS_IP) { $env:UPSTREAM_DNS_IP = Read-Host "Upstream DNS IP from Step 4a target" }
if (-not $env:FQDN) { $env:FQDN = Read-Host "FQDN that fails to resolve" }

# Query the upstream directly and include debug output so you can inspect ANSWER vs AUTHORITY sections.
nslookup.exe -debug $env:FQDN $env:UPSTREAM_DNS_IP
```

In Windows output, a referral pattern is typically an empty answer with authoritative nameserver data returned instead.

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `;; flags: qr aa rd ra;` (or at minimum `ra` set) and the requested record in the `ANSWER SECTION` | Upstream is fully recursive. The outbound chain should work. Re-test from the application and check Azure-side caching. If it still fails, → [Step 6](#step-6) for fragmentation. | → [Step 6](#step-6) |
| `;; flags: qr rd;` with `ra` **not** set, an empty `ANSWER SECTION`, and `NS` records in the `AUTHORITY SECTION` | The upstream returned a **referral**. Private Resolver doesn't continue recursion. | → [Resolution C](#resolution-c) |
| Connection times out or `;; communications error` | Upstream is unreachable from the outbound endpoint subnet. Check NSG on the outbound subnet, UDR routing back to on-prem, and on-prem firewall rules for UDP/TCP 53 from the outbound endpoint subnet. | Investigate transport. If transport works for short responses but fails for large ones → [Step 6](#step-6) |
| Returns the correct answer for short queries but `dig @"$UPSTREAM_DNS_IP" "$FQDN" TXT` truncates or times out | Upstream answers are arriving truncated. | → [Step 6](#step-6) |

---

### Step 6

**What this check does:** It checks whether large DNS responses are dropped on the VPN, ExpressRoute, or NVA path because of MTU mismatch or appliance fragment-handling. DNS over UDP (port 53) can return responses up to 4,096 bytes when EDNS0 is negotiated. VPN tunnels and many NVAs default to MTU values around 1,350–1,400. Intermediate devices that drop fragmented UDP cause classic "short queries work, large queries fail" behavior. TCP fallback (`+tcp`) succeeds when UDP fragmentation fails because TCP never produces an IP-fragmented payload.

#### Run this command

Run from the **same side** that the failing client lives on (inside the Azure VNet for outbound failures, or on the on-prem segment for inbound failures):

**Linux/macOS (`dig`)**

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$INBOUND_IP" ] && read -rp "Resolver IP to query (inbound for on-prem origin, upstream for Azure origin): " INBOUND_IP
[ -z "$FQDN" ] && read -rp        "FQDN under test:                                                              " FQDN
ZONE=$(echo "$FQDN" | awk -F. '{ for (i=2;i<=NF;i++) printf "%s%s", $i, (i==NF?"":".") }')

# 6a — Short A query over UDP (small response).
dig @"$INBOUND_IP" "$FQDN" A +noall +stats +time=5

# 6b — Force a large response over UDP. DNSKEY of the parent zone is reliably large; TXT also works.
dig @"$INBOUND_IP" "$ZONE" DNSKEY +noall +stats +time=5
dig @"$INBOUND_IP" "$FQDN" TXT  +noall +stats +time=5

# 6c — Same large query, forced over TCP. If 6b fails and 6c succeeds, fragmentation is the cause.
dig @"$INBOUND_IP" "$ZONE" DNSKEY +tcp +noall +stats +time=5
```

**Windows PowerShell (`Resolve-DnsName` and `nslookup`)**

```powershell
# Collect inputs (cached if already set in this session)
if (-not $env:INBOUND_IP) { $env:INBOUND_IP = Read-Host "Resolver IP to query (inbound for on-prem origin, upstream for Azure origin)" }
if (-not $env:FQDN) { $env:FQDN = Read-Host "FQDN under test" }
$labels = $env:FQDN -split "\."
if ($labels.Count -lt 2) { throw "FQDN must include at least two labels." }
$zone = ($labels[1..($labels.Count - 1)] -join ".")

# 6a - Short A query over UDP.
Resolve-DnsName -Name $env:FQDN -Server $env:INBOUND_IP -Type A -DnsOnly

# 6b - Large queries over UDP.
nslookup.exe -type=DNSKEY $zone $env:INBOUND_IP
nslookup.exe -type=TXT $env:FQDN $env:INBOUND_IP

# 6c - Same large query forced over TCP (virtual circuit mode in nslookup).
@"
server $env:INBOUND_IP
set type=DNSKEY
set vc
$zone
exit
"@ | nslookup.exe
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| 6a succeeds, 6b times out, or shows `;; Truncated, retrying in TCP mode`, 6c succeeds | UDP fragmentation is being dropped. MTU/fragmentation defect on the VPN, ExpressRoute, or NVA path. | → [Resolution D](#resolution-d) |
| 6a, 6b, and 6c all succeed | No fragmentation problem. Re-evaluate previous steps and capture packets at the upstream resolver. | If outbound path: → [Resolution C](#resolution-c). If inbound path: → [Resolution A](#resolution-a). |
| 6a fails as well | The path is broken end-to-end, not just for large responses. Treat as a transport problem, not MTU. | Return to [Step 3](#step-3) (inbound) or [Step 4](#step-4) (outbound). |

---

## Decision map

| Diagnostic result | Next action |
|---|---|
| Step 2: no inbound endpoint exists, or no Private Resolver at all | [Resolution A — Restore the inbound forwarding chain](#resolution-a) |
| Step 3: on-prem forwarder for the Azure namespace is `168.63.129.16` (or absent), inbound endpoint answers correctly when queried directly | [Resolution A — Restore the inbound forwarding chain](#resolution-a) |
| Step 4: outbound endpoint exists but no forwarding ruleset is linked to the failing client VNet | [Resolution B — Attach the outbound ruleset to the consumer VNet](#resolution-b) |
| Step 4a: ruleset linked but no rule covers the failing namespace, rule disabled, or upstream targets are wrong | [Resolution B — Attach the outbound ruleset to the consumer VNet](#resolution-b) |
| Step 5: upstream returns a referral (NS records in AUTHORITY, no ANSWER) | [Resolution C — Make the upstream return final answers](#resolution-c) |
| Step 6: short queries succeed, large queries fail over UDP, TCP fallback succeeds | [Resolution D — Fix MTU and fragmentation on the hybrid path](#resolution-d) |
| Step 3 / Step 5: TCP/UDP 53 to the resolver IP times out from the originating side | Transport problem (NSG, on-prem firewall, route). Resolve transport, then re-run [Step 3](#step-3) or [Step 5](#step-5). |

---

## Resolution A

**Root cause:** On-premises (or cross-cloud) DNS doesn't forward Azure private namespaces to a Private Resolver inbound endpoint. The two recurring forms are: (1) no conditional forwarder exists for the namespace, so the on-prem resolver returns NXDOMAIN or the public IP; and (2) a conditional forwarder exists but targets `168.63.129.16` directly, which is never reachable from outside an Azure VNet and silently fails over to public DNS.

### A.1

**Confirm or create the inbound endpoint and capture its IP.** Skip this step if [Step 2](#step-2) already returned a healthy inbound endpoint and you recorded `$INBOUND_IP`.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp  "Resolver Resource Group: " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "Resolver Name:           " RESOLVER_NAME

az dns-resolver inbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, ip:ipConfigurations[0].privateIpAddress}" \
  --output json
```

Record the `ip` value as `$INBOUND_IP`. If the resolver itself is missing, deploy `Microsoft.Network/dnsResolvers` in the hub VNet and add an inbound endpoint in a dedicated subnet **with no NSG rules blocking UDP/TCP 53** before continuing. Use the [Azure DNS Private Resolver overview](/azure/dns/dns-private-resolver-overview) for sizing and subnet requirements.

### A.2

> [!IMPORTANT]
> **⚠️ Write operation.** Make this change on your **on-premises (or cross-cloud) DNS server**, not in Azure. Confirm the namespace and the inbound endpoint IP (`$INBOUND_IP`) before you apply it. The exact procedure depends on the resolver software:

- **Windows DNS Server (AD DS / standalone):** DNS Manager → **Conditional Forwarders** → New Conditional Forwarder → enter the Azure namespace (for example, `privatelink.blob.core.windows.net`) → enter `$INBOUND_IP` as the IP of the primary server → leave **Store this conditional forwarder in Active Directory** checked if domain-replicated forwarding is required.
- **BIND (`named.conf`):** add a forward zone:

  ```text
  zone "privatelink.blob.core.windows.net" {
      type forward;
      forward only;
      forwarders { 10.0.0.4; };   // replace with $INBOUND_IP
  };
  ```

- **Infoblox / BlueCat / other appliance:** create a **Forward Zone** for the namespace and set the forwarder to `$INBOUND_IP`.

Repeat for every Azure private namespace the on-prem side must resolve (`privatelink.<service>.core.windows.net`, custom private zones, `azurewebsites.net` private link variants, and so on). **Don't** create a forwarder pointing at `168.63.129.16`; it's unreachable from outside an Azure VNet and is the most common single cause of this failure mode.

### A.3

If a conditional forwarder for this namespace **already exists** but points somewhere else (a stale forwarder, an NVA IP, a competing internal resolver), update it to `$INBOUND_IP` and **flush the on-prem DNS cache** before retesting. On Windows: `Clear-DnsServerCache`. On BIND: `rndc flush`. On Linux clients: `sudo systemctl restart systemd-resolved` or equivalent.

### A.4

Re-run [Step 3](#step-3) from the on-prem side. The 3a query (against the on-prem resolver) and the 3b query (directly against `$INBOUND_IP`) must both return the expected private IP in the `ANSWER SECTION`.

If the issue persists after this fix, proceed to [Step 6](#step-6) for fragmentation, or [Resolution C](#resolution-c) if cross-cloud forwarding is involved.

---

## Resolution B

**Root cause:** The Private Resolver outbound path is incomplete from the perspective of the failing client. Either no outbound endpoint exists, the forwarding ruleset is **linked to the wrong VNet** (commonly the resolver's own hub VNet rather than the consumer spoke), or the rule for the target namespace is missing, disabled, or pointing at the wrong upstream. **A forwarding ruleset only takes effect for queries that originate in a VNet to which it is linked.** Linking the ruleset to the resolver VNet alone does nothing for spoke clients.

### B.1

**Confirm the outbound endpoint and locate the ruleset.** This step is read-only.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp  "Subscription ID:         " SUBSCRIPTION
[ -z "$RESOLVER_RG" ] && read -rp   "Resolver Resource Group: " RESOLVER_RG
[ -z "$RESOLVER_NAME" ] && read -rp "Resolver Name:           " RESOLVER_NAME

echo "── Outbound endpoints ──"
az dns-resolver outbound-endpoint list \
  --dns-resolver-name "$RESOLVER_NAME" \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState, subnet:subnet.id}" \
  --output json

echo "── Forwarding rulesets in the resolver resource group ──"
az dns-resolver forwarding-ruleset list \
  --resource-group "$RESOLVER_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, state:provisioningState}" \
  --output json
```

Record `$RULESET_NAME`. If no outbound endpoint exists, create one in a dedicated subnet of the hub VNet before continuing. For more information, see [Outbound endpoints and rulesets](/azure/dns/private-resolver-endpoints-rulesets).

### B.2

> [!IMPORTANT]
> **⚠️ Write operation.** This command links the forwarding ruleset to your client VNet so Azure clients in that VNet start using its rules. Confirm `$RULESET_NAME`, `$CLIENT_VNET_NAME`, and the resource groups before you run it.

**Link the ruleset to the consumer VNet (the VNet where the failing Azure client lives).** This step is the single most common omission.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp     "Subscription ID:                  " SUBSCRIPTION
[ -z "$RULESET_RG" ] && read -rp       "Ruleset Resource Group:           " RULESET_RG
[ -z "$RULESET_NAME" ] && read -rp     "Forwarding Ruleset Name:          " RULESET_NAME
[ -z "$CLIENT_VNET_RG" ] && read -rp   "Client VNet Resource Group:       " CLIENT_VNET_RG
[ -z "$CLIENT_VNET_NAME" ] && read -rp "Client VNet Name (failing spoke): " CLIENT_VNET_NAME
[ -z "$LINK_NAME" ] && read -rp        "VNet Link Name (e.g. spoke-link): " LINK_NAME

VNET_ID=$(az network vnet show \
  --name "$CLIENT_VNET_NAME" \
  --resource-group "$CLIENT_VNET_RG" \
  --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az dns-resolver vnet-link create \
  --name "$LINK_NAME" \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RULESET_RG" \
  --subscription "$SUBSCRIPTION" \
  --virtual-network id="$VNET_ID"
```

<!-- VERIFY: az dns-resolver vnet-link create takes --virtual-network in id=<resourceId> form; confirm against `az dns-resolver vnet-link create --help` before publish. -->

Repeat for every spoke VNet whose clients must use these forwarding rules.

### B.3

> [!IMPORTANT]
> **⚠️ Write operation.** This command creates or replaces a forwarding rule on your ruleset. Confirm the target namespace and upstream DNS IP before you run it.

**Add or correct the forwarding rule for the target namespace.** Replace the example domain and target with your values.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp    "Subscription ID:               " SUBSCRIPTION
[ -z "$RULESET_RG" ] && read -rp      "Ruleset Resource Group:        " RULESET_RG
[ -z "$RULESET_NAME" ] && read -rp    "Forwarding Ruleset Name:       " RULESET_NAME
[ -z "$RULE_NAME" ] && read -rp       "Forwarding Rule Name:          " RULE_NAME
[ -z "$TARGET_DOMAIN" ] && read -rp   "Target namespace (with trailing dot, e.g. corp.contoso.com.): " TARGET_DOMAIN
[ -z "$UPSTREAM_DNS_IP" ] && read -rp "Upstream DNS IP (on-prem/3rd party): " UPSTREAM_DNS_IP

az dns-resolver forwarding-rule create \
  --ruleset-name "$RULESET_NAME" \
  --resource-group "$RULESET_RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --domain-name "$TARGET_DOMAIN" \
  --forwarding-rule-state "Enabled" \
  --target-dns-servers "[{ip-address:$UPSTREAM_DNS_IP,port:53}]"
```

<!-- VERIFY: --target-dns-servers accepts the shorthand "[{ip-address:...,port:53}]" form; confirm with `az dns-resolver forwarding-rule create --help` before publish. -->

The target **must** be a fully recursive DNS server (see [Resolution C](#resolution-c)). Don't use `168.63.129.16` (Azure-internal only) or a public recursive resolver (`8.8.8.8`, `1.1.1.1`) for a private namespace.

### B.4

Re-run [Step 4](#step-4) and [Step 4a](#step-4a). The ruleset must appear under the client VNet, and the rule must show `state: Enabled` with the correct upstream. Then re-run resolution from the application VM.

If resolution still fails, continue to [Resolution C](#resolution-c) (referrals) or [Resolution D](#resolution-d) (fragmentation).

---

## Resolution C

**Root cause:** The upstream DNS server returns a **referral** (NS records in the `AUTHORITY` section) rather than a fully recursive answer. Azure DNS Private Resolver expects the configured upstream to behave as a recursive resolver - it doesn't chase NS referrals on your behalf. This problem most often occurs when an outbound rule points to a third-party authoritative server (an AWS Route 53 inbound resolver, an Oracle Cloud DNS view, or a delegated authoritative server) instead of the on-prem **recursive** resolver that already knows how to complete the chain.

### C.1

**Confirm the referral pattern.** Re-run [Step 5](#step-5) and capture the output. The referral signature is: empty `ANSWER SECTION`, one or more `NS` records in `AUTHORITY SECTION`, and the `ra` flag **not** set in the `;; flags:` line.

### C.2

> [!IMPORTANT]
> **⚠️ Write operation.** This change points your forwarding rule to a different upstream resolver. Confirm the recursive resolver's IP before you apply it through [Resolution B.3](#b3).

**Point the forwarding rule to a fully recursive resolver.** The upstream resolver must accept recursion (`rd` set on input) and return final answers (`ra` set on output) for the namespaces the rule targets.

Two common designs:

1. **Use the on-premises recursive resolver as the upstream**, even if another cloud technically owns the namespace. Configure the on-premises recursive resolver to forward (or delegate) the cross-cloud namespace to the cross-cloud authoritative resolver. The on-premises recursive resolver returns final answers to Azure.
1. **Deploy a small recursive resolver in the hub VNet** (for example, an `unbound` or BIND VM) that targets the cross-cloud authoritative resolver. Point the Private Resolver outbound rule at the recursive resolver instead of the authoritative one.

Update the rule to the recursive resolver's IP by using [Resolution B.3](#b3). **Don't** remove or rewrite the third-party authoritative server itself. Private Resolver simply must not forward directly to an authoritative-only server.

### C.3

Re-run [Step 5](#step-5). The output must now show the requested record in the `ANSWER SECTION` and `ra` set in the `;; flags:` line. Then re-test from the application.

If short answers now resolve correctly but `TXT`, `DNSKEY`, or DNSSEC-signed responses still fail, continue to [Resolution D](#resolution-d).

---

## Resolution D

**Root cause:** Large DNS responses are dropped between the resolver and the failing client because of MTU mismatch or fragment-handling on the VPN tunnel, ExpressRoute private peering NVA, or an intermediate firewall. DNS over UDP can return responses up to 4,096 bytes when EDNS0 is negotiated. Tunnels with MTU near 1,350–1,400 produce IP fragments, and many appliances drop fragmented UDP by default. Symptoms: short `A` queries succeed, `TXT` / `DNSKEY` / DNSSEC-signed responses time out, and `dig +tcp` succeeds where UDP fails.

### D.1

**Confirm the fragmentation signature.** [Step 6](#step-6) must show: 6a (short A) succeeds, 6b (large UDP query for `DNSKEY` or `TXT`) times out or returns truncated, 6c (same large query forced over TCP) succeeds. If 6c also fails, the problem isn't MTU – return to [Resolution A](#resolution-a) or [Resolution C](#resolution-c).

### D.2

> [!IMPORTANT]
> **⚠️ Write operation.** These changes modify your VPN gateway, NVA, firewall, or resolver configuration. Apply only one change at a time and re-test before applying the next.

Apply one or more of the following changes on the path between the failing client and the resolver IP. Fix the **first** appliance in the path that drops fragments, then re-test before applying further changes:

1. **VPN gateway or on-premises VPN concentrator MTU.** Lower the tunnel MTU to a safe value (commonly 1350–1400 bytes for IPsec) on both ends so that the inner DNS payload doesn't exceed the post-encapsulation MTU after EDNS0 expansion.
1. **NVA or firewall fragmented-UDP handling.** On Azure Firewall, ensure DNS proxy isn't silently dropping fragments. On third-party NVAs (Palo Alto, Fortinet, Check Point), enable "allow IP fragmentation" or "reassemble fragmented UDP" on the rules covering the resolver IP.
1. **EDNS0 buffer size at the resolver client.** As a containment, lower the client's advertised EDNS0 UDP buffer to 1232 bytes (the DNS Flag Day 2020 recommendation), which forces small enough UDP responses to avoid fragmentation. On BIND: `edns-udp-size 1232;`. This is a workaround, not a fix; keep it until the underlying MTU is corrected.
1. **Force TCP for the affected zone.** As a last resort, configure the on-premises resolver to use TCP for the affected namespace. This change eliminates fragmentation at the cost of a small per-query latency.

Don't "fix" MTU by widening NSG rules or disabling DNS proxy. Those changes don't address fragmentation and they mask the failure mode for the next operator.

### D.3

Re-run [Step 6](#step-6). All three sub-queries (6a, 6b, 6c) must now succeed over UDP. Then re-test the application.

If large queries still fail after MTU is corrected, capture packets at both ends of the tunnel (`tcpdump -s 0 -w` on Linux, Wireshark on Windows) and confirm that the fragmented response packets actually arrive at the receiving side.

---

## Related articles

- `[Azure DNS Private Resolver overview](https://learn.microsoft.com/azure/dns/dns-private-resolver-overview)`
- [Private Resolver endpoints and forwarding rulesets](/azure/dns/private-resolver-endpoints-rulesets)
- [Azure DNS Private Resolver hybrid DNS architecture](/azure/architecture/networking/architecture/azure-dns-private-resolver)
- [Hybrid DNS resolution with Private Resolver](/azure/dns/private-resolver-hybrid-dns)
- [Troubleshoot DNS resolution failures caused by conditional forwarder misconfiguration](troubleshoot-azure-dns-resolution-fails-conditional-forwarder-misconfiguration.md)
- [Azure-provided DNS and the role of 168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [DNS Flag Day 2020 — EDNS0 buffer size guidance](https://dnsflagday.net/2020/)
