---
title: Repair a Linux VM automatically with the help of ALAR | Microsoft Docs
description: This article describes how to autorepair a non-bootable VM with the  Azure Linux Auto Repair scripts (ALAR).
services: virtual-machines
documentationcenter: ''
author: malachma
manager: noambi
editor: ''
tags: virtual-machines
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 02/19/2021
ms.author: malachma

---

# Use Azure Linux Auto Repair (ALAR) to fix a Linux VM

The next time that you have to run a repair on your Azure Linux virtual machine (VM), you can automate the job by putting the Azure Linux Auto Repair (ALAR) scripts to work for you. You no longer have to run the job manually. These scripts simplify the recovery process and enable even inexperienced users to recover their Linux VM easily.

ALAR is part of the VM repair extension that's described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

ALAR covers the following repair scenarios:
- Malformed /etc/fstab file:
   - Syntax errors
   - Missing disk
- Damaged initrd or missing initrd line in the /boot/grub/grub.cfg file
- Startup problems caused by a corrupted kernel image

## The ALAR scripts

**fstab**
This script strips off any lines in the /etc/fstab file that the system doesn't need to start successfully. The system first makes a copy of the original file.
After the system restarts, the /etc/fstab file can be updated to add lines for the correct mount options.

For more information about problems that are caused by a bad /etc/fstab file, see [Troubleshoot Linux VM starting issues because fstab errors](./linux-virtual-machine-cannot-start-fstab-errors.md). 

**kernel**
This script changes the default kernel. The script replaces the broken kernel with the previously installed version.


Consult also this page [How to recover an Azure Linux virtual machine from kernel-related boot issues](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/kernel-related-boot-issues). To understand what messages might be logged on the serial-console. In case you see a kernel-related boot issue.


**initrd**
This script corrects two problems that might occur when a new kernel is installed:
   - The Grub.cfg file is missing an `initrd` line.
   - The initrd image is missing.

Depending on the specific problem, the script either repairs the Grub.cfg file or creates a new initrd image to replace a missing image.

Initrd-related startup problems can appear as the following logged symptoms.

![Not syncing VFS](media/repair-linux-vm-using-ALAR/not-syncing-VFS.png)
![No working init found](media/repair-linux-vm-using-ALAR/no-working-init-found.png)

In both cases, the following information is logged before the error entries are logged.

![Unpacking failed](media/repair-linux-vm-using-ALAR/unpacking-failed.png)

## How to use ALAR
The ALAR scripts use the repair extension `run` command and its `--run-id` option. The script-id for the automated recovery is: **linux-alar-fki**. For example:

```azurecli-interactive
az vm repair create --verbose -g centos7 -n cent7 --repair-username rescue --repair-password 'password!234’
 ```

```azurecli-interactive
az vm repair run --verbose -g centos7 -n cent7 --run-id linux-alar-fki --parameters initrd --run-on-repair
 ```

```azurecli-interactive
az vm repair restore --verbose -g centos7 -n cent7
 ```

These steps create a repair task. In the next step, you will use the `initrd` script to fix an initrd-related startup problem. In the last step, you will run the restore operation.

  [!NOTE]
> You can pass over either a single recover-operation or multiple operations. For multiple operations, delineate them by using commas without spaces:
   > - ‘fstab’
   > - ‘fstab,initrd’

## Supported Operating Systems
- CentOS/Redhat 6.8 - 8.2
- Ubuntu 16.4 LTS and Ubuntu 18.4 LTS
- Suse 12 and 15"
- Debain 9 and 10"
       

## Limitations
- Encrypted images aren't supported.
- Classic VMs aren't supported.
- EFI-based images aren't supported.

## Next steps

If you experience a bug or want to request an enhancement to the script base of ALAR, post a comment on [GitHub](https://github.com/Azure/repair-script-library/issues).
