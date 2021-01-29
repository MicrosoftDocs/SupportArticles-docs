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

This article introduces the following Microsoft SQL Server backup and restore operations information:

- [References to SQL Server Books Online and other documentation about backup and restore topics](#reference-topics-for-sql-server-backup-and-restore-operations).

- [Potential issues that you may encounter and the resolutions that you can try when you work with backup or restore operations](#scenarios-of-sql-server-backup-and-restore-operation-issues).

- [Frequently Asked Questions (FAQ) about backup and restore operations](#more-information).

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 224071

## Reference topics for SQL Server backup and restore operations

- For extensive information about backup and restore operations, see the following topics in Books Online.
  - [Back Up and Restore of SQL Server Databases](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases): This topic covers the concepts of the backup and restore operations for SQL Server databases, provides links to additional topics, and provides detailed procedures about how to perform various backups or restore tasks (such as verifying backups, backing up by using T-SQL or SSMS, and so forth). This is the parent topic about this subject in SQL Server documentation.
  
- The following table lists additional topics that you may want to review for specific tasks that are related to backup and restore operations.

    |Reference|Can provide answers for|
    |---|---|
    | [BACKUP (Transact-SQL)](/sql/t-sql/statements/backup-transact-sql)|Provides answers to basic questions that are related to backup. Provides examples of different kinds of backup and restore operations.|
    | [Backup Devices (SQL Server)](/sql/relational-databases/backup-restore/backup-devices-sql-server)|Provides a great reference for understanding various backup devices, backing up to a network share, azure blob storage and related tasks.|
    | [Recovery Models (SQL Server)](/sql/relational-databases/backup-restore/recovery-models-sql-server)|Covers in detail the various recovery models: Simple, Full, and Bulk-Logged. Provides information about how the recovery model affects backups.|
    | [Backup & restore: system databases (SQL Server)](/sql/relational-databases/backup-restore/back-up-and-restore-of-system-databases-sql-server)|Covers strategies and discusses what you must be aware of when you work on backup and restore operations of system databases.|
    | [Restore and Recovery Overview (SQL Server)](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server)|Covers how the recovery models affect restore operations. You should review this if you have questions about how the recovery model of a database can affect the restore process.|
    | [Manage Metadata When Making a Database Available on Another Server](/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server)|Various considerations that you should be aware of when a database is moved or you encounter any issues that affect logins, encryption, replication, permissions, and so on.|
    | [Working with Transaction Log Backups](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server)|Presents concepts about how to back up and restore (apply) transaction logs in the full and bulk-logged recovery models. Explains how to take routine backups of transaction logs (log backups) to recover data.|
    | [SQL Server Managed Backup to Microsoft  Azure](/sql/relational-databases/backup-restore/sql-server-managed-backup-to-microsoft-azure)|Introduces managed backup and associated procedures.|
    |||

## Scenarios of SQL Server backup and restore operation issues  

- **Scenario 1: Backup or restore operation takes a long time**

  Backup and restore operations are I/O intensive. Backup/Restore throughput depends on how well the underlying I/O subsystem is optimized to handle the I/O volume. If you suspect that the backup operations are either hung or taking a long time to complete, you can use one or more of the following methods to estimate the time for completion or to track the progress of backup and restore operations:  

  - The SQL Server error log contains information about past backup and restore operations. You can use these details to estimate the time that is required to back up and restore the database in its current state. The following is a sample output from the error log:

      > RESTORE DATABASE successfully processed 315 pages in 0.372 seconds (6.604 MB/sec)

  - In SQL Server 2016 and later versions you can use XEvent [backup_restore_progress_trace](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases) to track the progress of backup and restore operations.

  - You can also use the **percent_complete** column of [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) to track the progress of in-flight backup and restore operations.

  - The throughput information that is related to backup and restore operations can be measured by using the Device throughput Bytes/sec and Backup/Restore throughput/sec performance monitor counters. For additional information, review [SQL Server, Backup Device Object](/sql/relational-databases/performance-monitor/sql-server-backup-device-object).

  - [How to query the progress of backup process currently running in SQL Server](https://gallery.technet.microsoft.com/scriptcenter/how-to-query-the-progress-53e7f89b)

  - [How It Works: What is Restore/Backup Doing?](https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-what-is-restore-backup-doing/ba-p/315442) This blog post can help you gain insight into the current stage of backup or restore operations.

**Things to check**

1. Check whether you are experiencing any of the known issues that are listed in the following table. Consider whether you should implement the changes or apply the fixes and best practices that are discussed in the corresponding articles.

    |Knowledge Base or Books Online link|Explanation and recommended actions|
    |---|---|
    | [Optimizing Backup and Restore Performance in SQL Server](https://technet.microsoft.com/library/ms190954%28v=sql.105%29.aspx)|The Books Online topic covers various best practices that you can use to improve the performance of Backup/Restore operations. For example, you can assign the SE_MANAGE_VOLUME_NAME special privilege to the Windows account that is running SQL Server to enable instant initialization of data files. This can produce significant performance gains.|
    | [2920151 Recommended hotfixes and updates for Windows Server 2012 R2-based failover clusters](https://support.microsoft.com/help/2920151) <br/><br/> [2822241 Windows 8 and Windows Server 2012 update rollup: April 2013](https://support.microsoft.com/help/2822241)|Current system rollups can include fixes for known issues at the system level that can cause performance issues that affect programs such as SQL Server. Installing these updates can help prevent these issues.|
    | [2878182 FIX: User mode processes in an application are unresponsive on servers that are running Windows Server 2012](https://support.microsoft.com/help/2878182) <br/><br/>|Backup operations are I/O intensive and can be affected by this bug. Apply this fix to help prevent these issues.|
    | [309422 How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/help/309422)|Antivirus software may hold locks on .bak files. This can affect the performance of backup and restore operations. Follow the guidance in this article to exclude backup files from virus scans.|
    | [2820470 Delayed error message when you try to access a shared folder that no longer exists in Windows 8, Windows 8.1, Windows Server 2012, or Windows Server 2012 R2](https://support.microsoft.com/help/2820470)||
    | [967351 A heavily fragmented file in an NTFS volume may not grow beyond a certain size](https://support.microsoft.com/help/967351)||
    | [304101 Backup program is unsuccessful when you back up a large system volume](https://support.microsoft.com/help/304101)||
    | [2455009 FIX: Slow performance when you recover a database if there are many VLFs inside the transaction log in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2](https://support.microsoft.com/help/2455009)|The presence of many virtual log files could affect the time that is required to restore a database. This is especially true during the recovery phase of the restore operation. For information about other possible issues that can be caused by the presence of many VLFs, refer to [Database operations take a long time to complete, or they trigger errors when the transaction log has numerous virtual log files](https://support.microsoft.com/help/2028436).|
    |A backup or restore operation to a network location is slow|Isolate the issue to the network by trying to copy a similarly sized file to the network location from the server that is running SQL Server. Verify the performance.|
    |||

2. Check for more error messages in the SQL Server error log and Windows event log for more pointers about the cause of the problem.

3. If you are either using third-party software or database maintenance plans for performing multiple backups at the same time, consider whether you should change the schedules so that there is less contention on the drive to which the backups are being written.

4. Work with your windows administrator to check for firmware updates for your hardware.  

- **Scenario 2: Backup or restore operations that use third-party backup applications fail**

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

- **Scenario 3: Backup and restore operations fail because of permissions issues**

  Ownership and permission problems on the physical file of the backup device can interfere with backup and restore operations. SQL Server must be able to read and write to the device. Also, the account under which the SQL Server service runs must have write permissions either on the drive or on the network share that is used for backups.

  **Things to try**

  For more information, see [Backup to a Network Share topic in SQL Server documentation](/sql/relational-databases/backup-restore/backup-devices-sql-server).

    |Symptom|Comments|
    |---|---|
    |SQL Server or SQL Agent is running under a local system account and the backups fail|Give permissions to computer account on the Domain\ComputerName$ share.<br/><br/>Microsoft recommends that you use dedicated domain accounts that possess only the required privileges in order to isolate the services.|
    |||

  **More resources**

  [Lists all the shared folder permissions or NTFS permissions (PowerShell)](https://gallery.technet.microsoft.com/scriptcenter/lists-all-the-shared-5ebb395a)  

- **Scenario 4: Restore operation fails because of corrupted backups**

  Enable Backup CHECKSUM option when performing the backup to avoid backing up a corrupt database. For more information, see [Possible Media Errors During Backup and Restore (SQL Server)](/sql/relational-databases/backup-restore/possible-media-errors-during-backup-and-restore-sql-server). You can also enable Trace flag 3023 to enable checksum when you perform backups by using backup tools. For more information, see [How to enable the CHECKSUM option if backup utilities do not expose the option](https://support.microsoft.com/help/2656988).

  If the backup files are corrupted, restore operations may fail and generate errors that resemble the following.

  > RESTORE detected an error on page (0:0) in database  
ADDITIONAL INFORMATION: The media family on device '\<device name>' is incorrectly formed. SQL Server cannot process this media family. RESTORE HEADERONLY is terminating abnormally. (Microsoft SQL Server, Error: 3241)

  **Things to try**

  Run the following command by replacing \<test> with your database name and file paths:

    ```SQL
    RESTORE DATABASE test='d:\test.bak'
    WITH NO_CHECKSUM, FILE=1, REPLACE, CONTINUE_AFTER_ERROR,
    MOVE 'test' TO 'C:\test.mdf',
    MOVE 'test_log' TO 'C:\test_log.ldf'
    ```

  For more information, see the following Books Online content:

  [Responding to SQL Server Restore Errors Caused by Damaged Backups](/previous-versions/sql/sql-server-2008-r2/ms190952(v=sql.105))
We also recommend that you run CHECKDB against the database after the restore operation is completed.  

- **Scenario 5: Miscellaneous issues**

    |Symptom/Scenario|Remedial actions or additional information|
    |---|---|
    |Backups may fail when change tracking is enabled on the databases and return errors that resemble the following:<br/><br/>Error: 3999, Severity: 17, State: 1.<br/><br/>< **Time Stamp** t> spid< **spid** > Failed to flush the commit table to disk in dbid 8 due to error 2601. Check the errorlog for<br/><br/><br/>|See the following Microsoft Knowledge Base articles:<ul><li> [2682488 FIX: Backup operation fails in a SQL Server 2008, in a SQL Server 2008 R2 or in a SQL Server 2012 database after you enable change tracking](https://support.microsoft.com/help/2682488)</li><li> [2603910 FIX: Backup fails in SQL Server 2008, in SQL Server 2008 R2 or in SQL Server 2012 if you enable change tracking on the database](https://support.microsoft.com/help/2603910) </li><li> [2522893 FIX: A backup operation on a SQL Server 2008 or SQL Server 2008 R2 database fails if you enable change tracking on this database](https://support.microsoft.com/help/2522893)</li><ul> |
    |Issues restoring backups of encrypted databases| [Move a TDE Protected Database to Another SQL Server](/sql/relational-databases/security/encryption/move-a-tde-protected-database-to-another-sql-server) |
    |Trying to restore a CRM backup from the Enterprise edition fails on a Standard edition| [2567984 "Database cannot be started in this edition of SQL Server" error when restoring a Microsoft Dynamics CRM database](https://support.microsoft.com/help/2567984) |
    |||

## More information  

FAQ about SQL Server backup and restore operations

- **How can I check the status of backup operations?**

  See [How to query the progress of backup process currently running in SQL Server](https://gallery.technet.microsoft.com/scriptcenter/how-to-query-the-progress-53e7f89b).

- **What should I do when SQL Server fails over in the middle of backup?**

  Restart the restore or backup operations per [Restart an Interrupted Restore Operation (Transact-SQL)](/sql/relational-databases/backup-restore/restart-an-interrupted-restore-operation-transact-sql)

- **Can I restore database backups from older program versions on newer versions, and vice-versa?**

  SQL Server backup cannot be restored by a version of SQL Server that is later than the version that created the backup. For more information, see the [Compatibility Support](/sql/t-sql/statements/restore-statements-transact-sql).

- **How do I verify my SQL Server database backups?**

  See the procedures that are documented in [RESTORE Statements - VERIFYONLY (Transact-SQL)](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql).

- **How can I get the backup history of databases in SQL Server?**

  See [How to get the backup history of databases in SQL Server](https://gallery.technet.microsoft.com/scriptcenter/how-to-get-the-backup-ea70af7f).

- **Can I restore 32-bit backups on 64-bit servers, and vice-versa?**

  Yes. Per the **Back Up and Restore of SQL Server Databases** topic, the SQL Server on-disk storage format is the same in the 64-bit and 32-bit environments. Therefore, backup and restore operations work across 32-bit and 64-bit environments. A backup that is created on a server instance that is running in one environment can be restored on a server instance that is running in the other environment.

## Additional references

- [How to schedule and automate backups of SQL Server databases in SQL Server Express](https://support.microsoft.com/help/2019698)

- [How to back up SQL Server databases in all the instances on a server (PowerShell)](https://gallery.technet.microsoft.com/scriptcenter/how-to-back-up-sql-server-a997fde9)
