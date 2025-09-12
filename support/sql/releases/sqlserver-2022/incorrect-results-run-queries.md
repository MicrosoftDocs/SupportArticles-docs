---
title: Incorrect results when you run queries against tables that contain indexes
description: Fixes incorrect results that may occur when you run queries against tables that contain indexes that use a descending sort order.
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5027811
ms.reviewer: hay, fahou, abhujabala, v-cuichen
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# FIX: Incorrect results may occur when you run queries against tables that contain indexes using a descending sort order

## Symptoms

After you install SQL Server 2022 Cumulative Update 4 (CU4), you may receive incorrect results from queries that meet all the following conditions:

1. You have indexes that explicitly specify a descending sort order. Here's an example:

    ```sql
    CREATE NONCLUSTERED INDEX [nci_table_column1] ON [dbo].[table1] (column1 DESC)
    ```

2. You run queries against the tables that contain these indexes. These queries specify a sort order that matches the sort order of the indexes.

3. The sort column is used in query predicates in the `WHERE IN` clause or multiple equality clauses. Here's an example:

    ```sql
    SELECT * FROM [dbo].[table1] WHERE column1 IN (1,2) ORDER BY column1 DESC
    SELECT * FROM [dbo].[table1] WHERE column1 = 1 or column1 = 2 ORDER BY column1 DESC
    ```

    > [!NOTE]
    > The `IN` clause that has a single value doesn't have this problem.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 5 for SQL Server 2022](cumulativeupdate5.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Workaround

To work around this problem, uninstall SQL Server 2022 CU4 or enable trace flag (TF) 13166, and then run `DBCC FREEPROCCACHE`.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
