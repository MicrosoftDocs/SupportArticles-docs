---
title: Recover Azure Linux VM where Logical Volume Manager is used
description: Provides a troubleshooting guide to recover an Azure Linux VM where Logical Volume Manager is configured.
services: virtual-machines
documentationcenter: ''
author: divargas-msft
tags: Linux chroot LVM
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.devlang: na
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure-services
ms.date: 03/06/2023
ms.author: divargas
---
# Troubleshoot Linux VM not booting up when the disk layout uses Logical Volume Manager

When the underlying file system layout of an Azure Linux virtual machine (VM) is configured with Logical Volume Manager (LVM), the following issues occur with the VM:

- The VM fails to boot up.
- Azure Serial Console for the VM is unaccessible.
- Connection to the VM by using SSH fails.

This article provides a troubleshooting guide to recovery the VM.

## Prerequisites

- To use the [Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md), the following access is required:

  - Access to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).
  - Access to a new or existent custom storage account.

- To perform the recovery operation, a temporary VM is required. To create such VM, you need the corresponding permissions at Azure subscription level.

## Prepare the rescue VM

1. Use [VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a rescue VM that has a copy of the affected VM's operating system (OS) disk attached.

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

    - If you create the rescue VM manually instead of using the VM repair commands, to avoid issues due to duplicated LVM structures, you must select an image without LVM in the OS disk. If using Red Hat based VMs, you need to search the image by using "Red Hat RAW". Ubuntu and SUSE images don't use LVM in the OS disk.

    - If the LVM utilities are missing in the Red Hat RAW image, [install the LVM utilities](/azure/virtual-machines/linux/configure-lvm?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json#install-the-lvm-utilities).

2. Connect to the rescue VM and mount the copy of the OS file systems in the rescue VM by using [chroot](chroot-environment-linux.md).

    When you execute commands in a chroot environment, they're executed against the attached OS Disk instead of the local rescue VM.

3. <a id="exit-chroot-and-swap-the-os-disk"></a>Once the troubleshooting is complete, perform the following actions:

    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure Serial Console or by trying to connect to the VM.

## Enable Serial Console

If there isn't an access to the Serial Console for the VM, verify the GRUB configuration parameters for your Linux VM and correct them. For more information, see [Proactive GRUB configuration](serial-console-grub-proactive-configuration.md).

## <a id="perform-fixes"></a>Common troubleshooting scenarios

### Scenario 1: Configure the VM to boot from a different kernel

If the current kernel is corrupted or an upgrade doesn't complete, force the VM to boot from a previous kernel. To do this, check [Recent kernel downgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kerneldowngrade) and follow the steps in [Boot system on older kernel version](kernel-related-boot-issues.md#bootingup-differentkernel).

### Scenario 2: Kernel update issues

A failed kernel upgrade can cause the VM to be non-bootable. For more information about the actions to perform the Kernel update, see [Kernel update process](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupdate).

### Scenario 3: LVM swap volume misconfiguration in GRUB

In this scenario, a VM fails to complete the boot process and enters the dracut emergency shell due to an invalid swap device path in the GRUB configuration.

To resolve the issues, perform the steps in [Wrong swap device path in GRUB configuration file](linux-no-boot-dracut.md#dracut-grub-misconf-wrong-swap).

## Next steps

For further no boot troubleshooting options, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
