---
title: Error 3156 when you restore a database
description: This article provides workarounds for the 3156 error that occurs when you restore a database with a memory-optimized filegroup in SQL Server.
ms.date: 04/15/2021
author: aartig13
ms.author: aartigoyle
ms.reviewer: jolamber, sqlblt
ms.custom: sap:Database Backup and Restore
---
# Error 3156 when restoring a database with a memory-optimized filegroup in SQL Server

This article provides a workaround for the 3156 error, which occurs when you try to restore a database that has a memory-optimized filegroup in SQL Server.

_Applies to:_ &nbsp; SQL Server  

## Symptoms

When trying to restore a database that has a memory-optimized filegroup in SQL Server, you receive the following error message:

> Msg 3156, Level 16, State 6, Line 1  
File '\<Database File>' cannot be restored to '\<Driver>:\\\<Folder Path>\\\<Database Folder>'. Use WITH MOVE to identify a valid location for the file.

## Cause

During the process of a database restoration, SQL Server Database Engine will create a folder for a memory-optimized filegroup. This issue occurs if there's already a folder with the same name in the same folder path, and the folder is used by SQL Server or other processes.

## Workaround

Use a different folder name or a different folder path when restoring a database.

## Script example

- Script example of creating a database with a filegroup

    ```sql
    USE [master];
    GO
    CREATE DATABASE Contoso
    ON PRIMARY
      ( NAME = 'Contoso_Primary',
        FILENAME=
           'C:\SQLserver\Contoso\Contoso_data.mdf',
        SIZE=4MB,
        MAXSIZE=10MB,
        FILEGROWTH=1MB),
    FILEGROUP Contoso_FG1
      ( NAME = 'Contoso_FG1',
        FILENAME =
           'C:\SQLserver\Contoso\Contoso_FG1.ndf',
        SIZE = 1MB,
        MAXSIZE=10MB,
        FILEGROWTH=1MB)

    ALTER DATABASE Contoso 
    ADD FILEGROUP [Contoso_FG1] CONTAINS MEMORY_OPTIMIZED_DATA 
    GO
    ```

- Script example of a database restoration

    ```sql
    USE [master]
    GO
    RESTORE DATABASE [Contoso] FROM  DISK = N'C:\backup\compress\Contoso\Contoso.bak' WITH FILE = 1,
    MOVE N'Contoso_data' TO N'C:\SQLserver\Contoso\Contoso_data.mdf',
    MOVE N'Contoso_log' TO N'C:\SQLServer\Contoso\Contoso_log.ldf',
    MOVE N'<Database File>' TO N'<Driver>:\<Folder Path>\<Database Folder>',
    Replace,
    NOUNLOAD, 
    STATS = 5
    GO
    ```

    > [!NOTE]
    > If the `<Database Folder>` is not used, the `Replace` keyword in the script will ensure that the process of restoration is completed without error.

## See also

[MSSQLSERVER_3156](/sql/relational-databases/errors-events/mssqlserver-3156-database-engine-error)
