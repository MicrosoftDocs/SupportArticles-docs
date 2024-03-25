---
title: Troubleshoot Linux VM boot issues due to fstab errors | Microsoft Learn
description: Explains why Linux VM cannot start and how to solve the problem.
services: virtual-machines
documentationcenter: ''
author: saimsh-msft
manager: dcscontentpm
tags: ''
ms.custom: linux-related-content
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 09/10/2022
ms.author: saimsh
---
# Troubleshoot Linux VM boot issues due to fstab errors

The Linux filesystem table, fstab is a configuration table which is designed to configure rules where specific file systems are detected and mounted in an orderly manner during the system boot process. 
This article discusses multiple conditions where a wrong fstab configuration can lead to boot issue and provides troubleshooting guidance.

Few common reasons that can lead to Virtual Machine Boot issues due to fstab misconfiguration are listed below:
* Traditional filesystem name is used instead of the Universally Unique Identifier (UUID) of the filesystem.
* An incorrect UUID is used. 
* An entry exists for an unattached device without ```nofail``` option within fstab configuration.
* Incorrect entry within fstab configuration.
  
## Identify fstab issues

Check the current boot state of the VM in the serial log within the [Boot diagnostics] (/azure/virtual-machines/boot-diagnostics#boot-diagnostics-view) blade in the Azure portal. The VM will be in an Emergency Mode. You see log entries that resemble the following example leading to the Emergency Mode state:

```
[K[[1;31m TIME [0m] Timed out waiting for device dev-incorrect.device.
[[1;33mDEPEND[0m] Dependency failed for /data.
[[1;33mDEPEND[0m] Dependency failed for Local File Systems.
…
Welcome to emergency mode! After logging in, type "journalctl -xb" to viewsystem logs, "systemctl reboot" to reboot, "systemctl default" to try again to boot into default mode.
Give root password for maintenance
(or type Control-D to continue)
```
 >[!Note]
 > "/data" is an example of mount point used. Dependency failure for filesystem mount point will differ based on the  names used.

## Resolution
There are 2 ways to resolve the issue:
* Repair the VM online
    * [Use the Serial Console](#use-the-serial-console)
* Repair the vm offline
    * [Use Azure Linux Auto Repair (ALAR)](#use-azure-linux-auto-repair-alar)
    * [Use Manual Method](#use-manual-method)

### Repair the VM Online
#### Use the serial console
1. Connect to [the serial console](./serial-console-linux.md) of the VM from Azure portal.
2. Manual access to single user mode is required to reconfigure fstab. The steps can vary based on the type of Linux OS in use and access to the root account. Follow [single user mode](serial-console-grub-single-user-mode.md) documentation to access single user mode for each supported Linux partner images.

##### Fstab troubleshooting steps
1. Once the vm has booted into single user mode. Use your favorite text editor to open the fstab file.

   ```
   vi /etc/fstab
   ```
2. Review the listed filesystems in `/etc/fstab`. Each line in the fstab file indicates a filesystem that is mounted when the VM starts. For more information about the syntax of the fstab file, run the `man fstab` command. To troubleshoot a boot failure, review the entry for the filesystem that failed to mount. It is a good practice to review each line to ensure that it is correct in both structure and content.  Few points to consider to correctly administer an fstab file are as follows:

   * Fields on each line are separated by tabs or spaces. Blank lines are ignored. Lines that have a number sign (#) as the first character are comments. Commented lines can remain in the fstab file, but they won't be processed. We recommend that you comment fstab lines that you are unsure about instead of removing the lines.
   * Mount the data disks on Azure VMs by using the UUID of the file system partition.To determine the UUID of the file system, run the `blkid` command. For more information about the syntax, run the `man blkid` command. Example of UUID entry in fstab file:

      ```bash
      UUID=<UUID number here>  /data      xfs    defaults,nofail 0  0
      ```
   * Use the `nofail` option in the filesystem entries (data disks) to enable startup to continue even after errors occur in partitions for the corresponding entries. The `nofail` option helps make sure that the VM starts even if the file system is corrupted or if it doesn't exist at startup.

5. Save the changes to the fstab file.

6. Use `mount -a` as a best practice after making changes to the fstab entries. This will rerun the fstab configuration and notify the users of any existing syntax or entry errors.

6. Once, the syntax and entries are verified, reboot the vm using the below command.

   ```
   reboot -f
   ```
7. If the entries comment or fix was successful, the system should reach a bash prompt in the portal. Check whether you can connect to the VM.
> [!Note]
   > You can also use "ctrl+x" command which would also reboot the vm.

### Repair the VM offline

If the VM serial console access is not available, an alternative solution is to repair the vm offline. There are two ways to take an offline approach: 

#### Use Azure Linux Auto Repair (ALAR)

Azure Linux Auto Repair (ALAR) scripts is a part of VM repair extension described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md). ALAR covers automation of multiple repair scenarios including `/etc/fstab` issues.

The ALAR scripts use the repair extension `run` command and its `--run-id` option. The script-id for the automated recovery is: **linux-alar2**. Implement the following steps to automate fstab errors via offline ALAR approach:

```azurecli-interactive
az vm repair create --verbose -g centos7 -n cent7 --repair-username rescue --repair-password 'password!234' --copy-disk-name  repairdiskcopy
 ```

```azurecli-interactive
az vm repair run --verbose -g centos7 -n cent7 --run-id linux-alar2 --parameters fstab --run-on-repair
 ```

```azurecli-interactive
az vm repair restore --verbose -g centos7 -n cent7
 ``` 

> [!Note] 
   >The resource group name "centos7, vm name "cent7", and --copy-disk-name "repairdiskcopy" are examples and the values need to change accordingly.

   >The fstab repair script will take a backup of the original file and strip off any lines in the /etc/fstab file which are not needed to boot a system. After successful start of the OS, edit the fstab again and correct any errors which didn’t allow a reboot of the system before. 

Alternatively, once a repair vm is created, the changes can also be implemented by manually logging into the repair vm, mounting the attached copy of OS disk and making changes to its fstab file. Follow the steps here: 
 * Create a repair VM using the `az vm repair create` command.
 * In order to mount and chroot to the filesystems of the attached OS disk in a rescue VM, follow the detailed [chroot instructions](./chroot-environment-linux.md).
 * Next, follow the same [fstab troubleshooting steps](#fstab-troubleshooting-steps) as above.
 * Once the changes are applied, `az vm repair restore` command can be used to perform automatic OS disk swap with the original VM. 

#### Use Manual Method

If both serial console and ALAR approach is not possible or fails , the repair has to be performed manually. Follow the steps here to manually attach the OS disk to a recovery VM and swap the OS disk back to the original VM:
* [Attach the OS disk to a recovery VM using the Azure portal](./troubleshoot-recovery-disks-portal-linux.md)
* [Attach the OS disk to a recovery VM using Azure CLI](./troubleshoot-recovery-disks-linux.md)

Once the OS disk is successfully attached to the recovery VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) to mount and chroot to the filesystems of the attached OS disk. Then, implement [fstab troubleshooting steps](#fstab-troubleshooting-steps) to make appropriate changes to the fstab file of the problematic OS disk.


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
