---
title: Error if you change password when you log on to Dynamics GP
description: Explains that you may receive an error message when you use the Enforce Password Change feature in Microsoft Dynamics GP 9.0 and then you try to change the password when you log on to Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: jayneb, kyouells
ms.date: 03/13/2024
---
# Error message if you try to change the password when you log on to Microsoft Dynamics GP 9.0: "The password change failed for an unknown reason. Enter a different password or contact your system administrator"

This article provides a solution to an error that occurs when you change the password when you log on to Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 913823

## Symptoms

Consider the following scenario. You use the Enforce Password Change feature in Microsoft Dynamics GP 9.0. You try to change the password when you log on to Microsoft Dynamics GP 10.0 or on to Microsoft Dynamics GP 9.0. In this scenario, you may receive the following error message:

> The password change failed for an unknown reason. Enter a different password or contact your system administrator

## Cause

This issue occurs because you are not using an Open Database Connectivity (ODBC) connection. You must set up the ODBC connection by using the SQL Native Client driver for Microsoft SQL Server 2005.

## Resolution

To resolve this issue, use the SQL Native Client driver to set up a new ODBC connection.

To obtain the SQL Native Client driver, use one of the following methods:

- Download the SQL Native Client.
- Run the Sqlncli.msi program from the Microsoft SQL Server 2005 CD.

## More information

The Enforce Password Change feature only works in Microsoft Dynamics GP 9.0 when the following conditions are true:

- You are in a Microsoft Windows Server 2003 domain.
- You are using SQL Server 2005.

If you do not use this password feature, you do not have to install the SQL Native Client driver to connect to Microsoft Dynamics GP 9.0 databases.

## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [919345](https://support.microsoft.com/help/919345) Error message when you try to log on to Microsoft Dynamics GP: "This login failed. Attempt to log in again or contact your system administrator"

- [922456](https://support.microsoft.com/help/922456) Frequently asked questions about the advanced SQL Server options in the User Setup window in Microsoft Dynamics GP  

For more information about how to set up a new ODBC connection, click the following article number to view the article in the Microsoft Knowledge Base:

[870416](https://support.microsoft.com/help/870416) ODBC setup on SQL Server 2005, SQL Server 2000, SQL Server 7.0, and SQL Server Desktop Engine 2000 (MSDE)
