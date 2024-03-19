---
title: Management Reporter 2012 Process Service stops unexpectedly
description: Describe an issue where the Management Reporter Process Service will unexpectedly stop running. Provides a resolution.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Management Reporter 2012 Process Service stops unexpectedly

This article provides a resolution for the issue that the  Management Reporter 2012 Process Service stops unexpectedly.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2728968

## Symptoms

The Management Reporter 2012 Process Service starts and stops repeatedly and you receive one of the following errors:

In Management Reporter, the following error will occur:

> The operation could not be completed because doing so would create a bad reference.

In Event Viewer, the following error is displayed:

> Application: MRServiceHost.exe Framework Version: v4.0.30319 Description: The process was terminated due to an unhandled exception. Exception Info: System.Configuration.ConfigurationErrorsException Stack: at System.Configuration.BaseConfigurationRecord.GetSectionRecursive(System.String, Boolean, Boolean, Boolean, Boolean, System.Object ByRef, System.Object ByRef) at System.Configuration.BaseConfigurationRecord.GetSection(System.String) at System.Configuration.ConfigurationManager.GetSection(System.String) at System.Configuration.PrivilegedConfigurationManager.GetSection(System.String) at System.Data.Common.DbProviderFactories.Initialize() at System.Data.EntityClient.EntityConnection.GetFactory(System.String) at System.Data.EntityClient.EntityConnection.ChangeConnectionString(System.String) at System.Data.Objects.ObjectContext.CreateEntityConnection(System.String) at Microsoft.Dynamics.Common.Scheduler.Data.SchedulerEntities..ctor(System.String) at Microsoft.Dynamics.Common.Scheduler.Data.SchedulerObjectContextFactory.CreateContext() at Microsoft.Dynamics.Common.Scheduler.Data.DataManager.RegisterScheduler(System.Guid, System.DateTime, Int32) at Microsoft.Dynamics.Common.Scheduler.GenericScheduler.Scheduler.MakeDatabaseCurrent() at Microsoft.Dynamics.Common.Scheduler.GenericScheduler.Scheduler.StartScheduler() at Microsoft.Dynamics.Performance.Reporting.Scheduler.SchedulerService.\<OnStart>b__1() at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean) at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object) at System.Threading.ThreadHelper.ThreadStart()

> Cannot insert duplicate key in object 'dbo.ControlConfiguredIntegration'
>
> System.Data.SqlClient.SqlException (0x80131904): The INSERT statement conflicted with the FOREIGN KEY constraint "Task_TaskType_Id". The conflict occurred in database "ManagementReporter", table "Scheduling.TaskType", column 'Id'.
>
> The statement has been terminated.

## Cause

This is caused when there is a duplicate *\<DbProviderFactories>* entry in the machine.config file on the server where the MR services are installed. The default folder location for the machine.config file is C:\Windows\Microsoft.Net\Framework64\v4.0.30319\Config\\.

## Resolution

Delete the duplicate `DbProviderFactories />` entry in the machine.config file.

> [!NOTE]
> Make a backup before you make any changes to the machine.config file.

Example duplicate entry:

```console
<DbProviderFactories>
<add name="IBM DB2 for i5/OS .NET Provider" invariant="IBM.Data.DB2.iSeries" description=".NET Framework Data Provider for i5/OS" type="IBM.Data.DB2.iSeries.iDB2Factory, IBM.Data.DB2.iSeries, Version=12.0.0.0, Culture=neutral, PublicKeyToken=9cdb2ebfb1f93a26" />
</DbProviderFactories>
<DbProviderFactories />
```

To correct the example entry here, you would have to delete the `\<DbProviderFactories />` line and then save the changes.

## More information

If you are unsure which entry to delete in the machine.config, contact Microsoft Support.
