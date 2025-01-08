---
title: Troubleshoot blocking issues caused by compile locks
description: This article describes how to troubleshoot and resolve blocking issues caused by compile locks.
ms.date: 01/08/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: josephv
---
# Troubleshoot blocking issues caused by compile locks

This article describes how to troubleshoot and resolve blocking issues caused by compile locks.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 263889

## Summary

In Microsoft SQL Server, only one copy of a stored procedure plan is generally in cache at a time. Enforcing this requires serialization of some parts of the compilation process, and this synchronization is accomplished in part by using compile locks. If many connections are concurrently running the same stored procedure and a compile lock must be obtained for that stored procedure every time that it runs, session IDs (SPIDs) might begin to block one another as they each try to obtain an exclusive compile lock on the object.

The following are some typical characteristics of compile blocking that can be observed in the blocking output:

- `waittype` for the blocked and (usually) blocking session SPIDs is `LCK_M_X` (exclusive) and `waitresource` is of the form `OBJECT: dbid: object_id [[COMPILE]]`, where `object_id` is the object ID of the stored procedure.

- Blockers have `waittype` NULL, status runnable. Blocked sessions have `waittype` `LCK_M_X` (exclusive lock), status sleeping.

- Although the overall duration of the blocking incident might be long, there's no single session (SPID) that is blocking the other SPIDs for a long time. There's rolling blocking; as soon as one compilation is complete, another SPID takes over the role of head blocker for several seconds or less, and so on.

The following information is from a snapshot of `sys.dm_exec_requests` during this kind of blocking:

```console
session_id   blocking_session_id   wait_type   wait_time   waitresource 
----------   -------------------   ---------   ---------   ----------------------------
221           29                   LCK_M_X     2141        OBJECT: 6:834102 [[COMPILE]]
228           29                   LCK_M_X     2235        OBJECT: 6:834102 [[COMPILE]]
29            214                  LCK_M_X     3937        OBJECT: 6:834102 [[COMPILE]]
13            214                  LCK_M_X     1094        OBJECT: 6:834102 [[COMPILE]]
68            214                  LCK_M_X     1968        OBJECT: 6:834102 [[COMPILE]]
214           0                    LCK_M_X     0           OBJECT: 6:834102 [[COMPILE]]
```

In the `waitresource` column (6:834102), 6 is the database ID and 834102 is the object ID. This object ID belongs to a stored procedure, not to a table.

## Scenarios that lead to compile locks

The following scenarios describe the causes for exclusive compile locks on stored procedures or triggers.

### Stored Procedure is executed without Fully Qualified Name  

- The user who runs the stored procedure isn't the owner of the procedure.
- The stored procedure name isn't fully qualified with the object owner's name.

For example, if user dbo owns object `dbo.mystoredproc` and another user, `Harry`, runs this stored procedure by using the command `exec mystoredproc`, the initial cache lookup by object name fails because the object isn't owner-qualified. (It isn't yet known whether another stored procedure named `Harry.mystoredproc` exists. Therefore, SQL Server can't be sure that the cached plan for `dbo.mystoredproc` is the correct one to execute.) SQL Server then obtains an exclusive compile lock on the procedure and makes preparations to compile the procedure. This includes resolving the object name to an object ID. Before SQL Server compiles the plan, SQL Server uses this object ID to perform a more precise search of the procedure cache and can locate a previously compiled plan even without owner qualification.

If an existing plan is found, SQL Server reuses the cached plan and doesn't actually compile the stored procedure. However, the lack of owner-qualification forces SQL Server to perform a second cache lookup and obtain an exclusive compile lock before the program determines that the existing cached execution plan can be reused. Obtaining the lock and performing lookups and other work that is needed to reach this point can introduce a delay for the compile locks that leads to blocking. This is especially true if many users who aren't the stored procedure's owner, concurrently run the procedure without supplying the owner's name. Even if you don't see SPIDs waiting for compile locks, lack of owner-qualification can introduce delays in stored procedure execution and cause high CPU utilization.

The following sequence of events is recorded in a SQL Server Extended Event session when this problem occurs.

