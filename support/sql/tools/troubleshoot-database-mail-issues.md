---
title: Troubleshoot Database Mail issues
description: Describes how to configure Database Mail and send the test mail. Provides troubleshooting methods for the Database Mail issues.
ms.date: 12/22/2021
ms.custom: sap:Other tools
author: pijocoder
ms.author: nathansc
---
# Troubleshoot Database Mail issues

This article provides methods for troubleshooting Database Mail issues. If [initial troubleshooting](#initial-database-mail-troubleshooting) has not resolved your issue, use [advanced troubleshooting](#advanced-database-mail-troubleshooting).

## Initial Database Mail troubleshooting

Here are basic troubleshooting steps:

1. Review the Database Mail log and sysmail (`sysmail_event_log`) views for mails that have already been sent or attempted to send by using *DatabaseMail.exe*.
1. Send a test mail. If the test mail is successfully sent, then focus on the details of the messages that aren't sent. If the test mail isn't sent, focus on troubleshooting the test mail and ignore the mails that are unsuccessfully sent before.
1. If you suspect that the SMTP server settings are incorrect or there is a problem with the account that's used to send the mail, use PowerShell to send a test mail.
1. If you fail to send the mail by using PowerShell, it's likely to be an SMTP configuration issue and an SMTP administrator is needed.

You can use the following steps for initial Database Mail troubleshooting.

### Msdb sysmail system views

Before looking at the detailed steps, here is a quick summary of the relevant Database Mail system views.

1. Most relevant logging occurs in the **msdb** sysmail system view. You can query these views directly in your environment.

    |Name  |Type  |Description  |
    |---------|---------|---------|
    |[sysmail_allitems](/sql/relational-databases/system-catalog-views/sysmail-allitems-transact-sql) |View|Lists all messages that are submitted to Database Mail.|
    |[sysmail_event_log](/sql/relational-databases/system-catalog-views/sysmail-event-log-transact-sql) |View|Lists messages about the behavior of the [Database Mail external program](/sql/relational-databases/database-mail/database-mail-external-program).|
    |[sysmail_faileditems](/sql/relational-databases/system-catalog-views/sysmail-faileditems-transact-sql) |View|    Information about messages that Database Mail could not send.|
    |[sysmail_mailattachments](/sql/relational-databases/system-catalog-views/sysmail-mailattachments-transact-sql) |View    |Information about attachments to Database Mail messages.|
    |[sysmail_sentitems](/sql/relational-databases/system-catalog-views/sysmail-sentitems-transact-sql) |View    |Information about messages that have been sent by using Database Mail.|
    |[sysmail_unsentitems](/sql/relational-databases/system-catalog-views/sysmail-unsentitems-transact-sql) |View    |Information about messages that Database Mail is currently trying to send.|

2. Some errors are logged in the Windows application event log.

## Step 1: Check sysmail_event_log view

This system view is the starting point for troubleshooting all Database Mail issues.

When troubleshooting Database Mail, search the `sysmail_event_log` view for events that are related to email failures. Some messages (such as the failure of the Database Mail external program) aren't associated with specific emails.

`Sysmail_event_log` contains one row for each Windows or SQL Server message that's returned by the Database Mail system. In SQL Server Management Studio (SSMS), select **Management**, right-click **Database Mail**, and select **View Database Mail Log** to check the Database Mail log as follows:

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-view-log.png" alt-text="Screenshot of the View Database Mail log item in Database Mail menu.":::

Run the following query to `sysmail_event_log`:

```sql
SELECT er.log_id AS [LogID],
  er.event_type AS [EventType],
  er.log_date AS [LogDate],
  er.description AS [Description],
  er.process_id AS [ProcessID],
  er.mailitem_id AS [MailItemID],
  er.account_id AS [AccountID],
  er.last_mod_date AS [LastModifiedDate],
  er.last_mod_user AS [LastModifiedUser]
FROM msdb.dbo.sysmail_event_log er
ORDER BY [LogDate] DESC
```

The `event_type` column can have the following values:

- Errors
- Warnings
- Information
- Success

To show only the required event types, use the `WHERE` clause to filter.

### Check the specific failed mail item

To search for errors that are related to specific emails, look up the `mailitem_id` of the failed email in the `sysmail_faileditems` view, and then search for messages that are related to `mailitem_id` in `sysmail_event_log`.

```sql
SELECT er.log_id AS [LogID], 
    er.event_type AS [EventType], 
    er.log_date AS [LogDate], 
    er.description AS [Description], 
    er.process_id AS [ProcessID], 
    er.mailitem_id AS [MailItemID], 
    er.account_id AS [AccountID], 
    er.last_mod_date AS [LastModifiedDate], 
    er.last_mod_user AS [LastModifiedUser],
    fi.send_request_user,
    fi.send_request_date,
    fi.recipients, fi.subject, fi.body
FROM msdb.dbo.sysmail_event_log er 
    LEFT JOIN msdb.dbo.sysmail_faileditems fi
ON er.mailitem_id = fi.mailitem_id
ORDER BY [LogDate] DESC
```

When an error is returned from `sp_send_dbmail`, the email isn't submitted to the Database Mail system and the error isn't displayed in the `sysmail_event_log` view. You should gather statement-level profiler trace and troubleshoot the error that you encounter. 

When individual account delivery attempts fail, Database Mail will hold the error messages during retry attempts until the mail item delivery succeeds or fails. If the delivery succeeds in the end, all accumulated errors get logged as separate warnings, including `account_id`. It can cause a warning even if the email was sent. If the delivery fails in the end, all previous warnings get logged as one error message without an `account_id` because all accounts have failed.

### Issues that may be logged in sysmail_event_log

The following issues might be logged in `sysmail_event_log`:

- Failure of *DatabaseMail.exe* to connect to SQL Server.

   If the external program can't log to the **msdb** tables, the program will log errors to the Windows application event log.
- Failures associated with SMTP server.
  - Failure to contact the SMTP server.
  - Failure to authenticate with the SMTP server.
  - SMTP server refuses the email message.
- Exceptions in *DatabaseMail.exe*.

If there are no problems with Database Mail external executable, go to the sysmail system views. To search for errors that are related to specific emails, look up the `mailitem_id` of the failed email in the `sysmail_faileditems` view, and then search for messages that are related to `mailitem_id` in `sysmail_event_log`. When an error is returned from `sp_send_dbmail`, the email isn't submitted to the Database Mail system and the error isn't displayed in the `sysmail_event_log` view.

## Step 2: Check sysmail_unsentitems, sysmail_sentitems, and sysmail_faileditems views

You can check these views for problems with specific emails to see whether database mails are being sent, are stuck in the queue, or fail to be sent.

Internal tables in the msdb database contain the email messages and attachments that are sent from Database Mail, together with their current status. Database Mail updates these tables when the messages are processed.

`Sysmail_mailitems` table is the base table for the other sysmail views. The `sysmail_allitems` view is built on the table and is a superset of these views.

> [!NOTE]
> If you back up the production **msdb** database and restore to another test system as a user database, you can re-create the sysmail system views in the restored backup. The view definitions in the restored backup will reference the **msdb** database on the system where you restored the backup. See the script to re-create sysmail views in customer **msdb** in the [Msdb backup](#method-1-back-up-the-msdb-database) section.

### Sysmail_unsentitems

This view contains one row for each Database Mail message whose status is **unsent** or **retrying**.

Use this view when you want to see how many messages are waiting to be sent and how long they have been in the mail queue. Generally, the number of unsent messages is small. You can benchmark during normal operations to determine a reasonable number of messages in the message queue for normal operations.

You can also check mails in `sysmail_unsentitems` if there are problems with the Service Broker objects in msdb. If the `ExternalMailQueue` or `InternalMailQueue` queue is disabled, or there are problems with the route, the mail may stay in `sysmail_unsentitmes`.

**Unsent** or **retrying** messages are still in the mail queue and may be sent at any time. Messages can have the **unsent** status for the following reasons:

- The message is new. Although the message has been placed on the mail queue, Database Mail is working on other messages and has not yet reached this message.
- The Database Mail external program is not running, and no mail is sent.

Messages can have the **retrying** status for the following reasons:

- Database Mail tried to send the mail, but couldn't contact the SMTP mail server. Database Mail continues to try to send the message by using other Database Mail accounts that are assigned to the profile that sent the message. If no account can send the mail, Database Mail will wait for the length of time that's configured for the `Account Retry Delay` parameter, and then try to send the message again. Database Mail uses the parameter to determine how many times are tried to send the message. When Database Mail tries to send the message, the message remains the **retrying** status.
- Database Mail connects to SMTP server, but it encounters an error. The SMTP error code that's returned by SMTP server and any accompanying error message can be used for further troubleshooting.

### Sysmail_faileditems

If you know that the email failed to be sent, you can query `sysmail_faileditems` directly. For more information about querying `sysmail_faileditems` and filtering for specific messages by recipient, see [Check the Status of EMail Messages Sent With Database Mail](/sql/relational-databases/database-mail/check-the-status-of-e-mail-messages-sent-with-database-mail).

To check the status of email messages that are sent by using Database Mail, run the following scripts:

```sql
-- Show the subject, the time that the mail item row was last  
-- modified, and the log information.  
-- Join sysmail_faileditems to sysmail_event_log   
-- on the mailitem_id column.  
-- In the WHERE clause list items where danw was in the recipients,  
-- copy_recipients, or blind_copy_recipients.  
-- These are the items that would have been sent to Jane@contoso.com
 
SELECT items.subject, items.last_mod_date, l.description 
FROM dbo.sysmail_faileditems AS items  
INNER JOIN dbo.sysmail_event_log AS l ON items.mailitem_id = l.mailitem_id  
WHERE items.recipients LIKE '%Jane%'    
    OR items.copy_recipients LIKE '%Jane%'   
    OR items.blind_copy_recipients LIKE '%Jane%'  
GO  
```

### Sysmail_sentitems

If you want to find the time when the last email was sent successfully, you can query `sysmail_sentitems` and order by `sent_date` as follows:

```sql
SELECT ssi.sent_date, * 
FROM msdb.dbo.sysmail_sentitems ssi
ORDER BY ssi.sent_date DESC
```

If certain types of mails are successfully sent but others aren't, this view may help you find out the differences.

## Step 3: Check sysmail_mailattachments view

This view contains one row for each attachment that's submitted to Database Mail. Use this view when you need information about Database Mail attachments.

If you have trouble sending mails with attachments, but some mails with attachments are sent successfully, this view may help you find out the differences.

## Step 4: Check Database Mail configuration for SMTP server

Another step to help solve Database Mail issues is to check the Database Mail configuration for SMTP server and the account that's used to send Database Mail.

For more information about how to configure Database Mail, see [Configure Database Mail](/sql/relational-databases/database-mail/configure-database-mail).

### Configure Database Mail

To configure Database Mail, follow the steps:

1. Open SSMS,  select **Management**, right-click **Database Mail**, and select **Configure Database Mail**.

    :::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-configure.png" alt-text="Screenshot of the configure Database Mail log item in Database Mail menu.":::

2. Select **Manage Database Mail accounts and profiles** > **Next**.
3. If you have an account, select **View, change, or delete an existing account** and select **Next**, otherwise select **create new account**. The following screenshot shows the account settings that are used to connect to the SMTP server and send Database Mail.

    :::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-configuration-wizard.png" alt-text="Screenshot of manage existing account in Database mail Configuration Wizard.":::

Pay special attention to:

- Server name and port number. The server name must be a fully qualified domain name and the port number must be accurate. Generally, the default SMTP port is 25, but you need to check the current SMTP configuration.

- SSL. Verify whether the SMTP server requires Secure Sockets Layer (SSL) or Transport Layer Security (TLS).

- SMTP authentication. Are you using the Windows authentication of the Database Engine service, basic authentication with a domain account specified, or anonymous authentication? You need to verify what the SMTP server allows in your own environment. If a domain account is specified (either service account or basic authentication), it must have the permissions on the SMTP server.

You can use the configuration to send a test mail with PowerShell, see [Send a test email with PowerShell](#send-a-test-email-with-powershell).

### Check Database Mail system parameters

To check the system parameters, follow the steps:

1. Open SSMS, select **Management**, right-click **Database Mail**, and select **Configure Database Mail**.

1. Select **View or change system parameters**.

The following screenshot shows the default values for the system parameters. Notice any unique system parameters and determine whether they are related to the issue that you're troubleshooting. 

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-configuration-systemparameters.png" alt-text="Screenshot of configure system parameters in Database mail Configuration Wizard.":::

## Step 5: Send a test mail

This section helps you send a test Database Mail by using SSMS and PowerShell.

### Send a test email with Database Mail

Sending a test email helps you try to reproduce the issue that you are experiencing and to verify whether any Database Mail can be sent.

To send a test Database Mail, select **Management**, right-click **Database Mail**, and select **Send Test E-Mail...**.

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-send-test-mail.png" alt-text="Screenshot of the send test email option that shows after right clicking Database Mail.":::

After you send the test mail, check the Database Mail log and sysmail views.
- If the test mail isn't sent successfully, use this document to troubleshoot why it isn't sent.
- If the test mail is sent successfully, but there are still problems with other mails that aren't sent, focus on the details of the email messages that aren't getting sent. Review the actual `sp_send_dbmail` command that is being executed. If you don't have the Transact-SQL command, gather an XEvent trace by using `sql_batch_completed` and `sql_batch_started` commands and look at the `batch_text` column.

### Send a test email with PowerShell

Using an external process helps you exclude Database Mail from the troubleshooting and test the account configuration. For example, use PowerShell to send a test mail. If you fail to send a test mail by using PowerShell, it indicates that it's not a Database Mail issue.

If the mail that's sent from PowerShell fails with the same SMTP server settings and credentials, it may indicate that the problem is on the SMTP server.

- Change the following parameters according to your environment, and then run the following script:

    ```PowerShell
    $EmailFrom = "dbmail@contoso.com"
    $EmailPass = "Y0reP@ssw0rd"
    $EmailTo = "email_alias@contoso.com"
    $Port = 587
    $Subject = "Test From PowerShell"
    $Body = "Did this work?"
    $SMTPServer = "smtp.contoso.com"
    
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $Port)
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPass);
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body) 
    ```

- If your SMTP server allows anonymous authentication, use standard port 25, and it doesn't require SSL. Run the following script:

    ```PowerShell
    $EmailFrom = "dbmail@contoso.com"
    $EmailTo = "email_alias@contoso.com"
    $Port = 25
    $Subject = "Test From PowerShell (Anonymous Auth, no SSL)"
    $Body = "Did this work?"
    $SMTPServer = "smtp.contoso.com"
    
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $Port)
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPass);
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body) 
    ```

## Step 6: Check the sysmail Service Broker objects

Problems with the Service Broker objects in **msdb** may cause unsuccessful operation of Database Mail. A common problem is that one of the Service Broker queues (`ExternalMailQueue` and `InternalMailQueue`) is disabled. This problem can be caused by a poison message that can't be successfully sent in Service Broker. For example, malformed XML. If a message can't be sent after five attempts, it's considered "poison" and the queue will be disabled until the poison message is removed. Re-enabling the queue won't resolve the issue because the poison message is still in the queue and the failure sequence will just repeat. For more information about poison message, see [Poison Message Handling](https://techcommunity.microsoft.com/t5/sql-server-blog/poison-message-handling/ba-p/383454).

One of the other Service Broker objects (such as `Message Type`, `Contract`, `Service`, and `Route`) may also be disabled or missing. The Service Broker queues have an activation procedure that's associated with the queue, so it's a possible point of failure. You can check the `activation_procedure` column in `msdb.sys.service_queues`, and then use `sp_helptext` to check whether there are any problems.

Run the following query, and then check the contents of the second column of the query results.

```sql
SELECT CONVERT(VARCHAR(32),name) Name, 'exec sp_helptext ''' + activation_procedure + '''' ActivationProc_Code 
FROM msdb.sys.service_queues
```

To determine whether there are any problems with the Service Broker objects, it's better to compare the objects with a functioning Database Mail configuration. Here are the objects you should compare with:

- `Message Types` 
  - {//www.microsoft.com/databasemail/messages}SendMail
  - {//www.microsoft.com/databasemail/messages}SendMailStatus
- `Contracts`
  - //www.microsoft.com/databasemail/contracts/SendMail/v1.0
- `Queues`
  - `dbo.ExternalMailQueue`
  - `dbo.InternalMailQueue`
- `Services`
  - `ExternalMailService`
  - `InternalMailService`
- `Routes`
  - [AutoCreatedLocal](/sql/t-sql/statements/create-route-transact-sql#remarks)

## Advanced Database Mail troubleshooting

Advanced troubleshooting applies to the following scenarios:

- When you look at the Database Mail log, Database Mail crashes and the cause isn't fully explained. You see that **DatabaseMail process is started** is followed immediately by an exception message, and then **DatabaseMail process is shutting down** is displayed.
- Database Mail doesn't successfully start. You don't see **DatabaseMail process is started** in the `sysmail_event_log` view.
- [Initial troubleshooting](#initial-database-mail-troubleshooting) doesn't help you resolve the problem.

You can use the following methods for advanced Database Mail troubleshooting.

### The collections for advanced troubleshooting

To solve the issues, you may need one or more of these collections.

- Backup of msdb
- Event log
- XEvent or SQL Server Trace
- Process Monitor ([Procmon](/sysinternals/downloads/procmon))
- [ProcDump](/sysinternals/downloads/procdump)
- [Time travel debugging](/windows-hardware/drivers/debugger/debugger-download-tools)

## Method 1: Back up the msdb database

It can be helpful to query the sysmail views in an environment that's separate from production. In some cases, you can back up the **msdb** database and then restore to another instance. The sysmail views are all defined with reference to msdb, so even when querying in the restored **msdb** backup, the views will reference the **msdb** system database in your instance. To re-create sysmail views from the production **msdb**, re-create the sysmail views in the user database by using the following script.

```sql
/* sysmail_allitems */

USE [msdb_customer]
GO

PRINT 'Creating view sysmail_allitems in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_allitems')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_allitems
GO

CREATE VIEW sysmail_allitems
AS
SELECT mailitem_id, profile_id, recipients, copy_recipients, blind_copy_recipients, subject, body, body_format, importance, sensitivity, file_attachments,
       attachment_encoding, query, execute_query_database, attach_query_result_as_file, query_result_header, query_result_width, query_result_separator,
       exclude_query_output, append_query_error, send_request_date, send_request_user, sent_account_id,
       CASE sent_status 
          WHEN 0 THEN 'unsent' 
          WHEN 1 THEN 'sent' 
          WHEN 3 THEN 'retrying' 
          ELSE 'failed' 
       END AS sent_status,
       sent_date, last_mod_date, last_mod_user       
FROM [msdb_customer].dbo.sysmail_mailitems 
WHERE (send_request_user = SUSER_SNAME()) OR (ISNULL(IS_SRVROLEMEMBER(N'sysadmin'), 0) = 1) 

GO

/* sysmail_sentitems */

USE [msdb_customer]
GO

PRINT 'Creating view sysmail_sentitems in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_sentitems')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_sentitems
GO

CREATE VIEW sysmail_sentitems
AS
SELECT * FROM [msdb_customer].dbo.sysmail_allitems WHERE sent_status = 'sent'

GO

/* sysmail_unsentitems */

USE [msdb_customer]
GO

PRINT 'Creating view sysmail_unsentitems in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_unsentitems')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_unsentitems
GO

CREATE VIEW sysmail_unsentitems
AS
SELECT * FROM [msdb_customer].dbo.sysmail_allitems WHERE (sent_status = 'unsent' OR sent_status = 'retrying')

GO

/* sysmail_faileditems */

USE [msdb_customer]
GO

PRINT 'Creating view sysmail_faileditems in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_faileditems')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_faileditems
GO

CREATE VIEW sysmail_faileditems
AS
SELECT * FROM [msdb_customer].dbo.sysmail_allitems WHERE sent_status = 'failed'

GO

/* sysmail_event_log */
USE [msdb_customer]
GO
PRINT 'Creating view sysmail_event_log in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_event_log')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_event_log
GO
CREATE VIEW sysmail_event_log
AS
SELECT log_id,
       CASE event_type 
          WHEN 0 THEN 'success' 
          WHEN 1 THEN 'information' 
          WHEN 2 THEN 'warning' 
          ELSE 'error' 
       END as event_type,
       log_date, description, process_id, sl.mailitem_id, account_id, sl.last_mod_date, sl.last_mod_user
FROM [msdb_customer].[dbo].[sysmail_log]  sl
WHERE (ISNULL(IS_SRVROLEMEMBER(N'sysadmin'), 0) = 1) OR 
      (EXISTS ( SELECT mailitem_id FROM [msdb_customer].[dbo].[sysmail_allitems] ai WHERE sl.mailitem_id = ai.mailitem_id ))

GO
```

For more information about sysmail views, see the [sysmail system views](#msdb-sysmail-system-views) section.

## Method 2: Check the Windows application event log

If the external *DatabaseMail.exe* program can't log to the **msdb** table, the program will log the error to the Windows application event log. In addition, if *DatabaseMail.exe* encounters exception, the exception will also be logged. Although the exception stack is typically identical, check the event log to see whether any other stack information exists.

Sometimes when you troubleshoot a *DatabaseMail.exe* crash, you may find that logging indicates a Windows Error Report dump was created as follows:

```output
<datetime stamp>,Information,0,1001,Windows Error Reporting,Viewpoint.contoso.com,"Fault bucket , type 0
Event Name: APPCRASH
Response: Not available
Cab Id: 0
Problem signature:
P1: DatabaseMail.exe
P2: 11.0.2100.60
P3: 4f35e1a1
P4: KERNELBASE.dll
P5: 6.3.9600.18725
P6: 59380775
P7: c0000142
P8: 00000000000ece60
P9: 
P10: 
Attached files:
These files may be available here:
C:\ProgramData\Microsoft\Windows\WER\ReportQueue\AppCrash_DatabaseMail.exe_deaadc12935831f6bbfe9bdcb0cbf864374426c1_807e7507_337982fd
Analysis symbol: 
Rechecking for solution: 0
Report Id: <Report Id>
Report Status: 4100
Hashed bucket:"
```

You can retrieve all files that show AppCrash_DatabaseMail.exe_\* in the *..\\WER\\ReportQueue* path. See the [ProcDump Analysis](#analyze-the-exception-dump) section for dump analysis suggestions.

## Method 3: Collect and analyze XEvent or SQL Server Trace

You can collect a trace of the Transact-SQL commands that are being executed on the system to see whether any of them fail.

### Configure PSSDiag tool

You can use [PSSDiag](https://github.com/microsoft/DiagManager/releases) to collect the XEvent or SQL Server trace under the General Performance template. As shown in the following screenshot, select some additional events, especially all the broker events.

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-pssdiag-broker-events.png" alt-text="Screenshot of the Pssdiag tool in which all the broker events on the XEvent tab are enabled.":::

### Analyze the Xevent or SQL trace

When a Database Mail is sent, you see typically five different sessions (SPIDs) in an Xevent or Profiler capture.

- **sp_send_dbmail**: After you run the Transact-SQL statement, you see the Service Broker events that are used to put the messages on the `ExternalMailQueue` queue.

- **Service Broker Activation for sending messages** to SMTP server through *DatabaseMail.exe*. The application name is "Microsoft SQL Server Service Broker Activation."

- **Database Mail External Program**: This is the external Database Mail program that receives messages from the `ExternalMailQueue` queue and prepares messages to send to the SMTP server. The application name is "DatabaseMail - DatabaseMail - Id\<PID\>."

- **Database Mail External Program**: This is another connection from Database Mail. After the first connection processes the existing messages on the `ExternalMailQueue` queue, the connection is created to listen for additional messages to be placed on the queue. If there are no other messages on the queue, *DatabaseMail.exe* will terminate and close this connection.

- **Service Broker Activation for receiving response messages** from SMTP server through *DatabaseMail.exe*. It updates the sysmail tables to log results of mails that are sent.

You can only know the expected behavior by viewing many of the traces. The best way to know the differences is to compare your trace with the one of the successfully sent Database Mails. If you can sometimes send a Database Mail, compare the trace with a successful trace, see the difference, and check for any errors that are reported by the SPIDs. If you can't send any Database Mail, compare the trace with the one that's sent successfully in your test environment.

## Method 4: Capture and analyze Process Monitor events

[Process Monitor](/sysinternals/downloads/procmon) (Procmon) is a part of the Windows Sysinternals suite.

Process Monitor produces a noisy capture. In order not to miss anything, it's better to apply filters to the data after it's captured rather than during the capture process. Typically, you can target the capture around a repro of the Database Mail issue, so the overall data captured would not be too large.

### Capture file, registry, network, process, and thread events

When you start *procmon.exe*, it begins capturing data immediately. The GUI is straightforward. You need to stop the capturing of events until you're ready to reproduce the issue. Select **File** > **Capturing Events (Ctrl+E)** to uncheck the menu item and stop event collection. Select the eraser icon or press Ctrl+X to clear the events that are already captured:

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-procmon-clear.png" alt-text="Screenshot of the procmon tool that shows all the events are cleared.":::

When you're ready to reproduce the Database Mail issue, follow the steps:

1. Select **File** > **Capturing Events (Ctrl+E)** to start capturing events.
1. Try to send the Database Mail to reproduce the issue.
1. Select **File** > **Capturing Events (Ctrl+E)** to stop capturing events.
1. Save the file as *.PML.

### Analyze the Process Monitor trace

After you get the .PML file, open it by using Process Monitor again. First, filter the file to the *DatabaseMail.exe* and *sqlservr.exe* processes. Then, select **Filter > Filter...** , or click the filter icon to open the filter menu.

For **Process Name**, select *sqlservr.exe* and *DatabaseMail.exe*, and then add these entries:

:::image type="content" source="media/troubleshoot-database-mail-issues/db-mail-procmon-filter.png" alt-text="Screenshot of the procmon tool that shows database.exe is filtered.":::

Just as the case of SQL XEvent or Trace capture, it's not immediately obvious what to look for. Usually, the best way to start analysis is to compare your trace with a Procmon capture for a successfully sent Database Mail. Ideally, compare the trace to a successfully sent email from the same environment where the issue occurs. However, if no Database Mail is successfully sent in the specific environment, compare the trace with a successfully sent email in another environment.

When *DatabaseMail.exe* fails to load a DLL or can't find the *DatabaseMail.exe.config* file, the analysis is useful.

## Method 5: Collect and analyze the exception dump by using ProcDump tool

[ProcDump](/sysinternals/downloads/procdump) is also a part of the Windows Sysinternals suite. 

ProcDump is useful when you try to capture a memory dump of the *DatabaseMail.exe* external program. Typically, you use ProcDump for troubleshooting when *DatabaseMail.exe* encounters an unhandled exception.

### Configure ProcDump

To configure ProcDump to capture a dump of *DatabaseMail.exe* when encountering an unhandled exception, first open a command prompt with administrator privileges. Then, enable ProcDump to capture the dump of the *DatabaseMail.exe* process by using the following command:

```console
c:\Sysinternals> procdump -ma -t DatabaseMail.exe -w e2
```

You will see the following output in the command window:

```output
ProcDump v9.0 - Sysinternals process dump utility
Copyright (C) 2009-2017 Mark Russinovich and Andrew Richards
Sysinternals - www.sysinternals.com
 
Waiting for process named DatabaseMail.exe...
```

Then, reproduce the issue. The dump will be created in the same folder where you've executed *ProcDump.exe*.

### Analyze the exception dump

Find the exception record and examine the call stack that leads to the exception.

1. Open the dump file in WinDbg ([Download Debugging Tools for  Windows - WinDbg - Windows drivers](/windows-hardware/drivers/debugger/debugger-download-tools)).
1. Switch to the exception record by using the `.ecxr` or `!analyze -v` command.

When you have the stack, begin searching for known issues for a matching call stack. If you need further help, contact CSS team.

## Method 6: Use Time Travel Debugging tool

Time travel debugging (TTD) capture is usually the last resort for difficult problems. You can use the [WinDbg preview debugger](https://www.microsoft.com/p/windbg-preview/9pgjgd53tn86) to [get it](/windows-hardware/drivers/debugger/windbg-user-mode-preview#launch-executable-advanced). For comprehensive instructions and information on TTD, see [Time Travel Debugging](/windows-hardware/drivers/debugger/time-travel-debugging-overview) on how it works and how to do analysis. If you get to this point, you need to contact CSS team. However, this section provides instructions on how to capture the TTD when necessary.

### Configure TTD

For several reasons, TTD capture of *DatabaseMail.exe* may be a bit challenging. First, *DatabaseMail.exe* doesn't run as a service indefinitely, but it is invoked by SQL Server (*sqlservr.exe*) process. Therefore, you can't attach to it, but you must configure TTD by using the `-onLaunch` parameter to start capturing it when *DatabaseMail.exe* starts. Second, because *DatabaseMail.exe* is invoked by another process, you need to use the [Debug child processes](/windows-hardware/drivers/debugger/-childdbg--debug-child-processes-).
