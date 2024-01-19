---
title: Troubleshooting linked server connectivity errors
description: This article provides symptoms and resolution for the linked server connectivity errors
ms.date: 12/20/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshooting linked server connectivity issues

This article helps you to resolve the consistent authentication linked server connectivity issue.

## Symptoms

When you connect to the SQL Server account from within the SQL Server Management Studio (SSMS), you might see the following error message:

> Msg 233, Level 20, State 0, Line 0
> A transport-level error has occurred when sending the request to the server. (provider: Shared Memory Provider, error: 0 - No process is on the other end of the pipe.)

When you connect using application developed using .NET, you might see the following error messages:

> The OLE DB provider "MSDASQL" for linked server "SQLPROD02" reported an error. Authentication failed.

> Cannot initialize the data source object of OLE DB provider "MSDASQL" for linked server "SQLPROD02".

If you also see the following error message, it indicates you're using Named Pipes for the linked server connection and a SQL login, and the mid-tier SQL Server service account or machine account doesn't have login rights to Windows on the backend server:

> OLE DB provider "MSDASQL" for linked server "SQLPROD02" returned message [Microsoft][SQL Server Native Client 11.0][SQL Server]Login failed for user 'CONTOSO\SQLPROD01$'.

## Cause

You might encounter these error messages because of the linked server account mapping issue.

## Resolution

You can correct this error by forcing TCP/IP or granting the appropriate permissions. 

In the **Linked Server security** dialog, when you select the **Be made without using a security context** option, the "Login Failed for user NT AUTHORITY\ANONYMOUS LOGON" error is shown. When you select **Be made with this security context**, the SQL login is successful.

In addition to the settings in the **Linked Server security** dialog, you can modify the individual account mappings in the upper portion of the dialog, which overrides the main mapping settings.

> [!NOTE]
> Using a [SQL Server ODBC driver ](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0650-SQL-Server-Linked-Server-Delegation-Issues)in a linked server isn't a supported scenario. Other ODBC drivers might have limited support from Microsoft and mainly from the vendor.
