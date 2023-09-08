---
title: ODBC tool displays both 32-bit and 64-bit
description: This article provides workaround for the problem that occurs in the ODBC Data Source Administrator tool.
ms.date: 12/07/2020
ms.custom: sap:MDAC and ADO 
---
# ODBC Administrator tool displays both the 32-bit and the 64-bit user DSNs in a 64-bit version of Windows

This article provides workaround for the problem that occurs in the ODBC Data Source Administrator tool.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 942976

## Symptoms

A 64-bit version of the Microsoft Windows operating system includes the following versions of the ODBC Data Source Administrator tool (_Odbcad32.exe_):

- The 32-bit version of the _Odbcad32.exe_ file is located in the `%systemdrive%\Windows\System32` folder.
- The 64-bit version of the _Odbcad32.exe_ file is located in the `%systemdrive%\Windows\SysWoW64` folder.

The _Odbcad32.exe_ file displays the following types of data source names (DSNs):

- System DSNs
- User DSNs

### Symptom 1

The 32-bit version of the ODBC Administrator tool displays 32-bit system DSNs, 32-bit user DSNs, and 64-bit user DSNs. The 64-bit version of the ODBC Administrator tool displays 64-bit system DSNs, 32-bit user DSNs, and 64-bit user DSNs.

### Symptom 2

The `SQLDataSources` function returns all versions of user DSNs, regardless of the architecture of the application. The `SQLDataSources` function that is called in a 32-bit application returns only system DSNs for 32-bit drivers but returns user DSNs for both 32-bit drivers and 64-bit drivers. Similarly, the `SQLDataSources` function that is called in a 64-bit application returns only system DSNs for 64-bit drivers but returns user DSNs for both 32-bit drivers and 64-bit drivers. Therefore, if the application makes a connection by using a user DSN that is returned from the `SQLDataSources` function, you may receive the following error message:

> Data source name not found and no default driver specified

For example, consider the following scenario. You create a user DSN for the 32-bit driver 'Microsoft Access Driver (*.mdb)'. This driver doesn't have a corresponding 64-bit version. The `SQLDataSources` function that is called in a 64-bit application returns this 32-bit user DSN. However, if you make a connection through this 32-bit user DSN, you receive the error message that is mentioned earlier in this section.

## Cause

The user DSNs are stored under the following registry subkey:

`HKEY_CURRENT_USER\Software\ODBC\ODBC.INI`

Registry redirection isn't enabled for this registry subkey. Therefore, user DSNs are visible in both the 32-bit and 64-bit versions of the ODBC Administrator tool.

## Resolution

To maintain backward compatibility, no resolution for this problem is currently available.

## Workaround

To work around this problem, use the appropriate version of the ODBC Administrator tool. If you build and then run an application as a 32-bit application on a 64-bit operating system, you need to use the `%windir%\SysWOW64\odbcad32.exe` ODBC Administrator tool to create the ODBC data source. To indicate the type of DSN, you can add '_32' to the 32-bit user DSNs and '_64' to the 64-bit user DSNs.

## More information

The 64-bit ODBC Administrator tool can be invoked from Control Panel to manage user DSNs and system DSNs that are used by 64-bit processes. On a 64-bit operating system, the 32-bit ODBC Administrator tool is used for Windows on Windows 64 (WOW64) processes. You must directly invoke the 32-bit ODBC Administrator tool from the _SysWoW64_ folder. You can use the 32-bit ODBC Administrator tool to manage user DSNs and system DSNs that are used by WOW64 processes.

System DSNs are stored in the following registry subkey:

`HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI`

Registry redirection is enabled for this registry subkey. Therefore, system DSNs for 32-bit drivers and for 64-bit drivers are separated. The 64-bit ODBC Administrator tool doesn't display system DSNs that are created by the 32-bit ODBC Administrator tool. Similarly, the 32-bit ODBC Administrator tool doesn't display system DSNs that are created by the 64-bit ODBC Administrator tool. Also, the 64-bit ODBC Administrator tool doesn't display system DSNs that use 32-bit drivers. Similarly, the 32-bit ODBC Administrator tool doesn't display system DSNs that use 64-bit drivers.

User DSNs are stored in the following registry subkey:

`HKEY_CURRENT_USER\Software\ODBC\ODBC.INI`

Registry redirection isn't enabled for this registry subkey. Therefore, both ODBC Administrator tools display all user DSNs.

For more information about registry redirection, see [Registry Redirector](/windows/win32/winprog64/registry-redirector).
