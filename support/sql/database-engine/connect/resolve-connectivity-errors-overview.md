---
title: Troubleshoot connectivity issues in SQL Server
description: Provides an overview of common connectivity issues in SQL Server and describes the tools to troubleshoot the issues.
ms.date: 01/20/2025
ms.custom: sap:Database Connectivity and Authentication
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: jopilov
---
# Troubleshoot connectivity issues in SQL Server

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4009936

There are various causes for connectivity issues in SQL Server. This article series helps you troubleshoot the most common SQL Server connectivity issues and describes the tools and methods you can use for troubleshooting.

> [!NOTE]
> If multiple SQL Server instances in your environment are impacted, or the issue is intermittent, it usually indicates Windows policy or networking issues. 

## Preparation

Before you start troubleshooting, check [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md) for logs that you should collect to assist with troubleshooting. There's also a list of quick actions to avoid common connectivity errors when working with SQL Server.

## Common connectivity issues

Use the following list to navigate to the appropriate article page for detailed troubleshooting steps for your scenario:

- [A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md)

- [Can't generate SSPI context](cannot-generate-sspi-context-error.md)

- [Login failed for user](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context) which covers the following login errors:

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

The following sections provide details for various tools and procedures to troubleshoot different connectivity errors:

### Configure Windows Firewall to work with SQL Server

[Configure firewalls to work with SQL Server](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?context=/troubleshoot/sql/context/context) describes how to configure Windows Firewall for successful connections to instances.

### Test an OLEDB or ODBC connection to SQL Server

- If you want to quickly test a connection from a client machine to a SQL Server instance, you can configure a UDL file. For more information, see [Test connections to SQL Server by using a Universal Data Link (UDL) file](../connect/test-oledb-connectivity-use-udl-file.md).

- You can also use the ODBC Data Sources (64-bit) or ODBC Data Sources (32-bit) Administrator to configure and test an ODBC connection to SQL Server. For more information, see [ODBC Data Source Administrator DSN options](/sql/connect/odbc/windows/odbc-administrator-dsn-creation#create-a-new-data-source-to-sql-server---screen-1).

### Discover if a port is blocked with PortQryUI

You can use the PortQryUI tool (a graphical user interface (GUI) port scanner) to help troubleshoot connectivity issues. For more information, see [Use PortQryUI tool with SQL Server](using-portqrytool-sqlserver.md).

### Find which ports SQL Server listening on

This article [Check whether SQL Server is listening on dynamic or static ports](../connect/static-or-dynamic-port-config.md) provides steps to identify which ports SQL Server is listening on.

### Get a detailed diagnostic report with SQLCheck

Microsoft product support engineers frequently use [SQLCheck](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK), which is a tool they built to diagnose causes of connection failures. You can follow the [instructions](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) to download and collect the SQLCheck report for in-depth analysis. 

### Use Kerberos Configuration Manager

To identify and resolve Service Principal Name (SPN) issues, you can use the Kerberos Configuration Manager. For more information, see 
[Use Kerberos Configuration Manager to fix SPN issues](../connect/cannot-generate-sspi-context-error.md#fix-the-error-with-kerberos-configuration-manager-recommended).

### Collect and analyze a network trace with SQLTrace and SQLNAUI

In many cases, a network trace might be the most effective tool to investigate network failures. You can follow the steps in [Collect network traces on the client and server](intermittent-periodic-network-issue.md#collect-network-traces-on-the-client-and-server) to investigate failures. Then, you can analyze the network trace using the [SQL Network Analyzer UI SQLNAUI](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI).


## See also

[CSS SQL Connectivity Wiki](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SSPICLIENT)
