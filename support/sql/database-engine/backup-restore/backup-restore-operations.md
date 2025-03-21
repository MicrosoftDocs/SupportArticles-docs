---
title: SQL Server backup and restore operation issues
description: This article troubleshoots SQL Server backup and restore operation issues, such as the operation taking a long time, issues between different SQL Server versions.
ms.date: 03/21/2025
ms.custom: sap:Database Backup and Restore
ms.reviewer: ramakoni
editor: v-jesits
---
# Troubleshoot SQL Server backup and restore operations  

This article provides solutions for common issues that you might experience during Microsoft SQL Server backup and restore operations, and provides references to further information about these operations.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 224071

## Backup and restore operations take a long time

Backup and restore operations are I/O intensive. Backup/Restore throughput depends on how well the underlying I/O subsystem is optimized to handle the I/O volume. If you suspect that the backup operations are either stopped or taking too long to finish, you can use one or more of the following methods to estimate the time for completion or to track the progress of a backup or restore operation:

- The SQL Server error log contains information about previous backup and restore operations. You can use these details to estimate the time that's required to back up and restore the database in its current state. The following is a sample output from the error log:

    ```output
    RESTORE DATABASE successfully processed 315 pages in 0.372 seconds (6.604 MB/sec)
    ```

- In SQL Server 2016 and later versions, you can use XEvent [backup_restore_progress_trace](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases#monitor-progress-with-xevent) to track the progress of backup and restore operations.

- You can use the `percent_complete` column of [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) to track the progress of in-flight backup and restore operations.

- You can measure backup and restore throughput information by using the `Device throughput Bytes/sec` and `Backup/Restore throughput/sec` performance monitor counters. For more information, see [SQL Server, Backup Device Object](/sql/relational-databases/performance-monitor/sql-server-backup-device-object).

- Use the [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) script to get an estimate of backup times.

- Refer to [How It Works: What is Restore/Backup Doing?](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-what-is-restore-backup-doing/ba-p/315442). This blog post provides insight into the current stage of backup or restore operations.

**Things to check**

1. Check whether you're experiencing any of the known issues that are listed in the following table. Consider whether you should implement the changes or apply the fixes and best practices that are discussed in the corresponding articles.

    |Knowledge Base link|Explanation and recommended actions|
    |---|---|
    | [Optimizing Backup and Restore Performance in SQL Server](https://technet.microsoft.com/library/ms190954%28v=sql.105%29.aspx)|This article covers various best practices that you can use to improve the performance of Backup/Restore operations. For example, you can assign the `SE_MANAGE_VOLUME_NAME` special privilege to the Windows account that's running SQL Server to enable instant initialization of data files. This can produce significant performance gains.|
    | [2920151 Recommended hotfixes and updates for Windows Server 2012 R2-based failover clusters](https://support.microsoft.com/help/2920151) <br/><br/> [2822241 Windows 8 and Windows Server 2012 update rollup: April 2013](https://support.microsoft.com/help/2822241)|Current system rollups can include fixes for known issues at the system level that can degrade the performance of programs such as SQL Server. Installing these updates can help prevent such issues.|
    | [2878182 FIX: User mode processes in an application are unresponsive on servers that are running Windows Server 2012](https://support.microsoft.com/help/2878182) <br/><br/>|Backup operations are I/O intensive and can be affected by this bug. Apply this fix to help prevent these issues.|
    | [Configure antivirus software to work with SQL Server](../security/antivirus-and-sql-server.md)|Antivirus software may hold locks on .bak files. This can affect the performance of backup and restore operations. Follow the guidance in this article to exclude backup files from virus scans.|
    | [2820470 Delayed error message when you try to access a shared folder that no longer exists in Windows](https://support.microsoft.com/help/2820470)|Discusses an issue that occurs when you try to access a shared folder that no longer exists in Windows 2012 and later versions.|
    | [967351 A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)|Discusses an issue that occurs when an NTFS file system is heavily fragmented.|
    | [304101 Backup program is unsuccessful when you back up a large system volume](https://support.microsoft.com/help/304101)||
    |A backup or restore operation to a network location is slow|Isolate the issue to the network by trying to copy a similarly sized file to the network location from the server that's running SQL Server. Verify the performance.|

2. Check for error messages in the SQL Server error log and Windows event log for more pointers about the cause of the problem.

3. If you're using either third-party software or database maintenance plans to do simultaneous backups, consider whether you should change the schedules to minimize contention on the drive to which the backups are being written.

4. Work with your Windows administrator to check for firmware updates for your hardware.  

## Issues that affect database restoration between different SQL Server versions

**Symptoms**

A SQL Server backup can't be restored to an earlier version of SQL Server than the version at which the backup was created. For example, you can't restore a backup that's taken on a SQL Server 2019 instance to a SQL Server 2017 instance. Otherwise, the following error message appears:

> Error 3169: The database was backed up on a server running version %ls. That version is incompatible with this server, which is running version %ls. Either restore the database on a server that supports the backup, or use a backup that is compatible with this server.

**Resolution**

Use the following method to copy a database that's hosted on a later version of SQL Server to an earlier version of SQL Server.

> [!NOTE]
> The following procedure assumes that you have two SQL Server instances that are named SQL_A (higher version) and SQL_B (lower version).

1. Download and install the latest version of [SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) on both SQL_A and SQL_B.
1. On SQL_A, follow these steps:
   1. Right-click <_YourDatabase_> **Tasks** > **Generate Scripts**, and select the option to script the whole database and all database objects.
   1. On the **Set Scripting Options** screen, select **Advanced**, and then select the version of SQL_B under **General** > **Script for SQL Server Version**. Also, select the option that works best for you to save the generated scripts. Then, continue the wizard.
   1. Use the [bulk copy program utility (bcp)](/sql/tools/bcp-utility#examples) to copy data from different tables.
1. On SQL_B, follow these steps:
   1. Use the scripts that were generated on the SQL_A server to create database schema.
   1. On each of the tables, disable any foreign key constraints and triggers. If the table has any identity columns, enable identity insert.
   1. Use bcp to import the data that you exported in the previous step into corresponding tables.
   1. After the data import is finished, enable foreign key constraints and triggers, and disable identity insert for each of the tables that are affected in step c.

This procedure typically works well for small-to-medium-sized databases. For larger databases, Out Of Memory issues might occur in SSMS and other tools. You should consider using [SQL Server Integration Services (SSIS)](/sql/integration-services/sql-server-integration-services), replication, or other options to create a copy of a database from a later version to an earlier version of SQL Server.

For more information about how to generate scripts for your database, see [Script a database by using the Generate Scripts option](/sql/ssms/tutorials/scripting-ssms#script-a-database-by-using-the-generate-scripts-option).

## Backup job issues in Always On environments

**Symptoms**

You encounter problems that affect backup jobs or maintenance plans in Always On environments.

**Resolution**

- By default, the automatic backup preference is set to **Prefer Secondary**. This specifies that backups should occur on a secondary replica - except if the primary replica is the only replica online. You can't take differential backups of your database by using this setting. To change this setting, use SSMS on your current primary replica, and navigate to **Backup Preferences** page under **Properties** of your availability group.
- If you're using a maintenance plan or scheduled jobs to generate backups of your databases, make sure to create the jobs for each availability database on every server instance that hosts an availability replica for the availability group.

For more information about backups in an Always On environment, see the following articles:

- [Configure backups on secondary replicas of an Always On availability group](/sql/database-engine/availability-groups/windows/configure-backup-on-availability-replicas-sql-server)
- [Offload supported backups to secondary replicas of an availability group](/sql/database-engine/availability-groups/windows/active-secondaries-backup-on-secondary-replicas-always-on-availability-groups)

## Media-related errors when you restore a database from a backup

**Symptoms**

If you receive error messages that indicate a file issue, this is symptomatic of a corrupted backup file. The following are some examples of errors that you could get if a backup set is corrupted:

 > 3241: The media family on device '%ls' is incorrectly formed. SQL Server cannot process this media family.
 
 > 3242: The file on device '%ls' is not a valid Microsoft Tape Format backup set.

 > 3243: The media family on device '%ls' was created using Microsoft Tape Format version %d.%d. SQL Server supports version %d.%d.


**Cause**

These issues can occur because of issues that affect the underlying hardware (hard disks, network storage, and so on) or that are related to a virus or malware. Review Windows System event logs and hardware logs for reported errors, and take appropriate action (for example, upgrade firmware or fix networking issues).

**Resolution**

- You can use the [Restore Header](/sql/t-sql/statements/restore-statements-headeronly-transact-sql) statement to check your backup.
- To reduce the occurrence of these restore errors, enable the **Backup CHECKSUM** option when you run a backup to avoid backing up a corrupted database. For more information, see [Possible Media Errors During Backup and Restore (SQL Server)](/sql/relational-databases/backup-restore/possible-media-errors-during-backup-and-restore-sql-server).
- You can also enable trace flag 3023 to enable a checksum when you run backups by using backup tools. For more information, see [How to enable the CHECKSUM option if backup utilities don't expose the option](https://support.microsoft.com/topic/how-to-enable-the-checksum-option-if-backup-utilities-do-not-expose-the-option-0d5efb4c-5dfc-0122-c7e3-312a5dd5af3b).
- To fix these issues, you have to either locate another usable backup file or create a new backup set. Microsoft doesn't offer any solutions that can help retrieve data from a corrupted backup set.
- If a backup file restores successfully on one server but not on another, try different ways to copy the file between the servers. For example, try [robocopy](/windows-server/administration/windows-commands/robocopy) instead of a regular copy operation. Investigate whether the file is being modified during the copy operation on the network or the destination storage device. 

## Backups fail because of permissions issues

**Symptoms**

When you try to run database backup operations, one of the following errors occurs.

- **Scenario 1**: When you run a backup from SQL Server Management Studio, the backup fails and returns the following error message:
  > Backup failed for Server \<Server name\>.  (Microsoft.SqlServer.SmoExtended)  
  > System.Data.SqlClient.SqlError: Cannot open backup device '\<device name\>'. Operating system error 5(Access is denied.). (Microsoft.SqlServer.Smo)
- **Scenario 2**: Scheduled backups fail and generate an error message that's logged in the job history of the failed job, and that resembles the following:
  
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

**Cause**

Either of these scenarios can occur if the SQL Server service account doesn't have Read and Write permissions to the folder that backups are being written to. Backup statements can be run either as part of a job step or manually from SQL Server Management Studio. In either case, they always run under the context of the SQL Server Service startup account. Therefore, if the service account doesn't have the necessary privileges, you receive the error messages that were noted earlier.

**Resolution**

You can check the current permissions of the SQL Server Service account on a folder by navigating to the **Security** tab in the properties of the corresponding folder, selecting the **Advanced** button, and then using the **Effective Access** tab. For more information, see [Backup Devices](/sql/relational-databases/backup-restore/backup-devices-sql-server).


## Backup or restore operations that use third-party backup applications fail

SQL Server provides a Virtual Backup Device Interface (VDI) tool. This API enables independent software vendors to integrate SQL Server into their products to provide support for backup and restore operations. These APIs are engineered to provide maximum reliability and performance, and to support the full range of SQL Server backup and restore functionality. This includes the full range of snapshot and hot backup capabilities.

**Common troubleshooting steps**

- For versions that are earlier than SQL Server 2012, make sure that the SQLWriter service is started and that the startup account is set to **Local System**. Also, make sure that the NT AUTHORITY\SYSTEM login exists in SQL Server, and that it's part of the Sysadmin server role of the instance to which backups are run.

- For SQL Server 2012 and later versions, a new login that's named [NT SERVICE\SQLWriter] is created and provisioned as a login during setup. Make sure that this login exists in SQL Server and is part of the Sysadmin server role.

- Make sure that SqlServerWriter is listed when the `VSSADMIN LIST WRITERS` command is run at a command prompt on the server that's running SQL Server. This writer must be listed as a writer and should be in the **Stable** state to enable VSS backups to finish successfully.

- For more information, check the logs from the corresponding backup software and their support sites.

  |Symptoms or scenario|KB article|
  |---|---|
  |Backups of case-sensitive databases failing| [2987610 FIX: Error when you back up a database that has case-sensitive collation by using VSS in SQL Server 2012 SP2](https://support.microsoft.com/help/2987610) |
  |Third-party backups that are made by using VSS writer may fail and return 8229 errors.| [2987610 FIX: Error when you back up a database that has case-sensitive collation by using VSS in SQL Server 2012 SP2](https://support.microsoft.com/help/2987610) |
  | Understanding how VDI backup works |[How It Works: SQL Server - VDI (VSS) Backup Resources](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-sql-server-vdi-vss-backup-resources/ba-p/315695) |

### More resources

[How It Works: How many databases can be backed up simultaneously?](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-how-many-databases-can-be-backed-up-simultaneously/ba-p/315874)

## Backups might fail if change tracking is enabled

**Symptoms**

Backups might fail if change tracking is enabled on the databases and return errors that resemble the following one:

> Error: 3999, Severity: 17, State: 1.  
> \<Time Stamp\> spid \<spid\> Failed to flush the commit table to disk in dbid 8 due to error 2601. Check the error log for more information.

**Resolution**

To solve the issue, see the following articles:

- [2682488 FIX: Backup operation fails in a SQL Server 2008, in a SQL Server 2008 R2 or in a SQL Server 2012 database after you enable change tracking](https://support.microsoft.com/help/2682488)
- [2603910 FIX: Backup fails in SQL Server 2008, in SQL Server 2008 R2 or in SQL Server 2012 if you enable change tracking on the database](https://support.microsoft.com/help/2603910)

## Issues restoring backups of encrypted databases

**Symptoms**

You encounter issues when restoring backups of encrypted databases.

**Resolution**

To solve the issue, see [Move a TDE Protected Database to Another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server).

## Fail to restore a CRM backup from the Enterprise edition

**Symptoms**

You fail to restore a CRM backup from the Enterprise edition on a Standard edition.

**Resolution**

To solve the issue, see [2567984 "Database cannot be started in this edition of SQL Server" error when restoring a Microsoft Dynamics CRM database](https://support.microsoft.com/help/2567984).
  
## FAQ about SQL Server backup and restore operations

#### How can I check the status of a backup operation?

   Use the [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) script to get an estimate of backup times.

#### What should I do if SQL Server fails over in the middle of backup?

  Restart the restore or backup operation per [Restart an Interrupted Restore Operation (Transact-SQL)](/sql/relational-databases/backup-restore/restart-an-interrupted-restore-operation-transact-sql).

#### Can I restore database backups from older program versions on newer versions, and vice-versa?

  SQL Server backup can't be restored by using a version of SQL Server that's later than the version that created the backup. For more information, see [Compatibility Support](/sql/t-sql/statements/restore-statements-transact-sql).

#### How do I verify my SQL Server database backups?

  See the procedures that are documented in [RESTORE Statements - VERIFYONLY (Transact-SQL)](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).

#### How can I get the backup history of databases in SQL Server?

  See [How to get the backup history of databases in SQL Server](/sql/relational-databases/system-tables/backupset-transact-sql#query-backup-history).

#### Can I restore 32-bit backups on 64-bit servers, and vice-versa?

  Yes. The SQL Server on-disk storage format is the same in the 64-bit and 32-bit environments. Therefore, backup and restore operations work across 64-bit and 32-bit environments.

## General troubleshooting tips

- Make sure to provision Read and Write permissions to the SQL Server Service account on the folder that the backups are being written to. For more information, see [Permissions for backup](/sql/t-sql/statements/backup-transact-sql).
- Make sure that the folder that the backups are being written to have enough space to accommodate your database backups. You can use the `sp_spaceused` stored procedure to get a rough estimate of the backup size for a specific database.
- Always use the latest version of SSMS to make sure that you don't encounter any known issues that are related to configuration of jobs and maintenance plans.
- Do a test run of your jobs to make sure that the backups are created successfully. Always add logic to [verify your backups](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).
- If you plan to move system databases from one server to another, review [Move System Databases](/sql/relational-databases/databases/move-system-databases).
- If you notice intermittent backup failures, check whether you're experiencing an issue that's already fixed in the latest update for your SQL Server version. For more information, see [SQL Server Versions and updates](../../releases/download-and-install-latest-updates.md).
- To schedule and automate backups for SQL Express editions, see [Schedule and automate backups of SQL Server databases in SQL Server Express](./schedule-automate-backup-database.md).

## Reference topics for SQL Server backup and restore operations

- For more information about backup and restore operations, see the following article:

   ["Back Up and Restore of SQL Server Databases"](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases): This article covers the concepts of the backup and restore operations for SQL Server databases, provides links to additional topics, and provides detailed procedures to run various backups or restore tasks (such as verifying backups, and backing up by using T-SQL or SSMS). This is the parent topic about this subject in SQL Server documentation.
- The following table lists additional topics that you might want to review for specific tasks that are related to backup and restore operations.

    |Reference|Description|
    |---|---|
    |[BACKUP (Transact-SQL)](/sql/t-sql/statements/backup-transact-sql)|Provides answers to basic questions that are related to backups. Provides examples of different kinds of backup and restore operations.|
    |[Backup Devices (SQL Server)](/sql/relational-databases/backup-restore/backup-devices-sql-server)|Provides a great reference for understanding various backup devices, backing up to a network share, Azure blob storage and related tasks.|
    |[Recovery Models (SQL Server)](/sql/relational-databases/backup-restore/recovery-models-sql-server)|Covers in detail the various recovery models: Simple, Full, and Bulk-Logged. Provides information about how the recovery model affects backups.|
    |[Backup & restore: system databases (SQL Server)](/sql/relational-databases/backup-restore/back-up-and-restore-of-system-databases-sql-server)|Covers strategies and discusses what you must be aware of when you work on backup and restore operations of system databases.|
    |[Restore and Recovery Overview (SQL Server)](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server)|Covers how the recovery models affect restore operations. You should review this if you have questions about how the recovery model of a database can affect the restore process.|
    |[Manage Metadata When Making a Database Available on Another Server](/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server)|Various considerations that you should be aware of when a database is moved or you encounter any issues that affect logins, encryption, replication, permissions, and so on.|
    |[Working with Transaction Log Backups](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server)|Presents concepts about how to back up and restore (apply) transaction logs in the full and bulk-logged recovery models. Explains how to take routine backups of transaction logs (log backups) to recover data.|
    |[SQL Server Managed Backup to Microsoft Azure](/sql/relational-databases/backup-restore/sql-server-managed-backup-to-microsoft-azure)|Introduces managed backup and associated procedures.|
