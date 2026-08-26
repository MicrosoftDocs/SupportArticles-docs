---
title: Troubleshoot intermittent outbound connection errors - Azure App Service
description: Troubleshoot Azure App Service outbound connection errors, identify SNAT port exhaustion, and apply fixes to restore reliable external connectivity.
ms.topic: troubleshooting
ms.date: 08/24/2026
ms.custom: sap:Networking,security-recommendations
ms.author: kaushika
author: kaushika-msft
manager: dcscontentpm
ms.reviewer: msangapu, kaushika
ms.service: azure-app-service
---

# Troubleshoot intermittent outbound connection errors in Azure App Service

## Summary

This article helps you troubleshoot intermittent outbound connection errors and related performance issues in [Azure App Service](/azure/app-service/overview). It provides more information on, and troubleshooting methodologies for, exhaustion of Source Network Address Translation (SNAT) ports. 

## Symptoms

Applications and functions hosted on App Service might exhibit one or more of the following issues:

- Slow response times on all or some of the instances in a service plan.
- Intermittent **5xx** or **Bad Gateway** errors.
- Time-out error messages.
- Inability to connect to external endpoints (like SQLDB, Service Fabric, or other app services).

## Cause

The major cause for intermittent connection issues is hitting a limit while making new outbound connections. The limits you can hit include:

- Transmission Control Protocol (TCP) connections: There's a limit on the number of outbound connections that you can make. The limit on outbound connections is associated with the size of the worker used.
- SNAT ports: [Outbound connections in Azure](/azure/load-balancer/load-balancer-outbound-connections) describes SNAT port restrictions and how they affect outbound connections. Azure uses source network address translation (SNAT) and load balancers (not exposed to customers) to communicate with public IP addresses. Each instance on App Service is initially given a preallocated number of *128* SNAT ports. The SNAT port limit affects opening connections to the same address and port combination. If your app creates connections to a mix of address and port combinations, you don't use up your SNAT ports. The SNAT ports are used up when you have repeated calls to the same address and port combination. Once a port is released, the port is available for reuse as needed. Azure Load Balancer reclaims SNAT ports from closed connections only after waiting for four minutes.

When applications or functions rapidly open a new connection, they can quickly exhaust their preallocated quota of 128 ports. They're then blocked until a new SNAT port becomes available, either through dynamically allocating more SNAT ports, or through reuse of a reclaimed SNAT port. If your app runs out of SNAT ports, it has intermittent outbound connectivity issues.

## Troubleshooting

There are solutions that let you avoid SNAT port limitations. They include:

- **Connection pools**: By pooling your connections, you avoid opening new network connections for calls to the same address and port.
- **Service endpoints**: You don't have a SNAT port restriction to services secured with service endpoints.
- **Private endpoints**: You don't have a SNAT port restriction to services secured with private endpoints.
- **NAT gateway**: With a NAT gateway, you have 64 thousand outbound SNAT ports that are usable by the resources sending traffic through it.

To avoid SNAT port problems, prevent the creation of new connections repetitively to the same host and port. Connection pools are a way to solve SNAT port problems.

If your destination is an Azure service that supports service endpoints, you can avoid SNAT port exhaustion issues by using [regional virtual network integration](/azure/app-service/overview-vnet-integration) and service endpoints or private endpoints. When you use regional virtual network integration and place service endpoints on the integration subnet, your app outbound traffic to those services won't have outbound SNAT port restrictions. Likewise, if you use regional virtual network integration and private endpoints, you won't have any outbound SNAT port issues to that destination. 

If your destination is an external endpoint outside of Azure, [using a NAT gateway](/azure/app-service/networking/nat-gateway-integration) gives you 64 thousand outbound SNAT ports. It also gives you a dedicated outbound address that you share with no one. 

If possible, improve your code to use connection pools and avoid the entire situation. It isn't always possible to change code fast enough to mitigate this situation. 

For cases where you can't change your code in time, take advantage of the other solutions. The best solution to the problem is to combine all of the solutions as best you can. Try to use service endpoints and private endpoints to Azure services and the NAT gateway for the rest. 

