---
title: Invalid directory error when installing SQL CU or SP
description: This article provides resolutions for the problem that occurs when you install a Cumulative Update or a Service Pack for a SQL Server instance.
ms.date: 07/28/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: lramirez, pijocoder
---

# Error that Data or Log directory in the registry is not valid when installing SQL Server Cumulative Update or a Service Pack

This article helps you resolve the problem that occurs when you install a Cumulative Update or a Service Pack for a SQL Server instance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2565113

## Symptoms

When you install a Cumulative Update or a Service Pack for a SQL Server instance, the setup process may fail with one of the following error messages:

```output
The User Data directory in the registry is not valid. Verify DefaultData key under the instance hive points to a valid directory.
Error code: 0x851A0043
```

```output
The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory.
Error code: 0x851A0044
```

```output
Error installing SQL Server Database Engine Services Instance Features. The Database Engine system data directory in the registry is not valid.
```

When the problem occurs, the SQL Server Setup log file *Summary.txt* has one of the following messages:

```output
Detailed results:
  Feature:                       Database Engine Services
  Status:                        Failed: see logs for details
  Reason for failure:            An error occurred during the setup process of the feature.
  Next Step:                     Use the following information to resolve the error, and then try the setup process again.
  Component name:                SQL Server Database Engine Services Instance Features
  Component error code:          0x851A0043
  Error description:             The User Data directory in the registry is not valid. Verify DefaultData key under the instance hive points to a valid directory.
  Error help link:               http://go.microsoft.com/fwlink?LinkId=20476&ProdName=Microsoft+SQL+Server&EvtSrc=setup.rll&EvtID=50000&ProdVer=11.0.7001.0&EvtType=0xD8FB5EBA%400x97A656BB%401306%4067&EvtType=0xD8FB5EBA%400x97A656BB%401306%4067
```

```output
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

The issue happens when the default locations of new data or log files for a database point to an invalid location. Common scenarios that lead to this issue are:

- Change of storage drives for database and log files and missing to update the default data and log location.
- A misconfiguration of the default data or log path during initial installation in the **Data Directories** tab (see [Database Engine Configuration - Data Directories page](/sql/sql-server/install/instance-configuration#-database-engine-configuration---data-directories-page)).
- A misconfiguration of the default data or log path under **Database Settings** in SQL Server Management Studio (see [View or Change the Default Locations for Data and Log Files](/sql/database-engine/configure-windows/view-or-change-the-default-locations-for-data-and-log-files)).

## Resolution

Use the following procedure to resolve the problem.

#### Step 1: Correct the default data and log directories valid folder paths

You can set the default data directory and log directory values to valid folder paths by using either SQL Server Management Studio or Registry Editor.

##### Method 1: Use SQL Server Management Studio (SSMS) and SQL Server Configuration Manager

1. In SSMS, open **Object Explorer**, right-click a server instance and select **Properties**.
1. In the left panel, select the **Database Settings** page.
1. In **Database default locations**, view the current default locations for new data files and new log files.
1. To change the default location, enter a new default pathname in the **Data** or **Log** field, or select the browse button to find and select a pathname.
1. Open SQL Server Configuration Manager and select **SQL Server Services**.
1. Double-click your instance and select the **Advanced** tab.
1. Review the **Data Path** property and see if the value is correct. The value is grayed out and can't be modified from here.
1. If the value is incorrect, use [Method 2](#method-2-use-registry-editor) to update it to the correct path.

##### Method 2: Use registry editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. Serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Start Registry Editor (*Regedit.exe*) from the command line.
1. Locate and then select the registry subkey `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL{nn}.Instance\MSSQLServer`.

   > [!NOTE]
   > In this registry subkey, `MSSQL{nn}.Instance` represents the corresponding value for your system. To obtain this value, locate and then select the registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL\`.

1. In the right panel, select the **DefaultData** registry entry and enter a valid path, if it's pointing to an incorrect location.
1. In the right panel, select the **DefaultLog** registry entry and enter a valid path, if it's pointing to an incorrect location.
1. Locate and then select the registry subkey `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL{nn}.Instance\Setup`.
1. In the right panel, select the **SQLDataRoot** registry entry and enter a valid path, if it's pointing to an incorrect location.

#### Step 2: Retry the installation of Service Pack or Cumulative Update

Once you have corrected the data and log paths for the affected instance, you can retry the installation.

The setup program may show that the instance has already been upgraded and it may not allow you to select just the Database Services component. You need to select all the features for that instance for the setup program to continue.

## References

[View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
