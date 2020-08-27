---
title: Software updates maintenance
description: Describes the maintenance processes for software updates in Configuration Manager.
ms.date: 06/04/2020
ms.prod-support-area-path:
---
# Software updates maintenance in Configuration Manager

This article describes the maintenance processes for software updates and provides suggestions for how Configuration Manager administrators can maintain optimal performance of the WSUS database.

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090526

## Expired updates

As part of the ongoing update revision process, some updates in the Microsoft Update Catalog are expired. This typically occurs when there is a newer version of the update available. However, in rare cases, Microsoft may discover a problem with an update and therefore expire it. During software updates synchronization, these expired updates are marked as **Expired** in the Configuration Manager console. This expired status is indicated by a dimmed icon next to the update. These expired updates are automatically cleaned up from the Configuration Manager database on a regular schedule. The WSUS Synchronization Manager component removes expired updates. It does this only if the following conditions are true:

- The update is not referenced in an update assignment.
- The update is older than the value of **Updates Cleanup Age**. (By default, this value is seven days.)

WSUS Synchronization Manager at the top-level Configuration Manager site checks every hour for updates that have to be removed, and it removes expired updates if they match the criteria in the previous list. When WSUS Synchronization Manager deletes expired updates, you can see the following entries in the WSyncMgr.log file:

> Deleting old expired updates... SMS_WSUS_SYNC_MANAGER Deleted 100 expired updates SMS_WSUS_SYNC_MANAGER  
> \...  
> \...  
> Deleted 2995 expired updates total SMS_WSUS_SYNC_MANAGER

## Content cleanup

As expired updates are removed, content for those expired updates may become orphaned. WSUS Synchronization Manager also cleans up this orphaned content. As part of the content cleanup, WSUS Synchronization Manager analyzes the packages that are owned by the current site, finds content that is no longer referenced, and removes that content from the package source directory. By default, content is removed only if it has been orphaned for more than one day.

If any content is removed, the cleanup process also updates the package so that the updated content is sent to the distribution points (DPs). When WSUS Synchronization Manager removes orphaned content, you can see the following entries in the WSyncMgr.log file:

> Deleting orphaned content for package CS100006 (EPDefinitions) from source \<PackageSource> SMS_WSUS_SYNC_MANAGER  
> Deleting orphaned content folder \\\\\<PackageSource>\51b6db15-6938-4b37-9fa8-caf513e13930... SMS_WSUS_SYNC_MANAGER  
> \...  
> \...  
> Deleting orphaned content folder \\\\\<PackageSource>\526b6a85-a62c-4d54-bc0d-b3409223b0df... SMS_WSUS_SYNC_MANAGER  
> Deleted 12 orphaned content folders in package CS100006 (EPDefinitions) SMS_WSUS_SYNC_MANAGER  
> Refreshing package CS100006 (EPDefinitions) SMS_WSUS_SYNC_MANAGER

