---
title: Troubleshoot linked server connectivity errors
description: This article provides a resolution for consistent authentication errors that are related to linked server connectivity.
ms.date: 02/19/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshoot linked server connectivity issues

This article helps you to resolve the consistent authentication linked server connectivity issue.

## Symptoms

When you try to connect to your Microsoft SQL Server account from within SQL Server Management Studio (SSMS), you receive the following error message:

> Msg 233, Level 20, State 0, Line 0
> A transport-level error has occurred when sending the request to the server. (provider: Shared Memory Provider, error: 0 - No process is on the other end of the pipe.)

If you try to connect by using an application that was developed by using .NET technology, you might receive the following error messages:

> The OLE DB provider "MSDASQL" for linked server "SQLPROD02" reported an error. Authentication failed.

> Cannot initialize the data source object of OLE DB provider "MSDASQL" for linked server "SQLPROD02".

You might also receive the following error message:

> OLE DB provider "MSDASQL" for linked server "SQLPROD02" returned message [Microsoft][SQL Server Native Client 11.0][SQL Server]Login failed for user 'CONTOSO\SQLPROD01$'.

This message indicates the following conditions:

- You're using named pipes for the linked server connection.
- You're using a SQL Server login account.
- The mid-tier SQL Server service account or machine account doesn't have login rights to Windows on the back-end server.

## Cause

You might encounter these error messages because of a linked server account mapping issue.

## Resolution

You can correct this error by forcing TCP/IP or granting the appropriate permissions.

In the Linked Server security dialog box, select **Be made with this security context** for a successful SQL Server login.

> [!NOTE]
> When you select **Be made without using a security context** option, you will see the following error message:
> "Login Failed for user NT AUTHORITY\ANONYMOUS LOGON".

In addition to the main mapping settings in the **Linked Server security** dialog box, you can modify the individual account mappings in the upper portion of the box. These override the main mapping settings.

> [!NOTE]
> Using a SQL Server ODBC driver in a linked server isn't a supported scenario. Other ODBC drivers might have primary support from the vendor and only limited support from Microsoft. For more information, see [SQL Server Linked Server Delegation Issues](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0650-SQL-Server-Linked-Server-Delegation-Issues).
