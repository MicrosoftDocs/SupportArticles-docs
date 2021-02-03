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

In Microsoft SQL Server, the master database records all the system-level information. The master database also records the existence of all other databases, the location of those database files, and the initialization information for SQL Server. Therefore, SQL Server cannot start if the master database is unavailable.

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

    1. Using SQL Server Configuration Manager

        Click the **Start** button, point to All Programs, point to Microsoft SQL Server, point to Configuration Tools, and then click **SQL Server Configuration Manager**.

        > [!NOTE]
        > Because SQL Server Configuration Manager is a snap-in for the Microsoft Management Console program and not a stand-alone program, SQL Server Configuration Manager does not appear as an application in newer versions of Windows.

        - Windows 10:  
            To open SQL Server Configuration Manager, on the **Start** Page, type *SQLServerManager13.msc* (for SQL Server 2016 (13.x)). For previous versions of SQL Server replace 13 with a smaller number. Click **SQLServerManager13.msc** opens the Configuration Manager. To pin the Configuration Manager to the Start Page or Task Bar, right-click **SQLServerManager13.msc**, and then click Open file location. In the Windows File Explorer, right-click **SQLServerManager13.msc**, and then click Pin to Start or Pin to taskbar.

        - Windows 8:  
            To open SQL Server Configuration Manager, in the Search charm, under Apps, type *SQLServerManager\<version>.msc* such as *SQLServerManager13.msc*, and then press **Enter**.

        1. In SQL Server Configuration Manager, click SQL Server Services.

        1. In the right pane, right-click SQL Server (\<instance_name>), and then click **Properties**.
        1. On the **Startup Parameters** tab, select the row that starts with *-d* in the Existing Parameters: section. The current value shows as an editable value in Specify a startup parameter box. Fix the path to reflect the correct value and click **Update** button and click **OK** to save the changes.
        1. Restart SQL service.

        - For more information regarding configuring startup options, see [Configure Server Startup Options](/sql/database-engine/configure-windows/scm-services-configure-server-startup-options).

        - For more information regarding database engine service startup options, see [Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options).

    2. Using Registry editor:

        1. Navigate to `HKLM\Software\Microsoft\MicrosoftSQL Server\MSSQL{nn}.MyInstance` hive for your SQL server instance.

        1. Locate **SQLArg0** value under `MSSQLServer\Parameters`.
        1. Modify the value to reflect the correct path for master database.
        1. Restart SQL Service.

3. If the master database does exist but is unusable you can return the database to a usable state, take one of the following actions:

    - Check the permissions for the service account on the folder where the file is located.
    - [Restore the master database](/sql/relational-databases/backup-restore/restore-the-master-database-transact-sql?view=sql-server-ver15) from a full database backup if you can start the server instance.
    - If server damage to master prevents you from starting SQL Server, [Rebuild the master database](/sql/relational-databases/databases/rebuild-system-databases).

        > [!IMPORTANT]
        > Rebuilding the master database rebuilds all the system databases. Therefore, any user modifications to these databases will be lost.
