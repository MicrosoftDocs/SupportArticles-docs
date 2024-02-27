---
title: Disk performance may be slower than expected when you use multiple disks
description: Describes a resolution for an issue in which  disk performance may be slower than expected.  This issue may occur when you use a hardware or software-based RAID.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robsmi, v-srisan
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Disk performance may be slower than expected when you use multiple disks

This article describes a resolution for an issue in which  disk performance may be slower than expected. This issue may occur when you use a hardware or software-based RAID.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 929491

## Symptoms

Disk performance may be slower than expected when you use multiple disks in Windows. For example, performance may slow when you use a hardware-based redundant array of independent disks (RAID) or a software-based RAID.

## Cause

This issue may occur if the starting location of the partition is not aligned with a stripe unit boundary in the disk partition that is created on the RAID.

A volume cluster may be created over a stripe unit boundary instead of next to the stripe unit boundary. This is because Windows uses a factor of 512 bytes to create volume clusters. This behavior causes a misaligned partition. Two disk groups are accessed when a single volume cluster is updated on a misaligned partition.

Windows creates partitions that are based on a predefined number of sectors. The starting location for a disk partition in Windows is either the 32nd or the 64th sector, depending on the information that is presented to the operating system by the mass storage controller.

> [!NOTE]
> Disk partitions always reserve the first sector of the partition for code and for partition information, such as the number of sectors and the starting sector. The actual data part of the partition starts from the second sector of the partition.

## Resolution

To resolve this issue, use the Diskpart.exe tool to create the disk partition and to specify a starting offset of 2,048 sectors (1 megabyte). A starting offset of 2,048 sectors covers most stripe unit size scenarios.

> [!NOTE]
> Windows Server 2003 Service Pack 1 introduced the ability for Diskpart to adjust the partition alignment. If you do not have access to an updated version of Diskpart, diskpar (Notice that there is no final "t" on the name for this utility) is available.

To verify that an existing partition is aligned, perform the calculation that is described in the "More Information" section.

To align a disk partition on a RAID that has a 2,048-sector offset, follow these steps:  

1. At a command prompt, type diskpart, and then press ENTER.
2. Type the following commands at the DISKPART prompt, and then press ENTER:  

   ```console
   list disk
   ```

   You receive output that resembles the following:

   ```output
   Disk ### Status Size Free Dyn Gpt  
   -------- ---------- ------- ------- --- ---  
   Disk 0 Online 37 GB 8033 KB  
   Disk 1 Online 17 GB 8033 KB
   Disk 2 Online 17 GB 0 B  
   Disk 3 Online 17 GB 148 MB *  
   Disk 4 Online 17 GB 8 MB *  
   Disk 5 Online 17 GB 8 MB *  
   Disk 6 Online 17 GB 8 MB *  
   Disk 7 Online 17 GB 8 MB *  
   Disk 8 Online 17 GB 435 KB *  
   Disk 9 Online 17 GB 8 MB *  
   Disk 10 Online 17 GB 8033 KB
   ```  

   The `list disk` command provides summary information about each disk that is installed on the computer. The disk that has the asterisk (*) mark has the current focus. Only fixed disks and removable disks are listed. Fixed disks include integrated device electronics [IDE] and SCSI disks. Removable disks include 1394 and USB disks.  

   ```console
   select disk
   ```

   Use the select disk command to set the focus to the disk that has the specified disk number. If you do not specify a disk number, the command displays the current disk that is in focus.

   ```console
   create partition primary align=1024
   ```

   > [!NOTE]  
   >
   >- When you type this command, you may receive a message that resembles the following:DiskPart succeeded in creating the specified partition.  
   >- The align= **number** parameter is typically used together with hardware RAID Logical Unit Numbers (LUNs) to improve performance when the logical units are not cylinder aligned. This parameter aligns a primary partition that is not cylinder aligned at the beginning of a disk and then rounds the offset to the closest alignment boundary.  
   >- **number** is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. The command fails if the primary partition is not at the beginning of the disk. If you use the command together with the offset = **number** option, the offset is within the first usable cylinder on the disk.  

   ```console
   exit
   ```

3. Click **Start**, click **Run**, type *diskmgmt.msc*, and then click **OK**.
4. In the Disk Management Microsoft Management Console (MMC) snap-in, locate the newly created partition, and then assign it a drive letter.
5. Use the NTFS file system to format the new partition, and then assign a cluster size.  

   > [!NOTE]
   > This sample procedure is for a single partition per RAID group.

## More information

To verify that an existing partition is aligned, divide the size of the stripe unit by the starting offset of the RAID disk group. Use the following syntax:  
((Partition offset) * (Disk sector size)) / (Stripe unit size)
> [!NOTE]
> Disk sector size and stripe unit size must be in bytes or in kilobytes (KB).

Example of alignment calculations in bytes for a 256-KB stripe unit size:  
(63 \* 512) / 262144 = 0.123046875  
(64 \* 512) / 262144 = 0.125  
(128 \* 512) / 262144 = 0.25  
(256 \* 512) / 262144 = 0.5  
(512 \* 512) / 262144 = 1  

Example of alignment calculations in kilobytes for a 256-KB stripe unit size:  
(63 \*.5) / 256 = 0.123046875  
(64 \*.5) / 256 = 0.125  
(128 \*.5) / 256 = 0.25  
(256 \*.5) / 256 = 0.5  
(512 \*.5) / 256 = 1  

These examples show that the partition is not aligned correctly for a 256-KB stripe unit size until the partition is created by using an offset of 512 sectors (512 bytes per sector).

> [!NOTE]
> The number of disks in the array group does not affect the partition alignment. The factors that affect partition alignment are stripe unit size and partition starting offset.

To find the starting offset for a given partition, follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type the following command, and then press Enter: 

   ```console
   wmic partition get BlockSize, StartingOffset, Name, Index
   ```  

   After you run the command, you receive output that resembles the following:

   ```output
   BlockSize Index Name StartingOffset  
   512 0 Disk #1, Partition #0 32256  
   512 0 Disk #2, Partition #0 32256  
   512 0 Disk #3, Partition #0 32256  
   512 0 Disk #4, Partition #0 1048576  
   512 0 Disk #0, Partition #0 32256  
   512 1 Disk #0, Partition #1 41126400
   ```

3. Notice the value of BlockSize and of StartingOffset for each given partition. The Index value that is returned by this command indicates whether a partition is the first partition, the second partition, or other partitions for a given disk drive. For example, a partition index of 0 is the first partition on a given disk.
4. To determine how many disk sectors a given partition starts from the beginning of the disk, divide the value for StartingOffset by the value of BlockSize. In the example in step 2, the following calculation yields the partition starting offset in sectors:

   32256 / 512 = 63
