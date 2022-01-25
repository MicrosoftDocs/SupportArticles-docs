---
title: No properties and members of Dimension Hierarchy
description: This article provides a workaround for the no results error that occurs when you try to get the properties and members of a Dimension Hierarchy by using XMLA script.
ms.date: 08/05/2020
ms.custom: sap:Analysis Services
ms.reviewer: deepeshs, jburchel
ms.prod: sql
---
# No results for XMLA script query for properties/members of a Dimension Hierarchy

This article helps you work around the problem that occurs when you try to get the properties and members of a Dimension Hierarchy by using XML for Analysis (XMLA) script.

_Original product version:_ &nbsp; SQL Server 2016 Business Intelligence, SQL Server 2016 Analysis Services  
_Original KB number:_ &nbsp; 4038458

## Symptoms

Assume that you have Microsoft SQL Server 2016 Analysis Services (SSAS 2016) installed. When you try to obtain the properties of a specific Dimension Hierarchy and its members by using XMLA script in SSAS 2016, no results are returned.

> [!NOTE]
> - The same XMLA script works in SQL Server 2014 Analysis Services or earlier versions of SQL Server Analysis Services.
> - This issue only occurs when `HierarchyUniqueNameStyle` is set to **ExcludeDimensionName**.

## Cause

This issue occurs because value **ExcludeDimensionName** was meant only for supporting old databases, such as SQL Server 2000 or 2005. If `HierarchyUniqueNameStyle` is set to **ExcludeDimensionName**, any XMLA request that includes `DIMENSION_UNIQUE_NAME` in the `RestrictionList` produces empty results.

## Workaround

To work around this issue, set the value of `HierarchyUniqueNameStyle` to **IncludeDimensionName** in the cube dimension object.