|Event Name  |Text  |
|---------|---------|
|rpc_starting|mystoredproc|
|sp_cache_miss|mystoredproc|
|sql_batch_starting|mystoredproc|
|sp_cache_hit|mystoredproc|
|...|...|

`sp_cache_miss` occurs when the cache lookup by name fails, but then a matching cached plan was ultimately found in cache after the ambiguous object name was resolved to an object ID and there's a `sp_cache_hit` event.

The solution to this problem of compile locking is to make sure that references to stored procedures are owner-qualified. (Instead of exec `mystoredproc`, use exec `dbo.mystoredproc`.) While owner-qualification is important for performance reasons, you don't have to qualify the stored proc with the database name to prevent the extra cache lookup.

Blocking that is caused by compile locks can be detected by using standard blocking troubleshooting methods.

### Stored procedure is recompiled frequently

Recompilation is one explanation for compile locks on a stored procedure or trigger. Ways to cause a stored procedure to recompile include `EXECUTE... WITH RECOMPILE`, `CREATE PROCEDURE ...WITH RECOMPILE`, or using `sp_recompile`. For more information, see [Recompile a Stored Procedure](/sql/relational-databases/stored-procedures/recompile-a-stored-procedure). The solution in this case is to reduce or to eliminate the recompilation.

### Stored procedure is prefixed with sp_**  

If your stored procedure name starts with the `sp_` prefix and it isn't in the master database, you see **sp_cache_miss**  before the cache hit for each execution even if you owner-qualify the stored procedure. This is because the `sp_` prefix tells SQL Server that the stored procedure is a system stored procedure, and system stored procedures have different name resolution rules. (The preferred location is in the master database.) The names of user-created stored procedures shouldn't start with `sp_`.

### Stored procedure is invoked using a different case (upper /lower)  

If an owner-qualified procedure is run using a different letter case (upper or lower) from the case that was used to create it, the procedure can trigger a CacheMiss event or request a COMPILE lock. To illustrate, notice the different letter case used in `CREATE PROCEDURE dbo.SalesData ...` versus `EXEC dbo.salesdata`. Eventually, the procedure uses the cached plan and isn't recompiled. But the request for a COMPILE lock can sometimes cause a **blocking chain** situation described earlier. The blocking chain can occur if there are many sessions (SPIDs) that are trying to execute the same procedure by using a different case than the case that was used to create it. This is true regardless of the sort order or collation that is being used on the server or on the database. The reason for this behavior is that the algorithm that is being used to find the procedure in cache is based on hash values (for performance), and the hash values can change if the case is different.

The solution is to drop and create the procedure by using the same letter case as the one that is used when the application executes the procedure. You can also make sure that the procedure is executed from all applications by using the correct case (upper or lower).

### Stored procedure is invoked as a Language event  

If you try to execute a stored procedure as a Language Event instead of as an RPC, SQL Server must parse and compile the language event query, determine that the query is trying to execute the particular procedure, and then try to find a plan in cache for that procedure. To avoid this situation in which SQL Server must parse and compile the language event, make sure that the query is sent to SQL Server as an RPC. For example, in .NET code, you would use `SqlCommand.CommandType.StoredProcedure` to ensure an RPC event.

### Stored procedure or sp_executesql uses a string parameter greater than 8 KB

If you call a stored procedure or [sp_executesql](/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql) and pass a string parameter with a size larger than 8 KB, SQL Server uses a binary large objects (BLOB) data type to store the parameter. As a result, the query plan for this execution isn't persisted in plan cache. Therefore, each and every execution of the stored procedure or `sp_executesql` has to acquire a compile lock to compile a new plan. This plan is discarded when execution completes. For more information, see the note in [Execution plan caching and reuse](/sql/relational-databases/query-processing-architecture-guide) regarding string literals larger than 8 KB in size. To avoid the compile lock in this scenario, reduce the size of the parameter to less than 8 KB.

## References

[OPEN SYMMETRIC KEY command prevents query plan caching](/archive/blogs/sqlserverfaq/open-symmetric-key-command-prevents-query-plan-caching)
