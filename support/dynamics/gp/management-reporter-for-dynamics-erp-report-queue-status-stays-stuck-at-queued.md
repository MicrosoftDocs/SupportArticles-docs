---
title: Report Queue Status window stays stuck at Queued
description: Discusses potential resolutions for being unable to process reports through Management Reporter.
ms.reviewer: theley, ryansand, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# Management Reporter for Dynamics ERP Report Queue Status window stays stuck at Queued

This article provides resolutions for the issues that cause the Report Queue Status window stays stuck at Queued.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2298248

## Symptoms

You select the **Generate** button in Management Reporter for Dynamics ERP but the Report Queue Status window lists the Status as Queued rather than Processing.

## Cause

There are six potential causes for this error:

Cause  1

If the Management Reporter Process Service is on the same machine as the machine hosting your ManagementReporter SQL database. The Process Service may have errored out by attempting to start before SQL Server was accepting connections. See Resolution 1 in the Resolution section.

Cause 2

A SQL Server connection error has occurred and the Management Reporter Process Service needs to be restarted. See Resolution 2 in the Resolution section.

Cause 3

The user running the Management Reporter Process Service does not have sufficient permissions to read from the ManagementReporter SQL Server database. See Resolution 3 in the Resolution section.

Cause 4

The SQL Service Broker on the ManagementReporter SQL Server database is not enabled. See Resolution 4 in the Resolution section.

Cause 5

This can happen if the owner of the Management Reporter database is a Windows User while the SQL Server Service is being run by a local user. If you check the Event Viewer, you may see this message:

> An exception occurred while enqueueing a message in the target queue. Error 15404, State 19. Could not obtain information about Windows NT group/user 'domain\user', error code 0x5.

See Resolution 5 in the Resolution section.

Cause 6

This can happen if the **no count** checkbox is selected in the Server Properties in SQL Server Management Studio. If you check Event Viewer after generating a report, you may see this message:

> System.Data.Linq.ChangeConflictException: (Row not found or changed) or (in Assembly 'xxxxxx' is not marked as serializable)

See Resolution 6 in the Resolution section.

## Resolution

Resolution 1

If using Windows Server 2008, you can set the Management Reporter Process Service to Automatic (Delayed Start) rather than Automatic.

OR

Restart Process Service manually or with a script similar to the following:

```console
NET STOP MRProcessService

NET START MRProcessService
```

Resolution 2

Restart Process Service manually or with a script similar to the following:

```console
NET STOP MRProcessService

NET START MRProcessService
```

Resolution 3

Grant the user running this service the GeneralUser role under the Management Reporter database in SQL Server. This user can be found on the **Log On** tab under the Services Control panel.

Resolution 4

Run the following statement on the SQL server where your ManagementReporter database resides:

```sql
SELECT name, is_broker_enabled FROM sys.databases WHERE name = DB_NAME() AND is_broker_enabled = 1
```

This statement should return a row for the ManagementReporter SQL Server database. If it does not, run the statement below to re-enable the SQL Service Broker on the ManagementReporter SQL Server database:

```sql
ALTER DATABASE [ManagementReporter] SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE;
```

Resolution 5

Change the database owner to sa or change the SQL Server Service user to a domain user.

Resolution 6

In SQL Server Management Studio, right-click on the server name and then select **Properties**. Select **Connections** and in the **Default connections option** section, scroll down and uncheck **no count**.
