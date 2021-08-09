---
title: Fail to run a large batch of SQL statements
description: This article provides workarounds for the problem that occurs when you execute a large batch of SQL statements that returns many result sets.
ms.date: 11/23/2020
ms.prod-support-area-path: MDAC and ADO
ms.prod: sql
---
# SQL Server does not finish execution of a large batch of SQL statements

This article helps you resolve the problem that occurs when you execute a large batch of SQL statements that returns many result sets.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 827575

## Symptoms

When you execute a large batch of SQL statements that returns many result sets, Microsoft SQL Server may stop processing the batch before all statements in the batch are executed. The effects of this behavior depend on what operations the batch statements perform. For example, if the batch starts a transaction at the beginning and commits the transaction at the end, the commit may not occur. This behavior causes locks to be held longer than expected. This can also cause the transaction to be rolled back when the connection is closed. If the batch does not start a transaction, the symptoms of the problem may be that some statements are not executed.

When processing the results of a batch, SQL Server fills the output buffer of the connection with the result sets that are created by the batch. These result sets must be processed by the client application. If you are executing a large batch with multiple result sets, SQL Server fills that output buffer until it hits an internal limit and cannot continue to process more result sets. At that point, control returns to the client. When the client starts to consume the result sets, SQL Server starts to execute the batch again because there is now available memory in the output buffer.

## Workaround

To work around the problem, use one of the following methods:

- Method 1: Flush all the output result sets. As soon as all output result sets are consumed by the client, SQL Server completes executing the batch.

  - If you are using Open Database Connectivity (ODBC) to connect to SQL Server, you can call the `SQLMoreResults` method until the method reports that there are no more result sets.
  - If you are using OLE DB to connect to SQL Server, you can repeatedly call the IMultipleResults::GetResult method until it returns `DB_S_NORESULT`.

- Method 2: Add the statement `SET NOCOUNT ON` to the beginning of your batch. If the batch is executed inside a stored procedure, add the statement to the beginning of the stored procedure definition. This prevents SQL Server from returning many types of result sets. Therefore, it can reduce the data to be output to the output buffer of the server. However, this does not guarantee that the problem will not occur. It only increases the chance that the data that is returned from the server is small enough to fit into one batch of result sets.

> [!NOTE]
>
> - Microsoft recommends that you always consume all result sets from SQL Server regardless of the size of the batch that you are executing. If you do not flush this data and there are successful result sets to be returned ahead of the error in the result set batch, the client might not discover the server errors.
> - Client applications should flush the result sets to guarantee correct execution.

## Status

This behavior is by design.

## Steps to reproduce the problem

1. Create a SQL stored procedure in the [pubs database](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs) with a relatively large batch of database query statements. You can create a procedure that is similar to the following:

    ```sql
    create proc bigBatch as begin transaction update authors set au_fname = 'newname1' where au_id='172-32-1176' update authors set au_fname = 'newname2' where au_id='172-32-1176' update authors set au_fname = 'newname3' where au_id='172-32-1176' ... update authors set au_fname = 'newname1000' where au_id='172-32-1176' commit transaction
    ```

    > [!NOTE]
    > Replace the text "..." with the appropriate database query statements that are similar to the other database query statements in the code.

2. Create, and then configure a Data Source Name (DSN) with pubs database that connects to the SQL Server.
3. Start the **Profiler** tool that is available with SQL Server installation.
4. Create, and then start a new trace for the SQL Server from the Profiler tool.

   > [!NOTE]
   > Make sure to add the event class that is named Stored Procedure for the new SQL Profiler trace. When you do this, you can see the individual steps in the procedure when it is executed.

5. Connect to SQL Server by using ODBC. To do this, follow these steps:

   1. Open the ODBC Test tool sample that is available with the Data Access (MDAC) SDK installation.
   2. On the **Conn** menu, click **Full Connect**.
   3. In the **Full Connect** dialog box, click the name of the DSN that you created in step 2.
   4. Make sure that the connection to SQL Server is successful.
   5. On the **Stmt** menu, click **SQLExecDirect**.
   6. In the **StatementText** box, type *{call bigBatch}*, and then click **OK**.

In the analysis of SQL Profiler trace, you notice that the processing of the stored procedure is not complete. However, the ODBC Test tool indicates that the execution was successful. To fetch all the result sets and to cause the batch to finish on the server, click **Get Data All**  on the **Results** menu.
You can connect to SQL Server by using OLE DB. To do this, follow these steps:

1. Open the OLE DB RowsetViewer tool sample that is available with MDAC SDK.
2. Connect to the SQL Server pubs database by using the **Full Connect** option.
3. On the **Command** menu, point to **ICommand**, and then click **Execute**.
4. In the **Cmd Text** box, type *{call bigBatch}*.
5. Click **IID_IMultipleResults** on the **REFIID** list, and then click **Properties**.
6. In the **ICommandProperties::SetProperties** dialog box, click **DBPROP_IMultipleResults**, change the value to **VARIANT_TRUE** and then click **OK**.
7. Click **OK**.

In the analysis of SQL Profiler trace, you notice that the processing of the stored procedure is not complete. However, the RowsetViewer tool shows that the operation was successful. To retrieve all result sets, right-click the **MultipleResults** object in the left pane, point to **IMultipleResults**, and then click **GetResult**. Repeat until all result sets have been consumed.

The problem is most easily reproduced when you are connected to the SQL Server by using the Named pipes protocol or the Shared memory (LPC) protocol. This is because of the internal buffer size that SQL Server has available for the different protocols.

The following are the possible effects of this problem. The effects are varied and depend on exactly what your batch contains.

- Consider that a batch of database query statements is executed from an application. If the batch of database query statements is made up of a BEGIN TRANSACTION at the beginning and COMMIT TRANSACTION at the end, the commit operation may not occur even though the control is returned to the application. This is an issue because the locks that are possibly being held may cause a pending transaction and may remain unnoticed.

  In this scenario, because the transaction is never committed in the batch, it remains pending and is rolled back on disconnection from the SQL Server.

- If you use an application program interface (API) to begin and commit your transaction, you may see the following behavior:

  - If you use the API to send a notification to the server to start a transaction, and then you execute the batch, SQL may process only a part of the batch, and then return the control to the application.
  - After this step, if you use the API to commit the transaction, only the part of the batch that was processed is committed. No error occurs.

  For example, with ODBC you call `SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_OFF)` to start the transaction, and then you use `SQLEndTran(SQL_COMMIT)` to commit the transaction.

## References

- [Using Multiple Active Result Sets (MARS)](/sql/connect/oledb/features/using-multiple-active-result-sets-mars)

    > [!NOTE]
    > If you are using ADO, calling the `NextRecordset` method of the `Recordset` object causes the OLE DB provider to execute the `IMultipleResults::GetResult` method.

- [Using Multiple Active Result Sets (MARS) in SQL Server Native Client](/sql/relational-databases/native-client/features/using-multiple-active-result-sets-mars)

- [SET NOCOUNT (Transact-SQL)](/sql/t-sql/statements/set-nocount-transact-sql)

- [SQLMoreResults](/sql/relational-databases/native-client-odbc-api/sqlmoreresults)

- [IMultipleResults::GetResult](/previous-versions/windows/desktop/ms723081(v=vs.85))
