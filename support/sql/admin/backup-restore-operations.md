---
title: Backup and restore operations
description: This article describes how to troubleshoot SQL Server back up and restore operation issues.
ms.date: 10/29/2020
ms.prod-support-area-path: Administration and Management
ms.reviewer: ramakoni
ms.topic: how-to
ms.prod: sql
---
# Troubleshooting SQL Server backup and restore operations  

This article provides solutions for common issues that you can experience with SQL server backup and restore operations and provides pointers to docs that have more detailed information about these operations.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 224071

## Backup or restore operation takes a long time

Backup and restore operations are I/O intensive. Backup/Restore throughput depends on how well the underlying I/O subsystem is optimized to handle the I/O volume. If you suspect that the backup operations are either hung or taking a long time to complete, you can use one or more of the following methods to estimate the time for completion or to track the progress of backup and restore operations:  

- The SQL Server error log contains information about past backup and restore operations. You can use these details to estimate the time that is required to back up and restore the database in its current state. The following is a sample output from the error log:

    > RESTORE DATABASE successfully processed 315 pages in 0.372 seconds (6.604 MB/sec)

- In SQL Server 2016 and later versions you can use XEvent [backup_restore_progress_trace](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases) to track the progress of backup and restore operations.

- You can also use the **percent_complete** column of [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) to track the progress of in-flight backup and restore operations.

- The throughput information that is related to backup and restore operations can be measured by using the Device throughput Bytes/sec and Backup/Restore throughput/sec performance monitor counters. For additional information, review [SQL Server, Backup Device Object](/sql/relational-databases/performance-monitor/sql-server-backup-device-object).

- Use the script [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) to get an estimate on backup times.

- [How It Works: What is Restore/Backup Doing?](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-what-is-restore-backup-doing/ba-p/315442) This blog post can help you gain insight into the current stage of backup or restore operations.

**Things to check**

