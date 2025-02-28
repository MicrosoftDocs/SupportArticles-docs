---
title: The Remove-SCVirtualMachine command doesn't remove a VM from the Hyper-V host
description: Fixes an issue where the Remove-SCVirtualMachine command doesn't remove a VM from the Hyper-V host.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# The Remove-SCVirtualMachine command may not remove a virtual machine from the Hyper-V host

This article helps you fix an issue where the PowerShell command `Remove-SCVirtualMachine` with the `-force` option doesn't remove a virtual machine from the Hyper-V host.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2680205

## Symptoms

In System Center 2012 Virtual Machine Manager (VMM), using the PowerShell command `Remove-SCVirtualMachine` with the `-force` option to delete a virtual machine (VM) removes the VM from VMM but may not remove it from the Hyper-V host.

## Cause

This is by design. The PowerShell command `Remove-SCVirtualMachine -force` is used to remove the VMM object, not the actual virtual machine on the host.

## Resolution

If you want to remove the virtual machine from VMM as well as from the host, run the `Remove-SCVirtualMachine` command without the `-force` switch.
