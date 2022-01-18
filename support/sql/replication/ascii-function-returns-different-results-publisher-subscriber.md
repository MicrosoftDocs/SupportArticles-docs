---
title: ASCII function returns different results in publisher and subscriber
description: This article provides workarounds for the problem where ASCII function returns different results in the publisher and subscriber database tables.
ms.date: 01/20/2022
ms.prod-support-area-path: Replication, change tracking, change data capture
author: sevend2
ms.author: v-sidong
ms.reviewer: akbarf, valcan, tzakir, maarumug
ms.prod: sql
---

# ASCII function returns different results in publisher and subscriber database tables

_Applies to:_ &nbsp; SQL Server 2019

This article provides workarounds for the problem where `ASCII` function returns different results in the publisher and subscriber database tables.

## Symptoms

Consider the following scenario:

- You use transactional or merge replication in SQL Server 2019.

- Initial schema and data are applied through Snapshot Agent.

- In the publisher database, the column that is defined as character data type includes a value of `char(0)`.

In this scenario, when you use the `ASCII` function to convert the column from the publisher and subscriber database tables, different results are returned. You can refer to the following sample:

- Publisher database table

    ```sql
    SELECT id, col1, ASCII(col1) FROM PublisherTable
    ```

    :::image type="content" source="media/ascii-conversion-shows-different-results-publisher-subscriber/publisher-result.png" alt-text="Screenshot of the results for the publisher table.":::

- Subscriber database table

    ```sql
    SELECT id, col1, ASCII(col1) FROM SubscriberTable
    ```

    :::image type="content" source="media/ascii-conversion-shows-different-results-publisher-subscriber/subscriber-result.png" alt-text="Screenshot of the results for the subscriber tables.":::

## Workaround

- To work around this issue for transactional replication, follow these steps:

    1. Open SQL Server Management Studio.

    1. Under **Object Explorer**, expand **SQL Server Agent**.

    1. Right-click **Jobs**, select **New Job...** > **Steps** > **Step 2**, and then select **Edit**.

    1. In the **Job Step Properties** window, add `-NativeBcpFileFormatVersion 100` at the end of command.

    1. If the distribution agent runs for push subscriptions, apply the latest [Microsoft OLE DB driver](/sql/connect/oledb/download-oledb-driver-for-sql-server) on the distributor server. If the distribution agent runs for pull subscriptions, apply the [OLE DB driver](/sql/connect/oledb/download-oledb-driver-for-sql-server) on the subscriber.

    1. Rename *msoledbsql.dll* present in *C:\Program Files\Microsoft SQL Server\150\COM* and paste latest version of *msoledbsql.dll* from *c:\Windows\System32\\* to *C:\Program Files\Microsoft SQL Server\150\COM*.

- To work around this issue for merge replication, follow these steps:

    1. Apply [SQL Server 2019 Cumulative Update 15 (CU15)](https://support.microsoft.com/help/5008996) or a later version on the distributor server.

    1. Follow all of the preceding steps applied to transactional replication issue.
