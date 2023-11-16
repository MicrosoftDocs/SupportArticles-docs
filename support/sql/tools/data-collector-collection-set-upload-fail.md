---
title: A Data Collector collection set might not be uploaded
description: This article introduces that a Data Collector collection set might not be uploaded if a cache file is corrupted.
ms.date: 07/22/2020
ms.custom: sap:Other tools
ms.reviewer: bartd
---
# A Data Collector collection set may not be uploaded if a cache file is corrupted

This article introduces that if a cache file is corrupted, Data Collector collection set might not be uploaded.

_Original product version:_ &nbsp;  SQL Server  
_Original KB number:_ &nbsp; 2019126

## Symptoms

You configure a Microsoft SQL Server Data Collector [collection set.](/previous-versions/sql/sql-server-2008-r2/bb677279(v=sql.105)) Then, you notice that new data is not being uploaded to the [Management Data Warehouse](/sql/relational-databases/data-collection/management-data-warehouse) database. When you view the [collection set logs](/sql/relational-databases/data-collection/view-collection-set-logs-sql-server-management-studio), you receive one of the following error messages:

- Error message 1

    > The file had bad version and flags information. The file is damaged or not a SSIS-produced raw data file.  
    component "Raw File Destination" (57) failed the pre-execute phase and returned error code 0xC0202061

- Error message 2

    > Encountered bad metadata in file header. The file is damaged or not a SSIS-produced raw data file.  
    component "Raw File Destination" (57) failed the pre-execute phase and returned error code 0xC020205E

- Error message 3

    > Unexpected end-of-file encountered while reading X bytes from file "Y". The file ended prematurely because of an invalid file format.  
    component "Raw File Destination" (57) failed the pre-execute phase and returned error code 0xC0202069

- Error message 4

    > The adapter encountered an unrecognized data type of X. This could be caused by a damaged input file (source) or by an invalid buffer type (destination).  
    component "Raw File Destination" (57) failed the pre-execute phase and returned error code 0xC020206B

- Error message 5

    > String too long. The adapter read a string that was X bytes long, and expected a string no longer than Y bytes, at offset Z. This could indicate a damaged input file. The file shows a string length that is too large for the buffer column.  
    component "Raw File Destination" (57) failed the pre-execute phase and returned error code 0xC020206C

## Cause

This problem occurs when one or more Data Collector cache files are corrupted. The corruption may be caused for one of the following reasons:

- Data Collector encountered an exception.
- The disk runs out of free space while Data Collector is writing to a cache file.
- A firmware or a driver problem occurs.

## Resolution

Locate the corrupted cache file and delete it. To do this, follow these steps:

1. Start SQL Server Management Studio, and connect to the instance of SQL Server where the error occurs.
2. Expand the **Management** folder, right-click **Data Collection**, and select **Properties**.
3. If a directory is displayed for **Cache directory**, this is the location of the Data Collector cache files. Go to step 5.
4. If a directory is not displayed for **Cache directory**, the default cache directory is the local temporary directory of the account that executes the collection set. This account may be the SQL Server Agent service account. For example, on Windows Server 2008, if the collection set was executed by an account that is named *sqlacct*, this account's temporary directory is located in a path that resembles the following: `C:\Users\sqlacct\AppData\Local\Temp`.
5. Find all files that have a *.CACHE file name extension, and move the files to a different directory. If the collection set is the Utility Information collection set, do not try to run the collection set directly. Wait 30 minutes to see whether the problem is resolved. If the collection set is any other collection set, restart the collection set.

## More information

- [Data Collection](/sql/relational-databases/data-collection/data-collection)
- [The Management Data Warehouse](/sql/relational-databases/data-collection/management-data-warehouse)
