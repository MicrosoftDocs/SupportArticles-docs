---
title: Fix orphaned XA transactions with the JDBC Driver for SQL Server
description: Resolve orphaned XA transactions in SQL Server caused by JDBC Driver connectivity failures. Discover diagnostic queries, manual termination steps, and timeout configurations to fix the issue.
ms.date: 04/14/2026
ms.reviewer: jopilov, v-shaywood
ms.custom: sap:Database Connectivity and Authentication
---

# Orphaned XA transactions when using Microsoft JDBC Driver for SQL Server

## Summary

When you use [XA transactions](/sql/connect/jdbc/understanding-xa-transactions) with the [Microsoft JDBC Driver for SQL Server](/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server), you might find orphaned transactions that stay pending on the SQL Server. These orphaned transactions typically occur when the transaction manager crashes or loses connectivity to the SQL Server before the XA transaction completes. This article explains the symptoms, causes, diagnostic steps, and resolution strategies for orphaned XA transactions in SQL Server.

## Symptoms

You might experience one or more of the following issues:

- Transactions stay in a pending state for a long time on SQL Server.
- Transactions appear with a `NULL` or `-2` session ID in the database.
- Transactions block other transactions indefinitely, causing lock timeouts and frozen threads.

### Confirm orphaned XA transactions

To confirm orphaned XA transactions, follow these steps:

1. Query active XA transactions by using the [sys.dm_tran_active_transactions](/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-active-transactions-transact-sql) dynamic management view (DMV):

   ```sql
   SELECT transaction_id, name, transaction_state
   FROM sys.dm_tran_active_transactions
   WHERE name LIKE '%XA%';
   ```

1. Check for transactions with a session ID of `-2`, which indicates an orphaned distributed transaction:

   ```sql
   SELECT request_session_id, resource_type, resource_database_id
   FROM sys.dm_tran_locks
   WHERE request_session_id = -2;
   ```

1. Verify that the transaction meets all of the following conditions before you attempt resolution:

   - The transaction isn't in a prepared (in-doubt) state.
   - The transaction isn't completing recovery.

## Cause

If connectivity between the transaction manager and SQL Server is lost before the XA transaction is prepared, the JDBC Driver doesn't clean up these transactions. Because of the XA implementation in the JDBC Driver for SQL Server, SQL Server can't detect abnormal disconnections of transaction managers.

As a result, orphaned transactions remain active until one of the following events happens:

- The XA transaction timeout occurs. By default, SQL Server sets the timeout to infinity.
- The database restarts.

> [!NOTE]
> The XA transaction timeout isn't configurable at the SQL Server level and requires external handling.

## Solutions

Use one of the following methods to resolve orphaned XA transactions.

### Restart SQL Server

Restart SQL Server after any JVM crash or network disruption that results in orphaned transactions. A restart clears in-memory transaction references.

### Manually terminate orphaned transactions

1. Run the following query to identify and stop transactions that survive application recovery:

   ```sql
   SELECT transaction_id, name
   FROM sys.dm_tran_active_transactions
   WHERE name LIKE '%XA%';
   ```

1. After you find the IDs of the orphaned transactions, commit or roll back by using [XAResource](/sql/connect/jdbc/reference/sqlserverxaresource-class) in Java. For example:

   - **Commit**

     ```java
     XAResource xaRes = xaConnection.getXAResource();
     xaRes.commit(xaTransactionId, bOnePhase);
     ```

   - **Roll back**

     ```java
     XAResource xaRes = xaConnection.getXAResource();
     xaRes.rollback(xaTransactionId);
     ```

### Configure XA transaction timeout

Set an XA timeout to enforce automatic cleanup of orphaned transactions. The timeout value should be longer than your longest-running transaction. For example:

```java
XAResource xaRes = xaConnection.getXAResource();
xaRes.setTransactionTimeout(600); // Timeout in seconds
```

> [!NOTE]
> Many third-party transaction managers don't expose [XAResource](/sql/connect/jdbc/reference/sqlserverxaresource-class). In these cases, use an external management app to set a default timeout value globally.

## Preventive best practices

Follow these guidelines to reduce the risk of orphaned XA transactions:

- Make sure that the MS DTC service is running and configured for XA on all participating nodes.
- Apply MS DTC security settings and enable XA Transactions in `dcomcnfg`.
- Use [JDBC XA properties](/sql/connect/jdbc/setting-the-connection-properties):

  ```properties
  xaTransactionTimeout=600
  loginTimeout=30
  ```

## Related content

- [Performing transactions with the JDBC driver](/sql/connect/jdbc/performing-transactions-with-the-jdbc-driver)
- [JDBC configuration and troubleshooting](jdbc-config-troubleshoot.md)
- [SQLServerXAConnection class](/sql/connect/jdbc/reference/sqlserverxaconnection-class)
