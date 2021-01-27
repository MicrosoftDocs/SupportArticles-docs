---
title: Error and MDX query fails in SSAS multidimensional instance
description: This article provides a resolution for the problem that occurs when you run a Multidimensional Expressions (MDX) query on a Microsoft SQL Server Analysis Services (SSAS) multidimensional instance.
ms.date: 01/14/2021
ms.prod-support-area-path: Analysis Services
ms.reviewer: yinnw, tizh, mariusd
ms.topic: troubleshooting
ms.prod: sql 
---
# Error (Query optimizer generated too many subcubes) and MDX query fails in SSAS multidimensional instance

This article helps you resolve the problem that occurs when you run a Multidimensional Expressions (MDX) query on a Microsoft SQL Server Analysis Services (SSAS) multidimensional instance.

_Applies to:_ &nbsp; SQL Server 2012 Analysis Services (SSAS), SQL Server 2014 Analysis Services (SSAS), SQL Server 2016 Analysis Services (SSAS), SQL Server 2017 Analysis Services (SSAS) Windows, SQL Server 2019 Analysis Services (SSAS) Windows  
_Original KB number:_ &nbsp; 4533057

## Symptoms

When you run a Multidimensional Expressions (MDX) query on a Microsoft SQL Server Analysis Services (SSAS) multidimensional instance, the MDX query fails and returns the following error message:

> Query optimizer generated too many subcubes in the query plan

This error occurs if the following conditions are true:

- Too many calculated members are defined on a single hierarchy level or attribute.
- Many fields or attribute members are put onto each axis. Or, many fields are put together on the rows or columns of a PivotTable in Microsoft Excel.
- All members of selected hierarchies are included in the axis.
- Grand totals and subtotals are turned on in the Excel PivotTable.

## Cause

The SSAS Formula Engine (FE) has to generate all relevant MDX sets for the Storage Engine (SE) Query subcube or Sonar subcube. There is a limit on the number of SE Query subcubes per query that can be generated. This is by design. Currently in the query plan, an error occurs if the FE generates too many query subcubes for the query.

## Resolution

To avoid this error, follow these best practices guidelines:

- In the Excel PivotTable, turn off both grand totals and subtotals.
- Remove the hierarchy from the **Rows** or **Columns** axis of the PivotTable in the Excel UI.
- Do not define too many calculated members (for example, more than 500) on the dimension hierarchy. Instead, have regular members in the dimension hierarchy, and use MDX scope assignment expressions (also known as calculated cells) to replace the expressions of those calculated members.