1. Check whether you are experiencing any of the known issues that are listed in the following table. Consider whether you should implement the changes or apply the fixes and best practices that are discussed in the corresponding articles.

    |Knowledge Base or Books Online link|Explanation and recommended actions|
    |---|---|
    | [Optimizing Backup and Restore Performance in SQL Server](https://technet.microsoft.com/library/ms190954%28v=sql.105%29.aspx)|The Books Online topic covers various best practices that you can use to improve the performance of Backup/Restore operations. For example, you can assign the SE_MANAGE_VOLUME_NAME special privilege to the Windows account that is running SQL Server to enable instant initialization of data files. This can produce significant performance gains.|
    | [2920151 Recommended hotfixes and updates for Windows Server 2012 R2-based failover clusters](https://support.microsoft.com/help/2920151) <br/><br/> [2822241 Windows 8 and Windows Server 2012 update rollup: April 2013](https://support.microsoft.com/help/2822241)|Current system rollups can include fixes for known issues at the system level that can cause performance issues that affect programs such as SQL Server. Installing these updates can help prevent these issues.|
    | [2878182 FIX: User mode processes in an application are unresponsive on servers that are running Windows Server 2012](https://support.microsoft.com/help/2878182) <br/><br/>|Backup operations are I/O intensive and can be affected by this bug. Apply this fix to help prevent these issues.|
    | [309422 How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/help/309422)|Antivirus software may hold locks on .bak files. This can affect the performance of backup and restore operations. Follow the guidance in this article to exclude backup files from virus scans.|
    | [2820470 Delayed error message when you try to access a shared folder that no longer exists in Windows](https://support.microsoft.com/help/2820470)|Discusses an issue that occurs when you try to access a shared folder that no longer exists in Windows 2012 and later versions.|
    | [967351 A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)|Discusses an issue that occurs when an NTFS file system is heavily fragmented.|
    | [304101 Backup program is unsuccessful when you back up a large system volume](https://support.microsoft.com/help/304101)||
    | [2455009 FIX: Slow performance when you recover a database if there are many VLFs inside the transaction log in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2](https://support.microsoft.com/help/2455009)|The presence of many virtual log files could affect the time that is required to restore a database. This is especially true during the recovery phase of the restore operation. For information about other possible issues that can be caused by the presence of many VLFs, refer to [Database operations take a long time to complete, or they trigger errors when the transaction log has numerous virtual log files](https://support.microsoft.com/help/2028436).|
    |A backup or restore operation to a network location is slow|Isolate the issue to the network by trying to copy a similarly sized file to the network location from the server that is running SQL Server. Verify the performance.|
    |||

2. Check for more error messages in the SQL Server error log and Windows event log for more pointers about the cause of the problem.

3. If you are either using third-party software or database maintenance plans for performing multiple backups at the same time, consider whether you should change the schedules so that there is less contention on the drive to which the backups are being written.

4. Work with your windows administrator to check for firmware updates for your hardware.  

## Issues when restoring databases between different SQL versions

Any SQL Server backup can't be restored to an earlier version of SQL Server than the version at which the backup was created. For example, you can't restore a backup that is taken on a SQL Server 2019 instance on a SQL Server 2017 instance. An attempt to perform this operation will result in the following error message:

> Error 3169: The database was backed up on a server running version %ls. That version is incompatible with this server, which is running version %ls. Either restore the database on a server that supports the backup, or use a backup that is compatible with this server.

Use the following procedure to create a copy of database that is hosted on a later version of SQL Server on an earlier version of SQL Server.

> [!NOTE]
> The following procedure assumes you have two SQL Server instances named SQL_A (higher version) and SQL_B (lower version).

1. Download and install the latest version of [SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) on both SQL_A and SQL_B.
1. On SQL_A, take the following steps:
   1. Right click your database > **Tasks** > **Generate Scripts**, and select the option to script entire database and all database objects.
   1. Select **Advanced** on the **Set Scripting Options** screen and select the version of SQL_B under **General** > **Script for SQL Server Version**. Also select the option that works best for you to save the generated scripts and continue with the rest of the steps in the wizard.
   1. Use [bulk copy program utility (bcp)](/sql/tools/bcp-utility#examples) to copy out data from different tables.
1. On SQL_B, take the following steps:
   1. Use the scripts generated on the SQL_A to create database schema.
   1. On each of the tables, disable any foreign key constraints, triggers and if the table has any identity columns, enable identity insert.
   1. Use bcp to import the data that you exported in previous step into corresponding tables.
   1. After the data import is complete, enable foreign key constraints, triggers and disable identity insert for each of the tables that are affected in step c.

This procedure typically works well for smaller to medium size databases. For larger databases, Out Of Memory issues may occur in SSMS and other tools. You should consider using [SQL Server Integration Services (SSIS)](/sql/integration-services/sql-server-integration-services), Replication or other options to create a copy of a database from a higher version on a lower version of SQL server.

For more information on generating scripts for your database, see [Script a database by using the Generate Scripts option](/sql/ssms/tutorials/scripting-ssms#script-a-database-by-using-the-generate-scripts-option) and [MSSQLSERVER_3169](/sql/relational-databases/errors-events/mssqlserver-3169-database-engine-error).

## Issues with backup tasks in Always On environments

If you encounter problems with backup jobs or maintenance plans in Always On environments, note the following:

- By default, automated backup preference is set to Prefer Secondary, which specifies that backups should occur on a secondary replica except when the primary replica is the only replica online. You can't take differential backups of your database with this setting. To change this setting, use SSMS on your current primary replica and navigate to **Backup Preferences** page under **Properties** of your Availability group.
- If you are using maintenance plan or scheduled jobs to generate backups of your databases, be sure to create the job(s) for each availability database on every server instance that hosts an availability replica for the availability group.

For more information about regarding backup in Always On environments, see the following topics:

- [Configure backups on secondary replicas of an Always On availability group](/sql/database-engine/availability-groups/windows/configure-backup-on-availability-replicas-sql-server)
- [Offload supported backups to secondary replicas of an availability group](/sql/database-engine/availability-groups/windows/active-secondaries-backup-on-secondary-replicas-always-on-availability-groups)

## Errors when restoring a database from backup

If you are receiving errors indicating that there's an issue with the file, it is a symptom of a corrupt backup file. Examples of errors you may experience when a backup set is corrupt include, but not limited to the following:

- > 3241:The media family on device '%ls' is incorrectly formed. SQL Server cannot process this media family.
- > 3242:The file on device '%ls' is not a valid Microsoft Tape Format backup set.
- > 3243: The media family on device '%ls' was created using Microsoft Tape Format version %d.%d. SQL Server supports version %d.%d.

> [!NOTE]
> You can use [Restore Header](/sql/t-sql/statements/restore-statements-headeronly-transact-sql) statement to check your backups.

These issues can occur due to issues with underlying hardware (hard disks, network storage etc.), virus, malware etc. Review Windows System event logs and hardware logs for errors and take appropriate action (for example: upgrade firmware, fix networking issues etc.

To prevent these errors, Enable **Backup CHECKSUM** option when performing the backup to avoid backing up a corrupt database. For more information, see [Possible Media Errors During Backup and Restore (SQL Server)](/sql/relational-databases/backup-restore/possible-media-errors-during-backup-and-restore-sql-server). You can also enable trace flag 3023 to enable checksum when you perform backups by using backup tools. For more information, see [How to enable the CHECKSUM option if backup utilities do not expose the option](https://support.microsoft.com/topic/how-to-enable-the-checksum-option-if-backup-utilities-do-not-expose-the-option-0d5efb4c-5dfc-0122-c7e3-312a5dd5af3b).

To solve these issues, you need to either locate another usable backup file or create a new backup set. Microsoft does not offer any solutions that can help retrieve data from a corrupt backup set.

> [!NOTE]
> If a backup file restores successfully on one server but not on another, try different ways to copy the file between the servers. For example try [robocopy](/windows-server/administration/windows-commands/robocopy) instead of a regular copy operation.

## Backups failing due to permission issues

When you try to perform database backup operations, one of the following errors may occur:

- Scenario 1: When running backup from SQL Server Management Studio, the backup may fail with an error:
  > Backup failed for Server \<Server name\>.  (Microsoft.SqlServer.SmoExtended)  
  > System.Data.SqlClient.SqlError: Cannot open backup device '\<device name\>'. Operating system error 5(Access is denied.). (Microsoft.SqlServer.Smo)
- Scenario 2:  Scheduled backups may fail with an error message like the following logged in job history of the failed job:
  
    ```output
    Executed as user: <Owner of the job>. ....2 for 64-bit  Copyright (C) 2019 Microsoft. All rights reserved.    
    Started:  5:49:14 PM  Progress: 2021-08-16 17:49:15.47    
    Source: {GUID}      Executing query "DECLARE @Guid UNIQUEIDENTIFIER      EXECUTE msdb..sp...".: 100% complete  End Progress  
    Error: 2021-08-16 17:49:15.74     
    Code: 0xC002F210     
    Source: Back Up Database (Full) Execute SQL Task     
    Description: Executing the query "EXECUTE master.dbo.xp_create_subdir N'C:\backups\D..." failed with the following error: "xp_create_subdir() returned error 5, 'Access is denied.'". 
    Possible failure reasons: Problems with the query, "ResultSet" property not set correctly, parameters not set correctly, or connection not established correctly.
    ```

Either of these scenarios can occur when SQL Server service account doesn't have Read and Write permissions to the folder where backups are being written to. Backup statements, either executed as part of a job step or manually from SQL Server Management Studio always execute under the context of SQL Server Service startup account. So when the service account doesn't have the necessary privileges you will receive error messages a noted above.

For more information, see [Backup Devices](/sql/relational-databases/backup-restore/backup-devices-sql-server).

> [!NOTE]
> You can check the current permissions of SQL Service account on a folder by navigating to Security tab in the properties of the corresponding folder, selecting the **Advanced** button and using **Effective Access** tab.

## Backup or restore operations that use third-party backup applications fail

SQL Server provides an API that is named Virtual Backup Device Interface (VDI). This API enables independent software vendors to integrate SQL Server into their products to provide support for backup and restore operations. These APIs are engineered to provide maximum reliability and performance and to support the full range of SQL Server backup and restore functionality. This includes the full range of snapshot and hot backup capabilities.

**Common troubleshooting steps**

- For versions earlier than SQL Server 2012, make sure that the SQLWriter service is started and that the startup account is set to Local System. Also, make sure that NT AUTHORITY\SYSTEM login exists in SQL Server and that it is part of the sysadmin server role of the instance to which backups are performed.

- For SQL Server 2012 and later versions, a new login that is named [NT SERVICE\SQLWriter] is created and provisioned as a login during setup. Make sure that this login exists in SQL Server and is part of the sysadmin server role.

- Make sure that SqlServerWriter is listed when the VSSADMIN LIST WRITERS command is run at a command prompt on the server that is running SQL Server. This writer must be listed as a writer and should be in the **Stable** state to enable VSS backups to complete successfully.

- For additional pointers, check the logs from the corresponding backup software and their support sites.

  |Symptoms or scenario|KB article|
  |---|---|
  |Backups of case-sensitive databases failing| [2987610 FIX: Error when you back up a database that has case-sensitive collation by using VSS in SQL Server 2012 SP2](https://support.microsoft.com/help/2987610) |
  |Third-party backups that are made by using VSS writer may fail and return 8229 errors.| [2987610 FIX: Error when you back up a database that has case-sensitive collation by using VSS in SQL Server 2012 SP2](https://support.microsoft.com/help/2987610) |
  | Understanding how VDI backup works |[How It Works: SQL Server - VDI (VSS) Backup Resources](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-sql-server-vdi-vss-backup-resources/ba-p/315695) |
  |Azure Site recovery agent reports failure | [ASR Agent or other non-component VSS backup fails for a server hosting SQL Server 2008 R2](https://support.microsoft.com/help/4504103) |
  |||

**More resources** 

[How It Works: How many databases can be backed up simultaneously?](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-how-many-databases-can-be-backed-up-simultaneously/ba-p/315874)

## Miscellaneous issues

|Symptom/Scenario|Remedial actions or additional information|
|---|---|
|Backups may fail when change tracking is enabled on the databases and return errors that resemble the following:<br/><br/>Error: 3999, Severity: 17, State: 1.<br/><br/>< **Time Stamp** t> spid< **spid** > Failed to flush the commit table to disk in dbid 8 due to error 2601. Check the errorlog for<br/><br/><br/>|See the following Microsoft Knowledge Base articles:<ul><li> [2682488 FIX: Backup operation fails in a SQL Server 2008, in a SQL Server 2008 R2 or in a SQL Server 2012 database after you enable change tracking](https://support.microsoft.com/help/2682488)</li><li> [2603910 FIX: Backup fails in SQL Server 2008, in SQL Server 2008 R2 or in SQL Server 2012 if you enable change tracking on the database](https://support.microsoft.com/help/2603910) </li><li> [2522893 FIX: A backup operation on a SQL Server 2008 or SQL Server 2008 R2 database fails if you enable change tracking on this database](https://support.microsoft.com/help/2522893)</li><ul> |
|Issues restoring backups of encrypted databases| [Move a TDE Protected Database to Another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server) |
|Trying to restore a CRM backup from the Enterprise edition fails on a Standard edition| [2567984 "Database cannot be started in this edition of SQL Server" error when restoring a Microsoft Dynamics CRM database](https://support.microsoft.com/help/2567984) |
|||

## FAQ about SQL Server backup and restore operations

### How can I check the status of backup operations?

   Use the script [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) to get an estimate on backup times.

### What should I do when SQL Server fails over in the middle of backup?

  Restart the restore or backup operations per [Restart an Interrupted Restore Operation (Transact-SQL)](/sql/relational-databases/backup-restore/restart-an-interrupted-restore-operation-transact-sql)

### Can I restore database backups from older program versions on newer versions, and vice-versa?

  SQL Server backup cannot be restored by a version of SQL Server that is later than the version that created the backup. For more information, see the [Compatibility Support](/sql/t-sql/statements/restore-statements-transact-sql).

### How do I verify my SQL Server database backups?

  See the procedures that are documented in [RESTORE Statements - VERIFYONLY (Transact-SQL)](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).

### How can I get the backup history of databases in SQL Server?

  See [How to get the backup history of databases in SQL Server](https://gallery.technet.microsoft.com/scriptcenter/how-to-get-the-backup-ea70af7f).

### Can I restore 32-bit backups on 64-bit servers, and vice-versa?

  Yes. Per the **Back Up and Restore of SQL Server Databases** topic, the SQL Server on-disk storage format is the same in the 64-bit and 32-bit environments. Therefore, backup and restore operations work across 32-bit and 64-bit environments. A backup that is created on a server instance that is running in one environment can be restored on a server instance that is running in the other environment.

## General troubleshooting tips

- Be sure to provision Read and Write permissions to SQL Server Service account on the folder where the backups are being written to. For more information, see [Permissions for backup](/sql/t-sql/statements/backup-transact-sql).
- Ensure the folder where the backups are being written to have enough space to accommodate the backups of your databases. You can use `sp_spaceused` stored procedure to get a rough estimate of size of backup for a specific database.
- Always use latest version of SSMS to ensure you do not run into any known issues related to configuration of jobs and maintenance plans.
- Do a test run of your jobs to ensure the backups are getting created successfully. Always add logic to [verify your backups](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).
- If you are looking to move system databases from one server to another, review [Move System Databases](/sql/relational-databases/databases/move-system-databases).
- If you are noticing intermittent backup failures, check if you are running into an issue that is already addressed in a most recent update for your SQL Server version. For more information, review [SQL Server Versions and updates](../general/determine-version-edition-update-level.md).
- To schedule and automate backups for SQL Express editions, review [Schedule and automate backups of SQL Server databases in SQL Server Express](schedule-automate-backup-database.md).

## Reference topics for SQL Server backup and restore operations

- For more information about backup and restore operations, see the following topics in Books Online.
  [Back Up and Restore of SQL Server Databases](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases): This topic covers the concepts of the backup and restore operations for SQL Server databases, provides links to additional topics, and provides detailed procedures about how to perform various backups or restore tasks (such as verifying backups, backing up by using T-SQL or SSMS, and so forth). This is the parent topic about this subject in SQL Server documentation.
- The following table lists more topics that you may want to review for specific tasks that are related to backup and restore operations.

    |Reference|Provide answers for|
    |---|---|
    |[BACKUP (Transact-SQL)](/sql/t-sql/statements/backup-transact-sql)|Provides answers to basic questions that are related to backup. Provides examples of different kinds of backup and restore operations.|
    |[Backup Devices (SQL Server)](/sql/relational-databases/backup-restore/backup-devices-sql-server)|Provides a great reference for understanding various backup devices, backing up to a network share, Azure blob storage and related tasks.|
    |[Recovery Models (SQL Server)](/sql/relational-databases/backup-restore/recovery-models-sql-server)|Covers in detail the various recovery models: Simple, Full, and Bulk-Logged. Provides information about how the recovery model affects backups.|
    |[Backup & restore: system databases (SQL Server)](/sql/relational-databases/backup-restore/back-up-and-restore-of-system-databases-sql-server)|Covers strategies and discusses what you must be aware of when you work on backup and restore operations of system databases.|
    |[Restore and Recovery Overview (SQL Server)](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server)|Covers how the recovery models affect restore operations. You should review this if you have questions about how the recovery model of a database can affect the restore process.|
    |[Manage Metadata When Making a Database Available on Another Server](/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server)|Various considerations that you should be aware of when a database is moved or you encounter any issues that affect logins, encryption, replication, permissions, and so on.|
    |[Working with Transaction Log Backups](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server)|Presents concepts about how to back up and restore (apply) transaction logs in the full and bulk-logged recovery models. Explains how to take routine backups of transaction logs (log backups) to recover data.|
    |[SQL Server Managed Backup to Microsoft Azure](/sql/relational-databases/backup-restore/sql-server-managed-backup-to-microsoft-azure)|Introduces managed backup and associated procedures.|
