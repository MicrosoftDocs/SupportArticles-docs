---
title: Troubleshoot BGP issues for Azure VPN Gateway
titleSuffix: Azure VPN Gateway
description: Troubleshoot BGP issues in Azure VPN Gateway by resolving peer connectivity, route learning, and session stability to restore routing.
author: cherylmc
ms.service: azure-vpn-gateway
ms.topic: troubleshooting
ms.date: 03/23/2026
ms.author: cherylmc
ms.custom: sap:Configuration and Setup
# Customer intent: As a network administrator, I want to troubleshoot BGP issues that affect my Azure VPN Gateway so that I can restore dynamic routing between my on-premises networks and Azure.
---

# Troubleshoot BGP issues for Azure VPN Gateway

## Summary

This article helps you troubleshoot BGP issues that affect Azure VPN Gateway so you can restore dynamic routing between your on-premises networks and Azure. For an overview of BGP support, see [About BGP and VPN Gateway](/azure/vpn-gateway/vpn-gateway-bgp-overview).

## Prerequisites

Before you troubleshoot specific symptoms, verify that the following prerequisites are met. Many BGP issues stem from configuration mismatches.

| Check | Requirement | How to verify |
|-------|-------------|---------------|
| **Gateway SKU** | BGP isn't supported on the Basic SKU. Use any other SKU. | Azure portal > Virtual network gateway > **Overview** |
| **VPN type** | BGP requires a **Route-based** VPN gateway. Policy-based gateways don't support BGP. | Azure portal > Virtual network gateway > **Configuration** |
| **ASN mismatch** | The on-premises Autonomous System Number (ASN) and the Azure VPN gateway ASN must be different. | Azure portal > Virtual network gateway > **Configuration** > BGP ASN |
| **Reserved ASNs** | Don't use Azure-reserved ASNs (8074, 8075, 12076, 65515, 65517–65520) or Internet Assigned Numbers Authority (IANA)-reserved ASNs. | For more information, see [VPN Gateway BGP FAQ](/azure/vpn-gateway/vpn-gateway-vpn-faq#bgp). |
| **BGP peer IP** | The on-premises BGP peer IP can't be the same as the VPN device public IP. Use a loopback or separate interface address. | Check your on-premises VPN device configuration. |
| **IPsec tunnel status** | The Internet Protocol Security (IPsec) site-to-site (S2S) VPN tunnel must be established before BGP can start. BGP runs over the IPsec tunnel. | Azure portal > **Connection** resource > **Status** should show **Connected** |
| **Local network gateway** | The local network gateway must have the correct BGP peer IP configured. You don't have to add a `/32` host route for the on-premises BGP peer IP in the address space. Azure adds it internally. When you use BGP, you can leave the address space empty. | Azure portal > Local network gateway > **Configuration** |

## BGP peer not connecting

If the BGP peer status shows as **Unknown** or **Not connected**, follow these steps.

### Step 1: Verify the IPsec tunnel is established

BGP peering sessions run on top of the IPsec tunnel. If the IPsec tunnel isn't established, BGP can't connect.

1. In the Azure portal, go to your **Connection** resource, and verify the status is **Connected**.
1. If the tunnel isn't connected, troubleshoot the IPsec and Internet Key Exchange (IKE) connection first. For more information, see [Troubleshoot Azure VPN Gateway using diagnostic logs](troubleshoot-vpn-with-azure-diagnostics.md).

### Step 2: Check BGP peer status

Use the Azure portal or Azure PowerShell to verify the BGP peer status.

**Azure portal**

1. Go to your virtual network gateway.
1. Under **Monitoring**, select **BGP peers**.
1. Review the **State** column for each peer.

