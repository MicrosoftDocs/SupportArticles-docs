---
title: NA returns when you run a multi-subselect query
description: This article discusses a problem that occurs when you run a multi subselect query in SQL Server Analysis Services.
ms.date: 07/22/2020
ms.prod-support-area-path: Analysis Services
ms.reviewer: Yinn Wong, Ramu Konidena
ms.prod: sql
---
# '#N/A' returns when you run a multi-subselect query in SQL Server Analysis Services

This article introduces a problem that occurs when you run a multi-subselect query in SQL Server Analysis Services.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 4100766

## Symptoms

Consider the following scenario:

- You install Analysis Services in `Multidimensional` mode on an instance of SQL Server 2012,  SQL Server 2014, SQL Server 2016, or SQL Server 2017.
- There is a database in this instance.
- You create a role with cell security read permission for this database.
- You execute a query that contains a subselect with multiple members.

In this situation, you get **#N/A** cell values for the measure if the multi-member subselect is at or below the granularity, and the higher-level members whose values are affected by the cell security read permissions are applied to them.

## Cause

This behavior is by design. This design makes sure that the database does not expose real cell values that are secured by the cell security.

## Applies to

- SQL Server 2012
- SQL Server 2012 Analysis Services
- SQL Server 2014
- SQL Server 2014 Business Intelligence
- SQL Server 2016
- SQL Server 2017 on Windows  
