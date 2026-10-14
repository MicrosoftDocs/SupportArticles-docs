---
title: Troubleshoot SQL Server Performance After a Version Upgrade
description: Diagnose and resolve SQL Server performance problems after a version upgrade caused by environment, application, configuration, optimizer, or storage changes.
ms.date: 10/02/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov, prmadhes, shaunbe, jaferebe
ai-usage: ai-assisted
---

# SQL Server performance is slower after a version upgrade

_Applies to:_ &nbsp; SQL Server

## Summary

This article helps you troubleshoot SQL Server performance problems, such as slower queries, higher CPU usage, increased waits, or changed query plans, that appear after you upgrade to a newer major version. The cause might be a simultaneous server or hardware migration, an edition change, an application or workload change, a configuration difference, a database compatibility level or cardinality estimator change, a storage engine behavior change, or a defect that's fixed in a later cumulative update (CU). It explains how to compare pre-upgrade and post-upgrade baselines by using SQL LogScout, SQL Nexus, and Query Store, identify what changed instead of relying on timing alone, and apply the resolution that matches the evidence.

## Symptoms

After upgrading SQL Server, you might notice one or more of the following symptoms:

| Symptom | Start with |
| --- | --- |
| Most or all applications, databases, or queries are slower | [Causes of widespread performance problems](#causes-of-widespread-performance-problems) |
| CPU, memory usage, I/O latency, or waits increased across the instance | [Causes of widespread performance problems](#causes-of-widespread-performance-problems) |
| The application is slower, but queries are fast when tested directly on SQL Server | [Causes of widespread performance problems](#causes-of-widespread-performance-problems) |
| CPU or login latency increased for SQL-authenticated connections after upgrading to SQL Server 2025 | [Causes of widespread performance problems](#causes-of-widespread-performance-problems) |
| Server-side execution is normal, but client requests, bulk loads, or metadata calls are slower | [Causes of widespread performance problems](#causes-of-widespread-performance-problems) |
| Only certain queries, procedures, or reports are slower | [Causes of query-specific performance problems](#causes-of-query-specific-performance-problems) |
| Query plans changed after the upgrade | [Causes of query-specific performance problems](#causes-of-query-specific-performance-problems) |
| Performance changed after raising the database compatibility level | [Causes of query-specific performance problems](#causes-of-query-specific-performance-problems) |
| Transaction log throughput, checkpoint activity, recovery, or `tempdb` performance changed | [Causes of storage and operational performance problems](#causes-of-storage-and-operational-performance-problems) |
| Backups, restores, DBCC checks, index maintenance, or data loads are slower | [Causes of storage and operational performance problems](#causes-of-storage-and-operational-performance-problems) |
| Blocking, latch contention, or concurrency problems increased | [Causes of storage and operational performance problems](#causes-of-storage-and-operational-performance-problems) |
| Availability group redo, replication snapshot or reinitialization, full-text, or columnstore operations are slower | [Causes of storage and operational performance problems](#causes-of-storage-and-operational-performance-problems) |

## Cause

Don't assume that the new SQL Server version caused the performance decrease. First identify what became slower, compare equivalent workloads, and determine what else changed during the upgrade.

### Identify what became slower

Determine whether the performance problem affects most workloads, specific queries, or storage and operational activity. Then identify where the extra time is spent, such as CPU, I/O, memory, blocking, network, compilation, or worker-thread waits. Test one change at a time under a representative workload.

### Capture a performance baseline

Whenever possible, collect a baseline while the source version is processing a representative production workload. Choose the method that best matches the problem; you don't ordinarily need to use both.

#### Option 1: Use SQL LogScout for a broad performance problem

Run [SQL LogScout](https://github.com/microsoft/SQL_LogScout#readme) by using the `DetailedPerf` scenario. This scenario collects information that's useful for a version-to-version comparison, including:

- SQL Server version, edition, and build
- Server and database configuration
- Trace flags and database-scoped configurations
- Hardware and operating system information
- Wait statistics and Performance Monitor counters
- Query execution activity and plans
- Query Store data
- SQL Server error logs

Run the collection for a bounded period that includes the problem workload. Save the output outside the SQL Server installation path so it remains available after the upgrade. After the upgrade, run the same scenario during a comparable workload period.

Import the pre-upgrade and post-upgrade SQL LogScout `DetailedPerf` collections into separate [SQL Nexus](https://github.com/microsoft/SqlNexus) databases. Compare them by using the [performance comparison reports](https://github.com/microsoft/SqlNexus/wiki/Reports-via-SQL-Queries#performance-comparison-between-two-log-collections-slow-and-fast-for-example) or [AI-assisted analysis](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run). Designate the pre-upgrade collection as the fast run and the post-upgrade collection as the slow run.

#### Option 2: Use Query Store for slow queries

Enable [Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) before the upgrade and allow it to capture a representative workload. Query Store retains query text, plans, and runtime statistics that can identify plan changes after the upgrade.

Follow the recommended compatibility-level upgrade workflow in [Change the database compatibility mode and use Query Store](/sql/database-engine/install-windows/change-the-database-compatibility-mode-and-use-the-query-store). This workflow separates the Database Engine upgrade from query processor changes that are enabled by a newer database compatibility level.

> [!IMPORTANT]
> Verify that Query Store captured the important workload before the upgrade. Enabling it immediately before the upgrade without collecting a representative workload doesn't provide a useful baseline.

#### Use historical data if no baseline exists

If no baseline exists, use application telemetry, monitoring history, job history, previous execution plans, and historical Query Store data. Compare these sources over equivalent time periods and workload volumes.

### Inventory changes made during the upgrade

Treat the upgrade as a change window, not as a single change. Record whether any of the following items changed:

- SQL Server major version, CU, or operating system
- SQL Server edition, especially a downgrade from Enterprise edition to Standard, Web, or Express edition
- Physical server, VM size, CPU topology, memory, virtualization host, or power plan
- Storage tier, SAN path, disk layout, sector size, drivers, firmware, antivirus, or filter drivers
- Database file placement, file size, autogrowth, or `tempdb` layout
- Application version, database driver or provider, protocol or encryption settings, connection string, connection pooling, authentication method, retry logic, command timeout, or session `SET` options
- Query text, parameters, workload volume, concurrency, batch frequency, or data distribution
- Server configuration, trace flags, startup parameters, Resource Governor, or service accounts
- Database compatibility level, database-scoped configuration, recovery model, Query Store settings, or statistics
- High availability, replication, backup, monitoring, auditing, antivirus, endpoint protection, or other filter software

When several items changed together, reproduce or test them independently when possible. Don't use a broad rollback as the first diagnostic test because it doesn't identify which change caused the performance problem.

Hardware, operating system, application, driver, workload, and storage changes often occur in the same maintenance window as the upgrade. Use the following tables to connect the symptoms to likely causes and the relevant solution steps.

### Causes of widespread performance problems

| Common cause | Typical signs | Go to |
| --- | --- | --- |
| Server or hardware change | Most workloads are slower, or CPU, memory, storage latency, or operating system counters differ under equivalent load | [Compare server and hardware characteristics](#step-2-compare-server-and-hardware-characteristics) |
| SQL Server edition change | The target edition has different capacity limits or capabilities | [Compare server and hardware characteristics](#step-2-compare-server-and-hardware-characteristics) |
| Application or workload change | Request text, parameters, session options, connection count, retries, data volume, or concurrency changed | [Determine where the extra time is spent](#step-1-determine-where-the-extra-time-is-spent) |
| Client driver or protocol change | Server-side duration is normal, but application requests, metadata calls, or bulk loads are slower | [Check authentication, client drivers, and third-party software](#step-5-check-authentication-client-drivers-and-third-party-software) |
| SQL Server 2025 SQL Authentication hashing | Login CPU or latency increased with frequent nonpooled SQL-authenticated connections | [Check SQL Server 2025 login CPU](#sql-server-2025-login-cpu) |
| Server or database configuration change | Memory, parallelism, trace flags, Resource Governor, database-scoped settings, files, or `tempdb` differ | [Compare SQL Server and database configuration](#step-3-compare-sql-server-and-database-configuration) |
| Third-party filter or security software | Antivirus, endpoint protection, backup, or monitoring software adds CPU or I/O latency | [Check antivirus, backup, and filter drivers](#antivirus-backup-and-filter-drivers) |
| Cold caches or competing activity | Performance improves after warm-up or changes with maintenance, scans, backups, or other background work | [Compare waits and resource consumption](#step-4-compare-waits-and-resource-consumption) |
| Product defect or missing update | The problem is reproducible on a specific build after other differences are excluded | [Apply the resolution that matches the evidence](#step-6-apply-the-resolution-that-matches-the-evidence) |

### Causes of query-specific performance problems

| Common cause | Typical signs | Go to |
| --- | --- | --- |
| Workload, data, or application change | Query text, parameters, data types, session options, row counts, data distribution, or concurrency differ | [Verify that you're comparing the same request](#step-1-verify-that-youre-comparing-the-same-request) |
| Query plan or optimizer change | CPU, reads, join order, access methods, parallelism, or memory grants changed | [Compare the execution plans](#step-4-compare-the-execution-plans) |
| Compatibility level or Cardinality Estimator change | Performance changed after the compatibility level was raised, or the plan uses a different CE model | [Check compatibility level and CE changes](#step-5-determine-whether-compatibility-level-or-ce-changes-caused-the-performance-problem) |
| Intelligent Query Processing feature change | A higher compatibility level made a query eligible for a feature such as scalar UDF inlining or Parameter Sensitive Plan optimization | [Check feature-specific plan changes](#step-6-check-feature-specific-plan-changes-and-compilation-storms) |
| Statistics, index, or recompilation change | Estimates, statistics sampling, available indexes, compilation time, or plan choice changed | [Check statistics, parameters, and optimizer fixes](#step-7-check-statistics-parameters-and-optimizer-fixes) |
| Parameter sensitivity | Compile-time and runtime parameter values differ, or one cached plan performs poorly for other values | [Check statistics, parameters, and optimizer fixes](#step-7-check-statistics-parameters-and-optimizer-fixes) |
| Memory grant change | The query spills, waits on `RESOURCE_SEMAPHORE`, wastes memory, or has reduced concurrency | [Compare actual runtime metrics](#step-2-compare-actual-runtime-metrics) |
| Ad hoc compilation or parameterization change | Compilations, single-use plans, plan-cache memory, or CPU increased | [Check feature-specific plan changes](#step-6-check-feature-specific-plan-changes-and-compilation-storms) |
| Product defect or missing update | The problem is reproducible on a specific build after plan, data, and configuration differences are excluded | [Apply the resolution that matches the root cause](#step-8-apply-the-resolution-that-matches-the-root-cause) |

> [!NOTE]
> The engine version and database compatibility level are separate. An in-place engine upgrade normally preserves the existing compatibility level. Query processor behavior gated by compatibility level might not change until you raise that level.

### Causes of storage and operational performance problems

| Common cause | Typical signs | Go to |
| --- | --- | --- |
| Storage, server, or VM change | File latency, throughput limits, storage paths, host contention, drivers, firmware, or file placement changed | [Determine whether the I/O subsystem changed](#step-2-determine-whether-the-io-subsystem-changed) |
| Database file or `tempdb` configuration change | File count, size, growth, placement, sector size, or instant file initialization differs | [Check feature and configuration changes](#step-3-determine-whether-a-feature-or-configuration-changed-storage-behavior) |
| Logging, checkpoint, recovery, or versioning change | Log throughput, checkpoint activity, recovery, version store, or `tempdb` behavior changed | [Check feature and configuration changes](#step-3-determine-whether-a-feature-or-configuration-changed-storage-behavior) |
| Edition or maintenance strategy change | Backup, restore, DBCC, index maintenance, compression, DOP, scheduling, or data-load behavior differs | [Check feature and configuration changes](#step-3-determine-whether-a-feature-or-configuration-changed-storage-behavior) |
| Third-party filter or security software | Filter drivers, antivirus, backup agents, or monitoring software add CPU or I/O latency | [Determine whether the I/O subsystem changed](#step-2-determine-whether-the-io-subsystem-changed) |
| High availability, replication, or specialized workload change | Redo, log hardening, snapshot initialization, full-text, columnstore, or maintenance operations are slower | [Check feature and configuration changes](#step-3-determine-whether-a-feature-or-configuration-changed-storage-behavior) |
| Storage engine or new default behavior | Waits, locking, latching, allocation, read-ahead, or specialized operations differ under an equivalent workload | [Determine whether the target build changed engine behavior](#step-4-determine-whether-the-target-build-changed-engine-behavior) |
| Cold caches or competing activity | Performance changes after warm-up or correlates with maintenance, scanning, or backups | [Connect the symptom to an upgrade-time change](#step-1-connect-the-symptom-to-an-upgrade-time-change) |
| Product defect or missing update | The behavior is reproducible on a specific build and matches a documented issue or controlled test | [Test on the latest supported CU](#step-5-test-on-the-latest-supported-cu) |

> [!TIP]
> Start with the most common differences. For slow queries, compare plans, compatibility level, statistics, indexes, and parameters. For widespread problems, compare workload, hardware, configuration, drivers, and third-party software. Investigate a build-specific Database Engine defect after excluding these differences.

## Solution

Use the solution path that matches what became slower.

### Troubleshoot a widespread performance problem

When many unrelated queries become slower, look for a shared resource, workload, configuration, or environmental difference. A single slow query rarely affects every operation unless it consumes enough resources to affect the whole instance.

#### Step 1: Determine where the extra time is spent

Ask the following questions:

- Is SQL Server execution time higher, or is only end-to-end application response time higher?
- Are all databases and applications affected?
- Does the issue occur continuously or only at peak load?
- Did CPU utilization, runnable tasks, memory pressure, physical reads, I/O latency, blocking, or network waits increase?
- Is another process on the server consuming CPU, memory, or I/O?

Run several representative application queries directly against SQL Server with the same query text, parameter values, database context, and session `SET` options.

| Observation | Most likely investigation |
| --- | --- |
| Queries are fast on SQL Server but the application is slow | Application server, driver, connection pooling, network, result processing, or changed application behavior |
| Login latency and CPU increased on SQL Server 2025, especially with SQL Authentication | PBKDF2 password hashing combined with frequent nonpooled logins or repeated authentication |
| Server-side duration is normal, but client calls or bulk loads are slower | Driver or provider compatibility, protocol or TLS behavior, extra metadata calls, network, or client-side processing |
| CPU time and logical reads increased for many queries | Plan changes, missing or stale statistics, configuration, or workload changes |
| Elapsed time increased but CPU and logical reads are similar | Waits such as I/O, locks, memory grants, worker threads, or network |
| Performance is normal at low load but becomes slower under concurrency | CPU capacity, memory, worker threads, blocking, latch contention, or storage throughput |
| Operating system and non-SQL Server activity are also slow | Host, VM, storage, driver, antivirus, or OS issue |

For each representative slow query, use the [running-versus-waiting methodology](troubleshoot-slow-running-queries.md#running-vs-waiting-why-are-queries-slow-in-sql-server). Compare elapsed time with CPU time to determine whether the query is primarily a long runner that spends its time executing on the CPU or a waiter that spends most of its time waiting on a bottleneck. This distinction determines whether to focus on query and plan tuning or on the underlying wait and resource contention.

For a broad system-level diagnostic flow, see [Troubleshoot entire SQL Server or database application that appears to be slow](troubleshoot-entire-sqlserver-slow.md).

#### Step 2: Compare server and hardware characteristics

If the upgrade moved SQL Server to another physical server or VM, compare:

- Processor model, clock speed, sockets, cores, logical processors, and NUMA layout
- VM reservations, limits, overcommit, dynamic memory, and host contention
- Physical memory and memory available to SQL Server
- Windows power plan and processor power management
- Storage media, caching, queue depth, throughput, latency, and database file placement
- Network path, bandwidth, latency, packet loss, and encryption offload
- OS, BIOS, firmware, storage, network, and virtualization drivers

Run this query on both instances to capture key SQL Server-visible properties:

```sql
SELECT
    SERVERPROPERTY('MachineName') AS machine_name,
    SERVERPROPERTY('ServerName') AS server_name,
    SERVERPROPERTY('ProductVersion') AS product_version,
    SERVERPROPERTY('ProductLevel') AS product_level,
    SERVERPROPERTY('ProductUpdateLevel') AS product_update_level,
    SERVERPROPERTY('Edition') AS edition,
    cpu_count,
    scheduler_count,
    hyperthread_ratio,
    physical_memory_kb,
    virtual_machine_type_desc,
    softnuma_configuration_desc
FROM sys.dm_os_sys_info;
```

Use [Troubleshoot a query that shows a significant performance difference between two servers](troubleshoot-query-perf-between-servers.md#diagnose-environment-differences) for a detailed environment comparison.

After importing the pre-upgrade and post-upgrade SQL LogScout collections into SQL Nexus, use [AI-assisted analysis to compare the two collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) and identify hardware, operating system, SQL Server build, and resource differences.

#### Step 3: Compare SQL Server and database configuration

Capture nondefault server settings:

```sql
SELECT
    name,
    value,
    value_in_use,
    is_dynamic,
    is_advanced
FROM sys.configurations
WHERE value <> value_in_use
   OR value_in_use <> 0
ORDER BY name;
```

Don't copy every setting from the old server without review. Some trace flags and workarounds that were useful on an older version might be unnecessary or harmful on a newer version. Compare each difference and determine why it exists.

Capture database-level settings:

```sql
SELECT
    name,
    compatibility_level,
    recovery_model_desc,
    page_verify_option_desc,
    is_auto_create_stats_on,
    is_auto_update_stats_on,
    is_auto_update_stats_async_on,
    is_read_committed_snapshot_on,
    snapshot_isolation_state_desc,
    delayed_durability_desc,
    is_accelerated_database_recovery_on
FROM sys.databases
ORDER BY name;

SELECT
    DB_NAME() AS database_name,
    name,
    value,
    value_for_secondary
FROM sys.database_scoped_configurations
ORDER BY name;
```

Run the second query in each affected user database. Also compare active trace flags by using `DBCC TRACESTATUS(-1)`, startup parameters, Resource Governor, database file definitions, and `tempdb`. Explicitly diff database-scoped settings after a side-by-side migration or cutover; don't assume that manual migration steps preserved settings such as snapshot isolation. Revalidate every carried-forward trace flag and nondefault setting for the target version and current hardware scale rather than assuming that a previous workaround is still beneficial.

You can also use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) and identify differences in server configuration, database configuration, trace flags, database files, and `tempdb`.

#### Step 4: Compare waits and resource consumption

Use the before-and-after baseline to compare:

- Total CPU and CPU per request
- Batch requests and transactions per second
- Page life expectancy, memory grants pending, and stolen memory
- Physical reads and writes, I/O latency, and log flush latency
- Compilations and recompilations
- Runnable tasks and worker-thread usage
- Blocking duration and lock waits
- Top waits, excluding benign background waits

Use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) to compare waits, workload volume, resource consumption, and the queries contributing most to the performance decrease.

Classify the dominant symptom:

- For CPU pressure, see [Troubleshoot high-CPU-usage issues in SQL Server](troubleshoot-high-cpu-usage-issues.md).
- For I/O latency, see [Troubleshoot slow SQL Server performance caused by I/O issues](troubleshoot-sql-io-performance.md).
- For memory pressure, see [Troubleshoot out-of-memory issues in SQL Server](troubleshoot-memory-issues.md).
- For blocking, see [Understand and resolve SQL Server blocking problems](understand-resolve-blocking.md).
- For memory grant waits or spills, see [Troubleshoot slow performance or low memory issues caused by memory grants](troubleshoot-memory-grant-issues.md).

#### Step 5: Check authentication, client drivers, and third-party software

##### SQL Server 2025 login CPU

SQL Server 2025 uses PBKDF2 for password-based authentication. Check this path early when CPU or login latency is higher and the application creates many SQL-authenticated connections.

Compare:

- SQL-authenticated logins per second before and after the upgrade
- Connection pooling configuration and connection reuse
- `PREEMPTIVE_OS_CRYPTOPS` waits
- Application-role authentication frequency
- Windows or Microsoft Entra authentication behavior, if the application supports it

The extra computational cost is most noticeable without connection pooling. Prefer reducing unnecessary authentication by enabling and correctly sizing connection pools. For current product guidance, see [PBKDF2 hashing algorithm can affect login performance](/sql/sql-server/sql-server-2025-known-issues#pbkdf2-hashing-algorithm-can-affect-login-performance).

##### Client drivers and protocols

If server-side query duration and resource use are normal, compare the exact client driver or provider version, protocol, TLS and encryption settings, connection initialization calls, metadata calls, and bulk-copy behavior. Run the client-side commands on the application server, not only on the SQL Server computer.

To list installed SQL Server ODBC drivers and their 32-bit or 64-bit platform, run:

```powershell
Get-OdbcDriver -Platform All |
    Where-Object Name -match 'SQL Server' |
    Select-Object Name, Platform, Attribute
```

For OLE DB, .NET, Java, and other clients, check the application's installed packages, dependency manifest, deployment package, or startup log. For guidance about identifying the appropriate provider and reviewing its requirements, see [Microsoft SQL drivers and frameworks](/sql/connect/sql-connection-libraries) and [Driver feature support matrix for Microsoft SQL](/sql/connect/driver-feature-matrix).

On SQL Server, correlate the application host and program with the client interface, network transport, and encryption state:

```sql
SELECT
    s.session_id,
    s.host_name,
    s.program_name,
    s.client_interface_name,
    c.net_transport,
    c.protocol_type,
    c.encrypt_option,
    c.auth_scheme,
    c.client_net_address,
    c.local_net_address,
    c.local_tcp_port,
    c.connect_time
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_connections AS c
    ON c.session_id = s.session_id
WHERE s.is_user_process = 1
ORDER BY s.host_name, s.program_name, s.session_id;
```

`client_interface_name` identifies the client interface but doesn't always include its complete product version. Use `host_name`, `program_name`, and `client_net_address` to match the session to the application-host inventory. `encrypt_option = TRUE` confirms that the connection is encrypted, but SQL Server doesn't expose the negotiated TLS version in this DMV. For column definitions, see [sys.dm_exec_connections](/sql/relational-databases/system-dynamic-management-objects/sys-dm-exec-connections-transact-sql).

Compare the following items between the source and target environments:

- Driver or provider name, version, and 32-bit or 64-bit platform
- Application connection string, protocol, encryption, certificate-validation, and authentication settings
- `client_interface_name`, `net_transport`, `encrypt_option`, and `auth_scheme`
- Connection initialization, metadata-call, and bulk-copy behavior
- Windows Schannel protocol and cipher-suite policy on both the client and server

Use SQL Server Configuration Manager to compare **Force Encryption**, certificates, enabled protocols, and aliases. To determine the exact negotiated TLS version and cipher suite, capture the connection handshake by using a network trace or Schannel event logging.

For detailed procedures, see:

- [Get-OdbcDriver](/powershell/module/wdac/get-odbcdriver)
- [TLS 1.2 support for Microsoft SQL Server](../connect/tls-1-2-support-microsoft-sql-server.md)
- [SQL Server and client encryption summary](/sql/database-engine/configure-windows/sql-server-and-client-encryption-summary)
- [Troubleshoot consistent SQL Server network connectivity issues](../connect/consistent-sql-network-connectivity-issue.md)

Validate the target SQL Server version against the driver's support matrix and test with a current supported driver before changing Database Engine settings.

##### Antivirus, backup, and filter drivers

Compare antivirus, endpoint-protection, backup-agent, and monitoring versions and policies. Use `fltmc instances` to identify file-system filter drivers and scanned volumes, and check `sys.dm_os_loaded_modules` for third-party modules loaded into `sqlservr.exe`. Configure only vendor-approved SQL Server exclusions after assessing the security risk. See [Configure antivirus software to work with SQL Server](../security/antivirus-and-sql-server.md) and [Performance and consistency issues when certain modules or filter drivers are loaded](performance-consistency-issues-filter-drivers-modules.md).

#### Step 6: Apply the resolution that matches the evidence

- Correct VM sizing, host contention, power plan, NUMA, driver, firmware, storage, or network differences.
- Restore an intentionally configured memory, parallelism, Resource Governor, database, or `tempdb` setting after validating it for the new version.
- Correct application connection pooling, authentication, driver, protocol, retry, parameter, or result-processing behavior.
- Correct vendor-supported antivirus, backup-agent, monitoring, or filter-driver configuration.
- Reschedule upgrade-related maintenance or scanning that competes with the production workload.
- Tune the high-resource queries that are affecting the entire instance.
- Apply the latest supported CU after reviewing and testing the fixes for the target version.

### Troubleshoot specific slow queries

When most queries perform normally and only certain queries become slower, compare their plans, cardinality estimates, statistics, parameters, and compatibility-level behavior.

Use [Troubleshoot slow-running queries in SQL Server](troubleshoot-slow-running-queries.md) as the primary query-troubleshooting methodology. It separates slow queries into two categories:

- **Running:** CPU time is close to elapsed time, so the query spends most of its duration executing on the CPU. Investigate logical reads, the execution plan, indexes, statistics, cardinality estimates, and parameter-sensitive behavior.
- **Waiting:** Elapsed time is significantly greater than CPU time, so the query spends most of its duration waiting. Identify the dominant wait and investigate the associated bottleneck, such as blocking, I/O, memory grants, worker threads, or network consumption.

#### Step 1: Verify that you're comparing the same request

Confirm that the before-and-after executions use the same:

- Query text and database context
- Parameter values and data types
- Session `SET` options
- Application name and database driver
- Data volume and data distribution
- Concurrency and cache state

A changed parameter or session option can produce a different plan even when the visible query text appears unchanged. If the application and a direct SSMS test behave differently, see [Troubleshoot query performance difference between database application and SSMS](troubleshoot-application-slow-ssms-fast.md).

#### Step 2: Compare actual runtime metrics

Compare the following values for equivalent executions:

- Elapsed time and CPU time
- Logical and physical reads
- Rows returned
- Wait type and wait duration
- Memory grant, used memory, and spills
- Degree of parallelism
- Compilation time

Interpret the result:

| Finding | Interpretation |
| --- | --- |
| CPU time and logical reads increased | A plan change or additional work is likely |
| Elapsed time increased but CPU and reads are similar | The query is waiting longer on a shared resource |
| The plan is the same but CPU time increased | Hardware, engine implementation, scalar functions, encryption, or other per-row CPU cost might differ |
| The plan is the same but physical reads increased | Cache size, memory pressure, storage, or read-ahead behavior might differ |
| The query compiles much more often | Plan cache pressure, schema or statistics changes, `RECOMPILE`, or configuration changes might be involved |

Don't compare estimated plan cost by itself. Use actual runtime statistics and waits.

Apply the [running-versus-waiting approach](troubleshoot-slow-running-queries.md#running-vs-waiting-why-are-queries-slow-in-sql-server) before assuming that a changed plan is the cause. A query with higher CPU time or logical reads is generally a long-runner investigation, while a query with similar CPU time but much higher elapsed time is generally a wait investigation.

If both runs were captured with SQL LogScout, use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) and compare query duration, CPU, reads, waits, execution counts, and workload differences.

#### Step 3: Use Query Store to identify a plan change

In Query Store, compare plans and runtime statistics from before and after the upgrade. Determine whether:

- A new plan appeared when performance became slower.
- The old plan still performs well on the target version.
- Duration, CPU, reads, memory grants, or execution count changed.
- The performance change coincides with raising the compatibility level rather than installing the new engine version.

You can temporarily force a known good plan to validate the diagnosis and restore service. Continue investigating the underlying cause because forced plans can become unsuitable when data or schema changes.

In addition to Query Store, [SQL Nexus AI-assisted analysis can compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) and highlight queries whose plans or runtime characteristics changed.

#### Step 4: Compare the execution plans

Use [Compare execution plans](/sql/relational-databases/performance/compare-execution-plans) and inspect:

- `CardinalityEstimationModelVersion`
- Estimated rows compared with actual rows
- Join order and join type
- Index seeks, scans, lookups, and missing-index suggestions
- Serial compared with parallel execution
- Degree of parallelism and row distribution between threads
- Memory grant size and spill warnings
- Sorts, hashes, spools, and exchanges
- Implicit conversions and residual predicates
- Optimizer timeout or early-abort reason
- Intelligent Query Processing features and feedback

Use [Diagnose query plan differences](troubleshoot-query-perf-between-servers.md#diagnose-query-plan-differences) for a broader checklist.

You can use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) to identify changed plans and prioritize queries with the largest performance decrease.

#### Step 5: Determine whether compatibility level or CE changes caused the performance problem

Check the compatibility level:

```sql
SELECT
    name,
    compatibility_level
FROM sys.databases
WHERE name = N'<DatabaseName>';
```

The execution plan property `CardinalityEstimationModelVersion` identifies the CE model used to compile the plan. A value of `70` indicates the legacy CE. Values of `120` or higher indicate newer CE models.

If a query became slower when moving from the legacy CE to a modern CE, follow [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md). Test the legacy CE only as a diagnostic comparison:

```sql
SELECT ...
OPTION (USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'));
```

If the hint restores performance, investigate why the cardinality estimates differ. Prefer a targeted correction, such as query or index tuning, updated statistics, Query Store plan forcing, or a targeted query hint. Don't force the legacy CE for the entire server as the first or permanent response.

Compatibility-level changes affect more than CE. Review [Differences between compatibility levels](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level#differences-between-compatibility-levels) and use the recommended [Query Store compatibility-level upgrade workflow](/sql/database-engine/install-windows/change-the-database-compatibility-mode-and-use-the-query-store).

> [!IMPORTANT]
> There is no universally safe direction for a compatibility-level change. A query might perform better at a lower or higher level depending on its plan and the features available. Use Query Store and controlled tests to identify the level and targeted mitigation that produce the appropriate plan; don't assume that rollback is always the correct permanent fix.

#### Step 6: Check feature-specific plan changes and compilation storms

When the plan changes at a higher compatibility level, check if a newly eligible feature is involved:

- [Scalar UDF inlining](/sql/relational-databases/user-defined-functions/scalar-udf-inlining) applies to eligible queries at compatibility level 150 and later versions. As a diagnostic test, use the `DISABLE_TSQL_SCALAR_UDF_INLINING` query hint before considering the database-scoped setting.
- [Parameter Sensitive Plan optimization](/sql/relational-databases/performance/parameter-sensitive-plan-optimization) applies at compatibility level 160 and later versions. Compare the dispatcher and query variants in Query Store. Use `DISABLE_PARAMETER_SENSITIVE_PLAN` as a targeted diagnostic test when the performance decrease begins with PSP eligibility.

If compilations, CPU, or plan-cache memory increased across many ad hoc queries, check:

- SQL compilations and recompilations per second
- Single-use ad hoc plans and their memory consumption
- Whether the application sends literal values instead of parameterized requests
- Inconsistent parameter data types, lengths, precision, or scale
- Whether parameterization behavior or plan guides changed during migration

Use [Best practices for Query Store: Avoid nonparameterized queries](/sql/relational-databases/performance/best-practice-with-the-query-store#avoid-using-non-parameterized-queries) and [Server configuration: optimize for ad hoc workloads](/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option). Forced parameterization can cause parameter-sensitive performance problems, so test it against the representative workload instead of enabling it solely because compilations increased.

#### Step 7: Check statistics, parameters, and optimizer fixes

Check whether:

- Statistics are stale, sampled differently, or missing after a database migration.
- The data distribution changed during the upgrade.
- The first parameter used after compilation produced an unsuitable cached plan.
- Compile-time parameter values differ from typical runtime values, or different parameter sets need substantially different plans.
- The application changed parameter data types or query text.
- The requested or granted query memory changed, or the plan now spills to `tempdb`, wastes a large grant, or waits on `RESOURCE_SEMAPHORE`.
- Index definitions or maintenance and statistics job schedules differ from the pre-upgrade environment.
- `QUERY_OPTIMIZER_HOTFIXES`, trace flag 4199, or another optimizer-related setting differs.
- The target build includes or lacks a relevant optimizer fix.

Consider updating statistics after the upgrade or migration so the target-version optimizer has current data-distribution information, especially when statistics are stale, were sampled differently, or weren't maintained during the migration. Updating statistics can trigger plan recompilation and consume CPU and I/O, so schedule and validate the operation against the workload. For guidance about choosing which statistics to update and the appropriate sampling method, see [UPDATE STATISTICS](/sql/t-sql/statements/update-statistics-transact-sql).

#### Step 8: Apply the resolution that matches the root cause

- For long-running queries, follow [Diagnose and resolve running queries](troubleshoot-slow-running-queries.md#diagnose-and-resolve-running-queries-in-sql-server). For waiting queries, follow [Diagnose and resolve waiting queries](troubleshoot-slow-running-queries.md#diagnose-and-resolve-waiting-queries-in-sql-server).
- Update inaccurate statistics with an appropriate sample rate.
- Add, modify, or remove an index based on workload evidence.
- Rewrite a non-SARGable or estimate-sensitive query.
- Correct application parameter types, values, or session options.
- Apply a targeted feature-disable hint only when a controlled test proves that the eligible feature causes the performance problem.
- Parameterize reusable queries or use `optimize for ad hoc workloads` when single-use plans are proven to consume significant plan-cache memory.
- Force a known good plan in Query Store as a targeted mitigation.
- Apply a targeted Query Store hint or query hint.
- Use CE-related hints only for queries proven to become slower because of a CE assumption.
- Apply a CU that contains a relevant optimizer fix.
- Keep the previous compatibility level temporarily while testing and correcting performance problems, then resume the compatibility-level upgrade workflow.

### Troubleshoot storage and operational performance

New waits or slower operations don't necessarily indicate a storage engine problem. Wait types identify where SQL Server spends time; by themselves, they don't prove that the SQL Server version caused the performance decrease. Associate the symptom with one of the following changes:

1. The migration changed the storage, hardware, virtualization, operating system, drivers, or database file placement.
1. The upgrade enabled or changed a Database Engine feature, default, or configuration that affects storage behavior.
1. The target SQL Server build introduced a documented or reproducible engine problem.

Use equivalent workloads and observation periods. A larger workload, a changed query plan that performs more reads, longer transactions, or different maintenance activity can produce the same waits without an I/O subsystem or storage engine problem.

#### Step 1: Connect the symptom to an upgrade-time change

| Observation | More common explanation | Evidence needed to associate it with the upgrade |
| --- | --- | --- |
| Higher `PAGEIOLATCH_*`, `WRITELOG`, `IO_COMPLETION`, or `ASYNC_IO_COMPLETION` waits | Slower storage, changed file placement, SAN or VM contention, drivers or firmware, autogrowth, or a workload that issues more I/O | File latency or I/O volume changed at the same time as the storage, VM, driver, or file-placement change. Separate higher latency per I/O from a higher number of I/O requests. |
| Higher `PAGELATCH_*` waits in `tempdb` | In-memory allocation or metadata contention rather than slow physical I/O | A comparable workload shows new contention after a `tempdb` layout, CPU topology, feature, configuration, or engine-build change. |
| More `LCK_M_*` waits or blocking | Longer transactions, changed concurrency, isolation level, application behavior, or query plans | The blocking chain changed because of a specific upgrade-time application, plan, configuration, or documented engine behavior change. |
| New latch or spinlock contention | Changed workload, CPU topology, configuration, or a build-specific engine issue | The contention starts on the target build under a comparable workload and matches a documented issue, CU fix, or controlled reproduction. |
| Slower checkpoint, startup, failover, or recovery | I/O latency, more dirty pages or log to process, long transactions, or changed checkpoint, recovery, or availability settings | Error log timestamps and runtime data correlate the slowdown with a changed setting or feature such as indirect checkpoint or Accelerated Database Recovery. |
| Slower backup, restore, DBCC, index maintenance, or data load | Storage throughput, DOP, edition, compression, job definition, blocking, or competing workload | The operation and workload are comparable, and a specific storage, edition, configuration, feature, or job change explains the difference. |
| Slower availability group redo or replication initialization | More log to process, changed log-block behavior, storage latency, Snapshot Agent locking, publication size, file growth, or disabled instant file initialization | Redo, send, harden, snapshot, locking, and file-growth metrics changed at cutover and map to a specific AG, replication, storage, or job change. |
| Slower full-text, columnstore, or maintenance-script operation | Changed word-breaking, cold metadata caches, optimizer behavior for system metadata, maintenance strategy, or a target-build issue | The specialized operation is reproducible independently, and its plan, cache state, waits, or build-specific fix differs from the source environment. |

Don't classify generic `tempdb` contention, blocking, or utility-operation slowness as a storage engine problem unless you can establish this connection.

#### Step 2: Determine whether the I/O subsystem changed

Investigate physical I/O first when `PAGEIOLATCH_*`, `WRITELOG`, `IO_COMPLETION`, or `ASYNC_IO_COMPLETION` waits increase after a migration. Check whether data, log, backup, and `tempdb` files moved to different volumes or storage tiers. Compare:

- Storage media, tier, caching, throughput limits, queue depth, and latency
- SAN paths, host bus adapters, multipathing, drivers, and firmware
- VM host placement, storage contention, reservations, and limits
- Antivirus and file-system filter drivers
- File placement, size, free space, autogrowth, and sector size
- I/O latency per request and total I/O request volume

An increase in latency per request supports an I/O subsystem problem. Similar latency with substantially more I/O points instead to a workload, cache, memory, or query plan change.

```sql
SELECT
    DB_NAME(vfs.database_id) AS database_name,
    mf.file_id,
    mf.type_desc,
    mf.physical_name,
    mf.size * 8.0 / 1024 AS size_mb,
    mf.growth,
    mf.is_percent_growth,
    CASE
        WHEN vfs.num_of_reads = 0 THEN 0
        ELSE vfs.io_stall_read_ms / vfs.num_of_reads
    END AS avg_read_latency_ms,
    CASE
        WHEN vfs.num_of_writes = 0 THEN 0
        ELSE vfs.io_stall_write_ms / vfs.num_of_writes
    END AS avg_write_latency_ms
FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS vfs
JOIN sys.master_files AS mf
    ON mf.database_id = vfs.database_id
    AND mf.file_id = vfs.file_id
ORDER BY avg_read_latency_ms DESC, avg_write_latency_ms DESC;
```

The DMV values are cumulative since the SQL Server service started. Compare equivalent observation windows and workload volumes. For detailed interpretation, use [Troubleshoot slow SQL Server performance caused by I/O issues](troubleshoot-sql-io-performance.md).

Use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) to compare file I/O latency, throughput, waits, and the workload generating the I/O.

#### Step 3: Determine whether a feature or configuration changed storage behavior

Compare features and settings that can change logging, versioning, allocation, checkpoint, recovery, and `tempdb` behavior:

- Accelerated Database Recovery
- Indirect checkpoint and target recovery time
- Read committed snapshot isolation, snapshot isolation, and version store usage
- Memory-optimized `tempdb` metadata
- Delayed durability and transaction commit frequency
- Availability group synchronization mode and replica latency
- Availability group send, harden, and redo rates
- Replication agent schedules, snapshot generation, publication reinitialization, and locking
- Recovery model, backup frequency, and transaction log reuse
- `tempdb` file count, size, growth, and storage placement
- Instant file initialization status for data file growth
- Transaction log size, growth, virtual log file count, and storage placement
- Edition-dependent capabilities, DOP, compression, and online or resumable behavior for maintenance operations
- Full-text, columnstore, and community maintenance-script behavior on the target version

New installations and in-place upgrades can have different effective defaults. Confirm that a feature or setting actually changed at upgrade time, and then correlate that change with the affected workload. For example, `PAGELATCH_*` waits indicate in-memory contention and shouldn't be attributed to the physical I/O subsystem. `PAGEIOLATCH_*` waits for `tempdb`, however, involve physical I/O and should be investigated by using the I/O methodology in step 2.

You can also use [SQL Nexus AI-assisted analysis to compare the pre-upgrade and post-upgrade SQL LogScout collections](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) to identify differences in database files, `tempdb`, logging, waits, and related configuration.

#### Step 4: Determine whether the target build changed engine behavior

Suspect a build-specific storage engine problem only when all or most of the following conditions are true:

- The hardware, storage, workload, data, application, edition, and relevant configuration are comparable.
- The symptom begins on the target build and can be reproduced.
- The affected wait, latch, spinlock, or operation maps to a specific Database Engine component.
- A documented behavior change, known issue, or CU fix matches the observed evidence.
- A controlled test, supported workaround, or later CU changes the behavior.

Review:

- The what's new article for the target version: [SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025), [SQL Server 2022](/sql/sql-server/what-s-new-in-sql-server-2022), or [SQL Server 2019](/sql/sql-server/what-s-new-in-sql-server-2019)
- [ALTER DATABASE compatibility level differences](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level#differences-between-compatibility-levels)
- Release notes and known issues for the target version
- CU fix lists between the installed build and the latest supported build
- Settings or trace flags that became default, were superseded, or no longer apply

Validate a suspected engine change with a measurable before-and-after difference. For example, a higher `WRITELOG` wait alone doesn't prove a logging engine problem; it can also result from more commits, smaller transactions, synchronous replicas, log autogrowth, or slower storage. Similarly, blocking alone doesn't prove a locking-engine problem, and `PAGELATCH_*` contention alone doesn't prove a physical I/O problem.

#### Step 5: Test on the latest supported CU

Determine the exact target build:

```sql
SELECT
    @@VERSION AS version_string,
    SERVERPROPERTY('ProductVersion') AS product_version,
    SERVERPROPERTY('ProductLevel') AS product_level,
    SERVERPROPERTY('ProductUpdateLevel') AS product_update_level,
    SERVERPROPERTY('ProductUpdateReference') AS product_update_reference;
```

If the instance isn't on a current supported CU, review the intervening fixes for the affected component. Test the CU under a representative workload before production deployment. Don't enable undocumented trace flags or apply version-specific workarounds without a confirmed match to the issue.

#### Step 6: Apply the resolution that matches the evidence

- For a migration-related I/O problem, correct storage latency, file placement, autogrowth, drivers, firmware, VM contention, or capacity.
- For a feature or configuration change, restore or tune the relevant `tempdb`, logging, versioning, checkpoint, recovery, or high-availability setting after testing it on the target version.
- For an operational difference, correct the job definition, DOP, compression, schedule, edition limitation, blocking, or competing workload.
- For an AG or replication difference, correct storage or file-growth constraints, agent scheduling, initialization strategy, locking, or replica throughput based on the measured bottleneck.
- For full-text, columnstore, or maintenance tooling, validate the operation independently and apply the target-build fix or supported operation-specific mitigation.
- For a confirmed build-specific problem, apply the CU or supported mitigation that addresses the matching issue.
- Remove obsolete trace flags only after verifying that the target version includes the intended behavior.
- If evidence indicates a previously unknown product defect, retain the baseline, reproduction steps, plans, waits, dumps or traces, and SQL LogScout output for Microsoft Support.

## Validate the solution

After making one targeted change:

1. Repeat the same representative workload under comparable concurrency.
1. Compare duration, CPU, reads, waits, throughput, and resource usage with both the slower state and the pre-upgrade baseline.
1. Verify that the change didn't make other queries or operations slower.
1. Monitor through at least one normal peak period.
1. Document the root cause, mitigation, final fix, and any temporary settings that must later be removed.

After the fix, capture another SQL LogScout `DetailedPerf` collection. Use [SQL Nexus AI-assisted analysis to compare this validation collection with the slower post-upgrade SQL LogScout collection](https://github.com/microsoft/SqlNexus/wiki/AI-Assisted-Analysis#comparing-two-collections-slow-run-vs-fast-run) to verify that the targeted metrics improved and that the workload remained comparable.

Avoid declaring success based on one fast execution. Cache state, parameter values, concurrent workload, automatic feedback features, and storage caching can make individual executions unrepresentative.

## Prepare for future upgrades

- Keep SQL Server on a tested, supported CU before and after the major-version upgrade.
- Use [Data Migration Assistant](/previous-versions/sql/dma/dma-overview) and review deprecated or discontinued features.
- Capture SQL LogScout and Query Store baselines before the change.
- Test the production workload by using Distributed Replay or [Replay Markup Language utilities](../../tools/replay-markup-language-utility.md) where appropriate.
- Upgrade the Database Engine while retaining the existing database compatibility level.
- Validate performance, then raise compatibility level by using the [Query Store upgrade workflow](/sql/database-engine/install-windows/change-the-database-compatibility-mode-and-use-the-query-store).
- Change hardware, application, and database configuration separately when possible.
- Define measurable rollback criteria and preserve the evidence needed to compare both states.

## Related content

- [Troubleshoot performance problems after changing the SQL Server edition](troubleshoot-performance-edition-change.md)
- [Troubleshoot a query that shows a significant performance difference between two servers](troubleshoot-query-perf-between-servers.md)
- [Troubleshoot entire SQL Server or database application that appears to be slow](troubleshoot-entire-sqlserver-slow.md)
- [Troubleshoot query performance difference between database application and SSMS](troubleshoot-application-slow-ssms-fast.md)
- [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md)
- [Join containment assumption in the New Cardinality Estimator degrades query performance](cardinality-estimator-degrades-query-performance.md)
- [Query Store usage scenarios](/sql/relational-databases/performance/query-store-usage-scenarios)
- [Troubleshoot slow-running queries on SQL Server](troubleshoot-slow-running-queries.md)