---
title: Troubleshoot Database Mail issues
description: Describes how to configure Database Mail and send test mail. Provides troubleshooting methods for the Database Mail issues.
ms.date: 12/22/2021
ms.prod-support-area-path: Other tools
author: cobibi
ms.author: v-yunhya
ms.prod: sql
---
# Troubleshoot Database Mail issues

This article provides a methodology on troubleshooting Database Mail issues. 

## Initial Database Mail troubleshooting

The basic troubleshooting algorithm is:

1. Review the Database Mail log and sysmail (`sysmail_event_log`) views for mails that have already been sent or attempted to send with *DatabaseMail.exe*.
1. Next, you can send a test mail and observe the behavior. If test mail is successfully sent, then focus on the specifics of the messages that aren't getting sent. If test mail isn't getting sent, focus on troubleshooting the test mail and disregard the mails unsuccessfully sent before. Check sysmail_\*items views or problems with specific emails, check if database mails are being sent, stuck in the queue, failing, etc.
1. If you suspect that the SMTP server settings are incorrect or the account being used to send the mails is problematic, use PowerShell to send a test mail.
1. If even PowerShell mail send fails, then you're most likely looking at an SMTP configuration issue and the customer will need to involve an SMTP admin.

## Msdb sysmail system views

Before we look at the methodology, here is a quick summary of the relevant Database Mail system views.

1. The majority of the relevant logging takes place in msdb sysmail system views. You can query these directly in your environment

    |Name  |Type  |Description  |
    |---------|---------|---------|
    |`sysmail_allitems` |View|Lists all messages submitted to Database Mail|
    |`sysmail_event_log` |View|Lists messages about the behavior of the Database Mail External Program|
    |`sysmail_faileditems` |View|    Information about messages that Database Mail could not sent|
    |`sysmail_mailattachments` |View    |Information about attachments to Database Mail messages|
    |`sysmail_sentitems` |View    |Information about messages that have been sent using Database Mail|
    |`sysmail_unsentitems` |View    |Information about messages that Database Mail is currently trying to send|

2. Some errors are logged in the Windows Application Event log

## Check sysmail_event_log view

This system view is the starting point for all Database Mail issues.

When troubleshooting Database Mail, search the `sysmail_event_log` view for events related to e-mail failures. Some messages, such as the failure of the Database Mail external program, are not associated with specific e-mails.

`Sysmail_event_log` contains one row for each Windows or SQL Server message returned by the Database Mail system. You can check the Database Mail Log if you right-click on **Management** \> **Database Mail**, and select **View Database Mail Log**.

:::image type="content" source="media/troubleshoot-database-mail-issues/DBMail-ViewLog.png" alt-text="View Database Mail log":::

This executes the following query to `sysmail_event_log`.

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

You can use `WHERE` clause to filter to only show the event types desired.

### Check the specific failed mail item

To search for errors related to specific e-mails, look up the `mailitem_id` of the failed e-mail in the `sysmail_faileditems` view and then search the `sysmail_event_log` for messages related to that `mailitem_id`.

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

When an error is returned specifically from `sp_send_dbmail`, the e-mail is not submitted to the Database Mail system and the error is not displayed in `sysmail_event_log` view. You should gather statement-level profiler trace and observe what error is encountered, then troubleshoot accordingly. 

When individual account delivery attempts fail, Database Mail holds the error messages during retry attempts until the mail item delivery either succeeds or fails. In case of ultimate success, all of the accumulated errors get logged as separate warnings including the `account_id`. This can cause warnings to appear, even though the e-mail was sent. In case of ultimate delivery failure, all previous warnings get logged as one error message without an `account_id`, since all accounts have failed.

### The kinds of issues might be logged in sysmail_event_log

- Failure of *DatabaseMail.exe* to connect to SQL Server.
   In the event that the external program cannot log to the msdb tables, the program logs errors to the Windows Application event log.
- Failures associated with SMTP server
  - Failure to contact the SMTP server
  - Failure to authenticate with the SMTP server
  - SMTP server refuses the email message
- Exceptions in *DatabaseMail.exe*

If there are no problems with Database Mail external executable, then you can go to the sysmail system views. To search for errors related to specific e-mails, look up the `mailitem_id` of the failed e-mail in the `sysmail_faileditems` view and then search the `sysmail_event_log` for messages related to that mailitem_id. When an error is returned from `sp_send_dbmail`, the e-mail is not submitted to the Database Mail system and the error is not  displayed in `sysmail_event_log` view.

