---
title: CDC capture job fails when processing changes
description: This article provides two workarounds for the problem where a CDC capture job fails when you process changes for a table that has a system CLR datatype (geometry, geography, or hierarchyid).
ms.date: 01/15/2021
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: akbarf 
---

# CDC capture job fails when processing changes for a table with system CLR datatype (geometry, geography, or hierarchyid)

This article helps you work around the problem where a CDC capture job fails when you process changes for a table that has a system CLR datatype (geometry, geography, or hierarchyid).

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4538384

## Symptoms

Consider the following scenario:

- You enable the Change Data Capture (CDC) feature on a table that has system CLR datatype, such as geometry, geography, or hierarchyid.
- The CDC capture (scan) job is processing changes that are related to other tables. The process hasn't yet reached the table that has system CLR datatype.
- You make some Data Manipulation Language (DML) changes on the table that has system CLR datatype. Then, you make Data Definition Language (DDL) changes on the same table (for example, you add a column).

In this scenario, when the CDC capture job starts processing the table that has the system CLR datatype, it fails and returns the following error message:

> Msg 18805, Level 16, State 1, Procedure sp_replcmds, LineLineNumber[Batch Start Line LineNumber ]  
The Log-Scan Process failed to construct a replicated command from log sequence number (LSN) {nnnnnnnn: nnnnnnnn: nnnn}. Back up the publication database and contact Customer Support Services.  
Msg 22859, Level 16, State 2, Procedure sp_replcmds, Line LineNumber [Batch Start Line LineNumber ]  
Log Scan process failed in processing log records. Refer to previous errors in the current session to identify the cause and correct any associated problems.  
Msg 3621, Level 16, State 6, Procedure sp_replcmds, Line LineNumber [Batch Start Line LineNumber ]  
The statement has been terminated.  
Msg 22864, Level 16, State 1, Procedure sp_MScdc_capture_job, Line LineNumber[Batch Start Line LineNumber ]  
The call to sp_MScdc_capture_job by the Capture Job for database 'DatabaseName' failed. Look at previous errors for the cause of the failure.

Additionally, the following entry may be logged in the error log:

> Error: 913, Severity: 16, State: 16.
Could not find database IDID. Database may not be activated yet or may be in transition. Reissue the query once the database is available. If you do not think this error is due to a database that is transitioning its state and this error continues to occur.

## More information

This issue does not occur if the CDC capture job initially processes only the DML, and then processes the DDL change on the next run.

## Workaround

To work around this issue, try either of the following methods:

- Avoid using the problematic datatypes (geometry, geography, hierarchyid) together with CDC.
- Make sure that you have no inflight DML changes when you make DDL changes on tables that have geometry, geography, or hierarchyid datatypes. To avoid this issue, follow these steps:

    1. Quiesce all DML to the table.
    1. Run a capture job to process the changes.
    1. Run DDL for the table.
    1. Run a capture job to process the DDL changes.
    1. Re-enable DML processing.

  > [!NOTE]
  > If you continue to experience this issue, disable and then re-enable CDC on the table.
