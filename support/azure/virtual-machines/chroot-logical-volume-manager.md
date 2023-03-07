---
title: Recover Linux VMs using chroot where LVM (Logical Volume Manager) is used - Azure VMs
description: Recovery of Linux VMs with LVMs. 
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

# Troubleshooting a Linux VM when there is no access to the Azure serial console and the disk layout is using LVM (Logical Volume Manager)

This troubleshooting guide is of benefit for scenarios where a Linux VM is not booting, connect to the virtual machine using SSH isn't possible, the Azure serial console access is unavailable, and the underlying file system layout is configured with LVM (Logical Volume Manager).

## Prerequisites

If using the [Azure repair VM](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) command, you'll need access to the [Azure cloud shell](https://ms.portal.azure.com/#cloudshell/), and access to an existent or new custom storage account.

You'll also need to create a temporary virtual machine to be used for the recovery operation. You'll need the corresponding permissions at Azure subscription level to create such virtual machine.

## Prepare the recovery virtual machine

1. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached.

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux).

    * If you're creating the rescue VM manually, instead of using the Repair VM command, you must select an image **without LVM** in the OS disk to avoid issues due to duplicated LVM structures. In the case of Red Hat based VMs, you'll need to search the image using `Red Hat RAW`. Ubuntu and SUSE images don't use LVM in the OS disk.
    * Refer to [Install the LVM utilities](/azure/virtual-machines/linux/configure-lvm?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json#install-the-lvm-utilities) in case the LVM utilities are missing in the Red Hat RAW image.

2. Connect to the repair/rescue VM and mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    * When executing commands in a **chroot** environment, note they're executed against the attached OS Disk and not the local **rescue/repair** VM.

## Enable Serial Console

Given the access to the serial console has not been possible, verify the GRUB configuration parameters for your Linux VM and correct them. Detailed instructions can be found in [Proactive GRUB configuration](./serial-console-grub-proactive-configuration.md).

## Common troubleshooting scenarios

### Scenario 1 - configure the VM to boot from a different kernel

A common scenario is to force a VM to boot from a previous kernel as the current kernel may have become corrupted or an upgrade did not complete correctly.

For detailed instructions to perform this kind of task, see [Boot system on older kernel version](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#bootingup-differentkernel). You can also check [Recent kernel downgrade](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#other-kernel-boot-issues-kerneldowngrade).

### Scenario 2 - kernel update issues

A failed kernel upgrade can render the VM non-bootable. For more information about the actions to take in this scenario, see [Kernel update process](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#other-kernel-boot-issues-kernelupdate).

### Scenario 3 - LVM swap volume misconfiguration in GRUB

In this scenario, A VM fails to complete the boot process and drops into the **dracut** Emergency shell due to an invalid swap device path in the GRUB configuration.
For more information about the steps required to address this issue, see [Wrong swap device path in GRUB configuration file](/troubleshoot/azure/virtual-machines/linux-no-boot-dracut?source=recommendations#dracut-grub-misconf-wrong-swap).

## Next steps

For further no boot troubleshooting options, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