**Azure PowerShell**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayBgpPeerStatus -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name>
```

Examine the **State** field in the output. A healthy peer shows `State: Connected`.

### Step 3: Verify ASN and peer IP configuration

Verify that the ASNs and BGP peer IPs match on both sides:

- **Azure side**: The virtual network gateway **Configuration** page shows the BGP ASN and BGP peer IP address.
- **On-premises side**: You must configure your VPN device to peer with the Azure BGP peer IP by using the correct remote ASN.

A common error is configuring the on-premises device to peer with the gateway's public IP instead of the BGP peer IP from the GatewaySubnet.

### Step 4: Check APIPA address requirements

If your on-premises VPN device uses Automatic Private IP Addressing (APIPA) addresses (169.254._x_._x_) for BGP:

- You must configure matching APIPA BGP IP addresses on the Azure VPN gateway. For more information, see [Configure BGP](/azure/vpn-gateway/bgp-howto).
- The exact range for APIPA addresses for use together with VPN Gateway is 169/254.21.0 -169.254.22.255. You can't expand this range.
- You must configure the on-premises BGP speaker to initiate connections. Although VPN Gateway initiates BGP sessions regardless of whether the peer uses APIPA, you must configure the on-premises device to initiate.
- APIPA BGP addresses must not overlap between the on-premises device and the Azure gateway.

### Step 5: Review diagnostic logs

Enable **RouteDiagnosticLog** and **IKEDiagnosticLog** in your gateway's diagnostic settings to see BGP events and IKE negotiation details.

1. Go to virtual network gateway > **Diagnostic settings** > **Add diagnostic setting**.
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

A pattern of **BgpConnectedEvent** followed quickly by **BgpDisconnectedEvent** indicates that the session is being established but is then dropped. Check for ASN mismatches, firewall rules that block BGP traffic (TCP port 179), or hold timer incompatibilities.

## Routes not being learned

If the BGP session is connected but routes aren't being learned from the on-premises peer, make the following checks.

### Check route counts

**Azure portal**

1. Go to virtual network gateway > **Monitoring** > **BGP peers**.
1. Review the **Routes received** column. A value of **0** indicates that no routes are being learned from that peer.

**Azure PowerShell**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayLearnedRoute -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name>
```

Review the output. Routes that show `Origin: EBgp` come from the on-premises peer. If no external BGP (eBGP) routes appear, the on-premises device isn't advertising routes.

### Verify on-premises device is advertising routes

Check your on-premises VPN device or router to verify that it meets the following conditions:

- BGP is enabled on the correct interface.
- The route table or network statements include the prefixes you intend to advertise.
- No outbound route filters block the prefixes.

### Check prefix limit

VPN Gateway supports up to 4,000 prefixes per BGP peer. If the on-premises device advertises more than 4,000 prefixes, Azure drops the BGP session entirely. Reduce the number of advertised prefixes to stay within the limit.

Look for sudden session drops by querying the diagnostic log:

```kusto
AzureDiagnostics
| where Category == "RouteDiagnosticLog"
| where OperationName == "BgpDisconnectedEvent"
| project TimeGenerated, Message, Resource
| order by TimeGenerated desc
```

## Routes not advertised to on-premises

If Azure routes aren't reaching your on-premises network, make the following checks.

### Check advertised routes

**Azure portal**

1. Go to virtual network gateway > **Monitoring** > **BGP peers**.
1. Select the **…** for the peer and choose **View advertised routes**.
1. Verify that the expected VNet prefixes appear.

**Azure PowerShell**

```azurepowershell-interactive
Get-AzVirtualNetworkGatewayAdvertisedRoute -ResourceGroupName <resource-group> -VirtualNetworkGatewayName <gateway-name> -Peer <on-premises-bgp-peer-ip>
```

### Duplicate prefix restriction with gateway transit

