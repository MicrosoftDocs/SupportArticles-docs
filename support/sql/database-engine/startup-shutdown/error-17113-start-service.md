---
title: Error 17113 when you start SQL Server service
description: Provides resolutions for the Error 17113 problem that occurs when you start SQL Server service.
ms.date: 12/17/2021
author: aartig13
ms.author: aartigoyle
ms.reviewer: ramakoni
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---

# Service-specific error 17113 when you start SQL Server service

_Applies to:_ &nbsp; SQL Server

## Symptoms

In Microsoft SQL Server, the `master` database records all the system-level information. The `master` database also records the existence of all other databases, the location of those database files, and the initialization information for SQL Server. Therefore, SQL Server cannot start if the `master` database is unavailable.

When you try to start SQL Server in this scenario, the SQL Server service doesn't start, and you receive one of the following error messages depending on how you try to start the service:

- By using the **Services** applet:

    > Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 17113.

- By using a command prompt:

    ```output
    C:\\>NET START MSSQLSERVER  
    The SQL Server (MSSQLSERVER) service is starting.  
    The SQL Server (MSSQLSERVER) service could not be started.  
    A service specific error occurred: 17113.  
    More help is available by typing NET HELPMSG 3547.
    ```

## Resolution

1. Check [SQL Server error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log) and verify that the cause is the inaccessibility of the `master` database. For example, you might see a log entry that resembles the following:

    ```output
    <Datetime> Server      Error: 17113, Severity: 16, State: 1.  
    <Datetime> Server      Error 2(The system cannot find the file specified.) occurred while opening file
                           'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master.mdf' to obtain configuration information at startup.
                           An invalid startup option might have caused the error. Verify your startup options, and correct or remove them if necessary.
    ```

2. Verify the location of the *master.mdf* file. If the path is incorrect, fix the path by using SQL Server Configuration Manager or Registry Editor.

    1. **By using SQL Server Configuration Manager**:

        Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, point to **Configuration Tools**, and then select **SQL Server Configuration Manager**.

        > [!NOTE]
        > Because SQL Server Configuration Manager is a snap-in for the Microsoft Management Console program and not a standalone program, SQL Server Configuration Manager does not appear as an application in newer versions of Windows. To open SQL Server Configuration Manager in Windows 11, 10, or 8, follow these steps for your version of Windows.

        - Windows 10 and 11:  
            1. Select **Start** Page, enter *SQLServerManager13.msc* (for SQL Server 2016 (13.x)). For different versions of SQL Server, replace 13 with the appropriate number.
            2. Select **SQLServerManager13.msc** to open the Configuration Manager. To pin the Configuration Manager to the Start Page or Task Bar, right-click **SQLServerManager13.msc**, and then select **Open file location**.
            3. In the Windows File Explorer, right-click **SQLServerManager13.msc**, and then select **Pin to Start** or **Pin to taskbar**.

        - Windows 8:  
            Press Windows logo key+Q to open the Search charm. Under Apps, enter *SQLServerManager\<version_number>.msc* (for example, SQLServerManager13.msc), and then press Enter.

        1. In SQL Server Configuration Manager, select **SQL Server Services**.

        1. In the right pane, right-click **SQL Server (\<instance_name>)**, and then select **Properties**.
        1. On the **Startup Parameters** tab, select the row that starts with *-d* in the **Existing Parameters** section. The current value is editable. Specify a startup parameter box. Fix the path to reflect the correct value, select **Update**, and then select **OK** to save the changes.
        1. Restart the SQL Server service.

        - For more information regarding configuring startup options, see [Configure Server Startup Options (SQL Server Configuration Manager)](/sql/database-engine/configure-windows/scm-services-configure-server-startup-options).

        - For more information regarding database engine service startup options, see [Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options).

    2. **By using Registry Editor**:

        1. Navigate to the `HKLM\Software\Microsoft\MicrosoftSQL Server\MSSQL{nn}.MyInstance` hive for your SQL server instance.

        1. Locate the **SQLArg0** value under `MSSQLServer\Parameters`.
        1. Change the value to reflect the correct path for the `master` database.
        1. Restart the SQL Server Service.

3. If the `master` database does exist but is unusable you can return the database to a usable state by using one of the following methods:

    - Check the permissions for the service account on the folder where the file is located.
    - [Restore the master database](/sql/relational-databases/backup-restore/restore-the-master-database-transact-sql) from a full database backup — if you can start the server instance.
    - If server damage to the `master` database prevents you from starting SQL Server, [rebuild the master database](/sql/relational-databases/databases/rebuild-system-databases).

        > [!CAUTION]
        > Rebuilding the `master` database rebuilds all the system databases. Therefore, any user modifications to these databases will be lost.
