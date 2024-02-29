---
title: Conversion failed when upgrading to Configuration Manager version 1810
description: Fixes an error that you receive when you try to upgrade to Configuration Manager version 1810.
ms.date: 12/05/2023
ms.reviewer: kaushika, luche, v-six
---
# Conversion failed when you upgrade to Configuration Manager version 1810

This article helps you fix an issue in which you receive error code 1603 when installing the Configuration Manager client.

_Original product version:_ &nbsp; System Center Configuration Manager (current branch - version 1810)  
_Original KB number:_ &nbsp; 4487768

## Symptoms

You create collections that have incremental updates enabled, and the schedule token is created by using PowerShell cmdlet `New-CMSchedule` together with the `-DurationInterval` and `-DurationCount` parameters.

For example, you use the following PowerShell commands to create the collection:

```powershell
$Schedule = New-CMSchedule -DayOfMonth 1 -DurationInterval Days -DurationCount 31
New-CMDeviceCollection -Name "TEST-2" -LimitingCollectionName "All Systems" -RefreshSchedule $Schedule -RefreshType Continuous
```

The collection has the following flags and schedule token:

`Flags = 4, Schedule = 2C996A0007D00008`

When you update to Configuration Manager current branch version 1810, you receive an error message that resembles the following example:

> \*\*\* \[22018][245]\[Microsoft][SQL Server Native Client 11.0][SQL Server]Conversion failed when converting the nvarchar value 'D' to data type int.

> [!NOTE]
> This issue doesn't occur if you set the update schedule in the Configuration Manager console.

## Cause

This issue occurs because the schedule token contains an invalid character (`D` in the example). Therefore, upgrade precheck fails.

## Resolution

To fix this issue, follow these steps:

1. Identify the collections that may cause this issue by running the following query:

    ```sql
    select CollectionID, CollectionName, Flags, Schedule from Collections_G
    where (Flags & 0x07 = 0x1 or Flags & 0x07 = 0x04) AND
    Schedule <> '' AND Schedule is not NULL AND
    substring(ISNULL(Schedule, ''), 11, 1) not like '[0-9]'
    ```

2. Change the schedule token of these collections. For each collection: On the **Membership Rules** tab of the collection's **Properties** dialog box, clear **Use incremental updates for this collection** or change the schedule for a full update on the collection.
