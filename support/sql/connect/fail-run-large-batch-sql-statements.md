---
title: Fail to run a large batch of SQL statements
description: This article provides workarounds for the problem that occurs when you execute a large batch of SQL statements that returns multiple result sets.
ms.date: 07/14/2023
ms.custom: sap:MDAC and ADO
ms.reviewer: jopilov
---
# SQL Server doesn't finish execution of a large batch of SQL statements

This article helps you resolve the problem that occurs when you execute a large batch of SQL statements that returns multiple result sets.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 827575

## Symptoms

When you execute a large batch of SQL statements that returns multiple result sets, Microsoft SQL Server may stop processing the batch before all statements in the batch are executed. The effects of this behavior depend on what operations the batch statements perform. For example, if the batch starts a transaction at the beginning and commits the transaction at the end, the commit may not occur. This behavior causes locks to be held longer than expected. This can also cause the transaction to be rolled back when the connection is closed. If the batch doesn't start a transaction, the symptoms of the problem may be that some statements aren't executed.

The following are the possible effects of this problem. The effects are varied and depend on exactly what your batch contains.

- Consider that a batch of database query statements is executed from an application. If the batch of database query statements is made up of a `BEGIN TRANSACTION` at the beginning and `COMMIT TRANSACTION` at the end, the commit operation may not occur even though the control is returned to the application. This is an issue because the locks that are possibly being held may cause a pending transaction and may remain unnoticed.

  In this scenario, because the transaction is never committed in the batch, it remains pending and is rolled back on disconnection from the SQL Server.

- If you use an application program interface (API) to begin and commit your transaction, you may see the following behavior:

  - If you use the API to send a notification to the server to start a transaction, and then you execute the batch, SQL may process only a part of the batch, and then return the control to the application.
  - After this step, if you use the API to commit the transaction, only the part of the batch that was processed is committed. No error occurs.

  For example, with ODBC you call `SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_OFF)` to start the transaction, and then you use `SQLEndTran(SQL_COMMIT)` to commit the transaction.

## Cause

When processing the results of a batch, SQL Server fills the connection output buffer with the results that come from the batch. These results must be processed by the client application. If you're executing a large batch with multiple result sets (multiple statements producing results), SQL Server fills that output buffer until it hits an internal limit and can't continue until the client application starts consuming those results. When the client starts to consume the result sets, SQL Server starts to execute the batch again because there's now available memory in the output buffer. This behavior is by design.

In many cases, you encounter this problem when you connect to the SQL Server by using the Named pipes protocol or the Shared memory (LPC) protocol. This is because of the internal buffer size that SQL Server has available for the different protocols.

## Workaround

To work around the problem, follow these steps:

1. Ensure that the client application consumes all the output result sets. As soon as all output result sets are consumed by the client, SQL Server completes executing the batch.

    - If you're using Open Database Connectivity (ODBC) to connect to SQL Server, you can call the `SQLMoreResults` method until the method reports that there are no more result sets.
    - If you're using OLE DB to connect to SQL Server, you can repeatedly call the IMultipleResults::GetResult method until it returns `DB_S_NORESULT`.

1. Add the statement `SET NOCOUNT ON` to the beginning of your batch. If the batch is executed inside a stored procedure, add the statement to the beginning of the stored procedure definition. This prevents SQL Server from returning an additional result set that shows the number of rows processed, after the main result set. Therefore, it can reduce the data to be output to the output buffer of the server. However, this doesn't guarantee that the problem won't occur. It only increases the chance that the data returned from the server is small enough to fit into one batch of result sets.

We recommend that your client application always consumes all result sets coming from SQL Server regardless of the size of the batch that you are executing. If you do not process this data and there are successful result sets to be returned ahead of an error in the result set batch, the client might not discover the server errors.  Client applications should process the result sets in their entirety to guarantee correct execution.

## Steps to reproduce the problem

