---
title: Azure ExpressRoute ARP tables - Troubleshooting
description: Learn how to get and use Azure ExpressRoute ARP tables to troubleshoot layer 2 connectivity issues on your circuit. Follow the steps to diagnose problems faster.
services: expressroute
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-expressroute
ms.reviewer: duau, allensu 
ms.topic: troubleshooting
ms.date: 09/08/2026
ms.custom: sap:Connectivity & Performance Issues
ai-usage: ai-assisted
---
# Get Azure ExpressRoute ARP tables in the Resource Manager deployment model

> [!div class="op_single_selector"]
> * [PowerShell - Resource Manager](expressroute-troubleshooting-arp-resource-manager.md)
> * [PowerShell - Classic](/previous-versions/azure/expressroute/expressroute-troubleshooting-arp-classic)
> 
## Summary

This article explains how to get Azure ExpressRoute Address Resolution Protocol (ARP) tables so you can validate layer 2 configuration and troubleshoot connectivity issues.

> [!IMPORTANT]
> This article is intended to help you diagnose and fix simple issues. It isn't intended to be a replacement for Microsoft support. Open a support ticket with [Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) if you're unable to solve the problem using the guidance described in this article.

The steps and examples in this article use Azure PowerShell Az modules. To install the Az modules locally on your computer, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell). To learn more about the new Az module, see [Introducing the new Azure PowerShell Az module](/powershell/azure/new-azureps-module-az). PowerShell cmdlets are updated frequently. If you're not running the latest version, the values specified in the instructions might fail. To find the installed versions of PowerShell on your system, use the `Get-Module -ListAvailable Az` cmdlet.

## ARP and ARP tables

