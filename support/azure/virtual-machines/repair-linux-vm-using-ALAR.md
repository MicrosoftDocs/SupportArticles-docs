---
title: Repair a Linux VM automatically with the help of ALAR
description: This article describes how to autorepair a non-bootable VM with the  Azure Linux Auto Repair scripts (ALAR).
services: virtual-machines-linux
documentationcenter: ''
author: malachma
manager: noambi
editor: v-jsitser
tags: virtual-machines
ms.service: virtual-machines
ms.subservice: vm-backup-restore
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 02/19/2021
ms.author: malachma

---

# Use Azure Linux Auto Repair (ALAR) to fix a Linux VM

The next time that you have to run a repair on your Azure Linux virtual machine (VM), you can automate the job by putting the Azure Linux Auto Repair (ALAR) scripts to work for you. You no longer have to run the job manually. These scripts simplify the recovery process and enable even inexperienced users to recover their Linux VM easily.

ALAR utilizes the VM repair extension that's described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

ALAR covers the following repair scenarios:

- Malformed /etc/fstab
    syntax error
    missing disk
- Damaged initrd or missing initrd line in the /boot/grub/grub.cfg
- Last installed kernel isn't bootable
- Serial console and GRUB serial are incorrectly configured or are missing
- GRUB/EFI installation or configuration damaged

## The ALAR actions

### fstab

This action strips off any lines in the */etc/fstab* file that aren't needed to boot a system. It makes a copy of the original file first, so after the OS starts, the administrator can edit the fstab again and correct any errors that didn't allow a reboot of the system before.

For more information about issues with a malformed */etc/fstab* file, see [Troubleshoot Linux VM starting issues because fstab errors](./linux-virtual-machine-cannot-start-fstab-errors.md).

### kernel

This action changes the default kernel. The script replaces the broken kernel with the previously installed version.

For more information about messages that might be logged on the serial console for kernel-related startup events, see [How to recover an Azure Linux virtual machine from kernel-related boot issues](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues).

### initrd

This action can be used to fix an initrd or initramfs that is either corrupted or incorrectly created.

To get the initrd or initramfs created correctly, add the modules `hv_vmbus`, `hv_netvsc`, and `hv_storvsc` to the image.

Initrd-related startup problems can appear as the following logged symptoms.

![Not syncing VFS](media/repair-linux-vm-using-ALAR/not-syncing-VFS.png)
![No working init found](media/repair-linux-vm-using-ALAR/no-working-init-found.png)

In both cases, the following information is logged before the error entries are logged.

![Unpacking failed](media/repair-linux-vm-using-ALAR/unpacking-failed.png)

### serialconsole

This action corrects an incorrect or malformed serial console configuration for the Linux kernel or GRUB. We recommend that you run this action in the following cases:

- No GRUB menu is displayed at VM startup.
- No operating system related information is written to the serial console.

### grubfix

This action can be used to reinstall GRUB and regenerate the *grub.cfg* file.

### efifix

This action can be used to reinstall the required software to boot from a GEN2 VM. The *grub.cfg* file is also regenerated.

## How to use ALAR

The ALAR scripts use the repair extension `run` command and its `--run-id` option. The script-id for the automated recovery is: **linux-alar2**. For example:

```azurecli-interactive
az vm repair create --verbose -g centos7 -n cent7 --repair-username rescue --repair-password 'password!234' --copy-disk-name  repairdiskcopy
 ```

```azurecli-interactive
az vm repair run --verbose -g centos7 -n cent7 --run-id linux-alar2 --parameters initrd --run-on-repair
 ```

```azurecli-interactive
az vm repair restore --verbose -g centos7 -n cent7
 ```

These steps create a repair task. In the next step, you'll use the `initrd` script to fix an initrd-related startup problem. In the last step, run the restore operation.

  [!NOTE]
> You can pass over either a single recover-operation or multiple operations. For multiple operations, delineate them by using commas without spaces:
   >
   > - ‘fstab’
   > - ‘fstab,initrd’

## Limitation

Classic VMs aren't supported.

## Next steps

If you experience a bug or want to request an enhancement to the ALAR tool, post a comment on [GitHub](https://github.com/Azure/ALAR/issues).

You can also find the latest information about the ALAR tool on [GitHub](https://github.com/Azure/ALAR).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
