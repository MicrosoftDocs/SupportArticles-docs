---
title: SQL Server backup and restore operation issues
description: This article troubleshoots SQL Server backup and restore operation issues, like the operation taking a long time, issues between different SQL Server versions.
ms.date: 05/20/2026
ms.custom: sap:Database Backup and Restore
ms.reviewer: ramakoni, v-shaywood
editor: v-jesits
---
# Troubleshoot SQL Server backup and restore operations

## Summary

This article helps you troubleshoot common SQL Server backup and restore operations issues. These problems include slow backup or restore performance, version compatibility errors, Always On availability group backup jobs, media errors, permissions failures, third-party VDI and VSS backups, change tracking failures, and encrypted database restores. The article also includes a frequently asked questions section and links to reference topics for SQL Server backup and restore.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 224071

## Backup and restore operations take a long time

Backup and restore operations are I/O intensive. Backup and restore throughput depends on how well the underlying I/O subsystem is optimized to handle the I/O volume. If you suspect that backup operations are stopped or are taking too long to finish, use one or more of the following methods to estimate the time to completion or to track the progress of a backup or restore operation:

- The SQL Server error log contains information about previous backup and restore operations. You can use these details to estimate the time that's required to back up and restore the database in its current state. The following is a sample output from the error log:

    ```output
    RESTORE DATABASE successfully processed 315 pages in 0.372 seconds (6.604 MB/sec)
    ```

