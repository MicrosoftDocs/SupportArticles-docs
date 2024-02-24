---
title: Correct disk space problems on NTFS volumes
description: Describes how to locate and correct disk space problems on NTFS volumes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
---
# Locate and correct disk space problems on NTFS volumes

This article discusses how to check an NTFS file system's disk space allocation to discover offending files and folders or look for volume corruption in Microsoft Windows Server 2003-based computers.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814594

## Summary

NTFS supports many volume and file-level features that may lead to what appear to be lost or incorrectly reported free disk space. For example, an NTFS volume may suddenly appear to become full for no reason, and an administrator cannot find the cause or locate the offending folders and files. This may occur if malicious or unauthorized access to an NTFS volume where large files or a high quantity of small files are secretly copied has occurred. These files then have their NTFS permissions removed or restricted. This behavior may also occur after a computer malfunction or power outage occurs that cause volume corruption.

The disk space allocation of an NTFS volume may appear to be misreported for any of the following reasons:

- The NTFS volume's cluster size is too large for the average-sized files that are stored there.
- File attributes or NTFS permissions prevent Windows Explorer or a Windows command prompt from displaying or accessing files or folders.
- The folder path exceeds 255 characters.
- Folders or files contain invalid or reserved file names.
- NTFS metafiles (such as the Master File Table) have grown, and you cannot de-allocate them.
- Files or folders contain alternate data streams.
- NTFS corruption causes free space to be reported as in use.
- Other NTFS features may cause file-allocation confusion.

The following information can help you to optimize, repair, or gain a better understanding of how your NTFS volumes use disk space.

## Cluster size is too large

Only files and folders that include internal NTFS metafiles like the Master File Table (MFT), folder indexes, and others can consume disk space. These files and folders consume all the file space allocations by using multiples of a cluster. A cluster is a collection of contiguous sectors. The cluster size is determined by the partition size when the volume is formatted.

