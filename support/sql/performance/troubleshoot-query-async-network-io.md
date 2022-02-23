---
title: Troubleshooting slow queries resulting from ASYNC_NETWORK_IO issues
description: This article describes how to troubleshoot slow query issues that result from ASYNC_NETWORK_IO wait type
ms.date: 02/22/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: pijocoder 
---

# Troubleshoot slow queries that result from ASYNC_NETWORK_IO issues

## Description

ASYNC_NETWORK_IO is a wait type that can occurs when the database client application fetches results from SQL Server and SQL Server is waiting for acknowledgment that all the results were received. When SQL Server produces result sets, it needs to send them to client application by putting the results in an output buffer. The client then fetches them from the output buffer. If client application stops or doesn't fetch the results fast enough, SQL Server has to wait before sending more results. This wait will show up as ASYNC_NETWORK_IO.

Excessive waits in this category cause two issues.
1. The query or queries will slow down; total duration of the query will be longer. 
1. When SQL Server waits for client(s) to fetch results, it cannot release locks acquired. This may cause blocking of other sessions on the SQL Server.


## Causes & resolutions

The following sections provide a list of common causes for this wait type and steps you can take to resolve them. 

### Large result set

Some applications request thousands or millions of rows to be sent to the client and then process the result on the client side by applying filters, sorting and aggregations. Large result sets may lead to unnecessary network utilization and client application processing. Application developers must carefully balance the processing between SQL Server and client. Filtering or aggregations can be performed by SQL Server and the final result set can be small. Limit the results set that arrives to the client. Any additional computations over the data, presentation and formatting are more appropriate on the client side, once the data is received.  

### Application doesn't fetch results fast enough

Let's use ADO.NET as an example. By default, DataSet/DataTable will fetch all rows to completion before client can access it. However, classes like [SqlDataReader](/dotnet/api/system.data.sqlclient.sqldatareader) allows the application developer to choose what to do after each row is fetched from the server. An application can fetch one row at a time and then process this row in conjunction with other complex operations. For example, it may write it to a file, send it to another application over the network, or simply wait for some period or for user input. However, the best practice is to fetch all results as fast as the client can, using a tight WHILE/FOR loop, store them in memory and only then do additional processing.

### Client application machine is under stress (I/O, memory, CPU)

Even when client application code is developed to fetch the results as fast as possible, system resource issues can cause the entire client process to be slow. For example, if the machine where the client application runs is constrained on resources say due to 100% CPU utilization, insufficient memory (all memory is consumed), or slow I/O where perhaps the application writes results or logs, the application may not be able to quickly fetch results. This can also lead to slow processing of incoming results and cause the SQL Server to wait with ASYNC_NETWORK_IO. 
To resolve this issue, diagnose the system where the application runs using tools like Performance monitor and eliminate any resource constraints. For example, you may need to stop other applications from running or fix any code issues in those applications, or you may need to upgrade the hardware on the system (if the applications have been tuned fully).

### NIC/Network

Slow network or faulty NIC can cause delay in network traffic and this will naturally delay fetching the results and communicating with SQL Server. Network delays are typically caused by network adapter driver issues, filter drivers, misconfigured/faulty firewalls or routers and overloaded networks due to traffic (less commonly). To diagnose such issues, you may need to collect a Network trace and look for packet resets and retransmits and eliminate those.

## See also:
[ASYNC_NETWORK_IO in sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql#async_network_io)