For more information about the cleanup of expired updates and content, see [Software Update Content Cleanup in System Center 2012 Configuration Manager](https://techcommunity.microsoft.com/t5/configuration-manager-archive/software-update-content-cleanup-in-system-center-2012/ba-p/273069).

## WSUS server maintenance

To maintain optimal performance of the WSUS database, we recommend that you routinely run the WSUS Cleanup Wizard tasks on the WSUS database (SUSDB) and also reindex the WSUS database on each WSUS computer that is hosting a Software Update Point role in the Configuration Manager environment. When you run WSUS Cleanup Wizard actions in a multilevel hierarchy, you should run the cleanup process on the lowest tier of the WSUS chain first and then move up to the next tier to run the Cleanup Wizard tasks. You should continue on up the hierarchy until you reach the top-tier WSUS computer. You can run this WSUS maintenance routine at the same time on multiple servers in the same tier.

Although reindexing can be performed in any order on any WSUS computer's SUSDB, we recommend that you run the cleanup and reindexing on each WSUS computer by running the reindex process first and then run the Cleanup Wizard tasks. If you tune the performance of the SUSDB first through reindexing, the Cleanup Wizard tasks will finish more quickly.

### Reindexing the WSUS database (SUSDB)

You can reindex of the WSUS database (SUSDB) by using the script in [Re-index the WSUS Database](https://gallery.technet.microsoft.com/scriptcenter/6f8cde49-5c52-4abd-9820-f1d270ddea61).

If the WSUS database is installed on an instance of Microsoft SQL Server, use SQL Server Management Studio to connect to the database server and to run the database maintenance script.

If the WSUS database is installed on Windows Internal Database, you can use either SQL Server Management Studio Express or the `sqlcmd` utility.

To use SQL Server Management Studio Express, follow these steps:

1. Start SQL Server Management Studio Express, and then connect to the database server.

   - For Windows Server 2012 or Windows Server 2012 R2, the server name would be as follows:

     `\\.\pipe\MICROSOFT##WID\tsql\query`

   - For older operating systems, the server name would be as follows:

     `\\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query`

2. Click **New Query**, paste the contents of the database maintenance script into the new query, and then click **Execute**.

To use the `sqlcmd` utility, follow these steps:

1. Open a command prompt by using administrator credentials.
2. Run one of the following commands, depending on your operating system:

   - For Windows Server 2012 or Windows Server 2012 R2:

     `sqlcmd -S \\.\pipe\MICROSOFT##WID\tsql\query -i <scriptLocation>\WsusDBMaintenance.sql`

   - For older operating systems:

     `sqlcmd -S \\.\pipe\MSSQL$MICROSOFT##SSEE\sql\query -i <scriptLocation>\WsusDBMaintenance.sql`

For more information, see [Reindex the WSUS Database](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939795(v=ws.10)?redirectedfrom=MSDN).

> [!TIP]
> If you aren't sure whether the WSUS database is hosted on SQL Server or Windows Internal Database, check the following registry key on the WSUS server:
>
> `HKEY_LOCAL_MACHINE\Software\Microsoft\Update Services\Server\Setup\<SQLServerName>`
>
> If you see only *ServerName* or *Server\Instance*, you are using SQL Server. If you see something that has a *##SSEE* or *##WID* string in it, the WSUS database is installed on Windows Internal Database.

To determine which version of SQL Server Management Studio Express to install, follow these guidelines:

- For Windows Server 2012 or Windows Server 2012 R2, go to the following folder, and then open the latest ErrorLog file in Notepad.

  `C:\Windows\WID\Log`

- For Windows Server 2008 R2 or earlier versions, go to the following folder, and then open the latest ErrorLog file in Notepad.

  `C:\Windows\SYSMSI\SSEE\MSSQL.2005\MSSQL\LOG`

At the top of the ErrorLog file, you will find the version number (for example, 9.00.4035.00 x64). To look up the version number, see the following article:

[SQL Server Versions](https://social.technet.microsoft.com/wiki/contents/articles/783.sql-server-versions.aspx)

Use the version number or service pack level to search the Microsoft Download Center for SQL Server Management Studio Express.

### Running a WSUS server cleanup

The WSUS Server Cleanup Wizard can be run from WSUS console > **Options**. We recommend that you run WSUS maintenance once a month. If cleanup was never run and the WSUS computer was in production for a long time, it's possible that cleanup may time out and fail. If this occurs, run the cleanup with only the unused updates and updates revisions check box selected. (This is the top check box.) Then, wait for the process to finish before you run the WSUS Server Cleanup Wizard again but with the next check box selected. This may require several passes to complete the cleanup process. Finally, run cleanup with all the options selected. For more information about the WSUS Server Cleanup Wizard, see [Use the Server Cleanup Wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd939856(v=ws.10)?redirectedfrom=MSDN).

### Cleaning up superseded updates

When WSUS is integrated with Configuration Manager, superseded updates may not be deleted because of the restrictions of the WSUS cleanup process. Therefore, we recommend that you periodically decline any unnecessary updates on the WSUS server as appropriate. Unnecessary updates include superseded updates, updates for products or classifications that are not present in the client environment, and expired updates. You can manually decline the updates in the WSUS console or use the following script.

> [!NOTE]
> Always back up the WSUS database (SUSDB) before you make any changes such as those described here.

Also, be aware that after you deline unneeded updates, you should reindex SUSDB and then run the WSUS Server Cleanup Wizard one more time to remove unneeded updates as appropriate. This will remove the updates from any Configuration Manager software update groups of which it is part. Cleaning up WSUS by using a [sample script](https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/69/06/Decline-SupersededUpdatesWithExclusionPeriod.ps1.txt) will allow scripted declining of superseded updates in your WSUS environment. Updates have to be declined at the top-level WSUS instance and replicated to downstream WSUS instances that are configured for replica mode. You will have to run the script on any WSUS instance that is running in Autonomous mode. To use the script, you must rename it as **Decline-SupersededUpdates.ps1** and then use it as the following instructions indicate. As always, it is important to test this script in a lab environment before you deploy the script in production.

#### Notes about the script

The default WSUS server port is 80. However, if you have WSUS installed to a custom IIS site, WSUS is probably using a different port. You will have to determine which port WSUS is using and then change the *-* *Port* parameter in the following examples to that port.

The argument `-DeclineLastLevelOnly` declines only those updates that *do not* supersede any other update. If you omit this argument, any update that is superseded will be declined. This leaves only updates that are not superseded in a state other than **declined**.

#### Running the script

1. Run the script with the `-SkipDecline` switch to see how many superseded updates are in WSUS. For example, to do a test run against WSUS Server without SSL, you would use the following command:

   `Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -Port 80 -SkipDecline`

2. You can decline only the updates that are superseded and not supersede updates (leaf-level updates):

   `Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -Port 80 -DeclineLastLevelOnly`

3. Or you can use the following command to decline *all* superseded updates:

   `Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8080`

#### Cleaning up WSUS from the WSUS console

If you have to or want to decline updates manually, you can do this directly from the WSUS console. To do this, follow these steps:

1. Open the Windows Update Services Microsoft Management Console (MMC).
2. Select the All Updates view. To do this, set the display to show the **Approval** status of **Any except Declined** with a status of **Any**, and then click **Refresh**.
3. Display the **Supersedence** column. To do this, right-click the column headers, and then select **Supersedence**.
4. Sort by supersedence. To do this, left-click the **Supersedence** column.
5. Select and decline the superseded updates.
