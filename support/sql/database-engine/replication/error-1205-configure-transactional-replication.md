---
title: Error 1205 when you configure replication
description: This article provides resolutions for the problem that occurs when you configure transactional replication in SQL Server.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: holgerl
---

# Error 1205 when you configure transactional replication

This article helps you resolve a problem that occurs when you configure transactional replication in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2674882

## Symptoms

Consider the following scenario:

- You configure transactional replication in SQL Server.
- The transactional replication topology consists of several publishers.
- The publishers replicate data into the same subscriber database.
- The distribution agents run continuously or run on a frequent schedule. For example, the distribution agents run every minute.

In this scenario, the distribution agents may be involved in a deadlock scenario and may be selected as a deadlock victim. When this issue occurs, you may receive an error message that resembles the following:

> Error 1205  
Transaction (Process ID %d) was deadlocked on %.*ls resources with another process and has been chosen as the deadlock victim. Rerun the transaction.

If you enable trace flag 1222 to redirect the deadlock information into the SQL Server Error Log, you receive an error message that resembles one of the following:

- > update MSreplication_subscriptions set transaction_timestamp = cast(@P1 as binary(15)) + cast(case datalength(transaction_timestamp) when 16 then isnull(substring(transaction_timestamp, 16, 1), 0) else 0 end as binary(1)), "time" = @P2 where UPPER(publisher) = UPPER(@P3) and publisher_db = @P4 and publication = @P5 and subscription_type = 0

- > update MSreplication_subscriptions set transaction_timestamp = cast(@P1 as binary(15)) + cast(substring(transaction_timestamp, 16, 1) as binary(1)), "time" = @P2 where UPPER(publisher) = UPPER(@P3) and publisher_db = @P4 and publication = @P5 and subscription_type = 0 and (substring(transaction_timestamp, 16, 1) = 0 or datalength(transaction_timestamp) < 16)

## Cause

This issue occurs if the rowcount estimate for the number `MSreplication_subscriptions` system table is incorrect. If the rowcount estimate is incorrect, the SQL Server database engine may use an incorrect method to update the database.

> [!NOTE]
> Typically, the correct rowcount estimate is equal to the number of subscriptions in the database. If you use the Subscription Streams feature, the rowcount estimate is equal to the number of subscriptions multiplied by the number of configured streams for each subscription.

## Resolution

To resolve this issue, use one of the following methods.

- Method 1: Use the `DBCC UPDATEUSAGE` command.

    To resolve this issue, update the incorrect rowcount value. To do this, run the following command:

    ```sql
    DBCC UPDATEUSAGE (**subscriber_database_name** **,**'MSreplication_subscriptions') WITH COUNT_ROWS
    ```

    > [!NOTE]
    > The `DBCC UPDATEUSAGE` command determines the correct values for rows, used pages, reserved pages, leaf pages, and data page counts for each partition in a table. If these values are correct, the `DBCC UPDATEUSAGE` command returns no data. If inaccurate values are found and corrected, `DBCC UPDATEUSAGE` returns the rows and columns that are updated.

- Method 2: Use the `ALTER INDEX` statement.

    To resolve this issue, rebuild the indexes that are associated with the `MSreplication_subscriptions` table. To do this, use the following statement:

    ```sql
    ALTER INDEX ALL ON [dbo].[MSreplication_subscriptions] REBUILD
    ```

## More information

When the issue that's mentioned in the [Symptoms](#symptoms) section occurs, the rowcount estimate for the `MSreplication_subscriptions` system table can be as high as **4,294,967,296**. To check the rowcount value, use one of the following methods.

- Method 1: Use SQL Server Management Studio.

    To use SQL Server Management Studio to check the rowcount value for the `MSreplication_subscriptions` system table, follow these steps:

    1. Start SQL Server Management Studio, and then connect to the subscriber server instance.
    1. Expand **Databases**, and then expand the subscriber database.
    1. Expand **Tables**, and then expand **System Tables**.
    1. Right-click **dbo.MSreplication_subscriptions**, and then select **Properties**.
    1. Select **Storage**, and then verify the rowcount value in the **Row count** field.

- Method 2: Use a query statement.

    To check the rowcount value for the `MSreplication_subscriptions` system table, run the following query:

    ```sql
    SELECT rows, * FROM sys.partitions WHERE object_id = object_id('MSreplication_subscriptions')
    ```

## References

- For more information about detecting and ending deadlocks, see [Detecting and Ending Deadlocks](/previous-versions/sql/sql-server-2008-r2/ms178104(v=sql.105))
- For more information about the `ALTER` statement, see [Transact-SQL statements](/sql/t-sql/statements/statements)
- For more information about the `DBCC UPDATEUSAGE` command, see [DBCC UPDATEUSAGE (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-updateusage-transact-sql)
