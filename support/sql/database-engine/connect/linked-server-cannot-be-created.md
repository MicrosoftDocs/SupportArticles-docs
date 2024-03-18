---
title: Linked server couldn't be created after moving on-premises SQL Server to Azure
description: This article provides a resolution to a problem in which a linked server can't be created after you migrate on-premises SQL Server to Azure.
ms.date: 03/18/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# A linked server couldn't be created after transition to a Windows 2022 OnPrem or Azure VM

This article helps you resolve a problem in which you try to create a linked server after you move an instance of Microsoft SQL Server to Azure.

## Symptoms

This problem can occur if you are connecting from a Windows Server 2022 or later to a SQL Server running on a lower version of Windows using the SQL Server Linked Server functionality.

## Cause

The presence of support for TLS 1.2 can be a possible cause of the problem in connecting to the SQL Server 2012 with the Azure virtual machines.

You might receive the following error messages:

> [Microsoft OLE DB Driver for SQL Server]: Client unable to Establish connection

> [Microsoft OLE DB Driver for SQL Server]: TCP Provider: An existing connection has been forced to be interrupted by the remote host.

Here, the remote server receives the TLS messages when the server tries to connect to SQL Server:

- An unrecoverable alert was generated and sent to the remote end. You might see this message when the connection is terminated. The defined unrecoverable error code of the TLS protocol is **40**. The status of the Windows SChannel error is **1205**.

- An unrecoverable alert was generated and sent to the remote end. This error might terminate the connection. The TLS protocol defined fatal error code is **40**. The Windows SChannel error status is **1205**.

## Resolution

To resolve this problem, add the following required registry keys, and update SQL Server to 2012 SP4 so that SQL Server 2022 can connect to it.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

You might receive the following error message after you install updates on the SQL Server 2012-based server:

> The language of the SQL Server instance MSSQLSERVER does not match the language expected by the SQL Server update. The language of the installed SQL Server product is \<other Language\> and the expected SQL Server language is English (United States).

To resolve this error, follow these steps.

  > [!NOTE]
  > Make sure that you have the English (United States) language pack installed before you run the commands in this procedure.

1. Open PowerShell.

1. To get the current language list, run `Get-WinUserLanguageList`.

1. To set the language as English (United States), run `Set-WinUserLanguageList -LanguageList en-US`.

1. Restart the server.

1. Install the [SQL Server 2012 SP4](https://www.microsoft.com/es-es/download/details.aspx?id=56040) update.

1. Restart the server again.

To check the connectivity by using UDL, see [Universal Data Link (UDL) configuration](/sql/connect/oledb/help-topics/data-link-pages).

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
