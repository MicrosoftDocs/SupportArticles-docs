---
title: Windows Server Update Services (WSUS) maintenance guide for Configuration Manager
description: Describes the complete guide to WSUS maintenance for Configuration Manager environments.
ms.date: 12/05/2023
ms.custom: sap:Software update point configuration
ms.reviewer: kaushika, mstewart, erice
---
# The complete guide to WSUS and Configuration Manager SUP maintenance

This article addresses some common questions about WSUS maintenance for Configuration Manager environments.

_Original product version:_ &nbsp; Windows Servers, Windows Server Update Services, Configuration Manager  
_Original KB number:_ &nbsp; 4490644

## Introduction

Questions are often along the lines of **How should I properly run this maintenance in a Configuration Manager environment**, or **How often should I run this maintenance**. It's not uncommon for conscientious Configuration Manager administrators to be unaware that WSUS maintenance should be run at all. Most of us just set up WSUS servers because it's a prerequisite for a software update point (SUP). Once the SUP is set up, we close the WSUS console and pretend it doesn't exist. Unfortunately, it can be problematic for Configuration Manager clients, and the overall performance of the WSUS/SUP server.

With the understanding that this maintenance needs to be done, you're wondering what maintenance you need to do and how often you need to be doing it. The answer is that you should perform monthly maintenance. Maintenance is easy and doesn't take long for WSUS servers that have been well maintained from the start. However, if it has been some time since WSUS maintenance was done, the cleanup may be more difficult or time consuming the first time. It will be much easier or faster in subsequent months.

## Maintain WSUS while supporting Configuration Manager current branch version 1906 and later versions

If you are using Configuration Manager current branch version 1906 or later versions, we recommend that you enable the **WSUS Maintenance** options in the software update point configuration at the top-level site to automate the cleanup procedures after each synchronization. It would effectively handle all cleanup operations described in this article, except backup and reindexing of WSUS database. You should still automate backup of WSUS database along with reindexing of the WSUS database on a schedule.

:::image type="content" source="media/wsus-maintenance-guide/wsus-maintenance-options.png" alt-text="Screenshot of the WSUS Maintenance options in Software Update Point Components Properties window.":::

For more information about software update maintenance in Configuration Manager, see [Software updates maintenance](/mem/configmgr/sum/deploy-use/software-updates-maintenance).

## Important considerations

