---
title: "Troubleshoot a Site-to-Site or Point-to-Site VPN tunnel that will not connect in Azure VPN Gateway"
description: Troubleshoot an Azure VPN Gateway tunnel that won't connect. Follow targeted checks for IKE/IPsec, routing, NAT, and policy issues to apply the right fix.
ms.service: azure-vpn-gateway
ms.topic: troubleshooting
ms.date: 09/18/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: stdoroff, duau, chadmat
ai-usage: ai-assisted
---

# Troubleshoot a Site-to-Site or Point-to-Site VPN tunnel that won't connect in Azure VPN Gateway

## Summary

An Azure VPN Gateway tunnel that never reaches **Connected** almost always fails during IKE/IPsec negotiation for one of a small set of reasons: 

- A pre-shared key (PSK) mismatch
- The wrong on-premises peer public IP on the local network gateway 
- A UDR or NSG blocking the GatewaySubnet
- An IKE/IPsec policy mismatch such as Perfect Forward Secrecy (PFS) enabled on only one side
- An on-premises device that's behind NAT or isn't on the validated-devices list
- A gateway that's stuck in a failed provisioning state

This guide runs one discriminating command per cause, tells you exactly what the output means, and routes you to the matching fix. It augments the classic linear article by delivering a decision tree.

## Symptoms

You might experience one or more of the following symptoms:

- The connection resource never reaches `connectionStatus: "Connected"`, it stays `Connecting`, `NotConnected`, or `Unknown`.
- Both `egressBytesTransferred` and `ingressBytesTransferred` on the connection stay at `0`.
- The Azure portal shows the connection status as **Not connected** or **Connecting**.
- The on-premises VPN device logs report IKE Phase 1 or Phase 2 failures such as `AUTHENTICATION_FAILED`, `NO_PROPOSAL_CHOSEN`, or `TS_UNACCEPTABLE`.
- A Point-to-Site or Site-to-Site tunnel that previously worked stopped connecting after the on-premises device, ISP, or firewall changed.
- A newly created connection never came up.

## Prerequisites

- **Permissions required:** `Network Contributor` on the resource group that contains the VPN gateway, the connection, and the local network gateway, plus read access to any NSG or route table on the GatewaySubnet.
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access. Reading IKE/Tunnel diagnostic logs additionally requires a Log Analytics workspace that the gateway's diagnostic settings send to.
- **What you need before starting:**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the VPN gateway and connection | `myResourceGroup` |
| `{GATEWAY_NAME}` | Virtual network gateway (VPN gateway) resource name | `myVpnGateway` |
| `{CONNECTION_NAME}` | Connection resource name (the S2S/P2S connection) | `myS2SConnection` |
| `{LOCAL_GATEWAY_NAME}` | Local network gateway representing the on-premises device | `myLocalGateway` |

> [!TIP]
> Each script in the following sections prompts you for the required values interactively. Select **Try It** to open Cloud Shell and answer the prompts. The session caches values, so you only need to enter them once.

---

## Diagnostic steps

> **These steps are read-only. They don't make any changes to your environment.** The only exception is [Step 5](#step-5), which offers an optional write command to enable diagnostic logging if it's not already on. That command is clearly marked.

Run the steps in order. Each step either confirms a cause and routes you to a resolution, or clears that cause and sends you to the next step.

---

### Step 1

**What this checks:** The live connection status and byte counters.  This information tells you whether the tunnel is genuinely failing to negotiate (a connect failure) versus already up (a different problem).

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME

