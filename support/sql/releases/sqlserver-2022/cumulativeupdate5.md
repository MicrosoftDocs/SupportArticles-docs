---
title: Cumulative update 5 for SQL Server 2022 (KB5026806)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 5 (KB5026806).
ms.date: 06/15/2023
ms.custom: KB5026806
author: Elena068
ms.author: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5026806 - Cumulative Update 5 for SQL Server 2022

_Release Date:_ &nbsp; June 15, 2023  
_Version:_ &nbsp; 16.0.4045.3

## Summary

This article describes Cumulative Update package 5 (CU5) for Microsoft SQL Server 2022. This update contains 31 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 4, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4045.3**, file version: **2022.160.4045.3**
- Analysis Services - Product version: **16.0.43.211**, file version: **2022.160.43.211**

## Known issues in this update

### Issue one

After you install this cumulative update, external data sources using the generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the Driver keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

### Issue two

After you install this cumulative update, you may receive incorrect results from queries that meet all of the following conditions:

1. You have indexes that explicitly specify the sort order. Here's an example:

    ```sql
    CREATE NONCLUSTERED INDEX [nci_table_column1] ON [dbo].[table1] (column1 DESC)
    ```

2. You run queries against tables that contain these indexes. These queries specify a sort order that matches the sort order of the indexes.

3. The sort column is used in query predicates in the `WHERE IN` clause or multiple equality clauses. Here's an example:

    ```sql
    SELECT * FROM [dbo].[table1] WHERE column1 IN (1,2) ORDER BY column1 DESC
    SELECT * FROM [dbo].[table1] WHERE column1 = 1 or column1 = 2 ORDER BY column1 DESC
    ```

    > [!NOTE]
    > The `IN` clause that has a single value doesn't have this issue.

To work around this issue, you can either uninstall this cumulative update or enable trace flag (TF) 13166 and then run `DBCC FREEPROCCACHE`.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.
