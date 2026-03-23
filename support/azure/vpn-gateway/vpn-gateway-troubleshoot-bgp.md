---
title: 'Troubleshoot BGP issues'
titleSuffix: Azure VPN Gateway
description: Learn how to diagnose and resolve common BGP (Border Gateway Protocol) issues with Azure VPN Gateway, including peer connectivity, route learning, and session stability.
author: cherylmc
ms.service: azure-vpn-gateway
ms.topic: troubleshooting
ms.date: 03/23/2026
ms.author: cherylmc
# Customer intent: As a network administrator, I want to troubleshoot BGP issues with my Azure VPN Gateway so that I can restore dynamic routing between my on-premises networks and Azure.
---

# Troubleshoot BGP issues for Azure VPN Gateway

This article helps you diagnose and resolve common BGP (Border Gateway Protocol) issues with Azure VPN Gateway. For an overview of BGP support, see [About BGP and VPN Gateway](/azure/vpn-gateway/vpn-gateway-bgp-overview).

Before troubleshooting specific symptoms, verify that the following baseline requirements are met. Many BGP issues stem from configuration mismatches.

| Check | Requirement | How to verify |
|-------|-------------|---------------|
| **Gateway SKU** | BGP isn't supported on the Basic SKU. Use any other SKU. | Azure portal > Virtual network gateway > **Overview** |
| **VPN type** | BGP requires a **Route-based** VPN gateway. Policy-based gateways don't support BGP. | Azure portal > Virtual network gateway > **Configuration** |
| **ASN mismatch** | The on-premises ASN and the Azure VPN gateway ASN must be different. | Azure portal > Virtual network gateway > **Configuration** > BGP ASN |
| **Reserved ASNs** | Don't use Azure reserved ASNs (8074, 8075, 12076, 65515, 65517–65520) or IANA reserved ASNs. | See the [VPN Gateway BGP FAQ](/azure/vpn-gateway/vpn-gateway-vpn-faq#bgp) for the full list. |
| **BGP peer IP** | The on-premises BGP peer IP must not be the same as the VPN device public IP. Use a loopback or separate interface address. | Check your on-premises VPN device configuration. |
| **IPsec tunnel status** | The IPsec S2S VPN tunnel must be established before BGP can start. BGP runs over the IPsec tunnel. | Azure portal > **Connection** resource > **Status** should show **Connected** |
| **Local network gateway** | The local network gateway must have the correct BGP peer IP configured. You don't need to add a /32 host route for the on-premises BGP peer IP in the address space — Azure adds it internally. You can leave the address space empty when using BGP. | Azure portal > Local network gateway > **Configuration** |

## BGP peer not connecting

If the BGP peer status shows as **Unknown** or **Not connected**, work through the following steps.

### Step 1: Verify the IPsec tunnel is established

BGP peering sessions ride on top of the IPsec tunnel. If the IPsec tunnel isn't established, BGP can't connect.

1. In the Azure portal, navigate to your **Connection** resource and verify the status is **Connected**.
1. If the tunnel isn't connected, troubleshoot the IPsec/IKE connection first. See [Troubleshoot Azure VPN Gateway using diagnostic logs](troubleshoot-vpn-with-azure-diagnostics.md).

### Step 2: Check BGP peer status

Use the Azure portal or PowerShell to verify the BGP peer status.

**Azure portal:**

1. Navigate to your virtual network gateway.
1. Under **Monitoring**, select **BGP peers**.
1. Review the **State** column for each peer.

