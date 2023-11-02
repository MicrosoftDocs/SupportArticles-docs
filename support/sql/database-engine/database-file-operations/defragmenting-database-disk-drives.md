---
title: Defragmenting database disk drives
description: This article provides some guidance regarding defragmentation of SQL Server database drives.
ms.date: 09/28/2022
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni
---
# Defragmenting SQL Server database disk drives

This article provides some guidance regarding defragmentation of SQL Server database drives.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3195161

## Should SQL Server disks be defragmented at the operating system layer?

That depends on the fragmentation state of the current drives. Generally, it doesn't hurt and it may help, assuming you follow the precautions that are described in the [Precautions when defragmenting SQL Server database drives](#precautions-when-you-defragment-sql-server-database-drives) section. **The only negative is that you must shut down SQL Server** unless the defragmentation tool supports transactional data capabilities. The good news is that, after you've run the defrag, you don't really have to do it again unless you have many Autogrowth and other files moving on and off the disks. Make sure that you understand any write-caching strategies that the utility uses. Caching by such a utility might involve a non-battery-backed cache, and this could violate WAL protocol requirements.

## More information

A disk defragmenter moves all files, including the database file, into contiguous clusters on a hard disk. This optimizes and speeds up file access. Except for Windows NT operating system, if you don't defragment your hard disk, the operating system may have to go to several physical locations on the disk to retrieve the database file, making file access slower.

Because physical data access is the most expensive part of an I/O request, defragmentation can provide performance gains for SQL Server and other applications. Positioning-related chunks of data close to each other reduces I/O operation requirements.

Various defragmentation utilities are available in the market today. Some utilities enable defragmentation on open files, whereas others require closed-file defragmentation or perform better when used under closed-file conditions. Additionally, some utilities have transactional capabilities, whereas others don't.

## Precautions when you defragment SQL Server database drives

When you evaluate a defragmentation utility for use with SQL Server, make sure that the utility provides transactional data capabilities. Specifically, choose a defragmentation utility that provides the following transactional data capabilities:

- The original sector isn't considered moved until the new sector has been successfully established and the data successfully copied.

- The utility protects against a system failure, such as a power outage, in a safe way that keeps the files logically and physically intact. To guarantee data integrity, a pull-the-plug test is highly recommended when a defragmentation utility is running on a SQL Server-based file.

- The Write-Ahead Logging (WAL) protocol requires the prevention of sector rewrites to avoid data loss. The utility must maintain the physical integrity of the file as long as it's performing any data movement. The utility should work on sector boundaries in a transactional way to keep the SQL Server files intact.

- The utility should provide appropriate locking mechanisms to guarantee that the file retains a consistent image for any modifications. For example, the utility should ensure that the original sector can't be modified when it's copied to a new location. If modifications were allowed, the defragmentation utility could lose the write.

Critical disk defragmenters that don't provide these transactional data capabilities shouldn't be used unless the SQL Server instance using the disks to be defragmented has been shut down so that you're not defragmenting open database files.

Open-file defragmentation raises several possible issues that closed-file defragmentation typically doesn't:

- Open-file defragmenting affects performance. Defragmentation utilities may lock sections of the file, preventing SQL Server from completing a read or write operation. This may affect the concurrency of the server that's running SQL Server. Contact the manufacturer of the defragmentation tool to learn how files are locked and how this could affect SQL Server concurrency.

- Open-file defragmenting can affect write caching and ordering. Open-file-based utilities require I/O path components; these components must not change the ordering or intended nature of the write operation. If the write-through or WAL protocol tenants are broken, database damage is likely to occur. The database and all associated files are considered to be a single entity. (This is covered in many Microsoft Knowledge Base articles, SQL Server Books Online, and various white papers.) All writes must retain the original write-ordering sequences and write-through capabilities.

## Recommendations

- Defrag the NTFS volume, unless it was formatted, before you create a new database or move existing databases to the volume.
- Make sure that you plan and size your SQL data and log files appropriately when the database is first created.
- Create your pre-SQL Server 2014 transaction logs with Autogrowth in mind if it will be used.
- Defrag the disk or disks on which your transaction logs reside. This will prevent external file fragmentation of the transaction log. This problem may occur if your files have had much Autogrowth or when it's not a dedicated disk that contains many databases, logs, or other files that have been modified. In that situation, files (including the transaction log file) may be interleaved and fragmented.
- If you're defragmenting database drives that are cluster disks, the cluster disks should be set up to suspend health monitoring (also referred to as *maintenance mode*).
- To minimize fragmentation, don't shrink your database files. Also, manually grow them in sizes that minimize the growth activity.
- Keep your database files on dedicated disks.
- Perform a full backup before you defragment those locations that contain SQL Server database and backup files.

## References

- [How to run ChkDsk and defrag on Cluster Shared Volumes in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/failover-clustering/how-to-run-chkdsk-and-defrag-on-cluster-shared-volumes-in/ba-p/371905)

- [Recommendations and guidelines for improving SQL Server FILESTREAM performance](https://support.microsoft.com/help/2160002)
