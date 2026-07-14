---
title: Troubleshoot NXDOMAIN from a Private DNS zone
description: Troubleshoot NXDOMAIN errors from an Azure Private DNS zone shadowing a public namespace. Learn how to diagnose and fix resolution failures fast.
ms.service: azure-dns
ms.topic: troubleshooting
ms.date: 07/14/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chadmat
ai.hint.symptom-tags:
  - nxdomain
  - private-dns-override
  - fallback-to-internet
  - negative-cache
  - resolver-precedence
  - aaaa-ipv6
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/privateDnsZones/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/read
  - Microsoft.Network/privateDnsZones/virtualNetworkLinks/write
  - Microsoft.Network/privateDnsZones/A/read
  - Microsoft.Network/dnsResolvers/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - VNET_NAME
  - FQDN
  - PRIVATE_ZONE_NAME
---

# Troubleshoot NXDOMAIN from an Azure Private DNS zone  

## Summary

This article helps you diagnose and resolve NXDOMAIN responses that occur when a Private DNS zone shadows a public namespace. This shadowing causes queries from inside an Azure virtual network to fail even though the name resolves correctly on the public internet.

A name that resolves correctly on the public internet returns `NXDOMAIN` (or the wrong answer) when queried from inside an Azure virtual network. This issue usually means a Private DNS zone is authoritative for that namespace and one of the following conditions applies: 

- The zone has no matching record and fallback-to-internet is off. 
- A forwarding ruleset is configured to override the zone but can't. 
- A stale negative-cache entry is present.
- The application is doing an `AAAA` (IPv6) lookup that the private endpoint never answers. 

## Symptoms

You might experience one or more of the following symptoms:

- A query from inside the virtual network (VNet) returns `*** server can't find <name>: NXDOMAIN`, but the same name resolves from a public resolver (for example, `8.8.8.8`).
- An application running on an Azure virtual machine (VM) fails with `Name or service not known`, `getaddrinfo ENOTFOUND`, or `Could not resolve host`, while the public DNS record clearly exists.
- Resolution started failing right after you created or linked a Private DNS zone to the VNet for a namespace that also has public records (for example `database.windows.net`, `blob.core.windows.net`, or a registered public domain).
- You applied a Domain Name System (DNS) fix (new `A` record, removed zone, or enabled fallback), but clients keep returning `NXDOMAIN` for several minutes.
- `nslookup -type=A` succeeds and returns a private IP, but the application still fails and `nslookup -type=AAAA` returns `NXDOMAIN`.

## Prerequisites

To troubleshoot this problem, you need the following items:

- **Permissions required:** `Private DNS Zone Contributor` (or `Reader` for diagnosis only) permissions on the resource group that holds the Private DNS zone, and `Reader` permissions on the Azure DNS Private Resolver if one is deployed.
- **Tools:** 
    - Azure CLI 2.x with the `dns-resolver` extension, or an AI agent with Azure MCP or AzureCLI access.
    - A shell on a VM inside the affected VNet (for client-side resolution tests).
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the Private DNS zone | `myResourceGroup` |
| `{VNET_NAME}` | Virtual network the failing client resolves from | `myVNet` |
| `{FQDN}` | Fully qualified name that returns NXDOMAIN | `mydb.database.windows.net` |
| `{PRIVATE_ZONE_NAME}` | Suspected Private DNS zone shadowing the namespace | `database.windows.net` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the name fails privately but works publicly, and whether the failure is on the `A` (Internet Protocol version 4 (IPv4)) record, the `AAAA` (Internet Protocol version 6 (IPv6)) record, or both. This check helps you classify the symptom before you change any Azure configuration.

Run the following commands in Azure CLI or Azure PowerShell.

Run this command from a host inside the affected VNet (like a VM on `{VNET_NAME}`). Resolution behavior depends on the network the query originates from, so Cloud Shell results aren't representative unless Cloud Shell is VNet-injected into the same VNet.

**Bash (Linux)**

