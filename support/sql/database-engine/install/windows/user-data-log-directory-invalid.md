---
title: Invalid directory error when installing SQL CU or SP
description: This article provides resolutions for the problem that occurs when you install a Cumulative Update or a Service Pack for a SQL Server instance.
ms.date: 09/25/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: lramirez
ms.prod: sql
---
# The User Data directory in the registry is not valid error message when installing SQL Server Cumulative Update or a Service Pack

This article helps you resolve the problem that occurs when you install a Cumulative Update or a Service Pack for a SQL Server instance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2565113

## Symptoms

When installing a Cumulative Update or a Service Pack for a SQL Server instance, the setup process may fail with one of the following error messages

 > The User Data directory in the registry is not valid. Verify DefaultData key under the instance hive   points to a valid directory.
  >
  > Error code: 0x851A0043

 > The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive  points to a valid directory.
  >
  > Error code: 0x851A0044

When The problem occurs, the SQL Server Setup log file *Summary.txt* has messages similar to one of the following:

 ```console
  Detailed results:

      Feature:                       Database Engine Services

      Status:                        Failed: see logs for details

      Reason for failure:            An error occurred during the setup process of the feature.

      Next Step:                     Use the following information to resolve the error, and then try the setup process again.

      Component name:                SQL Server Database Engine Services Instance Features

      Component error code:          0x851A0043

      Error description:             The User Data directory in the registry is not valid. Verify DefaultData key under the instance hive points to a valid directory.

      Error help link:               http://go.microsoft.com/fwlink?LinkId=20476&ProdName=Microsoft+SQL+Server&EvtSrc=setup.rll&EvtID=50000&ProdVer=11.0.7001.0&EvtType=0xD8FB5EBA%400x97A656BB%401306%4067&EvtType=0xD8FB5EBA%400x97A656BB%401306%4067
  ```

 ```console
  Detailed results:

  Feature:                       Database Engine Services

  Status:                        Failed: see logs for details

  Reason for failure:            An error occurred during the setup process of the feature.

  Next Step:                     Use the following information to resolve the error, and then try the setup process again.

  Component name:                SQL Server Database Engine Services Instance Features

  Component error code:          0x851A0044

  Error description:             The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory.

  Error help link:               http://go.microsoft.com/fwlink?LinkId=20476&ProdName=Microsoft+SQL+Server&EvtSrc=setup.rll&EvtID=50000&ProdVer=11.0.7001.0&EvtType=0xD8FB5EBA%400x97A656BB%401306%4068&EvtType=0xD8FB5EBA%400x97A656BB%401306%4068
  ```

## Cause

The issue happens when the default locations for new data or log files for a database point to an invalid location.

## Resolution

Use the following procedure to resolve the problem.

- Step 1: Set the default data directory value and the default log directory value to valid folder paths.

    You can set the default data directory value and the default log directory value by using either SQL Server Management Studio or Registry Editor.

  - Method 1: Use SQL Server Management Studio

    1. In **Object Explorer**, right-click a server and click **Properties**.
    2. In the left panel, click the **Database** settings page.
    3. In **Database** default locations, view the current default locations for new data files and new log files. To change a default location, enter a new default pathname in the Data or Log field, or click the browse button to find and select a pathname.

  - Method 2 : Using registry editor:

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    1. Start Registry Editor (Regedt32.exe) from the command line.
    2. Locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<MSSQL.x>\MSSQLServer`.

        > [!NOTE]
        > In this registry subkey, <MSSQL.x> represents the corresponding value for your system. To obtain this value, locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL\`

    3. In the right panel, click the **DefaultData** registry entry and enter a valid path (if it is pointing to an incorrect location).
    4. In the right panel, click the **DefaultLog** registry entry and enter a valid path (if it is pointing to an incorrect location).

    > [!NOTE]
    > The best practice for protecting your data files and log files is to ensure that they are protected by access control lists (ACLs). The ACLs should be set on the directory root under which the files are created.

- Step 2: Retry the installation of Service Pack or Cumulative Update for the affected instance.

  > [!NOTE]
  > The setup program will show that the instance has already been upgraded and it will not allow you to select just the Database Services component. You need to select all the features for that instance for the setup program to proceed.

## References

[View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
