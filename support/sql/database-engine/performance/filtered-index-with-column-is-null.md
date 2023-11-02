---
title: Filtered index with Column IS NULL isn't used
description: This article provides resolution for the problem that occurs when you create the filtered index together with the Column IS NULL predicate expression in Microsoft SQL Server.
ms.date: 09/14/2020
ms.custom: sap:Database Design and Development
ms.reviewer: fredep, ramakoni
---

# A filtered index that you create together with the IS NULL predicate is not used in SQL Server

This article helps you resolve the problem that occurs when you create the index together with the `Column IS NULL` predicate expression in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3051225

## Symptoms

Consider the following scenario:

- You create a filtered index together with the `Column IS NULL` predicate expression in SQL Server.
- The **Column** field isn't included in the index structure. (That is, the **Column** field isn't a key or included column in the filtered index definition.)

For example, you create the following query:

```sql
CREATE UNIQUE CLUSTERED INDEX i_action_rn ON dbo.filter_test (rn)
CREATE NONCLUSTERED INDEX i_action_filt_action_date_type ON dbo.filter_test (action_type)
WHERE action_date IS NULL
```

> [!NOTE]
> This query doesn't use the following filtered index:

```sql
SELECT count(*) FROM dbo.filter_test WHERE action_date IS NULL AND action_type=1
```

In this scenario, the filtered index isn't used. Instead, the clustered index is used.

:::image type="content" source="media/filtered-index-with-column-is-null/cluster-index-scan.png" alt-text="Diagram shows the clustered index scan is used.":::

## Resolution

To resolve this issue, include the column that is tested as NULL in the returned columns. Or, add this column as include columns in the index.

```sql
CREATE NONCLUSTERED INDEX New_i_action_filt_action_date_type ON dbo.filter_test (action_type) include (action_date) WHERE action_date IS NULL
```

:::image type="content" source="media/filtered-index-with-column-is-null/index-seek.png" alt-text="Diagram shows the filtered index seek is used.":::

## More information

- [Create Filtered Indexes](/sql/relational-databases/indexes/create-filtered-indexes)

- [Clustered and Nonclustered Indexes Described](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described)
