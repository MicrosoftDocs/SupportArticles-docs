---
title: Troubleshoot boot errors in Azure Linux virtual machines
description: This article helps troubleshoot boot errors in Azure Linux virtual machines.
services: virtual-machines
documentationCenter: ''
author: divargas-msft
manager: dcscontentpm
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.custom: linux-related-content
ms.workload: infrastructure
ms.date: 03/10/2023
ms.author: divargas
---
# Troubleshoot Azure Linux virtual machine boot errors

This article consolidates the most common Linux operating system boot errors you may receive when you start a Linux virtual machine (VM) in Microsoft Azure.

## Boot errors and solutions

* To recover a Linux VM that's unable to boot due to GRUB issues, see [Linux virtual machine boots to GRUB rescue](troubleshoot-vm-boot-error.md).

* To troubleshoot a UEFI (Gen2) Linux VM that's unable to load the Linux image, see [Troubleshoot UEFI boot failures in Azure Linux virtual machines](azure-linux-vm-uefi-boot-failures.md).

* To troubleshoot a Linux VM that lands into the dracut emergency shell, see [Azure Linux virtual machine fails to boot and enters dracut emergency shell](linux-no-boot-dracut.md).

* To recover a Linux VM that fails to boot due to VFAT file system disabled, see [Azure Linux virtual machine fails to boot after VFAT file system type is disabled](vfat-disabled-boot-issues.md).

* To troubleshoot a Linux VM that's unable to boot due to file system corruption issues, see [Troubleshoot Linux virtual machine boot issues due to filesystem errors](linux-recovery-cannot-start-file-system-errors.md).

* To fix Linux VM boot issues due to `/etc/fstab` misconfigurations or data file system issues, see [Troubleshoot Linux VM boot issues due to fstab errors](linux-virtual-machine-cannot-start-fstab-errors.md).

* To recover a Linux VM that fails to boot with a kernel panic "Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)" due to missing initramfs after a recent patching activity, see [Regenerate missing initramfs](kernel-related-boot-issues.md#missing-initramfs).

* To troubleshoot a Linux VM that fails to boot due to related Linux kernel issues, see [Scenario 1: Kernel panic occurs at boot time](linux-kernel-panic-troubleshooting.md#scenario-1-kernel-panic-occurs-at-boot-time), and [Azure Linux virtual machine fails to boot after applying kernel changes](kernel-related-boot-issues.md).

* To troubleshoot a Linux VM that fails to boot due to Hyper-V driver issues, see [Troubleshoot Linux virtual machine boot and network issues due to Hyper-V driver-associated errors](linux-hyperv-issue.md).

* To recover a Linux VM that fails to start due to root file system full issues, see [Troubleshoot Azure Linux virtual machine boot issues due to full OS disk](linux-fulldisk-boot-error.md).

## Tools to recover Linux VM from no boot scenarios

* [VM Serial Console](serial-console-linux.md)

    With the Azure Serial Console, you could recover several no boot scenarios, for example:

    * [Booting the system over previous kernel versions](kernel-related-boot-issues.md#bootingup-differentkernel)

    * [Booting the system in single-user mode](serial-console-grub-single-user-mode.md)

* [Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md)

    With this tool, you can create a repair VM and attach a copy of the OS disk to it. This copy can be modified to fix no boot scenarios from a chroot environment. For more information, see [using chroot to recover from no boot scenarios offline](chroot-environment-linux.md). When you execute commands in a chroot environment, they're executed against the attached OS Disk and not the local rescue/repair VM.

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

* Azure VM repair commands and [ALAR2 scripts](repair-linux-vm-using-alar.md)

    Azure Linux Auto Repair (ALAR) is part of the VM repair extension that's described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md). These scripts simplify the recovery process and enable even inexperienced users to recover their Linux VM easily.

* [Azure OS disk swap](/azure/virtual-machines/linux/os-disk-swap)

    If you have an existing VM but you want to swap the disk for a backup disk or another OS disk, you can use the Azure CLI to swap the OS disks. You don't have to delete and recreate the VM. You can even use a managed disk in another resource group as long as it isn't already in use. This tool is used by the [Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to exchange the OS disk of the VMs.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
