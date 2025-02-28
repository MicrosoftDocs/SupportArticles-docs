---
title: Performance views still show deleted counters 
description: Fixes an issue in which performance views still show counters when performance collection rules are disabled in Microsoft System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: adoyle, nicholad
---
# Performance views still show counters when performance collection rules are disabled in Operations Manager

This article helps you fix an issue in which performance views still show counters when performance collection rules are disabled in Microsoft System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3002249

## Symptoms

When performance collection rules are disabled in System Center Operations Manager, performance views still show counters even after all the data is groomed out.

This clutter `PerformanceDataAllView`, in extreme cases, can make the view difficult to use because of the number of counters that are selected.

## Cause

This issue is by design. The Operations Manager grooming processes don't groom the `PerformanceSource` table.

## Resolution

The following example is a small SQL script that will remove the entries from `PerformanceDataAllView` for which no data is recorded.

> [!NOTE]
> Stop all the Operations Manager services on all management servers before you run the script. Always back up your `OperationsManager` database before you run this script.

```sql
Use OperationsManager
delete from PerformanceSource where PerformanceSourceInternalId in
(
select PS.PerformanceSourceInternalId from PerformanceSource PS
left join PerformanceDataAllView PDA on PDA.PerformanceSourceInternalID = PS.PerformanceSourceInternalId
where PDA.PerformanceSourceInternalId IS NULL
)
```

If you want to see which performance counters will be deleted for what objects before you run the delete script that's listed before, first run the following script:

```sql
Use OperationsManager select PS.PerformanceSourceInternalId, BME.BaseManagedEntityId, BME.DisplayName, PC.CounterName, PC.ObjectName, PS.TimeAdded, PS.LastModified, PDA.PerformanceSourceInternalId from PerformanceSource PS left join PerformanceDataAllView PDA on PDA.PerformanceSourceInternalID = PS.PerformanceSourceInternalId join PerformanceCounter PC on PC.PerformanceCounterId = PS.PerformanceCounterId join BaseManagedEntity BME on BME.BaseManagedEntityId = PS.BaseManagedEntityId where PDA.PerformanceSourceInternalId IS NULL
```