> [!NOTE]
> If you are utilizing the [maintenance features that have been added in Configuration Manager, version 1906](/mem/configmgr/sum/deploy-use/software-updates-maintenance#wsus-cleanup-starting-in-version-1906), you don't need to consider these items since Configuration Manager handles the cleanup after each synchronization.

1. Before you start the maintenance process, read all of the information and instructions in this article.

1. When using WSUS along with downstream servers, WSUS servers are added from the top down, but should be removed from the bottom up. When syncing or adding updates, they go to the upstream WSUS server first, then replicate down to the downstream servers. When performing a cleanup and removing items from WSUS servers, you should start at the bottom of the hierarchy.

1. WSUS maintenance can be performed simultaneously on multiple servers in the same tier. When doing so, ensure that one tier is done before moving onto the next one. The cleanup and reindex steps described below should be run on all WSUS servers, regardless of whether they are a replica WSUS server or not. For more information about determining if a WSUS server is a replica, see [Decline superseded updates](#decline-superseded-updates).

1. Ensure that SUPs don't sync during the maintenance process, as it may cause a loss of some work already done. Check the SUP sync schedule and temporarily set it to manual during this process.

    :::image type="content" source="media/wsus-maintenance-guide/sync-schedule-setting.png" alt-text="Screenshot of the Enable synchronization on a schedule setting.":::

1. If you have multiple SUPs of the primary site or central administration sit (CAS) which don't share the SUSDB, consider the WSUS server that syncs with the first SUP on the site as residing in a tier below the site. For example, my CAS site has two SUPs:
   - The one named _New_ syncs with Microsoft Update, it would be my top tier (Tier1).
   - The server named _2012_ syncs with _New_, and it would be considered in the second tier. It can be cleaned up at the same time I would do all my other Tier2 servers, such as my primary site's single SUP.

    :::image type="content" source="media/wsus-maintenance-guide/multiple-sups.png" alt-text="Screenshot of the two example SUPs.":::

## Perform WSUS maintenance

The basic steps necessary for proper WSUS maintenance include:

1. [Back up the WSUS database](#back-up-the-wsus-database)
2. [Create custom indexes](#create-custom-indexes)
3. [Reindex the WSUS database](#reindex-the-wsus-database)
4. [Decline superseded updates](#decline-superseded-updates)
5. [Run the WSUS Server Cleanup Wizard](#run-the-wsus-server-cleanup-wizard)

### Back up the WSUS database

Back up the WSUS database (SUSDB) by using the desired method. For more information, see [Create a Full Database Backup](/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server).

### Create custom indexes

This process is optional but recommended, it greatly improves performance during subsequent cleanup operations.

If you are using Configuration Manager current branch version 1906 or a later version, we recommend that you use Configuration Manager to create the indexes. To create the indexes, configure the **Add non-clustered indexes to the WSUS database** option in the software update point configuration for the top-most site.

:::image type="content" source="media/wsus-maintenance-guide/add-non-clustered-index-option.png" alt-text="Screenshot of the Add non-clustered indexes to the WSUS database option under WSUS Maintenance tab.":::

If you use an older version of Configuration Manager or standalone WSUS servers, follow these steps to create custom indexes in the SUSDB database. For each SUSDB, it's a one-time process.

1. Make sure that you have a [backup](#back-up-the-wsus-database) of the SUSDB database.

2. Use SQL Management Studio to connect to the SUSDB database, in the same manner as described in the [Reindex the WSUS database](#reindex-the-wsus-database) section.

3. Run the following script against SUSDB, to create two custom indexes:

    ```sql
    -- Create custom index in tbLocalizedPropertyForRevision
    USE [SUSDB]

    CREATE NONCLUSTERED INDEX [nclLocalizedPropertyID] ON [dbo].[tbLocalizedPropertyForRevision]
    (
         [LocalizedPropertyID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

    -- Create custom index in tbRevisionSupersedesUpdate
    CREATE NONCLUSTERED INDEX [nclSupercededUpdateID] ON [dbo].[tbRevisionSupersedesUpdate]
    (
         [SupersededUpdateID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ```

    If custom indexes have been previously created, running the script again results in an error similar to the following one:

    > Msg 1913, Level 16, State 1, Line 4  
    > The operation failed because an index or statistics with name 'nclLocalizedPropertyID' already exists on table 'dbo.tbLocalizedPropertyForRevision'.

### Reindex the WSUS database

To reindex the WSUS database (SUSDB), use the [Reindex the WSUS Database](reindex-the-wsus-database.md) T-SQL script.

The steps to connect to SUSDB and perform the reindex differ, depending on whether SUSDB is running in SQL Server or Windows Internal Database (WID). To determine where SUSDB is running, check value of the `SQLServerName` registry entry on the WSUS server located at the `HKEY_LOCAL_MACHINE\Software\Microsoft\Update Services\Server\Setup` subkey.

If the value contains just the server name or server\instance, SUSDB is running on a SQL Server. If the value includes the string `##SSEE` or `##WID` in it, SUSDB is running in WID, as shown:

:::image type="content" source="media/wsus-maintenance-guide/ssee-string.png" alt-text="Screenshot of SqlServerName-SSEE.":::

:::image type="content" source="media/wsus-maintenance-guide/wid-string.png" alt-text="Screenshot of SqlServerName-WID.":::

#### If SUSDB was installed on WID

If SUSDB was installed on WID, SQL Server Management Studio Express must be installed locally to run the reindex script. Here's an easy way to determine which version of SQL Server Management Studio Express to install:

- For Windows Server 2012 or later versions:
  
  - Go to `C:\Windows\WID\Log` and find the error log that contains the version number.
  
  - Look up the version number in [How to determine the version, edition and update level of SQL Server and its components](https://support.microsoft.com/help/321185). This value tells you what Service Pack (SP) level that WID is running. Include the SP level when searching the [Microsoft Download Center](https://www.microsoft.com/download) for SQL Server Management Studio Express.

- For Windows Server 2008 R2 or previous versions:
  
  - Go to `C:\Windows\SYSMSI\SSEE\MSSQL.2005\MSSQL\LOG` and open up the last error log with Notepad. At the top, there will be a version number (for example 9.00.4035.00 x64). Look up the version number in [How to determine the version, edition and update level of SQL Server and its components](https://support.microsoft.com/help/321185). This version number tells you what Service Pack level it's running. Include the SP level when searching the [Microsoft Download Center](https://www.microsoft.com/download) for SQL Server Management Studio Express.

After installing SQL Server Management Studio Express, launch it, and enter the server name to connect to:

- If the OS is Windows Server 2012 or later versions, use `\\.\pipe\MICROSOFT##WID\tsql\query`.
- If the OS is older than Windows Server 2012, enter `\\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query`.

For WID, if errors similar to the following occur when attempting to connect to SUSDB using SQL Server Management Studio (SSMS), try launching SSMS using the **Run as administrator** option.

:::image type="content" source="media/wsus-maintenance-guide/connect-to-server-error.png" alt-text="Screenshot of the Cannot connect to server error." border="false":::

#### If SUSDB was installed on SQL Server

If SUSDB was installed on full SQL Server, launch SQL Server Management Studio and enter the name of the server (and instance if needed) when prompted.

> [!TIP]
> Alternatively, a utility called `sqlcmd` can be used to run the reindex script. For more information, see [Reindex the WSUS Database](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939795(v=ws.10)).

#### Running the script

To run the script in either SQL Server Management Studio or SQL Server Management Studio Express, select **New Query**, paste the script in the window, and then select **Execute**. When it's finished, a **Query executed successfully** message will be displayed in the status bar. And the **Results** pane will contain messages related to what indexes were rebuilt.

:::image type="content" source="media/wsus-maintenance-guide/execute-query.png" alt-text="Screenshot of executing the SQL statement.":::

:::image type="content" source="media/wsus-maintenance-guide/log.png" alt-text="Screenshot of the successful log.":::

### Decline superseded updates

Decline superseded updates in the WSUS server to help clients scan more efficiently. Before declining updates, ensure that the superseding updates are deployed, and that superseded ones are no longer needed. Configuration Manager includes a separate cleanup, which allows it to expire superseded updates based on specified criteria. For more information, see the following articles:

- [Supersedence rules](/mem/configmgr/sum/plan-design/plan-for-software-updates#BKMK_SupersedenceRules)
- [WSUS cleanup behavior starting in version 1810](/mem/configmgr/sum/deploy-use/software-updates-maintenance#wsus-cleanup-behavior-starting-in-version-1810)

The following SQL query can be run against the SUSDB database, to quickly determine the number of superseded updates. If the number of superseded updates is higher than 1500, it can cause various software update related issues on both the server and client sides.

```sql
-- Find the number of superseded updates
Select COUNT(UpdateID) from vwMinimalUpdate where IsSuperseded=1 and Declined=0
```

If you are using Configuration Manager current branch version 1906 or a later version, we recommend that you automatically decline the superseded updates by enabling the **Decline expired updates in WSUS according to supersedence rules** option in the software update point configuration for the top-most site.

:::image type="content" source="media/wsus-maintenance-guide/decline-expired-updates-option.png" alt-text="Screenshot of the Decline expired updates in WSUS according to supersedence rules option under WSUS Maintenance tab.":::

When you use this option, you can see how many updates were declined by reviewing the WsyncMgr.log file after the synchronization process finishes. If you use this option, you don't need to use the script described later in this section (either by manually running it or by setting up as task to run it on a schedule).

If you are using standalone WSUS servers or an older version of configuration Manager, you can [manually decline superseded updates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800975(v=ws.11)#declining-updates) by using the WSUS console. Or you can run this [PowerShell script](decline-superseded-updates.md). Then, copy and save the script as a _Decline-SupersededUpdatesWithExclusionPeriod.ps1_ script file.

> [!NOTE]
> This script is provided as is. It should be fully tested in a lab before you use it in production. Microsoft makes no guarantees regarding the use of this script in any way. Always run the script with the `-SkipDecline` parameter first, to get a summary of how many superseded updates will be declined.

If Configuration Manager is set to **Immediately expire superseded updates** (see below), the PowerShell script can be used to decline all superseded updates. It should be done on all **autonomous** WSUS servers in the Configuration Manager/WSUS hierarchy.

:::image type="content" source="media/wsus-maintenance-guide/expire-updates-option.png" alt-text="Screenshot of the Immediately expire superseded updates options under Supersedence Rules tab.":::

You don't need to run the PowerShell script on WSUS servers that are set as replicas, such as secondary site SUPs. To determine whether a WSUS server is a replica, check the **Update Source** settings.

:::image type="content" source="media/wsus-maintenance-guide/update-source.png" alt-text="Screenshot of the Update Source and Proxy Server option.":::

If updates are not configured to be immediately expired in Configuration Manager, the PowerShell script must be run with an exclusion period that matches the Configuration Manager setting for number of days to expire superseded updates. In this case, it would be 60 days since SUP component properties are configured to wait two months before expiring superseded updates:

:::image type="content" source="media/wsus-maintenance-guide/month-setting.png" alt-text="Screenshot of the months to expire superseded updates.":::

The following command lines illustrate the various ways that the PowerShell script can be run:

> [!NOTE]
> When you run the script on the WSUS server, use `LOCALHOST` instead of the actual `SERVERNAME`.

```powershell
Decline-SupersededUpdatesWithExclusionPeriod.ps1 -UpdateServer SERVERNAME -Port 8530 –SkipDecline

Decline-SupersededUpdatesWithExclusionPeriod.ps1 -UpdateServer SERVERNAME -Port 8530 –ExclusionPeriod 60

Decline-SupersededUpdatesWithExclusionPeriod.ps1 -UpdateServer SERVERNAME -Port 8530

Decline-SupersededUpdatesWithExclusionPeriod.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531
```

Running the script with a `-SkipDecline` and `-ExclusionPeriod 60` to gather information about updates on the WSUS server, and how many updates could be declined:

:::image type="content" source="media/wsus-maintenance-guide/powershell-skipdecline.png" alt-text="Screenshot of the Windows PowerShell window running SkipDecline and ExclusionPeriod 60." border="false":::

Running the script with **-ExclusionPeriod 60**, to decline superseded updates older than 60 days:

:::image type="content" source="media/wsus-maintenance-guide/powershell-exclusionperiod-60.png" alt-text="Screenshot of the Windows PowerShell window with ExclusionPeriod 60 running." border="false":::

The output and progress indicators are displayed while the script is running. Note the **SupersededUpdates.csv** file, which will contain a list of all updates that are declined by the script:

:::image type="content" source="media/wsus-maintenance-guide/output.png" alt-text="Screenshot of the Windows PowerShell output and progress indicator." border="false":::

> [!NOTE]
> If issues occur when attempting to use the above PowerShell script to decline superseded updates, see the section [Running the Decline-SupersededUpdatesWithExclusionPeriod.ps1 script times out when connecting to the WSUS server, or a 401 error occurs while running](#running-the-decline-supersededupdateswithexclusionperiodps1-script-times-out-when-connecting-to-the-wsus-server-or-a-401-error-occurs-while-running) for troubleshooting steps.

After superseded updates have been declined, for best performance, SUSDB should be reindexed again. For related information, see [Reindex the WSUS database](#reindex-the-wsus-database).

### Run the WSUS Server Cleanup Wizard

WSUS Server Cleanup Wizard provides options to clean up the following items:

- Unused updates and update revisions (also known as Obsolete updates)
- Computers not contacting the server
- Unneeded update files
- Expired updates
- Superseded updates

In a Configuration Manager environment, **Computers not contacting the server** and **Unneeded update files** options are not relevant because Configuration Manager manages software update content and devices, unless either the **Create all WSUS reporting events** or **Create only WSUS status reporting events** options are selected under **Software Update Sync Settings**. If you have one of these options configured, you should consider automating the WSUS Server Cleanup to perform cleanup of these two options.

If you are using Configuration Manager current branch version 1906 or a later version, enabling the **Decline expired updates in WSUS according to supersedence rules** option handles declining of **Expired updates** and **Superseded updates** based on the supersedence rules that are specified in Configuration Manager. Enabling the **Remove obsolete updates from the WSUS database** option in Configuration Manager current branch version 1906 handles the cleanup of **Unused updates and update revisions** (Obsolete updates). It's recommended to enable these options in the software update point configuration on the top-level site to allow Configuration Manager to clean up the WSUS database.

:::image type="content" source="media/wsus-maintenance-guide/remove-obsolete-updates-option.png" alt-text="Screenshot of the Remove obsolete updates from the WSUS database option.":::

If you've never cleaned up obsolete updates from WSUS database before, this task may time out. You can review WsyncMgr.log for more information, and manually run the SQL script that is specified in [HELP! My WSUS has been running for years without ever having maintenance done and the cleanup wizard keeps timing out](#help-my-wsus-has-been-running-for-years-without-ever-having-maintenance-done-and-the-cleanup-wizard-keeps-timing-out) once, which would allow subsequent attempts from Configuration Manager to run successfully. For more information about WSUS cleanup and maintenance in Configuration Manager, see the docs.

For standalone WSUS servers, or if you are using an older version of Configuration Manager, it is recommended that you run the WSUS Cleanup wizard periodically. If the WSUS Server Cleanup Wizard has never been run and the WSUS has been in production for a while, the cleanup may time out. In that case, reindex with [step 2](#create-custom-indexes) and [step 3](#reindex-the-wsus-database) first, then run the cleanup with only the **Unused updates and update revisions** option checked.

If you have never run WSUS Cleanup wizard, running the cleanup with **Unused updates and update revisions** may require a few passes. If it times out, run it again until it completes, and then run each of the other options one at a time. Lastly make a full pass with all options checked. If timeouts continue to occur, see the SQL Server alternative in [HELP! My WSUS has been running for years without ever having maintenance done and the cleanup wizard keeps timing out](#help-my-wsus-has-been-running-for-years-without-ever-having-maintenance-done-and-the-cleanup-wizard-keeps-timing-out). It may take multiple hours or days for the Server Cleanup Wizard or SQL alternative to run through completion.

The WSUS Server Cleanup Wizard runs from the WSUS console. It is located under **Options**, as shown here:

:::image type="content" source="media/wsus-maintenance-guide/cleanup-wizard.png" alt-text="Screenshot of the WSUS Server Cleanup Wizard location page.":::

For more information, see [Use the Server Cleanup Wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939856(v=ws.10)).

:::image type="content" source="media/wsus-maintenance-guide/wizard-start.png" alt-text="Screenshot of the WSUS Server Cleanup Wizard start page.":::

After it reports the number of items it has removed, the cleanup finishes. If you do not see this information returned on your WSUS server, it is safe to assume that the cleanup timed out. In that case, you will need to start it again or use the [SQL alternative](#troubleshooting).

:::image type="content" source="media/wsus-maintenance-guide/wizard-finish.png" alt-text="Screenshot of the WSUS Server Cleanup Wizard when finished.":::

After superseded updates have been declined, for best performance, SUSDB should be reindexed again. See the [Reindex the WSUS database](#reindex-the-wsus-database) section for related information.

## Troubleshooting

### HELP! My WSUS has been running for years without ever having maintenance done and the cleanup wizard keeps timing out

There are two different options here:

1. Reinstall WSUS with a fresh database. There are a number of caveats related to this, including length of initial sync, and full client scans against SUSDB, versus differential scans.

2. Ensure you have a [backup](#back-up-the-wsus-database) of the SUSDB database, then run a [reindex](#reindex-the-wsus-database). When that completes, run the following script in SQL Server Management Studio or SQL Server Management Studio Express. After it finishes, follow all of the above instructions for running maintenance. This last step is necessary because the `spDeleteUpdate` stored procedure only removes unused updates and update revisions.

  > [!NOTE]
  > Before you run the script, follow the steps in [The spDeleteUpdate stored procedure runs slowly](spdeleteupdate-slow-performance.md) to improve the performance of the execution of `spDeleteUpdate`.

```sql
DECLARE @var1 INT
DECLARE @msg nvarchar(100)

CREATE TABLE #results (Col1 INT)
INSERT INTO #results(Col1) EXEC spGetObsoleteUpdatesToCleanup

DECLARE WC Cursor
FOR
SELECT Col1 FROM #results

OPEN WC
FETCH NEXT FROM WC
INTO @var1
WHILE (@@FETCH_STATUS > -1)
BEGIN SET @msg = 'Deleting' + CONVERT(varchar(10), @var1)
RAISERROR(@msg,0,1) WITH NOWAIT EXEC spDeleteUpdate @localUpdateID=@var1
FETCH NEXT FROM WC INTO @var1 END

CLOSE WC
DEALLOCATE WC

DROP TABLE #results
```

### Running the Decline-SupersededUpdatesWithExclusionPeriod.ps1 script times out when connecting to the WSUS server, or a 401 error occurs while running

If errors occur when you attempt to use the PowerShell script to decline superseded updates, an alternative SQL script can be run against SUDB.

1. If Configuration Manager is used along with WSUS, check **Software Update Point Component Properties** > **Supersedence Rules** to see how quickly superseded updates expire, such as immediately or after _X_ months. Make a note of this setting.

    :::image type="content" source="media/wsus-maintenance-guide/supersedence-rule.png" alt-text="Screenshot of the Supersedence Rules.":::

2. If you haven't [backed up the SUSDB database](#back-up-the-wsus-database), do so before proceeding further.
3. Use SQL Server Management Studio to connect to SUSDB.
4. Run the following query. The number **90** in the line that includes `DECLARE @thresholdDays INT = 90` should correspond with the **Supersedence Rules** from step 1 of this procedure, and the correct number of days that aligns with the number of months that is configured in **Supersedence Rules**. If this is set to expire immediately, the value in the SQL query for `@thresholdDays` should be set to zero.

    ```sql
    -- Decline superseded updates in SUSDB; alternative to Decline-SupersededUpdatesWithExclusionPeriod.ps1
    DECLARE @thresholdDays INT = 90 -- Specify the number of days between today and the release date for which the superseded updates must not be declined (i.e., updates older than 90 days). This should match configuration of supersedence rules in SUP component properties, if ConfigMgr is being used with WSUS.
    DECLARE @testRun BIT = 0 -- Set this to 1 to test without declining anything.
    -- There shouldn't be any need to modify anything after this line.

    DECLARE @uid UNIQUEIDENTIFIER
    DECLARE @title NVARCHAR(500)
    DECLARE @date DATETIME
    DECLARE @userName NVARCHAR(100) = SYSTEM_USER

    DECLARE @count INT = 0

    DECLARE DU CURSOR FOR
      SELECT MU.UpdateID, U.DefaultTitle, U.CreationDate FROM vwMinimalUpdate MU
      JOIN PUBLIC_VIEWS.vUpdate U ON MU.UpdateID = U.UpdateId
    WHERE MU.IsSuperseded = 1 AND MU.Declined = 0 AND MU.IsLatestRevision = 1
      AND MU.CreationDate < DATEADD(dd,-@thresholdDays,GETDATE())
    ORDER BY MU.CreationDate

    PRINT 'Declining superseded updates older than ' + CONVERT(NVARCHAR(5), @thresholdDays) + ' days.' + CHAR(10)

    OPEN DU
    FETCH NEXT FROM DU INTO @uid, @title, @date
    WHILE (@@FETCH_STATUS > - 1)
    BEGIN
      SET @count = @count + 1
      PRINT 'Declining update ' + CONVERT(NVARCHAR(50), @uid) + ' (Creation Date ' + CONVERT(NVARCHAR(50), @date) + ') - ' + @title + ' ...'
      IF @testRun = 0
         EXEC spDeclineUpdate @updateID = @uid, @adminName = @userName, @failIfReplica = 1
      FETCH NEXT FROM DU INTO @uid, @title, @date
    END

    CLOSE DU
    DEALLOCATE DU

    PRINT CHAR(10) + 'Attempted to decline ' + CONVERT(NVARCHAR(10), @count) + ' updates.'
    ```

5. To check progress, monitor the **Messages** tab in the **Results** pane.

### What if I find out I needed one of the updates that I declined?

If you decide you need one of these declined updates in Configuration Manager, you can get it back in WSUS by right-clicking the update, and selecting **Approve**. Change the approval to **Not Approved**, and then resync the SUP to bring the update back in.

:::image type="content" source="media/wsus-maintenance-guide/approve-updates.png" alt-text="Screenshot of the WSUS Approve Updates screen.":::

If the update is no longer in WSUS, it can be imported from the Microsoft Update Catalog, if it hasn't been expired or removed from the catalog.

:::image type="content" source="media/wsus-maintenance-guide/import-updates.png" alt-text="Screenshot shows how to import updates in WSUS.":::

## Automating WSUS maintenance

> [!NOTE]
> If you are using Configuration Manager version1906 or a later version, automate the cleanup procedures by enabling the **WSUS Maintenance** options in the software update point configuration of the top-level site. These options handle all cleanup operations that are performed by the WSUS Server Cleanup Wizard. However, you should still automatically back up and reindex the WSUS database on a schedule.

WSUS maintenance tasks can be automated, assuming that a few requirements are met first.

1. If you have never run WSUS cleanup, you need to do the first two cleanups manually. Your second manual cleanup should be run 30 days from your first since it takes 30 days for some updates and update revisions to age out. There are specific reasons for why you don't want to automate until after your second cleanup. Your first cleanup will probably run longer than normal. So you can't judge how long this maintenance will normally take. The second cleanup is a much better indicator of what is normal for your machines. This is important because you need to figure out about how long each step takes as a baseline (I also like to add about 30-minutes wiggle room) so that you can determine the timing for your schedule.

2. If you have downstream WSUS servers, you will need to perform maintenance on them first, and then do the upstream servers.

3. To schedule the reindex of the SUSDB, you will need a full version of SQL Server. Windows Internal Database (WID) doesn't have the capability of scheduling a maintenance task though SQL Server Management Studio Express. That said, in cases where WID is used you can use the Task Scheduler with `SQLCMD` mentioned earlier. If you go this route, it's important that you don't sync your WSUS servers/SUPs during this maintenance period! If you do, it's possible your downstream servers will just end up resyncing all of the updates you just attempted to clean out. I schedule this overnight before my AM sync, so I have time to check on it before my sync runs.

Needed/helpful links:

- [Reindex the WSUS Database](reindex-the-wsus-database.md)
- [Agent XPs Server Configuration Option](/sql/database-engine/configure-windows/agent-xps-server-configuration-option)
- [Weekend Scripter: Use the Windows Task Scheduler to Run a Windows PowerShell Script](https://devblogs.microsoft.com/scripting/weekend-scripter-use-the-windows-task-scheduler-to-run-a-windows-powershell-script/)

### WSUS cleanup script

> [!NOTE]
> When you run the script on the WSUS server, use `LOCALHOST` instead of the actual `SERVERNAME`. Additionally, replace `PORT` with the used one.

```powershell
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")`
 | out-null
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer("SERVERNAME",$true,PORT);
$cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope;
$cleanupScope.DeclineSupersededUpdates = $true
$cleanupScope.DeclineExpiredUpdates = $true
$cleanupScope.CleanupObsoleteUpdates = $true
$cleanupScope.CompressUpdates = $true
#$cleanupScope.CleanupObsoleteComputers = $true
$cleanupScope.CleanupUnneededContentFiles = $true
$cleanupManager = $wsus.GetCleanupManager();
$cleanupManager.PerformCleanup($cleanupScope);
```

### Setting up the WSUS Cleanup task in Task Scheduler

> [!NOTE]
> As mentioned previously, if you are using Configuration Manager current branch version 1906 or a later version, automate the cleanup procedures by enabling the **WSUS Maintenance** options in the software update point configuration of the top-level site. For standalone WSUS servers or older versions of Configuration Manager, you can continue to use the following steps.

The [Weekend Scripter](https://blogs.technet.com/b/heyscriptingguy/archive/2012/08/11/weekend-scripter-use-the-windows-task-scheduler-to-run-a-windows-powershell-script.aspx) blog post mentioned in the previous section contains basic directions and troubleshooting for this step. However, I'll walk you through the process in the following steps.

1. Open **Task Scheduler** and select **Create a Task**. On the **General** tab, set the name of the task, the user that you want to run the PowerShell script as (most people use a service account). Select **Run whether a user is logged on or not**, and then add a description if you wish.

    :::image type="content" source="media/wsus-maintenance-guide/create-task.png" alt-text="Screenshot of the WSUS Create a task screen." border="false":::

2. Under the **Actions** tab, add a new action and specify the program/script you want to run. In this case, we need to use PowerShell and point it to the PS1 file we want it to run. You can use the [WSUS Cleanup script](#wsus-cleanup-script). This script performs cleanup options that Configuration Manager current branch version 1906 doesn't do. You can uncomment them if you are using standalone WSUS or an older version of Configuration Manager. If you would like a log, you can modify the last line of the script as follows:

    > [!NOTE]
    > When you run the script on the WSUS server, use `LOCALHOST` instead of the actual `SERVERNAME`. Additionally, replace `PORT` with the used one.

    ```powershell
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer("SERVERNAME",$true,PORT);
    $cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope;
    # $cleanupScope.DeclineSupersededUpdates = $true # Performed by CM1906
    # $cleanupScope.DeclineExpiredUpdates    = $true # Performed by CM1906
    # $cleanupScope.CleanupObsoleteUpdates   = $true # Performed by CM1906
    $cleanupScope.CompressUpdates          = $true
    $cleanupScope.CleanupObsoleteComputers = $true
    $cleanupScope.CleanupUnneededContentFiles = $true
    $cleanupManager = $wsus.GetCleanupManager();
    $cleanupManager.PerformCleanup($cleanupScope) | Out-File C:\WSUS\WsusClean.txt;
    ```

    You'll get an FYI/warning in Task Scheduler when you save. You can ignore this warning.

    :::image type="content" source="media/wsus-maintenance-guide/add-line.png" alt-text="Screenshot shows WSUS add a line of script to start the task.":::

3. On the **Triggers** tab, set your schedule for once a month or on any schedule you want. Again, you must ensure that you don't sync your WSUS during the entire cleanup and reindex time.

    :::image type="content" source="media/wsus-maintenance-guide/edit-trigger.png" alt-text="Screenshot shows Set the WSUS Edit Trigger for the task.":::

4. Set any other conditions or settings you would like to tweak as well. When you save the task, you may be prompted for credentials of the **Run As** user.

5. You can also use these steps to configure the [Decline-SupersededUpdatesWithExclusionPeriod.ps1](decline-superseded-updates.md) script to run every three months. I usually set this script to run before the other cleanup steps, but only after I have run it manually and ensured it completed successfully. I run at 12:00 AM on the first Sunday every three months.

### Setting up the SUSDB reindex for WID using SQLCMD and Task Scheduler

1. Save the [Reindex the WSUS database script](reindex-the-wsus-database.md) as a .sql file (for example, _SUSDBMaint.sql_).
2. Create a basic task and give it a name:

    :::image type="content" source="media/wsus-maintenance-guide/create-basic-task-wizard.png" alt-text="Screenshot of the WSUS Create Basic Task Wizard screen.":::

3. Schedule this task to start about 30 minutes after you expect your cleanup to finish running. My cleanup is running at 1:00 AM every first Sunday. It takes about 30 minutes to run and I am going to give it another 30 minutes before starting my reindex. It means I would schedule this task for every first Sunday at 2:00 AM, as shown here:

    :::image type="content" source="media/wsus-maintenance-guide/task-frequency.png" alt-text="Screenshot shows set the frequency for that task in the Create Basic Task Wizard.":::

4. Select the action to **Start a program**. In the **Program/script** box, type the following command. The file specified after the `-i` parameter is the path to the SQL script you saved in step 1. The file specified after the `-o` parameter is where you would like the log to be placed. Here's an example:

    `"C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.exe" -S \\.\pipe\Microsoft##WID\tsql\query -i C:\WSUS\SUSDBMaint.sql -o c:\WSUS\reindexout.txt`

    :::image type="content" source="media/wsus-maintenance-guide/script.png" alt-text="Screenshot shows how the script should look in the Create Basic Task Wizard.":::

5. You'll get a warning, similar to the one you got when creating the cleanup task. Select **Yes** to accept the arguments, and then select **Finish** to apply:

    :::image type="content" source="media/wsus-maintenance-guide/pop-up.png" alt-text="Screenshot of the Task Scheduler confirmation popup window." border="false":::

6. You can test the script by forcing it to run and reviewing the log for errors. If you run into issues, the log will tell you why. Usually if it fails, the account running the task doesn't have appropriate permissions or the WID service isn't started.

#### Setting up a basic Scheduled Maintenance Task in SQL for non-WID SUSDBs
  
> [!NOTE]
> You must be a sysadmin in SQL Server to create or manage maintenance plans.

1. Open **SQL Server Management Studio** and connect to your WSUS instance. Expand **Management**, right-click **Maintenance Plans**, and then select **New Maintenance Plan**. Give your plan a name.

    :::image type="content" source="media/wsus-maintenance-guide/maintenance-plan-name.png" alt-text="Screenshot of the typed name for your WSUS maintenance plan." border="false":::

2. Select **subplan1** and then ensure your **Toolbox** is in context:

    :::image type="content" source="media/wsus-maintenance-guide/toolbox.png" alt-text="Screenshot to ensure your Toolbox is in context.":::

3. Drag and drop the task **Execute T-SQL Statement Task**:

    :::image type="content" source="media/wsus-maintenance-guide/execute-t-sql-statement-task.png" alt-text="Screenshot of the Execute T-SQL Statement Task option.":::

4. Right-click it and select **Edit**. Copy and paste the WSUS reindex script, and then select **OK**:

    :::image type="content" source="media/wsus-maintenance-guide/paste-wsus-reindex-script.png" alt-text="Screenshot to Copy and paste the WSUS reindex script." border="false":::

5. Schedule this task to run about 30 minutes after you expect your cleanup to finish running. My cleanup is running at 1:00 AM every first Sunday. It takes about 30 minutes to run, and I am going to give it another 30 minutes before starting reindex. It means I would schedule this task to run every first Sunday at 2:00 AM.

    :::image type="content" source="media/wsus-maintenance-guide/new-job-schedule.png" alt-text="Screenshot of the WSUS New Job Schedule screen.":::

6. While creating the maintenance plan, consider adding a backup of the SUSDB into the plan as well. I usually back up first, then reindex. It may add more time to the schedule.

### Putting it all together

When running it in a hierarchy, the WSUS cleanup run should be done from the bottom of the hierarchy up. However, when using the script to decline superseded updates, the run should be done from the top down. Declining superseded updates is really a type of addition to an update rather than a removal. You're actually adding a type of **approval** in this case.

Since a sync can't be done during the actual cleanup, it's suggested to schedule/complete all tasks overnight. Then check on their completion via the logging the following morning, before the next scheduled sync. If something failed, maintenance can be rescheduled for the next night, once the underlying issue is identified and resolved.

These tasks may run faster or slower depending on the environment, and timing of the schedule should reflect that. Hopefully they are faster since my lab environment tends to be a bit slower than a normal production environment. I am a bit aggressive on the timing of the decline scripts. If Tier2 overlaps Tier3 by a few minutes, it will not cause a problem because my sync isn't scheduled to run.

Not syncing keeps the declines from accidentally flowing into my Tier3 replica WSUS servers from Tier2. I did give myself extra time between the Tier3 decline and the Tier3 cleanup since I definitely want to make sure the decline script finishes before running my cleanup.

It brings up a common question: Since I'm not syncing, why shouldn't I run all of the cleanups and reindexes at the same time?

The answer is that you probably could, but I wouldn't. If my coworker across the globe needs to run a sync, with this schedule I would minimize the risk of orphaned updates in WSUS. And I can schedule it to rerun to completion the next night.

|Time|Tier|Tasks|
|---|---|---|
|12:00 AM|Tier1-**Decline**| |
|12:15 AM|Tier2-**Decline**| |
|12:30 AM|Tier3-**Decline**| |
|1:00 AM|Tier3 WSUS Cleanup| |
|2:00 AM|Tier3 Reindex|Tier2 WSUS Cleanup|
|3:00 AM|Tier1-Cleanup|Tier2 Reindex|
|4:00 AM|Tier1 Reindex| |
  
> [!NOTE]
> If you're using Configuration Manager current branch version 1906 or a later version to perform WSUS Maintenance, Configuration Manager performs the cleanup after synchronization using the top-down approach. In this scenario, you can schedule the WSUS database backup and reindexing jobs to run before the configured sync schedule without worrying about any of the other steps, because Configuration Manager will handle everything else.

For more information about SUP maintenance in Configuration Manager, see the following articles:

- [Software updates maintenance](/mem/configmgr/sum/deploy-use/software-updates-maintenance)
- [Software updates maintenance in Configuration Manager](/troubleshoot/mem/configmgr/software-update-maintenance)
