---
title: Generation 2 VMs can't start with error 23352
description: Describes an issue in which you cannot start generation 2 VMs that are created by using System Center 2012 R2 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, greggo, jchornbe
---
# Generation 2 VMs created in System Center 2012 R2 Virtual Machine Manager cannot start

This article fixes an issue in which you can't start generation 2 virtual machines that are created by using System Center 2012 R2 Virtual Machine Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2955362

## Symptoms

When using System Center 2012 R2 Virtual Machine Manager (VMM 2012 R2) for template creation, generation 2 virtual machines (VMs) based on this template cannot start after creation. Virtual Machine Manager returns the following error:

> Error (23352) VMM cannot find the device or this device is not valid for a boot device.

## Cause

The issue occurs because the Bootmgfw.efi file is set as the first startup device for the VM instead of the .vhdx file that contains the operating system.

## Resolution

To resolve the issue, open the properties of the VM, highlight **Hard Drive**, and move the .vhdx file that contains the operating system that you want to start from to the top of the list. This enables the VM to start.

To resolve the problem within the template for future VM deployments, run the following PowerShell command on Virtual Machine Manager server:

```powershell
get-scvmtemplate -name "YourGen2TemplateName" | set-scvmtemplate -FirstBootDevice "SCSI,0,0"
```

where *YourGen2TemplateName* is the name of your generation 2 template, the first 0 is the SCSI bus ID and the second 0 is the LUN ID of the boot disk.

As soon as this change is made, new generation 2 virtual machines deployed from the template should successfully start.
