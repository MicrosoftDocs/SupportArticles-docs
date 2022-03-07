---
title: Troubleshoot slow queries resulting from ASYNC_NETWORK_IO
description: Provides resolutions to troubleshoot slow query issues that result from ASYNC_NETWORK_IO wait type.
ms.date: 02/22/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: pijocoder 
---

# Troubleshoot slow queries that result from ASYNC_NETWORK_IO wait type

## Symptoms

When SQL Server produces result sets and sends them to a client application by putting the results in an output buffer, the client application fetches them from the output buffer. If the client application stops or doesn't fetch the results fast enough, SQL Server has to wait for acknowledgment that the client application has received all the results before sending more results. This wait will show up as `ASYNC_NETWORK_IO`. For more information, see the video [Understanding ASYNC_NETWORK_IO Waits in SQL Server](/shows/SQL-Workshops/Understanding-ASYNCNETWORKIO-Waits-in-SQL-Server).

In addition, excessive waits in the symptom cause two issues:

- All the queries will slow down, and total duration of these queries will be longer.

- When SQL Server waits for the client to fetch results, it can't release locks acquired. If the lock isn't released for a long time, other sessions will be blocked on SQL Server.

## Causes and resolutions

The following sections list the common causes for this wait type and the corresponding steps to resolve the issue:

### Large result set

Some application clients request thousands or millions of rows and then process the result by applying filters, sorting and aggregations. Large result sets may lead to unnecessary network utilization and client application processing.

**Resolution:** Application developers must carefully balance the processing between SQL Server and clients. Filtering or aggregations can be performed by SQL Server and the final result set can be small. Limit the results set that arrives to the clients. Any more computations over the data, presentation and formatting are more appropriate on the client side, once the data is received.  

### Application doesn't fetch results fast enough

If the client application doesn't fetch results fast enough and doesn't notify SQL Server that the results set has been received, the `ASYNC_NETWORK_IO` wait will occur on the server.

To illustrate using ADO.NET, by default, [DataSet](/dotnet/framework/data/adonet/ado-net-datasets) and [DataTable](/dotnet/api/system.data.datatable) will fetch all rows to completion before client can access it. However, classes like [SqlDataReader](/dotnet/api/system.data.sqlclient.sqldatareader) allow the application developer to choose what to do after each row is fetched from the server. An application can fetch one row at a time and then process this row according to business requirements. For example, it may write it to a file, send it to another application over the network, or wait for some time or for user input.

**Resolution:** To resolve the issue, follow these steps:

1. Fetch all results as fast as the client can.

1. Use a tight WHILE/FOR loop.

1. Store them in memory and only then do more processing.

### Client application machine is under stress (I/O, memory, CPU)

Even if application code is developed to fetch results as fast as possible, system resource issues can cause the entire client process to be slow. For example:

If the machine that runs the client application is constrained on resources, like 100% CPU utilization, insufficient memory (all memory is consumed), or slow I/O where perhaps the application writes results or logs, the application may not be able to quickly fetch results.

This case can also lead to slow processing of incoming results and cause the SQL Server to wait with `ASYNC_NETWORK_IO`.

**Resolution:** To resolve this issue, use tools like Performance monitor to diagnose the system that runs the application, and then eliminate any resource constraints. One of the following methods may work for you:

- Stop other applications from running.

- Fix any code issues in those applications.

- Upgrade the hardware on the system (if the applications have been tuned fully.

### NIC/Network

Slow network or broken Network Interface Card (NIC) can cause delay in network traffic and this case will naturally delay fetching the results and communicating with SQL Server. Network delays are typically caused by the following issues:

- Network adapter driver issues

- Network filter drivers issues

- Misconfigured or faulty firewalls

- Routers issues

- Overloaded networks due to traffic(less commonly)

**Resolution:** To diagnose and resolve these issues, you can [collect a network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) and look for packet resets and retransmits.

## See also

[ASYNC_NETWORK_IO in sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#async_network_io)
