---
title: Unable to resize MBR partition with more than 2 TB on Data Disk in a Linux virtual machine
description: How to change the partition type from MBR to GPT.
author: brfett
ms.author: brfett
ms.service: virtual-machines
ms.topic: how-to #Don't change
ms.date: 04/14/2024
---
# Unable to resize a data disk MBR partition with more than 2 TB in a Linux virtual machine

## Environment

ALL Linux Distribution's

> [!IMPORTANT]
> Disclaimer! This could only be done in a data disk, not an OS disk. If this is done is an OS disk, this will end up in a no boot situation.  
> This document covers supported [Endorsed Linux distros](/azure/virtual-machines/linux/endorsed-distros).  
> Red Hat created on 11 September 2022 the following article mentioning that it isn't possible to convert msdos to gpt label without losing data. Refer: https://access.redhat.com/solutions/1261843. This document is for best effort only the other option is to take a full backup of the data on the disk and recreate gpt partition table instead.


## Problem Description

Unable to resize an MBR partition for a data disk with a size bigger than 2 TB
  
Refer to the below WARNING message when we use fdisk command to resize the partition.

> [!IMPORTANT]
> The size of this disk is 8.8 TB. DOS partition table format can't be used on drives for volumes larger than 2 TB for 512-byte sectors. Use parted(1) and GUID partition table format (GPT).

  ```bash
  sudo fdisk /dev/sdd
  ```
  ```outputs
  WARNING: The size of this disk is 8.8 TB (8796093022208 bytes).
  DOS partition table format can not be used on drives for volumes
  larger than (2199023255040 bytes) for 512-byte sectors. Use parted(1) and GUID
  partition table format (GPT).

  The device presents a logical sector size that is smaller than
  the physical sector size. Aligning to a physical sector (or optimal
  I/O) size boundary is recommended, or performance may be impacted.
  Welcome to fdisk (util-linux 2.23.2).

  Changes will remain in memory only, until you decide to write them.
  Be careful before using the write command.

  Command (m for help):

  Command (m for help): d
  Selected partition 1
  Partition 1 is deleted

  Command (m for help): n
  Partition type:
     p   primary (0 primary, 0 extended, 4 free)
     e   extended
  Select (default p): p
  Partition number (1-4, default 1): 1
  First sector (2048-4294967295, default 2048):
  Using default value 2048
  Last sector, +sectors or +size{K,M,G} (2048-4294967294, default 4294967294):
  Using default value 4294967294
  Partition 1 of type Linux and of size 2 TiB is set   <--- HERE

  Command (m for help): p

  Disk /dev/sdd: 8796.1 GB, 8796093022208 bytes, 17179869184 sectors
  Units = sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 4096 bytes
  I/O size (minimum/optimal): 4096 bytes / 4096 bytes
  Disk label type: dos
  Disk identifier: 0x7024d1b6

     Device Boot      Start         End      Blocks   Id  System
  /dev/sdd1            2048  4294967294  2147482623+  83  Linux

  Command (m for help): w
  The partition table has been altered!

  Calling ioctl() to re-read partition table.

  WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
  The kernel still uses the old table. The new table will be used at
  the next reboot or after you run partprobe(8) or kpartx(8)
  Syncing disks.
  ```

  ```bash
  sudo partprobe /dev/sdd
  ```

  Checking the new size for partition /dev/sdd1. It was resized only with 2 TB.

  ```bash
  sudo lsblk -o NAME,TYPE,FSTYPE,LABEL,SIZE,RO,MOUNTPOINT
  ```

  ```output
  NAME              TYPE FSTYPE      LABEL  SIZE RO MOUNTPOINT
  sda               disk                     32G  0
  ├─sda1            part vfat               500M  0 /boot/efi
  ├─sda2            part xfs                500M  0 /boot
  ├─sda3            part xfs                 31G  0 /
  └─sda4            part                      2M  0
  sdb               disk                    256G  0
  └─sdb1            part ext4               256G  0 /mnt
  sdd               disk                      8T  0
  └─sdd1            part ext4                 2T  0 /appext4
  ```

## Cause

The MBR, which contains the partition boundaries and partition (file system) type information, has an addressing limit of 2^32 sectors. It's this 32-bit address limitation within the MBR partition data structures that ultimately limits the size of the disk and partition.

With 512-byte sectors that is 2 TiB.

