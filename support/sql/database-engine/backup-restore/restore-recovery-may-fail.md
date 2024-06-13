---
title: Restore or recovery may fail
description: This article provides resolutions for the problem where restore or recovery may fail or take a long time if query notification is used in a database.
ms.date: 01/20/2021
ms.custom: sap:Database Backup and Restore
---
# Restore or recovery may fail or take a long time if query notification is used in a database

This article helps you resolve the problem where restore or recovery may fail or take a long time if query notification is used in a database.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2483090

## Symptoms

You may notice one or more of the following symptoms with a database that is configured for query notification subscriptions:

- Symptom 1: Restoring the database from its backup may fail with 1205 error message if **NEW_BROKER** option is specified during the restore operation. Additionally dump files will be generated in the SQL Server's Errorlog folder.

- Symptom 2: Restoring the database from its backup fails and the database goes offline. Additionally the following messages are logged in the SQL Server Error log:

    > \<Datetime> spid61 Error: 9768, Severity: 16, State: 1.  
    \<Datetime> spid61 A database user associated with the secure conversation was dropped before credentials had been exchanged with the far endpoint. Avoid using DROP USER while conversations are being created.  
    \<Datetime> spid61 Failed to check for pending query notifications in database "5" because of the following error when opening the database: 'A database user associated with the secure conversation was dropped before credentials had been exchanged with the far endpoint. Avoid using DROP USER while conversations are being created. The query notification subscriptions cleanup operation failed. See previous errors for details.'.  
    \<Datetime> spid61 Error: 9001, Severity: 16, State: 5.  
    \<Datetime> spid61 The log for database 'Test' is not available. Check the event log for related error messages. Resolve any errors and restart the database.  
    \<Datetime> spid61 Error: 3314, Severity: 21, State: 4.  
    \<Datetime> spid61 During undoing of a logged operation in database 'Test', an error occurred at log record ID (1835:7401:137). Typically, the specific failure is logged previously as an error in the Windows Event Log service. Restore the database or file from a backup, or repair the database.

    > [!NOTE]
    > You may encounter the issue during recovery phase of the database. Recovery is also run on a database when database is brought online, server is restarted, etc.

- Symptom 3: Restoring the database from its backup may take a long time and messages similar to the following are logged in SQL Server Error log:

    > Date Time SPID Query notification delivery could not send message on dialog '{ Dialog ID }.'. Delivery failed for notification '?\<qn:QueryNotification xmlns:qn="`https://schemas.microsoft.com/SQL/Notifications/QueryNotification`" id="2881" type="change" source="database" info="restart" database_id="7" sid="0x010500000000000515000000FA48F22A6990BA52422C73DFF9030000">\<qn:Message>4a4c696b-645c-40fd-bfef-4f2bc7c599b4;eb99973e-3cc9-4c7e-b4b9-47d8cf590c43</qn:Message></qn:QueryNotification>' because of the following error in service broker: 'The conversation handle "\<Conversation Handler>" is not found.'.

    > [!NOTE]
    > You may encounter the issue during recovery phase of the database. Recovery is also run on a database when database is brought online, server is restarted, etc.

## Cause

Cause for Symptom 1: When you specify **NEW_BROKER** option during the restore operation, SQL Server attempts to truncate all the Service Broker related tables. Truncation requires SCH_M lock on the truncated object. The main transaction thus holds a SCH_M lock on sysdesend. When a database is recovered or restored, by default SQL Server attempts to fire all outstanding query notifications, which requires rows(messages) to be inserted in sysdesend table. This operation requires a SCH_S lock on the table. However this operation happens on a different transaction and the attempt to acquire SCH_S lock is blocked by the SCH_M lock held by the first transaction. As a result the thread executing the restore is now blocked on a resource that it owns, situation known as a self-deadlock. The deadlock is detected by the deadlock monitor and the thread is terminated, thus terminating the restore operation.

For more information on locks, see [Lock Modes](/previous-versions/sql/sql-server-2008-r2/ms175519(v=sql.105)). The other symptoms discussed in the Symptoms section are caused due to known issues that are documented in the fix articles mentioned in the Resolution section below.

## Resolution

Workaround for Symptom 1: You can work around the problem by enabling session level trace flag 9109 before you attempt the restore operation. An example script is shown below:

```sql
dbcc traceon (9109)
go
RESTORE DATABASE [Test] 
FROM DISK = N'C:\TestBackup.bak' WITH FILE = 1, 
MOVE N'test_Data' TO N'C:\test.mdf', 
MOVE N'test_Log' TO N'C:\test_1.ldf', 
NOUNLOAD, 
STATS = 1, 
NEW_BROKER
go
dbcc traceoff (9109)
go
```

> [!NOTE]
> Once the database is completely restored or recovered it is highly recommended that you check to make sure that query notifications are being fired. The easiest way to achieve this is to change the status of the database to Read-only and change it back to Read-write. Some other ways you can check for this include detaching and reattaching the database, restarting SQL Server etc.

You can also avoid the problem altogether by not specifying by not specifying the NEW_BROKER option on the restore operation and instead use `ALTER DATABASE` with **NEW_BROKER** option after the database is restored.

For more information, see [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql).
