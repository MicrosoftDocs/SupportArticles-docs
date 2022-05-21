---
title: Convert between VHD and VHDX formats
description: Fixes an issue in which a Virtual Machine Manager template referencing a VHDX cannot be deployed to a Windows Server 2008 Hyper-V server.
ms.date: 05/07/2020
---
# How to convert between VHD and VHDX formats in System Center 2012 Virtual Machine Manager

This article describes how to convert VHD files to VHDX, or VHDX files to VHD in System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2799257

## Symptoms

Certain situations may necessitate converting VHD files to VHDX, or VHDX files to VHD. For example, a Virtual Machine Manager (VMM) template referencing a VHDX cannot be deployed to a Windows Server 2008 Hyper-V server, therefore this template will need to be recreated using a VHD file.

## Cause

Windows Server 2008 Hyper-V servers are not aware of the VHDX file format and System Center 2012 Virtual Machine Manager SP1 relies on the Hyper-V host to read the header of the file.

## Resolution

Use one of the following methods to convert between formats:

- Use the Hyper-V UI in Windows Server 2012, select to edit the VHDX or VHD file and choose to convert to either VHD or VHDX.
- Use the new `Convert-VHD` PowerShell cmdlet referenced here:

   [Convert-VHD](/powershell/module/hyper-v/convert-vhd)

> [!NOTE]
> VHD conversion must be done when the VM is shut down.

## More Information

When you encounter this issue, you may see one or more of the following:

- When you create a virtual machine template from a cloned hard disk for the Windows Server 2012 operating system and attempt to place it on a Windows Server 2008 R2 library server, it fails with the error below:

  > Error (802)  
  > The VirtualHardDisk file <*name*> is already in use by another VirtualHardDisk.

- During virtual machine creation from a Windows Server 2012 template, the host rating explanation shows the following status:

  > SCVMM cannot locate an available physical instance of the equivalence group for the virtual disk with ID <*name*>
