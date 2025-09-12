---
title: Error connecting higher SQL Server version to lower SQL Server version
description: This article provides a resolution for the challenge of connecting higher to lower version of SQL Server using SQL Server Linked Server functionality.
ms.date: 04/30/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, aartigoyle, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# Error connecting higher to lower version of SQL Server using SQL Server Linked Server functionality

This article helps you to find the solution of connectivity issue using SQL Server Linked Server functionality from a Windows Server 2022 or newer to a SQL Server hosted on an older version of Windows.

## Symptoms

This problem can occur if you are connecting from a Windows Server 2022 or later to a SQL Server running on a lower version of Windows using the SQL Server Linked Server functionality.

You might receive one of the following error messages:

> [Microsoft OLE DB Driver for SQL Server]: Client unable to Establish connection

> [Microsoft OLE DB Driver for SQL Server]: TCP Provider: An existing connection has been forced to be interrupted by the remote host.

Here, the remote server receives the TLS messages when the server tries to connect to SQL Server. An unrecoverable alert is generated and sent to the remote end. This error might terminate the connection. The TLS protocol defined fatal error code is **40**. The Windows Schannel error status is **1205**.

## Cause

The presence of support for TLS 1.2 can be a possible cause of the problem in connecting to the SQL Server 2012 with the Azure virtual machines.

## Resolution

To resolve this problem, add the following required registry keys, and update SQL Server to 2012 SP4 so that SQL Server 2022 can connect to it.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

You might receive the following error message after you install updates on the SQL Server 2012-based server:

> The language of the SQL Server instance MSSQLSERVER does not match the language expected by the SQL Server update. The language of the installed SQL Server product is \<other Language\> and the expected SQL Server language is English (United States).

To resolve this error, follow these steps.

  > [!NOTE]
  > Ensure that you have the English (United States) language pack installed before you run the commands in this procedure.

1. Open PowerShell.

1. To get the current language list, run the following command:

   `Get-WinUserLanguageList`

1. To set the language as English (United States), run the following command:

   `Set-WinUserLanguageList -LanguageList en-US`

1. Restart the server.

1. Install the [SQL Server 2012 SP4](https://www.microsoft.com/es-es/download/details.aspx?id=56040) update.

1. Restart the server again.

To check the connectivity by using UDL, see [Universal Data Link (UDL) configuration](/sql/connect/oledb/help-topics/data-link-pages).

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
