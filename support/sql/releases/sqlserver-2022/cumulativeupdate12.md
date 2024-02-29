---
title: Cumulative update 12 for SQL Server 2022 (KB5033663)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 12 (KB5033663).
ms.date: 03/14/2024
ms.custom: KB5033663
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5033663 - Cumulative Update 12 for SQL Server 2022

_Release Date:_ &nbsp; March 14, 2024  
_Version:_ &nbsp; 16.0.4115.3

## Summary

This article describes Cumulative Update package 12 (CU12) for Microsoft SQL Server 2022. This update contains 54 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 11, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4115.3**, file version: **2022.160.4115.3**
- Analysis Services - Product version: **16.0.43.222**, file version: **2022.160.43.222**
## Known issues in this update

### Read-scale availability group not displayed in dm_hadr_database_replica_cluster_states

SQL Server 2022 CU10 introduced [fix 2714261](cumulativeupdate10.md#2714261), which causes an issue with `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups that results in the **Availability Databases** folder in SQL Server Management Studio (SSMS) not showing the databases in the availability group (AG). To mitigate this issue, roll back the patch to CU9.

Microsoft is working on a fix for this issue and it will be available in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.
