---
title: Issues when starting VM or installing Hyper-V
description: This article describes an issue where BIOS update is required before installing Hyper-V role or start virtual machines on Windows Server 2012 and Windows 8.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, taylorb, vimalsh, adityah
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# A BIOS update may be required for some computers to install the Hyper-V Role and/or start Hyper-V virtual machines

This article provides help to solve issues that occur when you install the Hyper-V Role or start Hyper-V virtual machines.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2762297

## Symptoms

Various symptoms and errors:

### Issue 1

On a computer with Windows Server 2012 or Windows 8 with Hyper-V role installed or after upgrading from a previous version of Windows with the Hyper-V role already installed, you may receive the following error message while starting a virtual machine:

> Virtual machine 'VM_Name' could not be started because the hypervisor is not running (Virtual machine ID \<Virtual_Machine_ID>). The following actions may help you resolve the problem:  
>
> 1. Verify that the processor of the physical computer has a supported version of hardware-assisted virtualization.
> 2. Verify that hardware-assisted virtualization and hardware-assisted data execution protection are enabled in the BIOS of the physical computer. (If you edit the BIOS to enable either setting, you must turn off the power to the physical computer and then turn it back on. Resetting the physical computer is not sufficient.)
> 3. If you have made changes to the Boot Configuration Data store, review these changes to ensure that the hypervisor is configured to launch automatically.  

### Issue 2

A computer that is running Windows Server 2012 or Windows 8, trying to enable the Hyper-V role, you may receive one of the following error messages:

> 1. Hyper-V cannot be installed because virtualization support is not enabled in the BIOS.
> 2. Hyper-V cannot be installed: Data Execution Prevention is not enabled.
> 3. Verifying the computer's BIOS has virtualization support and Data Execution Protection is enabled.

#### Issue 3

When attempting to enable SR-IOV support on Windows Server 2012 with the Hyper-V installed, you may receive the following error messages from the IovSupportReasons property when running the following PowerShell command:

```powershell
Get-VMHost | Format-List IovSupport, IovSupportReasons  
```

> - SR-IOV cannot be used on this computer because the processor does not support second level address translation (SLAT). For Intel processors, this feature might be referred to as Extended Page Tables (EPT). For AMD processors, this feature might be referred to as Rapid Virtualization Indexing (RVI) or Nested Page Tables (NPT).
> - The chipset on the system does not do interrupt remapping, without which SR-IOV cannot be supported.
> - The chipset on the system does not do DMA remapping, without which SR-IOV cannot be supported.
> - SR-IOV cannot be used on this system as it has been configured to disable the use of I/O remapping hardware.
> - Ensure that the system has chipset support for SR-IOV and that I/O virtualization is enabled in the BIOS.
> - To use SR-IOV on this computer, the BIOS must be updated because it contains incorrect information describing the hardware capabilities. Contact your computer manufacturer for an update.
> - SR-IOV cannot be used on this system as it is reporting that there is no PCI Express Bus. Contact your system manufacturer for further information.
> - To use SR-IOV on this system, the system BIOS must be updated to allow Windows to control PCI Express. Contact your system manufacturer for an update.
> - SR-IOV cannot be used on this system as the PCI Express hardware does not support Access Control Services (ACS) at any root port. Contact your system vendor for further information.

## Cause

Various causes associated with issues mentioned in Symptoms section.

### Cause for issue 1

This error occurs because the Secure Mode Extensions (SMX) feature available from the BIOS is enabled and there is a change in the execution environment. This causes the Hypervisor to not be loaded.

### Cause for issue 2

This error may occur when the BIOS reports that virtualization support or Data Execution Protection is not enabled even though it is enabled in the BIOS configuration menu.

### Cause for issue 3

These errors may be caused due to the following reasons:

- An outdated BIOS
- Incorrect BIOS setting
- Incompatible Hardware

## Resolution

To resolve issues mentioned in Symptoms section, refer to the appropriate section below:

### Resolution for issue 1

Contact the hardware manufacture to check for a BIOS/firmware update and disable the Secure Mode Extensions (SMX) feature from the BIOS.

### Resolution for issue 2

Contact the hardware manufacture to check for a BIOS/firmware update.

### Resolution for issue 3

1. Verify with your hardware manufacturer that the system contains the required chipset support, and is supported for SR-IOV capability through firmware.
2. Ensure the system is updated with the latest firmware release containing SR-IOV support.
3. It may be necessary to change the firmware settings to enable VT-d (on Intel Platforms) or AMD-Vi (on AMD Platforms). This may be referred to in several ways including "IOMMU", "IO/MMU", "I/O Virtualization" or "SR-IOV support". The naming of the firmware settings is vendor-specific.
4. Some systems may have settings in two different places in the firmware that require configuring. You should consult your hardware manufacturers documentation for the specific settings and for NIC hardware that they support for SR-IOV networking.
5. After changing BIOS/firmware settings, it may be necessary to cold restart the system.  

Also, refer to the Windows Server 2012 Release Notes for Hyper-V that contain additional information regarding SR-IOV.  
[Release Notes: Important Issues in Windows Server 2012](https://technet.microsoft.com/library/jj134216.aspx)
