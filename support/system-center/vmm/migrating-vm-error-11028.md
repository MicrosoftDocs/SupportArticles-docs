---
title: Error 11028 migrating a virtual machine
description: Describes an issue that you receive error 11028 when migrating a VM with attached shared ISO in Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: jarrettr
---
# Error ID 11028 when migrating a VM with attached shared ISO in Virtual Machine Manager

This article fixes an issue in which you receive error 11028 when migrating a virtual machine with attached shared ISO in Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2792049

## Symptoms

When attempting to migrate a virtual machine (VM) with an attached shared ISO using System Center Virtual Machine Manager, the following error message is generated:

> Virtualization platform on host *Host_Name.domain.com* does not support shared DVD ISO images.  
> Remove the shared ISO image from hardware profile or select a different host.  
> ID: 11028

All hosts are configured to support shared ISOs.

VMMTrace event:

> 07:14:37.149 12-13-2012 0x18B4 0x132C ErrorDialog.cs(306) 0x00000000 Error Dialog.Show: Code: 11028; DetailedErrorCode: ; DetailedErrorSource: NoneProblem: Virtualization platform on host vmm-2012-jfb.domain.com does not support shared DVD ISO images.Action: Remove the shared ISO image from hardware profile or select a different host. {00000000-0000-0000-0000-000000000000}

## Cause

Shared ISOs are not supported during a VM migration.

## Resolution

Remove the shared ISO from the VM and restart the VM migration process.

## More Information

[How to Enable Shared ISO Images for Hyper-V Virtual Machines in VMM](/previous-versions/system-center/virtual-machine-manager-2008-r2/ee340124(v=technet.10)?redirectedfrom=MSDN)
