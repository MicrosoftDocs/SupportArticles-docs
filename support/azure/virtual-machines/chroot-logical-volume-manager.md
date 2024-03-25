---
title: Troubleshoot Azure Linux VM when there's no access to Azure Serial Console and the disk layout uses LVM
description: Provides a troubleshooting guide for an Azure Linux VM when there's no access to Azure Serial Console and the disk layout uses Logical Volume Manager.
services: virtual-machines
documentationcenter: ''
author: divargas-msft
tags: Linux chroot LVM
ms.custom: linux-related-content
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure-services
ms.date: 03/10/2023
ms.author: divargas
---
# Troubleshoot Azure Linux VM when there's no access to Azure Serial Console and the disk layout uses Logical Volume Manager

This article provides a troubleshooting guide for an Azure Linux virtual machine (VM) where all the following conditions are presented:

- The VM isn't booting up.
- Connection to the VM by using SSH isn't possible.
- The Azure Serial Console access is unavailable.
- The VM is using Logical Volume Manager (LVM) in the operating system (OS) disk.

## Prerequisites

- To use the [Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md), the following access is required:

  - Access to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/)
  - Access to a new or existing custom storage account

- To perform the recovery operation, a temporary VM is required. To create such a VM, you need the corresponding permissions at the Azure subscription level.

## Prepare the rescue VM

1. Use [VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a rescue VM that has a copy of the affected VM's OS disk attached.

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

    - If you create the rescue VM manually instead of using the VM repair commands, to avoid issues due to duplicated LVM structures, you must select an image without LVM in the OS disk. If using Red Hat-based VMs, you need to search the image by using "Red Hat RAW." Ubuntu and SUSE images don't use LVM in the OS disk.

    - If the LVM utilities are missing in the Red Hat RAW image, [install the LVM utilities](/azure/virtual-machines/linux/configure-lvm?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json#install-the-lvm-utilities).

2. Connect to the rescue VM and mount the copy of the OS file systems in the rescue VM by using [chroot](chroot-environment-linux.md).

    When you execute commands in a chroot environment, they're executed against the attached OS Disk instead of the local rescue VM.

3. <a id="exit-chroot-and-swap-the-os-disk"></a>Once the troubleshooting is complete, perform the following actions:

    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure Serial Console or by trying to connect to the VM.

## Enable Serial Console

If access to the Serial Console is still not possible, verify the GRUB configuration parameters for your Linux VM and correct them. For more information, see [Serial Console GRUB proactive configuration](serial-console-grub-proactive-configuration.md).

## <a id="perform-fixes"></a>Common troubleshooting scenarios

### Scenario 1: Configure the VM to boot from a different kernel

A common scenario is to force a VM to boot from a previous kernel, as the currently installed kernel may have become corrupt or an upgrade didn't complete correctly.

To do this, follow the steps in [Boot system on older kernel version](kernel-related-boot-issues.md#bootingup-differentkernel). You can also check [Recent kernel downgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kerneldowngrade).

### Scenario 2: Kernel update issues

A failed kernel upgrade can cause the VM to be non-bootable. For more information about the actions to perform the Kernel update, see [Kernel update process](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupdate).

### Scenario 3: LVM swap volume misconfiguration in GRUB

In this scenario, a VM fails to complete the boot process and enters the dracut emergency shell due to an invalid swap device path in the GRUB configuration.

To resolve the issues, perform the steps in [Wrong swap device path in GRUB configuration file](linux-no-boot-dracut.md#dracut-grub-misconf-wrong-swap).

## Next steps

For further no boot troubleshooting options, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
