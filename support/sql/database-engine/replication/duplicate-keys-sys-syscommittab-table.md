---
title: Duplicate keys from sys.syscommittab table
description: This article provides information about resolving a SQL Server Change Tracking issue that can result in duplicate rows in `sys.syscommittab` file.
ms.date: 03/16/2020
---
# Duplicate key rows from the sys.syscommittab table in SQL Server

This article provides information about resolving a SQL Server Change Tracking issue that can result in duplicate rows in `sys.syscommittab` file.

_Original product version:_ &nbsp; SQL Server 2008 and the later versions  
_Original KB number:_ &nbsp; 3083381

## Symptoms

When you compare the in-memory `SYSCOMMITTABLE` and the on-disk `sys.syscommittab` file in Microsoft SQL Server, you may see duplicate key rows. These duplicate values may cause backup and checkpoint operations to fail.

> "Cannot insert duplicate key row in object 'sys.syscommittab' with unique index 'si_xdes_id'. The duplicate key value is (KeyValue).  
> Error: 3999, Severity: 17, State: 1.  
> Failed to flush the commit table to disk in dbidDatabaseID due to error 2601. Check the errorlog for more information."

## Cause

This problem occurs because of a known issue in SQL Server change tracking.

## Resolve factors that cause the duplicate keys

To resolve the factors that cause the duplicate keys, apply one of the following fixes, as appropriate for your situation:

- [FIX: A backup operation on a SQL Server 2008 or SQL Server 2008 R2 database fails if you enable change tracking on this database](https://support.microsoft.com/help/2522893)

- [FIX: Backup fails in SQL Server 2008, SQL Server 2008 R2, or SQL Server 2012 if you enable change tracking on the database](https://support.microsoft.com/kb/2603910)

- [FIX: Backup operation fails in a SQL Server 2008, SQL Server 2008 R2, or SQL Server 2012 database after you enable change tracking](https://support.microsoft.com/kb/2682488)

Although these fixes prevent duplicate key rows from continuing to appear, they don't automatically remove the duplicate rows. Without removing the duplicate rows, the affected database can't complete database checkpoints, and backups may fail.

## Disable and enable change tracking to remove duplicate rows

1. Disable change tracking on the affected tables and database.
1. Issue a manual database Checkpoint.
1. Enable change tracking on the affected database and tables.

For more information about change tracking, see [Enable and disable change tracking](/sql/relational-databases/track-changes/enable-and-disable-change-tracking-sql-server). For issuing a manual Checkpoint, see [CHECKPOINT (Transact-SQL)](/sql/t-sql/language-elements/checkpoint-transact-sql).

## Manually delete the duplicate rows

1. Copy the [Transact-SQL script](#transact-sql-script) from the **Transact-SQL script** section into a text editor.
1. Locate the `<AFFECTED_DB>` placeholder in the script, and replace it with the name of the affected database.
1. Save the modified script to your hard disk as a .sql file. For example, `C:\temp\remove_duplicates.sql`.

If you're running SQL Server 2014, you must grant the per-Service SID full control to the `mssqlsystemresource.ldf` and `mssqlsystemresource.mdf` files. To do this, follow these steps:

1. Navigate to the Bin directory that corresponds to your Instance ID. For example:  
`C:\Program Files\Microsoft SQL Server\<Instance ID>\MSSQL\Binn`

1. Open the properties for `mssqlsystemresource.ldf` and `mssqlsystemresource.mdf`, and then select the **Security** tab.
1. Locate the SQL Server service per-Service SID, and note the default permissions:

   - `*Read & execute`
   - `*Read`

1. Grant the SQL Server service per-Service SID Full Control, and then close the permissions dialog boxes.
1. Start SQL Server in Single-User mode. For more information, see [Start SQL Server in Single-User mode](/sql/database-engine/configure-windows/start-sql-server-in-single-user-mode).
1. Use a `sqlcmd` command line to connect to SQL Server under the Dedicated Administrator Connection (DAC). For example:

   ```console
   sqlcmd -S PRODSERV1\MSSQLSERVER -A -E -i c:\temp\remove_duplicates.sql
   ```

   Then, execute the modified Transact-SQL script.

1. [Restart SQL Server in Multi-User mode](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services), and then verify that backup and CHECKPOINT operations against the affected database complete successfully. If step 4 was used, revert the permissions to the default values.

### Transact-SQL script

```sql
--Create a temporary database to store the necessary rows required to remove the duplicate data 
USE master
GO
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'dbChangeTrackingMetadata')
BEGIN
  DROP DATABASE dbChangeTrackingMetadata
END
GO
CREATE DATABASE dbChangeTrackingMetadata
GO

--Table to store the contents of the SYSCOMMITTABLE
USE dbChangeTrackingMetadata
GO
CREATE TABLE dbo.t_SYSCOMMITTABLE (
commit_ts BIGINT
,xdes_id BIGINT
,commit_lbn BIGINT
,commit_csn BIGINT
,commit_time DATETIME
)
GO

--Table to store the duplicate rows to be removed from the sys.syscommittab table

CREATE TABLE dbo.t_syscommittab (
commit_ts BIGINT
,xdes_id BIGINT
,commit_lbn BIGINT
,commit_csn BIGINT
,commit_time DATETIME
,dbfragid INT
)
GO

--Enable the usage of OPENROWSET
EXEC sys.sp_setbuildresource 1
GO

--Change <AFFECTED_DB> to the database that contains the duplicate values
USE <AFFECTED DB>
GO
DECLARE @rowcount BIGINT
SET @rowcount = 0

--Copy all rows from the SYSCOMMITTABLE INTo the temporary database
INSERT INTO dbChangeTrackingMetadata.dbo.t_SYSCOMMITTABLE
SELECT commit_ts, xdes_id, commit_lbn, commit_csn, commit_time
FROM OPENROWSET (table SYSCOMMITTABLE, db_id (), 0, 0)

--Save the duplicate values INTo the temporary database
INSERT INTO dbChangeTrackingMetadata.dbo.t_syscommittab
SELECT ondisk_ct.* 
FROM sys.syscommittab as ondisk_ct
JOIN dbChangeTrackingMetadata.dbo.t_SYSCOMMITTABLE as inmem_ct
 ON ondisk_ct.xdes_id = inmem_ct.xdes_id

--Delete the duplicate values
DELETE FROM sys.syscommittab
WHERE xdes_id in ( SELECT xdes_id from dbChangeTrackingMetadata.dbo.t_syscommittab )

SET @rowcount = @@rowcount

IF (@rowcount > 0)
BEGIN
  PRINT ''
  PRINT 'DELETED '+CAST(@rowcount as NVARCHAR(10))+' rows from sys.syscommittab that were also stored in SYSCOMMITTABLE'
PRINT ''
END
ELSE
BEGIN
  PRINT ''
  PRINT 'Failed to DELETE DUP rows from sys.syscommittab'
  PRINT ''
END
EXEC sys.sp_setbuildresource 0
GO
```
