---
title: Runbook server goes offline due to deadlocks
description: Fixes an issue where the System Center Orchestrator runbook server goes offline due to deadlocks.
ms.date: 06/26/2024
---
# The runbook server goes offline due to deadlocks

This article helps you fix an issue where the System Center Orchestrator runbook server goes offline due to deadlocks.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2860832

## Symptoms

The System Center Orchestrator runbook server takes itself offline due to database errors resulting from being the victim of one or more deadlocks. Orchestrator platform events as viewed in the Runbook Designer or the Orchestration console reports the following events:

> Summary: Runbook Server \<computer> is experiencing frequent errors while accessing the database  
> Details: The Runbook Server is experiencing frequent errors while accessing the database. Verify the status of the database server. If the problem persists, contact Technical Support.  

A review of the deadlocks shows a stored procedure of `dbo.sp_UnpublishPolicyRequest` being executed with an `objectlock` against the `dbo.POLICY_REQUEST_ACTION_SERVERS` table from each of the locks.

## Cause

Numerous runbook instances are being completed at the same time and executing the `dbo.sp_UnpublishPolicyRequest` stored procedure to remove the completed instance. The foreign key relationship from the `dbo.POLICY_REQUEST_ACTION_SERVERS` table with a cascading delete option but no index against the `SeqNumber` column of the foreign key is causing a full table lock to occur rather than a more selective row lock. When the multiple executions attempt to convert their intent to lock (IX) locks to exclusive (X) locks, the deadlock results.

## Resolution

Use SQL Server Management Studio to execute the following T-SQL against your Orchestrator database to create an index on the `SeqNumber` column of the `dbo.POLICY_REQUEST_ACTION_SERVERS` table.

```sql
CREATE NONCLUSTERED INDEX [IX_POLICY_REQUEST_ACTION_SERVERS_SeqNumber] ON [dbo].[POLICY_REQUEST_ACTION_SERVERS]
(
       [SeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
```

## More information

Example of what kind of content you will see when examining SQL Server deadlock graph details:

> \<process id="process3cd0188" taskpriority="0" logused="1596" waitresource="OBJECT: 10:2142630676:0 " waittime="85" ownerId="255020956" transactionname="DELETE" lasttranstarted="2013-06-05T22:20:51.713" XDES="0x454c4d4d8" lockMode="X" schedulerid="4" kpid="12168" status="suspended" spid="183" sbid="0" ecid="0" priority="0" trancount="2" lastbatchstarted="2013-06-05T22:20:51.713" lastbatchcompleted="2013-06-05T22:20:51.710" lastattention="1900-01-01T00:00:00.710" clientapp="Orchestrator" hostname="COMPUTER" hostpid="3596" loginname="DOMAIN\username" isolationlevel="read committed (2)" xactid="255020956" currentdb="10" lockTimeout="4294967295" clientoption1="673185824" clientoption2="128056">  
 \<executionStack>  
 \<frame procname="Orchestrator.Microsoft.SystemCenter.Orchestrator.Runtime.Internal.CompleteJob" line="22" stmtstart="1054" stmtend="1230" sqlhandle="0x03000a0044da8e2771265d0124a0000001000000000000000000000000000000000000000000000000000000">
DELETE FROM  
 [dbo].[POLICY_PUBLISH_QUEUE]  
 WHERE  
 [SeqNumber] = @SeqNumber \</frame>
 \<frame procname="Orchestrator.dbo.sp_UnpublishPolicyRequest" line="19" stmtstart="820" stmtend="1080" sqlhandle="0x03000a00ac66a25373265d0124a0000001000000000000000000000000000000000000000000000000000000">
EXEC [Microsoft.SystemCenter.Orchestrator.Runtime.Internal].[CompleteJob] @JobId, @SeqNumber, @PolicyID, 'S-1-5-500', @JobStatus \</frame>
 \</executionStack>
 \<inputbuf>
Proc [Database Id = 10 Object Id = 1403152044] \</inputbuf>
\</process>
>
> \<objectlock lockPartition="0" objid="2142630676" subresource="FULL" dbid="10" objectname="Orchestrator.dbo.POLICY_REQUEST_ACTION_SERVERS" id="lockbdedf6280" mode="IX" associatedObjectId="2142630676">
