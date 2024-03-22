---
title: Three types of OLAP storage schemes are compatible with Analysis Cubes for Microsoft Excel
description: Describes the data storage and the data retrieval of Multidimensional OLAP (MOLAP), Relational OLAP (ROLAP), and Hybrid OLAP (HOLAP). Compares the speed of the query performances.
ms.reviewer: theley, ngregg
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Three types of OLAP storage schemes in Analysis Services are compatible with Analysis Cubes for Microsoft Excel

This article gives an overview of the three types of OLAP storage schemes that are compatible with Analysis Cubes for Microsoft Excel in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. These OLAP storage schemes are available in Microsoft SQL Server Analysis Services.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916683

The following is an overview of the three types of OLAP storage schemes:

- Multidimensional OLAP (MOLAP)

  Data is stored in and retrieved from cube structures that are separate from a relational database. This OLAP has the fastest query performance for users.
- Relational OLAP (ROLAP)

  Data is stored in and retrieved from a relational database. This OLAP has the slowest query performance for users.

- Hybrid OLAP (HOLAP)

  Data is stored in and retrieved from a combination of multidimensional cube structures and relational database tables. The query performance of this OLAP is slower than Multidimensional OLAP but faster than Relational OLAP.
