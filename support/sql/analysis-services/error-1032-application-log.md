---
title: Error 1032 in the application log
description: This article provides a workaround for the problem that occurs when you try to run instances of SQL Server or SQL Server Analysis Services on a computer that is running Windows Server 2012.
ms.date: 11/04/2020
ms.reviewer: ramakoni
ms.custom: sap:Analysis Services
ms.prod: sql
---
# Error 1032 messages in the application log in Windows Server 2012

This article helps you resolve the problem that occurs when you try to run instances of SQL Server or SQL Server Analysis Services on a computer that is running Windows Server 2012.

_Original product version:_ &nbsp; SQL Server Analysis Services, SQL Server  
_Original KB number:_ &nbsp; 2811566

## Symptoms

Consider the following scenario:

- You install Microsoft SQL Server or SQL Server Analysis Services on a computer that is running Windows Server 2012.
- You use the default account as a service account for these applications during the installation.
- The installation is successful.
- After the installation, the services for these programs start successfully.

In this scenario, you may find error messages in the Application log that resemble the following:

- For instances of SQL Server (SQLServr.exe)

  > sqlservr (3472) An attempt to open the file "C:\Windows\system32\LogFiles\Sum\Api.log" for read only access failed with system error 5 (0x00000005): "Access is denied. ". The open file operation will fail with error -1032 (0xfffffbf8).  
    sqlservr (3472) Error -1032 (0xfffffbf8) occurred while opening logfile C:\Windows\system32\LogFiles\Sum\Api.log.

- For instances of SQL Server Analysis Services (Msmdsrv.exe)  

  > msmdsrv (4680) An attempt to open the file "C:\Windows\system32\LogFiles\Sum\Api.chk" for read / write access failed with system error 5 (0x00000005): "Access is denied. ". The open file operation will fail with error -1032 (0xfffffbf8).  
  msmdsrv (4680) Error -1032 (0xfffffbf8) occurred while opening logfile C:\Windows\system32\LogFiles\Sum\Api.log.

## Cause

This problem occurs because of insufficient permissions for the service startup accounts for SQL Server and for SQL Server Analysis Services when the services access the following folder for logging as a part of the Software Usage Metrics feature:

`C:\Windows\System32\LogFiles\Sum`

## Workaround

To work around this problem, add read/write permissions manually to the service accounts that are used by SQL Server (sqlservr.exe) and SQL Server Analysis Services (msmdsrv.exe) to access the `\Windows\System32\LogFiles\Sum` folder.

## More information

The Software Usage Metrics feature uses the User Access Logging Service in Windows Server 2012. For more information, see [User Access Logging Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh849634(v=ws.11)).
