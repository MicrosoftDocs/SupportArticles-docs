---
title: Troubleshoot connectivity issues in SQL Server
description: Get an overview of SQL Server connectivity errors, common causes of connection failure, and a troubleshooting overview with tools and methods to diagnose and fix them.
ms.date: 05/20/2026
ms.custom: sap:Database Connectivity and Authentication
author: aartig13
ms.author: aartigoyle
ms.reviewer: jopilov, v-shaywood
---
# Troubleshoot connectivity issues in SQL Server

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4009936

## Summary

SQL Server connectivity errors can have many causes, including network configuration, authentication, name resolution, firewall rules, and Transport Layer Security (TLS) settings. This troubleshooting overview helps you identify the category of a connection failure, provides links to focused articles for each common error, and lists the diagnostic tools that Microsoft support engineers use to investigate SQL Server connectivity problems.

> [!NOTE]
> If multiple SQL Server instances in your environment are affected, or the issue is intermittent, a Windows policy or network problem is usually the root cause rather than a SQL Server configuration problem.

## Before you start

Before you start troubleshooting, see [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md) for the logs to collect and a list of quick actions that help you avoid common connectivity errors when you work with SQL Server.

## Categories of SQL Server connectivity errors

Most connectivity errors fall into one of the following categories. Use this table to match your symptom to a category, and then go to the linked article for detailed steps.

| Category | Typical symptom | Where to start |
|---|---|---|
| Network or instance reachability | The client can't reach the server or the named instance. | [Network-related or instance-specific error](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md) |
| Authentication and Kerberos | Sign-in fails or the client can't generate an SSPI context. | [Cannot generate SSPI context](cannot-generate-sspi-context-error.md) and [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context) |
| Timeouts and dropped connections | Connections take too long or are closed unexpectedly. | [Timeout expired](../connect/timeout-expired-error.md) and [An existing connection was forcibly closed](../connect/tls-exist-connection-closed.md) |
| Encryption and certificates | The certificate isn't trusted or the TLS handshake fails. | [The certificate chain was issued by an authority that is not trusted](../connect/error-message-when-you-connect.md) |
| Access validation | Token-based server access validation fails. | [Token-based server access validation failed](../connect/cannot-connect-remotely.md) |

## Common connectivity issues

Use the following list to go to the article that matches your scenario:

- [A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md)
- [Can't generate SSPI context](cannot-generate-sspi-context-error.md)
- [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context), which covers the following sign-in errors:

  - > "Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'"
  - > "Login failed for user '(null)'"
  - > "Login failed for user (empty)"
  - > "Login failed for user '\<username\>'"
  - > "Login failed for user '\<domain>\\\<username>'"

- [Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding](../connect/timeout-expired-error.md)
- [An existing connection was forcibly closed by the remote host](../connect/tls-exist-connection-closed.md)
- [Token-based server access validation failed with an infrastructure error. Check for previous errors](../connect/cannot-connect-remotely.md)
- [The certificate chain was issued by an authority that is not trusted](../connect/error-message-when-you-connect.md)

## Tools and methods to troubleshoot connectivity issues

The following sections describe tools and procedures that help you diagnose different SQL Server connectivity errors.

### Set up Windows Firewall to work with SQL Server

See [Configure firewalls to work with SQL Server](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?context=/troubleshoot/sql/context/context) for steps to set up Windows Firewall so that clients can connect to your SQL Server instance.

### Test an OLE DB or ODBC connection to SQL Server

- To quickly test a connection from a client computer to a SQL Server instance, set up a Universal Data Link (UDL) file. For more information, see [Test connections to SQL Server by using a Universal Data Link (UDL) file](../connect/test-oledb-connectivity-use-udl-file.md).
- You can also use **ODBC Data Sources (64-bit)** or **ODBC Data Sources (32-bit)** to set up and test an ODBC connection to SQL Server. For more information, see [ODBC Data Source Administrator DSN options](/sql/connect/odbc/windows/odbc-administrator-dsn-creation#create-a-new-data-source-to-sql-server---screen-1).

### Check whether a port is blocked with PortQryUI

Use the PortQryUI tool, a graphical port scanner, to check whether a required SQL Server port is blocked. For more information, see [Use PortQryUI tool with SQL Server](using-portqrytool-sqlserver.md).

### Find which ports SQL Server is listening on

See [Check whether SQL Server is listening on dynamic or static ports](../connect/static-or-dynamic-port-config.md) for steps to identify the TCP ports that your SQL Server instance is listening on.

### Get a detailed diagnostic report with SQLCheck

Microsoft product support engineers often use [SQLCheck](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK), a tool that diagnoses causes of connection failures. Follow the linked instructions to download SQLCheck and collect a report for in-depth analysis.

### Use Kerberos Configuration Manager to fix SPN issues

To identify and fix Service Principal Name (SPN) issues, use the Kerberos Configuration Manager. For more information, see [Use Kerberos Configuration Manager to fix SPN issues](../connect/cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager).

### Collect and analyze a network trace with SQLTrace and SQLNAUI

In many cases, a network trace is the most effective way to investigate network failures. Follow the steps in [Collect network traces on the client and server](intermittent-periodic-network-issue.md#collect-network-traces-on-the-client-and-server), and then analyze the trace with the [SQL Network Analyzer UI (SQLNAUI)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI).

## Frequently asked questions

### Which article should I start with if I don't know the exact error?

Start with [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md) to collect baseline logs. Then, use the [Categories of SQL Server connectivity errors](#categories-of-sql-server-connectivity-errors) table to match your symptom to a focused article.

### The issue happens only sometimes. What should I collect?

For intermittent issues, collect a network trace on both the client and the server at the same time. See [Collect network traces on the client and server](intermittent-periodic-network-issue.md#collect-network-traces-on-the-client-and-server).

### How do I tell whether the issue is name resolution, authentication, or the network?

Check the error text and the stage at which it occurs. Name resolution failures usually mention that the server wasn't found or can't be reached. You can confirm them by using `ping` and `nslookup` against the server name. Network or port issues surface as connection refused or timeout errors. You can isolate these issues by using [PortQryUI](using-portqrytool-sqlserver.md). Authentication problems appear after the TCP connection succeeds, as sign-in failures or SSPI errors. See [Can't generate SSPI context](cannot-generate-sspi-context-error.md) and [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context).

### What's the difference between a TCP connection failure and a TLS handshake failure?

A TCP connection failure happens before any SQL Server traffic is exchanged. The client can't open a socket to the server's port, usually because of a firewall, a wrong port, or a stopped service. A TLS handshake failure happens after the TCP connection is established, when the client and server can't agree on a protocol version, cipher, or certificate. For TLS issues, see [The certificate chain was issued by an authority that is not trusted](../connect/error-message-when-you-connect.md) and [An existing connection was forcibly closed by the remote host](../connect/tls-exist-connection-closed.md).

### Which logs should I collect before I contact Microsoft Support?

Collect the SQL Server error log, the Windows System and Application event logs from both the client and server, a [SQLCheck](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) report from the server, and simultaneous network traces from the client and server during a repro. For the full list, see [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md) and [Collect network traces on the client and server](intermittent-periodic-network-issue.md#collect-network-traces-on-the-client-and-server).

### Where can I find more community guidance?

See the [CSS SQL Networking Tools wiki](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki) for tool documentation and troubleshooting notes maintained by Microsoft support.

## Related content

- [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md)
- [MSSQLSERVER_18456 database engine error](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context)
- [CSS SQL Connectivity wiki](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SSPICLIENT)
