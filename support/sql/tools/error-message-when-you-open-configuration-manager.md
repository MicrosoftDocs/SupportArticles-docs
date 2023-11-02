---
title: Error occurs when you open Configuration Manager
description: This article provides workarounds for the problem that occurs when you open SQL Server Configuration Manager.
ms.reviewer: yongzhe, randolphwest
ms.date: 02/23/2023
ms.custom: sap:Other tools
---
# Error message when you open SQL Server Configuration Manager in SQL Server: Cannot connect to WMI provider. You do not have permission or the server is unreachable

This article helps you work around the problem that occurs when you open SQL Server Configuration Manager.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956013

## Symptoms

You may receive one of the following error messages when you open SQL Server Configuration Manager:

> Cannot connect to WMI provider. You do not have permission or the server is unreachable. Note that you can only manage SQL Server 2005 and later servers with SQL Server Configuration Manager.  
> Invalid namespace [0x8004100e]

or

> Cannot connect to WMI provider. You do not have permission or the server is unreachable, Note that you can only manage SQL Server 2005 and later servers with SQL Server Configuration Manager.  
> Invalid class [0x80041010]

## Cause

SQL Server Configuration Manager use Window Management Instrumentation (WMI) to view and change some server settings. When connecting to servers, SQL Server Configuration Manager uses WMI to obtain the status of the SQL Server (MSSQLSERVER) and SQL Server Agent services. This problem occurs because the WMI provider is removed when you uninstall an instance of SQL Server.

This file is located in the `%programfiles(x86)%` folder.

## Workaround

The MOF file for your SQL instance is found in the `%programfiles(x86)%\Microsoft SQL Server\nnn\Shared` folder. Determine the location of the MOF file for your version, using the following table as a reference:

| Version | _nnn_ | MOF |
| --- | --- | --- |
| Microsoft SQL Server 2022 | 160 | `sqlmgmprovider.mof` |
| Microsoft SQL Server 2019 | 150 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2017 | 140 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2016 | 130 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2014 | 120 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2012 | 110 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2008 R2 | 100 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2008 | 100 | `sqlmgmproviderxpsp2up.mof` |
| Microsoft SQL Server 2005 | 90 | `sqlmgmproviderxpsp2up.mof` |

You can use one of the following options to solve the problem.

### Option 1: Recompile SQL WMI provider using mofcomp (Managed Object Format (MOF) compiler)

Use the following procedure:

1. Open an elevated command prompt, and change the directory to the folder location from Step 1.

1. For SQL Server 2022 and later versions, type the following command, and then press **Enter**:

    ```console
    mofcomp "sqlmgmprovider.mof"
    ```

   For SQL Server 2019 and earlier versions, type the following command, and then press **Enter**:

    ```console
    mofcomp "sqlmgmproviderxpsp2up.mof"
    ```

    > [!NOTE]  
    > For this command to succeed, the MOF file must be present in the `%programfiles(x86)%\Microsoft SQL Server\nnn\Shared` folder.

1. After you run the **mofcomp** tool, restart the WMI service for the changes to take effect. To do this, open **Services** application, select **Windows Management Instrumentation**, and then select **Restart**. You can also restart the WMI service by running the following PowerShell command as administrator:

    ```PowerShell
    Get-Service winmgmt | Restart-Service -Force
    ```

### Option 2: Repair your SQL Server installation. For further information review Repair a Failed SQL Server Installation

> [!NOTE]  
> This option is only required if the MOF is missing from the `%programfiles(x86)%\Microsoft SQL Server\nnn\Shared` location.

## See also

- [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager)
- [Configure WMI to Show Server Status in SQL Server Tools](/sql/ssms/configure-wmi-to-show-server-status-in-sql-server-tools)
