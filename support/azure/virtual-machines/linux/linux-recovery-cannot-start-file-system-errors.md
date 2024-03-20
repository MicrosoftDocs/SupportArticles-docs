---
title: Troubleshoot Linux VM boot issues due to filesystem errors
description: Describes how to troubleshoot Linux VM not starting issues that are caused by filesystem errors.
services: virtual-machines
documentationcenter: ''
author: genlin
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
ms.date: 07/19/2022
ms.author: genli
---
# Troubleshoot Linux virtual machine boot issues due to filesystem errors

This article provides guidance to troubleshoot Linux virtual machine (VM) boot issues caused by filesystem errors.

## Symptoms

You can't connect to an Azure Linux virtual machine (VM) by using the Secure Shell Protocol (SSH), or the VM Agent status in the [Azure portal](https://portal.azure.com/) isn't **Ready**. When you run the [Boot diagnostics](../virtual-machines/windows/boot-diagnostics.md) in the Azure portal or connect to the [Serial Console](serial-console-linux.md), you see log entries that resemble the following examples:

> [!NOTE]
>
> - Not all examples will be present.
> - A mounting failure doesn't always result in a VM entering emergency mode. If the issue is with certain critical filesystems, the VM may not use emergency mode.

### Example 1: Fail to mount ext4 filesystem

```output
EXT4-fs (sda1): INFO: recovery required on readonly filesystem
EXT4-fs (sda1): write access will be enabled during recovery
EXT4-fs warning (device sda1): ext4_clear_journal_err:4531: Filesystem error recorded from previous mount: IO failure
EXT4-fs warning (device sda1): ext4_clear_journal_err:4532: Marking fs in need of filesystem check.
```

### Example 2: Fail to mount ext Logical Volume Manager (LVM) device

```output
[   14.382472] EXT4-fs error (device dm-0): ext4_iget:4398: inode #8: comm mount: bad extra_isize 4060 (inode size 256)
[   14.389648] EXT4-fs (dm-0): no journal found
<snipped>
[FAILED] Failed to mount /opt/data.
```

### Example 3: Fail to mount xfs filesystem

```output
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
[DEPEND] Dependency failed for Local filesystems.
```

### Example 4: Boot into emergency mode

```output
You are in emergency mode. After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or "exit"
to boot into default mode.
Give root password for maintenance
(or press Control-D to continue):
```

## Cause

The log entries above indicate disk corruption. In certain situations, disk corruption will prevent the VM from fully booting. Various issues can cause disk corruption, such as Linux kernel problems, driver errors, errors in the underlying physical or virtual hardware, and so on.

## Resolution

To resolve the Linux VM boot issues caused by filesystem errors, recover the VM by repairing the disk corruption. To repair the disk corruption, follow these steps:

