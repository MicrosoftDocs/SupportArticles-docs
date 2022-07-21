Here are some common causes for differences in query plans:

- Data size or data values differences

  Is the same database being used on both servers—using the same database backup? Has the data been modified on one server compared to the other? Data differences can lead to different query plans. For example, joining table T1 (1000 rows) with table T2 (2,000,000 rows) is different from joining table T1 (100 rows) with table T2 (2,000,000 rows). The type and speed of the `JOIN` operation can be significantly different.

- Statistics differences

  Have [statistics](/sql/t-sql/statements/update-statistics-transact-sql) been updated on one database and not on the other? Have statistics been updated with a different sample rate (for example, 30% versus 100% full scan)? Ensure that you update statistics on both sides with the same sample rate.

- Database compatibility level differences

  Check if the compatibility levels of the databases are different between the two servers. To get the database compatibility level, run the following query:

   ```sql
   SELECT name, compatibility_level
   FROM sys.databases
   WHERE name = '<YourDatabase>'
   ```

- Server version/build differences
  
  Are the versions or builds of SQL Server different between the two servers? For example, is one server SQL Server version 2014 and the other SQL Server version 2016? There could be product changes that can lead to changes in how a query plan is selected. Make sure you compare the same version and build of SQL Server.

   ```sql
   SELECT ServerProperty('ProductVersion')
   ```

- Cardinality Estimator (CE) version differences

  Check if the legacy cardinality estimator is activated at the database level. For more information about CE, see [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server).

   ```sql
   SELECT name, value, is_value_default
   FROM sys.database_scoped_configurations
   WHERE name = 'LEGACY_CARDINALITY_ESTIMATION'
   ```

- Optimizer hotfixes enabled/disabled

  If the query optimizer hotfixes are enabled on one server but disabled on the other, then different query plans can be generated. For more information, see [SQL Server query optimizer hotfix trace flag 4199 servicing model](https://support.microsoft.com/topic/kb974006-sql-server-query-optimizer-hotfix-trace-flag-4199-servicing-model-cd3ebf5c-465c-6dd8-7178-d41fdddccc28).

  To get the state of query optimizer hotfixes, run the following query:

   ```sql
   -- Check at server level for TF 4199
   DBCC TRACESTATUS (-1)
   -- Check at database level
   USE <YourDatabase>
   SELECT name, value, is_value_default 
   FROM sys.database_scoped_configurations
   WHERE name = 'QUERY_OPTIMIZER_HOTFIXES'
   ```

- Trace flags differences

  Some trace flags affect query plan selection. Check if there are trace flags enabled on one server that aren't enabled on the other. Run the following query on both servers and compare the results:

   ```SQL
   -- Check at server level for trace flags
   DBCC TRACESTATUS (-1)
   ```

- Hardware differences (CPU count, Memory size)

  To get the hardware information, run the following query:

   ```sql
   SELECT cpu_count, physical_memory_kb/1024/1024 PhysicalMemory_GB 
   FROM sys.dm_os_sys_info
   ```

- Hardware differences according to the query optimizer

  Check the `OptimizerHardwareDependentProperties` of a query plan and see if hardware differences are considered significant for different plans.

   ```sql
   WITH xmlnamespaces(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
   SELECT
    txt.text,
    t.OptHardw.value('@EstimatedAvailableMemoryGrant', 'INT') AS EstimatedAvailableMemoryGrant , 
    t.OptHardw.value('@EstimatedPagesCached', 'INT') AS EstimatedPagesCached, 
    t.OptHardw.value('@EstimatedAvailableDegreeOfParallelism', 'INT') AS EstimatedAvailDegreeOfParallelism,
    t.OptHardw.value('@MaxCompileMemory', 'INT') AS MaxCompileMemory
   FROM sys.dm_exec_cached_plans AS cp
   CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
   CROSS APPLY qp.query_plan.nodes('//OptimizerHardwareDependentProperties') AS t(OptHardw)
   CROSS APPLY sys.dm_exec_sql_text (CP.plan_handle) txt
   WHERE text Like '%<Part of Your Query>%'
   ```

- Optimizer timeout

  Is there an [optimizer timeout](https://techcommunity.microsoft.com/t5/sql-server-support-blog/understanding-optimizer-timeout-and-how-complex-queries-can-be/ba-p/319188)? The query optimizer can stop evaluating plan options if the query being executed is too complex. When it stops, it picks the plan with the lowest cost available at the time. This can lead to an arbitrary plan choice on one server versus another.
  
- SET options

  Some SET options are plan-affecting, such as [SET ARITHABORT](/sql/t-sql/statements/set-arithabort-transact-sql#remarks). For more information, see [SET Options](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-plan-attributes-transact-sql#set-options).

- Query Hint differences

  Does one query use [query hints](/sql/t-sql/queries/hints-transact-sql-query) and the other not? Check the query text manually to establish the presence of query hints.
  
- Parameter-sensitive plans (parameter sniffing issue)

  Are you testing the query with the exact same parameter values? If not, then you may start there. Was the plan compiled earlier on one server based on a different parameter value? Test the two queries by using the RECOMPILE query hint to ensure there's no plan reuse taking place. For more information, see [Investigate and resolve parameter-sensitive issues](../../performance/troubleshoot-high-cpu-usage-issues.md#step-5-investigate-and-resolve-parameter-sensitive-issues).

- Different database options/scoped configuration settings

  Are the same database options or scoped configuration settings used on both servers? Some database options may influence plan choices. For example, database compatibility, legacy CE versus default CE, and parameter sniffing. Run the following query from one server to compare the database options used on the two servers:

   ```sql
   -- On Server1 add a linked server to Server2 
   EXEC master.dbo.sp_addlinkedserver @server = N'Server2', @srvproduct=N'SQL Server'
   
   -- Run a join between the two servers to compare settings side by side
   SELECT 
     s1.name AS srv1_config_name, 
     s2.name AS srv2_config_name,
     s1.value_in_use AS srv1_value_in_use, 
     s2.value_in_use AS srv2_value_in_use, 
     Variance = CASE WHEN ISNULL(s1.value_in_use, '##') != ISNULL(s2.value_in_use,'##') THEN 'Different' ELSE '' END
   FROM sys.configurations s1 
   FULL OUTER JOIN [server2].master.sys.configurations s2 ON s1.name = s2.name
   
   
   SELECT 
     s1.name AS srv1_config_name,
     s2.name AS srv2_config_name,
     s1.value srv1_value_in_use,
     s2.value srv2_value_in_use,
     s1.is_value_default,
     s2.is_value_default,
     Variance = CASE WHEN ISNULL(s1.value, '##') != ISNULL(s2.value, '##') THEN 'Different' ELSE '' END
   FROM sys.database_scoped_configurations s1
   FULL OUTER JOIN [server2].master.sys.database_scoped_configurations s2 ON s1.name = s2.name
   ```

- Plan guides

  Are any plan guides used for your queries on one server but not on the other? Run the following query to establish differences:

   ```sql
   SELECT * FROM sys.plan_guides
   ```