```bash
# ── Collect inputs (cached if already set in this session) ──
while [ -z "${FQDN:-}" ]; do
  read -rp "Failing FQDN (required): " FQDN || { echo "FQDN is required."; exit 1; }
done

echo "===== Which resolver is this client actually using? ====="
# Azure default is 168.63.129.16, but a VNet with custom DNS — or a local
# forwarder such as dnsmasq/systemd-resolved on 127.0.0.x — may point elsewhere.
# The resolver identity matters for Step 4a, so record it now.
grep -E '^nameserver' /etc/resolv.conf

echo "===== A record — via the client's configured resolver ====="
nslookup -type=A "$FQDN"

echo "===== AAAA record — via the client's configured resolver ====="
nslookup -type=AAAA "$FQDN"

echo "===== A record — public resolver 8.8.8.8 (comparison) ====="
nslookup -type=A "$FQDN" 8.8.8.8
```

**Windows (Azure PowerShell)**

```powershell
# Collect input (cached for this PowerShell session)
if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  $env:FQDN = Read-Host "Failing FQDN (required)"
}

if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  Write-Host "FQDN is required. Please set `$env:FQDN and rerun this block."
} else {
  Write-Host "===== Which resolver is this client actually using? ====="
  Get-DnsClientServerAddress | Where-Object { $_.ServerAddresses } | Select-Object InterfaceAlias, ServerAddresses | Format-Table -AutoSize

  Write-Host "===== A record - via the client's configured resolver ====="
  nslookup -type=A $env:FQDN

  Write-Host "===== AAAA record - via the client's configured resolver ====="
  nslookup -type=AAAA $env:FQDN

  Write-Host "===== A record - public resolver 8.8.8.8 (comparison) ====="
  nslookup -type=A $env:FQDN 8.8.8.8
}
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `A` query returns `NXDOMAIN` from the VNet but resolves to a public IP from `8.8.8.8`. | A private override is shadowing a name that exists publicly. | Perform [Step 2](#step-2). |
| `A` query succeeds and returns a private IP (for example, `10.x.x.x`), but `AAAA` returns no answer (`*** Can't find <name>: No answer`, a `NODATA` or `NOERROR` response since the host has an `A` record but no `AAAA` record) and the app still fails. | IPv4 resolves. The application is likely doing an IPv6 lookup the private endpoint never answers. | Perform [Step 2](#step-2) to confirm the zone and then [Resolution D](#resolution-d). |
| `A` query returns `NXDOMAIN` from both the VNet and `8.8.8.8`. | The name doesn't exist publicly either. This isn't a private override problem. | See [Troubleshoot Azure DNS](troubleshoot-dns.md) and investigate the authoritative record or conditional forwarding. |
| `A` query returns the correct expected answer from the VNet and the app works. | DNS resolution is healthy. The issue is elsewhere. | This guidance doesn't apply |

Capture which record failed (`A`, `AAAA`, or both) and the exact answer the VNet returned. [Step 3a](#step-3a) and [Step 4a](#step-4a) need this information.

### Step 2

Check whether a Private DNS zone whose name is a suffix of `{FQDN}` is actually linked to the querying VNet. A linked zone is what makes Azure answer authoritatively and therefore return `NXDOMAIN` instead of falling through to the internet.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:          " VNET_NAME

# List all private zones in the resource group so you can confirm the suffix match
az network private-dns zone list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{zone:name, records:numberOfRecordSets, links:numberOfVirtualNetworkLinks}" \
  --output table

# Show the VNet links on the suspected zone and whether THIS VNet is linked
az network private-dns link vnet list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{link:name, vnet:virtualNetwork.id, state:virtualNetworkLinkState, registration:registrationEnabled, resolutionPolicy:resolutionPolicy}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| A zone whose name is a suffix of `{FQDN}` exists and a link entry references `{VNET_NAME}` with `"virtualNetworkLinkState": "Completed"`. | That zone is authoritative for your query and the override is confirmed. | Perform [Step 3a](#step-3a). |
| No private zone in the list is a suffix of `{FQDN}` or the suffix-matching zone isn't linked to `{VNET_NAME}`. | No private zone is shadowing the namespace from this VNet. The NXDOMAIN comes from a custom DNS zone or conditional forwarding instead. | See [Troubleshoot Azure DNS](troubleshoot-dns.md) and troubleshoot conditional forwarding and custom DNS settings. |
| The suffix-matching zone is linked but `"virtualNetworkLinkState"` is `InProgress` or `Failed`. | The link isn't healthy. The resolution behavior is undefined until it completes. | Wait for the link to reach `Completed`, and then re-run [Step 2](#step-2). If the issue persists, perform [Step 3a](#step-3a). |

Be sure to note the `resolutionPolicy` value returned for the `{VNET_NAME}` link. On a `privatelink.*` zone this value is `Default` or `NxDomainRedirect`. On any other zone the property doesn't apply and the field is `null` (which behaves like `Default` with no fallback to internet). You use it in [Step 4a](#step-4a).

### Step 3a

Check whether a DNS Private Resolver forwarding ruleset linked to the same VNet has a rule for the same namespace. If both a linked private zone and a forwarding rule exist for one namespace, the private zone always takes precedence and the forwarding rule is silently ignored. 

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG

# List forwarding rulesets in the resource group
az dns-resolver forwarding-ruleset list \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{ruleset:name, id:id}" \
  --output table
```

If a ruleset is listed, inspect its rules and which VNets it's linked to:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name (from above): " RULESET_NAME

# Rules: look for a domainName that matches your namespace (e.g. database.windows.net.)
az dns-resolver forwarding-rule list \
  --resource-group "$RG" \
  --ruleset-name "$RULESET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{rule:name, domain:domainName, state:forwardingRuleState, targets:targetDnsServers[].ipAddress}" \
  --output json

# VNet links: confirm this ruleset is linked to the querying VNet
az dns-resolver vnet-link list \
  --resource-group "$RG" \
  --ruleset-name "$RULESET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{link:name, vnet:virtualNetwork.id}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| A forwarding rule whose `domainName` matches the namespace of `{FQDN}` (for example, `database.windows.net.`) and the ruleset is linked to `{VNET_NAME}` ([Step 2](#step-2) also found a linked private zone for that namespace). | Both systems claim the namespace. The private zone takes precedence, but you didn't yet confirm which one is *meant* to answer. An empty linked zone looks identical to a missing record case. | Perform [Step 3b](#step-3b) to confirm the forwarding target. |
| No forwarding ruleset exists, no rule matches the `{FQDN}` namespace, or the ruleset isn't linked to `{VNET_NAME}`. | No forwarding rule is competing with the zone. | Perform [Step 4a](#step-4a). |
| `az dns-resolver` reports the extension isn't installed. | No DNS Private Resolver is in use, so no forwarding rule can compete. | Perform [Step 4a](#step-4a). |

Record the forwarding rule's target DNS server IP (`targets` and `targetDnsServers[].ipAddress`) as [Step 3b](#step-3b) queries it directly.

### Step 3b

Check when both a linked private zone and a competing forwarding rule exist for the same namespace. This check confirms which system is meant to answer the `{FQDN}` namespace and which of the following fixes to use:
 
- Remove the shadowing zone ([Resolution B](#resolution-b)).
- Treat the zone as the intended authority that simply lacks a record or fallback ([Resolution A](#resolution-a)). 

Determine this by checking if the forwarding rule's target DNS server resolves the `{FQDN}` value. This check is necessary because a linked zone that holds no records produces the same outputs as [Resolution A](#resolution-a) (specifically no `A` record, `resolutionPolicy: Default` or `null`, and the client is `NXDOMAIN`).

Run the following commands in Azure CLI or Azure PowerShell.

Run them from a host inside the affected VNet. Use the target DNS server IP you recorded in [Step 3a](#step-3a).

**Bash (Linux)**

```bash
# ── Collect inputs (cached if already set in this session) ──
while [ -z "${FQDN:-}" ]; do
  read -rp "Failing FQDN (required): " FQDN || { echo "FQDN is required."; exit 1; }
done
while [ -z "${FORWARD_TARGET_IP:-}" ]; do
  read -rp "Forwarding rule target DNS server IP (required, from Step 3): " FORWARD_TARGET_IP || { echo "FORWARD_TARGET_IP is required."; exit 1; }
done

echo "===== Does the forwarding target actually resolve $FQDN? ====="
nslookup -type=A "$FQDN" "$FORWARD_TARGET_IP"
```

**Windows (PowerShell)**

```powershell
# Collect inputs (cached for this PowerShell session)
if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  $env:FQDN = Read-Host "Failing FQDN (required)"
}
if ([string]::IsNullOrWhiteSpace($env:FORWARD_TARGET_IP)) {
  $env:FORWARD_TARGET_IP = Read-Host "Forwarding rule target DNS server IP (required, from Step 3)"
}

if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  Write-Host "FQDN is required. Please set `$env:FQDN and rerun this block."
} elseif ([string]::IsNullOrWhiteSpace($env:FORWARD_TARGET_IP)) {
  Write-Host "FORWARD_TARGET_IP is required. Please set `$env:FORWARD_TARGET_IP and rerun this block."
} else {
  Write-Host "===== Does the forwarding target actually resolve $($env:FQDN)? ====="
  nslookup -type=A $env:FQDN $env:FORWARD_TARGET_IP
}
```

### Interpret the results

| If you see... | Meaning | Next step |
|---|---|---|
| The forwarding target returns a valid `A` answer for `{FQDN}`. | The namespace is meant to be answered by forwarding. The linked private zone (even if it holds no records) is a shadow that takes precedence and blocks the rule. Removing the zone link lets the forwarding rule answer. | Perform [Resolution B](#resolution-b). |
| The forwarding target returns `NXDOMAIN`, returns no answer, is unreachable, or times out. | Forwarding isn't a working answer path for this name, so removing the zone won't produce a correct answer. The private zone is the intended authority but has no matching record and no fallback. | Perform [Step 4a](#step-4a). |

### Step 4a

Check whether the authoritative private zone actually contains a matching record, and whether fallback-to-internet (`resolutionPolicy`) is enabled. Combined with the client result from [Step 1](#step-1), this check separates a missing record or no-fallback case from a stale negative cache case and from an IPv6-only case.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:          " VNET_NAME

# A records in the zone — is the exact host label present?
az network private-dns record-set a list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{record:name, ips:aRecords[].ipv4Address, ttl:ttl}" \
  --output json

# AAAA records in the zone (almost always empty for private endpoints)
az network private-dns record-set aaaa list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{record:name, ips:aaaaRecords[].ipv6Address}" \
  --output table

# resolutionPolicy on THIS VNet's link — Default means no fallback-to-internet
az network private-dns link vnet list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(virtualNetwork.id, '$VNET_NAME')].{link:name, resolutionPolicy:resolutionPolicy}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| No `A` record matches the host label of `{FQDN}`, `resolutionPolicy` is `Default` or `null`, and [Step 1](#step-1) showed client as `NXDOMAIN`. | The zone is authoritative, has no record, and fallback is off. Azure returns `NXDOMAIN` instead of the public answer. | Perform [Resolution A](#resolution-a). |
| The matching `A` record exists with the correct private IP (or `resolutionPolicy` is already `NxDomainRedirect`), yet [Step 1](#step-1) showed client as `NXDOMAIN` on the `A` query. | The Azure side looks correct, but a client `NXDOMAIN` can also come from a resolver that never reaches Azure. Confirm the resolution path before assuming a stale cache. | Perform [Step 4b](#step-4b). |
| The matching `A` record exists and the [Step 1](#step-1) `A` query succeeded (returned the private IP), but the [Step 1](#step-1) `AAAA` query returned no answer (`NODATA`) and the app uses IPv6. | IPv4 resolution is healthy. The application is requesting an `AAAA` record that doesn't exist. | Perform [Resolution D](#resolution-d). |
| No `A` record matches, `resolutionPolicy` is `NxDomainRedirect`, and the [Step 1](#step-1) client `A` query resolved to the public IP. | Fallback is working as intended. Public names already resolve. | Resolution is healthy for public names. If a private IP was expected instead, perform [Resolution A](#resolution-a) to add the record. |

### Step 4b

[Step 4a](#step-4a) shows the Azure side is correct (the record exists, or `resolutionPolicy` is `NxDomainRedirect`) yet the client still returns `NXDOMAIN`. Before assuming a stale negative cache ([Resolution C](#resolution-c)), this step confirms the resolution path, that the resolver answering the client actually reaches Azure DNS. A custom or local forwarder (for example `dnsmasq`, `systemd-resolved` on `127.0.0.x`, or a custom VNet DNS server) that never forwards this namespace to Azure produces the same client `NXDOMAIN`. A cache flush won't fix it. 

This step distinguishes a transient stale cache [Resolution C](#resolution-c) from a conditional forwarding or custom DNS misconfiguration (which is out of scope for this guidance).

Run the following commands in Azure CLI or Azure PowerShell.

Run them from the affected VNet host. It compares the client's configured resolver (identified in [Step 1](#step-1)) against Azure DNS queried directly at `168.63.129.16`, uses the `AAAA` response code as corroboration, flushes the local resolver, and then re-queries to determine precedence.

**Bash (Linux)**

```bash
# ── Collect inputs (cached if already set in this session) ──
while [ -z "${FQDN:-}" ]; do
  read -rp "Failing FQDN (required): " FQDN || { echo "FQDN is required."; exit 1; }
done

echo "===== Client's configured resolver ====="
grep -E '^nameserver' /etc/resolv.conf

echo "===== Via the client's configured resolver (before flush) ====="
nslookup -type=A "$FQDN"
nslookup -type=AAAA "$FQDN"

echo "===== Via Azure DNS directly (168.63.129.16) ====="
nslookup -type=A "$FQDN" 168.63.129.16
nslookup -type=AAAA "$FQDN" 168.63.129.16

echo "===== Flush the local resolver, then re-query via the client resolver ====="
sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches 2>/dev/null || true
# If a local dnsmasq/unbound forwarder is in use, restart it to clear its cache too:
sudo systemctl restart dnsmasq 2>/dev/null || sudo systemctl restart unbound 2>/dev/null || true
nslookup -type=A "$FQDN"
```

**Windows (PowerShell)**

```powershell
# Collect input (cached for this PowerShell session)
if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  $env:FQDN = Read-Host "Failing FQDN (required)"
}

if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  Write-Host "FQDN is required. Please set `$env:FQDN and rerun this block."
} else {
  Write-Host "===== Client's configured resolver ====="
  Get-DnsClientServerAddress | Where-Object { $_.ServerAddresses } | Select-Object InterfaceAlias, ServerAddresses | Format-Table -AutoSize

  Write-Host "===== Via the client's configured resolver (before flush) ====="
  nslookup -type=A $env:FQDN
  nslookup -type=AAAA $env:FQDN

  Write-Host "===== Via Azure DNS directly (168.63.129.16) ====="
  nslookup -type=A $env:FQDN 168.63.129.16
  nslookup -type=AAAA $env:FQDN 168.63.129.16

  Write-Host "===== Flush the local resolver, then re-query via the client resolver ====="
  ipconfig /flushdns
  nslookup -type=A $env:FQDN
}
```

### Interpret the results

| If you see... | Meaning | Next step |
|---|---|---|
| Azure DNS (`168.63.129.16`) returns the correct `A` record, the client resolver returns `NXDOMAIN` for `A` but `NODATA`, or **No answer** for `AAAA`. | The resolver answering the client is reaching the authoritative zone (it knows the name has no `AAAA` value). The `A` `NXDOMAIN` is a stale negative cache. | Perform [Resolution C](#resolution-c). |
| Azure DNS (`168.63.129.16`) returns the correct `A` record, and after flushing the local resolver the client `A` query now resolves. | The client or forwarder was holding a stale negative cache and clearing it fixed the name. | Perform [Resolution C](#resolution-c). |
| Azure DNS (`168.63.129.16`) returns the correct `A` record, but the client's custom or local forwarder returns `NXDOMAIN` for both `A` and `AAAA` and still returns `NXDOMAIN` after the flush. | The forwarder doesn't know the zone. It never forwards this namespace to Azure DNS. A cache flush can't fix a forwarding configuration gap. | See [Troubleshoot Azure DNS](troubleshoot-dns.md). |
| Azure DNS (`168.63.129.16`) also returns `NXDOMAIN` for the `A` query. | Azure doesn't actually hold the record. The [Step 4a](#step-4a) reading was against a different zone or VNet. | Perform [Step 4a](#step-4a) to re-confirm the record and the VNet link. |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| No suffix-matching private zone linked to the VNet ([Step 2](#step-2)). | See [Troubleshoot Azure DNS](troubleshoot-dns.md).  |
| Linked private zone and competing forwarding rule, and the forwarding target resolves `{FQDN}` ([Step 3a](#step-3a) and [Step 3b](#step-3b)). | Perform [Resolution B](#resolution-b). |
| Linked private zone and competing forwarding rule, but the forwarding target doesn't resolve `{FQDN}` ([Step 3a](#step-3a) - [Step 4a](#step-4a)). | Perform [Resolution A](#resolution-a). |
| Linked zone, no record, `resolutionPolicy: Default` or `null`, or client `NXDOMAIN` ([Step 4a](#step-4a)). | Perform [Resolution A](#resolution-a). |
| Zone correct (record present or `NxDomainRedirect`) but client still `NXDOMAIN`, and the resolver path reaches Azure ([Step 4a](#step-4a) - [Step 4b](#step-4b)). | Perform [Resolution C](#resolution-c). |
| Zone correct but client still `NXDOMAIN`, and a custom forwarder never forwards the namespace to Azure ([Step 4a](#step-4a) - [Step 4b](#step-4b)). | See [Troubleshoot Azure DNS](troubleshoot-dns.md).  |
| `A` resolves to private IP but `AAAA` is `NXDOMAIN` and app uses IPv6 ([Step 4a](#step-4a)). | Perform [Resolution D](#resolution-d). |

## Resolution A

A Private DNS zone for a public namespace is linked to the VNet and is authoritative for it, but the queried name has no matching record. Because the link doesn't have fallback-to-internet enabled, Azure doesn't fall back to the public internet. It returns the authoritative `NXDOMAIN`.

You have two options. Choose based on the zone type and your intent.

- **The name should resolve publicly *and* the zone is a `privatelink.*` zone** (for example `privatelink.blob.core.windows.net`). Enable fallback-to-internet by setting `resolutionPolicy` to `NxDomainRedirect` (step 2 in this resolution). `resolutionPolicy` or `NxDomainRedirect` is only valid on `privatelink.*` zones. For any other zone (like a registered public domain, `database.windows.net`, `blob.core.windows.net`, and so on) the update is rejected with `(BadRequest) The ResolutionPolicy property is applicable exclusively to private link zones`. For those non-`privatelink` zones, use step 3 in this resolution (remove the link) or add the missing record instead.
- **The private zone is unnecessary for this namespace** (it was created by mistake or is no longer needed). Remove the VNet link or the zone (step 3 in this resolution). This is the correct fix for a non-`privatelink` public namespace shadow.

Run the following commands in Azure CLI.

1. Confirm the current `resolutionPolicy` on the link before changing it.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$VNET_NAME" ] && read -rp "VNet Name:          " VNET_NAME

az network private-dns link vnet list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[?contains(virtualNetwork.id, '$VNET_NAME')].{link:name, resolutionPolicy:resolutionPolicy}" \
  --output json
```

