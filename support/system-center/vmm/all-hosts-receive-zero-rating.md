---
title: No available connection to selected VM Network can be found
description: Fixes an issue in which all hosts receive a zero rating when you place a virtual machine on a Hyper-V cluster in Virtual Machine Manager.
ms.date: 09/11/2020
ms.reviewer: msadoff
---
# All hosts receive a zero rating when you place a virtual machine on a Hyper-V cluster in VMM

This article helps you fix an issue in which all hosts receive a zero rating when you place a virtual machine on a Hyper-V cluster in Virtual Machine Manager (VMM) and you receive the **No available connection to selected VM Network can be found** error message.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2865716

## Symptoms

Consider the following scenario:

- You use System Center 2012 Virtual Machine Manager Service Pack 1 and have a logical network that uses VLAN isolation.
- You have a second logical network that doesn't use isolation or network virtualization and doesn't have VLANs defined.
- You have a Windows Server 2012 Hyper-V cluster where each node in the Hyper-V cluster has multiple network adapters.
- The Hyper-V hosts have virtual switches attached to each of the two logical networks.
- You try to create or migrate a virtual machine that is dual-homed and has network adapters attached to each of the two virtual switches.
- The existing or proposed virtual machine has a static MAC address on the network where no VLANs are defined.

In this scenario, all hosts receive a zero rating when you try to place the virtual machine on a node in the Hyper-V cluster. On the **Rating Explanation** tab, the following message is displayed:

> No available connection to selected VM Network can be found

This may occur in the **Migrate Virtual Machine Wizard** or in the **Create Virtual Machine Wizard**. As a result, you are unable to proceed with placing the virtual machine.

## Cause

This is a known issue in System Center 2012 Virtual Machine Manager.

## Workaround

To work around this issue, add a single VLAN to the logical network that doesn't use isolation. Use the following steps to do this:

1. In the VMM admin console, select the **Fabric** tab and open the properties of the logical network that doesn't use isolation.
2. Select the **Network Site** tab.
3. Select **Add**.
4. Select one or more host groups for the network site.
5. Select **Insert row** to add a VLAN.
6. Enter **0** for the VLAN ID.
7. For the IP subnet, enter the IP subnet that the network uses.
8. Click **OK**.