1. Connect to SQL Server by using SQL Server Management Studio (SSMS) and create a sample [pubs database](https://github.com/Microsoft/sql-server-samples/tree/main/samples/databases/northwind-pubs).
1. Create a SQL stored procedure in `pubs` with a relatively large batch of database query statements, like the following:

    ```sql
    CREATE PROC bigBatch AS
    BEGIN TRANSACTION
    UPDATE authors SET au_fname = 'newname1' WHERE au_id='172-32-1176'
    UPDATE authors SET au_fname = 'newname2' WHERE au_id='172-32-1176'
    UPDATE authors SET au_fname = 'newname3' WHERE au_id='172-32-1176'
    -- Add more UPDATE statements here ... 
    UPDATE authors SET au_fname = 'newname1000' WHERE au_id='172-32-1176'
    COMMIT TRANSACTION
    ```

1. In **Object Explorer**, select **Management** > **Extended Events**.
1. Right-click **Sessions**, and then select **New Session Wizard**.
1. Create a new event session by using the _TSQL\_SPs_ session template.
1. Start the session and watch the live data. For more information, see [Quickstart: Extended events in SQL Server](/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server).
1. Connect to SQL Server with ODBC or OLE DB, run `bigBatch`, and then analysis the live data of the event session.

### Connect with ODBC

To connect to SQL Server by using ODBC, follow these steps:

1. Create, and then configure a Data Source Name (DSN) with `pubs` database that connects to the SQL Server.
1. Open the [ODBC Test](/sql/odbc/odbc-test) tool sample that is available with the Data Access (MDAC) SDK installation.
1. On the **Conn** menu, select **Full Connect**.
1. In the **Full Connect** dialog box, select the DSN that you created in step 1.
1. Make sure that the connection to SQL Server is successful.
1. On the **Stmt** menu, select **SQLExecDirect**.
1. In the **StatementText** box, type _{call bigBatch}_, and then select **OK**.

In the XEvent live data, you notice that the processing of the stored procedure isn't complete. However, the ODBC Test tool indicates that the execution was successful. To fetch all the result sets and to cause the batch to finish on the server, select **Get Data All** on the **Results** menu.

### Connect with OLE DB

To connect to SQL Server by using OLE DB, follow these steps:

1. Open the OLE DB RowsetViewer tool sample that is available with MDAC SDK.
1. Connect to the SQL Server `pubs` database by using the **Full Connect** option.
1. On the **Command** menu, point to **ICommand**, and then select **Execute**.
1. In the **Cmd Text** box, type _{call bigBatch}_.
1. Select **IID_IMultipleResults** on the **REFIID** list, and then select **Properties**.
1. In the **ICommandProperties::SetProperties** dialog box, select **DBPROP_IMultipleResults**, change the value to **VARIANT_TRUE** and then select **OK**.
1. Select **OK**.

In the XEvent live data, you notice that the processing of the stored procedure isn't complete. However, the RowsetViewer tool shows that the operation was successful. To retrieve all result sets, right-click the **MultipleResults** object in the left pane, point to **IMultipleResults**, and then select **GetResult**. Repeat until all result sets have been consumed.

## References

- [Using Multiple Active Result Sets (MARS)](/sql/connect/oledb/features/using-multiple-active-result-sets-mars)

  **Note:** If you're using ADO, calling the `NextRecordset` method of the `Recordset` object causes the OLE DB provider to execute the `IMultipleResults::GetResult` method.

- [Using Multiple Active Result Sets (MARS) in SQL Server Native Client](/sql/relational-databases/native-client/features/using-multiple-active-result-sets-mars)

- [SET NOCOUNT (Transact-SQL)](/sql/t-sql/statements/set-nocount-transact-sql)

- [SQLMoreResults](/sql/relational-databases/native-client-odbc-api/sqlmoreresults)

- [IMultipleResults::GetResult](/previous-versions/windows/desktop/ms723081(v=vs.85))