With newer 4Kn devices, the total would be 2^32 x 4,096 bytes per logical sector, or 16 TiB.


## Solution

GPT partition tables don't have this sector address limit and are recommended for disks that are 2 TiB and larger in size.

## How to change the partition type from MBR to GPT.

### Identify the current partition table type

> [!IMPORTANT] 
> Take a [snapshot](/azure/virtual-machines/snapshot-copy-managed-disk) of the Data disk before doing any change. 

To check if the current data disk is MBR or GPT, you can use any of the following utilities.

### [Using fdisk](#tab/fdisk)

 ```bash
 sudo fdisk -l /dev/sdd | grep -i type
 ```

 ```output
 Disk label type: dos
 ```

### [Using parted](#tab/parted)

 ```bash
 sudo parted /dev/sdd print | grep -i '^Partition Table'
 ```

 ```output
 Partition Table: msdos
 ```

### [Using gdisk](#tab/gdisk)

```bash
 sudo gdisk -l /dev/sdd | grep -A4 '^Partition table scan:'
```

```output
 Partition table scan: 
   MBR: MBR only
   BSD: not present
   APM: not present
   GPT: not present
 ```

---

> [!NOTE]
> In this Example we're going to use `gdisk` to recreate the partition

1. Install `gdisk` tool if not already installed in the Linux virtual machine:

### [Red Hat 7.x](#tab/rhel7)

```bash
sudo yum install gdisk -y
```

### [Red Hat 8.x/9.x](#tab/rhel89)

```bash
sudo dnf install gdisk -y
```

### [Ubuntu](#tab/ubuntu)

```bash
sudo apt -y install gdisk
```

### [SUSE](#tab/sles)

```bash
sudo zypper install gdisk
```

---

2. Verify the current size of the data disk

```bash
sudo gdisk -l /dev/sdd | grep Disk | grep sectors
```

```output
  Disk /dev/sdd: 17179869184 sectors, 8.0 TiB
```

3. Stop the application running on the Virtual Machine and unmount the filesystem

> [!NOTE]
> Both `myapp.service` and `/appext4` are sample entries.

```bash
sudo systemctl stop myapp.service
sudo umount /appext4
```

