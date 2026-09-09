---
title: Schedule and Automate Backups of SQL Server Express Databases
description: Learn how to use the sp_BackupDatabases stored procedure, sqlcmd utility, and Windows Task Scheduler to automate scheduled backups of SQL Server Express databases.
ms.date: 09/01/2026
ms.custom: sap:Database Backup and Restore
ms.topic: how-to
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# Schedule and automate backups of SQL Server Express databases

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2019698

## Summary

SQL Server Express doesn't include SQL Server Agent, so you can't schedule backup jobs or maintenance plans the way you can in other SQL Server editions. To automate backups on SQL Server Express, combine three components: the `sp_BackupDatabases` stored procedure, the `sqlcmd` command-line utility, and Windows Task Scheduler. This article walks through the steps that set up scheduled full, differential, and transaction log backups of SQL Server Express databases. It also explains how to confirm that a scheduled backup ran.

This article applies only to SQL Server Express editions. It doesn't apply to [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb).

## Why SQL Server Express can't schedule backups with SQL Server Agent

SQL Server Agent is the component that runs scheduled jobs and maintenance plans, and it isn't included in SQL Server Express. For a full comparison of what each edition includes, see [Editions and supported features of SQL Server](/sql/sql-server/editions-and-components-of-sql-server-2025).

Without SQL Server Agent, you can still back up a SQL Server Express database on demand by using any of the following tools:

- [sqlcmd utility](/sql/tools/sqlcmd/sqlcmd-utility)
- [SQL Server Management Studio (SSMS)](/ssms/sql-server-management-studio-ssms)
- [MSSQL extension for Visual Studio Code](/sql/tools/visual-studio-code-extensions/mssql/mssql-extension-visual-studio-code)
- A Transact-SQL script that uses the [BACKUP (Transact-SQL)](/sql/t-sql/statements/backup-transact-sql) family of commands

To run those backups on a schedule instead of on demand, use Windows Task Scheduler as the scheduling engine, as described in the following steps. For background on backup types and strategy, see [Back up and restore of SQL Server databases](/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases).

## Prerequisites

Before you begin, make sure that you have:

- A running instance of SQL Server Express. The examples in this article use the default named instance, `.\SQLEXPRESS`.
- Membership in the **sysadmin** fixed server role on that instance, which is required to create a stored procedure in the `master` database.
- A local folder or drive with enough free space to hold the backup files. The examples use `D:\SQLBackups`.
- Permission to create scheduled tasks on the computer that runs SQL Server Express.

## Step 1: Create the sp_BackupDatabases stored procedure

`sp_BackupDatabases` is a Microsoft-provided stored procedure that runs the appropriate `BACKUP` command against one database or every online database on the instance. You create it one time in the `master` database.

