---
title: Calculate previous period growth
description: This article shows that when you calculate the previous period growth in MDX, you need to verify if the previous period exists (for example, if it is not zero or NULL). The other item you need to verify when calculating the previous period growth is to verify if you have any negative values for any of the results. If you do have negative values, you can use the procedure discussed in this article to get the correct values in your calculations.
ms.date: 07/22/2020
ms.custom: sap:Analysis Services
ms.topic: how-to
ms.prod: sql
---
# Calculate previous period growth in SQL Server Analysis Services

This article explains how to calculate the previous period growth in SQL Server Analysis Services.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2406745

## Summary

This article discusses the procedure that you can follow to calculate the correct value for Previous Period Growth when you have Analysis Services cubes that contain negative results.

## Use formula to calculate previous period growth

In a scenario where you have an Analysis services cube that contains negative results for which you want to calculate previous period growth values, you need to apply a formula to get the correct results. For example, assume you have the following balances for years 2008, 2009 and 2010: $10.00, ($4.00), $5.00. Between 2009 and 2010, since the balance went from being negative ($4.00) to a positive value $5.00, the growth has to be positive. To achieve the correct results, you should apply the following formula:

```sql
IIF (measures.PreviousPeriodCurrentBalance = 0, NULL,
IIF (measures.PreviousPeriodCurrentBalance < 0,
 ([Measures].[Balance Current] - measures.PreviousPeriodCurrentBalance) / measures.PreviousPeriodCurrentBalance * -1,
 ([Measures].[Balance Current] - measures.PreviousPeriodCurrentBalance) / measures.PreviousPeriodCurrentBalance
))
```

> [!NOTE]
> The above formula uses a calculated member `PreviousPeriodCurrentBalance` that was created on a date hierarchy with the following formula:

```sql
([Measures].[Balance Current], [Date Balance].[Hierarchy].currentmember.Prevmember)
```

For more information `IIf` function, you can refer to the topic in SQL Server Books Online: [IIf (MDX)](/sql/mdx/iif-mdx?redirectedfrom=MSDN&view=sql-server-ver15&preserve-view=true)
