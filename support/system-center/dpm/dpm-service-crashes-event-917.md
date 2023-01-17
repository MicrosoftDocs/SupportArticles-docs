---
title: DPM service crashes with event ID 917
description: Describes a crash issue in System Center 2012 Data Protection Manager that affects only protection groups that are configured for long-term protection.
ms.date: 07/23/2020
---
# The DPM service crashes with Event ID 917 after you change a protection group

This article helps you work around an issue where the Data Protection Manager (DPM) service crashes with event ID 917 after you change a protection group.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager, System Center 2012 R2 Data Protection Manager  
_Original KB number:_ &nbsp; 2905631

## Symptoms

After you change a protection group in Microsoft System Center 2012 Data Protection Manager (DPM 2012), the DPM service crashes with event ID 917, and the console shuts down. This affects only protection groups that are configured for long-term protection (for example, groups that are configured for tape backup), especially if those groups contain data sources that are SQL Server Always On databases.

## Cause

It's a known issue in DPM 2012. When you protect an SQL Server data source by using only tape backup and then the volume ID of the data source changes, DPM tries to invalidate the replica that has the old volume ID. Because there's no replica that doesn't have short-term protection, the service crashes with a `NullReferenceException`. The issue most frequently affects Microsoft SQL Server 2012 Always On availability groups because the underlying volumes frequently change.

## Workaround

To work around this issue, create a protection group that contains all the SQL Server Always On databases. (If you have to adjust protection group settings, you should make the change when no jobs are running.) After the error occurs, restart the console, and then resolve the warning. At that point, the protection group will return to **OK** status, the new settings will take effect, and future backups will succeed.