1. [Identify which disk is corrupted](#identify-which-disk-is-corrupted).
2. [Identify filesystem type](#identify-filesystem-type).
3. [Select recovery mode (online or offline)](#select-recovery-mode).
4. Prepare the recovery environment according to the recovery mode you select:
    - [Prepare environment for online recovery](#prepare-environment-for-online-recovery)
    - [Prepare environment for offline recovery](#prepare-environment-for-offline-recovery)
5. Use command-line tools to [repair the problematic filesystem](#perform-filesystem-repair) on the disk.
    - [Repair ext4 filesystem](#repair-ext4-filesystem)
    - [Repair xfs filesystem](#repair-xfs-filesystem)

    > [!NOTE]
    >
    > - It's important to back up critical data because data loss may occur on the recovered disk.
    > - Before you make changes to a disk, take a snapshot to preserve the current state of the disk, even if it's in an error state. Fixing the disk corruption will change the data on the disk, which will carry risk.

### <a id="identify-which-disk-is-corrupted"></a>Identify which disk is corrupted

To determine which disk is corrupted, download the serial log for your VM by using the Serial Console or Boot diagnostics, examine the log entries during boot up, and then look for the specific error calling out which disk or mount is failing.

Here are three log entry examples. In these examples, note the text in parenthesis, which reports the corrupted device.

In the following example, the corrupted device is `sdc1`:

```output
[   14.285807] XFS (sdc1): Mounting V5 Filesystem
[   14.426283] XFS (sdc1): Metadata CRC error detected at xfs_agi_read_verify+0xde/0x100 [xfs], xfs_agi block 0x10
[   14.426284] XFS (sdc1): Unmount and run xfs_repair
<snipped>
[FAILED] Failed to mount /opt/parent.
```

In the following example, the partition where a filesystem error occurs is `sda1`:

```output
EXT4-fs (sda1): INFO: recovery required on readonly filesystem
EXT4-fs (sda1): write access will be enabled during recovery
EXT4-fs warning (device sda1): ext4_clear_journal_err:4531: Filesystem error recorded from previous mount: IO failure
EXT4-fs warning (device sda1): ext4_clear_journal_err:4532: Marking fs in need of filesystem check.
<snipped>
[FAILED] Failed to mount /boot.
```

In the following example, the corrupted device is `dm-2`. It's a Linux Device Mapper device, which indicates an LVM volume.

```output
[   18.014318] EXT4-fs (dm-2): VFS: Can't find ext4 filesystem
[FAILED] Failed to mount /home.
See 'systemctl status home.mount' for details.
[DEPEND] Dependency failed for Local File Systems.
[DEPEND] Dependency failed for Mark the need to relabel after reboot.

```

If the disk device being called out uses a name of the format "sdXN" where X is a letter from a-z and N is an optional partition number, it means that the disk is raw and can be operated on by using the */dev/sdXN* path.

If the disk device being mounted uses a name such as */dev/mapper/vgname/lvname*, */dev/vgname/lvname*, or *dm-N*, it means that an LVM device is used. Take care to recognize all disk physical volumes (PVs) which may be in use.

It's not supported for the LVM volume group (VG) to contain the OS disk and any number of data disks. For such a scenario, there's a high risk of data loss. However, multiple data disks are permissible in an LVM VG.

When determining the mapping of OS disk references to Azure disk objects:

- For marketplace images, the root filesystem (/), */boot* and */boot/efi* is located on the OS disk.
- For LVM based images, many other system mounts may exist such as */home*, */tmp*, */usr*, */var*, */var/log*, and */opt*.
- Extra filesystems created for applications are located on data disks, for example, */data*, */datadisk*, or */sap*. Configure them properly so that the system can boot even if there's an error. If a data disk is a device that boots into emergency mode, see [prevent boot failure](#prevent-boot-failure).

### <a id="identify-filesystem-type"></a>Identify filesystem type

While doing initial identification, the only method to determine the disk type is using the serial log as previously examined in [Identify which disk is corrupted](#identify-which-disk-is-corrupted). When the disk device is reported in the serial log, errors will be displayed from the Linux kernel module for the filesystem. Note each line where `EXT4-fs` or `XFS` is specified. For any other filesystem types, the log is in the same area. The filesystem noted in the log entries is determined by the */etc/fstab* file. Take care to verify that the specified format is correct when performing a repair.

Once you have access to an interactive shell, run the `lsblk` command with the `-f` flag as follows to show devices, paths (if the filesystem is mounted), and the filesystem type that's read from the disk itself.

```bash
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

Here are some important points in the output:

- By using the ASCII art display, you can see that there are LVM volumes present because there's an LVM2_MEMBER FSTYPE for sda4 containing objects with names such as `rootvg-rootlv` and `rootvg-homelv`.
- `rootvg-homelv` isn't mounted, which is denoted by the empty MOUNTPOINT field.
- `rootvg-homelv` has filesystem type XFS. It's a contrast with the EXT4 mount error during booting up. If the filesystem type is inconsistent, trust the `lsblk` output rather than the contents of fstab.

### <a id="select-recovery-mode"></a>Select recovery mode

You can recover a VM online through emergency mode or single-user mode or offline by using a rescue VM.

#### Requirements for online recovery

- The [Serial Console](serial-console-linux.md) access to the VM.

- If emergency mode is used, the Serial Console must display an emergency mode prompt, the root account must be unlocked, and the password must be known.
  
- If single-user mode is used, the root password isn't needed. The single-user mode may be used when a filesystem other than required system partitions such as root (`/`) or `/usr` is corrupted.

#### Requirements for offline recovery

If the Serial Console requirements for online recovery can't be met, perform offline recovery by using a rescue VM. To perform offline recovery, the ability to create a VM and manage disks in Azure is required. Alternatively, you can use a functioning Linux VM with Azure-level access to the corrupted disks.

### <a id="prepare-environment-for-online-recovery"></a>Prepare environment for online recovery

When the emergency mode is displayed in the sign-in prompt as follows, enter the root password:

```output
Welcome to emergency mode! After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or ^D to
try again to Give root password for maintenance
(or press Control-D to continue):
```

If the root password isn't known, or the root account is locked, as in the following output, use [single-user mode](serial-console-grub-single-user-mode.md):

```output
Welcome to emergency mode! After logging in, typ
Cannot open access to console, the root account is locked.
See sulogin(8) man page for more details.

Press Enter to continue.
```

If the online recovery environment is unusable, proceed to offline recovery.

### <a id="prepare-environment-for-offline-recovery"></a>Prepare environment for offline recovery

In single disk VMs, or when the failing mount is a system partition such as the root filesystem (`/`) or `/usr`, the most reliable method to repair the disk is by using a rescue VM to gain access to the disk. You can create a rescue VM automatically or manually.

For automated creation of a rescue VM, see [Azure Virtual Machine Repair](repair-linux-vm-using-azure-virtual-machine-repair-commands.md). For manual creation of a rescue VM, see [creating a recovery VM](troubleshoot-recovery-disks-portal-linux.md). In either case, don't mount the volumes from the problem disk because a filesystem must not be mounted for repair utilities to operate.

### <a id="perform-filesystem-repair"></a>Perform filesystem repair

Before repairing the filesystem, ensure that the following steps have been completed:

- The problem disk and partition, or LVM volume structure, has been identified.
- The filesystem type has been determined.
- (Optional) A copy of the problem disk, or disks in a spanned LVM volume group, has been attached to a rescue VM.
- Access to an interactive shell has been secured by using access to the disk.

To perform the filesystem repair, go to [Repair ext4 filesystem](#repair-ext4-filesystem) or [Repair XFS filesystem](#repair-xfs-filesystem) according to the filesystem type.

No matter what recovery mode is used, the commands to perform the filesystem repair are the same. The emergency shell may have limitations. If the commands aren't available in an emergency mode environment, or there are errors about unknown filesystem types, [prepare environment for offline recovery](#prepare-environment-for-offline-recovery).

The commands to repair the filesystem may not fix all errors. They work around disk corruptions, but data loss still may occur. Once the command output states that the filesystem is clean, reassemble the original VM with the repaired disk, and boot the VM to verify data.

In the following sections, `/dev/sdc1` is the corrupted filesystem in raw mode, and the LV `homelv` in the VG `rootvg` is the LVM volume. Substitute these values for the actual corrupted filesystem in all instances.

#### <a id="repair-ext4-filesystem"></a>Repair ext4 filesystem

Use the `fsck [-y] FILESYSTEM` command to repair an ext4 filesystem. Specify the filesystem as a disk partition for a raw filesystem, for example `/dev/sdc1`, or the LVM logical volume path `/dev/rootvg/homelv`.

Here's a command output example:

```output
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

The output shows that the confirmation to modify the filesystem is requested three times. If there are many requests, press CTRL+C and restart `fsck` with the `-y` flag to assume "yes" to all questions. If any files are reported as being placed in `lost+found`, manually identify them and place them in proper locations.

If some errors occur and are subsequently fixed, run the `fsck` command again. Repeat until the `fsck` command exits with the `clean` status. Refer to the following output as an example:

```output
[root@vm1dev ~]# fsck /dev/sdc1
fsck from util-linux 2.23.2
e2fsck 1.42.9 (28-Dec-2013)
/dev/sdc1: clean, 11/2097152 files, 176706/8388352 blocks
[root@vm1dev ~]#
```

#### <a id="repair-xfs-filesystem"></a>Repair xfs filesystem

Here are commands to repair an XFS filesystem:

- `xfs_repair [-n] FILESYSTEM`
- `xfs_repair [-L] FILESYSTEM`
- `mount FILESYSTEM MOUNTPOINT`

To repair an XFS filesystem, follow these steps:

1. Check filesystem errors by using the `xfs_repair -n` command, as follows:

   ```bash
   xfs_repair -n /dev/rootvg/homelv
   ```

2. If the check succeeds, continue with the repair mode by removing the `-n` flag, which will try to fix any encountered errors, as follows:

   ```bash
   xfs_repair /dev/rootvg/homelv
   ```

For XFS filesystems, journaled but uncommitted changes are dealt with by mounting the filesystem. If you encounter the following error during the troubleshooting, attempt a mount and view the results.

> ERROR: The filesystem has valuable metadata changes in a log which needs to be replayed

If a recovery VM is used, create a directory for a temporary mount point, such as `/recovery`, and mount the filesystem. If the recovery environment is in emergency or single-user mode, mount the filesystem on its intended location. Refer to the following commands as examples:

```bash
mount /dev/rootvg/homelv /recovery
```

or

```bash
mount /home
```

If the journaled changes aren't written when you mount filesystems, use the `-L` flag to discard the journal and mount the filesystem as if all changes are successfully completed. When the `-L` flag is used, data loss will occur because the log shows incomplete file operations are being discarded.  

```bash
xfs_repair -L /dev/rootvg/homelv /recovery
```

### <a id="prevent-boot-failure"></a>Prevent boot failure

If the `nofail` option is specified when mounting filesystems, the corruption of a non-critical filesystem may not prevent Linux from booting fully. For more information about `nofail`, see [Mount the disk](/azure/virtual-machines/linux/attach-disk-portal#mount-the-disk). Most mounts aside from the root (`/`), `/usr`, and `/var` can be done with `nofail`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