**PowerShell:**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayBgpPeerStatus -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name>
```

Look at the **State** field in the output. A healthy peer shows `State: Connected`.

### Step 3: Verify ASN and peer IP configuration

Confirm that the ASNs and BGP peer IPs match on both sides:

- **Azure side**: Virtual network gateway **Configuration** page shows the BGP ASN and BGP peer IP address.
- **On-premises side**: Your VPN device must be configured to peer with the Azure BGP peer IP using the correct remote ASN.

A common error is configuring the on-premises device to peer with the gateway's public IP instead of the BGP peer IP from the GatewaySubnet.

### Step 4: Check APIPA address requirements

If your on-premises VPN device uses APIPA addresses (169.254.x.x) for BGP:

- You must configure matching APIPA BGP IP addresses on the Azure VPN gateway. See [Configure BGP](/azure/vpn-gateway/bgp-howto).
- The exact range for APIPA addresses for use with VPN Gateway is 169/254.21.0 -169.254.22.255. This range can't be expanded.
- You must configure the on-premises BGP speaker to initiate connections. Although Azure VPN Gateway initiates BGP sessions regardless of whether the peer uses APIPA, the on-premises device must also be configured to initiate.
- APIPA BGP addresses must not overlap between the on-premises device and the Azure gateway.

### Step 5: Review diagnostic logs

Enable **RouteDiagnosticLog** and **IKEDiagnosticLog** in your gateway's diagnostic settings to see BGP events and IKE negotiation details.

1. Navigate to virtual network gateway > **Diagnostic settings** > **Add diagnostic setting**.
1. Enable the **RouteDiagnosticLog** category.
1. Send logs to a Log Analytics workspace.

Query BGP events:

```kusto
AzureDiagnostics
| where Category == "RouteDiagnosticLog"
| where OperationName == "BgpConnectedEvent" or OperationName == "BgpDisconnectedEvent"
| project TimeGenerated, OperationName, Message, Resource
| order by TimeGenerated desc
```

A pattern of **BgpConnectedEvent** followed quickly by **BgpDisconnectedEvent** indicates the session is being established but then dropped. Check for ASN mismatches, firewall rules blocking BGP traffic (TCP port 179), or hold timer incompatibilities.

## Routes not being learned

If the BGP session is connected but routes aren't being learned from the on-premises peer:

### Check route counts

**Azure portal:**

1. Go to virtual network gateway > **Monitoring** > **BGP peers**.
1. Review the **Routes received** column. A value of **0** indicates no routes are being learned from that peer.

**PowerShell:**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayLearnedRoute -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name>
```

Review the output. Routes with `Origin: EBgp` come from the on-premises peer. If no EBgp routes appear, the on-premises device isn't advertising routes.

### Verify on-premises device is advertising routes

Check your on-premises VPN device or router to confirm:

- BGP is enabled on the correct interface.
- The route table or network statements include the prefixes you intend to advertise.
- No outbound route filters are blocking the prefixes.

### Check prefix limit

Azure VPN Gateway supports up to **4,000 prefixes** per BGP peer. If the on-premises device advertises more than 4,000 prefixes, Azure drops the BGP session entirely. Reduce the number of advertised prefixes to stay within the limit.

Look for sudden session drops by querying the diagnostic log:

```kusto
AzureDiagnostics
| where Category == "RouteDiagnosticLog"
| where OperationName == "BgpDisconnectedEvent"
| project TimeGenerated, Message, Resource
| order by TimeGenerated desc
```

## Routes not being advertised to on-premises

If Azure routes aren't reaching your on-premises network:

### Check advertised routes

**Azure portal:**

1. Go to virtual network gateway > **Monitoring** > **BGP peers**.
1. Select the **…** for the peer and choose **View advertised routes**.
1. Verify that the expected VNet prefixes appear.

