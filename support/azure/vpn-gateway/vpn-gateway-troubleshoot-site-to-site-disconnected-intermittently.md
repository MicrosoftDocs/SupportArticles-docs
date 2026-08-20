---
title: Troubleshoot Azure Site-to-Site VPN disconnections
description: Identify and fix Azure Site-to-Site VPN disconnections caused by device, route, security association, or PFS settings. Follow the steps to restore connectivity.
titleSuffix: Azure VPN Gateway
author: kaushika-msft
ms.author: kaushika
ms.service: azure-vpn-gateway
ms.reviewer: duau, allensu 
ms.topic: troubleshooting
ms.date: 08/19/2026
ms.custom: sap:Connectivity

# Customer intent: As a network administrator, I want to troubleshoot Azure Site-to-Site VPN connection issues, so that I can ensure stable connectivity and minimize disruptions for users.
---

# Troubleshoot Azure Site-to-Site VPN disconnections

## Summary

Azure Site-to-Site VPN disconnections can disrupt connectivity for new or existing connections. This article helps you identify common configuration causes and restore a stable VPN connection.

## Troubleshooting steps

### Prerequisites

Check the type of Azure virtual network gateway:

1. Go to [Azure portal](https://portal.azure.com).
1. Check the **Overview** page of the virtual network gateway to verify the **Type**. For example: **Route-based**.

### Step 1: Check whether the on-premises VPN device is validated

1. Check whether you are using a [validated VPN device and operating system version](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#devicetablee). If the VPN device is not validated, you may have to contact the device manufacturer to see if there is any compatibility issue.
1. Make sure that the VPN device is correctly configured. For more information, see [Editing device configuration samples](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#editing).

### Step 2: Check the Security Association settings (for policy-based Azure virtual network gateways)

1. Make sure that the virtual network, subnets and, ranges in the **Local network gateway** definition in Microsoft Azure are same as the configuration on the on-premises VPN device.
1. Verify that the Security Association settings match.

### Step 3: Check for user-defined routes or network security groups on gateway subnet

A user-defined route on the gateway subnet might restrict some traffic while allowing other traffic. This condition makes the VPN connection seem unreliable for some traffic but good for other traffic. 

### Step 4: Check the **one VPN tunnel per subnet pair** setting (for policy-based virtual network gateways)

Ensure that the on-premises VPN device is set to use **one VPN tunnel per subnet pair** for policy-based virtual network gateways.

### Step 5: Check for security association limitations

The virtual network gateway has a limit of 200 subnet Security Association pairs. If the number of Azure virtual network subnets multiplied by the number of local subnets exceeds 200, you might see sporadic subnet disconnections.

### Step 6: Check the on-premises VPN device external interface address

If you include the internet-facing IP address of the VPN device in the **Local network gateway address space** definition in Azure, you might experience sporadic disconnections.

### Step 7: Check whether the on-premises VPN device has Perfect Forward Secrecy enabled

The PFS group is the Diffie-Hellman group used for IPsec Quick Mode (Phase 2). When you use a custom IPsec/IKE policy, the on-premises VPN device configuration must match or contain the PFS group configured on the Azure connection.

1. Check the PFS group configured on the Azure connection.

   **Azure CLI**

   ```azurecli
   az network vpn-connection ipsec-policy list --resource-group "<resource-group>" --connection-name "<connection-name>" --query "[].pfsGroup" --output tsv
   ```

   **Azure PowerShell**

   ```azurepowershell
   $connection = Get-AzVirtualNetworkGatewayConnection -ResourceGroupName "<resource-group>" -Name "<connection-name>"
   $connection.IpsecPolicies | Select-Object PfsGroup
   ```

1. Check the PFS or Phase 2 Diffie-Hellman group configured on the on-premises VPN device. Use the device vendor's documentation for the exact command or interface.
1. If the settings differ, update one peer so the PFS groups match. An Azure custom policy must specify all IKE and IPsec algorithms and parameters, so use [the Azure portal procedure](/azure/vpn-gateway/ipsec-ike-policy-howto#step-3-configure-a-custom-ipsecike-policy-on-the-s2s-vpn-connection) or [the Azure PowerShell procedure](/azure/vpn-gateway/vpn-gateway-ipsecikepolicy-rm-powershell#managepolicy) to apply the complete policy. If PFS is disabled on the peer, select `None` for the Azure PFS group; otherwise, select the corresponding supported group. Updating a custom policy can briefly restart the tunnel, so plan the change for a maintenance window or other low-traffic period.
1. To correlate a disconnect with configuration activity, review **TunnelDiagnosticLog** for tunnel state changes and **GatewayDiagnosticLog** for configuration events. Compare the **TimeGenerated** values, which are in UTC, around the same time. For setup and query examples, see [Troubleshoot Azure VPN Gateway using diagnostic logs](/troubleshoot/azure/vpn-gateway/troubleshoot-vpn-with-azure-diagnostics).
1. After both peers use matching settings, verify the connection state:

   ```azurecli
   az network vpn-connection show --resource-group "<resource-group>" --name "<connection-name>" --query connectionStatus --output tsv
   ```

## Next steps

- [Configure a Site-to-Site connection to a virtual network](/azure/vpn-gateway/tutorial-site-to-site-portal)
- [Configure IPsec/IKE policy for Site-to-Site VPN connections](/azure/vpn-gateway/vpn-gateway-ipsecikepolicy-rm-powershell)
