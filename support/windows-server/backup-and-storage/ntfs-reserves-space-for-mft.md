---
title: How NTFS reserves space for MFT
description: Describes how NTFS reserves space for its Master File Table (MFT).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# How NTFS reserves space for its Master File Table (MFT)

This article describes how NTFS reserves space for its Master File Table (MFT).

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 174619

## Summary

The NTFS file system contains at its core, a file called the master file table (MFT). There is at least one entry in the MFT for every file on an NTFS volume, including the MFT itself.

Because utilities that defragment NTFS volumes cannot move MFT entries, and because excessive fragmentation of the MFT can impact performance, NTFS reserves space for the MFT in an effort to keep the MFT as contiguous as possible as it grows.

In Windows, the defrag utility defrags the MFT.

## The defrag utility

A defrag operation on the MFT combines an MFT file into 1 and prevents it from being stored in multiple places that are not sequential on disk. In this class of operation, the MFT file is more sequential. However, it is exactly the size that the MFT file was before the defrag operation.

An MFT can be too large if a volume used to have lots of files that were deleted. The files that were deleted cause internal holes in the MFT. These holes are significant regions that are unused by files. It is impossible to reclaim this space. This is at least true on a live NTFS volume.

## More information

NTFS uses MFT entries to define the files to which they correspond. All information about a file, including its size, time and date stamps, permissions, and data content is either stored in MFT entries or in space external to the MFT but described by the MFT entries.

(Directory entries, external to the MFT, also contain some redundant information regarding files. But a full discussion of all the structures on NTFS is beyond the scope of this article.)

As files are added to an NTFS volume, more entries are added to the MFT and so the MFT increases in size. When files are deleted from an NTFS volume, their MFT entries are marked as free and may be reused, but the MFT does not shrink. Thus, space used by these entries is not reclaimed from the disk.

Because of the importance of the MFT to NTFS and the possible impact on performance if this file becomes highly fragmented, NTFS makes a special effort to keep this file contiguous. NTFS reserves 12.5 percent of the volume for exclusive use of the MFT until and unless the remainder of the volume is used up. Thus, space for files and directories is not allocated from this MFT zone until all other space is allocated first.

> [!NOTE]
> You can change the **NtfsMFTZoneReservation** registry key to increase the volume in Windows.
> For more information about the MFT, please see the **Key elements in the disk defragmentation process** section of  [Maintaining Windows 2000 Peak Performance Through Defragmentation](/previous-versions/windows/it-pro/windows-2000-server/bb742585(v=technet.10)).

Depending on the average file size and other variables, either the reserved MFT zone or the unreserved space on the disk may be used up before the other as the disk fills to capacity.

Volumes with a small number of relatively large files exhaust the unreserved space first, while volumes with a large number of relatively small files exhaust the MFT zone space first. In either case, fragmentation of the MFT starts to take place when one region or the other becomes full. If the unreserved space becomes full, space for user files and directories starts to be allocated from the MFT zone competing with the MFT for allocation. If the MFT zone becomes full, space for new MFT entries is allocated from the remainder of the disk, again competing with other files.

A new registry parameter can increase the percentage of a volume that NTFS reserves for its master file table. **NtfsMftZoneReservation** is a REG_DWORD value that can take on a value between 1 and 4, where 1 corresponds to the minimum MFT zone size and 4 corresponds to the maximum. If the parameter is not specified or an invalid value is supplied, NTFS uses a default value of 1 for this parameter. The exact ratios that correspond to each setting are undocumented because they are not standardized and may change in future releases. In order to know what setting is best for your environment, it may be necessary to experiment with different values.

To determine the current size of the MFT on a Windows computer, type the `dir /a $mft` command on an NTFS volume.

To determine the current size of the MFT on a Windows computer, use Disk Defragmenter to analyze the NTFS drive, and then click **View Report**. This displays the drive statistics, including the current MFT size and number of fragments.

The Disk Defragmenter displays *green* for what is called *system files* and on an NTFS formatted volume this is simply the combination of the MFT, pagefile.sys (if one exists on this volume) and what is called the "MFT Zone" or reserved space for *MFT Expansion*. The defragmentation report only displays information about the pagefile and MFT; it does not mention the MFT Zone because it does not affect in any way disk utilization or capacity.

The MFT Zone is not subtracted from available (free) drive space used for user data files, it is only space that is used last. When the MFT needs to increase in size, for example, you created new files and directories, it is taken from the MFT Zone first, thus decreasing MFT fragmentation and optimizing MFT performance.

The default MFT Zone is calculated and reserved by Ntfs.sys when it mounts the volume, and is based on volume size. You can increase the MFT Zone by means of the registry entry documented below, but you cannot make the default MFT Zone smaller than what is calculated by Ntfs.sys. Increasing the MFT Zone does not decrease in any way disk space that can be used by users for data files.

> [!NOTE]
> The results returned by the dir command may not be current. The size reported by the dir command may reflect cached data that reflects the size of the MFT at the time the system was started following an orderly shutdown.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

To add this value, perform the following steps:

1. Run Registry Editor (Regedt32.exe), and go to the following subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\FileSystem`

2. From the **Edit** menu, click **Add Value**.
3. Type the following information in the dialog box:

    - Value Name: **NtfsMftZoneReservation**
    - Data Type: REG_DWORD
    - Data: (valid range is 1-4)

4. Quit Registry Editor and restart your computer.

> [!NOTE]
> This is a run-time parameter and does not affect the actual format of a volume. Rather, it affects the way NTFS allocates space on all volumes on a given system. Therefore, to be completely effective, the parameter must be in effect from the time that a volume is formatted and throughout the life of the volume. If the registry parameter is adjusted downward or removed, the MFT zone will be reduced accordingly, but this will not have any affect on MFT space already allocated and used.
