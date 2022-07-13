---
title: SQL Server Agent jobs in BizTalk Server
description: Lists all the SQL Server Agent jobs in BizTalk Server. Also provides a description of each SQL Server Agent job.
ms.date: 03/06/2020
ms.custom: sap:BizTalk Server Setup and Configuration
ms.reviewer: rickcau
---
# Description of the SQL Server Agent jobs in BizTalk Server

This article lists the SQL Server Agent jobs in Microsoft BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server 2013, 2010, 2009  
_Original KB number:_ &nbsp; 919776

## List of BizTalk SQL Agent jobs

The following table lists the BizTalk SQL Agent jobs.

|Job name|Description|Enabled by default|
|---|---|---|
|Backup BizTalk Server|Consists of three steps: <ul><li>Step 1: Performs full database backup of the BizTalk Server databases. </li><li>Step 2: Backs up the BizTalk Server database logs.</li><li>Step 3: Specifies for how long the backup history is kept.</li></ul>|No|
|CleanupBTFExpiredEntriesJob_BizTalkMgmtDb|Deletes expired BizTalk Framework entries from the BizTalk Management (`BizTalkMgmtDb`) database.|Yes|
|DTA Purge and Archive|Automates the archiving of tracked messages and the purging of the BizTalk Tracking database to maintain a healthy system and to keep the tracking data archived for future use. </p>On BizTalk Server 2004, this job is created after you install BizTalk Server 2004 Service Pack 2.|No|
|MessageBox_DeadProcesses_Cleanup_BizTalkMsgBoxDb|Detects when a BizTalk Server host instance (BTSNTSvc.exe) has stopped responding. The job then releases the work from the host instance so a different host instance can finish the tasks.|Yes|
|MessageBox_Message_Cleanup_BizTalkMsgBoxDb|Removes all messages that are not referenced by any subscribers in the `BizTalkMsgBoxDb` database tables. </p>This job is also started by the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` job. Therefore, we recommend that you disable this job. On BizTalk Server 2004, this job is enabled by default. So, we recommend that you disable this job.|No|
|MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb|Manages the reference count logs for messages and determines when a message is no longer referenced by a subscriber. </p>This job runs in an infinite loop and deletes the entries from the two individual message reference count logs. This job also calls the `MessageBox_Message_Cleanup_BizTalkMsgBoxDb` job. </p>At first, the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` job status icon displays a status of **Success**. However, there will be no corresponding success entry in the job history. If one of the jobs in the `MessageBox_Message_ManageRefCountLog_BizTalkMsgBoxDb` job fails, a failure entry appears in the job history and the status icon displays a status of **Failure**. The job will always display a status of **Failure** after the first failure. To verify that the other BizTalk SQL Agent jobs run correctly, check the status of the other BizTalk SQL Agent jobs. </p>On BizTalk Server 2004, this job is created after you install BizTalk Server 2004 Service Pack 2.|Yes|
|MessageBox_Parts_Cleanup_BizTalkMsgBoxDb|Removes all message parts that are no longer referenced by a message in the `BizTalkMsgBoxDb` database tables. All messages are composed of one or more message parts that contain the message data.|Yes|
|MessageBox_UpdateStats_BizTalkMsgBoxDb|Updates the statistics for the `BizTalkMsgBoxDb` database. This job doesn't exist on BizTalk Server 2004.|Yes|
|Monitor BizTalk Server|Scans for any known issues with the `BizTalkMgmtDb`, `BizTalkMsgBoxDb`, and `BizTalkDTADb` databases. This includes orphaned instances. This job is created on BizTalk Server 2010.|Yes|
|Operations_OperateOnInstances_OnMaster_BizTalkMsgBoxDb|Used for multiple `BizTalkMsgBoxDb` database deployment. It asynchronously performs operational actions. For example, it asynchronously performs bulk terminates on the master `BizTalkMsgBoxDb` database after those changes are applied to the subordinate `BizTalkMsgBoxDb` database. This job doesn't exist on BizTalk Server 2004.|Yes|
|PurgeSubscriptionsJob_BizTalkMsgBoxDb|Purges unused subscription predicates from the `BizTalkMsgBoxDb` database.|Yes|
|Rules_Database_Cleanup_BizTalkRuleEngineDb|Purges old audit data from the Rule Engine (`BizTalkRuleEngineDb`) database every 90 days. This job also purges old history data (deploy/undeploy notifications) from the Rule Engine (`BizTalkRuleEngineDb`) database every 3 days. This job is created on BizTalk Server 2009.|Yes|
|TrackedMessages_Copy_BizTalkMsgBoxDb|Copies the message bodies of tracked messages from the `BizTalkMsgBoxDb` database to the Tracking (`BizTalkDTADb`) database.|Yes|
|TrackingSpool_Cleanup_BizTalkMsgBoxDb|Purges inactive tracking spool tables to free database space. This job exists only on BizTalk Server 2004.|No|
  
## References

For a list of the SQL Server Agent jobs and their descriptions on BizTalk Server, see [Database Structure and Jobs](/biztalk/core/database-structure-and-jobs).

> [!NOTE]
> The BizTalk SQL Agent jobs must be owned by a user who has a System Administrator server role on SQL Server.
