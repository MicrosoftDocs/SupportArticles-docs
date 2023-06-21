---
title: Troubleshoot blocking issues caused by compile locks
description: This article describes how to troubleshoot and resolve blocking issues caused by compile locks.
ms.date: 09/25/2020
ms.custom: sap:Performance
---
# Troubleshoot blocking issues caused by compile locks

This article describes how to troubleshoot and resolve blocking issues caused by compile locks.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 263889

## Summary

In Microsoft SQL Server, only one copy of a stored procedure plan is generally in cache at a time. Enforcing this requires serialization of some parts of the compilation process, and this synchronization is accomplished in part by using compile locks. If many connections are concurrently running the same stored procedure and a compile lock must be obtained for that stored procedure every time that it runs, session IDs (SPIDs) might begin to block one another as they each try to obtain an exclusive compile lock on the object.

The following are some typical characteristics of compile blocking that can be observed in the blocking output:

- `waittype` for the blocked and (usually) blocking session SPIDs is `LCK_M_X` (exclusive) and `waitresource` is of the form `OBJECT: dbid: object_id [[COMPILE]]`, where `object_id` is the object ID of the stored procedure.

- Blockers have `waittype` NULL, status runnable. Blockees have `waittype` `LCK_M_X` (exclusive lock), status sleeping.

- Although the duration of the blocking incident may be long, there is no single SPID that is blocking the other SPIDs for a long time. There is rolling blocking. As soon as one compilation is complete, another SPID takes over the role of head blocker for several seconds or less, and so on.

The following information is from a snapshot of `sys.dm_exec_requests` during this kind of blocking:

```console
session_id   blocking_session_id   wait_type   wait_time   waitresource ---------- ------------------- --------- --------- ----------------------------
221           29                   LCK_M_X     2141        OBJECT: 6:834102
[[COMPILE]]
228           29                   LCK_M_X     2235        OBJECT: 6:834102
[[COMPILE]]
29            214                  LCK_M_X     3937        OBJECT: 6:834102
[[COMPILE]]
13            214                  LCK_M_X     1094        OBJECT: 6:834102
[[COMPILE]]
68            214                  LCK_M_X     1968        OBJECT: 6:834102
[[COMPILE]]
214           0                    LCK_M_X     0           OBJECT: 6:834102
[[COMPILE]]
```

In the `waitresource` column (6:834102), 6 is the database ID and 834102 is the object ID. This object ID belongs to a stored procedure, not to a table.

## More information

Stored procedure recompilation is one explanation for compile locks on a stored procedure or trigger. The solution in this case is to reduce or to eliminate the recompiles.

## Additional Scenarios that lead to compile locks

1. **Stored Procedure is executed without Fully Qualified Name**  

   - The user who runs the stored procedure is not the owner of the procedure.
   - The stored procedure name is not fully qualified with the object owner's name.

   For example, if user dbo owns object `dbo.mystoredproc` and another user, `Harry`, runs this stored procedure by using the command `exec mystoredproc`, the initial cache lookup by object name fails because the object is not owner-qualified. (It is not yet known whether another stored procedure named `Harry.mystoredproc` exists. Therefore, SQL Server cannot be sure that the cached plan for `dbo.mystoredproc` is the correct one to execute.) SQL Server then obtains an exclusive compile lock on the procedure and makes preparations to compile the procedure. This includes resolving the object name to an object ID. Before SQL Server compiles the plan, SQL Server uses this object ID to perform a more precise search of the procedure cache and can locate a previously compiled plan even without owner qualification.

   If an existing plan is found, SQL Server reuses the cached plan and does not actually compile the stored procedure. However, the lack of owner-qualification forces SQL Server to perform a second cache lookup and obtain an exclusive compile lock before the program determines that the existing cached execution plan can be reused. Obtaining the lock and performing lookups and other work that is needed to reach this point can introduce a delay for the compile locks that leads to blocking. This is especially true if many users who are not the stored procedure's owner concurrently run the procedure without supplying the owner's name. Even if you do not see SPIDs waiting for compile locks, lack of owner-qualification can introduce delays in stored procedure execution and cause high CPU utilization.

   The following sequence of events will be recorded in a SQL Server Extended Event session when this problem occurs.

    |Event Name|Text|
    |---|---|
    |rpc_starting|mystoredproc|
    |sp_cache_miss|mystoredproc|
    |sql_batch_starting|mystoredproc|
    |sp_cache_hit|mystoredproc|
    |...|...|

   `sp_cache_miss` occurs when the cache lookup by name fails, but then a matching cached plan was ultimately found in cache after the ambiguous object name was resolved to an object ID and there is a `sp_cache_hit` event.

   The solution to this problem of compile locking is to make sure that references to stored procedures are owner-qualified. (Instead of exec `mystoredproc`, use exec `dbo.mystoredproc`.) While owner-qualification is important for performance reasons, you do not have to qualify the stored proc with the database name to prevent the additional cache lookup.

   Blocking that is caused by compile locks can be detected by using standard blocking troubleshooting methods.

2. **Stored procedure is prefixed with sp_**  

   If your stored procedure name starts with the `sp_` prefix and is not in the master database, you see **sp_cache_miss**  before the cache hit for each execution even if you owner-qualify the stored procedure. This is because the `sp_` prefix tells SQL Server that the stored procedure is a system stored procedure, and system stored procedures have different name resolution rules. (The preferred location is in the master database.) The names of user-created stored procedures should not start with `sp_`.

3. **Stored procedure is invoked using a different case (upper /lower)**  

   If an owner-qualified procedure is executed by using a different case (upper or lower) from the case that was used to create it, the procedure can trigger a CacheMiss event or request a COMPILE lock. Eventually, the procedure uses the cached plan and is not recompiled. But the request for a COMPILE lock can sometimes cause a **blocking chain** situation if there are many SPIDs that are trying to execute the same procedure by using a different case than the case that was used to create it. This is true regardless of the sort order or collation that is being used on the server or on the database. The reason for this behavior is that the algorithm that is being used to find the procedure in cache is based on hash values (for performance), and the hash values can change if the case is different.

   The workaround is to drop and create the procedure by using the same case as the one that is used when the application executes the procedure. You can also make sure that the procedure is executed from all applications by using the correct case (upper or lower).

4. **Stored procedure is invoked as a Language event**  

   If you try to execute a stored procedure as a Language Event instead of as an RPC, SQL Server must parse and compile the language event query, determine that the query is trying to execute the particular procedure, and then try to find a plan in cache for that procedure. To avoid this situation in which SQL Server must parse and compile the language event, make sure that the query is sent to SQL as an RPC.

   For more information, see the **System Stored Procedures** section in the Books Online article **Creating a Stored Procedure**.

## References

[OPEN SYMMETRIC KEY command prevents query plan caching](/archive/blogs/sqlserverfaq/open-symmetric-key-command-prevents-query-plan-caching)