az network vpn-connection show \
  --name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{status:connectionStatus, egressBytes:egressBytesTransferred, ingressBytes:ingressBytesTransferred, connectionType:connectionType, usePolicyBasedTrafficSelectors:usePolicyBasedTrafficSelectors}" \
  --output json
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `status: "Connected"` with both `egressBytes` and `ingressBytes` greater than 0 | The tunnel is up and passing traffic — this condition isn't a connect failure | This guide doesn't apply. If throughput is poor or drops, see the `intermittent disconnects` troubleshooter. |
| `status: "Connected"` but `egressBytes` and/or `ingressBytes` are 0 | The tunnel negotiated but no traffic is flowing — a routing or selector problem, not a connect failure | → [Resolution H](#resolution-h) — traffic selector or policy-based subnet mismatch |
| `status": "Connecting"`, `"NotConnected"`, or `"Unknown"` with 0 bytes | The tunnel is failing IKE/IPsec negotiation | → [Step 2](#step-2) |
| `ResourceNotFound` or `(ResourceNotFound)` error | Subscription, resource group, or connection name is wrong | Verify your variables and re-run |

---

### Step 2

**What this step checks:** Whether the gateway itself is healthy. A gateway stuck in a failed or in-progress provisioning state can't bring up any tunnel, and the fix is unrelated to IKE settings. This step also records the VPN type (route-based vs policy-based), which changes how later steps behave.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$GATEWAY_NAME" ] && read -rp "VPN Gateway Name: " GATEWAY_NAME

az network vnet-gateway show \
  --name "$GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, gatewayType:gatewayType, vpnType:vpnType, sku:sku.name, activeActive:activeActive}" \
  --output json
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `provisioningState: "Succeeded"` and `vpnType": "RouteBased"` | Gateway is healthy and route-based | → [Step 3](#step-3) |
| `provisioningState: "Succeeded"` and `vpnType": "PolicyBased"` | Gateway is healthy but policy-based. It uses IKEv1 and exact traffic selectors, so subnet or selector mismatches are more likely. | → [Step 3](#step-3) (keep [Resolution H](#resolution-h) in mind) |
| `provisioningState: "Failed"` or `"Updating"` (and it doesn't clear within a few minutes) | The gateway isn't in a serviceable state and can't negotiate any tunnel. | → [Resolution G](#resolution-g) — recover the gateway |
| `provisioningState: "Deleting"` | The gateway is being deleted. | Stop — the connection can't come up. Confirm whether the deletion was intended. |

---

### Step 3

**What this checks:** Whether the local network gateway's `gatewayIpAddress` matches the **current public IP the on-premises device actually presents to Azure**. A wrong or changed peer IP, or a device behind NAT whose public NAT address differs from what Azure has, means IKE packets never reach the right peer. This single command plus two answers deterministically separates a plain wrong-IP [Resolution C](#resolution-c) from a NAT mismatch [Resolution E](#resolution-e).

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:         " RG
[ -z "$LOCAL_GATEWAY_NAME" ] && read -rp "Local Network Gateway:  " LOCAL_GATEWAY_NAME

az network local-gateway show \
  --name "$LOCAL_GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{configuredPeerIp:gatewayIpAddress, fqdn:fqdn, onPremAddressSpace:localNetworkAddressSpace.addressPrefixes}" \
  --output json
```

Then determine the **real** current public IP of the on-premises VPN device. From a host on the on-premises network (not from Cloud Shell), run:

```bash
curl -s https://api.ipify.org; echo
```

Record the answers to two questions:
- Is the on-premises VPN device **behind NAT** (its WAN/external interface holds a private address that a firewall/router translates to a public address)? **Yes / No**
- Does `configuredPeerIp` from Azure equal the public IP the device presents (the `curl` result, or the device's public NAT address)? **Match / Mismatch**

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `configuredPeerIp` **matches** the device's public IP, device is **not** behind NAT | Peer IP is correct | → [Step 4](#step-4) |
| `configuredPeerIp` **does not match** the device's public IP, device is **not** behind NAT | The local network gateway points at the wrong or a stale peer IP | → [Resolution C](#resolution-c) — correct the peer public IP |
| Device **is** behind NAT and `configuredPeerIp` is the device's **private/internal** interface address (not its public NAT address) | NAT mismatch — Azure must be given the public NAT address, and the device must use IKEv2 NAT-T | → [Resolution E](#resolution-e) — fix the NAT/external-interface address |
| `configuredPeerIp` matches the public NAT address and NAT-T is configured | Peer addressing is correct even with NAT | → [Step 4](#step-4) |

---

### Step 4

**What this step checks:** Whether a user-defined route (UDR) or a network security group (NSG) on the **GatewaySubnet** is blocking the IKE/IPsec traffic (UDP 500, UDP 4500, and ESP) to or from the on-premises peer. This problem causes the classic "the gateway is fine but nothing reaches the peer" issue.

#### Run this command

First resolve the route table and NSG (if any) attached to the GatewaySubnet:

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$VNET_NAME" ] && read -rp "VNet Name (hosting the gateway): " VNET_NAME

az network vnet subnet show \
  --name GatewaySubnet \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{routeTableId:routeTable.id, nsgId:networkSecurityGroup.id}" \
  --output json
```

If `routeTableId` isn't null, list its routes and look for a route that redirects the on-premises peer IP or a default route to a next hop that would block IKE traffic:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$ROUTE_TABLE_ID" ] && read -rp "Route Table ID (the routeTableId from above): " ROUTE_TABLE_ID

# Derive the route table name from the ARM ID returned by the previous command
ROUTE_TABLE_NAME="${ROUTE_TABLE_ID##*/}"

az network route-table route list \
  --resource-group "$RG" \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, prefix:addressPrefix, nextHopType:nextHopType, nextHopIp:nextHopIpAddress}" \
  --output table
```

If `nsgId` isn't null, list its Deny rules that affect UDP 500 or 4500 or the peer address:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$NSG_ID" ] && read -rp "NSG ID (from above): " NSG_ID

az network nsg show \
  --ids "$NSG_ID" \
  --query "securityRules[?access=='Deny'].{name:name, priority:priority, direction:direction, destPort:destinationPortRange, source:sourceAddressPrefix, dest:destinationAddressPrefix}" \
  --output table
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| A UDR sends the on-premises peer IP (or `0.0.0.0/0`) to `VirtualAppliance`, `VirtualNetworkGateway` other than this gateway, or `None` | The route blocks IKE traffic to the peer | → [Resolution D](#resolution-d) — fix the GatewaySubnet route or NSG |
| An NSG Deny rule matches `destinationPortRange` `500`, `4500`, or `*`, or the peer address, inbound or outbound | The NSG drops IKE/IPsec traffic on the GatewaySubnet | → [Resolution D](#resolution-d) — fix the GatewaySubnet route or NSG |
| `routeTableId` and `nsgId` are both null, or no matching Deny or block route exists | Routing and NSG on the GatewaySubnet aren't the cause | → [Step 5](#step-5) |

---

### Step 5

**What this step checks:** The **IKE diagnostic logs** — the single richest discriminating signal. The `IKEDiagnosticLog` and `TunnelDiagnosticLog` categories record the exact negotiation failure reason (authentication failure, no proposal chosen, traffic-selector rejection, or no packets received at all), which distinguishes the remaining causes (PSK, PFS/policy, validated device, and confirms peer-reachability findings).

#### Confirm diagnostic logging is enabled

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$GATEWAY_NAME" ] && read -rp "VPN Gateway Name: " GATEWAY_NAME

GATEWAY_ID=$(az network vnet-gateway show \
  --name "$GATEWAY_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az monitor diagnostic-settings list \
  --resource "$GATEWAY_ID" \
  --query "value[].{name:name, workspaceId:workspaceId, logs:logs[?enabled].categoryGroup}" \
  --output json
```

If the list is empty, no diagnostic logs are being collected. Enable them so the IKE failure reason is captured, then reproduce the connection attempt:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command creates a diagnostic setting on the gateway that streams its IKE logs to the Log Analytics workspace you specify.

> [!TIP]
> It doesn't change tunnel configuration, but it is a write operation. Wait a few minutes after enabling, then trigger a fresh connection attempt so the logs capture a negotiation.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$GATEWAY_NAME" ] && read -rp "VPN Gateway Name: " GATEWAY_NAME
[ -z "$WORKSPACE_ID" ] && read -rp "Log Analytics Workspace resource ID: " WORKSPACE_ID

GATEWAY_ID=$(az network vnet-gateway show \
  --name "$GATEWAY_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query id --output tsv)

az monitor diagnostic-settings create \
  --name vpn-ike-diag \
  --resource "$GATEWAY_ID" \
  --workspace "$WORKSPACE_ID" \
  --logs '[{"categoryGroup":"allLogs","enabled":true}]'
```

#### Query the IKE negotiation failures

Query the workspace for recent IKE log entries. Use the workspace **GUID** (customer ID), which you can read from the workspace resource.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$WORKSPACE_GUID" ] && read -rp "Log Analytics Workspace GUID (customerId): " WORKSPACE_GUID

az monitor log-analytics query \
  --workspace "$WORKSPACE_GUID" \
  --analytics-query "AzureDiagnostics | where Category == 'IKEDiagnosticLog' | where TimeGenerated > ago(1h) | project TimeGenerated, Message | order by TimeGenerated desc | take 50" \
  --output table
```

<!-- VERIFIED 2026-09-14 against live workspace law-aegt-s01: the Step 5 diagnostic-settings create block uses the default (Azure diagnostics) destination (logAnalyticsDestinationType is null), so gateway IKE logs land in the classic 'AzureDiagnostics' table filtered by Category == 'IKEDiagnosticLog'. Azure VPN Gateway doesn't emit to a resource-specific/dedicated table, so the query above is the correct and only surface. -->

#### Interpret the result

Read the most recent `Message` entries for the failed negotiation and match the phrase:

> [!NOTE]
> The exact strings below are the **Azure gateway's** own `IKEDiagnosticLog` phrasing. The **on-premises VPN device's** logs describe the same failures by using the classic IKE terms (`AUTHENTICATION_FAILED`, `NO_PROPOSAL_CHOSEN`, `TS_UNACCEPTABLE`), shown in parentheses as a secondary hint. Match whichever log you have in front of you — both point to the same resolution.

| If the IKE log shows... | Meaning | Next step |
|---|---|---|
| `Sending Notify Message - Authentication failed`, `IKE Tunnel closed ... with status IKE authentication credentials are unacceptable`, `[ErrorCode] 0x35E9`/`13801 [ErrorMessage] IKE authentication credentials are unacceptable`, or `[ErrorCode] 0x3602 [ErrorMessage] Failed to verify signature` (on-premises device logs might show `AUTHENTICATION_FAILED`) | The pre-shared key doesn't match between Azure and the on-premises device | → [Resolution B](#resolution-b) — reset the pre-shared key |
| `Sending Notify Message - Policy Mismatch`, `IKE Tunnel closed ... with status Policy match error`, `[ErrorCode] 0x362C [ErrorMessage] Policy match error`, or `IkeCleanupMMNegotiation called with error 13868` (on-premises device logs might show `NO_PROPOSAL_CHOSEN` / no matching proposal) | IKE/IPsec policy mismatch — commonly PFS enabled on one side only, or mismatched DH group / encryption | → [Resolution F](#resolution-f) — align the IKE/IPsec policy |
| A `Received Traffic Selector payload request` whose `StartAddress`/`EndAddress` ranges don't match your side, followed by `[IkeEvent] SA_NEGOTIATION_FAILED` and `[ErrorMessage] Negotiation timed out` (`[ErrorCode] 0x35ED`) (on-premises device logs might show `TS_UNACCEPTABLE` / proxy-ID mismatch) | Phase 2 traffic-selector / subnet mismatch (most common on policy-based gateways) | → [Resolution H](#resolution-h) — traffic selector mismatch (deep dive routed to the selector guide) |
| No `IKEDiagnosticLog` entries at all for the attempt, even though Steps 3 and 4 passed | No IKE packets are reaching the gateway from the peer — the on-premises device isn't sending, is filtering UDP 500/4500 outbound, or isn't a supported/validated configuration | → [Resolution A](#resolution-a) — validated device and on-premises reachability |
| `Unsupported`, `INVALID_KE_PAYLOAD`, `unsupported IKE version`, or repeated malformed packets | The on-premises device is using a configuration Azure doesn't support | → [Resolution A](#resolution-a) — validated device and on-premises reachability |
| Logs can't be enabled or read in this environment | You can't obtain the discriminating signal here | → [Step 6](#step-6) to compare policy directly, then if still unresolved, file an Azure support request |

---

### Step 6

**What this checks:** A direct read-only comparison of the connection's configured IKE/IPsec policy, used to **confirm** a suspected PFS or policy mismatch from Step 5 without relying on log text. Use this check when the IKE log points to `NO_PROPOSAL_CHOSEN` or when logs are unavailable.

#### Run this command

**Azure CLI:**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME

az network vpn-connection show \
  --name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{ipsecPolicies:ipsecPolicies, connectionProtocol:connectionProtocol, usePolicyBasedTrafficSelectors:usePolicyBasedTrafficSelectors}" \
  --output json
```

#### Interpret the result

| If you see... | Meaning | Next step |
|---|---|---|
| `ipsecPolicies": []` (empty) | The connection uses Azure default policy — Azure accepts a broad set of proposals, so the mismatch is on the on-premises device. Align the device to the [default IPsec/IKE parameters](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#ipsec) | → [Resolution F](#resolution-f) |
| `ipsecPolicies` lists a `pfsGroup` other than `None` (for example `PFS2048`, `ECP256`) and the on-premises device has PFS disabled or set to a different group | Custom policy with a PFS group that the on-premises device doesn't match — Phase 2 fails | → [Resolution F](#resolution-f) |
| `ipsecPolicies` custom values (DH group, encryption, integrity) differ from the on-premises device | Custom IKE/IPsec policy mismatch | → [Resolution F](#resolution-f) |
| Policy matches the device exactly and logs showed no proposal issue | Policy is not the cause | Re-check [Step 5](#step-5) log text; if still unresolved, file an Azure support request |

---

## Decision map

Every branch in the following table is reachable from a runnable signal in the preceding steps.

| Diagnostic result | Next action |
|---|---|
| Step 1: `Connected` with bytes flowing | Not a connect failure — see the `intermittent disconnects` troubleshooter |
| Step 1: `Connected` but 0 bytes, or Step 5 shows a mismatched `Traffic Selector payload` + `SA_NEGOTIATION_FAILED` / `Negotiation timed out` (device logs might show `TS_UNACCEPTABLE`) | [Resolution H — Traffic selector / subnet mismatch](#resolution-h) |
| Step 2: `provisioningState` Failed/Updating/Deleting | [Resolution G — Recover the gateway](#resolution-g) |
| Step 3: peer IP mismatch, device not behind NAT | [Resolution C — Correct the peer public IP](#resolution-c) |
| Step 3: device behind NAT, configured IP is the private/internal address | [Resolution E — Fix the NAT / external-interface address](#resolution-e) |
| Step 4: UDR blackholes peer, or NSG Deny on UDP 500/4500 | [Resolution D — Fix the GatewaySubnet route/NSG](#resolution-d) |
| Step 5: IKE log `Authentication failed` / `IKE authentication credentials are unacceptable` (device logs might show `AUTHENTICATION_FAILED`) | [Resolution B — Reset the pre-shared key](#resolution-b) |
| Step 5/6: IKE log `Policy Mismatch` / `Policy match error` — PFS or policy mismatch (device logs might show `NO_PROPOSAL_CHOSEN`) | [Resolution F — Align the IKE/IPsec policy](#resolution-f) |
| Step 5: no IKE packets received, or unsupported/malformed | [Resolution A — Validated device and on-premises reachability](#resolution-a) |
| All diagnostics pass, tunnel still down | File an Azure support request |

---

## Resolution A

**Root cause:** No IKE packets reach the Azure gateway from the on-premises peer even though the peer IP (Step 3) and the GatewaySubnet routing/NSG (Step 4) are correct, or the device presents a configuration that Azure doesn't support. This condition maps to the classic article's "device not on the validated-devices list" and on-premises-side reachability steps.

Common contributing causes:
- The on-premises device model or firmware isn't on the Azure [validated VPN devices](/azure/vpn-gateway/vpn-gateway-about-vpn-devices) list, or it's configured outside the validated parameters.
- The on-premises firewall or ISP blocks **outbound** UDP 500/4500 or ESP toward the Azure gateway public IP.
- The device isn't actually initiating (dead peer, disabled tunnel, wrong Azure gateway public IP configured on the device).

### A.1

Confirm the Azure gateway public IP that the on-premises device must target.

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$GATEWAY_NAME" ] && read -rp "VPN Gateway Name: " GATEWAY_NAME

az network vnet-gateway show \
  --name "$GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "ipConfigurations[].publicIPAddress.id" \
  --output tsv \
| while read -r PIP_ID; do
    az network public-ip show --ids "$PIP_ID" --query "{name:name, ip:ipAddress}" --output json
  done
```

Confirm the on-premises device is configured to initiate to this exact public IP (both IPs, if the gateway is active-active).

### A.2

On the on-premises device, verify it's on the [validated VPN devices](/azure/vpn-gateway/vpn-gateway-about-vpn-devices) list and that its configuration matches Azure's [default IPsec/IKE parameters](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#ipsec) (or the custom policy you confirmed in [Step 6](#step-6)). Confirm the device firewall and the ISP allow **outbound** UDP 500, UDP 4500, and ESP to the Azure gateway public IP.

### A.3

After correcting the device configuration or firewall, re-run [Step 1](#step-1). The status should move to `Connecting` then `Connected`, and [Step 5](#step-5) should now show `IKEDiagnosticLog` entries for the negotiation. If IKE entries appear but report a new failure reason, return to [Step 5](#step-5) and follow the matching row.

---

## Resolution B

**Root cause:** The pre-shared key (PSK) configured on the Azure connection doesn't match the key on the on-premises device, so IKE authentication fails (`AUTHENTICATION_FAILED`).

### B.1

Read the current shared key that Azure holds for this connection so you can compare it to the device.

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME

az network vpn-connection shared-key show \
  --connection-name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

Compare this value with the PSK configured on the on-premises device. Some devices silently truncate long keys or reject certain special characters. Use an alphanumeric key of 20 or more characters.

### B.2

Set both sides to the same PSK. Update the Azure side:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command sets the Azure side of the connection's pre-shared key to the new value you enter.

> [!TIP]
> Set the on-premises device to the identical value. Changing the key briefly resets the tunnel.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME
read -rp "New shared key value: " SHARED_KEY

az network vpn-connection shared-key update \
  --connection-name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --value "$SHARED_KEY"
```

### B.3

Re-run [Step 1](#step-1). The status should reach `Connected` with bytes incrementing. If it still fails, re-check [Step 5](#step-5) — if the failure moved from `AUTHENTICATION_FAILED` to `NO_PROPOSAL_CHOSEN`, proceed to [Resolution F](#resolution-f).

---

## Resolution C

**Root cause:** The local network gateway's `gatewayIpAddress` doesn't match the on-premises device's current public IP address (a typo, or the ISP-assigned IP changed), so Azure sends IKE to the wrong destination.

### C.1

Update the local network gateway with the correct current public IP recorded in [Step 3](#step-3).

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command updates the local network gateway's `gatewayIpAddress` to the on-premises public IP you enter.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$LOCAL_GATEWAY_NAME" ] && read -rp "Local Network Gateway: " LOCAL_GATEWAY_NAME
read -rp "Correct on-prem public IP: " PEER_PUBLIC_IP

az network local-gateway update \
  --name "$LOCAL_GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --gateway-ip-address "$PEER_PUBLIC_IP"
```

> If the on-premises public IP changes frequently, consider configuring the local network gateway with an FQDN instead of a static IP so DNS resolves the current address.

### C.2

Re-run [Step 1](#step-1). The tunnel should negotiate once IKE reaches the correct peer. If it still fails after the IP is corrected, continue to [Step 4](#step-4).

---

## Resolution D

**Root cause:** A user-defined route on the GatewaySubnet blackholes traffic to the on-premises peer, or an NSG on the GatewaySubnet denies IKE/IPsec (UDP 500, UDP 4500, ESP).

### D.1

**If a UDR is the cause:** remove or correct the offending route so traffic to the on-premises peer prefix uses the `VirtualNetworkGateway`/`Internet` next hop rather than a virtual appliance or `None`. Confirm the offending route name and prefix from [Step 4](#step-4), then:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command deletes the offending user-defined route from the route table so gateway-subnet traffic to the on-premises peer is no longer blackholed.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$ROUTE_TABLE_NAME" ] && read -rp "Route Table Name: " ROUTE_TABLE_NAME
[ -z "$ROUTE_NAME" ] && read -rp "Offending Route Name (from Step 4): " ROUTE_NAME

az network route-table route delete \
  --route-table-name "$ROUTE_TABLE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$ROUTE_NAME"
```

### D.2

**If an NSG Deny rule is the cause:** Don't associate an NSG with the GatewaySubnet. If an NSG is present and denying IKE/IPsec, either remove the association or add a higher-priority Allow rule for UDP 500 and 4500 to or from the on-premises peer. To add the Allow rule:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command adds a higher-priority inbound Allow rule for UDP 500 and 4500 from the on-premises peer to the GatewaySubnet NSG.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$NSG_NAME" ] && read -rp "GatewaySubnet NSG Name: " NSG_NAME
read -rp "On-prem peer public IP: " PEER_PUBLIC_IP

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-IKE-IPsec-Inbound \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Udp \
  --source-address-prefix "$PEER_PUBLIC_IP" \
  --destination-port-ranges 500 4500
```

### D.3

Re-run [Step 1](#step-1). The tunnel should negotiate once IKE traffic is no longer blocked. If IKE still shows no packets, continue to [Resolution A](#resolution-a).

---

## Resolution E

**Root cause:** The on-premises device is behind NAT and the local network gateway was configured with the device's private or internal external-interface address instead of its public NAT address, or the device isn't using IKEv2 NAT-Traversal. Azure must peer to the public NAT address.

### E.1

Set the local network gateway to the **public NAT address** the device presents to the internet (from [Step 3](#step-3)).

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command sets the local network gateway's `gatewayIpAddress` to the public NAT address you enter.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$LOCAL_GATEWAY_NAME" ] && read -rp "Local Network Gateway: " LOCAL_GATEWAY_NAME
read -rp "Public NAT address of the on-prem device: " NAT_PUBLIC_IP

az network local-gateway update \
  --name "$LOCAL_GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --gateway-ip-address "$NAT_PUBLIC_IP"
```

### E.2

On the on-premises device and its NAT firewall, confirm:
- The connection uses **IKEv2** (route-based) so NAT-T (UDP 4500) is available. Verify `connectionProtocol` from [Step 6](#step-6) is `IKEv2`.
- The NAT device forwards UDP 500 and UDP 4500 to the internal VPN device and doesn't rewrite the IKE identity in a way the device doesn't expect.

### E.3

Re-run [Step 1](#step-1). If the peer address is now the public NAT IP and NAT-T is in use, the tunnel should negotiate. If IKE now reports an authentication or proposal error, follow the matching row in [Step 5](#step-5).

---

## Resolution F

**Root cause:** The IKE/IPsec policy doesn't match between Azure and the on-premises device, so Phase 1 or Phase 2 returns `NO_PROPOSAL_CHOSEN`. The most common form is Perfect Forward Secrecy (PFS) enabled on one side only, or a different DH group, encryption, or integrity algorithm.

### F.1

Decide which side to change. If the device must keep a specific policy (for example, corporate standard requires a given PFS group), set a **matching custom IPsec/IKE policy** on the Azure connection. Use the values you confirmed in [Step 6](#step-6) and align every field to the device.

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command applies a custom IPsec/IKE policy to the connection, replacing Azure's default parameters and restricting the connection to the exact algorithms you specify.

> [!TIP]
> Specify all six algorithm fields plus SA lifetime and size together; they must exactly match the on-premises device.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME

# Set each value to match the on-premises device exactly.
az network vpn-connection ipsec-policy add \
  --connection-name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --dh-group DHGroup14 \
  --ike-encryption AES256 \
  --ike-integrity SHA256 \
  --ipsec-encryption AES256 \
  --ipsec-integrity SHA256 \
  --pfs-group None \
  --sa-lifetime 27000 \
  --sa-max-size 102400000
```

> Set `--pfs-group` to the exact value the device uses (for example, `PFS2048` or `ECP256`), or `None` if the device has PFS disabled. A PFS mismatch here is the single most common cause of `NO_PROPOSAL_CHOSEN` in this scenario.

### F.2

Alternatively, if you can change the device, remove the custom Azure policy so the connection accepts Azure's broad [default IPsec/IKE parameters](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#ipsec), and configure the device to any one supported combination:

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command clears any custom IPsec/IKE policy from the connection so it accepts Azure's default parameters.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$CONNECTION_NAME" ] && read -rp "Connection Name:  " CONNECTION_NAME

az network vpn-connection ipsec-policy clear \
  --connection-name "$CONNECTION_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

### F.3

Re-run [Step 1](#step-1). Phase 2 should complete and the status should reach `Connected`. Confirm with [Step 6](#step-6) that the policies now match. If Phase 2 now reports `TS_UNACCEPTABLE`, proceed to [Resolution H](#resolution-h).

---

## Resolution G

**Root cause:** The gateway isn't in a serviceable provisioning state (`Failed` or stuck `Updating`), so it can't negotiate any tunnel. This condition maps to the classic article's gateway-health step.

### G.1

Re-check the state after a few minutes. Transient `Updating` states clear on their own. If the state stays `Failed`, reset the gateway to force a redeploy of the active instances. This action doesn't delete the configuration but briefly drops all tunnels on the gateway.

> **⚠️ WRITE OPERATION — requires customer approval before executing**

This command resets the gateway, redeploying its active instances without deleting the connection configuration.

> [!TIP]
> A gateway reset restarts the gateway instances and drops all tunnels on this gateway for a short time. Schedule it in a maintenance window if other tunnels are healthy.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:  " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:   " RG
[ -z "$GATEWAY_NAME" ] && read -rp "VPN Gateway Name: " GATEWAY_NAME

az network vnet-gateway reset \
  --name "$GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION"
```

### G.2

Re-run [Step 2](#step-2). The `provisioningState` should return to `Succeeded`. Then re-run [Step 1](#step-1). If the gateway doesn't leave the `Failed` state after a reset, this condition is on the platform side. See the `stuck Failed/Updating provisioning state` troubleshooter and file an Azure support request. When the gateway is `Succeeded` but the tunnel is still down, return to [Step 3](#step-3).

---

## Resolution H

**Root cause:** IKE authenticates and Phase 1 completes, but Phase 2 fails or no traffic flows because the traffic selectors or proxy IDs (the local and remote subnets) don't match. This mismatch is most common on policy-based gateways. This guide keeps this branch shallow. The full selector and proxy ID troubleshooting guide lives in the dedicated selector-mismatch AEGT.

### H.1

Confirm the address spaces both sides expect.

**Azure CLI (read-only):**
```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:       " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:        " RG
[ -z "$LOCAL_GATEWAY_NAME" ] && read -rp "Local Network Gateway: " LOCAL_GATEWAY_NAME

az network local-gateway show \
  --name "$LOCAL_GATEWAY_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "localNetworkAddressSpace.addressPrefixes" \
  --output json
```

Confirm these on-premises prefixes exactly match the remote networks you configured on the device, and that the VNet address space matches what the device expects as the remote network. For policy-based connections, the subnet definitions must match exactly.

### H.2

The complete traffic selector and proxy ID walkthrough (policy-based selectors, `usePolicyBasedTrafficSelectors`, and multiple subnet pairs) is out of scope for this guide. The dedicated selector-mismatch guide covers this topic. For selector background, see `Troubleshoot a Site-to-Site VPN connection that cannot connect` (step covering matching subnets on policy-based gateways). Return here only if the selectors are correct but the tunnel still won't connect. In that case, re-run [Step 5](#step-5).

---

## References

- [Validated VPN devices and device configuration guides](/azure/vpn-gateway/vpn-gateway-about-vpn-devices)
- [About cryptographic requirements and Azure VPN gateways (IPsec/IKE policy)](/azure/vpn-gateway/vpn-gateway-about-compliance-crypto)
- [Configure custom IPsec/IKE connection policies for S2S VPN](/azure/vpn-gateway/ipsec-ike-policy-howto)

