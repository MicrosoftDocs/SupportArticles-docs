---
title: Writeback performance issue
description: This article provides workarounds for the writeback performance problem that occurs when cell security is enabled in SQL Server Analysis Services.
ms.date: 05/09/2025
ms.custom: sap:Analysis Services
ms.reviewer: haidongh, heidist, gasadas
---
# Writeback performance problem when cell security is enabled in SQL Server Analysis Services

This article helps you work around the writeback performance problem that occurs when cell security is enabled in SQL Server Analysis Services.

_Original product version:_ &nbsp; SQL Server 2012 Analysis Services and later versions  
_Original KB number:_ &nbsp; 2747616

## Symptoms

Assume that you're running Microsoft SQL Server Analysis Services (SSAS) under a role for which cell security is enabled. When you try to execute an UPDATE CUBE Multidimensional Expressions (MDX) statement, the statement execution may take longer to execute than for a role for which cell security isn't enabled.

## Cause

This behavior is by design. When cell security is enabled, the Analysis Services engine executes the queries in cell-by-cell mode. If the writeback operation performs allocation at a high level, the space of leaf level cells will be large.

> [!NOTE]
> The space isn't the number of rows in the fact table. The space is the full cross join space of all dimension granularity attributes. It takes a long time to enumerate those cells one-by-one in order to check the cell security.

## Workaround

To work around this issue, use one of the following methods.

- Method 1  

    Put the measures that should be secured into a separate cube, and implement the cube level write security under your role.

    > [!NOTE]
    > The performance when you use this method is as fast as when the query runs under an admin role. However, your cube design becomes complex, and you have to create virtual cubes to use linked measure groups in order to return the different measures in a single MDX query. Additionally, when you perform the writeback operation, you have to create an MDX query that uses the correct cube name based on the writeback measure.

- Method 2  

    Perform the writeback operation at the lowest granularity level of a certain member. You can't allocate for many detailed granularity members.

    > [!NOTE]
    > You may have to create dummy members in dimension tables that are marked as adjustment members in each dimension, to support the writeback operation.
