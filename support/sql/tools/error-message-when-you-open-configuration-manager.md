---
title: Cannot Connect to WMI Provider Error in SQL Server
description: Learn how to work around the Cannot connect to WMI provider error when you open SQL Server Configuration Manager by recompiling the provider.
ms.reviewer: yongzhe, randolphwest, jopilov
ms.date: 08/31/2026
ms.custom: sap:SQL Server Management, Query and Data Tools
---
# Cannot connect to WMI provider error in SQL Server Configuration Manager

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956013

## Summary

When you open SQL Server Configuration Manager, you might receive the error **Cannot connect to WMI provider. You do not have permission or the server is unreachable**. The message ends with either `Invalid namespace [0x8004100e]` or `Invalid class [0x80041010]`.

This error occurs when the Windows Management Instrumentation (WMI) provider that SQL Server Configuration Manager depends on is no longer registered. It's most often unregistered when you uninstall an instance or a different version of SQL Server from the same computer.

To fix the error, recompile the SQL Server WMI provider Managed Object Format (MOF) file by using the `mofcomp` tool, or repair the SQL Server installation.

## Symptoms

You receive one of the following error messages when you open SQL Server Configuration Manager (`SQLServerManager<nn>.msc`):

> Cannot connect to WMI provider. You do not have permission or the server is unreachable. Note that you can only manage SQL Server 2005 and later servers with SQL Server Configuration Manager.  
> Invalid namespace [0x8004100e]

or

> Cannot connect to WMI provider. You do not have permission or the server is unreachable, Note that you can only manage SQL Server 2005 and later servers with SQL Server Configuration Manager.  
> Invalid class [0x80041010]

## Cause

SQL Server Configuration Manager uses Windows Management Instrumentation (WMI) to view and change some server settings. When it connects to a server, SQL Server Configuration Manager uses WMI to get the status of the SQL Server (MSSQLSERVER) and SQL Server Agent services. The provider is registered in a WMI namespace that uses the format `root\Microsoft\SqlServer\ComputerManagement<nn>`, where `<nn>` is the two-digit major version number of SQL Server, such as `16` for SQL Server 2022 (16.x).

The error codes indicate that the provider registration is missing rather than that access was denied:

- `Invalid namespace [0x8004100e]` means the `ComputerManagement<nn>` namespace isn't present in the WMI repository.
- `Invalid class [0x80041010]` means the namespace exists, but the classes that SQL Server Configuration Manager expects aren't registered in it.

This registration is removed when you [uninstall an instance of SQL Server](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup), including when you uninstall a different version of SQL Server that shared the same computer. Recompiling the MOF file restores the registration.

## Locate the MOF file for your SQL Server version

The SQL Server WMI provider is defined in a Managed Object Format (MOF) file that's installed in the shared components folder, `%programfiles(x86)%\Microsoft SQL Server\nnn\Shared`. Use the following table to determine the *nnn* value and MOF file name for your version:

| Version | *nnn* | MOF file |
| --- | --- | --- |
| SQL Server 2025 (17.x) | 170 | `sqlmgmprovider.mof` |
| SQL Server 2022 (16.x) | 160 | `sqlmgmprovider.mof` |
| SQL Server 2019 (15.x) | 150 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2017 (14.x) | 140 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2016 (13.x) | 130 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2014 (12.x) | 120 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2012 (11.x) | 110 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2008 R2 (10.50.x) | 100 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2008 (10.0.x) | 100 | `sqlmgmproviderxpsp2up.mof` |
| SQL Server 2005 (9.x) | 90 | `sqlmgmproviderxpsp2up.mof` |

If you're not sure which versions are installed, or if the folder isn't where you expect, list the MOF files across all installed versions from an elevated Command Prompt:

```console
dir "%programfiles(x86)%\Microsoft SQL Server\*.mof" /s
```

For more information about how shared components map to version folders, see [File locations for default and named instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

After you locate the MOF file, use one of the following options to workaround the error.

## Workaround 1: Recompile the SQL Server WMI provider by using mofcomp

Use the [mofcomp](/windows/win32/wmisdk/mofcomp) tool to compile the MOF file and register the WMI provider again:

1. Select **Start**, enter `cmd`, right-click **Command Prompt**, and then select **Run as administrator**.

1. Run `mofcomp` against the full path of the MOF file for your version. Passing the full path avoids a **file not found** error if the command prompt isn't in the MOF file's folder.

    For SQL Server 2022 (16.x) and later versions, enter the following command, and then select **Enter**. Replace `160` with the *nnn* value for your version.

    ```console
    mofcomp "%programfiles(x86)%\Microsoft SQL Server\160\Shared\sqlmgmprovider.mof"
    ```

    For SQL Server 2019 (15.x) and earlier versions, enter the following command, and then select **Enter**. Replace `150` with the *nnn* value for your version.

    ```console
    mofcomp "%programfiles(x86)%\Microsoft SQL Server\150\Shared\sqlmgmproviderxpsp2up.mof"
    ```

    > [!NOTE]  
    > If the command reports that the file can't be found, confirm the exact path and file name by running the `dir` command in [Locate the MOF file for your SQL Server version](#locate-the-mof-file-for-your-sql-server-version). On some installations, the shared components are under `%programfiles%` instead of `%programfiles(x86)%`.

1. Restart the WMI service so that the changes take effect. Open the **Services** app, select **Windows Management Instrumentation**, and then select **Restart**. You can also restart the service by running the following PowerShell command as an administrator:

    ```PowerShell
    Get-Service winmgmt | Restart-Service -Force
    ```

## Workaround 2: Repair your SQL Server installation

If the MOF file is missing from the `Shared` folder, `mofcomp` has nothing to compile. In that case, run SQL Server Setup in repair mode to restore the missing files and registry entries. For step-by-step instructions, see [Repair a failed SQL Server installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation).

> [!NOTE]  
> Use this option only when the MOF file is missing. If the MOF file is present, use [Workaround 1](#workaround-1-recompile-the-sql-server-wmi-provider-by-using-mofcomp) instead, because recompiling it is faster and doesn't require the installation media.

## Related content

- [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager)
- [Working with the WMI Provider for Configuration Management](/sql/relational-databases/wmi-provider-configuration/working-with-the-wmi-provider-for-configuration-management)
- [Configure WMI to show server status in SQL Server tools](/sql/ssms/configure-wmi-to-show-server-status-in-sql-server-tools)
- [SQL Server Configuration Manager: Connect to another computer](/sql/database-engine/configure-windows/scm-services-connect-to-another-computer)
