---
title: Error when the Replication Log Reader Agent fails
description: This article describes troubleshooting steps that might help resolve problems that occur after the Replication Log Reader Agent fails in SQL Server.
ms.date: 05/08/2025
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
ms.reviewer: ramakoni
---
# 20011 error messages in SQL Server when the Replication Log Reader Agent fails

This article describes troubleshooting steps that might help resolve problems that occur after the Replication Log Reader Agent fails in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2892635

## Symptoms

When the Replication Log Reader Agent fails in Microsoft SQL Server, you receive an error message that resembles the following in the SQL Server log:

> \<Time stamp> spid98 Replication-Replication Transaction-Log Reader
Subsystem: agent logreadername failed. The process could not execute 'sp_replcmds'
on '\<Server name>'.
\<Time stamp> spid258 Error: 14151, Severity: 18, State: 1.
\<Time stamp> spid258 Replication-Replication Transaction-Log Reader
Subsystem: agent logreadername failed. The process could not execute 'sp_replcmds'
on '\<Server name>'.

Additionally, you may receive one or more error messages that resemble the following:

- > 18805/18836 LogReader Failed to Construct Replicated Command
\<Time stamp> Status: 0, code: 20011, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.
\<Time stamp> The process could not execute 'sp_replcmds' on '\<Server name>'.
\<Time stamp> Status: 0, code: 18836, text: 'Invalid Text Info Block for UpdateText: m_pHead->GetType() : 1, m_TextDataType : 0, m_TextOpType : 3, ti:{RowsetId 7746362867712, {TextTimeStamp 480235880448, {RowId {PageId 2680944, FileId 1}, SlotId 21 }} , coloffset -1, textInfoFlags 0x4, textSize 177, offset 177, oldSize 0, newSize 0}.'.
\<Time stamp> Status: 0, code: 18805, text: 'Logreader failed to construct replicated command from LSN {00150725:00014316:009d}.'. \<Time stamp> Status: 0, code: 22037, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.

- > 18805/18836 LogReader Failed to Construct Replicated Command
\<Time stamp> Status: 0, code: 20011, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.
\<Time stamp> The process could not execute 'sp_replcmds' on '\<Server name>'.
\<Time stamp> Repl Agent Status: 6
\<Time stamp> Status: 0, code: 18805, text: 'The Log Reader Agent failed to construct a replicated command from log sequence number (LSN) {00033a89:0000969c:000a}. Back up the publication database and contact Customer Support Services.'.
\<Time stamp> Status: 0, code: 22037, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.

- > LogReader Timeout
The agent is running. Use Replication Monitor to view the details of this agent session.
Repl Agent Status: 3
Publisher: {call sp_repldone ( 0x0000172a0002ac900001, 0x0000172a0002ac900001, 0, 0)}
Publisher: {call sp_replcmds (500, 0)}
Status: 2, code: 0, text: 'The process could not execute 'sp_replcmds' on '\<Publisher name>'.'.
The process could not execute 'sp_replcmds' on '\<Publisher name>'.
Repl Agent Status: 5
Status: 2, code: 0, text: 'Timeout expired'.
Disconnecting from Publisher '\<Publisher name>'
The agent failed with a 'Retry' status. Try to run the agent at a later time.

- > Assertion
\<Time stamp> Status: 0, code: 20011, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.
\<Time stamp> The process could not execute 'sp_replcmds' on '\<Server name>'.
\<Time stamp> Status: 0, code: 18773, text: 'Could not locate text information records for the column "ClientPreferences", ID 30 during command construction.'.
\<Time stamp> Status: 0, code: 3624, text: 'A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a QFE from Technical Support. '.
\<Time stamp> Status: 0, code: 22037, text: 'The process could not execute 'sp_replcmds' on '\<Server name>'.'.

## Troubleshooting

- Error message 1: "18805/18836 LogReader Failed to Construct Replicated Command"

  From this message, you can determine the object and the change that created the transaction in the log. To do this, use the following information:

  - Code 18836 gives you the ID of the page on which you can find the object.

      > [!NOTE]
      >  You can use the [How to use DBCC PAGE](https://techcommunity.microsoft.com/t5/sql-server/how-to-use-dbcc-page/ba-p/383094) to view the contents of database pages.

  - Code 18805 gives you a log sequence number (LSN) that can provide the object:

    ```sql
    dbcc Log(master, 3, 'lsn', '0x00000208:000000a0:0004', 'numrecs', 1)
    ```

- Error message 2: "18805/18836 LogReader Failed to Construct Replicated Command"

  The main difference between error message 1 and error message 2 is that error 2 doesn't contain the status message and doesn't point to the "textinfo" column. This known issue is fixed in [Cumulative update package 11 for Microsoft SQL Server 2008 Service Pack 3 (SP3)](https://support.microsoft.com/help/2834048).

The issue occurs only on those tables that have binary large object (BLOB) data type columns and for which the article isn't using the parameterized commands in order to replicate. To resolve this issue, follow these steps:

  1. Determine whether the article is using parameterized commands. To do this, run the following query:

     ```sql
     SELECT STATUS, NAME FROM sysarticles WHERE NAME =''
     ```

  2. Convert the status values into binary format. For example, for a status value of 41, the binary value is 101001, and the fifth bit from the right side, also known as the status bit, is ON. If the status bit is 1, then it is already set. If the status bit is 0, then it is not set. Therefore, you have to run `sp_changearticle` to configure the parameterized commands. To change the status bit, run the following command:

     ```sql
     sp_changearticle 'ConstituentRequest_ETL_Trans', 'CRProfile', 'status', 'parameters'
     ```

- Error message 3: **LogReader Timeout**

  To resolve this issue, use one of the following methods:

  - Increase the value for the Log Reader Agent's *QueryTimeout* parameter.

      > [!NOTE]
      >  By default, the value for this parameter is 1,800 seconds (30 minutes).

  - Set the value for the *QueryTimeout*  parameter to zero (0) to disable time-out.

  - Reduce the value for the Log Reader Agent's *ReadBatchSize* parameter.

If the assertion in the error log matches the issues in these Knowledge Base articles, install the appropriate fix.