For more information about clusters, see [Default cluster size for NTFS, FAT, and exFAT](https://support.microsoft.com/help/140365).

When a file is created, it consumes a minimum of a single cluster of disk space, depending on the initial file size. When data is later added to a file, NTFS increases the file's allocation in multiples of the cluster size.

To determine the current cluster size and volume statistics, run a read-only chkdsk command from a command prompt. To do so, follow these steps:

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type the command: `chkdsk d:`.  

    Where **d:** is the letter of the drive that you want to check.
3. Click **OK**.
4. View the resulting output. For example:

    > 4096543 KB total disk space. <--- Total formatted disk capacity.  
    2906360 KB in 19901 files. <--- Space used by user file data.  
    6344 KB in 1301 indexes. <--- Space used by NTFS indexes.  
    0 KB in bad sectors. <--- Space lost to bad sectors.  
    49379 KB in use by the system. <--- Includes MFT and other NTFS metafiles.  
    22544 KB occupied by the log file. <--- NTFS Log file - (Can be adjusted using chkdsk /L:size)  
    1134460 KB available on disk. <--- Available FREE disk space
    >
    > 4096 bytes in each allocation unit. <--- Cluster Size. (4K)  
    1024135 total allocation units on disk. <--- Total Clusters on disk.  
    283615 allocation units available on disk. <--- Available free clusters.

> [!NOTE]
> Multiply each value that the output reports in kilobytes (KB) by 1024 to determine accurate byte counts. For example: 2906360 x 1024 = 2,976,112,640 bytes. You can use this information to determine how your disk space is being used and the default cluster size.

To determine whether this is the optimal cluster size, you must determine the wasted space on your disk. To do so, follow these steps:

1. Click **Start**, click **My Computer**, and then double-click the drive letter (for example, D) of the volume in question to open the volume and display the folders and files that the root contains.
2. Click any file or folder, and then click **Select All** on the **Edit** menu.
3. With all the files and folders selected, right-click any file or folder, click **Properties**, and then click the **General** tab.

    The **General** tab displays the total number of files and folders on the whole volume and provides two file size statistics: **SIZE** and **SIZE ON DISK**.

If you are not using NTFS compression for any files or folders contained on the volume, the difference between SIZE and SIZE ON DISK may represent some wasted space because the cluster size is larger than necessary. You may want to use a smaller cluster size so that the SIZE ON DISK value is as close to the SIZE value as possible. A large difference between the SIZE ON DISK and the SIZE value indicates that the default cluster size is too large for the average file size that you are storing on the volume.

You can only change the cluster size you are using by reformatting the volume. To do this, back up the volume, and then format the volume by using the format command and the `/a` switch to specify the appropriate allocation. For example: `format D: /a:2048`
(This example uses a 2-KB cluster size).

> [!NOTE]
> Alternately, you can enable NTFS compression to regain space that you lost because of an incorrect cluster size. However, this may result in decreased performance.

## File attributes or NTFS permissions

Both Windows Explorer and the directory list command `dir /a /s` display the total file and folder statistics for only those files and folders that you have permissions to access. By default, Files hidden files and protected operating system files are excluded. This behavior may cause Windows Explorer or the dir command to display inaccurate file and folder totals and size statistics.

To include these types of files in the overall statistics, change **Folder Options**. To do so, follow these steps:

1. Click **Start**, click **My Computer**, and then double-click the drive letter (for example: **D**) of the volume. This opens the volume and displays the folders and files that the root contains.
2. On the **Tools** menu, click **Folder Options**, and then click the **View** tab.
3. Select the **Show Hidden Files and Folders** check box, and then click to clear the **Hide protected operating system files** check box.
4. Click **Yes** when you receive the warning message, and then click the **Apply** button. This change permits Windows Explorer and the `dir /a /s` command to total all the files and folders that the volume contains that the user has permissions to access.

To determine the folders and files that you cannot access, follow these steps:

1. At the command prompt, create a text file from the output of the `dir /a /s` command.

    For example: At the command prompt, type the following command: `dir d: /a /s >c:\d-dir.txt`.

2. Start the Backup or Restore Wizard.

   1. Click **Start**, click **Run**, type *ntbackup*, and then click **OK**.
   2. Click **Advanced Mode**.

3. Click **Options** on the **Tools** menu, click the **Backup Log** tab, click **Detailed**, and then click **OK**.

4. In the Backup Utility, click the **Backup** tab, and then select the check box for the whole volume that is affected (for example: **D:**), and then click **Start Backup**.

5. After the backup is complete, open the backup report and compare folder for folder the NTBackup log output with the d-dir.txt output that you saved in step 1.

Because backup can access all the files, its report may contain folders and files that Windows Explorer and the dir command do not display. You may find it easier to use the NTBackup interface to locate the volume without backing up the volume when you want to search for large files or folders that you cannot access by using Windows Explorer.

After you locate the files that you do not have access to, you can add or change permissions by using the **Security** tab while you view the properties of the file or folder in Windows Explorer. By default, you cannot access the System Volume Information folder. You must add the correct permissions to include the folder in the `dir /a /s` command.

You may notice folders or files that do not have a **Security** tab. Or, you may not be able to re-assign permissions to the affected folders and files. You may receive the following error message when you try to access them:

> D:\folder_name\ is not accessible
>
> Access is denied

If you have any such folders, contact [Microsoft Product Support Services](https://support.microsoft.com) for additional help.

## Invalid file names

Folders or files that contain invalid or reserved file names may also be excluded from file and folder statistics. Folders or files that contain leading or trailing spaces are valid in NTFS, but they are not valid from a Win32 subsystem point of view. Therefore, neither Windows Explorer nor a command prompt can reliably work with them.

You may not be able to rename or delete these files or folders. When you try to do so, you may receive one of the following error messages:

> Error renaming file or folder
>
> Cannot rename file: Cannot read from the source file or disk.

Or

> Error deleting file or folder
>
> Cannot delete file: Cannot read from the source file or disk.

If you have folders or files that you cannot delete or rename, contact Microsoft Product Support Services.

## NTFS Master File Table (MFT) expansion

When an NTFS volume is created and formatted, NTFS metafiles are created. One of these metafiles is named the Master File Table (MFT). It is small when it is created (approximately 16 KB), but it grows as files and folders are created on the volume. When a file is created, it is entered in the MFT as a File Record Segment (FRS). The FRS is always 1024 bytes (1 KB). As files are added to the volume, the MFT grows. However, when files are deleted, the associated FRSs are marked as free for reuse, but the total FRSs and associated MFT allocation remains. That is why you do not regain the space used by the MFT after you delete a large number of files, .

To see exactly how large the MFT is, you can use the built-in defragmenter to analyze the volume. The resulting report provides detailed information about the size and number of fragments in the MFT.

For example:

> Master File Table (MFT) fragmentation  
Total MFT size = 26,203 KB  
MFT record count = 21,444  
Percent MFT in use = 81 %  
Total MFT fragments = 4

However, for more complete information about how much space (overhead) the whole NTFS is using, run the chkdsk.exe command, and then view the output for the following line:

> In use by system.

Currently, only third-party defragmenters consolidate unused MFT FRS records and reclaim unused MFT allocated space.

## Alternate data streams

NTFS permits files and folders to contain alternate data streams. With this feature, you can associate multiple data allocations with a single file or folder. The use of alternate data streams on files and folders has the following limitations:

- Windows Explorer and the dir command do not report the data in alternate data streams as part of the file size or volume statistics. Instead, they show only the total bytes for the primary data stream.
- The output from chkdsk accurately reports the space that a user's data files use, including alternate data streams.
- Disk quotas accurately track and report all data stream allocations that are part of a user's data files.
- NTBackup records the number of bytes backed up in the backup log report. However it does not show which files contain alternate data streams. It also does not show accurate file sizes for files that include data in alternate streams.

## NTFS file system corruption

In rare circumstances, the NTFS Metafiles $MFT or $BITMAP may become corrupted and result in lost disk space. You can identify and fix this issue by running the `chkdsk /f` command against the volume. Toward the end of chkdsk, you receive the following message if you must adjust the $BITMAP:Correcting errors in the master file table's (MFT) BITMAP attribute. CHKDSK discovered free space marked as allocated in the volume bitmap. Windows has made corrections to the file system.

## Other NTFS features that may cause file allocation confusion

NTFS also supports hard links and reparse points that permit you to create volume mount points and directory junctions. These additional NTFS features may cause confusion when you try to determine how much space a physical volume is consuming.

A *hard link* is a directory entry for a file regardless of where the file data is located on that volume. Every file has at least one hard link. On NTFS volumes, each file can have multiple hard links, and therefore a single file can appear in many folders (or even in the same folder with different names). Because all the links refer to the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all the links to it are deleted. After you create a hard link, programs can use it like any other file name.

> [!NOTE]
> Windows Explorer and a command prompt show all linked files as being the same size, even though they all share the same data and do not actually use that amount of disk space.

Volume mount points and directory junctions permit an empty folder on an NTFS volume to point to the root or subfolder on another volume. Windows Explorer and a dir /s command follow the reparse point, count any files and folders on the destination volume, and then include them in the host volume's statistics. This may mislead you to believe that more space is being used on the host volume than what is actually being used.

In summary, you can use chkdsk output, NTBackup GUI or backup logs, and the viewing of disk quotas to determine how disk space is being used on a volume. However, Windows Explorer and the dir command have some limitations and drawbacks when used for this purpose.
