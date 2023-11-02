---
title: Troubleshoot database consistency errors reported
description: This article introduces how to troubleshoot errors reported by the DBCC CHECKDB command.
ms.reviewer: jopilov, v-jayaramanp
ms.date: 08/30/2023
ms.custom: sap:Administration and Management
---

# Troubleshoot database consistency errors reported by DBCC CHECKDB

This article explains how to troubleshoot errors reported by the `DBCC CHECKDB` command.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2015748

## Symptoms

When the [DBCC CHECKDB](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql) (or other similar commands like [DBCC CHECKTABLE](/sql/t-sql/database-console-commands/dbcc-checktable-transact-sql)) is executed, a message like the following one is written to the SQL Server error log:

```output
DBCC CHECKDB (mydb) executed by MYDOMAIN\theuser found 15 errors and repaired 3 errors.
Elapsed time: 0 hours 0 minutes 0 seconds.
Internal database snapshot has split point LSN = 00000026:0000089d:0001 and first LSN = 00000026:0000089c:0001.
This is an informational message only. No user action is required.
```

This message shows how many database consistency errors were found and how many were repaired, if a repair option was used. This message is also written to the Windows Application Event Log as an information level message with EventID=8957. Even if errors are reported this message is an information level message.

The information in the message starting with "internal database snapshot..." only appears if `DBCC CHECKDB` was run online, in which the database isn't in the `SINGLE_USER` mode. This is because for an online `DBCC CHECKDB`, an internal database snapshot is used to present a consistent set of data to check.

This article doesn't discuss how to troubleshoot each specific error reported by `DBCC CHECKDB` but rather the general approach if errors are reported. Any reference to `CHECKDB` in this article also applies to `DBCC CHECKTABLE` and [DBCC CHECKFILEGROUP](/sql/t-sql/database-console-commands/dbcc-checkfilegroup-transact-sql) unless stated.

## Cause

The `DBCC CHECKDB` command checks the physical and logical consistency of database pages, rows, allocation pages, index relationships, system table referential integrity, and other structure checks. If any of these checks fail (depending on the options you have chosen), errors are reported.