Download the script from [SQL_Express_Backups.sql](https://raw.githubusercontent.com/microsoft/mssql-support/master/sample-scripts/backup_restore/SQL_Express_Backups.sql) and save it locally, for example as *C:\Temp\SQL_Express_Backups.sql*. Then create the stored procedure by using either SSMS or `sqlcmd`.

### Create the stored procedure by using SSMS

1. Open SSMS and connect to your SQL Server Express instance. In **Server name**, enter `.\SQLEXPRESS`, and then select **Connect**.
1. Select **File** > **Open** > **File**, select the *SQL_Express_Backups.sql* file that you saved, and then select **Open**.
1. Confirm that the database list on the toolbar shows `master`. The script starts with `USE [master]`, so it targets the correct database automatically.
1. Select **Execute** (or press F5). The **Messages** pane reports `Commands completed successfully`.

### Create the stored procedure by using sqlcmd

Run the following command from a command prompt:

```cmd
sqlcmd -S .\SQLEXPRESS -E -i "C:\Temp\SQL_Express_Backups.sql"
```

### Confirm that the stored procedure was created

Run the following query against the instance. It returns one row if the stored procedure exists:

```sql
SELECT name, create_date
FROM master.sys.procedures
WHERE name = 'sp_BackupDatabases';
```

### sp_BackupDatabases parameters

The stored procedure accepts the following parameters:

| Parameter | Required | Description |
|---|---|---|
| **`@backupLocation`** | Yes | The folder that receives the backup files, for example `D:\SQLBackups\`. The folder must already exist. |
| **`@backupType`** | Yes | The backup type: `F` for full, `D` for differential, or `L` for transaction log. |
| **`@databaseName`** | No | The database to back up. If you omit this parameter, the stored procedure backs up every online database on the instance except the databases that the script excludes. |

The stored procedure never backs up `tempdb`. It also skips the sample databases `Northwind`, `pubs`, and `AdventureWorks` for every backup type, and it skips `master` for differential and log backups because those backup types aren't supported for the `master` database.

> [!IMPORTANT]
> The excluded database names are hardcoded in the script. If you have a database that uses one of those names, the stored procedure skips it without reporting an error. To back up such a database, edit the `DELETE @DBs WHERE DBNAME IN (...)` lists in the script before you create the stored procedure.

## Step 2: Install the sqlcmd utility

The `sqlcmd` utility lets you run Transact-SQL statements, system stored procedures, and script files from the command line. It's installed with SSMS, and it's also available as a standalone download for computers that don't have SSMS. To install it, see [Download and install the sqlcmd utility](/sql/tools/sqlcmd/sqlcmd-download-install).

To confirm that `sqlcmd` is installed and available, run `sqlcmd -?` from a command prompt.

The folder that contains the `sqlcmd` executable is usually added to the `Path` environment variable when you install SQL Server or the standalone tools. If `sqlcmd -?` reports that the command isn't recognized, either add the folder to the `Path` variable or specify the full path to the utility in your batch file.

## Step 3: Create the Sqlbackup.bat batch file

In a text editor, create a batch file named *Sqlbackup.bat*. Copy the text from one of the following examples into that file, depending on your scenario.

Consider the following points before choosing an example:

- Every example uses `D:\SQLBackups` as a placeholder. Change the path to the drive and backup folder that you want to use in your environment, and ensure that the folder exists.
- If you use SQL Server Authentication, the password is stored in clear text in the batch file. Restrict access to the folder that holds the batch file to authorized users only.

### Example 1: Full backups of all databases by using Windows Authentication

```cmd
REM Sqlbackup.bat
sqlcmd -S .\SQLEXPRESS -E -b -Q "EXEC sp_BackupDatabases @backupLocation='D:\SQLBackups\', @backupType='F'"
```

### Example 2: Differential backups of all databases by using SQL Server Authentication

```cmd
REM Sqlbackup.bat
sqlcmd -U <YourSQLLogin> -P <StrongPassword> -S .\SQLEXPRESS -b -Q "EXEC sp_BackupDatabases @backupLocation='D:\SQLBackups\', @backupType='D'"
```

> [!NOTE]
> To run backups, the login must be a member of the **db_backupoperator** or **db_owner** fixed database role in each database that you back up, or a member of the **sysadmin** fixed server role. For more information, see [Database-level roles](/sql/relational-databases/security/authentication-access/database-level-roles).

### Example 3: Transaction log backups of all databases by using Windows Authentication

```cmd
REM Sqlbackup.bat
sqlcmd -S .\SQLEXPRESS -E -b -Q "EXEC sp_BackupDatabases @backupLocation='D:\SQLBackups\', @backupType='L'"
```

Transaction log backups require the full or bulk-logged recovery model, and they require at least one previous full backup. For more information, see [Recovery models (SQL Server)](/sql/relational-databases/backup-restore/recovery-models-sql-server).

### Example 4: Full backup of a single database by using Windows Authentication

```cmd
REM Sqlbackup.bat
sqlcmd -S .\SQLEXPRESS -E -b -Q "EXEC sp_BackupDatabases @backupLocation='D:\SQLBackups\', @databaseName='USERDB', @backupType='F'"
```

To make a differential backup of `USERDB`, change the `@backupType` parameter to `D`. To make a transaction log backup, change it to `L`.

The `-b` option makes `sqlcmd` exit and return a `DOS ERRORLEVEL` value of `1` when a SQL Server error has a severity level greater than 10. Without `-b`, `sqlcmd` returns `0` even when the backup fails, and Task Scheduler reports the task as successful.

Before you continue, run *Sqlbackup.bat* manually from a command prompt and confirm that backup files appear in the backup folder. Fixing errors now is easier than diagnosing them later through Task Scheduler.

## Step 4: Schedule the batch file in Windows Task Scheduler

Follow these steps to run *Sqlbackup.bat* on a schedule:

1. On the computer that is running SQL Server Express, select **Start** and type **Task Scheduler** in the text box.

   :::image type="content" source="media/schedule-automate-backup-database/task-scheduler.png" alt-text="Screenshot of Windows search results showing the Task Scheduler desktop app listed under Best match." border="false":::

1. Under **Best match**, select **Task Scheduler** to launch it.
1. In **Task Scheduler**, right-click **Task Scheduler (Local)** and select **Create Basic Task**.
1. Enter a name for the new task (for example, **SQLBackup**), and then select **Next**.
1. Select **Daily** for the task trigger, and then select **Next**.
1. Set the recurrence to one day, and then select **Next**.
1. Select **Start a program** as the action, and then select **Next**.
1. Select **Browse**, select the *Sqlbackup.bat* file that you created in [Step 3: Create the Sqlbackup.bat batch file](#step-3-create-the-sqlbackupbat-batch-file), and then select **Open**.
1. Select the **Open the Properties dialog for this task when I click Finish** checkbox, and then select **Finish**.
1. On the **General** tab, review the **Security options** and confirm the following for the account listed under **When running the task, use the following user account**:

   - The account has at least Read and Execute permissions to run the `sqlcmd` utility.
   - If the batch file uses Windows Authentication, the account has permission to back up the SQL Server databases.
   - If the batch file uses SQL Server Authentication, the SQL Server login in the batch file has permission to back up the databases.

1. Adjust the remaining settings to match your requirements, and then select **OK**.

> [!TIP]
> As a test, run *Sqlbackup.bat* from a command prompt that you started with the same user account that owns the task. This step confirms that the account has the permissions it needs before the schedule runs.

For more information about the scheduling options, see [Task Scheduler](/windows/win32/taskschd/task-scheduler-start-page).

## Verify that the scheduled backup ran

After the first scheduled run, confirm that the backup succeeded:

- Check the backup folder for new *.bak* files (full and differential backups) or *.trn* files (transaction log backups). The stored procedure adds a date and time stamp to each file name.
- In Task Scheduler, select **Task Scheduler Library**, select your task, and review the **Last Run Result** column. This column shows the exit code that the batch file returned. Because the examples use the `-b` option, a value of `0x1` means that the backup command failed. For other values, see [Task Scheduler error and success constants](/windows/win32/taskschd/task-scheduler-error-and-success-constants).
- Query the backup history on the instance:

  ```sql
  SELECT database_name, type, backup_start_date, backup_finish_date, physical_device_name
  FROM msdb.dbo.backupset AS bs
  INNER JOIN msdb.dbo.backupmediafamily AS bmf
      ON bs.media_set_id = bmf.media_set_id
  ORDER BY backup_start_date DESC;
  ```

  These tables are part of the backup history that SQL Server maintains in the `msdb` database. For more information, see [Backup history and header information (SQL Server)](/sql/relational-databases/backup-restore/backup-history-and-header-information-sql-server).

> [!IMPORTANT]
> Always confirm that the backup files exist and that the backup history contains recent rows. A task that Task Scheduler reports as successful isn't proof that the backup succeeded.

## Requirements and limitations of this backup method

Be aware of the following requirements and limitations when you use the procedure in this article:

- The Task Scheduler service must be running when the task is scheduled to start. We recommend that you set the startup type for this service to **Automatic** so that the service runs even after a restart.
- The drive that receives the backups must have enough free space. Clean up old files in the backup folder regularly so that you don't run out of disk space. The `sp_BackupDatabases` stored procedure doesn't delete old backup files.
- The stored procedure backs up only databases that are online. It silently skips databases that are offline, restoring, or otherwise unavailable.
- This method doesn't replace SQL Server Agent. It has no built-in job history, retry logic, or failure alerts. Review the backup history regularly, or upgrade to an edition that includes SQL Server Agent if you need those capabilities.

## Related content

- [Create a full database backup](/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server)
- [Restore a database backup using SSMS](/sql/relational-databases/backup-restore/restore-a-database-backup-using-ssms)
- [Differential backups (SQL Server)](/sql/relational-databases/backup-restore/differential-backups-sql-server)
- [Transaction log backups (SQL Server)](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server)
- [Backup overview (SQL Server)](/sql/relational-databases/backup-restore/backup-overview-sql-server)
