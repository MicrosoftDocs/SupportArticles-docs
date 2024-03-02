---
title: Troubleshooting an error when you try to create a linked server after migrating SQL Server to Azure
description: This article provides a resolution to a problem in which a linked server can't be created after you migrate on-premises SQL Server to Azure.
ms.date: 02/28/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Can't create a linked server after migrating on-premises SQL Server to Azure

This article helps you resolve a problem in which you can't create a linked server after you move an instance of Microsoft SQL Server to Azure.

## Symptoms

After you migrate on-premises SQL Server to Azure, you can't create a linked server. This problem might occur if you use a SQL Server linked server to connect from a server that's running Windows Server 2022 or a later version to an instance of SQL Server that's running on an earlier version of Windows Server.

## Cause

The support for TLS 1.2 can be a possible cause of the problem in connecting to the SQL Server 2012 with the new Azure machines.

You might reproduce the same error:

> [Microsoft OLE DB Driver for SQL Server]: Client unable to Establish connection

> [Microsoft OLE DB Driver for SQL Server]: TCP Provider: An existing connection has been forced to be interrupted by the remote host.

Here, the remote server receives the following TLS messages when it tries to connect to SQL Server:

"An unrecoverable alert was generated and sent to the remote end." 

Note: You might see this message when the connection is terminated. The defined unrecoverable error code of the TLS protocol is **40**. The status of the Windows SChannel error is **1205**.

"An unrecoverable alert was generated and sent to the remote end."

Note: This error might cause the connection to terminate. The TLS protocol defined fatal error code is **40**. The Windows SChannel error status is **1205**.

## Resolution

To resolve this problem, add the following required registry keys, and update SQL Server to 2012 SP4 so that SQL Server 2022 can make the connection.

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