The cause of these problems can range from file system corruption, underlying hardware system issues, driver issues, corrupted pages in memory or storage cache, or problems with the SQL Server. For information on how to identify the root cause of reported errors, see [Investigate root cause](#investigate-root-cause-for-database-consistency-errors).

## Resolution

1. Resolve any underlying hardware-related problems on the system before you proceed with restoring a backup or otherwise repairing the database. Apply any device driver, firmware, BIOS, and operating system updates that are relevant to the I/O path. Work with the administrator of the full I/O path (local machine, device drivers, storage NICs, SAN, backend storage, and cache) to isolate and resolve any problems. Examples include updating device drivers and checking configuration of the entire I/O path. For more information about checking the root cause, see [Investigate root cause](#investigate-root-cause-for-database-consistency-errors).
1. If `DBCC CHECKDB` reports permanent consistency errors, the best solution would be to restore data from a known good backup. For more information, see [Restore and Recovery](/sql/relational-databases/backup-restore/restore-and-recovery-overview-sql-server).
1. Apply the latest SQL Server Cumulative Update or Service Pack to make sure you aren't running into any known issues. Check the [Cumulative Update or Service Pack documentation](../../releases/download-and-install-latest-updates.md) for any known issues fixed related to database corruption (consistency errors) and apply any relevant fixes. One central location where you can search for all fixes for a particular version if the [Detailed fix lists for SQL Server 2022, 2019, 2017](https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fdownload.microsoft.com%2Fdownload%2Fd%2F3%2Fe%2Fd3e28f3d-6a4f-47ce-aaa5-9d74c5590ed6%2FSQLServerBuilds.xlsx).
1. If the `DBCC CHECKDB` errors are intermittent, that is if they appear on one run and disappear on the next one, you might be facing disk cache issues (either device driver or other I/O path issue). Work with the maintainers of the I/O path to isolate and resolve any problems. Examples include updating device drivers, checking configuration of the entire I/O path, and updating firmware and BIOS on the I/O path devices and system.
1. If it isn't possible to restore from a backup, `CHECKDB` has a feature to repair errors that you can use. There are two levels of repair:
    - `REPAIR_REBUILD` - performs repairs that have no possibility of data loss.
    - `REPAIR_ALLOW_DATA_LOSS` - performs repairs that have the possibility of data loss.

   For more information, see [DBCC CHECKDB documentation](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#repair_allow_data_loss--repair_fast--repair_rebuild).

   You must exercise caution when making choice to repair with allow data loss since it may leave your database in a logically inconsistent state. The `DBCC CHECKDB` output makes a recommendation on the minimum repair level to use. It's a common practice to run `CHECKDB` with `REPAIR_ALLOW_DATA_LOSS` multiple times until no more errors are reported. This is because when the repair fixes a set of errors, other broken linkages may be uncovered. However, new errors can show up if the underlying cause hasn't been resolved. Therefore, if system level problems such as hardware or file system are causing data corruption, these problems must be addressed first, before the restoration of a backup or repair. Microsoft support engineers can't assist with physical recovery of corrupt data if the repair doesn't fix the consistency errors or if the database backup is corrupt.

    When you run `DBCC CHECKDB`, a recommendation is provided to indicate the minimum repair option required to repair all errors. These messages resemble the following output:

    > CHECKDB found 0 allocation errors and 15 consistency errors in database 'mydb'.  
     `REPAIR_ALLOW_DATA_LOSS` is the minimum repair level for the errors found by `DBCC CHECKDB` (mydb).

    The repair recommendation is the minimum level of repair to attempt to resolve all errors from `CHECKDB`. The minimum repair level doesn't mean that this repair option fixes all errors. Some errors simply can't be fixed. Also you might need to run the repair process more than once. Not all errors reported require the use of this repair level to be resolved. This means that not all repairs by `CHECKDB` with `REPAIR_ALLOW_DATA_LOSS` result in data loss. Repair must be run to determine if the resolution to an error results in data loss. One technique to help narrow down what the repair level is for each table is to use `DBCC CHECKTABLE` for any table reporting an error. This shows the minimum level of repair for a given table.

   > [!WARNING]  
   > You must perform manual data validation after `CHECKDB` repair or data export or import is complete. For more information, see [DBCC CHECKDB arguments](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#arguments). The data might not be logically consistent after the repair. For example, repair (particularly `REPAIR_ALLOW_DATA_LOSS` option) might remove entire data pages that contain inconsistent data. In such cases, a table with a foreign key relationship to another table may end up with rows that don't have corresponding primary key rows in the parent table.

1. Try to [script out the database schema](/sql/ssms/scripting/generate-scripts-sql-server-management-studio). Use the script to create a new database and then use a tool like [BCP](/sql/relational-databases/import-export/import-and-export-bulk-data-by-using-the-bcp-utility-sql-server) or [SSIS Export/Import Wizard](/sql/integration-services/import-export-data/import-and-export-data-with-the-sql-server-import-and-export-wizard) to export as much of the data as possible from the corrupted database to the new database. Exporting data from a corrupt table is likely to fail. In such cases, skip this table, move to the next, and save what you can.
1. Review the following articles for specific errors generated by `DBCC CHECKDB` and follow the steps provided (if any). Here are some examples:
   - Error 605 ([MSSQLSERVER_605](/sql/relational-databases/errors-events/mssqlserver-605-database-engine-error))
   - Error 823 ([MSSQLSERVER_823](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error))
   - Error 824 ([MSSQLSERVER_824](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error))
   - Error 825 ([MSSQLSERVER_825](/sql/relational-databases/errors-events/mssqlserver-825-database-engine-error))
   - Error 2508 ([MSSQLSERVER_2508](/sql/relational-databases/errors-events/mssqlserver-2508-database-engine-error))
   - Error 2511 ([MSSQLSERVER_2511](/sql/relational-databases/errors-events/mssqlserver-2511-database-engine-error))
   - Error 2512 ([MSSQLSERVER_2512](/sql/relational-databases/errors-events/mssqlserver-2512-database-engine-error))
   - Error 7987 ([MSSQLSERVER_7987](/sql/relational-databases/errors-events/mssqlserver-7987-database-engine-error))
   - Error 7988 ([MSSQLSERVER_7988](/sql/relational-databases/errors-events/mssqlserver-7988-database-engine-error))
   - Error 7995 ([MSSQLSERVER_7995](/sql/relational-databases/errors-events/mssqlserver-7995-database-engine-error))
   - Error 8993 ([MSSQLSERVER_8993](/sql/relational-databases/errors-events/mssqlserver-8993-database-engine-error))
   - Error 8994 ([MSSQLSERVER_8994](/sql/relational-databases/errors-events/mssqlserver-8994-database-engine-error))
   - Error 8996 ([MSSQLSERVER_8996](/sql/relational-databases/errors-events/mssqlserver-8996-database-engine-error))

### Investigate root cause for database consistency errors

To identify the root cause of database consistency errors, consider these methods:

- Check the Windows System Event Log for any system level, driver, or disk-related errors and work with your hardware manufacturer to resolve them.
- Run any diagnostics provided by your hardware manufacturers for the computer and/or disk system.
- Work with your hardware vendor or device manufacturer to make sure that:
  - The hardware devices and the configuration confirm to the [Microsoft SQL Server Database Engine Input/Output requirements](database-engine-input-output-requirements.md).
  - The device drivers and other supporting software components of all devices in the I/O path are updated.
- Consider using a utility like [SQLIOSim](../../tools/sqliosim-utility-simulate-activity-disk-subsystem.md) on the drive where the databases that have reported the consistency errors reside. SQLIOSim is a tool independent of the SQL Server Engine to test the integrity of I/O for the disk system. SQLIOSim ships with SQL Server and doesn't require a separate download. It can be found in the *\MSSQL\Binn* folder.
- Check the [Cumulative Update or Service Pack documentation](../../releases/download-and-install-latest-updates.md) for any known issues fixed related to database corruption (consistency errors) and apply any relevant fixes. One central location where you can search for all fixes for a particular version if the [Detailed fix lists for SQL Server 2022, 2019, 2017](https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fdownload.microsoft.com%2Fdownload%2Fd%2F3%2Fe%2Fd3e28f3d-6a4f-47ce-aaa5-9d74c5590ed6%2FSQLServerBuilds.xlsx).
- Check for any other errors reported by SQL Server such as access violations or assertions. Activity against corrupted databases frequently results in access violation exceptions or assert errors.
- Make sure that your databases are using the `PAGE_VERIFY CHECKSUM` option. If checksum errors are being reported, this is an indication that the consistency errors have occurred after SQL Server has written pages to disk. Thus, your I/O subsystem should be thoroughly checked. For more information about checksum errors, see [How to Troubleshoot Msg 824 in SQL Server](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error).
- Look for message 832 errors in the ERRORLOG. These errors might indicate that pages might be damaged while they are in cache before written to the disk. For more information, see [How to Troubleshoot Msg 832 in SQL Server](/sql/relational-databases/errors-events/mssqlserver-832-database-engine-error).
- On another system, try to restore a database backup you know that's "clean" (no errors from `CHECKDB`) followed by transaction log backups that span the time when the error was generated. If you can "re-create" this problem by restoring a "clean" database backup and transaction log backup, contact Microsoft Technical Support for assistance.
- Data Purity errors can be a problem with the application inserting or updating invalid data into SQL Server tables. For more information about troubleshooting Data Purity errors, see [Troubleshooting DBCC Error 2570 in SQL Server 2005](/sql/relational-databases/errors-events/mssqlserver-2570-database-engine-error).
- Check the integrity of the file system by using the [chkdsk](/windows-server/administration/windows-commands/chkdsk) command.

## More information

For details on the syntax of `DBCC CHECKDB` and information or options about how to run the command, see [DBCC CHECKDB (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql).

If any errors are found by using `CHECKDB`, other messages similar to the following message are reported in the ERRORLOG for the purposes of error reporting:

```output
**Dump thread - spid = 0, EC = 0x00000000855F5EB0
***Stack Dump being sent toFilePath\FileName
* ******************************************************************************
*
* BEGIN STACK DUMP:
*  Date/Timespid 53
*
* DBCC database corruption
*
* Input Buffer 84 bytes -
*             dbcc checkdb(mydb)
*
* *******************************************************************************
*   -------------------------------------------------------------------------------
* Short Stack Dump
Stack Signature for the dump is 0x00000000000001E8
External dump process return code 0x20002001.
```

The error information has been submitted to Watson error reporting.

The files used for error reporting include a *SQLDump\<nnn>.txt* file. This file can be useful for historical purposes as it contains a list of the errors found from `CHECKDB` in an XML format.

To find out when the last time `DBCC CHECKDB` was run without errors which were detected for a database (the last known clean `CHECKDB`), check the SQL Server ERRORLOG for a message like the following one in a user or system database (this message is written as an Information Level message in the Windows Application Event Log with EventID = 17573 as well):

> Date/Time spid7s      CHECKDB for database 'master' finished without errors on Date/Time22:11:11.417 (local time). This is an informational message only; no user action is required
