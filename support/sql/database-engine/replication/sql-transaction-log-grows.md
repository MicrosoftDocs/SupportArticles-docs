---
title: SQL Transaction log grows continuously
description: This article helps you resolve the problem where you notice continuous transaction log growth for a CDC enabled database.
ms.date: 04/23/2025
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
---
# SQL Transaction log grows when you use Change Data Capture for Oracle by Attunity

This article helps you resolve the problem where you notice continuous transaction log growth for a CDC enabled database.

_Original product version:_ &nbsp; SQL Server 2012 and the later versions  
_Original KB number:_ &nbsp; 2871474

## Symptoms

Consider the following scenario:

- You use Microsoft SQL Server 2017 on Windows, SQL Server 2016, 2014, or 2012 Change Data Capture for Oracle by Attunity.
- You create a CDC instance to capture changes from Oracle database tables.
- The change capture values are stored in SQL Server change capture databases.
- The transaction log on the SQL Server database grows, and transactions aren't marked for truncation as data changes are captured.

In this scenario, the SQL Server database transaction log file growth accumulates and consumes too much disk space over time.

## Cause

When Change Data Capture for Oracle instances are configured, the SQL database that receives the change data will have mirrored tables, with transactions marked for replication. This behavior occurs because CDC for Oracle relies on underlying system stored procedures that resemble those that are used in CDC for SQL Server. However, because there's no SQL CDC replication involved when CDC for Oracle is used alone, there's no log reader to clear the transactions that are marked for replication. Because the transaction doesn't have to be replicated in SQL Server, it's safe to manually mark the transaction as distributed by using the workaround that's described later in this article.

To verify this exact cause, run the `DBCC OPENTRAN` command while you're connected to the SQL Server CDC database. You'll see a non-distributed LSN number as shown in the following example:

```console
Replicated Transaction Information:
Oldest distributed LSN : (0:0:0)
Oldest non-distributed LSN : (38:272:1)
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
```

You may have a non-distributed LSN because CDC for Oracle uses CDC for SQL stored procedures, and that, in turn, uses the replication log reader. This non-distributed LSN corresponds to the log entries to add the mirrored table in the Attunity CDC database.

If you run this query, the `log_reuse_wait_desc` option returns a value of `REPLICATION`, indicating the cause.

```sql
SELECT log_reuse_wait_desc FROM sys.databases WHERE name = '<your_cdc_database>'
```

## Resolution

1. Run the following command in a query window that's connected to the CDC-enabled database in SQL Server:

    ```sql
    EXEC sp_repltrans
    ```

    You should receive output that resembles the following:

    ```output
    xdesid xact_seqno xact_seqno
    0x000000260000012C0001 0x0000002A000001B50001
    ```

    Copy the LSN transaction sequence numbers for the next command.
2. Using the numbers from step 1, run the `sp_repldone` command as follows to signal that BeginTran and CommitTran LSN pairs are already replicated:

    ```sql
    sp_repldone @xactid = 0x000000260000012C0001, @xact_segno = 0x0000002A000001B50001
    ```

3. Run the following command to verify that the transaction is marked as replicated in the CDC database:

    ```sql
    DBCC OPENTRAN
    ```

    This returns output that resembles the following:

    ```output
    No active open transactions.
    DBCC execution completed. If DBCC printed error messages, contact your system administrator.
    ```

4. To make sure that the transaction log can be reused, confirm that there's no other reuse reason indicated on the database:
  
    ```sql
    SELECT log_reuse_wait_desc, NAME FROM sys.databases WHERE NAME = '<your_cdc_database>'
    ```

    This returns output that resembles the following:

    ```output
    log_reuse_wait_desc name
    NOTHING <your_cdc_database>
    ```

5. Now you should be able to truncate the Transaction log by using log backups. You should also be able to shrink the transaction log file to reduce the disk space that's consumed. For example, run the following:

    ```sql
    BACKUP LOG <your_cdc_database> TO DISK='c:\folder\logbackup.trn'
    DBCC SHRINKFILE (yourcdcdatabase_log, 1024)
    ```

For more information, see [Manage the size of the transaction log file](/previous-versions/sql/sql-server-2012/ms365418(v=sql.110)).

## More information

For more information, see
[Troubleshoot CDC instance errors in Microsoft change data capture for Oracle by Attunity](https://social.technet.microsoft.com/wiki/contents/articles/7642.troubleshoot-cdc-instance-errors-in-microsoft-change-data-capture-for-oracle-by-attunity.aspx).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
