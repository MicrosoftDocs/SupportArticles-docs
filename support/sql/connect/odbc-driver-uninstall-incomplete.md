---
title: ODBC driver uninstall is incomplete
description: On a Windows computer with both ODBC 17 and ODBC 13 drivers installed, uninstalling either of the driver still leaves the remnants of the uninstalled version. This article provides more information about the problem and the resolution for the same.
ms.date: 02/17/2020
ms.custom: sap:Client Application Development
---
# Driver uninstall leaves remnants when ODBC 13(.1)/17(.1) are both installed on Windows

On a Windows computer with both ODBC 17 and ODBC 13 drivers installed, uninstalling either of the driver still leaves the remnants of the uninstalled version. This article provides more information about the problem and the resolution for the same.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4460005

## Symptoms

Assume you have Microsoft ODBC Driver 13/13.1 for SQL Server and ODBC Driver 17/17.1 for SQL Server installed on the same Windows computer. If you uninstall either version, the uninstalled driver remains visible, but it becomes unusable in ODBC Data Source Administrator (odbcad32.exe). Additionally, some corresponding registry entries remain under the following registry sub key:

`HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBCINST.INI`

## Cause

This problem occurs because of an ODBC 17/17.1 installer issue.

## Resolution

This issue has been fixed in the ODBC 17.2 driver. To fix this issue:

1. Uninstall the ODBC 17/17.1 driver.
2. Install [ODBC 17.2 or a later version of the driver](/sql/connect/odbc/download-odbc-driver-for-sql-server).

## Reference

[Microsoft ODBC Driver 17.2 for SQL Server released](/archive/blogs/sqlnativeclient/odbc-driver-17-2-for-sql-server-released)
