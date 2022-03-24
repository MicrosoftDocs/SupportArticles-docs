---
title: Enable the snapshot transaction isolation level
description: This article describes the steps that you must follow to enable the snapshot transaction isolation level in Analysis Services.
ms.date: 09/22/2020
ms.custom: sap:Analysis Services
ms.prod: sql
---
# Enable the snapshot transaction isolation level in SQL Server 2005 Analysis Services

This article describes the steps that you must follow to enable the snapshot transaction isolation level in Analysis Services.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 919160

## Introduction

This article describes how to enable the snapshot transaction isolation level in Microsoft SQL Server Analysis Services. Additionally, this article describes how to test whether the snapshot transaction isolation level is enabled.

## Enable the snapshot transaction isolation level

In Analysis Services, you can use the snapshot transaction isolation level to connect to the SQL Server data source. To enable the snapshot transaction isolation level, follow these steps:

1. In SQL Server Management Studio, run the following statements.

    ```sql
    ALTER DATABASE <DatabaseName>
    SET READ_COMMITTED_SNAPSHOT ON
    GO
    ALTER DATABASE <DatabaseName>
    SET ALLOW_SNAPSHOT_ISOLATION ON
    GO
    ```

    > [!NOTE]
    > In these statements, `<DatabaseName>` is a placeholder for a database in the data source that you want to use in Analysis Services.

2. In Business Intelligence Development Studio, create a new Analysis Services project.

    Alternatively, open an existing Analysis Services project.

3. If you created a new Analysis Services project in step 2, follow these steps:

    1. In Solution Explorer, right-click **Data Sources**, and then click **New Data Source**.
    2. In the **Select how to define the connection** dialog box, click **New**. The **Connection Manager** dialog box appears.

   If you opened an existing Analysis Services project in step 2, follow these steps:

    1. Under the **Data Sources** folder, double-click the existing data source.
    2. In the **Data Source Designer** dialog box, click **Edit**. The **Connection Manager** dialog box appears.

4. In the **Connection Manager** dialog box, click **Native OLE DB\SQL Native Client** in the **Provider** list.

5. Specify the server name and the authentication.

6. To test the connection, click **Test Connection**.

7. In the left pane, click **All**.

8. In the right pane, click **True** in the **MARS Connection** list, and then click **OK**.

9. In the **Data Source Designer** dialog box, click **Snapshot** in the **Isolation** list, and then click **OK**.

## Test whether the snapshot transaction isolation level is enabled

To test whether the snapshot transaction isolation level is enabled, follow these steps:

1. Start SQL Server Profiler.
2. Create a new trace to connect to the data source that you specified in the Analysis Services project.
3. In the **Trace Properties** dialog box, click the **Events Selection** tab.
4. In the **TransactionID** column, click to select the check boxes in the row for the `SQL:BatchCompleted` event and in the row for the `SQL:BatchStarting` event.

    > [!NOTE]
    > To display the **TransactionID** column, click to select the **Show all columns** check box.

5. Click **Run** to start the trace.
6. In Business Intelligence Development Studio, process the Analysis Services project.
7. In SQL Server Profiler, look for the `SQL:BatchCompleted` events and for the `SQL:BatchStarting` events that have the same value in the **TransactionID** column. Typically, these events contain the `SELECT` statement in the **TextData** column. For these events, obtain the **session ID** in the **SPID** column.
8. To connect to the data source, start SQL Server Management Studio.
9. Create a new query, and then run the following Transact-SQL statement.

    ```sql
    select session_id,Transaction_Isolation_Level from sys.dm_exec_sessions
    where session_id=<SPID>
    ```

    > [!NOTE]
    > In this statement, **\<SPID>** is a placeholder for the session ID that you obtained in step 7.

10. On the **Results** tab, note the value in the **Transaction_Isolation_Level** column. This value indicates the transaction isolation level that you are using in the Analysis Services project. When the snapshot transaction isolation level is enabled, the value in the **Transaction_Isolation_Level** column is **5**. The following table shows the values in the **Transaction_Isolation_Level** column and the corresponding transaction isolation levels.

    |Value|Transaction isolation level|
    |---|---|
    |0|Unspecified|
    |1|ReadUncommitted|
    |2|ReadCommitted|
    |3|Repeatable|
    |4|Serializable|
    |5|Snapshot|

## References

For more information about the snapshot transaction isolation level, see the following topics in SQL Server 2005 Books Online:

- SET TRANSACTION ISOLATION LEVEL (Transact-SQL)
- Enabling row versioning-based isolation levels
- Isolation levels in the Database Engine
