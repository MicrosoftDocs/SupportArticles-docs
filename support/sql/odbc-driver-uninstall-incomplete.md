---
title: ODBC driver uninstall is incomplete
description: This article describes that you can't uninstall ODBC driver completely if you installed ODBC Driver 17/17.1 on Windows. The resolution is provided.
ms.date: 02/17/2020
ms.prod-support-area-path:
---

# Driver uninstall leaves remnants when ODBC 13(.1)/17(.1) are both installed on Windows

**Applies to**: ODBC Driver for SQL Server

_Original product version:_ &nbsp; 16, 17  
_Original KB number:_ &nbsp; 4460005

## Symptoms

Assume you have Microsoft ODBC Driver 13/13.1 for SQL Server and ODBC Driver 17/17.1 for SQL Server installed on the same Windows computer. If you uninstall either version, the uninstalled driver remains visible, but it becomes unusable in ODBC Data Source Administrator (odbcad32.exe). Additionally, some corresponding registry entries remain under the following registry sub key:

`HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBCINST.INI`

## Cause

This problem occurs because of an ODBC 17/17.1 installer issue.

## Resolution

This issue has been fixed in the ODBC 17.2 driver. To fix this issue:

1. Uninstall the ODBC 17/17.1 driver.
2. Install [ODBC 17.2 or a later version of the driver](https://www.microsoft.com/download/details.aspx?id=56567).

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in **Applies to**.

## Reference

[Microsoft ODBC Driver 17.2 for SQL Server released](https://blogs.msdn.microsoft.com/sqlnativeclient/2018/07/11/odbc-driver-17-2-for-sql-server-released/)
