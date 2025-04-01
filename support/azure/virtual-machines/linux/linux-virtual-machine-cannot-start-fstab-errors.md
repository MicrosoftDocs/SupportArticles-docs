---
title: Troubleshoot Linux VM boot issues due to fstab errors
description: Explains why Linux VM can't start and how to solve the problem.
services: virtual-machines
documentationcenter: ''
author: saimsh-msft
ms.author: saimsh
manager: dcscontentpm
ms.reviewer: divargas
tags: ''
ms.custom: sap:My VM is not booting, linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 02/26/2025
---

# Troubleshoot Linux VM boot issues due to fstab errors

**Applies to:** :heavy_check_mark: Linux VMs

[!INCLUDE [CentOS End Of Life](../../../includes/centos-end-of-life-note.md)]

The Linux filesystem table, fstab, is a configuration table that is designed to configure rules where specific file systems are detected and mounted in an orderly manner during the system boot process. 

This article discusses multiple conditions where a wrong fstab configuration can lead to boot issues and provides troubleshooting guidance.

Here are some common reasons that can lead to virtual machine (VM) boot issues due to fstab misconfiguration:

* Traditional filesystem name is used instead of the Universally Unique Identifier (UUID) of the filesystem.
* An incorrect UUID is used. 
* An entry exists for an unattached device without the `nofail` option within the fstab configuration.
* Incorrect entry within the fstab configuration.
  
## Identify fstab issues

Check the current boot state of the VM in the serial log within the [Boot diagnostics](/azure/virtual-machines/boot-diagnostics#boot-diagnostics-view) blade in the Azure portal. The VM will be in an Emergency Mode. You see log entries that resemble the following example leading to the Emergency Mode state:

```output
[K[[1;31m TIME [0m] Timed out waiting for device dev-incorrect.device.
[[1;33mDEPEND[0m] Dependency failed for /data.
[[1;33mDEPEND[0m] Dependency failed for Local File Systems.
…
Welcome to emergency mode! After logging in, type "journalctl -xb" to viewsystem logs, "systemctl reboot" to reboot, "systemctl default" to try again to boot into default mode.
Give root password for maintenance
(or type Control-D to continue)
```

 >[!Note]
 > `/data` is an example of mount point used. Dependency failure for filesystem mount point will differ based on the names used.

## Resolution

There are two ways to resolve the issue:

* Repair the VM online
    * [Use the serial console](#use-the-serial-console)
* Repair the VM offline
    * [Use Azure Linux Auto Repair (ALAR)](#use-azure-linux-auto-repair-alar)
    * [Use the manual method](#use-the-manual-method)

### Repair the VM online

#### Use the serial console

1. Connect to [the serial console](./serial-console-linux.md) of the VM from the Azure portal.
2. Manual access to single-user mode is required to reconfigure fstab. The steps can vary based on the type of Linux OS used and access to the root account. Follow the [single-user mode](serial-console-grub-single-user-mode.md) documentation to access single-user mode for each supported Linux partner image.

##### Fstab troubleshooting steps

1. Once the VM has booted into single-user mode. Use your favorite text editor to open the fstab file.

   ```bash
   vi /etc/fstab
   ```

2. Review the listed filesystems in `/etc/fstab`. Each line in the fstab file indicates a filesystem that is mounted when the VM starts. For more information about the syntax of the fstab file, run the `man fstab` command. To troubleshoot a boot failure, review the entry for the filesystem that failed to mount. It's a good practice to review each line to ensure that it's correct in both structure and content. A few points to consider to correctly administer a fstab file are as follows:

   * Fields on each line are separated by tabs or spaces. Blank lines are ignored. Lines that have a number sign (#) as the first character are comments. Commented lines can remain in the fstab file, but they won't be processed. We recommend that you comment fstab lines that you're unsure about instead of removing the lines.
   * Mount the data disks on Azure VMs by using the UUID of the file system partition. To determine the UUID of the file system, run the `blkid` command. For more information about the syntax, run the `man blkid` command. Example of the UUID entry in the fstab file:

      ```bash
      UUID=<UUID number here>  /data      xfs    defaults,nofail 0  0
      ```

   * Use the `nofail` option in the filesystem entries (data disks) to enable startup to continue even after errors occur in partitions for the corresponding entries. The `nofail` option helps make sure that the VM starts even if the file system is corrupted or if it doesn't exist at startup.

5. Save the changes to the fstab file.

6. Use `mount -a` as a best practice after making changes to the fstab entries. This will rerun the fstab configuration and notify the users of any existing syntax or entry errors.

6. Once the syntax and entries are verified, reboot the VM using the following command:

   ```bash
   reboot -f
   ```
7. If the entries comment or fix was successful, the system should reach a bash prompt in the portal. Check whether you can connect to the VM.

   > [!Note]
   > You can also use the `ctrl+x` command that will also reboot the VM.

### Repair the VM offline

If the VM serial console access isn't available, an alternative solution is to repair the VM offline. There are two ways to take an offline approach: 

#### Use Azure Linux Auto Repair (ALAR)

Azure Linux Auto Repair (ALAR) scripts are part of the VM repair extension described in [Use Azure Linux Auto Repair (ALAR) to fix a Linux VM](./repair-linux-vm-using-alar.md). ALAR covers the automation of multiple repair scenarios, including `/etc/fstab` issues.

The ALAR scripts use the repair extension `repair-button` to fix fstab issues by specifying `--button-command fstab`. This parameter triggers the automated recovery. Implement the following steps to automate fstab errors via the offline ALAR approach:

```azurecli-interactive
az extension add -n vm-repair
az extension update -n vm-repair
az vm repair repair-button --button-command 'fstab' --verbose --resource-group $RGNAME --name $VMNAME
```

> [!NOTE]
> Replace the resource group name `$RGTEST` and VM name `$VMNAME` accordingly.

* The repair VM script, in conjunction with the ALAR script, will temporarily create a resource group, a repair VM, and a copy of the affected VM's OS disk. It backs up the original `/etc/fstab` file and modifies it by removing or commenting out data file system entries that aren't required to boot the system.
* After the OS starts successfully, review and edit the `/etc/fstab` file to fix any errors that might have prevented a proper reboot.
* Finally, the `repair-button` script will automatically delete the resource group containing the repair VM.

#### Use the manual method

If both the serial console and ALAR approaches aren't possible or fail, the repair has to be performed manually. Follow the steps here to manually attach the OS disk to a recovery VM and swap the OS disk back to the original VM:

* [Attach the OS disk to a recovery VM using the Azure portal](./troubleshoot-recovery-disks-portal-linux.md)
* [Attach the OS disk to a recovery VM using the Azure CLI](./troubleshoot-recovery-disks-linux.md)

Once the OS disk is successfully attached to the recovery VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) to mount and chroot to the filesystems of the attached OS disk. Then, implement the [fstab troubleshooting steps](#fstab-troubleshooting-steps) to make appropriate changes to the fstab file of the problematic OS disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
