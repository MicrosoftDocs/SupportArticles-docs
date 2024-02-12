---
title: VM can't reach network configured by vLan tagging
description: Resolves an issue where virtual machines can't reach the network that's configured by using vLan tagging.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Hyper-V virtual machines cannot reach the network when the vLan tagging is enabled on a Windows Server 2008-based computer

This article provides a solution to an issue where virtual machines can't reach the network that's configured by using vLan tagging.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2739081

## Symptoms

Consider the following scenario:

- You are running a Windows Server 2008-based computer.
- You configure virtual networks by using vLan tagging for Hyper-V virtual machines.
- You bind the virtual networks to Intel network adapters.

In this scenario, the virtual machines cannot reach the network. Additionally, these virtual machines are inaccessible from the network.

## Cause

The Hyper-V Virtual Switch driver is responsible for routing vLan traffic for the Parent Partition connection and for each virtual machine. Intel network adapters have a vLan Filtering feature that interferes with this process.

## Resolution

To resolve this problem, follow these steps:

1. Click **Start**, type *regedit* in the Start Search box, and then press ENTER.
2. Locate the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325 -11CE-BFC1-08002BE10318}`  
    Under this subkey, there is a sequence of subkeys. For example, you will see "0000, 0001."
3. Select the subkey that matches the Intel network adapter to which the virtual networks are bound. You can determine this by matching the "Driver Desc" value to the name of the physical network adapter.
4. Double-click the **VlanFiltering** registry entry.
5. In the Value data box, type *0*, and then click **OK**.
6. On the **File** menu, click **Exit**.
7. Restart the computer.

> [!NOTE]
> If the associated Intel Network adapter is reinstalled, the VLanFiltering value gets reset to the default value of 0x1. Since Service Pack 2 for Windows Server 2008 reruns Plug and Play during installation, the Network driver is subsequently reinstalled causing the VLanFiltering value to be reset to 0x1. This causes the VMs configured with VLAN Tags to fail to communicate on the configured VLAN.

## More information

The Hyper-V role of Windows Server 2008 can specify a vLan tag for the virtual machine network connection and for the parent partition network connection. To enable vLan tagging for a parent partition, click to select the Enable virtual LAN identification check box to enable vLan tagging and to specify an ID. (You specify an ID under Virtual Network Properties on the Virtual Network Manager page in the Hyper-V Manager.)
To enable vLan tagging for a virtual machine, access the properties of the virtual machine, and then select the virtual network adapter. Click to select the Enable virtual LAN identification check box to enable vLan tagging and to specify an ID that you want the virtual machine connection to use. A virtual machine may have multiple network adapters, and all these adapters may use either the same or different vLan IDs. Therefore, you must perform this action on each network adapter.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
