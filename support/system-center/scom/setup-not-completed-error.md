---
title: Operations Manager setup cannot be completed
description: Describes an installation failure with the Setup Cannot be Completed error when you install System Center Operations Manager.
ms.date: 07/06/2020
---
# Setup Cannot be Completed error when installing System Center Operations Manager

This article fixes an issue in which you can't install System Center Operations Manager and receive the **Setup Cannot be Completed** error.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2705760

## Symptoms

While installing System Center Operations Manager, the installation fails and you receive the error **Setup Cannot be Completed**.

## Cause

This may occur if the OperationsManager.mdf and OperationsManager.ldf files already exist in the directory where you chose to install the new `OperationsManager` database. If this occurs, you will see an error similar to the following in the OpsMgrSetupWizard.log file:

> [05:44:19]: Error: :Exception running sql string CREATE DATABASE [OperationsManager] ON PRIMARY(NAME=MOM_DATA,FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\OperationsManager.mdf',SIZE=1000MB,MAXSIZE=1000MB,FILEGROWTH=0MB) LOG ON(NAME=MOM_LOG, FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\OperationsManager.ldf',SIZE=500MB,MAXSIZE=500MB,FILEGROWTH=0MB) COLLATE SQL_Latin1_General_CP1_CI_AS: Threw Exception.Type: System.Data.SqlClient.SqlException, Exception Error Code: 0x80131904, Exception.Message: Cannot create file 'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\OperationsManager.mdf' because it already exists. Change the file path or the file name, and retry the operation.  
> CREATE DATABASE failed. Some file names listed could not be created. Check related errors.  
> [05:44:19]: Error: :StackTrace: at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)  
> at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning()  
> at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)  
> at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async)  
> at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)  
> at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()  
> at Microsoft.EnterpriseManagement.OperationsManager.Setup.DBConfigurationHelper.DBConfiguration.RunSqlStrings(String[] sqlCommands)  
> [05:44:19]: Always: :Failed to create and configure the DB with exception.: Threw Exception.Type: System.Data.SqlClient.SqlException, Exception Error Code: 0x80131904, Exception.Message: Cannot create file 'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\OperationsManager.mdf' because it already exists. Change the file path or the file name, and retry the operation.  
> CREATE DATABASE failed. Some file names listed could not be created. Check related errors.

> [!NOTE]
> The OpsMgrSetupWizard.log file is located in `C:\Users\<InstallationAccount>\AppData\Local\SCOM\Logs`.

## Resolution

To resolve this issue, you must either delete the old OperationsManager.mdf and OperationsManager.ldf files, or move them to a separate location and run the install again.