When you enable VNet peering with gateway transit, Azure blocks advertisement of prefixes that exactly match your virtual network address space. You can advertise a superset prefix (for example, advertise 10.0.0.0/8 instead of 10.0.0.0/16), but not the exact prefix. For more information, see the [BGP FAQ](/azure/vpn-gateway/vpn-gateway-vpn-faq#advertise-exact-prefixes).

### Verify on-premises device is receiving routes

Verify the following conditions on your on-premises router:

- The BGP session is established from the on-premises side.
- No inbound route filters are blocking Azure prefixes.
- The received routes appear in the routing table (not only the BGP table).

## BGP session flapping

If the BGP session repeatedly connects and disconnects, make the following checks.

### Check for hold timer expiry

VPN Gateway uses the default BGP keep-alive interval of 60 seconds and a hold timer of 180 seconds. If network latency or packet loss causes three consecutive keep-alive intervals to be missed, the hold timer expires and the session drops.

- Bidirectional Forwarding Detection (BFD) isn't supported on VPN Gateway for S2S connections. You can't use BFD for faster failure detection.
- VPN gateways support only fixed keep-alive and hold timers. These values are: **Keepalive: 60 seconds** and **Hold timer: 180 seconds**.

### Check for prefix limit violations

If the on-premises device occasionally advertises more than 4,000 prefixes, the BGP session drops and is then re-established when fewer prefixes are advertised. Monitor your on-premises route count.

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

BGP session flapping often mirrors IPsec tunnel flapping. If the underlying tunnel is unstable, the BGP session drops together with it. Check the `TunnelDiagnosticLog` for tunnel connect and disconnect events that occur at the same times as the BGP events.

## BGP issues in active-active gateways

Active-active VPN gateways have two gateway instances. Each instance has its own BGP peer IP address. Both instances establish independent BGP sessions.

Common issues:

- **Only one instance connecting**: Verify that the on-premises device is configured to peer with both BGP peer IP addresses. Each instance uses a separate IP address from the gateway subnet.
- **Asymmetric routing**: In active-active mode, Azure might send traffic over either tunnel. If your on-premises firewall requires symmetric routing, adjust routing policies by using BGP attributes such as Autonomous System (AS) path prepending or Multi-Exit Discriminator (MED). Or, consider active-standby mode.
- **Post-migration issues**: Changing from active-standby to active-active (or vice versa) changes the BGP IP addresses and requires updating on-premises BGP peer configurations. For more information, see [Change an active-active gateway](/azure/vpn-gateway/gateway-change-active-active).

## BGP plus NAT

If you use both BGP and Network Address Translation (NAT) on VPN Gateway:

- Verify that the NAT rules don't conflict with BGP peer IP addresses.
- Verify that address translation rules correctly map the prefixes that you exchange through BGP.
- Check that the on-premises device's BGP peering address is either pre-NAT or post-NAT, as expected by your NAT configuration.

For more information, see [About NAT and VPN Gateway](/azure/vpn-gateway/nat-overview).

## Diagnostic tools reference

The following table summarizes the tools that are available for BGP diagnostics.

| Tool | What it shows | When to use it |
|------|--------------|-------------|
| **Portal > BGP peers** | Peer status, messages sent and received, routes received and advertised | Quick health check |
| **Get-AzVirtualNetworkGatewayBgpPeerStatus** | Peer state, connected duration, messages, routes received | Detailed peer-level status |
| **Get-AzVirtualNetworkGatewayLearnedRoute** | All routes that are learned (BGP plus network plus static) with AS path and origin | Verify route learning |
| **Get-AzVirtualNetworkGatewayAdvertisedRoute** | Routes sent to a specific peer | Verify route advertisement |
| **RouteDiagnosticLog** | BgpRouteUpdate, BgpConnectedEvent, BgpDisconnectedEvent | Session establishment, route changes |
| **IKEDiagnosticLog** | IKE control messages and events | IPsec tunnel issues that affect BGP |
| **TunnelDiagnosticLog** | Tunnel state changes | Correlate tunnel drops with BGP drops |
| **BGP Peer Status metric** | Average BGP connectivity status per peer and instance | Alerting and dashboards |
| **BGP Routes Advertised metric** | Count of routes that are advertised per peer | Monitor route count trends |
| **BGP Routes Learned metric** | Count of routes that are learned per peer | Monitor route count trends |

## Set up alerts for BGP issues

You can configure Azure Monitor alerts to notify you when BGP issues occur:

1. In the Azure portal, go to your virtual network gateway.
1. Select **Alerts** > **Create alert rule**.
1. For BGP peer connectivity, use the **BGP Peer Status** metric that has a condition of **less than 1** (connected = 1, not connected = 0).
1. For route count changes, use the **BGP Routes Learned** metric that has a condition that's based on your expected baseline.
