---
title: Logshipping monitor raises 14420 error
description: This article provides resolutions for the problem that Logshipping monitor incorrectly raises error number 14420 instead of 14421 when the secondary database is out of sync.
ms.date: 07/22/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: raffaeca
---
# Logshipping monitor incorrectly raises error number 14420 instead of 14421 when the secondary database is out of sync

This article helps you resolve the problem where Logshipping monitor incorrectly raises error number 14420 instead of 14421 when the secondary database is out of sync.

_Original product version:_ &nbsp; Microsoft SQL Server  
_Original KB number:_ &nbsp; 2006312

## Symptoms

Consider the following configuration of a Log Shipping environment:

- Server A hosts primary server instance and the database.
- Server B hosts secondary server instance and the database.
- Server C hosts a monitor server instance where in the Log Shipping Monitor job is configured to use an impersonated proxy account for the connections to Server A and Server B.

When you use this configuration, Log Shipping Monitor job incorrectly raises error message 14420 instead of 14421 when the secondary database is out of sync. The description of these error messages in SQL Server 2005 and SQL Server 2008 is as follows:

> Error: 14420, Severity: 16, State: 1  
The log shipping primary database %s.%s has backup threshold of %d minutes and has not performed a backup log operation for %d minutes. Check agent log and logshipping monitor information.

> Error: 14421, Severity: 16, State: 1  
The log shipping secondary database %s.%s has restore threshold of %d minutes and is out of sync. No restore was performed for %d minutes. Restored latency is %d minutes. Check agent log and logshipping monitor information.

The alert message 14221 indicates that the difference between current time (UTC) and the `last_restored_date_utc` value in the `log_shipping_monitor_secondary` table on the monitor server is greater than value that is set for the Restore Alert threshold whereas the alert message 14220 indicates that the difference between UTC and the `last_backup_date_utc` value in the `log_shipping_monitor_primary` table on the monitor server is greater than value that is set for the Backup Alert threshold.

## Cause

The issue happens because of a problem in the Log Shipping user interface. When you create the monitor job for the secondary, 14220 is passed instead of 14221.

## Resolution

To resolve the problem, correct the `@threshold_alert` parameter value for the secondary database by executing the following statement on the monitor server (Server C):

```sql
use master
go
sp_change_log_shipping_secondary_database @secondary_database = 'dbname', @threshold_alert = 14421
```

## More information

[Description of error message 14420 and error message 14421 that occur when you use log shipping in SQL Server](https://support.microsoft.com/help/329133/description-of-error-message-14420-and-error-message-14421-that-occur)
