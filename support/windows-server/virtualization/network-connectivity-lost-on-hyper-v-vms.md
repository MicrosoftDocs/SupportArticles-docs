---
title: Network connectivity is lost on Hyper-V VMs if VMQ is enabled
description: Resolves an issue where network connections on Guest VM that use VLAN are lost if Virtual Machine Queue (VMQ) is enabled on the HOST network and disabled on virtual networks.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:virtual-switch-manager-vmswitch, csstroubleshoot
ms.technology: hyper-v
---
# Network connectivity is lost on Hyper-V VMs if VMQ feature is enabled on HOST network cards

This article provides a solution to an issue where network connections on Guest VM that use VLAN are lost if Virtual Machine Queue (VMQ) is enabled on the HOST network and disabled on virtual networks.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2681638

## Symptoms

Consider the scenario:

- A server running Windows Server 2008 R2 Service Pack 1 with Hyper-V installed or Microsoft Hyper-V Server 2008 R2.
- Live migration of VMs would result in drop of network connections on Guest VM that use VLAN. Network is restored when migration is complete.
- Issue occurs only if Virtual Machine Queue (VMQ) is enabled on the HOST network and disabled on virtual networks.

> [!NOTE]
> If we disable VMQ on Host network, Live migration of Guest VMs is successful without Network drop.

## Cause

NICs are introduced with new feature "VMQ- Virtual Machine Queues". Earlier Hyper-V used to create the queue and segregate the traffic between the VMs, however with VMQ enabled, this option is offloaded to NICs. Creating and sorting of queues are done by the NICs.

Just enabling VMQ on NIC is not sufficient. VMQ does require some registry for VMSMP to understand the VMQ feature and support it.

## Resolution

> [!CAUTION]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.

To resolve this particular issue, follow below steps to add registry subkeys on the host server.

1. To open an elevated Command Prompt window, click **Start**, point to **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.
2. Type *regedit*, and then press ENTER.
3. In the Registry Editor, open the subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318` and locate the subkey for the network adapter you want to work with. Subkeys are four numbers (for example 0003 and 0010). Make a note of it. You will need it later in this procedure.
4. Return to the elevated command prompt window.
5. At the command prompt, type the following commands based on the type of network adapter you are using. For each command, substitute the subkey from earlier in this procedure for ID.

    1. For 1 GBPS network adapters, type `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318\ID /v *MaxRssProcessors /t REG_DWORD /d 1 /f` and press ENTER. Then, type `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318\ID /v *RssBaseProcNumber /t REG_DWORD /d 0 /f` and press ENTER.

    2. For 10 GBPS network adapters, type `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318\ID /v *MaxRssProcessors /t REG_DWORD /d 3 /f` and press ENTER. Then type `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318\ID /v *RssBaseProcNumber /t REG_DWORD /d 0 /f` and press ENTER.

    3. Reboot the Host server for registry changes to take effect.

    > [!IMPORTANT]
    > If you are configuring more than one network adapter, each adapter should have a different value assigned to the *RssBaseProcNumber sub-key with sufficient difference so that there are no overlapping RSS processors.  
    > For example, if Network Adapter A has a value of 0 assigned to \*RssBaseProcNumber and a value of 3 assigned to \*MaxRssProcessors, Network Adapter B should have an \*RssBaseProcNumber of 4.

## More information

VMQ is a new feature and is used with Hyper-V Clusters. Below is the complete checklist for VMQ.

1. Virtual Machine Queue (VMQ) will only work on Windows 7 and Windows Server 2008 R2 Guests.

2. If you have enabled Virtual Machine Queue (VMQ), Virtual Machine Chimney (VMC) will not work. You have to keep VMC disabled.

3. Verify Synthetic NICs are configured for VMs.

Refer following articles for more details:

- [Checklist: Deploying Virtual Machine Queue](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/gg162680(v=ws.10))
- [Checklist: Deploying Virtual Machine Chimney](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/gg162685(v=ws.10))
- [Enabling Virtual Machine Queue on the Management Operating System](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/gg162696(v=ws.10))
- [FAQs: VMDq, VLANs, and Teaming on Intel® Ethernet Adapters in Hyper-V](https://www.intel.com/content/www/us/en/support.html) 
