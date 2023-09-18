---
title: ASCII function returns different results in Publisher and Subscriber
description: This article provides workarounds for the issue that the ASCII function returns different results in the Publisher and Subscriber database tables.
ms.date: 01/20/2022
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: akbarf, valcan, tzakir, maarumug, v-sidong
---

# ASCII function returns different results in Publisher and Subscriber database tables

_Applies to:_&nbsp; SQL Server 2019

This article provides workarounds for the issue that the `ASCII` function returns different results in the Publisher and Subscriber database tables.

## Symptoms

Consider the following scenario:

- You use transactional or merge replication in SQL Server 2019.

- Initial schema and data are applied through the Replication Snapshot Agent.

- In the Publisher database, a column that is defined as character data type includes a NULL value - ASCII character 0 `char(0)`.

In this scenario, when you use the `ASCII` function to convert the column in the Publisher and Subscriber database tables, different results are returned. You can refer to the following sample:

- Convert the column (`col1`) in the Publisher database table:

    ```sql
    SELECT id, col1, ASCII(col1) FROM PublisherTable
    ```

    :::image type="content" source="media/ascii-function-returns-different-results-publisher-subscriber/publisher-result.png" alt-text="Screenshot of the results for the publisher table.":::

- Convert the column (`col1`) in the Subscriber database table:

    ```sql
    SELECT id, col1, ASCII(col1) FROM SubscriberTable
    ```

    :::image type="content" source="media/ascii-function-returns-different-results-publisher-subscriber/subscriber-result.png" alt-text="Screenshot of the results for the subscriber tables.":::

## Workaround

- To work around this issue for transactional replication, follow these steps:

    1. Open SQL Server Management Studio and connect to the server acting as a Distributor.

    1. Under **Object Explorer**, expand **SQL Server Agent**, and then expand **Jobs**.

    1. Select the snapshot agent job for the affected publication, right-click it, and then select **Properties** > **Steps** > **Step 2** > **Edit**.

    1. In the **Job Step Properties** window, add `-NativeBcpFileFormatVersion 100` at the end of the command and select **OK** to save the changes.

    1. Apply the latest [Microsoft OLE DB driver](/sql/connect/oledb/download-oledb-driver-for-sql-server):

        - If the distribution agent (or merge agent) runs for push subscriptions, apply it on the Distributor server.

        - If the distribution agent (or merge agent) runs for pull subscriptions, apply it on the Subscriber server.

    1. Rename the *msoledbsql.dll* file in the *C:\Program Files\Microsoft SQL Server\150\COM* folder:

        - If it's a push subscription, rename the file in the folder on the Distributor server.

        - If it's a pull subscription, rename the file in the folder on the Subscriber server.

    1. Copy the *msoledbsql.dll* file from the *C:\Windows\System32\\* folder and paste it to the *C:\Program Files\Microsoft SQL Server\150\COM* folder.

- To work around this issue for merge replication, follow these steps:

    1. Apply [SQL Server 2019 Cumulative Update 15 (CU15)](https://support.microsoft.com/help/5008996) or a later version on the Distributor server.

    1. Follow all the steps that are applied to the transactional replication issue.
