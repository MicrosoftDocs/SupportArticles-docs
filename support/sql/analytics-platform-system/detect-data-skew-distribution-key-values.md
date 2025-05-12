---
title: Detect skew on distribution key values
description: This article describes how to detect skew on the distribution key of a distributed table in a Parallel Data Warehouse appliance.
ms.date: 05/09/2025
ms.custom: sap:Parallel Data Warehouse (APS)
ms.topic: how-to
ms.reviewer: jopilov, ccaldera
---
# Detect data skew on the distribution key values

This article shows how to detect skew on the distribution key of a distributed table in a Parallel Data Warehouse appliance.

_Original product version:_ &nbsp; SQL Server Parallel Data Warehouse  
_Original KB number:_ &nbsp; 3046863

## Summary

Data skew may occur at several different levels in Microsoft SQL Server Parallel Data Warehouse. This article focuses on rows that are skewed to certain values. This can cause a distributed table to put more data on one distribution than on the other distributions. The following query counts the number of rows that have a specific value for the distribution key of the table:

```sql
select distribution_key, count(distribution_key)

from distributed_table

group by distribution_key

--having count(distribtuion_key) >5000

order by count(distribtuion_key) desc
```

> [!NOTE]
> The `having` clause is commented out. However, if you want to perform a quick check of whether there's significant skew, this clause may tell you. You may have to adjust the having value to something that makes sense for your result set. For example, if all values have 5,000 records, we recommend that you set this value to 7,500 or 10,000 to indicate an issue.

The question of when skew becomes a problem doesn't have a deterministic answer. Skew becomes a problem when performance of skewed distributions becomes noticeable and the application can't tolerate the situation. The rule of thumb is that the appliance can tolerate a skew of 10 to 20 percent across all the tables. Within this threshold, the skewed distributions should even out under concurrency. Above this threshold, you may start to see some long-running distributions when the data is processed. Some implementations may be able to tolerate greater skew, and some implementations may be unable to tolerate this much. Testing is required to determine the actual threshold for your implementation.

## More information

If the skewed value is also used as a join condition and the other side is skewed toward the same value, there can be an explosion in the number of rows from the join. This can cause query execution to take a long time.

> [!IMPORTANT]
> Pay extra attention to the number of NULL values, because these can cause issues for joins.
