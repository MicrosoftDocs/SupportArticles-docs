---
title: Error 17113 when you start SQL Server service
description: This article provides resolutions for the Error 17113 problem that occurs when you start SQL Server service.
ms.date: 1/28/2020
author: xl989
ms.author: v-lianna
ms.reviewer: ramakoni
---

# Service-specific error 17113 when you start SQL Server service

_Applies to:_ &nbsp; SQL Server

## Symptoms

In a Microsoft SQL Server, the master database records all the system-level information. The master database also records all other databases, the location of those database files, and the initialization information for SQL Server. Therefore, SQL Server cannot start if the master database is unavailable.

When you try to start SQL Server in this scenario, the SQL Server service doesn’t start, and you receive the following error message, depending on how you try to start the service:

- By using the Services applet:

    > Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 17113.

- By using a command prompt:

    > C:\\>NET START MSSQLSERVER  
    The SQL Server (MSSQLSERVER) service is starting.  
    The SQL Server (MSSQLSERVER) service could not be started.  
    A service specific error occurred: 17113.  
    More help is available by typing NET HELPMSG 3547.

## Resolution

1. Check [SQL Server error log](https://docs.microsoft.com/sql/tools/configuration-manager/viewing-the-sql-server-error-log) and verify that the cause is the inaccessibility of the master database. For example, you might see a log entry that resembles the following:

    > \<Datetime> Server      Error: 17113, Severity: 16, State: 1.  
    \<Datetime> Server      Error 2(The system cannot find the file specified.) occurred while opening file 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master.mdf' to obtain configuration information at startup. An invalid startup option might have caused the error. Verify your startup options, and correct or remove them if necessary.

2. Verify the location of the master.mdf file.

    If the path is incorrect, fix the path in registry or in Configuration manager.

    If the master database does exist but is unusable you can return the database to a usable state, take one of the following actions:

    - Check the permissions for the service account on the folder where the file is located.
    - [Restore the master database](/sql/relational-databases/backup-restore/restore-the-master-database-transact-sql) from a full database backup if you can start the server instance.
    - If server damage to master prevents you from starting SQL Server, [Rebuild the master database](/sql/relational-databases/databases/rebuild-system-databases).

        > [!IMPORTANT]
        > Rebuilding the master database rebuilds all the system databases. Therefore, any user modifications to these databases will be lost.

    If the file doesn't exist in the path that's mentioned in the error log, fix the path in Registry Editor or in Sql Server Configuration Manager.
