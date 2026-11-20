---
title: ODBC Administrator Tool Shows 32-bit and 64-bit User DSNs
description: Learn why the 32-bit and 64-bit ODBC Data Source Administrator tools both display user DSNs on 64-bit Windows, and how to avoid DSN architecture errors.
ms.date: 11/13/2026
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# ODBC Administrator tool displays 32-bit and 64-bit user DSNs in 64-bit Windows

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 942976

## Summary

On a 64-bit version of Windows, both the 32-bit and 64-bit ODBC Administrator tools (_Odbcad32.exe_) display all user data source names (DSNs), regardless of driver architecture. This article explains the symptoms and cause of the "Data source name not found and no default driver specified" error that can result, and how to work around it by using the ODBC Administrator tool that matches your application's architecture and adding an architecture suffix to DSN names.

## Symptoms

On 64-bit Windows, both the 32-bit and 64-bit ODBC Administrator tools (_Odbcad32.exe_) display all user data source names (DSNs), regardless of driver architecture. An application that tries to connect through a user DSN for a different architecture might receive an error.

### Symptom 1: Both ODBC Administrator tools display 32-bit and 64-bit user DSNs

- The 32-bit version of the ODBC Administrator tool displays 32-bit system DSNs, 32-bit user DSNs, and 64-bit user DSNs.
- The 64-bit version of the ODBC Administrator tool displays 64-bit system DSNs, 32-bit user DSNs, and 64-bit user DSNs.

### Symptom 2: SQLDataSources returns user DSNs for both architectures

The `SQLDataSources` function returns all versions of user DSNs, regardless of the architecture of the application:

- When called in a 32-bit application, the function returns only system DSNs for 32-bit drivers, but it returns user DSNs for both 32-bit drivers and 64-bit drivers.
- When called in a 64-bit application, the function returns only system DSNs for 64-bit drivers, but it returns user DSNs for both 32-bit drivers and 64-bit drivers.

Therefore, if the application makes a connection by using a user DSN that the `SQLDataSources` function returns, you might receive the following error message:

> Data source name not found and no default driver specified

For example, consider the following scenario. You create a user DSN for the 32-bit driver 'Microsoft Access Driver (*.mdb)'. This driver doesn't have a corresponding 64-bit version. The `SQLDataSources` function that is called in a 64-bit application returns this 32-bit user DSN. However, if you make a connection through this 32-bit user DSN, you receive the error message that is mentioned earlier in this section.

## Cause

The user DSNs are stored under the following registry subkey:

`HKEY_CURRENT_USER\Software\ODBC\ODBC.INI`

Registry redirection isn't enabled for this registry subkey. Therefore, user DSNs are visible in both the 32-bit and 64-bit versions of the ODBC Administrator tool.

## Workaround: Use the ODBC Administrator tool that matches the application architecture

The application and the driver that the DSN uses must have the same architecture. Use the ODBC Administrator tool that matches that architecture:

| Application and driver architecture | ODBC Administrator tool to use |
| --- | --- |
| 32-bit application and 32-bit driver on a 64-bit operating system | `%windir%\SysWOW64\odbcad32.exe` |
| 64-bit application and 64-bit driver | `%windir%\System32\odbcad32.exe` |

> [!NOTE]
> The folder names are counterintuitive. On a 64-bit version of Windows, the _System32_ folder contains the 64-bit tool, and the _SysWOW64_ folder contains the 32-bit tool.

Because both tools display all user DSNs, also ensure that the application uses a DSN that matches its architecture. If you build and then run an application as a 32-bit application on a 64-bit operating system, you need to use the `%windir%\SysWOW64\odbcad32.exe` ODBC Administrator tool to create the ODBC data source. To indicate the type of DSN, you can add '_32' to the 32-bit user DSNs and '_64' to the 64-bit user DSNs.

If you use the 64-bit ODBC Administrator tool to configure or remove a DSN that connects to a 32-bit driver, you receive the following error message:

> The specified DSN contains an architecture mismatch between the Driver and Application

To resolve this error, use the 32-bit ODBC Administrator tool to configure or remove the DSN. For more information about managing data sources, see [Managing data sources](/sql/odbc/admin/managing-data-sources).

### Open the ODBC Administrator tool

Use one of the following methods to open the ODBC Administrator tool:

- **Windows Search**: Select **Start**, type **ODBC Data Sources**, and then select **ODBC Data Sources (64-bit)** or **ODBC Data Sources (32-bit)**.
- **Run dialog box**: Press **Windows+R**, type `odbcad32.exe`, and then select **OK**. This command opens the 64-bit version on x64-based systems. To open the 32-bit version, enter the full path `%windir%\SysWOW64\odbcad32.exe`.
- **Control Panel**: Open **Control Panel** > **Administrative Tools** > **ODBC Data Sources**.

## More information about DSN storage and registry redirection

Invoke the 64-bit ODBC Administrator tool from Control Panel to manage user DSNs and system DSNs that 64-bit processes use. On a 64-bit operating system, use the 32-bit ODBC Administrator tool for Windows on Windows 64 (WOW64) processes. You must directly invoke the 32-bit ODBC Administrator tool from the _SysWoW64_ folder. Use the 32-bit ODBC Administrator tool to manage user DSNs and system DSNs that WOW64 processes use.

System DSNs are stored in the following registry subkey:

`HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI`

Registry redirection is enabled for this registry subkey. Therefore, system DSNs for 32-bit drivers and for 64-bit drivers are separated. The 64-bit ODBC Administrator tool doesn't display system DSNs that the 32-bit ODBC Administrator tool creates. Similarly, the 32-bit ODBC Administrator tool doesn't display system DSNs that the 64-bit ODBC Administrator tool creates. Also, the 64-bit ODBC Administrator tool doesn't display system DSNs that use 32-bit drivers. Similarly, the 32-bit ODBC Administrator tool doesn't display system DSNs that use 64-bit drivers.

User DSNs are stored in the following registry subkey:

`HKEY_CURRENT_USER\Software\ODBC\ODBC.INI`

Registry redirection isn't enabled for this registry subkey. Therefore, both ODBC Administrator tools display all user DSNs.

For more information about registry redirection, see [Registry Redirector](/windows/win32/winprog64/registry-redirector).

## Related content

- [Registry keys affected by WOW64](/windows/win32/winprog64/shared-registry-keys)
- [Data source names and 64-bit operating systems](/sql/relational-databases/native-client/odbc/data-source-names-and-64-bit-operating-systems)
- [Microsoft ODBC Driver for SQL Server](/sql/connect/odbc/microsoft-odbc-driver-for-sql-server)
