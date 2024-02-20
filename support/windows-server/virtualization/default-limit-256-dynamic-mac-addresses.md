---
title: Windows Hyper-V server has a default limit of 256 dynamic MAC addresses
description: Provides a solution to an issue that occurs when you start a guest virtual machine.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-switch-manager-vmswitch, csstroubleshoot
---
# Windows Hyper-V server has a default limit of 256 dynamic MAC addresses

This article provides a solution to an issue that occurs when you start a guest virtual machine.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2804678

## Symptoms

Consider the following scenario:

You have a Windows Server 2012 computer that is configured with the Hyper-V role. The Hyper-V server is configured to provide Dynamic MAC addresses to the guest machines.

When you start a guest virtual machine, you may encounter the following error message:

> The application encountered an error while attempting to change the state of '\<Virtual machine name>'

> Synthetic Ethernet Port (Instance ID CCE417C5-BDD9-4216-85CA-248620EE75C6): Failed to power on with Error 'Attempt to access invalid address'.

On a Windows Server 2008 or Windows Server 2008 R2 Hyper-V host, an Event ID 12565 from source "Microsoft-Windows-Hyper-V-Worker" is logged, as described in the [Event ID 12565 — NIC Configuration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd582068(v=ws.10)).

## Cause

This problem occurs because the default number of dynamic MAC addresses for virtual machines (256) has been exceeded.

Hyper-V generates the MAC address as described below (mapping MAC address to aa-bb-cc-dd-ee-ff):

- The first three octets (aa-bb-cc) are Microsoft's IEEE organizationally Unique Identifier, 00:15:5D (which is common on all Hyper-V hosts.
- The next two octets (dd-ee) are derived from the last two octets of the server's IP address.
- The last octet (ff) is automatically generated from the range 0x0-0xFF.

Because the last octet is an 8-bit value, there is a default limit of 256 possible MAC addresses.

## Resolution

Apply one of the following solutions:

- Turn off the virtual machine, allocate a static MAC Address that does not belong to Hyper-V's dynamic MAC address range, then restart the virtual machine.

- Increase the range of MAC addresses by using one of the following methods, by modifying the fifth and/or the sixth octet of the default dynamic MAC address range:

If the host is Windows Server 2008, you can modify the dynamic MAC address range via the following registry values:

- `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Virtualization\MinimumMacAddress`
- `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Virtualization\MaximumMacAddress`

> [!NOTE]
> Knowledge of the hexadecimal numbering system is helpful to modify the octets. Each octet's range is 00 - FF.

## More information

Refer to the following blog posts for additional reading on this subject:

- [Hyper-V R2: MAC Address Management](/archive/blogs/virtual_pc_guy/hyper-v-r2-mac-address-management)

- [Managing MAC Address Pools in Hyper-V R2](/archive/blogs/roblarson/managing-mac-address-pools-in-hyper-v-r2)
