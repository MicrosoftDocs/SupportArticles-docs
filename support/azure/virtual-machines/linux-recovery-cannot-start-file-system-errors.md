---
title: Troubleshoot Linux VM startup issues due to file system errors | Microsoft Docs
description: Learn how to troubleshoot Linux VM not starting due to file system errors
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: ''
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 19/07/2022
ms.author: v-six

---

# Troubleshoot Linux VM startup issues due to file system errors

You cannot connect to an Azure Linux virtual machine (VM) by using Secure Shell (SSH) or the Agent status in the Azure portal is not ready. When you run the Boot Diagnostics feature on [Azure portal](https://portal.azure.com/) or connect to the [Serial Console](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/serial-console-linux), you see log entries that resemble the following examples.  Note that all examples do not have to be present, and a failure to mount does not always result in a VM entering emergency mode. Also, the VM may not be able to utilize emergency mode if the issue was with certain critical filesystems.

## Examples

### Failure to mount ext4 filesystem

```
EXT4-fs (sda1): INFO: recovery required on readonly filesystem
EXT4-fs (sda1): write access will be enabled during recovery
EXT4-fs warning (device sda1): ext4_clear_journal_err:4531: Filesystem error recorded from previous mount: IO failure
EXT4-fs warning (device sda1): ext4_clear_journal_err:4532: Marking fs in need of filesystem check.
```

### Failure to mount an ext LVM device

```
[   14.382472] EXT4-fs error (device dm-0): ext4_iget:4398: inode #8: comm mount: bad extra_isize 4060 (inode size 256)
[   14.389648] EXT4-fs (dm-0): no journal found
<snipped>
[FAILED] Failed to mount /opt/data.
```

### Failure to mount xfs filesystem

```
[    8.543984] XFS (sdc1): Metadata CRC error detected at xfs_agi_read_verify+0xd0/0xf0 [xfs], xfs_agi block 0x10
[    8.553867] XFS (sdc1): Unmount and run xfs_repair
[    8.558993] XFS (sdc1): First 128 bytes of corrupted metadata buffer:
[    8.564893] 00000000: 58 41 47 49 00 00 00 01 00 00 00 00 00 1f ff c0  XAGI............
[    8.572847] 00000010: 00 00 00 40 00 00 00 06 00 00 00 01 00 00 00 3d  ...@...........=
[    8.580476] 00000020: 00 00 00 60 ff ff ff ff ff ff ff ff ff ff ff ff  ...`............
[    8.588219] 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[    8.596280] 00000040: ff 07 f8 ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[    8.603575] 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[    8.610849] 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[    8.619261] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[    8.629731] XFS (sdc1): metadata I/O error in "xfs_trans_read_buf_map" at daddr 0x10 len 8 error 74
[    8.637799] XFS (sdc1): xfs_imap_lookup: xfs_ialloc_read_agi() returned error -117, agno 0
[FAILED] Failed to mount /data.
See 'systemctl status data.mount' for details.
[DEPEND] Dependency failed for Local File Systems.

```

### Booting to Emergency mode

```
You are in emergency mode. After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or "exit"
to boot into default mode.
Give root password for maintenance
(or press Control-D to continue):
```

## Cause

Generally speaking, the errors above are describing a disk corruption, which in certain situations will not allow the VM to fully boot.  Corruption can occur due to a variety of issues such as Linux kernel problems, driver errors, errors in the underlying physical or virtual hardware, etc.. The purpose of this document is not to determine the reason for the corruption, but to repair the corruption to recover the VM as much as possible.  There are also some configuration changes that may allow a VM to continue to boot if certain conditions are met, allowing for easier remediation.

> [!NOTE]
> It is always important to have a backup of critical data. The tools described in this article may help to repair file systems to the point of being usable, but there is still a possibility that data loss will occur on the recovered disk.

## Resolution

The general procedure to resolving a disk corruption leading to boot error can be described in the following steps

1. [Identify the corruption](#identifying-the-corruption)
    1. [Determine the disk which is in an error state](#determine-erroring-disk).
    1. [Identify filesystem type](#identifying-the-filesystem-type)
1. [Identify if online (emergency mode) or offline (recovery VM) will be used.](#selection-of-recovery-mode)
1. Prepare the recovery environment
    * [Online](#online-recovery) via Emergency mode or Single user
    * [Offline / Rescue VM](#offline-rescue-vm-recovery)
1. Execute the specific tool for the problematic filesystem on the disk.
    * [EXT4](#repairing-ext4-filesystems)
    * [XFS](#repairing-xfs-filesystems)

> [!NOTE]
> Before making any modifications to a disk, a snapshot should be taken to preserve the current state of the disk, even if it is in error.  The very nature of fixing disk corruption will change the data on the disk and therefore carries risk.

### Identifying the corruption

#### Determine erroring disk

Using the Serial Console, or [Boot diagnostics](https://docs.microsoft.com/azure/virtual-machines/boot-diagnostics) for your VM to download the serial log, examine the messages during boot up and look for the specific error calling out which disk or mount which is failing.  In the following three examples, note the text in parenthesis, as this is where the device will be reported

In this example the device is `sdc1`:

```
[   14.285807] XFS (sdc1): Mounting V5 Filesystem
[   14.426283] XFS (sdc1): Metadata CRC error detected at xfs_agi_read_verify+0xde/0x100 [xfs], xfs_agi block 0x10
[   14.426284] XFS (sdc1): Unmount and run xfs_repair
<snipped>
[FAILED] Failed to mount /opt/parent.
```

The partition containing a filesystem error in this example is `sda1`

```
EXT4-fs (sda1): INFO: recovery required on readonly filesystem
EXT4-fs (sda1): write access will be enabled during recovery
EXT4-fs warning (device sda1): ext4_clear_journal_err:4531: Filesystem error recorded from previous mount: IO failure
EXT4-fs warning (device sda1): ext4_clear_journal_err:4532: Marking fs in need of filesystem check.
<snipped>
[FAILED] Failed to mount /boot.
```

In this case, the device `dm-2` is a Linux Device Mapper device, which usually indicates an LVM volume

```
[   18.014318] EXT4-fs (dm-2): VFS: Can't find ext4 filesystem
[FAILED] Failed to mount /home.
See 'systemctl status home.mount' for details.
[DEPEND] Dependency failed for Local File Systems.
[DEPEND] Dependency failed for Mark the need to relabel after reboot.

```

If the disk being called out uses a name of the format `sdXN` where X is a letter(s) from a-z and N is an optional partition number, then the disk is said to be 'raw' and can be operated on using the /dev/sdXN path.  If the disk device being mounted uses a name such as /dev/mapper/vgname/lvname, /dev/vgname/lvname, or dm-N, then LVM is being utilized and care must be taken to recognize all disk physical volumes (PVs) which may be in use.  If the LVM volume group (VG) contains the OS disk and any number of data disks, this is an unsupported scenario and there is a high risk of data loss.  Multiple data disks are permissible in an LVM VG, however.

> [!TIP]
>
> When determining the mapping of OS disk references to Azure disk objects, for marketplace images, the root filesystem (`/`), `/boot` and `/boot/efi` will be located on the OS disk.  For LVM based images, a number of other system mounts **may** exist such as `/home`, `/tmp`, `/usr`, `/var`, `/var/log`, `/opt` to name a few.  Extra filesystems created for applications should be located on data disks, for example `/data`, `/datadisk`, or `/sap`, and ideally should be configured in a way that they do not cause the system to fail to boot if there is an error.  Please see the section on [preventing boot failures](#preventing-a-boot-failure) if a data disk is found to be the source of booting to emergency mode.

#### Identifying the filesystem type

While doing initial identification, the only method to determine the disk type will be by using the logging as previously examined.  The error messages will be displayed from the Linux kernel module for the filesystem, at the time that the device is reported.  Examine the [previous examples](#determine-erroring-disk) and note on each line where either `EXT4-fs` or `XFS` is specified.  In case of any other filesystem types, the logging should be in the same area.

>[!NOTE] The filesytem noted in these log entries will be determined by the `/etc/fstab` file.  Care must be taken to verify that the specified format is correct when attempting to perform a repair.

Once access is gained to an interactive shell, running the `lsblk` command with the `-f` flag will show devices, paths if mounted, as well as the filesystem type as is read from the disk itself.

```
[root@localhost ~]# lsblk -f
NAME              FSTYPE      LABEL UUID                                   MOUNTPOINT
sda
|-sda1            vfat              93DA-8C20                              /boot/efi
|-sda2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
|-sda3
`-sda4            LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
  |-rootvg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
  |-rootvg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
  |-rootvg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
  |-rootvg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0
  |-rootvg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
  `-rootvg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
sdb
`-sdb1            ext4              1dac7c4c-bf8e-4964-8a59-7359eef53d0a   /mnt
sdc               LVM2_member       CRWEZQ-iLhH-ev0b-BAaA-dfLD-nbPT-GgtG0r
`-vgapp-lvapp     xfs               733e25ee-565f-4bfa-a2a1-2451efd25cd1
sdd
`-sdd1            ext4              704d9fb1-2207-4bb9-998c-029f776dc6d2   /opt/data
```

There are several important areas of this output

* Using the ASCII art display,  we see that there are LVM volumes present, because there is an LVM2_MEMBER FSTYPE for sda4 containing objects with names such as `rootvg-rootlv` and `rootvg-homelv`
* rootvg-homelv is not mounted, denoted by the empty MOUNTPOINT field
* rootvg-homelv has filesystem type XFS.  This is a contrast with boot time mount message for an EXT4 error.  In cases of inconsistency of filesystem type such as this, trust the `lsblk` output over the contents of fstab.

#### Selection of recovery mode

In order to fix any of the issues presented, the following capabilities may be required, which of the following may direct the recovery mode being used
* [Serial console](./serial-console-linux.md) access to the VM to interact with the running VM
* In order to use online recovery, the serial console must be displaying an emergency mode prompt, the root account must be unlocked, and the password must be known. 
  * Alternatively the root password is not needed for [single user mode](serial-console-grub-single-user-mode.md) via serial console. This may be used in cases of corruption to a filesystem other than required system partitions such as root (`/`) or `/usr`, for example
* In the case where the serial console requirements are not met, a rescue VM will need to be utilized.  The ability to create a VM and manage disks in the Azure subscription will be required.  
  * As an alternative to creating a new rescue VM, a functioning Linux VM with Azure-level access to the corrupted disks can be used.

#### Prepare the recovery environment

##### Online recovery

In the case where emergency mode is being displayed with the login prompt, as below, simply enter the root password

```
Welcome to emergency mode! After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or ^D to
try again to Give root password for maintenance
(or press Control-D to continue):
```

If the root password is not known, or the root account is locked, as in the following output, [single user mode](serial-console-grub-single-user-mode.md) can be used

```
Welcome to emergency mode! After logging in, typ
Cannot open access to console, the root account is locked.
See sulogin(8) man page for more details.

Press Enter to continue.
```

If all of these options fail or are unusable for any reason, proceed to offline recovery.

##### Offline (Rescue VM) recovery

In single disk VMs, or when the failing mount is a system partition such as the root filesystem (`/`) or `/usr`, the most reliable method to repair the disk is by using a recovery VM to gain access to the disk.  
* For automated creation of the recovery VM - reference the [Azure Virtual Machine Repair](https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/repair-linux-vm-using-azure-virtual-machine-repair-commands) utility 
* For manual instructions on [creating a recovery VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux) 

>[!NOTE] In either case, do not mount the volumes from the problem disk as a filesystem must not be mounted for repair utilities to operate.

#### Perform filesystem repairs

At this point, the following steps should have been completed

* Problem disk and partition, or LVM volume structure, has been identified
* Filesystem type has been determined
* Optional: A copy of the problem disk, or disks in the case of a spanned LVM volume group, has been attached to a rescue VM
* Access to an interactive shell has been secured with access to the disk

The following commands should be the same regardless of the recovery mode being employed.  If commands are not found in an emergency mode environment, or there are errors regarding unknown filesystem types, follow the [rescue VM](#offline-rescue-vm-recovery) methodology, as the emergency shell may have limitations.

>[!IMPORTANT]All repair tools are best effort, and generally work well, however it is possible that they may not be able to fix all errors.  Even in cases where the tools are able to work around corruptions, the chance for data loss must not be overlooked.  Once the tools below have completed their checks and state that the filesystem is clean, reassemble the original VM with the repaired disks if necessary, and attempt to boot the VM to verify data.

For the following examples, `/dev/sdc1` will be the corrupt filesystem in raw mode, and the LV `homelv` in VG `rootvg` will be the LVM volume.  Substitute these values for the actual corrupted filesystem in all instances.

##### Repairing ext4 filesystems

Commands:

* `fsck [-y] FILESYSTEM`

Repairing an ext4 filesystem is handled by the fsck tool, with the only required argument being the filesystem needing to be checked.  Specify the filesystem as either a disk partition for a raw filesystem, for example `/dev/sdc1`, or the LVM logical volume path `/dev/rootvg/homelv`

In the below output it can be seen that confirmation to modify the filesystem was requested 3 times, if there are many requests, press CTRL+c and restart `fsck` with the `-y` flag to assume yes to all questions.  In general there are likely to be no better alternatives than to accept the suggestions, but being aware of the changes is a good practice.  Also, be aware if any files are reported as being placed in `lost+found` as these are misplaced files which will need to be manually identified and placed in the proper locations.

If errors are encountered and subsequently fixed, run fsck again.  Repeat until the fsck command exits with `clean` status.

```
[root@vm1dev ~]# fsck /dev/sdc1
fsck from util-linux 2.23.2
e2fsck 1.42.9 (28-Dec-2013)
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext4: Group descriptors look bad... trying backup blocks...
/dev/sdc1 was not cleanly unmounted, check forced.
Resize inode not valid.  Recreate<y>? yes
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #0 (23508, counted=23509).
Fix<y>? yes
Free blocks count wrong (8211645, counted=8211646).
Fix<y>? yes

/dev/sdc1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sdc1: 11/2097152 files (0.0% non-contiguous), 176706/8388352 blocks
[root@vm1dev ~]#
```

```
[root@vm1dev ~]# fsck /dev/sdc1
fsck from util-linux 2.23.2
e2fsck 1.42.9 (28-Dec-2013)
/dev/sdc1: clean, 11/2097152 files, 176706/8388352 blocks
[root@vm1dev ~]#
```

##### Repairing XFS filesystems 

Commands:
    - `xfs_repair [-n] FILESYSTEM`
    - `xfs_repair [-L] FILESYSTEM`
    - `mount FILESYSTEM MOUNTPOINT`

* Start by checking the filesystem for errors using `xfs_repair` with the `-n` flag.

   ```
   xfs_repair -n /dev/rootvg/homelv
   ```

* If the check succeeds, continue with the repair mode, by removing the `-n` flag, which will attempt to fix any encountered errors.

   ```
   xfs_repair /dev/rootvg/homelv
   ```

* For XFS filesystems, journaled but uncommitted changes are dealt with by mounting the filesystem. If the following message is encountered during the course of this troubleshooting, attempt a mount and view the results.

   `ERROR: The filesystem has valuable metadata changes in a log which needs to be replayed`

* In the case of a recovery VM, create a directory for a temporary mount point, such as `/recovery`, and mount the filesystem.  If the environment is in emergency or single-user mode, simply mount the filesystem on its intended location

    ```
    mount /dev/rootvg/homelv /recovery
    ```

    or

    ```
    mount /home
    ```

* As a last resort, if the mounting of the filesystem returns an error and fails to write the journaled changes, the `-L` flag can be used to discard the journal and mount the filesystem as if all changes were successfully completed.

    ```
    xfs_repair -L /dev/rootvg/homelv /recovery
    ```

> [!NOTE]
> There will be data loss which occurs when using the -L flag, as the contents of the log are incomplete file operations, which are being discarded.  

### Preventing a boot failure

Corruption of a non-critical filesystem does not have to be a situation that prevents Linux from booting fully, if the `nofail` is specified when mounting the filesystems.  Please reference the [Linux data disk documentation](https://docs.microsoft.com/azure/virtual-machines/linux/attach-disk-portal#mount-the-disk) for usage of the `nofail` option.  Most mounts aside from the root (`/`), `/usr`, and `/var` can be mounted with nofail.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
