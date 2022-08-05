### Type 1: CPU-bound (runner)

If the CPU time is close, equal to, or higher than the elapsed time, you can treat it as a CPU-bound query. For example, if the elapsed time is 3000 milliseconds (ms) and the CPU time is 2900 ms, that means most of the elapsed time is spent on the CPU. Then we can say it's a CPU-bound query.

> [!Note]
> If the CPU time is greater than the duration, then a parallel query was being executed while multiple threads were using the CPU at the same time when the clock was ticking. For more information, see [Parallel queries - runner or waiter](#parallel-queries---runner-or-waiter).

### Type 2: Waiting on a bottleneck (waiter)

A query is waiting on a bottleneck if the elapsed time is significantly greater than the CPU time. The elapsed time includes the time executing the query on the CPU (CPU time) and the time waiting for a resource to be released (wait time). For example, if the elapsed time is 2000 ms and the CPU time is 300 ms, the wait time is 1700 ms (2000 - 300 = 1700). For more information, see [Types of Waits](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#WaitTypes).

### Parallel queries - runner or waiter

Parallel queries may use more CPU time than the overall duration. The goal of parallelism is to allow multiple threads to run parts of a query simultaneously. In one second of clock time, a query may use eight seconds of CPU time by executing eight parallel threads. Therefore, it becomes challenging to determine a CPU-bound or a waiting query based on the elapsed time and CPU time difference. However, as a general rule, follow the principles listed in the above two sections. The summary is:

- If the elapsed time is much greater than the CPU time, consider it a waiter.
- If the CPU time is much greater than the elapsed time, consider it a runner.
