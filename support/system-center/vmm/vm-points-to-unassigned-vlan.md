---
title: A new VM points to an unassigned VLAN
description: Fix an issue where Virtual Machine Manager selects a tagged VLAN when creating a new virtual machine
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# System Center 2012 Virtual Machine Manager selects a tagged VLAN when creating a new virtual machine

This article helps you fix an issue where Virtual Machine Manager selects a tagged VLAN when creating a new virtual machine.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2680267

## Symptoms

You have a logical network that has two VLANs defined: One is VLAN 0 and the other is VLAN X.

You create a virtual machine using System Center 2012 Virtual Machine Manager and assign it to VLAN 0. When you view the properties of the virtual machine, you notice that it points to VLAN X.

## Cause

This behavior is expected for new virtual machine placements. Unless you manually specify the VLAN to use by using the `set-scvirtualnetworkadapter` command, placement will pick what it considers the best VLAN to use.

## Resolution

If the VLANs are not for the same use, you may want to create two different logical networks, one for each VLAN. By doing this, once the logical network is assigned, it will select the only VLAN listed for that logical network.

When deploying the virtual machine from a template when you choose static IP address from the pool, the process will automatically select the VLAN based on the pool selected. This helps control the VLAN for the virtual machine.

If you create a virtual machine and use DHCP, the recommendation is to create a separate logical network for each VLAN. This way the same VLAN is assigned every time.
