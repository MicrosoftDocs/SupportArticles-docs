---
title: Problem occurs when you use a logic handler
description: Provides resolutions for a problem that occurs when you use a custom business logic handler in SQL Server.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: holgerl, sqlblt
---
# A custom SQL Server business logic handler replaces an empty string with an end-of-string character

This article helps you resolve the problem that occurs when you use a custom business logic handler in SQL Server.

_Original product version:_ &nbsp; SQL Server 2008 Standard, SQL Server 2008 Enterprise, SQL Server 2008 R2 Standard, SQL Server 2008 R2 Enterprise, SQL Server 2008 R2 Datacenter, SQL Server 2012 Standard, SQL Server 2012 Enterprise, SQL Server 2012 Developer  
_Original KB number:_ &nbsp; 2598605

## Symptoms

Consider the following scenario:

- You configure merge replication in Microsoft SQL Server 2012, in Microsoft SQL Server 2008 R2, or in Microsoft SQL Server 2008.
- The publication contains a table article.
- The table article contains a column of data type `varchar`.
- The `varchar` column contains an empty string ('').

> [!NOTE]
> This issue does not occur with a NULL value or single space value (' ').

- You configure the table article to use a custom business logic handler.
- The custom business logic handler handles events that occur during merge replication synchronization.
- The custom business logic handler uses a custom dataset to return the row.

In this scenario, although no error is returned, the custom business logic handler replaces the empty string with a single `end-of-string` character. For example, the custom business logic handler replaces the empty string with one of the following strings:

- 'ASC0'
- '0x00'
- '\0' No other data is affected.

## Cause

This issue occurs because of how the merge agent components and the business logic handler pass data in and out of the intermediate variables.

## Workaround

You may be able to work around this issue by using the `nvarchar` data type instead of the `varchar` data type.

## More information

The problem that is described in the [Symptoms](#symptoms) section can occur if the custom business logic handler handles conflicting `UPDATE` statements at the publisher and subscriber. The empty string is replaced by the single `end-of-string` character after the publisher or subscriber dataset is copied into the custom dataset, and the custom dataset is then passed to the merge replication reconciler.

Additionally, this issue occurs if the data is not changed in custom code that resembles the following:

```csharp
public override ActionOnUpdateConflict UpdateConflictsHandler(..., ref customDataSet, ...)
{
    customDataSet = publisherDataSet.Copy();
    conflictLogType = ConflictLogType.ConflictLogPublisher;
    return ActionOnUpdateConflict.AcceptCustomConflictData;
}
```
