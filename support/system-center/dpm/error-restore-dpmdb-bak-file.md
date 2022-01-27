---
title: Can't restore the DPMDB.bak file
description: Fixes an issue that triggers an error when you use the DpmSync.exe command-line tool to restore the DPMDB.bak database file.
ms.date: 07/23/2020
---
# The system cannot find the file specified error when you use DPM to restore DPMDB.bak

This article helps you fix an issue where you receive **The system cannot find the file specified** error when you restore the DPMDB.bak file in Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 3047774

## Symptoms

When you run the `DpmSync.exe -restoredb -dbloc` command line to restore the DPMDB.bak file, the operation fails with the following error:  

> Unhandled Exception: Microsoft.SqlServer.Management.Smo.FailedOperationException: Restore failed for Server \<DPMDBName>. ---> Microsoft.SqlServer.Management.Common.ExecutionFailureException: An exception occurred while executing a Transact-SQL statement or batch. ---> System.Data.SqlClient.SqlException: Directory lookup for the file "\<D:\Microsoft System Center 2012\DPMDB\MSDPM2012$DPMDB.mdf>" failed with the operating system error 2(The system cannot find the file specified.). File 'MSDPM2012$DPMDB_dat' cannot be restored to 'D:\Microsoft System Center 2012\DPMDB\MSDPM2012$DPMDB.mdf'. Use WITH MOVE to identify a valid location for the file.Directory lookup for the file "\<D:\Microsoft System Center 2012\DPMDB\MSDPM2012$D>PMDB_log.ldf" failed with the operating system error 2(The system cannot find the file specified.). File 'MSDPM2012$DPMDBLog_dat' cannot be restored to 'D:\Microsoft System Center2012\DPMDB\MSDPM2012$DPMDB_log.ldf'. Use WITH MOVE to identify a valid locationfor the file.Problems were identified while planning for the RESTORE statement. Previous messages provide details.RESTORE DATABASE is terminating abnormally.at Microsoft.SqlServer.Management.Common.ConnectionManager.ExecuteTSql(ExecuteTSqlAction action, Object execObject, DataSet fillDataSet, Boolean catchException)at Microsoft.SqlServer.Management.Common.ServerConnection.ExecuteNonQuery(String sqlCommand, ExecutionTypes executionType)--- End of inner exception stack trace --- at Microsoft.SqlServer.Management.Common.ServerConnection.ExecuteNonQuery(String sqlCommand, ExecutionTypes executionType)at Microsoft.SqlServer.Management.Common.ServerConnection.ExecuteNonQuery(StringCollection sqlCommands, ExecutionTypes executionType)at Microsoft.SqlServer.Management.Smo.ExecutionManager.ExecuteNonQuery(StringCollection queries)at Microsoft.SqlServer.Management.Smo.BackupRestoreBase.ExecuteSql(Server server, StringCollection queries)at Microsoft.SqlServer.Management.Smo.Restore.SqlRestore(Server srv) --- End of inner exception stack trace --- at Microsoft.SqlServer.Management.Smo.Restore.SqlRestore(Server srv) at Microsoft.Internal.EnterpriseStorage.Dls.RestoreDbSync.RestoreDBHelper.RestoreFromBackupFile(String dbLocation) at Microsoft.Internal.EnterpriseStorage.Dls.RestoreDbSync.RestoreDBHelper.RestoreDb(String dbLocation)at Microsoft.Internal.EnterpriseStorage.Dls.RestoreDbSync.RestoreDbSync.Main(String[] args) \<D:\Microsoft System Center 2012\DPM\DPM\bin>> .//

## Cause

This problem may occur if the DPM installation directory has changed. For example, assume that the DPM installation path was *D:\Microsoft System Center 2012*.

However, at some point a reinstall was done, and now the installation path is *D:\Program Files\ Microsoft System Center 2012*.

## Resolution

To resolve this issue, use one of the following options.

- Option 1: Create the directory structure so that the restore operation can use the original installation path.

- Option 2: Use SQL Server Management Studio to do the restore of DPMDB.bak. Then, after the database is restored, run `DpmSync.exe -sync` from an administrative command prompt (**Run As Administrator**).

## More information

The `DPMSync.exe -sync` command in option 2 may fail with the following error:

> Error ID: 454 DpmSync failed to connect to the specified SQL Server instance. Make sure that you have specified a valid SQL server instance associated with DPM and you are logged on as a user with administrator privileges. Detailed Error: Cannot open database "DPMDB NAME" requested by the login. The login failed. Login failed for user 'domain\currently logged in user'.

This problem may occur if the name of the restored DPMDB doesn't match the default DPMDB name that's mentioned in the error message. To verify it, look in SQL Server Management Studio for the DPMDB that was successfully restored, and determine whether the DPMDB name differs from the name that's shown in error ID: 454.

If the names do differ, use SQL Server Management Studio to change the name of the currently mounted DPMDB to match the DBName value that's noted in the error message:

1. Expand **Databases**, and then select **DPMDB**.
2. Right-click **DPMDB**, and then select **Rename**.
3. Change the DPMDB name to reflect the name that's noted in the **ID: 454** error.
4. In SQL Server Management Studio, make sure that the user that's specified in the error message has sysadmin permissions under server roles and that DPMDB is selected under user mappings.
5. At an administrative command prompt, run `DpmSync.exe -sync`.
