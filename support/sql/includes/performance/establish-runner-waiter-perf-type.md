### Type 1: CPU-bound (runner)

If the CPU time is close, equal to, or higher than the elapsed time, you can treat it as a CPU-bound query. For example, if the elapsed time is 3000 milliseconds (ms) and the CPU time is 2900 ms, that means most of the elapsed time is spent on the CPU. Then we can say it's a CPU-bound query.

Examples of running (CPU-bound) queries:

|Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|-----------------|-------------|---------------|
|   3200          | 3000        | 300000        |
|   1080          | 1000        |     20        |

Logical reads - reading data/index pages in cache - are most frequently the drivers of CPU utilization in SQL Server. There could be scenarios where CPU use comes from other sources: a while loop (in T-SQL or other code like XProcs or SQL CRL objects). The second example in the table illustrates such a scenario, where the majority of the CPU is not from reads.

> [!Note]
> If the CPU time is greater than the duration, this indicates a parallel query is executed; multiple threads are using the CPU at the same time. For more information, see [Parallel queries - runner or waiter](#parallel-queries---runner-or-waiter).

### Type 2: Waiting on a bottleneck (waiter)

A query is waiting on a bottleneck if the elapsed time is significantly greater than the CPU time. The elapsed time includes the time executing the query on the CPU (CPU time) and the time waiting for a resource to be released (wait time). For example, if the elapsed time is 2000 ms and the CPU time is 300 ms, the wait time is 1700 ms (2000 - 300 = 1700). For more information, see [Types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).


Examples of waiting queries:

|Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|-----------------|-------------|---------------|
|   2000          | 300        | 28000        |
|   10080         | 700        | 80000       |


### Parallel queries - runner or waiter

Parallel queries may use more CPU time than the overall duration. The goal of parallelism is to allow multiple threads to run parts of a query simultaneously. In one second of clock time, a query may use eight seconds of CPU time by executing eight parallel threads. Therefore, it becomes challenging to determine a CPU-bound or a waiting query based on the elapsed time and CPU time difference. However, as a general rule, follow the principles listed in the above two sections. The summary is:

- If the elapsed time is much greater than the CPU time, consider it a waiter.
- If the CPU time is much greater than the elapsed time, consider it a runner.

Examples of Parallel queries:

|Elapsed Time (ms)|CPU Time (ms)|Reads (logical)|
|-----------------|-------------|---------------|
|   1200          | 8100        | 850000        |
|   3080          | 12300       | 1500000       |
