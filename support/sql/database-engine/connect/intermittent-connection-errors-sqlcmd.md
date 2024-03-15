---
title: Intermittent connection errors occur when the SQLCMD tool is used
description: This article provides a resolution for resolving intermittent connection errors that are generated when you use the SQLCMD tool.
ms.date: 03/15/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshoot intermittent connection errors when you use SQLCMD

This article helps you resolve intermittent connection "OS error 10054" issues that occur when you use the SQLCMD command line tool.

## Errors

You receive the following warning and error messages:

> WARNING: proc_procname returned HResult 0x2746, Level 16, State 1

> TCP Provider: An existing connection was forcibly closed by the remote host.

> SQLCMD.EXE : Sqlcmd: Error: Microsoft SQL Server Native Client 10.0 : Client unable to establish connection

One possible cause of these errors is an unsupported driver.

## Questions to consider

Review the following scenarios to determine whether any match your issue:

- You collect a network trace and learn that TLS 1.0 and 1.1 are disabled and TLS 1.2 is enabled. On the server that's running SQL Server, TLS 1.0, 1.1, and 1.2 are enabled on the application server.

  :::image type="content" source="media/intermittent-connection-errors-with-sqlcmd/intermittent-connection-sqlcmd-errors.png" alt-text="Screenshot that shows that TLS 1.0, 1.1, and 1.2 are enabled on the application server.":::

- You run a [UDL test](test-oledb-connectivity-use-udl-file.md) on the application server by using both the Microsoft OLE DB Provider for SQL Server and the SNAC 11 provider. The connection fails. You also receive a message that states that the "Microsoft OLE DB Provider for SQL Server" driver is deprecated and doesn't support TLS 1.2.

- The application server uses SQL Server Native Client 11 to successfully test the ODBC data source. If SQL Server Native Client 10.0 isn't supported, you might receive the following error message:

  > The connection failed with SQL State: '08001' SQL Server Error: 10054 [Microsoft][SQL Server Native Client 10.0]TCP Provider: An existing connection was forcibly closed by remote host. [Microsoft][SQL Server Native Client 10.0] Client unable to establish connection.

  This message might be displayed because the application server uses the older version of Diffie-Hellman algorithm (v1) and SQL Server uses the newer version (v2). This mismatch causes intermittent TLS failures.

## Resolution

To resolve these issues, follow these steps:

1. Specify SQL Server Native Client 11 in the connection string.

   > [!NOTE]
   > Microsoft no longer supports SNAC 11. If you experience any issues while you use SNAC 11, you must upgrade to a supported version of the Microsoft driver before technical support can be provided.

1. Upgrade the application driver to a supported driver.
1. Use MSOLEDBSQL v18 or ODBC v17 if you aren't using encryption for the connection. If you are using encryption for the connection on the application server, use MSOLEDBSQL v19 or ODBC v18. By default, these drivers are included together with the encryption. For more information, see the following articles:

   - [Release notes for OLE DB Driver - OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server?view=sql-server-ver16&preserve-view=true)

   - [Release Notes for ODBC Driver for SQL Server on Windows - ODBC Driver for SQL Server](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows)

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
