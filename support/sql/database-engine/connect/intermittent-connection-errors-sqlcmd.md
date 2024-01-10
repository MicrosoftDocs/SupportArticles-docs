---
title: Troubleshooting intermittent connection errors with SQLCMD
description: This article provides symptoms and resolution for troubleshooting intermittent connection errors with SQLCMD.
ms.date: 01/03/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Intermittent connection errors with SQLCMD

This article helps you to resolve the intermittent connection errors using the command line utility **SQLCMD**.

## Symptoms

You see the following warning and error messages:

> WARNING: proc_procname returned HResult 0x2746, Level 16, State 1

> TCP Provider: An existing connection was forcibly closed by the remote host.

> SQLCMD.EXE : Sqlcmd: Error: Microsoft SQL Server Native Client 10.0 : Client unable to establish connection

One of the possible causes of these errors is unsupported driver.

## Questions to consider

Consider the following questions and check if any of them match your results:

- You collect the Network trace and find that TLS v1.0 and v1.1 are disabled, while TLS v1.2 is enabled. On the SQL Server, TLS v1.0, v1.1, and v1.2 are enabled on the Application server.

  :::image type="content" source="media/intermittent-connection-errors-with-sqlcmd/intermittent-connection-sqlcmd-errors.png" alt-text="TLS versions 1.0, 1.1, and 1.2 are enabled on the application server.":::

- Did you run the test "UDL Opens in new window or tab" on the Application server using Microsoft OLE DB Provider for SQL Server and SNAC 11 and the connection failed. The driver "Microsoft OLE DB Provider for SQL Server" is deprecated and doesn't support TLS 1.2.

- Did you perform an ODBC data source test on the Application Server as well using SQL Server Native Client 10.0? Is the following error message "The connection failed with SQL State: '08001' SQL Server Error: 10054 [Microsoft][SQL Server Native Client 10.0]TCP Provider: An existing connection was forcibly closed by remote host. [Microsoft][SQL Server Native Client 10.0]Client unable to establish connection." shown?

- Was an ODBC data source test using SQL Server Native Client 11 successful on the Application Server? This indicates that driver SQL Server Native Client 10.0 isn't supported. Therefore, Application Server uses the older version of Diffie-Hellman algorithm v1 while SQL Server uses the new version of Diffie-Hellman algorithm v2. So it's expected that you will face intermittent TLS failures if the algorithm version is different from the client SQL Server.

## Resolution

To resolve this issue, follow these steps:

1. Specify SQL Server Native Client 11 in the connection string.

   > [!NOTE]
   > Microsoft no longer supports SNAC 11. If you find any issues using SNAC 11, you must upgrade to a supported version of Microsoft driver before technical support can be provided.

1. It's recommended that you upgrade the application driver to a supported driver.
1. Use MSOLEDBSQL v18/ODBC v17 if you aren't using encryption for connection, but if you're using encryption for connection on the application server, use MSOLEDBSQL v19/ODBC v18 as these drivers come with encryption by default. For more information, see the following articles:

   - [Release notes for OLE DB Driver - OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server?view=sql-server-ver16&preserve-view=true)

   - [Release Notes for ODBC Driver for SQL Server on Windows - ODBC Driver for SQL Server](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows)