To learn more about strategies for mitigating SNAT port exhaustion, see [Use SNAT for outbound connections](/azure/load-balancer/load-balancer-outbound-connections). Of these strategies, the following are applicable to apps and functions hosted on App Service.

### Use connection pooling

- For pooling HTTP connections, see [Pool HTTP connections with HttpClientFactory](/aspnet/core/performance/performance-best-practices#pool-http-connections-with-httpclientfactory).
- For information on SQL Server connection pooling, see [SQL Server Connection Pooling (ADO.NET)](/dotnet/framework/data/adonet/sql-server-connection-pooling).

The following resources describe implementing connection pooling by different solution stacks.

#### Node

By default, Node.js doesn't keep connections alive. Resources include:

- [MySQL](https://github.com/mysqljs/mysql#pooling-connections)
- [MongoDB](https://www.mongodb.com/docs/manual/administration/connection-pool-overview)
- [PostgreSQL](https://node-postgres.com/features/pooling)
- [SQL Server](https://github.com/tediousjs/node-mssql#connection-pools)

HTTP keep-alive resources include:

- [agentkeepalive](https://www.npmjs.com/package/agentkeepalive)
- [Node.js v13.9.0 documentation](https://nodejs.org/api/http.html)

#### Java

Java Database Connectivity (JDBC) connection pooling resources include:

- [Tomcat 8](https://tomcat.apache.org/tomcat-8.0-doc/jdbc-pool.html)
- [C3p0](https://github.com/swaldman/c3p0)
- [HikariCP](https://github.com/brettwooldridge/HikariCP)
- [Apache DBCP](https://commons.apache.org/proper/commons-dbcp/)

HTTP connection pooling resources include:

- [HttpClient Overview](https://hc.apache.org/httpcomponents-client-5.4.x/)

#### PHP

Although PHP doesn't support connection pooling, you can try using persistent database connections to your back-end server. Resources include:

- **MySQL server**
   - [MySQLi connections](https://www.php.net/manual/mysqli.quickstart.connections.php) for newer versions
   - [mysql_pconnect](https://www.php.net/manual/function.mysql-pconnect.php) for older versions of PHP

- **Other data sources**
   - [PHP connection management](https://www.php.net/manual/pdo.connections.php)

#### Python

Python connection pooling resources include:

- [MySQL](https://dev.mysql.com/doc/connector-python/en/connector-python-connection-pooling.html)
- [MariaDB](https://mariadb.com/docs/connectors/mariadb-connector-python/api/pool/)
- [PostgreSQL](https://www.psycopg.org/docs/pool.html)
- [Pyodbc](https://github.com/mkleehammer/pyodbc/wiki/The-pyodbc-Module#pooling)
- [SQLAlchemy](https://docs.sqlalchemy.org/en/20/core/pooling.html)

#### HTTP 

HTTP connection pooling resources include:

- [Requests](https://requests.readthedocs.io/en/latest/user/advanced/#keep-alive)
- [Urllib3](https://urllib3.readthedocs.io/en/stable/reference/urllib3.connectionpool.html)

### Reuse connections

For more resources and examples on managing connections in Azure Functions, see [Manage connections in Azure Functions](/azure/azure-functions/manage-connections).

### Use less aggressive retry logic

For more guidance and examples, see [Retry pattern](/azure/architecture/patterns/retry).

### Use keepalives to reset the outbound idle timeout

For implementing keepalives for Node.js apps, see [My node application is making excessive outbound calls](/azure/app-service/app-service-web-nodejs-best-practices-and-troubleshoot-guide#my-node-application-is-making-excessive-outbound-calls).

### More guidance specific to App Service

Further App Service-specific guidance includes:

- A [load test](/azure/devops/test/load-test/app-service-web-app-performance-test) should simulate real-world data in a steady feeding speed. Testing apps and functions under real-world stress can identify and resolve SNAT port exhaustion issues ahead of time.
- Ensure that the back-end services can return responses quickly. For troubleshooting performance issues with Azure SQL Database, review [Troubleshoot Azure SQL Database performance issues with Intelligent Insights](/azure/azure-sql/database/intelligent-insights-troubleshoot-performance#recommended-troubleshooting-flow).
- Scale out the App Service plan to more instances. For more information on scaling, see [Scale an app in Azure App Service](/azure/app-service/manage-scale-up). Each worker instance in an app service plan is allocated a number of SNAT ports. If you spread your usage across more instances, you might get the SNAT port usage per instance below the recommended limit of 100 outbound connections, per unique remote endpoint.
- Consider moving to [App Service Environment](/azure/app-service/environment/using-an-ase), where you're allotted a single outbound IP address, and the limits for connections and SNAT ports are higher. In an App Service Environment, the number of SNAT ports per instance is based on the [Azure load balancer preallocation table](/azure/load-balancer/load-balancer-outbound-connections#snatporttable). For example, an App Service Environment with 1-50 worker instances has 1,024 preallocated ports per instance, while an App Service Environment with 51-100 worker instances has 512 preallocated ports per instance.

Avoiding the outbound TCP limits is easier to solve, as the limits are set by the size of your worker. You can see the limits in [Sandbox Cross VM Numerical Limits - TCP Connections](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#cross-vm-numerical-limits).

|Limit name|Description|Small (A1)|Medium (A2)|Large (A3)|Isolated tier (App Service Environment)|
|---|---|---|---|---|---|
|Connections|Number of connections across entire VM|1920|3968|8064|16,000|

To avoid outbound TCP limits, either increase the size of your workers, or scale out horizontally.

## Diagnose outbound connection limits in App Service

Knowing the two types of outbound connection limits and what your app does makes it easier to troubleshoot. If you know that your app makes many calls to the same storage account, you might suspect a SNAT limit. If your app creates many calls to endpoints all over the internet, you might be reaching the virtual machine (VM) limit.

If you don't know the application behavior enough to determine the cause quickly, there are tools and techniques available in App Service to help with that determination.

### Find SNAT port allocation information

Use [App Service Diagnostics](/azure/app-service/overview-diagnostics) to find SNAT port allocation information, and observe the SNAT ports allocation metric of an App Service site. To find SNAT port allocation information, see the following steps:

1. To access App Service diagnostics, go to your App Service web app or App Service Environment in the [Azure portal](https://portal.azure.com/). In the sidebar menu, select **Diagnose and solve problems**.
1. Select **Availability and Performance** category.
1. Select the **SNAT Port Exhaustion** tile in the list of available tiles under the category. Keep it below 128.

If you can't determine this using the previous steps, open a support ticket.

Because SNAT port usage isn't available as a metric, you can't autoscale based on SNAT port usage or configure autoscale based on the SNAT ports allocation metric.

### TCP connections and SNAT ports

TCP connections and SNAT ports aren't directly related. The **Diagnose and Solve Problems** management page of any App Service app includes a TCP connections usage detector. Search for the phrase *TCP connections* to find it.

Be aware of the following points when using the TCP connections usage detector:

- SNAT ports are only used for external network flows, while the total TCP connections includes local loopback connections.
- Different flows can share SNAT ports if the flows differ in protocol, IP address, or port. The TCP connections metric counts every TCP connection.
- The TCP connections limit happens at the worker instance level. Azure outbound load balancing doesn't use the TCP connections metric for SNAT port limiting.
- You can find the TCP connections limits in [Sandbox Cross VM Numerical Limits - TCP Connections](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#cross-vm-numerical-limits).
- Existing TCP sessions fail when new outbound TCP sessions are added from an App Service source port. Either use a single IP or reconfigure backend pool members to avoid conflicts.

|Limit name|Description|Small (A1)|Medium (A2)|Large (A3)|Isolated tier (App Service Environment)|
|---|---|---|---|---|---|
|Connections|Number of connections across entire VM|1920|3968|8064|16,000|

### WebJobs and database connections
 
If SNAT ports are exhausted and WebJobs can't connect to a SQL Server database, no metric shows how many connections each individual web application process opens. To find the problematic WebJob, move several WebJobs to another App Service plan to see if the situation improves or if an issue remains in one of the plans. Repeat the process until you find the problematic WebJob.

## References

- [SNAT with App Service](https://4lowtherabbit.github.io/blogs/2019/10/SNAT/)
- [Troubleshoot slow app performance issues in Azure App Service](/azure/app-service/troubleshoot-performance-degradation)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
