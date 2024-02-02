---
title: Support for databases on compressed volumes
description: This article describes SQL Server's database file storage behavior on compressed drives.
ms.date: 09/07/2020
ms.custom: sap:Administration and Management
ms.reviewer: sureshka
---
# Description of support for SQL Server databases on compressed volumes

This article describes SQL Server's database file storage behavior on compressed drives.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 231347

## Summary

SQL Server databases are not supported on NTFS or FAT compressed volumes except under special circumstances for SQL Server 2005 and later versions. A compressed volume does not guarantee sector-aligned writes, and these are necessary to guarantee transactional recovery under some circumstances.

For SQL Server 2005 and later versions, database file storage on compressed drives behaves as follows:

- If your data file belongs to a read-only filegroup, the file is allowed.
- If your data file belongs to a read-only database, the file is allowed.
- If your transaction log file belongs to a read-only database, the file is allowed.
- If you try to bring up a read/write database with files on a compressed drive, SQL Server generates the following error:

  > Msg 5118, Level 16, State 2, Line 1
The file "< *file_name* >" is compressed but does not reside in a read-only database or filegroup. The file must be decompressed.

For more information about exclusions for read-only databases and read-only filegroups in SQL Server 2008, go to the following MSDN website:

[Read-Only Filegroups and Compression](/previous-versions/sql/sql-server-2008-r2/ms190257(v=sql.105))

> [!NOTE]
> This topic also applies to SQL Server 2012 and later versions.

## More information

Although it is physically possible to add SQL Server databases on compressed volumes, we do not recommend this, and we do not support it. The underlying reasons for this include the following:

- Performance  

  Databases on compressed volumes may cause significant performance overhead. The amount will vary, depending on the volume of I/O and on the ratio of reads to writes. However, over 500 percent degradation was observed under some conditions.

- Database recovery  

  Reliable transactional recovery of the database requires sector-aligned writes, and compressed volumes do not support this scenario. A second issue concerns internal recovery space management. SQL Server internally reserves preallocated space in database files for rollbacks. It is possible on compressed volumes to receive an **Out of Space** error on preallocated files, and this interferes with successful recovery.

In certain scenarios, a SQL Server backup to a compressed volume or compressed folder is not successful. When this issue occurs, you receive one of the following error messages.

- In Windows Vista and later versions of Windows

  > STATUS_FILE_SYSTEM_LIMITATION The requested operation could not be completed due to a file system limitation  
  > Operating system error 665(The requested operation could not be completed due to a file system limitation)

- In earlier versions of Windows

  > STATUS_INSUFFICIENT_RESOURCES insufficient system resources exist to complete the requested service
  > Operating system error 1450(Insufficient system resources exist to complete the requested or 33(The process cannot access the file because another process has locked a portion of the file.)

For more information about this issue, see [A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351).

> [!NOTE]
>
> - The hotfix for Windows Vista and later versions of Windows that's discussed in KB article [967351](https://support.microsoft.com/help/967351) may not resolve the issue of SQL Server backups that are not successful to a compressed volume or to a compressed folder. However, this hotfix will help mediate the issue.
> - After you apply the hotfix that is discussed in KB article [967351](https://support.microsoft.com/help/967351), you must format the drive on which compression is enabled by using the `/L` parameter. When you format the drive on which compression is enabled by using the `/L` parameter, the Bytes Per File Records Segment increases from 1,024 bytes to 4,096 bytes.

SQL Server backups to compressed volumes can save disk space. However, they may increase CPU usage during the backup operation. We always recommend that you use the BACKUP checksum facilities to help guarantee data integrity.

SQL Server requires systems to support guaranteed delivery to stable media, as outlined in the [SQL Server I/O Reliability Program Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf).

For more information about the input and output requirements for the SQL Server database engine, see [Microsoft SQL Server Database Engine Input/Output requirements](https://support.microsoft.com/help/967576)
