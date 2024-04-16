---
title: HAL_INITIALIZATION_FAILED error on VMware VM
description: Provides a solution to fix a HAL_INITIALIZATION_FAILED error that occurs when you install Windows 8 or Microsoft Windows Server 2012 on VMware VM.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca, ctimon
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# Error HAL_INITIALIZATION_FAILED when you install Windows 8 or Windows Server 2012 on VMware VM

This article provides a solution to fix a HAL_INITIALIZATION_FAILED error that occurs when you install Windows 8 or Microsoft Windows Server 2012 on VMware VM.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2814803

## Symptoms

Consider the following scenarios:

### Scenario 1  

When installing Windows 8, Windows Server 2012, or booting using Windows PE 4.0 on a VMware 4.x virtual machine running a Windows operating system, you may encounter the following error:

> Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you. (0% complete)  
If you would like to know more, you can search online later for this error: HAL_INITIALIZATION_FAILED

> [!Note]
> If you attempt to boot the x86 version of Windows PE 4.0, the system will hang.
  
### Scenario 2

You attempt to execute an Offline P2V using System Center Virtual Machine Manager 2012 SP1 for a virtual machine (Windows operating system) running on a VMware ESX server 4.x, you experience the symptoms as mentioned in the Scenario 1.

### Scenario 3

Assume that you install Windows 8 or Windows Server 2012 on a VMware virtual machine. In this situation, the VM crashes while booting and you may receive the following Stop error code:

> STOP: 0x0000005D (parameter1, parameter2, parameter3, parameter4)

## Cause

VMware 4.x doesn't support Windows 8 or Windows Server 2012 as guest operating system. VMware 4.x also doesn't support an Offline P2V of a virtual machine running a Windows operating system when using System Center Virtual Machine Manager (VMM) 2012 SP1. This version of VMM uses WinPE 4.0 when executing the Offline P2V process.

## Resolution

Upgrade to later version of VMware (at least version 5.1).
For Scenario 2, the options include:

1. Execute an Online P2V. This option may not be recommended for some virtual machines, such as those functioning as Domain Controllers, and or SQL servers.
2. Execute a V2V
3. Use the Microsoft Virtual Machine Converter solution - [Microsoft Virtual Machine Converter](https://technet.microsoft.com/library/hh967435.aspx)

## More information

You can also run into this issue in other scenarios involving WDS, SCCM, or other deployment technologies. For example, attempting to PXE boot a Windows 8 boot.wim.

For more information on support for Windows 8 and Windows Server 2012 in VMware, see the following article:  
[Windows 8 / Windows Server 2012 Operating System does not boot or install on ESXi or ESX (2006859)](https://kb.vmware.com/s/article/2006859).

For more information on support for operating systems in VMware Guests, see the following article:  
[VMware Compatibility Guide](https://www.vmware.com/resources/compatibility/search.php).

Hardware requirements for Windows 8 and Windows Server 2012:  
[PAE/NX/SSE2 Support Requirement Guide for Windows 8](/previous-versions/windows/it-pro/windows-8.1-and-8/dn482072(v=win.10))

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
