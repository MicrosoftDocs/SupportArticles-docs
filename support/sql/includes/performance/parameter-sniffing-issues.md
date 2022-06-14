You can use the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command to free plan cache and check whether this resolves the high-CPU-usage issue. If the issue is fixed, it's an indication of a parameter-sensitive problem (PSP, also known as "parameter sniffing issue").

> [!NOTE]
> Using the `DBCC FREEPROCCACHE` without parameters removes all compiled plans from plan cache. This will cause new query executions to be compiled again, which will lead to one-time longer duration for each new query. The best approach is to use `DBCC FREEPROCCACHE (  plan_handle | sql_handle )` to identify which query may be causing the issue and then address that individual query or queries.

To mitigate the parameter-sensitive issues, use the following methods. Each method has associated tradeoffs and drawbacks.

- Use the [RECOMPILE](/sql/t-sql/queries/hints-transact-sql-query#recompile) query hint. You can add a `RECOMPILE` query hint to one or more of the high-CPU queries that are identified in [step 2](#step-2-identify-queries-contributing-to-cpu-usage). This hint helps balance the slight increase in compilation CPU usage with a more optimal performance for each query execution. For more information, see [Parameters and Execution Plan Reuse](/sql/relational-databases/query-processing-architecture-guide#PlanReuse), [Parameter Sensitivity](/sql/relational-databases/query-processing-architecture-guide#ParamSniffing) and [RECOMPILE query hint](/sql/t-sql/queries/hints-transact-sql-query/#recompile).

  Here's an example of how you can apply this hint to your query.

  ```sql
  SELECT * FROM Person.Person 
  WHERE LastName = 'Wood'
  OPTION (RECOMPILE)
  ```

- Use the [OPTIMIZE FOR](/sql/t-sql/queries/hints-transact-sql-query#optimize-for--variable_name--unknown---literal_constant-_---n--) query hint to override the actual parameter value with a more typical parameter value that covers most values in the data. This option requires a full understanding of optimal parameter values and associated plan characteristics. Here's an example of how to use this hint in your query.

  ```sql
  DECLARE @LastName Name = 'Frintu'
  SELECT FirstName, LastName FROM Person.Person 
  WHERE LastName = @LastName
  OPTION (OPTIMIZE FOR (@LastName = 'Wood'))
  ```

- Use the [OPTIMIZE FOR UNKNOWN](/sql/t-sql/queries/hints-transact-sql-query#optimize-for-unknown) query hint to override the actual parameter value with the density vector average. You can also do this by capturing the incoming parameter values in local variables, and then using the local variables within the predicates instead of using the parameters themselves. For this fix, the average density may be sufficient to provide acceptable performance.

- Use the [DISABLE_PARAMETER_SNIFFING](/sql/t-sql/queries/hints-transact-sql-query#use_hint) query hint to disable parameter sniffing completely. Here's an example of how to use it in a query:

  ```sql
  SELECT * FROM Person.Address  
  WHERE City = 'SEATTLE' AND PostalCode = 98104
  OPTION (USE HINT ('DISABLE_PARAMETER_SNIFFING'))
  ```

- Use the [KEEPFIXED PLAN](/sql/t-sql/queries/hints-transact-sql-query#keepfixed-plan) query hint to prevent recompilations in cache. This workaround assumes that the "good enough" common plan is the one that's already in cache. You can also disable automatic statistics updates to reduce the chances that the good plan will be evicted and a new bad plan will be compiled.

- Use the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command as a temporary solution until the application code is fixed. You can use the `DBCC FREEPROCCACHE (plan_handle)` command to remove only the plan that is causing the issue. For example, to find query plans that reference the `Person.Person` table in AdventureWorks, you can use this query to find the query handle. Then you can release the specific query plan from cache by using the `DBCC FREEPROCCACHE (plan_handle)` that is produced in the second column of the query results.

  ```sql
  SELECT text, 'DBCC FREEPROCCACHE (0x' + CONVERT(VARCHAR (512), plan_handle, 2) + ')' AS dbcc_freeproc_command FROM sys.dm_exec_cached_plans
  CROSS APPLY sys.dm_exec_query_plan(plan_handle)
  CROSS APPLY sys.dm_exec_sql_text(plan_handle)
  WHERE text LIKE '%person.person%'
  ```