Record the **link name** returned as you need it for the next step.

2. Enable fallback-to-internet by setting the link's `resolutionPolicy` to `NxDomainRedirect`.

> [!NOTE]
> This applies to `privatelink.*` zones only.  

Once set, when the private zone has no matching record, Azure returns the public answer instead of `NXDOMAIN`. If the zone isn't a `privatelink.*` zone, skip to step A.3 and remove the link (or add the missing record) instead.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This updates the VNet link's resolution behavior.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (from A.1): " LINK_NAME

az network private-dns link vnet update \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --name "$LINK_NAME" \
  --resolution-policy NxDomainRedirect
```

3. Remove the unnecessary zone link.

> [!IMPORTANT]
> Use this only if the private zone shouldn't be authoritative for this VNet. Removing the link makes the VNet resolve the namespace publicly again. Any private records this VNet relied on from this zone stop resolving. Confirm no other name in the zone is needed by this VNet before running it.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (from A.1): " LINK_NAME

az network private-dns link vnet delete \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --name "$LINK_NAME" \
  --yes
```

4. Re-run [Step 1](#step-1) from the VNet host. The `A` query should now return the public IP (if you enabled fallback in step 2 or removed the link in step 3). 

If the client still returns `NXDOMAIN`, the old negative answer is cached. Go to [Resolution C](#resolution-c).

## Resolution B

A Private DNS zone and a DNS Private Resolver forwarding rule both target the same namespace on the same VNet. Azure evaluates the linked private zone first, so the forwarding rule you expected to answer is never consulted. The private zone takes precedence unconditionally.

Decide which system should own the namespace and then remove the other for this VNet.

Run the following commands in Azure CLI.

1. Determine the zone link and the competing forwarding rule.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name: " RULESET_NAME

echo "===== Private zone link (precedence winner) ====="
az network private-dns link vnet list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{link:name, vnet:virtualNetwork.id}" \
  --output json

echo "===== Forwarding rule (currently ignored) ====="
az dns-resolver forwarding-rule list \
  --resource-group "$RG" \
  --ruleset-name "$RULESET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{rule:name, domain:domainName, state:forwardingRuleState}" \
  --output table
```

2. If the forwarding target (for example, an on-premises or hub resolver) should own the namespace, remove the conflicting private-zone link from the VNet so the forwarding rule takes effect.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. This unlinks the private zone from the VNet for this namespace. Confirm the on-premises or hub resolver returns complete answers for every name your workload needs before running it.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME
[ -z "$LINK_NAME" ] && read -rp "VNet Link Name (from B.1): " LINK_NAME

az network private-dns link vnet delete \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --name "$LINK_NAME" \
  --yes
```

If the private zone should own the namespace, leave the zone linked and remove the conflicting forwarding rule instead.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$RULESET_NAME" ] && read -rp "Forwarding Ruleset Name: " RULESET_NAME
[ -z "$RULE_NAME" ] && read -rp "Forwarding Rule Name (from B.1): " RULE_NAME

az dns-resolver forwarding-rule delete \
  --resource-group "$RG" \
  --ruleset-name "$RULESET_NAME" \
  --subscription "$SUBSCRIPTION" \
  --name "$RULE_NAME" \
  --yes
```

3. Re-run [Step 1](#step-1). The namespace should now resolve through the single owner you kept. 

If clients still return the old answer, go to [Resolution C](#resolution-c).

## Resolution C

The Azure-side configuration is now correct (the record exists, fallback is enabled, or the shadowing zone was removed), but a resolver between the application and Azure cached the earlier `NXDOMAIN`. DNS negative answers are cached for the duration of the zone start of authority (SOA) minimum time to live (TTL), so clients keep failing until that interval expires or the cache is flushed.

Run the following commands in Azure CLI or Azure PowerShell.

1. Check how long the negative answer is cached. The SOA `minimumTtl` is the negative-cache lifetime.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME

az network private-dns record-set soa show \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "{ttl:ttl, minimumTtl:soaRecord.minimumTtl}" \
  --output json
```

The `minimumTtl` (in seconds) is the longest a downstream resolver holds the stale `NXDOMAIN`.

2. Flush the cache on the client and on any intermediary resolver, then re-test. Run the command for the client OS you are testing from.

**Bash (Linux client with systemd-resolved)**

```bash
# Flush the local stub resolver cache, then re-query
sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches

while [ -z "${FQDN:-}" ]; do
  read -rp "Failing FQDN (required): " FQDN || { echo "FQDN is required."; exit 1; }
done
nslookup -type=A "$FQDN"
```

**Windows (PowerShell)**

```powershell
# Flush the local DNS resolver cache, then re-query
ipconfig /flushdns

if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  $env:FQDN = Read-Host "Failing FQDN (required)"
}

if ([string]::IsNullOrWhiteSpace($env:FQDN)) {
  Write-Host "FQDN is required. Please set `$env:FQDN and rerun this block."
} else {
  nslookup -type=A $env:FQDN
}
```

On a Windows client, if a local DNS forwarder or proxy is in use, clear the intermediary cache so it doesn't continue serving stale negative answers.

If a custom DNS forwarder or Azure Firewall DNS Proxy sits between the client and Azure, flush or restart that resolver. It caches the negative answer independently of the client.

3. Re-run [Step 1](#step-1) after the flush, or after the `minimumTtl` interval from step 1 has elapsed. The `A` query should now return the corrected answer. 

If it still fails after the cache is cleared and the TTL has expired, re-run [Step 2](#step-2). The Azure-side fix might not have applied to the VNet you're testing from.

## Resolution D

IPv4 resolution is healthy and the `A` record returns the correct private IP, but the application issues an `AAAA` (IPv6) lookup. Azure private endpoints register only `A` records, so the `AAAA` query returns no answer (`NODATA` or `NOERROR`, shown as `*** Can't find <name>: No answer`). An application that prefers or requires IPv6 treats this condition as a failure.

Run the following commands in Azure CLI.

1. Confirm the zone has the `A` record but no `AAAA` record for the host label.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:     " RG
[ -z "$PRIVATE_ZONE_NAME" ] && read -rp "Private Zone Name:  " PRIVATE_ZONE_NAME

echo "===== A records (expected: host label present) ====="
az network private-dns record-set a list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{record:name, ips:aRecords[].ipv4Address}" \
  --output json

echo "===== AAAA records (expected: empty for private endpoints) ====="
az network private-dns record-set aaaa list \
  --resource-group "$RG" \
  --zone-name "$PRIVATE_ZONE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{record:name, ips:aaaaRecords[].ipv6Address}" \
  --output table
```

If the `A` record is present and the `AAAA` list is empty, the application uses the IPv4 (`A`) result.

2. Fix the application's lookup pattern. The private endpoint path is IPv4-only, so follow these steps:

- Configure the application or its client library to request `A` records (IPv4). For example, use the `AF_INET` or `IPv4` address family or disable IPv6-only resolution for this hostname.
- If the platform performs a dual-stack lookup and fails on the `AAAA` `NXDOMAIN`, set it to fall through to the `A` answer (like Happy Eyeballs or dual-stack fallback) rather than treating `AAAA` `NXDOMAIN` as fatal.
- Don't add a synthetic `AAAA` record pointing at the private endpoint. The private endpoint doesn't serve traffic over IPv6, so the connection fails at the transport layer.

This change is an application or host-stack configuration change. There's no Azure DNS write operation for this change.

3. Re-run [Step 1](#step-1). The `A` query continues to return the private IP, and the application should now connect over IPv4 without waiting on the `AAAA` failure.

## References

- [What is Azure DNS Private Resolver?](/azure/dns/dns-private-resolver-overview)
- [Fallback to internet for Azure Private DNS zones](/azure/dns/private-dns-fallback)
- [Private endpoint DNS integration](/azure/private-link/private-endpoint-dns-integration)
- [Troubleshoot Azure DNS](troubleshoot-dns.md)
