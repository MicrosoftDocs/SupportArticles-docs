---
title: MessagesToLOB and MessageContent in BTARN
description: MessagesToLOB table in the BTARNDATA SQL Server database contains messages generated during private processing. MessageContent table in the BTARNARCHIVE SQL Server database contains processed message content (both for successful or failed messages). These two tables continue to grow as messages are processed.  
ms.date: 03/16/2020
ms.prod-support-area-path: Accelerators
---
# Maintaining the MessagesToLOB and MessageContent Tables in BTARN

This article provides information about maintaining `MessagesToLOB` and `MessageContent` tables in Microsoft BizTalk Accelerator for RosettaNet (BTARN).

_Original product version:_ &nbsp; BizTalk Server 2013, 2010    
_Original KB number:_ &nbsp; 2897398

## Summary

The scripts that are documented in the **Delete records in MessagesToLOB table** section and **Delete records in MessageContent table** section below, maintain the `MessagesToLOB` and `MessageContent` tables. The `MessagesToLOB` table grows as messages are processed. The private process routes incoming messages to the `MessagesToLOB` table in the BTARNDATA SQL Server database, in route to the LOB application. The same occurs with the `MessageContent` table. Whenever a send or receive pipeline processes a message, the pipeline creates a message activity. The pipeline creates a message-activity record in the `MessageContent` table. The record contains the content of the message, including both service content and headers.

> [!NOTE]
> - You must test the scripts thoroughly in your test environment before running them in a production environment. You can also create SQL Agent jobs to run them on a schedule basis.
> - See the BTARN product documentation for complete documentation on how BTARN processes a message. The full description is beyond the scope of this kb article.

## Delete records in MessagesToLOB table

To delete records in the `MessagesToLOB` table, you must modify the argument in the `DATEADD` function that is used in the `Delete` query. In the query below, the parameter `-7` means that the query will delete records that are older than seven months.

```sql
USE BTARNDATA
DELETE from [BTARNARCHIVE].[dbo].[MessagesToLOB] WHERE TimeCreated < DATEADD(mm,-7,GETDATE())
```

## Delete records in MessageContent table

To delete records in the `MessageContent` table, you must modify the parameter `@MonthValue`. In the query below, the value **-2** means that the query will delete records that are older than two months.

```sql
USE BTARNARCHIVE
declare @MonthValue as int
set @MonthValue = -2
DELETE from [BTARNARCHIVE].[dbo].[MessageContent]
WHERE ContentXml IS NOT NULL
AND CONVERT(DATETIME,SUBSTRING(ContentXml,
charindex('<DateTimeStamp>20',ContentXml)+15,8),101) < DATEADD(MM,@MonthValue,GETDATE())
```