**PowerShell:**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayAdvertisedRoute -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name> -Peer <on-premises-bgp-peer-ip>
```

### Duplicate prefix restriction with gateway transit

When VNet peering with gateway transit is enabled, Azure blocks advertisement of prefixes that exactly match your virtual network address space. You can advertise a superset prefix (for example, advertise 10.0.0.0/8 instead of 10.0.0.0/16), but not the exact prefix. See the [BGP FAQ](/azure/vpn-gateway/vpn-gateway-vpn-faq#advertise-exact-prefixes) for details.

### Verify on-premises device is receiving routes

Confirm on your on-premises router that:

- The BGP session is established from the on-premises side.
- No inbound route filters are blocking Azure prefixes.
- The received routes appear in the routing table (not just the BGP table).

## BGP session flapping

If the BGP session repeatedly connects and disconnects:

### Check for hold timer expiry

Azure VPN Gateway uses the default BGP keepalive interval of 60 seconds and a hold timer of 180 seconds. If network latency or packet loss causes three consecutive keepalives to be missed, the hold timer expires and the session drops.

- BFD (Bidirectional Forwarding Detection) isn't supported on VPN Gateway for S2S connections. You can't use BFD for faster failure detection.
- VPN gateways support only fixed keepalive and hold timers. Ths values are: Keepalive: 60 seconds, Hold timer: 180 seconds.

### Check for prefix limit violations

If the on-premises device occasionally advertises more than 4,000 prefixes, the BGP session drops and then re-establishes when fewer prefixes are advertised. Monitor your on-premises route count.

### Review RouteDiagnosticLog for patterns

Query for connected and disconnected events over time to identify patterns:

```kusto
AzureDiagnostics
| where Category == "RouteDiagnosticLog"
| where OperationName == "BgpConnectedEvent" or OperationName == "BgpDisconnectedEvent"
| summarize count() by OperationName, bin(TimeGenerated, 1h)
| order by TimeGenerated desc
| render timechart
```

If disconnection events correlate with specific times of day, look for scheduled processes on your on-premises network that might affect the VPN device or link stability.

### Check IPsec tunnel stability

BGP session flapping often mirrors IPsec tunnel flapping. If the underlying tunnel is unstable, the BGP session drops along with it. Check the **TunnelDiagnosticLog** for tunnel connect/disconnect events occurring at the same times as the BGP events.

## BGP issues with active-active gateways

Active-active VPN gateways have two gateway instances, each with its own BGP peer IP address. Both instances establish independent BGP sessions.

Common issues:

- **Only one instance connecting**: Verify that the on-premises device is configured to peer with **both** BGP peer IP addresses. Each instance uses a separate IP from the GatewaySubnet.
- **Asymmetric routing**: In active-active mode, Azure may send traffic over either tunnel. If your on-premises firewall requires symmetric routing, adjust routing policies using BGP attributes (such as AS path prepending or MED) or consider active-standby mode.
- **Post-migration issues**: Changing from active-standby to active-active (or vice versa) changes the BGP IP addresses and requires updating on-premises BGP peer configurations. See [Change an active-active gateway](/azure/vpn-gateway/gateway-change-active-active).

## BGP with NAT

When using both BGP and NAT on VPN Gateway:

- Verify that the NAT rules don't conflict with BGP peer IP addresses.
- Confirm that address translation rules map correctly for the prefixes being exchanged through BGP.
- Check that the on-premises device's BGP peering address is either pre-NAT or post-NAT as expected by your NAT configuration.

For more information, see [About NAT and VPN Gateway](/azure/vpn-gateway/nat-overview).

## Diagnostic tools reference

The following table summarizes the tools available for BGP diagnostics:

| Tool | What it shows | When to use |
|------|--------------|-------------|
| **Portal > BGP peers** | Peer status, messages sent/received, routes received/advertised | Quick health check |
| **Get-AzVirtualNetworkGatewayBgpPeerStatus** | Peer state, connected duration, messages, routes received | Detailed peer-level status |
| **Get-AzVirtualNetworkGatewayLearnedRoute** | All routes learned (BGP + network + static) with AS path and origin | Verify route learning |
| **Get-AzVirtualNetworkGatewayAdvertisedRoute** | Routes being sent to a specific peer | Verify route advertisement |
| **RouteDiagnosticLog** | BgpRouteUpdate, BgpConnectedEvent, BgpDisconnectedEvent | Session establishment, route changes |
| **IKEDiagnosticLog** | IKE control messages and events | IPsec tunnel issues affecting BGP |
| **TunnelDiagnosticLog** | Tunnel state changes | Correlate tunnel drops with BGP drops |
| **BGP Peer Status metric** | Average BGP connectivity status per peer and instance | Alerting and dashboards |
| **BGP Routes Advertised metric** | Count of routes advertised per peer | Monitor route count trends |
| **BGP Routes Learned metric** | Count of routes learned per peer | Monitor route count trends |

## Set up alerts for BGP issues

You can configure Azure Monitor alerts to notify you when BGP problems occur:

1. In the Azure portal, navigate to your virtual network gateway.
1. Select **Alerts** > **Create alert rule**.
1. For BGP peer connectivity, use the **BGP Peer Status** metric with a condition of **less than 1** (connected = 1, not connected = 0).
1. For route count changes, use the **BGP Routes Learned** metric with a condition based on your expected baseline.