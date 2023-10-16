---
title: Performance issues can be caused by excessive entries in the TokenAndPermUserStore cache
description: This article helps you resolve performance issues that occur in the TokenAndPermUserStore cache. It also explains the causes and provides workarounds. 
ms.date: 09/21/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.reviewer: ramakoni, v-jayaramanp
---

# Queries take longer to finish when the size of the TokenAndPermUserStore cache grows in SQL Server

This article helps you troubleshoot problems related to query performance when the size of `TokenAndPermUserStore` grows. It also provides various causes and workarounds.

_Original KB number:_ &nbsp; 927396

## Symptoms

In Microsoft SQL Server, you experience the following symptoms:

- Queries that typically run fast take a longer time to finish.

- CPU usage for the SQL Server process is greater than usual.

- You experience decreased performance when you run an ad hoc query. However, if you query the `sys.dm_exec_requests` or `sys.dm_os_waiting_tasks` dynamic management views, the results don't indicate that the ad hoc query is waiting for any resource.

- The size of the `TokenAndPermUserStore` cache grows at a steady rate.

- The size of the `TokenAndPermUserStore` cache is several hundred megabytes (MB).

- In some cases, running the `DBCC FREEPROCCACHE` or `DBCC FREESYSTEMCACHE` command provides temporary relief.

## Cause

Performance issues such as high CPU and increased memory use, can be caused by excessive entries in `TokenAndPermUserStore` cache. By default, entries in this cache are cleaned up only when SQL Server signals internal memory pressure. On servers that have lots of RAM, internal memory pressure might not trigger often. When this cache grows, it takes longer to search for existing entries to reuse. Access to this cache is controlled by a spinlock. Only one thread at a time can do the search. This behavior eventually causes query performance to decrease and more CPU usage occurs.

To monitor the size of `TokenAndPermUserStore` cache, you can use a query that resembles the following query:

```sql
SELECT SUM(pages_kb) AS 
   "CurrentSizeOfTokenCache(kb)" 
   FROM sys.dm_os_memory_clerks 
   WHERE name = 'TokenAndPermUserStore'
```

The `TokenAndPermUserStore` cache maintains the following security token types:

- LoginToken
  - One login token per server level principal.
- TokenPerm
  - Records all permissions for a securable object for a UserToken and SecContextToken.
  - Each entry in this cache is a single permission on a specific securable. For example, a select permission granted on table t1 to user u1.
  - This token entry is different from entries in Access Check Results (ACR) cache. ACR entries mainly indicate whether a user or login has permission to run an entire query.
- UserToken
  - One user token per database for a login.
  - Stores information about membership in database level roles.
- SecContextToken
  - One SecContextToken created per server level principal.
  - Stores server-wide security context for a principal.
  - Contains a hash table cache of User Tokens.
  - Stores information about membership in server level roles.
- TokenAccessResult
  - Different classes of TokenAccessResult entries are present.
  - Access Check indicates whether a given user in a particular database has permission to run a query that involves multiple objects.
  - Prior to Microsoft SQL Server 2008, ACR security caches were stored in a single cache, `TokenAndPermUserStore`.  
  - In SQL Server 2008, the ACR caches were separated and the ACR cache entries were tracked in their own individual user stores. This separation improved performance and provided   better bucket count and quota control for the caches.
  - Currently, `TokenAndPermUserStore` and `ACRCacheStores` are the only kinds of security cache that are used. For more information on ACR caches, see [access check cache Server Configuration Options](/sql/database-engine/configure-windows/access-check-cache-server-configuration-options).
  
You can run the following query to get information about the different caches and their individual sizes:

```sql
SELECT type, name, pages_kb 
FROM sys.dm_os_memory_clerks 
WHERE type = 'USERSTORE_TOKENPERM'
```

You can run the following query to identify the kinds of tokens that are growing in the `TokenAndPermUserStore`:

```sql
SELECT [name] AS "SOS StoreName",[TokenName],[Class],[SubClass], count(*) AS [Num Entries]
FROM
(SELECT name,
x.value('(//@name)[1]', 'varchar (100)') AS [TokenName],
x.value('(//@class)[1]', 'varchar (100)') AS [Class],
x.value('(//@subclass)[1]', 'varchar (100)') AS [SubClass]
FROM
(SELECT CAST (entry_data as xml),name
FROM sys.dm_os_memory_cache_entries
WHERE type = 'USERSTORE_TOKENPERM') 
AS R(x,name)
) a
GROUP BY a.name,a.TokenName,a.Class,a.SubClass
ORDER BY [Num Entries] desc
```

## Workaround

SQL Server offers two trace flags that can be used to configure the quota of the `TokenAndPermUserStore` (By default, there's no quota. This implies that there can be any number of entries in this cache).

- **TF 4618** - Limits the number of entries in `TokenAndPermUserStore` to 1024.
- **TF 4618+TF 4610** - Limits the number of entries in `TokenAndPermUserStore` to 8192.

If the very low entry count of 4618 causes other performance concerns, use the traceflags 4610 and 4618 together.

Trace flags 4610 and 4618 are documented in the Books Online topic, [DBCCC TRACEON - Trace Flags](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql).

These trace flags should be used for scenarios in which the unbounded growth of `TokenAndPermUserStore` is too great for the server. This typically occurs in two kinds of environments:

- Low-end or medium-end hardware for which `TokenAndPermUserStore` occupies a large amount of the available memory for the server and for which the rate of new entry creation is faster or as fast as the rate of cache eviction. This can cause memory contention and more frequent cache invalidation for other parts of the server (for example, proc cache).

- High-end computers that have lots of memory (for example, several recent support cases involved more than 1 TB of RAM). In these environments, the cache store can grow  large before it experiences any memory pressure. This can cause performance degradation from long bucket chains or walks.

As a temporary mitigation, you can clear this cache periodically by using the following method:

- Flush entries from the `TokenAndPermUserStore` cache.

Notes:

 1. To do this, run the following command:

     `DBCC FREESYSTEMCACHE ('TokenAndPermUserStore')`

1. Observe the threshold of the `TokenAndPermUserStore` cache size when problems start to appear.
1. Create a scheduled SQL Server Agent job that takes the following actions:
    - Check the size of the `TokenAndPermUserStore` cache. To check the size, run the following command:

      ```sql
      SELECT SUM(pages_kb) AS 
       "CurrentSizeOfTokenCache(kb)" 
       FROM sys.dm_os_memory_clerks 
       WHERE name = 'TokenAndPermUserStore'
      ```

   - If the cache size is bigger than the observed threshold, run the following command:

       `DBCC FREESYSTEMCACHE ('TokenAndPermUserStore')`
