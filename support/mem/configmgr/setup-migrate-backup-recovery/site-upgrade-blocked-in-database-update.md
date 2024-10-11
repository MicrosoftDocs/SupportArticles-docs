---
title: Site upgrade gets stuck at database update
description: Describes an issue that Configuration Manager upgrade gets stuck at the Upgrade ConfigMgr Database step due to many Software Center requests.
ms.date: 12/05/2023
ms.custom: sap:Configuration Manager Database\Database Errors
ms.reviewer: kaushika
---
# Configuration Manager upgrade gets stuck at Upgrade ConfigMgr Database

This article fixes an issue in which Configuration Manager upgrade gets stuck at the **Upgrade ConfigMgr Database** step.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4509681

## Symptoms

When you upgrade a Configuration Manager site, the upgrade gets stuck at the **Upgrade ConfigMgr Database** step for more than one hour.

In this scenario, one of the following messages is the last log entries in CMUpdate.log, and the messages were logged more than an hour ago:

> CONFIGURATION_MANAGER_UPDATE is currently blocked in database by another session [\<Application Name>][session_id=\<Session_ID>]

> INFO: Creating reporting views.  
> SQL MESSAGE: sp_RenewCollectionViews - Creating collection views.

> INFO: Executing DropForeignKeys  
> INFO: Drop DBMon triggers

Additionally, you may experience high memory usage and SQL Server may appear unresponsive.

## Cause

This issue occurs if the database update queries are blocked by applications that communicate with the Configuration Manager database.

## Resolution

To fix the issue, follow these steps:

1. Identify the application that blocks the Configuration Manager database upgrade by running the following SQL query:

   ```sql
   select
       req.session_id
       ,req.blocking_session_id
       ,req.last_wait_type
       ,req.wait_type
       ,req.wait_resource
       ,case when req.statement_end_offset > 0 then SUBSTRING(convert(nvarchar(max), t.text), req.statement_start_offset/2, (req.statement_end_offset-req.statement_start_offset)/2)
              else NULL end as currentstatement
       ,t.text
       from sys.dm_exec_sessions s
       inner join sys.dm_exec_requests req on s.Session_id=req.session_id
       cross apply sys.dm_exec_sql_text(sql_handle) t
   where program_name='CONFIGURATION_MANAGER_UPDATE'
   OR req.session_id=<Session_ID>
   ```

   > [!NOTE]
   > \<Session_ID> is the session ID that's logged in CMUpdate.log.

2. Based on the returned application name, do one of the following:

   - If the returned application name is **System Center Configuration Manager**, then the issue is likely caused by Software Center requests from the management points to retrieve the information about available user-targeted applications.

     In this case, stop the **SMS Agent Host service** (CcmExec.exe) on the management points.

     > [!NOTE]
     > This issue is fixed in [Configuration Manager current branch version 1906](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1906).

   - If the returned application name is **SMS Provider**, review the SMSProv.log file to identify whether the Administration Console or scripts are using the SMS Provider.

     If this is the case, close the Administration Console or stop the scripts.

   - If the returned application name is a third-party application or service, review the application owner, or stop the application or service temporarily.

## More information

Starting in Configuration Manager current branch version 1906, you can [monitor the database upgrade when you apply a Configuration Manager update](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1906#configuration-manager-update-database-upgrade-monitoring).
