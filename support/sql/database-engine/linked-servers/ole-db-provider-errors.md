---
title: Fix OLE DB Provider Errors for SQL Linked Servers
description: Resolve OLE DB provider errors 7403 and 7302 for linked servers in SQL Server. Learn how to fix provider registration, bitness mismatches, and connectivity issues.
ms.date: 04/14/2026
ms.reviewer: v-shaywood
ms.custom: sap:Linked Server and distributed queries
---

# Troubleshoot OLE DB provider errors for linked servers

This article helps you resolve OLE DB provider errors that occur when you run T-SQL queries through [linked servers](/sql/relational-databases/linked-servers/linked-servers-database-engine) or ad hoc queries by using [OPENROWSET](/sql/t-sql/functions/openrowset-transact-sql) or [OPENDATASOURCE](/sql/t-sql/functions/opendatasource-transact-sql) in SQL Server. These errors typically indicate that the OLE DB provider isn't installed, isn't registered, or doesn't match SQL Server's architecture.

## Symptoms

When you run T-SQL queries that use linked servers or ad hoc queries (by using `OPENROWSET` or `OPENDATASOURCE`), you receive one of the following error messages:

> The OLE DB provider "\<ProviderName>" has not been registered. (Microsoft SQL Server, Error: 7403)

> Cannot create an instance of OLE DB provider "\<ProviderName>" for linked server "\<LinkedServerName>". (Microsoft SQL Server, Error: 7302)

These errors can also occur after you:

- Migrate SQL Server from one computer to another.
- Restore the `master` database from a different server.

## Cause

SQL Server can't initialize the specified OLE DB provider for one of the following reasons:

- The OLE DB provider isn't installed on the server.
- The installed provider doesn't match SQL Server's bitness (x86 versus x64).
- The OLE DB provider is installed but not properly registered.

> [!NOTE]
> When you create a linked server with [sp_addlinkedserver](/sql/relational-databases/system-stored-procedures/sp-addlinkedserver-transact-sql), SQL Server doesn't immediately report errors related to provider availability. These errors appear only when you run a query that uses the linked server.

## Solution

To resolve the issue, follow the steps in each section in order.

### Verify the installed OLE DB providers

Check which OLE DB providers are registered on your SQL Server instance by using one of these methods:

- In **SQL Server Management Studio (SSMS)**, expand **Server Objects** > **Linked Servers** > **Providers** to see the list of registered OLE DB providers.
- Run the following query to see all defined linked servers and their associated providers:

  ```sql
  SELECT * FROM sys.servers;
  ```

  For more information about the columns returned, see [sys.servers (Transact-SQL)](/sql/relational-databases/system-catalog-views/sys-servers-transact-sql).

### Validate the provider installation

Confirm that the correct OLE DB provider is installed and matches SQL Server's architecture:

1. Check whether the provider that's required by your linked server is present in the provider list from [Verify the installed OLE DB providers](#verify-the-installed-ole-db-providers).
1. If the provider is missing, install it:

   - **For Microsoft OLE DB Driver for SQL Server (MSOLEDBSQL):** Download the latest version from the [Microsoft OLE DB Driver download page](/sql/connect/oledb/download-oledb-driver-for-sql-server).
   - **For third-party providers:** Contact the vendor to get the correct installer.

1. Make sure the provider version matches SQL Server's architecture. For example, install the 64-bit provider for a 64-bit SQL Server instance.

For more methods to validate the provider, see [OLE DB driver installation check](../install/windows/oledb-driver-install-check.md).

### Register the OLE DB provider

If the provider DLL exists on disk but isn't registered, manually register it:

1. Open an elevated Command Prompt.
1. Run the following command to register the DLL:

   ```console
   regsvr32 <ProviderDLLPath>
   ```

   For example, to register the SQL Server Native Client provider:

   ```console
   regsvr32 sqlncli11.dll
   ```

1. If you need both 32-bit and 64-bit providers, run the command in each respective environment. For example, use a 32-bit Command Prompt to register a 32-bit DLL.

For more information about registering OLE DB provider DLLs, see [OLE DB driver installation check](../install/windows/oledb-driver-install-check.md).

### Validate the provider connectivity

Use a Universal Data Link (UDL) file to confirm that the OLE DB provider can connect to the target data source:

1. Create a new *.udl* test file.
1. Double-click the *.udl* file to open the **Data Link Properties** dialog.
1. Select the **Provider** tab and choose the OLE DB provider from the list.
1. On the **Connection** tab, enter the server name and authentication details.
1. Select **Test Connection** to verify connectivity.

For detailed steps, see [Test OLE DB connectivity to SQL Server by using a UDL file](../connect/test-oledb-connectivity-use-udl-file.md).

## Related content

- [Create linked servers (SQL Server Database Engine)](/sql/relational-databases/linked-servers/create-linked-servers-sql-server-database-engine)
- [OLE DB Driver for SQL Server](/sql/connect/oledb/oledb-driver-for-sql-server)
- [sp_addlinkedsrvlogin (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-addlinkedsrvlogin-transact-sql)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
