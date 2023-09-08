---
title: Error when Database mail fails to send message
description: This article provides a resolution for the problem where Database mail fails to send a message.
ms.date: 09/10/2020
ms.custom: sap:Administration and Management
ms.reviewer: nathansc
---

# 'The transaction not longer valid' error when Database mail fails to send a message in SQL Server

This article helps you resolve the problem where Database mail fails to send a message.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2014, SQL Server 2016, SQL Server 2017 on Linux, SQL Server 2017 on Windows  
_Original KB number:_ &nbsp; 4502457

## Symptoms

Assume that a user who is running Microsoft SQL Server cannot send Database Mail. In this situation, the Database mail log (sysmail_event_log) shows the following entry:

> **Exception Information:** Exception Type: Microsoft.SqlServer.Management.SqlIMail.Server.Common.BaseException  
Message: The Transaction not longer valid.  
Data: System.Collections.ListDictionaryInternal  
TargetSite: Void ValidateConnectionAndTransaction()  
HelpLink: NULL  
Source: DatabaseMailEngine  
**StackTrace Information:** at Microsoft.SqlServer.Management.SqlIMail.Server.DataAccess.ConnectionManager.ValidateConnectionAndTransaction()  
at Microsoft.SqlServer.Management.SqlIMail.Server.DataAccess.ConnectionManager.RollbackTransaction()  
at Microsoft.SqlServer.Management.SqlIMail.IMailProcess.QueueItemProcesser.GetDataFromQueue(DataAccessAdapter da, Int32 lifetimeMinimumSec)  
at Microsoft.SqlServer.Management.SqlIMail.IMailProcess.QueueItemProcesser.ProcessQueueItems(String dbName, String dbServerName, Int32 lifetimeMinimumSec, LogLevel loggingLevel, Byte[] encryptionKey, Int32 connectionTimeout)',@proc

> [!NOTE]
>
> - The phrase **not longer valid** appears this way in the **Message** field to mean that the transaction **is no longer valid**.
> - You may see the same message in the Application log. The mail message will stay in "retry" state in `sysmail_unsentitems`, and will remain unsent until the DatabaseMail.exe external program can run successfully.

## Cause

The SQL Server default connection option uses **SET NUMERIC_ARITHABORT ON**. When you run `sp_send_dbmail`, the mail message is queued to **ExternalMailQueue**. When a message appears in the queue, the activation stored procedure triggers the DatabaseMail.exe external executable. When **DatabaseMail.exe** is connected to SQL Server, it runs `sp_readrequest` in order to read messages from the queue. During the execution of `sp_readrequest`, you may notice that the exception occurs.
The following `SELECT` statement is run in `sp_readrequest` (you have to collect statement-level tracing to see this `SELECT` statement):

```SQL
DatabaseMail - DatabaseMail - Id\<ProcessId>        \<NTUserName>        \<SPID>                \<StartTime>              msdb        \<LoginSid>  \<SessionLoginName>
-- network protocol: TCP/IP
set quoted_identifier on
set arithabort off
set numeric_roundabort on
set ansi_warnings on
set ansi_padding on
set ansi_nulls on
set concat_null_yields_null on
set cursor_close_on_commit off
set implicit_transactions off
set language us_english
set dateformat mdy
set datefirst 7
set transaction isolation level read committed
2 - Pooled        1        1 - Non-DAC
RPC:Starting <BinaryData> 4 <NTUserName> DatabaseMail - DatabaseMail - Id<ProcessId> <NTUserName> <SPID> <StartTime> sp_readrequest msdb <LoginSid> <SessionLoginName> exec sp_readrequest @receive_timeout=600000

SP:StmtStarting <BinaryData> 4 <NTUserName> DatabaseMail - DatabaseMail - Id<ProcessId> <NTUserName> <SPID> <StartTime> sp_readrequest msdb <LoginSid> <SessionLoginName>

SELECT @mailitem_id = MailRequest.Properties.value('(MailItemId)[1]', 'int')  
FROM @xmlblob.nodes('
declare namespace requests="https://schemas.microsoft.com/databasemail/requests]";/requests:SendMail')

AS MailRequest(Properties)
If SET NUMERIC_ARITHABORT ON is set as default connection option, this SELECT statement will encounter error 1934 and an exception will occur:

Exception 4 <servername> DatabaseMail - DatabaseMail - Id<ProcessId> <NTUserName> <SPID> <StartTime> 1934 msdb <LoginSid> <SessionLoginName> SELECT failed because the following SET options have incorrect settings:  
'NUMERIC_ROUNDABORT'.  
Verify that SET options are correct for use with indexed views and/or indexes on computed columns and/or filtered indexes and/or query notifications and/or XML data type methods and/or spatialindex operations.
```

When DatabaseMail.exe encounters the exception, a rollback is tried but fails. The exception causes the transaction to go out of scope. For this reason, a **transaction not longer valid** message is logged in the Database Mail log.

However, the root cause of the problem is that Error 1934 occurs because of an incompatible **SET** option when the XML data type method (`MailRequest.Properties.value('(MailItemId)[1]', 'int')`) is used in the `SELECT` statement.

## Verify the error message

- Check whether the error message in the Database Mail log is the same message (**The Transaction not longer valid**).

- Gather a profiler trace by having Statement-level events, Errors and Warnings, and Broker events enabled.

- Check the SQL Server instance setting for the default connection options. To do this, open **SQL Server Management Studio**, right-click **Server**, and then select **Properties** > **Connections** > **Default connection options** > **numeric round abort**.

## Resolution

To resolve this problem, change the default connection option to **SET NUMERIC_ROUNDABORT OFF**.