> [!NOTE]
> If you need to increase the size you can do it now through your account in Azure. A disk resize in the Azure portal will need downtime. Please review [How to expand data disk document](/azure/virtual-machines/linux/expand-disks?tabs=ubuntu#expand-an-azure-managed-disk)

4. Use `gdisk` to recreate the partition number 1

```bash
sudo gdisk /dev/sdd
```

```output
  GPT fdisk (gdisk) version 0.8.10
  Partition table scan:
    MBR: MBR only
    BSD: not present
    APM: not present
    GPT: not present
  ***************************************************************
  Found invalid GPT and valid MBR; converting MBR to GPT format
  in memory. THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by
  typing q if you dont want to convert your MBR partitions
  to GPT format!
  ***************************************************************
  Command (? for help): p                                                --> PRINT PARTITION TABLE
  Disk /dev/sdd: 17179869184 sectors, 8.0 TiB
  Logical sector size: 512 bytes
  Disk identifier (GUID): 8A3DAD49-6916-4BC5-836B-2F90C5161C05
  Partition table holds up to 128 entries
  First usable sector is 34, last usable sector is 17179869150
  Partitions will be aligned on 2048-sector boundaries
  Total free space is 12884903870 sectors (6.0 TiB)
  Number  Start (sector)    End (sector)  Size       Code  Name
     1            2048      4294967294   2.0 TiB     8300  Linux filesystem
  Command (? for help): d                                                --> DELETE PARTITION TABLE
  Using 1
  Command (? for help): n                                                --> CREATE NEW PARTITION TABLE
  Partition number (1-128, default 1):                                   --> PARTITION 1
  First sector (34-17179869150, default = 2048) or {+-}size{KMGTP}: 2048 --> SAME 1th SECTOR AS THE ORIGINAL PARTITION
  Last sector (2048-17179869150, default = 17179869150) or {+-}size{KMGTP}: --> HIT ENTER TO USE THE WHOLE SPACE, IN THIS CASE 8 TB
  Current type is 'Linux filesystem'
  Hex code or GUID (L to show codes, Enter = 8300):
  Changed type of partition to 'Linux filesystem'
  Command (? for help): p                                                --> PRINT PARTITION TABLE
  Disk /dev/sdd: 17179869184 sectors, 8.0 TiB
  Logical sector size: 512 bytes
  Disk identifier (GUID): 8A3DAD49-6916-4BC5-836B-2F90C5161C05
  Partition table holds up to 128 entries
  First usable sector is 34, last usable sector is 17179869150
  Partitions will be aligned on 2048-sector boundaries
  Total free space is 2014 sectors (1007.0 KiB)
  Number  Start (sector)    End (sector)  Size       Code  Name
     1            2048     17179869150   8.0 TiB     8300  Linux filesystem
  Command (? for help): w                                                  --> APPLY CHANGES
  Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
  PARTITIONS!!
  Do you want to proceed? (Y/N): Y                                          --> "Y" TO APPLY
  OK; writing new GUID partition table (GPT) to /dev/sdd.
  Warning: The kernel is still using the old partition table.
  The new table will be used at the next reboot.
  The operation has completed successfully.
```

5. Verify the partition. As we can see, GPT is presented now.

```bash
sudo gdisk -l /dev/sdd | grep -A4 '^Partition table scan:'
```

```output
  Partition table scan:
    MBR: protective
    BSD: not present
    APM: not present
    GPT: present    
```

```bash
sudo lsblk -o NAME,TYPE,FSTYPE,LABEL,SIZE,RO,MOUNTPOINT
```

```output
  NAME              TYPE FSTYPE      LABEL  SIZE RO MOUNTPOINT
  sda               disk                     32G  0
  ├─sda1            part vfat               500M  0 /boot/efi
  ├─sda2            part xfs                500M  0 /boot
  ├─sda3            part xfs                 31G  0 /
  └─sda4            part                      2M  0
  sdb               disk                    256G  0
  └─sdb1            part ext4               256G  0 /mnt
  sdd               disk                      8T  0
  └─sdd1            part ext4                 2T  0 /appext4
```

6. The filesystem was mounted automatically, In this case unmount the filesystem and run a `fsck`.

```bash
sudo umount /appext4
sudo fsck.ext4 -fy /dev/sdd1
```

```output
  e2fsck 1.42.9 (28-Dec-2013)
  Pass 1: Checking inodes, blocks, and sizes
  Pass 2: Checking directory structure
  Pass 3: Checking directory connectivity
  Pass 4: Checking reference counts
  Pass 5: Checking group summary information
  /dev/sdd1: 6728/134217728 files (0.2% non-contiguous), 8849024/536870655 blocks
```

7. Now, mount the filesystem back and resize the filesystem.

```bash
sudo mount /appext4
```

* **If the file system is `ext4`:**

```bash
sudo resize2fs /dev/sdd1
```

```output
  resize2fs 1.42.9 (28-Dec-2013)
  Filesystem at /dev/sdd1 is mounted on /appext4; on-line resizing required
  old_desc_blocks = 256, new_desc_blocks = 1024
  The filesystem on /dev/sdd1 is now 2147483387 blocks long.
```

* **If the file system is `XFS`:**

```bash
sudo xfsgrowfs /dev/sdd1
```

8. Next verify the new size. We can see the new partition size.

```bash
sudo lsblk -o NAME,TYPE,FSTYPE,LABEL,SIZE,RO,MOUNTPOINT
```

```output
  NAME              TYPE FSTYPE      LABEL  SIZE RO MOUNTPOINT
  sda               disk                     32G  0
  ├─sda1            part vfat               500M  0 /boot/efi
  ├─sda2            part xfs                500M  0 /boot
  ├─sda3            part xfs                 31G  0 /
  └─sda4            part                      2M  0
  sdb               disk                    256G  0
  └─sdb1            part ext4               256G  0 /mnt
  sdc               disk                      1T  0
  └─sdc1            part LVM2_member          1T  0
    └─vgtest1-lvol1 lvm  ext4               500G  0
  sdd               disk                      8T  0
  └─sdd1            part ext4                 8T  0 /appext4
  sde               disk                      1T  0
```

```bash
sudo df -h /appext4
```

```output
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sdd1       7.9T  1.5G  7.6T   1% /appext4
```

```bash
sudo ls -l /appext4
```

```output
  total 20
  drwx------.  2 root root 16384 Dec  1 19:47 lost+found
  drwxr-xr-x. 20 root root  4096 Dec  1 19:50 datalog
```
