---
title: Troubleshooting an error while creating a linked server after migrating SQL Server to Azure
description: This article provides a resolution to the problem where the linked server can't be created after migrating on-premises SQL Server to Azure.
ms.date: 02/28/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# A linked server couldn't be created after migrating on-premises SQL Server to Azure

This article helps you resolve an issue when you can't create a linked server after you move the on-premises SQL Server to Azure.

## Symptoms

This problem can happen when you use a SQL Server Linked Server to connect from a Windows Server 2022 or later to a SQL Server that's operating on a previous version of Windows.

## Cause

The support for TLS 1.2 can be a possible cause of the problem in connecting to the SQL Server 2012 with the new Azure machines.

You might reproduce the same error:

> [Microsoft OLE DB Driver for SQL Server]: Client unable to Establish connection

> [Microsoft OLE DB Driver for SQL Server]: TCP Provider: An existing connection has been forced to be interrupted by the remote host.

Here, the remote server receives the following TLS messages when attempting to connect to SQL Server:

"An unrecoverable alert was generated and sent to the remote end." - You might see this message when the connection is being terminated. The defined unrecoverable error code of the TLS protocol is 40. The status of the Windows SChannel error is 1205.

"An unrecoverable alert was generated and sent to the remote end." - This might cause the connection to terminate. The TLS protocol defined fatal error code is 40. The Windows SChannel error status is 1205.

## Workaround

To resolve the issue, add the following required registry keys, and update SQL Server to 2012 SP4 so that SQL Server 2022 can connect.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

You might experience the following error message after installing the patches on the SQL Server 2012 machine:

> The language of the SQL Server instance MSSQLSERVER does not match the language expected by the SQL Server update. The language of the installed SQL Server product is \<other Language\> and the expected SQL Server language is English (United States).

To resolve this error, follow these steps:

1. Open PowerShell.

1. Run `Get-WinUserLanguageList` to get the current language list.

1. To set the language as English (United States), run `Set-WinUserLanguageList -LanguageList en-US`.

1. Restart the server.

1. Now, install SQL patch [SQL Server 2012 SP4](https://www.microsoft.com/es-es/download/details.aspx?id=56040).

1. Restart the server again.

    > [!NOTE]
    > Make sure that you have the English (United States) language pack is installed before you run the previous commands.

To check the connectivity using UDL, see [Universal Data Link (UDL) configuration](/sql/connect/oledb/help-topics/data-link-pages).