## Check sysmail_unsentitems, sysmail_sentitems, sysmail_faileditems views for issues

You can check these views for problems with specific emails, check if database mails are being sent, whether they are stuck in the queue, failing, and so on.

Internal tables in the msdb database contain the e-mail messages and attachments sent from Database Mail, together with the current status of each message. Database Mail updates these tables as each message is processed.

`sysmail_mailitems` table is the base table for the other sysmail views. The `sysmail_allitems` view is built on the this table and is a superset of the following these views.

> [!NOTE]
> If you backup the production msdb database and restore to another test system as a user database, you can recreate the sysmail system views in the restored backup. The view definitions in the restored backup will reference the msdb database on the system where you restored the backup. See the script to recreate sysmail views in customer msdb in [Msdb backup](#msdb-backup) section.

### sysmail_unsentitems

This view contains one row for each Database Mail message with the unsent or retrying status.

Use this view when you want to see how many messages are waiting to be sent and how long they have been in the mail queue. Normally the number of unsent messages will be low. You can conduct a benchmark test during normal operations to determine a reasonable number of messages in the message queue for your normal operations.

You can also see mails in the `sysmail_unsentitems` if there are problems with the Service Broker objects in msdb. If the `ExternalMailQueue` or `InternalMailQueue` queue is disabled, or there are problems with the route, the mail may stay in `sysmail_unsentitmes`.

Messages with **unsent** or **retrying** status are still in the mail queue and may be sent at any time. Messages can have the **unsent** status for the following reasons:

- The message is new, and though the message has been placed on the mail queue, Database Mail is working on other messages and has not yet reached this message.
- The Database Mail external program is not running and no mail is being sent.

Messages can have the **retrying** status for the following reason:

Database Mail has attempted to send the mail, but the SMTP mail server could not be contacted. Database Mail will continue to attempt to send the message using other Database Mail accounts assigned to the profile that sent the message. If no accounts can send the mail, Database Mail will wait for the length of time configured for the Account Retry Delay parameter and then attempt to send the message again. Database Mail uses the Account Retry Attempts parameter to determine how many times to attempt to send the message. Messages retain retrying status as long as Database Mail is attempting to send the message.

### sysmail_faileditems

If you know that the email send attempt fails, you can query `sysmail_faileditems` directly. For more information about querying `sysmail_faileditems` and filtering for specific messages by recipient, see [Check the Status of E-Mail Messages Sent With Database Mail](/sql/relational-databases/database-mail/check-the-status-of-e-mail-messages-sent-with-database-mail).

To Check the status of e-mail messages sent with database mail.

```sql
-- Show the subject, the time that the mail item row was last  
-- modified, and the log information.  
-- Join sysmail_faileditems to sysmail_event_log   
-- on the mailitem_id column.  
-- In the WHERE clause list items where danw was in the recipients,  
-- copy_recipients, or blind_copy_recipients.  
-- These are the items that would have been sent to JaneSmith@contoso.com
 
SELECT items.subject, items.last_mod_date, l.description 
FROM dbo.sysmail_faileditems AS items  
INNER JOIN dbo.sysmail_event_log AS l ON items.mailitem_id = l.mailitem_id  
WHERE items.recipients LIKE '%JaneSmith%'    
    OR items.copy_recipients LIKE '%JaneSmith%'   
    OR items.blind_copy_recipients LIKE '%JaneSmith%'  
GO  
```

### sysmail_sentitems

If you want to find when the last mail was successfully sent, you can query `sysmail_sentitems` and order by `sent_date`.

```sql
SELECT ssi.sent_date, * 
FROM msdb.dbo.sysmail_sentitems ssi
ORDER BY ssi.sent_date DESC
```

This will help you get an idea of when things were working. If there are certain types of mails that get successfully sent but others are not, this may give you an idea of what the differences may be.

## Check sysmail_mailattachments view

This view contains one row for each attachment submitted to Database Mail. Use this view when you want information about Database Mail attachments.

If there are problems with sending mails with attachments, but some mails with attachments are being sent successfully, this view will be helpful to find out what the differences may be.

## Check Database Mail configuration for SMTP server and account settings

Another step to help eliminate Database Mail issues is to review the Database Mail configuration for SMTP server settings and the account being used to send database mail.

If you haven't already, become familiar with the steps for configuring Database Mail see: [How to Configure Database Mail](/sql/relational-databases/database-mail/configure-database-mail).

### Configure Database Mail

1. Right-click on **Management** -> **Database Mail**, and select **Configure Database Mail**

    :::image type="content" source="media/troubleshoot-database-mail-issues/DbMail-Configure.png" alt-text="Configure Database Mail":::

2. Click **Manage Database Mail accounts and profiles** and select **Next**
3. If you have an account, select **View, change, or delete an existing account** and select **Next**, otherwise select **create new account**. This will show you the settings the account is using to connect to the SMTP server and send Database Mail.

    :::image type="content" source="media/troubleshoot-database-mail-issues/DbMail Configuration Wizard.png" alt-text="Database mail Configuration Wizard":::

Of particular interest are:

- Server name and port number. The server name must be a fully qualified domain name and the port number must be accurate. Typically, default SMTP port is 25, but you will need to confirm with the existing SMTP configuration.

- SSL - Verify if the SMTP server requires Secure Sockets Layer (SSL) and Transport Layer Security (TLS).

- SMTP authentication. Are you using the Windows authentication of the Database Engine service, basic authentication with a domain account specified, or anonymous authentication? You need to validate within your own environment what the SMTP server allows. If a domain account is specified (either service account or basic authentication), it must have permissions on the SMTP server.

You can use the configuration to send a test mail with PowerShell, see [Send a test email with PowerShell](#send-a-test-email-with-powershell).

### Check Database Mail system parameters

To check the configuration:

1. Right-click on **Management** -> **Database Mail**, and select **Configure Database Mail**.

1. Click **View or change system parameters**.

This screenshot shows the default settings, you can see the default settings. Make note of any unique system parameters and determine if they could have any relation to the issue you're troubleshooting.

:::image type="content" source="media/troubleshoot-database-mail-issues/DbMail Configuration -SystemParameters.png" alt-text="Database Mail System Parameters":::

## Send a test mail

This section will guide you through the SSMS and PowerShell test Database Mail.

### Send a test email with Database Mail

It will be useful to send a test email to try to reproduce the issue you are experiencing or to validate whether ANY database mails can be sent.

To send a test Database Mail, Right-click on **Management** \> **Database Mail**, and select **Send Test E-Mail...**

:::image type="content" source="media/troubleshoot-database-mail-issues/DBMail_SendTestMail.png" alt-text="Database Mail Send Test Mail":::

After you send the test mail, then review the Database Mail log and sysmail views for what happened to the test mail. If the test mail isn't sent successfully, review the account configuration and compare to the SMTP server requirements at which point you may need to involve the SMTP server administrator. If the test mail is sent successfully, but there are still problems with other mails not being sent, then you need to drill into the specifics of the email messages that aren't getting sent. Review the actual `sp_send_dbmail` command that is being executed. If you don't have the T-SQL command, you can gather an Xevent trace (with `sql_batch_completed` and `sql_batch_started`) and look at the `batch_text` column.

A good way to take Database Mail out of the troubleshooting and test the account configuration is to use an external process, like PowerShell, to send a test mail. If PowerShell test mail fails then you know it's not a problem with Database Mail.

### Send a test email with PowerShell

If the test Database Mail fails to send, it may be useful to use PowerShell to send a mail to the SMTP server, thereby eliminating SQL Server Database Mail as the source of the problem. If the mail send from PowerShell fails with the same SMTP server settings and credentials, this may point to the problem being with the SMTP server.

- You can change the following parameters according to your environment, then run the following script:

    ```PowerShell
    $EmailFrom = "dbmail@contoso.com"
    $EmailPass = "Y0reP@ssw0rd"
    $EmailTo = email_alias@contoso.com
    $Port = 587
    $Subject = "Test From PowerShell"
    $Body = "Did this work?"
    $SMTPServer = "smtp.contoso.com"
    
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $Port)
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPass);
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body) 
    ```

- If your SMTP server allows anonymous authentication, use standard port 25, and doesn't require SSL, the following can be used.

    ```PowerShell
    $EmailFrom = "dbmail@contoso.com"
    $EmailTo = email_alias@contoso.com
    $Port = 25
    $Subject = "Test From PowerShell (Anonymous Auth, no SSL)"
    $Body = "Did this work?"
    $SMTPServer = "smtp.contoso.com"
    
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $Port)
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPass);
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body) 
    ```

## Check the sysmail Service Broker objects

If there are problems with the Service Broker objects in msdb, this could prevent successful operation of Database Mail. A common problem is when one of the Service Broker queues (`ExternalMailQueue` and `InternalMailQueue`) get disabled. This can be due to a poison message, which is a message that cannot be successfully sent in Service Broker. An example could be malformed XML. If a message is unable to be sent after five attempts, it is deemed 'poison' and the queue will be disabled until the poison message is removed. Reenabling the queue will not resolve the issue as the poison message is still in the queue and the failure sequence will just repeat. For more information on poison message, see [Poison Message Handling](https://techcommunity.microsoft.com/t5/sql-server-blog/poison-message-handling/ba-p/383454).

It's also possible that one of the other Service Broker objects (Message Type, Contract, Service, Route) could be disabled or missing. The Service Broker queues each have an activation procedure associated with the queue, so this is a possible point of failure. You can check `activation_procedure` column in `msdb.sys.service_queues` and then use `sp_helptext` to check for any problems.

Run the following query and check the contents of the second column from the query results.

```sql
SELECT CONVERT(VARCHAR(32),name) Name, 'exec sp_helptext ''' + activation_procedure + '''' ActivationProc_Code 
FROM msdb.sys.service_queues
```

To determine if there are any problems with the Service Broker objects, it's best to compare it with a functioning Database Mail configuration. The objects you should compare are as follows:

- Message Types 
  - {//www.microsoft.com/databasemail/messages}SendMail
  - {//www.microsoft.com/databasemail/messages}SendMailStatus
- Contracts
  - //www.microsoft.com/databasemail/contracts/SendMail/v1.0
- Queues
  - `dbo.ExternalMailQueue`
  - `dbo.InternalMailQueue`
- Services
  - `ExternalMailService`
  - `InternalMailService`
- Routes
  - [AutoCreatedLocal](/sql/t-sql/statements/create-route-transact-sql#remarks)

## Advanced Database Mail troubleshooting

You can do advanced troubleshooting in following scenarios:

- Database Mail crashes and the cause isn't fully explained when looking at Database Mail log. You see **DatabaseMail process is started** followed immediately by an exception message, and then **DatabaseMail process is shutting down**.
- Database Mail doesn't successfully start. You don't see **DatabaseMail process is started** in `sysmail_event_log` view.
- Initial troubleshooting doesn't help you resolve the problem.

### Collections for advanced troubleshooting

Depending on the problem, you may need one or more of these collections. These are described in order of what you're most likely to need.

- Backup of msdb
- Event Log
- Xevent or SQL Server Trace
- Process Monitor ([Procmon](/sysinternals/downloads/procmon))
- [Procdump](/sysinternals/downloads/procdump)
- [Time travel debugging](/windows-hardware/drivers/debugger/debugger-download-tools)

### Msdb backup

It can be helpful to be query the sysmail in your own environment. In some cases you can backup the **msdb** database and then restore to another test instance. The sysmail views are all defined with reference to msdb, so even when querying within the restored **msdb** backup, the views will reference the msdb system database in your instance. You will need to recreate the sysmail views in the user database with following script to recreate sysmail views in customer msdb.

```sql
/* sysmail_allitems  */

USE [msdb_customer]
GO

PRINT ''
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
SELECT mailitem_id,
       profile_id,
       recipients,
       copy_recipients,
       blind_copy_recipients,
       subject,
       body,
       body_format,
       importance,
       sensitivity,
       file_attachments,
       attachment_encoding,
       query,
       execute_query_database,
       attach_query_result_as_file,
       query_result_header,
       query_result_width,
       query_result_separator,
       exclude_query_output,
       append_query_error,
       send_request_date,
       send_request_user,
       sent_account_id,
       CASE sent_status 
          WHEN 0 THEN 'unsent' 
          WHEN 1 THEN 'sent' 
          WHEN 3 THEN 'retrying' 
          ELSE 'failed' 
       END AS sent_status,
       sent_date,
       last_mod_date,
       last_mod_user
FROM [msdb_customer].dbo.sysmail_mailitems
WHERE (send_request_user = SUSER_SNAME()) OR (ISNULL(IS_SRVROLEMEMBER(N'sysadmin'), 0) = 1)

GO

/* sysmail_sentitems */

USE [msdb_customer]
GO

PRINT ''
PRINT 'Creating view sysmail_sentitems in msdb backup from customer...'
GO
IF (EXISTS (SELECT *
            FROM [msdb_customer].dbo.sysobjects
            WHERE (NAME = N'sysmail_sentitems')
              AND (TYPE = 'V')))
  DROP VIEW sysmail_sentitems
go

CREATE VIEW sysmail_sentitems
AS
SELECT * FROM [msdb_customer].dbo.sysmail_allitems WHERE sent_status = 'sent'

GO

/* sysmail_unsentitems */

USE [msdb_customer]
GO

PRINT ''
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

PRINT ''
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

PRINT ''
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
       log_date,
       description,
       process_id,
       sl.mailitem_id,
       account_id,
       sl.last_mod_date,
       sl.last_mod_user
FROM [msdb_customer].[dbo].[sysmail_log]  sl
WHERE (ISNULL(IS_SRVROLEMEMBER(N'sysadmin'), 0) = 1) OR 
      (EXISTS ( SELECT mailitem_id FROM [msdb_customer].[dbo].[sysmail_allitems] ai WHERE sl.mailitem_id = ai.mailitem_id ))

GO
```

See [sysmail system views](#msdb-sysmail-system-views) section for tips regarding what each sysmail view shows.

### Event log

In the event that the external *DatabaseMail.exe* program cannot log to the msdb tables, the program logs errors to the Windows application event log. In addition, if *DatabaseMail.exe* encounters some kind of exception, it is often logged to Application event log as well. The exception stack is typically identical, but check the Application event log to see if any additional stack information is present.

Sometimes when troubleshooting a *DatabaseMail.exe* crash, you may find logging that indicates a Windows Error Report dump was created. It will appear something similar to this:

```output
<datetime stamp>,Information,0,1001,Windows Error Reporting,Viewpoint.gettle.com,"Fault bucket , type 0
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

You can retrieve all files in the path indicated (..\\WER\\ReportQueue) that show AppCrash_DatabaseMail.exe\_\*. See Procdump Analysis section below for dump analysis suggestions.

### Xevent or SQL Server Trace

You can collect a trace of the T-SQL commands that are being executed on the system to see if any of them are failing.

#### Configuration

You can use [PSSDiag](https://github.com/microsoft/DiagManager/releases) to gather the Xevent or SQL Server trace using the General Performance template. As shown in the following screenshot, select some additional events, specifically all of the broker events.

:::image type="content" source="media/troubleshoot-database-mail-issues/DBMail-Pssdiag-BrokerEvents.png" alt-text="Pssdiag Enable Broker Events":::

#### Analysis

There are typically five distinct sessions (SPIDs) that will contain
useful information for troubleshooting a Database Mail issue.

- **sp_send_dbmail**: After you execute T-SQL statement, you will see the Service Broker events for putting the messages on the `ExternalMailQueue`.

- **Service Broker Activation for sending messages** to SMTP server via *DatabaseMail.exe*. Application name will be "Microsoft SQL Server Service Broker Activation"

- **Database Mail External Program:** This is the external Database Mail program that receives messages from the ExternalMailQueue and prepares the messages to send to the SMTP server. Application name will be "DatabaseMail - DatabaseMail - Id\<PID>\"

- **Database Mail External Program** This is another connection from Database Mail that will get created to listen for additional messages to be placed on queue after the first connection processes the existing messages on the queue. If no additional messages are put on the queue, *DatabaseMail.exe* will terminate and close this connection.

- **Service Broker Activation for receiving response messages** from SMTP server via *DatabaseMail.exe*. This will update the sysmail tables for logging results of mail sends.

It's difficult to know what precisely you should expect to see unless you've reviewed many of these traces. The best approach is to compare to a trace where the database mail is sent successfully. If your troubleshooting scenario involves failure to sometimes successfully send database mails, then compare to the problem trace to a successful trace and see where the behavior diverges. Check for any errors reported by any of the SPIDs. If you are unable to send any database mails, then compare to a successful send in your own test environment.

### Process Monitor

[Process Monitor](/sysinternals/downloads/procmon) (Procmon) is part of the Windows Sysinternals suite.

Process Monitor produces a very noisy capture, and it's best to apply filters to the data after it has been captured rather than as the capture is occurring so you don't miss anything. Typically you are able to target the capture around a repro of the Database Mail issue, so the overall data captured would not be too large.

#### Collect capturing events

When you start *procmon.exe* it will begin capturing data immediately. The GUI is very straightforward. You will want to stop the capturing of events until you're ready to reproduce the issue, so select **File** -\> **Capturing Events (Ctrl+E)**; this will uncheck the menu item and stop event collection. Select the eraser icon or press Ctrl+X to clear the events already captured:

:::image type="content" source="media/troubleshoot-database-mail-issues/DbMail_ProcMon-Clear.png" alt-text="Procmon clear events":::

When you're ready to repro the issue:

1. Select *File* -> *Capturing Events (Ctrl+E)* to start capturing events
1. Repro issue
1. Select *File* -> *Capturing Events (Ctrl+E)* to stop capturing events.
1. Save the file as *.PML

#### Analysis

After you get the captured PML file, open it with Process Monitor again. You start by filtering it to *DatabaseMail.exe* and *sqlservr.exe* processes.
Click **Filter -\> Filter...** or click the filter icon to open the filter menu.

Add entries for Process Name is *sqlservr.exe* and *DatabaseMail.exe*:

:::image type="content" source="media/troubleshoot-database-mail-issues/DbMail-ProcMon-Filter.png" alt-text="Procmon filter database mail":::

As is the case with SQL Xevent or Trace capture, it's not immediately obvious what to looking for. As is typically the case, the best way to start the analysis is to compare it to a Procmon capture for a successfully sent Database Mail. Ideally, compare to a successfully-sent email from the same environment where the issue occurs. But, if no Database Mail can be successfully sent in the specific environment, compare to a successful mail delivery in another environment.

An example of when this kind of analysis is useful is when *DatabaseMail.exe* fails to load a DLL or can't find the *DatabaseMail.exe.config* file.

### Procdump

Procdump is also part of the Windows Sysinternals suite and can be found here: [ProcDump](/sysinternals/downloads/procdump)

Procdump is most useful when trying to capture a memory dump of the *DatabaseMail.exe* external program, typically in the context of troubleshooting when *DatabaseMail.exe* encounters an unhandled exception.

#### Configuration/Collection

To configure Procdump to capture a dump of *DatabaseMail.exe* when encountering an unhandled exception, first open a command prompt with Administrator privileges. Next, use the following command to enable Procdump to capture the dump of the *DatabaseMail.exe* process:

```Console
c:\Sysinternals> procdump -ma -t DatabaseMail.exe -w e2
```

You will see the following in the command window:

```output
ProcDump v9.0 - Sysinternals process dump utility
Copyright (C) 2009-2017 Mark Russinovich and Andrew Richards
Sysinternals - www.sysinternals.com
 
Waiting for process named DatabaseMail.exe...
```

Then, reproduce the issue. The dump will get created in the same folder where you've executed *procdump.exe*.

#### Analysis

As with any exception dump, you want to find the exception record and
examine the call stack that leads to the exception.

1. Open the dump file in WinDbg ([Download Debugging Tools for  Windows - WinDbg - Windows drivers](/windows-hardware/drivers/debugger/debugger-download-tools)).
1. Switch to exception record using `.ecxr` command.
1. You can also execute `!analyze -v`.

Once you have the stack, begin searching for known issues for a matching callstack. You can engage CSS if you need further help with analysis.

### Time travel debugging

Time travel debugging (TTD) capture is typically the last resort for difficult problems. You can use the [WinDbg preview debugger](https://www.microsoft.com/p/windbg-preview/9pgjgd53tn86) to [get it](/windows-hardware/drivers/debugger/windbg-user-mode-preview#launch-executable-advanced). For comprehensive instructions and information on TTD, see [Time Travel Debugging](/windows-hardware/drivers/debugger/time-travel-debugging-overview) on how to it works and how to do analysis; if you get to this point, you likely need to contact CSS. However, this section provides instructions on how to capture the TTD should it be necessary.

#### Configuration/Collection

Capturing of TTD of *DatabaseMail.exe* may be a bit challenging for a couple of different reasons. First, *DatabaseMail.exe* doesn't run as a service indefinitely, but is invoked by SQL Server (*sqlservr.exe*) process. Therefore, you can't simply attach to it but must configure TTD to start capturing when *DatabaseMail.exe* starts by using the **-onLaunch** parameter. Second, because *DatabaseMail.exe* is invoked by another process, you must use the [Debug child processes](/windows-hardware/drivers/debugger/-childdbg--debug-child-processes-).