- In SQL Server 2016 and later versions, use the XEvent [backup_restore_progress_trace](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases#monitor-progress-with-xevent) to track the progress of backup and restore operations.

- Use the `percent_complete` column of [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) to track the progress of in-flight backup and restore operations.

- Measure backup and restore throughput by using the `Device throughput Bytes/sec` and `Backup/Restore throughput/sec` performance monitor counters. For more information, see [SQL Server, Backup Device Object](/sql/relational-databases/performance-monitor/sql-server-backup-device-object).

- Use the [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) script to get an estimate of backup times.

- Refer to [How It Works: What is Restore/Backup Doing?](https://techcommunity.microsoft.com/blog/sqlserversupport/how-it-works-what-is-restorebackup-doing/315442). This blog post provides insight into the current stage of backup or restore operations.

### Investigate slow backup or restore performance

1. Check whether you're hitting any of the known issues in the following table, and consider applying the relevant fixes or best practices.

    |Knowledge Base link|Explanation and recommended actions|
    |---|---|
    | [Back up and restore of SQL Server databases](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases)|Covers best practices that can improve backup and restore performance. For example, grant the `SE_MANAGE_VOLUME_NAME` privilege to the Windows account that runs SQL Server to let instant file initialization speed up data file operations.|
    | [Configure antivirus software to work with SQL Server](../security/antivirus-and-sql-server.md)|Antivirus software might hold locks on `.bak` files, which can affect the performance of backup and restore operations. Follow the guidance in this article to exclude backup files from virus scans.|
    | [967351 A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)|Discusses an issue that occurs when an NTFS file system is heavily fragmented.|
    |A backup or restore operation to a network location is slow|Isolate the issue to the network by copying a similarly sized file to the network location from the server that runs SQL Server, and check the performance.|

2. Check the SQL Server error log and Windows event log for error messages that point to the cause of the problem.

3. If you use third-party software or database maintenance plans to do simultaneous backups, consider changing the schedules to minimize contention on the drive that the backups are written to.

4. Work with your Windows administrator to check for firmware updates for your hardware.  

## Restore a database between different SQL Server versions

### Symptoms

You can't restore a SQL Server backup to an earlier version of SQL Server than the version that created the backup. For example, you can't restore a backup taken on a SQL Server 2022 instance to a SQL Server 2019 instance. Otherwise, the following error message appears:

> Error 3169: The database was backed up on a server running version %ls. That version is incompatible with this server, which is running version %ls. Either restore the database on a server that supports the backup, or use a backup that is compatible with this server.

### Resolution

Use the following method to copy a database hosted on a later version of SQL Server to an earlier version of SQL Server.

> [!NOTE]
> The following procedure assumes that you have two SQL Server instances named SQL_A (higher version) and SQL_B (lower version).

1. Download and install the latest version of [SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) on both SQL_A and SQL_B.
1. On SQL_A, follow these steps:
   1. Right-click <_YourDatabase_> > **Tasks** > **Generate Scripts**, and select the option to script the whole database and all database objects.
   1. On the **Set Scripting Options** screen, select **Advanced**, and then select the version of SQL_B under **General** > **Script for SQL Server Version**. Then, select the save option that works best for you, and continue the wizard.
   1. Use the [bulk copy program utility (bcp)](/sql/tools/bcp-utility#examples) to copy data from different tables.
1. On SQL_B, follow these steps:
   1. Use the scripts generated on the SQL_A server to create the database schema.
   1. On each table, disable any foreign key constraints and triggers. If the table has identity columns, enable identity insert.
   1. Use bcp to import the data that you exported in the previous step into the corresponding tables.
   1. After the data import finishes, enable foreign key constraints and triggers, and disable identity insert for each of the tables changed in step c.

This procedure typically works well for small to medium-sized databases. For larger databases, out-of-memory issues might occur in SSMS and other tools. Consider using [SQL Server Integration Services (SSIS)](/sql/integration-services/sql-server-integration-services), replication, or other options to copy a database from a later version to an earlier version of SQL Server.

For more information about how to generate scripts for your database, see [Script a database by using the Generate Scripts option](/sql/ssms/tutorials/scripting-ssms#script-a-database-by-using-the-generate-scripts-option).

## Backup job problems in Always On availability groups

### Symptoms

You encounter problems that affect backup jobs or maintenance plans in Always On availability group environments.

### Resolution

- By default, the automatic backup preference is set to **Prefer Secondary**. This setting specifies that backups occur on a secondary replica, unless the primary replica is the only replica online. You can't take differential backups of your database with this setting. To change this setting, use SSMS on your current primary replica and go to the **Backup Preferences** page under **Properties** of your availability group.
- If you use a maintenance plan or scheduled jobs to generate backups of your databases, create the jobs for each availability database on every server instance that hosts an availability replica for the availability group.

For more information about backups in an Always On environment, see the following articles:

- [Configure backups on secondary replicas of an Always On availability group](/sql/database-engine/availability-groups/windows/configure-backup-on-availability-replicas-sql-server)
- [Offload supported backups to secondary replicas of an availability group](/sql/database-engine/availability-groups/windows/active-secondaries-backup-on-secondary-replicas-always-on-availability-groups)

## Media errors when you restore a database from a backup

### Symptoms

Error messages that indicate a file problem typically point to a corrupted backup file. The following errors are examples of problems you might encounter if a backup set is corrupted:

 > 3241: The media family on device '%ls' is incorrectly formed. SQL Server cannot process this media family.
 
 > 3242: The file on device '%ls' is not a valid Microsoft Tape Format backup set.

 > 3243: The media family on device '%ls' was created using Microsoft Tape Format version %d.%d. SQL Server supports version %d.%d.


### Cause

These problems can occur because of issues that affect the underlying hardware (hard disks, network storage, and so on) or because of a virus or malware. Review Windows System event logs and hardware logs for reported errors, and take appropriate action (for example, upgrade firmware or fix networking issues).

### Resolution

- Use the [RESTORE HEADERONLY](/sql/t-sql/statements/restore-statements-headeronly-transact-sql) statement to check your backup.
- To reduce the occurrence of these restore errors, enable the **Backup CHECKSUM** option when you run a backup to avoid backing up a corrupted database. For more information, see [Possible media errors during backup and restore (SQL Server)](/sql/relational-databases/backup-restore/possible-media-errors-during-backup-and-restore-sql-server).
- You can also enable trace flag 3023 to enable a checksum when you run backups by using backup tools. For more information, see [Server configuration: backup checksum default](/sql/database-engine/configure-windows/backup-checksum-default).
- To fix these problems, locate another usable backup file or create a new backup set. Microsoft doesn't offer any solutions that can help retrieve data from a corrupted backup set.
- If a backup file restores successfully on one server but not on another, try different ways to copy the file between the servers. For example, try [robocopy](/windows-server/administration/windows-commands/robocopy) instead of a regular copy operation. Investigate whether the file is changed during the copy operation on the network or on the destination storage device. 

## Backups fail because of permissions problems

### Symptoms

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

### Cause

Either scenario can occur if the SQL Server service account doesn't have Read and Write permissions to the folder that backups are written to. Backup statements can run either as part of a job step or manually from SQL Server Management Studio. In either case, they run under the context of the SQL Server service startup account. So, if the service account doesn't have the necessary privileges, you get the error messages noted earlier.

### Resolution

Check the current permissions of the SQL Server service account on a folder by going to the **Security** tab in the properties of the folder, selecting **Advanced**, and then using the **Effective Access** tab. For more information, see [Backup devices](/sql/relational-databases/backup-restore/backup-devices-sql-server).


## Third-party backup or restore operations fail

SQL Server provides a Virtual Backup Device Interface (VDI). This API lets independent software vendors integrate SQL Server into their products to support backup and restore operations. These APIs are engineered to provide reliability and performance, and to support the full range of SQL Server backup and restore functionality, including snapshot and hot backup capabilities.

### Common troubleshooting steps

- In all supported versions of SQL Server, a login named `NT SERVICE\SQLWriter` is created and provisioned during setup. Check that this login exists in SQL Server and is part of the **sysadmin** server role on the instance that's being backed up. Also, check that the SQL Server VSS Writer service is started and that its startup account is set to **Local System**.

- Check that `SqlServerWriter` is listed when you run the `VSSADMIN LIST WRITERS` command at an elevated command prompt on the server that runs SQL Server. The writer must be present and in the **Stable** state for VSS backups to finish successfully.

- For more information, check the logs from the backup software and the vendor's support site.

  |Symptoms or scenario|Reference|
  |---|---|
  | Understanding how VDI backup works |[How It Works: SQL Server - VDI (VSS) backup resources](https://techcommunity.microsoft.com/blog/sqlserversupport/how-it-works-sql-server---vdi-vss-backup-resources/315695) |
  | How many databases can be backed up simultaneously |[How It Works: How many databases can be backed up simultaneously?](https://techcommunity.microsoft.com/blog/sqlserversupport/how-it-works-how-many-databases-can-be-backed-up-simultaneously/315874)|

## Backups fail when change tracking is enabled

### Symptoms

Backups might fail when you enable change tracking on the database. You might see an error like the following one:

> Error: 3999, Severity: 17, State: 1.  
> \<Time Stamp\> spid \<spid\> Failed to flush the commit table to disk in dbid 8 due to error 2601. Check the error log for more information.

### Resolution

If you encounter this problem on a supported version of SQL Server, install the latest cumulative update for your version. For background and historical fixes, see the following articles:

- [2682488 FIX: Backup operation fails in a SQL Server 2008, in a SQL Server 2008 R2 or in a SQL Server 2012 database after you enable change tracking](https://support.microsoft.com/help/2682488)

## Restore backups of encrypted databases

### Symptoms

You encounter problems when you restore backups of databases protected by transparent data encryption (TDE).

### Resolution

To fix the problem, see [Move a TDE protected database to another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server).

## Restore a Dynamics CRM backup from Enterprise edition to Standard edition

### Symptoms

Restoring a Microsoft Dynamics CRM database backup taken on SQL Server Enterprise edition fails on SQL Server Standard edition.

### Resolution

To fix the issue, see ["Database cannot be started in this edition of SQL Server" error when restoring a Microsoft Dynamics CRM database](/previous-versions/troubleshoot/dynamics/crm/database-cannot-be-started-in-this-edition-of-sql-error-when-restoring).
  
## Frequently asked questions about SQL Server backup and restore

#### How can I check the status of a backup operation?

   Use the [estimate_backup_restore](https://github.com/microsoft/mssql-support/blob/master/sample-scripts/backup_restore/estimate_backup_restore.sql) script to estimate backup times.

#### What should I do if SQL Server fails over in the middle of a backup?

  Restart the restore or backup operation per [Restart an interrupted restore operation (Transact-SQL)](/sql/relational-databases/backup-restore/restart-an-interrupted-restore-operation-transact-sql).

#### Can I restore database backups from older versions on newer versions, and vice versa?

  You can't restore a SQL Server backup by using a version of SQL Server earlier than the version that created the backup. For more information, see [RESTORE compatibility support](/sql/t-sql/statements/restore-statements-transact-sql).

#### How do I check my SQL Server database backups?

  See the procedures documented in [RESTORE statements - VERIFYONLY (Transact-SQL)](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).

#### How can I get the backup history of databases in SQL Server?

  See [How to get the backup history of databases in SQL Server](/sql/relational-databases/system-tables/backupset-transact-sql#query-backup-history).

#### Can I restore 32-bit backups on 64-bit servers, and vice versa?

  Yes. The SQL Server on-disk storage format is the same in 64-bit and 32-bit environments. So, backup and restore operations work across 64-bit and 32-bit environments.

#### How do I back up and restore a database protected by transparent data encryption (TDE)?

  Back up the database, the database encryption key's server certificate, and the certificate's private key. To restore the backup on another instance, first restore the server certificate (with its private key) to the `master` database on the target instance, and then restore the user database backup. For step-by-step guidance, see [Move a TDE protected database to another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server).

#### Does backup compression work on TDE-enabled databases?

  Yes. Starting with SQL Server 2016, backup compression works on TDE-enabled databases when you specify `MAXTRANSFERSIZE` greater than 65536 (64 KB) in the `BACKUP` statement. Without that setting, the backup runs uncompressed even when you request compression. For details, see [Backup compression](/sql/relational-databases/backup-restore/backup-compression-sql-server).

#### How do VDI and VSS backups interact with Always On availability group secondary replicas?

  VSS-based (snapshot) backups taken through the SQL Writer service are supported only against the primary replica. On secondary replicas, request a copy-only full backup through the VDI client, because VSS full backups against a secondary aren't supported. For more information, see [Active secondaries: Backup on secondary replicas (Always On availability groups)](/sql/database-engine/availability-groups/windows/active-secondaries-backup-on-secondary-replicas-always-on-availability-groups).

## General troubleshooting tips

- Grant **Read** and **Write** permissions to the SQL Server service account on the folder where you write backups. For more information, see [Permissions for backup](/sql/t-sql/statements/backup-transact-sql).
- Check that the folder where you write backups has enough space for your database backups. Use the `sp_spaceused` stored procedure to get a rough estimate of the backup size for a database.
- Use the latest version of SSMS to avoid known problems related to job and maintenance plan configuration.
- Do a test run of your jobs to check that backups are created successfully. Add logic to [check your backups](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).
- If you plan to move system databases from one server to another, review [Move system databases](/sql/relational-databases/databases/move-system-databases).
- If you see intermittent backup failures, check whether the latest update for your SQL Server version fixes the problem. For more information, see [SQL Server versions and updates](../../releases/download-and-install-latest-updates.md).
- To schedule and automate backups for SQL Server Express editions, see [Schedule and automate backups of SQL Server databases in SQL Server Express](./schedule-automate-backup-database.md).

## Reference topics for SQL Server backup and restore

The following table lists topics to review for specific backup and restore tasks.

|Article|Description|
|---|---|
|[BACKUP (Transact-SQL)](/sql/t-sql/statements/backup-transact-sql)|Answers basic questions about backups, and provides examples of different kinds of backup and restore operations.|
|[Backup devices (SQL Server)](/sql/relational-databases/backup-restore/backup-devices-sql-server)|A reference for understanding backup devices, backing up to a network share, Azure Blob Storage, and related tasks.|
|[Recovery models (SQL Server)](/sql/relational-databases/backup-restore/recovery-models-sql-server)|Covers the Simple, Full, and Bulk-logged recovery models in detail, and explains how the recovery model affects backups.|
|[Back up and restore of system databases (SQL Server)](/sql/relational-databases/backup-restore/back-up-and-restore-of-system-databases-sql-server)|Covers strategies and considerations when you work on backup and restore operations for system databases.|
|[Restore and recovery overview (SQL Server)](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server)|Covers how the recovery models affect restore operations. Review this article if you have questions about how the recovery model of a database affects the restore process.|
|[Manage metadata when making a database available on another server](/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server)|Considerations to keep in mind when you move a database or hit problems that affect logins, encryption, replication, permissions, and so on.|
|[Transaction log backups (SQL Server)](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server)|Presents concepts about how to back up and restore (apply) transaction logs in the Full and Bulk-logged recovery models. Explains how to take routine transaction log backups to recover data.|
|[SQL Server managed backup to Microsoft Azure](/sql/relational-databases/backup-restore/sql-server-managed-backup-to-microsoft-azure)|Introduces managed backup and the related procedures.|

## Related content

- [Back up and restore of SQL Server databases](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases)
- [Permissions for backup](/sql/t-sql/statements/backup-transact-sql)
- [Possible media errors during backup and restore (SQL Server)](/sql/relational-databases/backup-restore/possible-media-errors-during-backup-and-restore-sql-server)
- [Move a TDE protected database to another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server)