ARP is a layer 2 protocol defined in [RFC 826](https://tools.ietf.org/html/rfc826). ARP maps the Ethernet address (MAC address) to an IP address.

The ARP table provides the following information for both the primary and secondary interfaces for each peering type:

- Mapping of on-premises router interface IP address to the MAC address
- Mapping of ExpressRoute router interface IP address to the MAC address
- Age of the mapping

ARP tables can help validate layer 2 configuration and troubleshoot basic layer 2 connectivity issues.

The following is an example ARP table.

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
 10 On-Prem           10.0.0.1   ffff.eeee.dddd
  0 Microsoft         10.0.0.2   aaaa.bbbb.cccc
```

The following section provides information on how you can view the ARP tables seen by the ExpressRoute edge routers.

## Prerequisites for learning ARP tables

Ensure that the following information is valid before going further:

- There's a valid ExpressRoute circuit configured with at least one peering. The circuit must be fully configured with the connectivity provider. You or your connectivity provider must configure at least Azure private or Microsoft peering on this circuit.
- There are valid IP address ranges used to configure the peerings. To understand how IP addresses get mapped to interfaces, review the IP address assignment examples in the [ExpressRoute routing requirements page](/azure/expressroute/expressroute-routing). To get information on the peering configuration, see the [ExpressRoute peering configuration page](/azure/expressroute/expressroute-howto-routing-arm).
- You have information from your networking team or connectivity provider about the MAC addresses of the interfaces that use these IP addresses.
- You have the latest Azure PowerShell module (version 1.50 or newer).

> [!NOTE]
> If the service provider provides layer 3 and the ARP tables are blank in the portal, refresh the circuit configuration by using the refresh button in the portal. This operation applies the right routing configuration on your circuit.

## Get the ARP tables for your ExpressRoute circuit

This section provides instructions on how you can view the ARP tables per peering by using PowerShell. You or your connectivity provider must configure the peering before you proceed. Each circuit has two paths (primary and secondary). You can check the ARP table for each path independently.

> [!NOTE]
> Depending on the hardware platform, the ARP results can vary and only display the on-premises interface.

### ARP tables for Azure private peering

The following cmdlet provides the ARP tables for Azure private peering.

```azurepowershell
# Required Variables
$RG = "<Your Resource Group Name Here>"
$Name = "<Your ExpressRoute Circuit Name Here>"

# ARP table for Azure private peering - Primary path
Get-AzExpressRouteCircuitARPTable -ResourceGroupName $RG -ExpressRouteCircuitName $Name -PeeringType AzurePrivatePeering -DevicePath Primary

# ARP table for Azure private peering - Secondary path
Get-AzExpressRouteCircuitARPTable -ResourceGroupName $RG -ExpressRouteCircuitName $Name -PeeringType AzurePrivatePeering -DevicePath Secondary 
```

Sample output for one of the paths:

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
 10 On-Prem           10.0.0.1   ffff.eeee.dddd
  0 Microsoft         10.0.0.2   aaaa.bbbb.cccc
```

### ARP tables for Microsoft peering

The following cmdlet provides the ARP tables for Microsoft peering.

```azurepowershell
# Required Variables
$RG = "<Your Resource Group Name Here>"
$Name = "<Your ExpressRoute Circuit Name Here>"

# ARP table for Microsoft peering - Primary path
Get-AzExpressRouteCircuitARPTable -ResourceGroupName $RG -ExpressRouteCircuitName $Name -PeeringType MicrosoftPeering -DevicePath Primary

# ARP table for Microsoft peering - Secondary path
Get-AzExpressRouteCircuitARPTable -ResourceGroupName $RG -ExpressRouteCircuitName $Name -PeeringType MicrosoftPeering -DevicePath Secondary 
```

The following output is an example for one of the paths.

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
 10 On-Prem           20.33.0.1   ffff.eeee.dddd
  0 Microsoft         20.33.0.2   aaaa.bbbb.cccc
```

## Use ExpressRoute ARP tables to troubleshoot connectivity

You can use the ARP table of a peering to determine and validate layer 2 configuration and connectivity. This section provides an overview of how ARP tables look under different scenarios.

### Diagnose VLAN C-Tag mismatches

For an ExpressRoute Direct circuit that uses QinQ virtual local area network (VLAN) tagging, the outer VLAN ID is the S-Tag assigned to the circuit. The inner VLAN ID is the C-Tag assigned to a peering. For more information, see [VLAN tagging for ExpressRoute Direct](/azure/expressroute/expressroute-erdirect-about#vlan-tagging).

The `Get-AzExpressRouteCircuitARPTable` output contains `Age`, `InterfaceProperty`, `IpAddress`, and `MacAddress`. It doesn't contain the C-Tag or S-Tag. Use the ARP table to check whether address resolution succeeds on each circuit path. Then, use the circuit configuration to retrieve the tag values by running the following commands in Azure PowerShell.

```azurepowershell
$circuit = Get-AzExpressRouteCircuit -ResourceGroupName $RG -Name $Name

# S-Tag (outer VLAN tag) assigned to the ExpressRoute Direct circuit
$circuit | Select-Object Name, Stag

# C-Tag (inner VLAN tag) configured for each peering
$circuit.Peerings | Select-Object PeeringType, VlanId
```

To diagnose a possible tag mismatch, follow these steps:

1. Run `Get-AzExpressRouteCircuitARPTable` for both the `Primary` and `Secondary` device paths, as shown in [Get the ARP tables for your ExpressRoute circuit](#get-the-arp-tables-for-your-expressroute-circuit).
1. Check each result for an `Incomplete` on-premises MAC address or a result that contains only the Microsoft entry.
1. For the affected peering, compare the `VlanId` value (C-Tag) and circuit `Stag` value (S-Tag) with the inner and outer VLAN IDs in your network's QinQ configuration.
1. If the values don't match, work with your networking team or connectivity provider to correct the VLAN configuration. For QinQ configuration examples, see [Router configuration samples](/azure/expressroute/expressroute-config-samples-routing#configure-interfaces-and-subinterfaces).
1. Run the primary and secondary ARP table commands again. Confirm that each reported path maps the on-premises IP address to a MAC address.

### ARP table when a circuit is in operational state (expected state)

The following list describes the expected characteristics of the ARP table when a circuit is in an operational state:

- The ARP table has an entry for the on-premises side with a valid IP address and MAC address. You can see the same information for the Microsoft side.
- The last octet of the on-premises IP address is an odd number.
- The last octet of the Microsoft IP address is an even number.
- The same MAC address appears on the Microsoft side for all three peerings (primary and secondary).

The following examples show an ARP table in an operational state.

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
 10 On-Prem           20.33.0.1   ffff.eeee.dddd
  0 Microsoft         20.33.0.2   aaaa.bbbb.cccc
```

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
 10 On-Prem           20.33.0.1   ffff.eeee.dddd
```

### ARP table when on-premises or connectivity provider side has problems

If there's a problem with the on-premises or connectivity provider, the ARP table shows one of two things: 

- The on-premises MAC address shows as incomplete.
- Only the Microsoft entry is present in the ARP table.

The following ARP table entries indicate a problem with the on-premises or connectivity provider side.

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------   
  0 On-Prem           20.33.0.1   Incomplete
  0 Microsoft         20.33.0.2   aaaa.bbbb.cccc
```

```output
Age InterfaceProperty IpAddress  MacAddress    
--- ----------------- ---------  ----------    
  0 Microsoft         20.33.0.2   aaaa.bbbb.cccc
```

> [!NOTE]
> Open a support request with your connectivity provider for debugging any issues.
> If the ARP table doesn't have IP addresses of the interfaces mapped to MAC addresses, review the following information:
> 
> - Ensure the first IP address of the /30 subnet assigned for the link between the Microsoft Enterprise Edge (MSEE)-PR and MSEE is used on the interface of MSEE-PR. Azure always uses the second IP address for MSEEs.
> - Verify if the customer (C-Tag) and service (S-Tag) VLAN tags match both on MSEE-PR and MSEE pair.

### ARP table when Microsoft side has problems

The following ARP table entries indicate a problem with the Microsoft side:

- The ARP table for a peering doesn't appear.

Open a support ticket with [Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade). Specify that you have an issue with layer 2 connectivity.

## Next steps

- Validate Layer 3 configurations for your ExpressRoute circuit.
  - Get the route summary to check the state of BGP sessions.
  - Get the route table to see which prefixes are advertised across ExpressRoute.
- Validate data transfer by reviewing bytes in and out.
- Open a support ticket with [Microsoft support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) if you're still experiencing issues.