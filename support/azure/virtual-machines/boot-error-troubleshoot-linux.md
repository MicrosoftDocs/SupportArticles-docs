---
title: 'Troubleshoot boot errors in Azure Linux Virtual Machines'
description: This article helps link you to articles to troubleshoot boot errors in Azure Linux Virtual Machines.
services: virtual-machines
documentationCenter: ''
author: divargas-msft
manager: dcscontentpm
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure
ms.date: 03/06/2023
ms.author: divargas
---

# Troubleshoot Azure Linux Virtual Machines boot errors

This article consolidates the most common Linux Operating system boot errors that you may receive when you start a Linux virtual machine (VM) in Microsoft Azure.

## Boot errors and solutions

* For detailed instructions about how to recover Linux virtual machines unable to boot due to GRUB issues, see [Linux virtual machine boots to GRUB rescue](troubleshoot-vm-boot-error.md).
* To troubleshoot an `UEFI` (Gen2) Linux virtual machine unable to load the Linux image, see [Troubleshoot UEFI boot failures in Azure Linux virtual machines](/troubleshoot/azure/virtual-machines/azure-linux-vm-uefi-boot-failures).
* To troubleshoot a virtual machine landing into the Dracut emergency shell, see [Azure Linux virtual machine fails to boot and enters dracut emergency shell](/troubleshoot/azure/virtual-machines/linux-no-boot-dracut).
* To recover a Linux virtual machine failing to boot due to VFAT file system disabled, see [Azure Linux virtual machine fails to boot after VFAT file system type is disabled](/troubleshoot/azure/virtual-machines/vfat-disabled-boot-issues).
* To troubleshoot Azure Linux virtual machines unable to boot due to file system corruption issues, see [Troubleshoot Linux virtual machine boot issues due to filesystem errors](h/troubleshoot/azure/virtual-machines/linux-recovery-cannot-start-file-system-errors).
* For instructions about how to fix Linux boot issues due to `/etc/fstab` misconfigurations or data file system issues, see [Troubleshoot Linux VM boot issues due to fstab errors](/troubleshoot/azure/virtual-machines/linux-virtual-machine-cannot-start-fstab-errors).
* To recover a Linux virtual machine failing to boot with a kernel panic `Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)` due to missing initramfs, after a recent patching activity, see [Regenerate a missing initramfs](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#missing-initramfs).
* To troubleshoot a Linux virtual machine failing to boot due to related Linux kernel issues, see [Scenario 1: Kernel panic occurs at boot time](troubleshoot/azure/virtual-machines/linux-kernel-panic-troubleshooting#scenario-1-kernel-panic-occurs-at-boot-time), and [Azure Linux virtual machine fails to boot after applying kernel changes](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues).
* To troubleshoot a Linux virtual machine failing to boot due to Hyper-V driver issues, see [Troubleshoot Linux virtual machine boot and network issues due to Hyper-V driver-associated errors](/troubleshoot/azure/virtual-machines/linux-hyperv-issue).
* To recover a Linux virtual machine failing to start due to root file system full issues, see [Troubleshoot Azure Linux virtual machine boot issues due to full OS disk](/troubleshoot/azure/virtual-machines/linux-fulldisk-boot-error).

## Next steps

The following Azure articles and tools are key to recover from Linux no boot scenarios:

* [VM Serial Console](serial-console-linux.md): with the Azure serial console you could recover several no boot scenarios: booting the system over [previous kernel versions](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#bootingup-differentkernel), [booting the system in single user mode](troubleshoot/azure/virtual-machines/serial-console-grub-single-user-mode), and so on, and so forth.
* [Azure Repair VM command](repair-linux-vm-using-azure-virtual-machine-repair-commands.md): This tool takes care of creating a repair VM and attaching a copy of the OS disk to it. This copy can be then modified to fix no boot scenarios from a chroot environment.

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux).

    * [Using chroot to recover from no boot scenarios offline](/troubleshoot/azure/virtual-machines/chroot-environment-linux): When you're executing commands in a **chroot** environment, they're executed against the attached OS Disk and not the local **rescue/repair** VM.
* [Azure VM repair command + ALAR2 scripts](/troubleshoot/azure/virtual-machines/repair-linux-vm-using-alar): ALAR is part of the VM repair extension that's described in Repair a Linux VM by using the [Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md). These scripts simplify the recovery process and enable even inexperienced users to recover their Linux VM easily.
* [Azure OS disk swap](/azure/virtual-machines/linux/os-disk-swap): If you have an existing VM, but you want to swap the disk for a backup disk or another OS disk, you can use the Azure CLI to swap the OS disks. You don't have to delete and recreate the VM. You can even use a managed disk in another resource group, as long as it isn't already in use. This tool is used by the [Azure Repair VM command](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to exchange the OS disk of the virtual machines.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
