---
title: Increase the number of IP addresses on a subnet
description: Describes three methods you can use to change the number of IP hosts on any given subnet.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, drewba
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
---
# Increase the number of IP addresses on a subnet in a DHCP server

This article describes methods to change the number of IP hosts on a subnet in a Dynamic Host Configuration Protocol (DHCP) server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 255999

## Symptoms

You try to extend your scope in a DHCP server. When you change the scope in the **Scope Properties** dialog box, you receive the following error:

> The IP range has been changed, but not yet saved. Continuing will discard the changes. Proceed?

Selecting either **Yes** or **No** to this message causes no change to the existing scope.

## Resolution

This article describes methods that you can use to change the number of IP hosts on any particular subnet. The following three methods are covered:

- Scope extension
- Resubnetting
- Superscoping

### Scope extension

Assume that you already have a DHCP scope. The Start Address and End Address don't currently include all addresses for your given subnet. In this case, to increase the number of addresses in the scope, you can extend the Start Address or End Address in the scope properties.

The following example shows a Class C network with the following settings:

Subnet Address: 192.168.1.0  
Subnet Mask: 255.255.255.0

This example yields a network of 254 hosts that occupy the range of addresses from 192.168.1.1 to 192.168.1.254.

The scope you created has the following properties:

Start Address: 192.168.1.50  
End Address: 192.168.1.150  
Subnet Mask: 255.255.255.0

To increase the number of addresses available to clients, you can change either the Start Address or End Address as far as 1 and 254, respectively.

> [!NOTE]
> In earlier versions of DHCP, you had to extend the Start Address or End Address in increments of 32. It's no longer the case if you're running Windows NT 4.0 Service Pack 6 or later.

If your scope already covers the entire range and is fully used, you only have two other options: superscoping or resubnetting. Both of these options require you to make architectural changes to your network.

Simply changing the DHCP scope parameters doesn't give you more leases. DHCP runs on top of your network subnet architecture and can hand out addresses however you want. Primarily, always treat the need to expand address ranges as a subnet architecture exercise. After you decide which architecture to use, you can configure DHCP to conform to your network design.

### Resubnetting

Resubnetting is the recommended procedure for increasing a DHCP scope when the current scope has entirely consumed the current subnet mask. This method requires you to change all subnet hosts and gateways. If you have an address range that has run out of available host addresses, you possibly can change the subnet mask to include a larger share of host addresses. However, simply changing the subnet mask requires:

- All routers and other statically assigned computers be reconfigured.
- All DHCP clients have renewed their lease obtaining the new parameters.

Additionally, the entire DHCP scope or scopes must first be deleted and then re-created using the new subnet mask. If you don't take steps to prevent leasing addresses that other clients may use, duplicate addresses may occur during this period. Despite all of the aforementioned caveats, resubnetting is still the recommended procedure. The resubnetting configuration creates no extra overhead on the subnet routers or gateways, and keeps all hosts on the same broadcast address.

The following example shows a depleted subnet with the following settings:

Subnet Address: 192.168.1.0  
Subnet Mask: 255.255.255.0

It yields a network of 254 hosts with addresses from 192.168.1.1 to 1921.68.1.254.

The following example shows the result if you use the resubnetting option:

Subnet Address: 192.168.1.0  
Subnet Mask: 255.255.254.0

You now have a network of 510 hosts with addresses from 192.168.0.1 to 192.168.1.254 (for scope 192.168.0.0), or 256 newly available DHCP addresses.

Before:  
---------192.168.1.0/24-------R-------192.168.5.0/24---------

After:  
---------192.168.0.0/23-------R-------192.168.5.0/24---------

### Superscoping

Superscoping (also referred to as multinetting) may meet your requirements. If you don't want to change the subnetting of an existing network, you can add more logical networks to the same physical wire. This method puts more burden on the router or gateway that's configured with multiple logical subnets running on a single physical port. The extra burden may cause reduced network performance. Hosts on one logical subnet must be routed through the gateway to communicate with hosts on the other logical subnet, despite sharing the same physical wire.

The following example shows a depleted subnet with the following settings:

Subnet Address: 192.168.1.0  
Subnet Mask: 255.255.255.0

The following example shows the results if you use the superscoping option:

Subnet Address: 192.168.1.0 and 192.168.2.0  
Subnet Mask: 255.255.255.0

You now have two networks of 254 hosts (508 hosts total) with addresses from 192.168.1.1 to 192.168.1.254 and 192.168.2.1 to 192.168.2.254, or 254 newly available DHCP addresses.

Before:  
-----192.168.1.0/24------R-----192.168.5.0/24--------

After:  
-----192.168.1.0/24 and 192.168.2.0/24-----R-----192.168.5.0/24------

After you decide which option you want to use, you can choose the corresponding DHCP configuration.

If you use the resubnetting option, you need to delete and re-create the DHCP scope with the new subnet mask. It's not possible to change only the mask for a particular scope.

If you're servicing existing clients within a portion of this range, you should turn on conflict detection until all your clients are migrated into the new scope. This action requires you to take the following steps:

1. Configure the interface of each connected router and change the IP address for the connected interface, its subnet address, and its subnet mask.
2. Delete your current DHCP scope.
3. Create a new DHCP scope with the new subnet mask.
4. Enable the Conflict Retries option on the DHCP server (set to 1 or 2).
5. Force your DHCP clients to renew their DHCP leases.
6. Change the IP address, subnet mask, and/or default gateway on each statically configured host.

When you use the superscoping option, you need to superscope many scopes together. Create each scope individually and then create a superscope to incorporate the individual scopes. This action requires you to take the following steps:

1. Add secondary IP addresses to the current router interfaces.
2. Create a new DHCP scope for the new logical subnet.
3. Create a superscope and add the old and new DHCP scopes as children.
