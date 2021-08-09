---
title: Troubleshoot database consistency errors reported
description: This article introduces how to troubleshoot errors reported by DBCC CHECKDB command.
ms.date: 09/25/2020
ms.prod-support-area-path: Administration and Management
ms.prod: sql
---
# Troubleshoot database consistency errors reported by DBCC CHECKB

This article introduces how to troubleshoot errors reported by DBCC CHECKDB command.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2015748

## Symptoms

When the DBCC CHECKDB (or other similar commands like CHECKTABLE) is executed, a message like the following is written to the SQL Server ERRORLOG:

> Date/Time spid53 DBCC CHECKDB (mydb) executed by MYDOMAIN\theuser found 15 errors and repaired errors. Elapsed time: 0 hours 0 minutes 0 seconds. Internal database snapshot has split point LSN = 00000026:0000089d:0001 and first LSN = 00000026:0000089c:0001. This is an informational message only. No user action is required.

This message shows how many database consistency errors were found and how many were repaired (if a repair option was used with the command). This message is also written to the Windows Application Event Log as an Information Level message with EventID=8957 (even if errors are reported this message is an Information Level Message).

The information in the message starting with "internal database snapshot..." only appears if DBCC CHECKDB was run online, in which the database is not in `SINGLE_USER` mode. This is because for an online DBCC CHECKDB, an internal database snapshot is used to present a consistent set of data to check.

This article will not discuss how to troubleshoot each specific error reported by DBCC CHECKDB but rather the general approach if errors are reported. Any reference to CHECKDB in this article also applies to `DBCC CHECKTABLE` and `CHECKFILEGROUP` unless stated.

## Cause

DBCC CHECKDB checks the physical and logical consistency of database pages, rows, allocation pages, index relationships, system table referential integrity, and other structure checks. If any of these checks fail (depending on the options you have chosen), errors will be reported as part of the command.

The cause of these problems can vary from file system corruption, underlying hardware system issues, driver issues, corrupted pages in memory, or problems with the SQL Server Engine. Read through the Resolution section for more information on how to find the cause of errors that are reported.

## Resolution

The first, best solution if DBCC CHECKDB reports consistency errors is to restore from a known good Backup. However, if you cannot restore from a Backup, then CHECKDB provides a feature to repair errors. If system level problems such as the file system or hardware may be causing these problems, it is recommended you correct these first before restoring or running repair.

When you run DBCC CHECKDB, a recommendation is provided to indicate what the minimum repair option that is required to repair all errors. These messages may look something like the following:

> CHECKDB found 0 allocation errors and 15 consistency errors in database 'mydb'.  
 **repair_allow_data_loss** is the minimum repair level for the errors found by DBCC CHECKDB (mydb).

The repair recommendation is the minimum level of repair to attempt to resolve all errors from CHECKDB. This does not mean that this repair option will actually fix all errors. Furthermore, not all errors reported may require this level of repair to resolve the error. This means that not all errors reported by CHECKDB when `repair_allow_data_loss` is recommended will result in data loss. Repair must be run to determine if the resolution to an error will result in data loss. One technique to help narrow down what the repair level will be for each table is to use DBCC CHECKTABLE for any table reporting an error. This will show the minimum level of repair for a given table.

To find the cause of why database consistency errors have occurred, consider these methods:

- Check the Windows System Event Log for any system level, driver, or disk-related errors.
- Check the integrity of the file system with the [chkdsk](/windows-server/administration/windows-commands/chkdsk).
- Run any diagnostics provided by your hardware manufacturers for the computer and/or disk system.
- Work with your hardware vendor or device manufacturer to ensure:
  - The hardware devices and the configuration confirm to the [Microsoft SQL Server Database Engine Input/Output requirements](https://support.microsoft.com/help/967576).
  - The device drivers and other supporting software components of all devices in the I/O path are updated
- Consider using a utility like [SQLIOSim](https://support.microsoft.com/help/231619) on the same drive as the databases that have reported the consistency errors. SQLIOSim is a tool independent of the SQL Server Engine to test the integrity of I/O for the disk system. SQLIOSim ships with SQL Server 2008 and does not require a separate download.
- Check for any other errors reported by SQL Server such as Access Violations or Assertions.
- Ensure your databases are using the `PAGE_VERIFY CHECKSUM` option. If checksum errors are being reported, these are indicators that the consistency errors have occurred after SQL Server has written pages to disk so your disk system should be thoroughly checked, see [How to Troubleshoot Msg 824 in SQL Server](/sql/relational-databases/errors-events/mssqlserver-824-database-engine-error) for more information about checksum errors.
- Look for Msg 832 errors in the ERRORLOG. These are indicators that pages may be damaged while they are in cache before written to disk. See [How to Troubleshoot Msg 832 in SQL Server](/sql/relational-databases/errors-events/mssqlserver-832-database-engine-error) for more information.
- Try to restore a database Backup you know that is "clean" (no errors from CHECKDB) and transaction log Backups you know span the time when the error was encountered. If you can "replay" this problem by restoring a "clean" database Backup and transaction logs then contact Microsoft Technical Support for assistance.
- Data Purity errors can be a problem with the application inserting or updating invalid data into SQL Server tables. For more information about troubleshooting Data Purity errors, see [Troubleshooting DBCC Error 2570 in SQL server 2005](/sql/relational-databases/errors-events/mssqlserver-2570-database-engine-error).

## More information

For details on the syntax of DBCC CHECKDB and information/options about how to execute the command, see [DBCC CHECKDB (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql).

If any errors were found by CHECKDB, additional messages like the following are reported in the ERRORLOG for the purposes of Error Reporting:

> Date/Time spid53      Using 'dbghelp.dll' version '4.0.5'  
Date/Time spid53      **Dump thread - spid = 0, EC = 0x00000000855F5EB0  
Date/Time spid53      ***Stack Dump being sent toFilePath\FileName  
Date/Time spid53      * ******************************************************************************  
Date/Time spid53      *  
Date/Time spid53      * BEGIN STACK DUMP:  
Date/Time spid53      *  Date/Timespid 53  
Date/Time spid53      *  
Date/Time spid53      * DBCC database corruption  
Date/Timespid53       *  
Date/Time spid53      * Input Buffer 84 bytes -  
Date/Time spid53      *             dbcc checkdb(mydb)  
Date/Time spid53      *  
Date/Time spid53      * *******************************************************************************  
Date/Time spid53      *   -------------------------------------------------------------------------------  
Date/Time spid53      * Short Stack Dump  
Date/Time spid53      Stack Signature for the dump is 0x00000000000001E8  
Date/Time spid53      External dump process return code 0x20002001.  

The error information has been submitted to Watson error reporting.

The files used for error reporting include a SQLDump\<nnn>.txt file. This file can be useful for historical purposes as it contains a list of the errors found from CHECKDB in an XML format.

To find out when the last time DBCC CHECKDB was run without errors detected for a database (the last known clean CHECKDB), check the SQL Server ERRORLOG for a message like the following for your database or system database (this message is written as an Information Level message in the Windows Application Event Log with EventID = 17573):

> Date/Time spid7s      CHECKDB for database 'master' finished without errors onDate/Time22:11:11.417 (local time). This is an informational message only; no user action is required
