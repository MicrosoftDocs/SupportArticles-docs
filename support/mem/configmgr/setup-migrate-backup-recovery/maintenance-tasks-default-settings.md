---
title: Maintenance tasks default settings
description: Lists the default settings for the maintenance tasks in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Maintenance tasks default settings in Configuration Manager

This article introduces the default settings for the maintenance tasks in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 2897050

## Summary

This table lists the default settings for the maintenance tasks in Microsoft System Center 2012 Configuration Manager and System Center 2012 R2 Configuration Manager.

| Maintenance task| Central administration site| Primary site| #of days| Days| Time| Secondary site |
|---|---|---|---|---|---|---|
|Backup Site Server|√|Ø|Not available|Every day|02:00-05:00|Not available|
|Check Application Title with Inventory Information|√|√|Not available|Saturday|0:00-05:00|Not available|
|Clear Install Flag|Not available|Ø|21|Sunday|00:00-05:00|Not available|
|Delete Aged Application Request Data|Not available|√|30|Saturday|00:00-05:00|Not available|
|Delete Aged Client Operations|√|√|7|Every day|00:00-05:00|Not available|
|Delete Aged Client Presence History|√|√|30|Every day|00:00-05:00|Not available|
|Delete Aged Collected Files|Not available|√|90|Saturday|00:00-05:00|Not available|
|Delete Aged Computer Association Data|Not available|√|30|Saturday|00:00-05:00|Not available|
|Delete Aged Delete Detection Data|√|√|5|Every day|00:00-05:00|Not available|
|Delete Aged Distribution Point Usage Data (available only in Microsoft System Center 2012 R2)|√|√|90|Every day|00:00-05:00|Not available|
|Delete Aged Device Wipe Record|Not available|√|180|Saturday|00:00-05:00|Not available|
|Delete Aged Devices Managed by the Exchange Server Connector|Not available|√|Not available|Saturday|00:00-05:00|Not available|
|Delete Aged Discovery Data|Not available|√|90|Saturday|00:00-05:00|Not available|
|Delete Aged Endpoint Protection Health Status History Data|Not available|√|365|Saturday|00:00-05:00|Not available|
|Delete Aged Enrolled Devices|Not available|√|90|Saturday|00:00-05:00|Not available|
|Delete Aged Inventory History|Not available|√|90|Saturday|00:00-05:00|Not available|
|Delete Aged Log Data|√|√|30|Every day|00:00-05:00|√|
|Delete Aged Notification Task History|Not available|√|10|Every day|00:00-05:00|Not available|
|Delete Aged Replication Summary Data|√|√|90|Every day|00:00-05:00|√|
|Delete Aged Replication Tracking Data|√|√|7|Every day|00:00-05:00|√|
|Delete Aged Software Metering Data|Not available|√|5|Every day|00:00-05:00|Not available|
|Delete Aged Software Metering Summary Data|Not available|√|270|Sunday|00:00-05:00|Not available|
|Delete Aged Status Messages|√|√|Not available|Everyday|00:00-05:00|Not available|
|Delete Aged Threat Data|Not available|√|30|Saturday|00:00-05:00|Not available|
|Delete Aged Unknown Computers|Not available|√|30|Saturday|00:00-05:00|Not available|
|Delete Aged User Device Affinity Data|Not available|√|90|Saturday|00:00-05:00|Not available|
|Delete Inactive Client Discovery Data|Not available|Ø|90|Saturday|00:00-05:00|Not available|
|Delete Obsolete Alerts|√|√|30|Every day|00:00-05:00|Not available|
|Delete Obsolete Client Discovery Data|Not available|Ø|7|Saturday|00:00-05:00|Not available|
|Delete Obsolete Forest Discovery Sites and Subnets|√|√|30|Saturday|00:00-05:00|Not available|
|Delete Unused Application Revisions|Not available|√|60|Every day|00:00-05:00|Not available|
|Evaluate Provisioned AMT Computer Certificates|Not available|√|42|Saturday|00:00-05:00|Not available|
|Monitor Keys|√|√|Not available|Sunday|00:00-05:00|Not available|
|Rebuild Indexes|Ø|Ø|Not available|Sunday|00:00-05:00|Ø|
|Summarize Installed Software Data|Not available|√|Not available|Every day|00:00-05:00|Not available|
|Summarize Software Metering File Usage Data|Not available|√|Not available|Every day|00:00-05:00|Not available|
|Summarize Software Metering Monthly Usage Data|Not available|√|Not available|Everyday|00:00-05:00|Not available|
|Update Application Catalog Tables|√|√|Not available|Not available|Every 1,380 minutes|Not available|

> [!NOTE]
>
> √ = By default, enabled  
> Ø = By default, not enabled

## References

For more information about maintenance tasks in System Center 2012 R2 Configuration Manager, see [Planning for Maintenance Tasks for Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg712686(v=technet.10)?redirectedfrom=MSDN#planning-for-maintenance-tasks-for-configuration-manager).
