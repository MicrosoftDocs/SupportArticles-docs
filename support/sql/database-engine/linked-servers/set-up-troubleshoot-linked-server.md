---
title: Set up and troubleshoot a linked server to an Oracle database
description: This article describes how to set up a linked server from a computer that is running Microsoft SQL Server to an Oracle database and provides basic troubleshooting steps for common errors you may experience when you set up a linked server to an Oracle database.
ms.date: 07/11/2023
ms.custom: sap:Database Engine
---
# Set up and troubleshoot a linked server to an Oracle database in SQL Server

This article describes how to set up a linked server from a computer that is running Microsoft SQL Server to an Oracle database and provides basic troubleshooting steps for common errors you may experience when you set up a linked server to an Oracle database.

_Original product version:_ &nbsp; Microsoft SQL Server 2005 Standard Edition, Microsoft SQL Server 2005 Developer Edition, Microsoft SQL Server 2005 Enterprise Edition, Microsoft SQL Server 2005 Express Edition, Microsoft SQL Server 2005 Workgroup Edition  
_Original KB number:_ &nbsp; 280106

## Summary

This article describes how to set up a linked server from a computer that is running Microsoft SQL Server to an Oracle database and provides basic troubleshooting steps for common errors you may experience when you set up a linked server to Oracle. Most of the information in this article is applicable to environments that are configured to use Microsoft OLEDB Provider for Oracle (MSDAORA). Avoid using this feature in new development work, and plan to modify applications that currently use this feature. Instead, use Oracle's OLE DB provider.

For more information on configuring a linked server using Oracle's OLEDB provider, review [How to get up and running with Oracle and Linked Servers](https://techcommunity.microsoft.com/t5/sql-server-support/how-to-get-up-and-running-with-oracle-and-linked-servers/ba-p/318636).

> [!IMPORTANT]
> The current version of the Microsoft ODBC Driver for Oracle complies with the ODBC 2.5 specification, while the OLE DB Provider for Oracle is a native Oracle 7 OCI API provider. Both the driver and provider use the SQL*Net Client (or Net8 client for Oracle 8x) and the Oracle Call Interface (OCI) library, and other Oracle client components, to connect to Oracle databases and retrieve data. The Oracle client components are important, and must be configured correctly to successfully connect to Oracle databases using both the driver and the provider.

From Microsoft Data Access Components (MDAC) version 2.5 and later versions, both the Microsoft ODBC Driver and OLE DB Provider support ONLY Oracle 7 and Oracle 8i with the following limitations:

- Oracle 8.x-specific data types, such as CLOB, BLOB, BFILE, NCHAR, NCLOB, and NVARCHAR2, are not supported.

- The Unicode feature against Oracle 7.x and 8.x servers is not supported.

- Multiple Oracle client instances, or multiple Oracle homes, are not supported because they rely on the first occurrence of the Oracle home in the SYSTEM PATH variable.

- Returning multiple resultsets from a stored procedure or batch SQL statement is not supported using ADO or OLEDB.

- Nested outer joins are not supported.

- XML persistence is not supported.

- Version greater than 8i are not supported using these drivers.

> [!NOTE]
> The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## Steps to set up a linked server to Oracle

1. You must install the Oracle client software on the computer that is running SQL Server where the linked server is set up.
2. Install the driver you want on the computer that is running SQL Server. Microsoft only supports Microsoft OLE DB Provider for Oracle and Microsoft ODBC Driver for Oracle. If you use a third-party provider or a third-party driver to connect to Oracle, you must contact the respective vendor for any problems that you may experience by using their provider or driver.
3. If you use Microsoft OLE DB Provider for Oracle and Microsoft ODBC Driver for Oracle, consider the following:

   - Both the OLE DB provider and the ODBC driver that are included with Microsoft Data Access Components (MDAC) require SQL*Net 2.3.x, or a later version. You must install the Oracle 7.3.x client software, or a later version, on the client computer. The client computer is the computer that is running SQL Server.

   - Make sure that you have MDAC 2.5, or a later version, installed on the computer that is running SQL Server. With MDAC 2.1, or with an earlier version, you cannot connect to databases that use Oracle 8. *x* or a later version.

   - To enable MDAC 2.5, or later versions, to work with Oracle client software, the registry must be modified on the client computer that is running SQL Server as indicated in the following table.

        ```console
        Oracle
        Client               Microsoft Windows 2000 and later versions
        --------------------------------------------------------------------------
  
        7.x                  [HKEY_LOCAL_MACHINE\SOFTWARE
                             Microsoft\MSDTC\MTxOCI]
                             "OracleXaLib"="xa73.dll"
                             "OracleSqlLib"="SQLLib18.dll"
                             "OracleOciLib"="ociw32.dll"

        8.0                  [HKEY_LOCAL_MACHINE\SOFTWARE
                             \Microsoft\MSDTC\MTxOCI]
                             "OracleXaLib"="xa80.dll"
                             "OracleSqlLib"="sqllib80.dll"
                             "OracleOciLib"="oci.dll"

        8.1                  [HKEY_LOCAL_MACHINE\SOFTWARE
                             \Microsoft\MSDTC\MTxOCI]
                             "OracleXaLib"="oraclient8.dll"
                             "OracleSqlLib"="orasql8.dll"
                             "OracleOciLib"="oci.dll"
        ```

4. Restart the computer that is running SQL Server after you install the Oracle client software.
5. On the computer that is running SQL Server, set up a linked server by using the following script.

    ```sql
    -- Adding linked server (from SQL Server Books Online):
    /* sp_addlinkedserver [@server =] 'server'[, [@srvproduct =] 'product_name']
     [, [@provider =] 'provider_name']
     [, [@datasrc =] 'data_source']
     [, [@location =] 'location'] [, [@provstr =] 'provider_string'] 
     [, [@catalog =] 'catalog']
    */

    EXEC sp_addlinkedserver 'Ora817Link', 'Oracle', 'MSDAORA', 'oracle817'

    -- Adding linked server login:
    /* sp_addlinkedsrvlogin [@rmtsrvname =] 'rmtsrvname'[,[@useself =] 'useself']
     [,[@locallogin =] 'locallogin']
     [,[@rmtuser =] 'rmtuser']
     [,[@rmtpassword =] 'rmtpassword']
    */

    EXEC sp_addlinkedsrvlogin 'Ora817Link', 'FALSE',NULL, 'scott', 'tiger'

    -- Help on the linked server:
    EXEC sp_linkedservers
    EXEC sp_helpserver
    select * from sysservers
    ```

    > [!NOTE]
    > If you use Microsoft ODBC Driver for Oracle, you can use the `@datasrc` parameter to specify a DSN name. For a DSN-less connection, the provider string is supplied through the *@provstr* parameter. With Microsoft OLE DB Provider for Oracle, use the Oracle server alias that is configured in the TNSNames.Ora file for the *@datasrc* parameter. For more information, see the "sp_addlinkedserver" topic in SQL Server Books Online.

## Common error messages and how to troubleshoot them

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

You can use either of the following two methods to retrieve extended information about any error that you experience when you execute a distributed query.

- Method 1

  Connect to SQL Server using SQL Server Management Studio and run the following code to turn on trace flag 7300.

    ```sql
    DBCC Traceon(7300)
    ```

- Method 2

  Capture the "OLEDB Errors" event that is located in the "Errors and Warnings" event category in SQL Profiler. The error message format is the following:

  > Interface::Method failed with hex-error code.

  You can look up hex-error code in the Oledberr.h file that is included with the [MDAC Software Development Kit (SDK)](https://www.microsoft.com/download/details.aspx?id=21995).

The following is a list of common error messages that may occur, together with information about how to troubleshoot the error message.

> [!NOTE]
> If you are using SQL Server 2005 or later versions, these error messages may be slightly different. However, the error IDs of these error messages are same as them in older versions of SQL Server. Therefore, you can identify them by the error IDs.
For performance-related issues, search SQL Server Books Online for the **Optimizing Distributed Queries** topic.

- Message 1

  > Error 7399: The OLE DB provider "%ls" for linked server "%ls" reported an error. %ls

  Turn on trace flag 7300 or use SQL Profiler to capture the **OLEDB Errors** event to retrieve extended OLEDB error information.

- Message 2a

  > "ORA-12154: TNS:could not resolve service name"

- Message 2b

  > "The Oracle(tm) client and networking components were not found. These components are supplied by Oracle Corporation and are part of the Oracle Version 7.3.3 (or greater) client software installation"

  These errors occur when there is a connectivity issue to Oracle server. Review [Techniques to troubleshoot connectivity issues to Oracle server](#techniques-to-troubleshoot-connectivity-issues-to-oracle-server) section below for additional troubleshooting.

- Message 3

  > Error 7302: Cannot create an instance of OLE DB provider ‘MSDAORA’ for linked server "%ls".

  Make sure that the MSDAORA.dll file is registered correctly. (The MSDAORA.dll file is the Microsoft OLE DB provider for Oracle file.) Use RegSvr32.exe to register Microsoft OLE DB Provider for Oracle.

  > [!NOTE]
  > If you use a third-party Oracle provider, and your Oracle provider cannot run outside a SQL Server process, enable it to run in-process by changing the provider options. To change the provider options, use one of the following methods:
  >
  > - Method 1
  > Locate the following registry key. Then, change the value of the AllowInProcess (DWORD) entry to 1. This registry key is located under the corresponding provider name: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Providers\ProviderName`.
  >
  > - Method 2
  > Follow these steps to set the **Allow inprocess** option for providers using SQL Server Management Studio (SSMS).
  > 1. Open SSMS and connect to your SQL Server instance.
  > 1. In **Object Explorer**, navigate to **Server Objects** > **Linked Servers** > **Providers**.
  > 1. Right-click the provider you want to configure and select **Properties**.
  > 1. In the **Provider Options** window, check the **Enable** box for the **Allow inprocess** option.

- Message 4

  > Error 7303: Cannot initialize the data source object of OLE DB provider ‘MSDAORA’ for linked server "%ls". [OLE/DB provider returned message: ORA-01017: invalid username/password; logon denied] OLE DB error trace [OLE/DB Provider 'MSDAORA' IDBInitialize::Initialize returned 0x80040e4d].

  This error message indicates that the linked server does not have correct login mapping. You can execute the `sp_helplinkedsrvlogin` stored procedure to set the login information correctly. Also, verify that you have specified the correct parameters for the linked server configuration.

- Message 5

  > Error 7306: Cannot open the table ' %ls' from OLE DB provider 'MSDAORA' for linked server "%ls". The specified table does not exist. [OLE/DB provider returned message: Table does not exist.][OLE/DB provider returned message: ORA-00942: table or view does not exist] OLE DB error trace [OLE/DB Provider 'MSDAORA' IOpenRowset::OpenRowset returned 0x80040e37: The specified table does not exist.].

  > Error 7312: Invalid use of schema and/or catalog for OLE DB provider '%ls' for linked server "%ls". A four-part name was supplied, but the provider does not expose the necessary interfaces to use a catalog and/or schema.

  > Error 7313: An invalid schema or catalog was specified for the provider "%ls" for linked server "%ls".

  > Error 7314: The OLE DB provider "%ls" for linked server "%ls" does not contain the table "%ls". The table either does not exist or the current user does not have permissions on that table.

  If you receive these error messages, a table may be missing in the Oracle schema or you may not have permissions on that table. Verify that the schema name has been typed by using uppercase. The alphabetical case of the table and of the columns should be as specified in the Oracle system tables.

  On the Oracle side, a table or a column that is created without double quotation marks is stored in uppercase. If the table or the column is enclosed in double quotation marks, the table or the column is stored as is.

  The following call shows if the table exists in the Oracle schema. This call also shows the exact table name.

  ```sql
  sp_tables_ex @table_server=Ora817Link, @table_schema='your_schema_name'
  ```

- Message 6

  > Error 7413: Could not connect to linked server '%ls' (OLE DB Provider '%ls'). Enable delegation or use a remote SQL Server login for the current user. Msg 18456, Level 14, State 1, Line 1 Login failed for user '\'.

  This error message indicates that a distributed query is being attempted for a Microsoft Windows authenticated login without an explicit login mapping. In an operating-system environment in which security delegation is not supported, Windows NT authenticated logins need an explicit mapping to a remote login and password created using `sp_addlinkedsrvlogin`.

- Message 7

  > Error 7391: The operation could not be performed because OLE DB provider 'MSDAORA' for linked server "%ls" was unable to begin a distributed transaction. OLE DB error trace [OLE/DB Provider 'MSDAORA' ITransactionJoin::JoinTransaction returned 0x8004d01b]

  Verify that the OCI versions are registered correctly as described earlier in this article.

    > [!NOTE]
    > If the registry entries are all correct, the MtxOCI.dll file is loaded. If the MtxOCI.dll file is not loaded, you cannot perform distributed transactions against Oracle by using Microsoft OLE DB Provider for Oracle or by using Microsoft ODBC Driver for Oracle. If you are using a third-party provider and you receive Error 7391, verify that the OLE DB provider that you are using supports distributed transactions. If the OLE DB provider does support distributed transactions, verify that the Microsoft Distributed Transaction Coordinator (MSDTC) is running and has [network access enabled](../../../windows-server/application-management/enable-network-dtc-access.md).

- Message 8

  > Error 7392: Cannot start a transaction for OLE DB provider 'MSDAORA'for linked server "%ls". OLE DB error trace [OLE/DB Provider 'MSDAORA' ITransactionLocal::StartTransaction returned 0x8004d013: ISOLEVEL=4096].

  The OLE DB provider returned error 7392 because only one transaction can be active for this session. This error indicates that a data modification statement is being attempted against an OLE DB provider when the connection is in an explicit or implicit transaction, and the OLE DB provider does not support nested transactions. SQL Server requires this support so that, on certain error conditions, it can terminate the effects of the data modification statement while continuing with the transaction.

  If `SET XACT_ABORT` is **ON**, SQL Server does not require nested transaction support from the OLE DB provider. Therefore, execute `SET XACT_ABORT ON` before you execute data modification statements against remote tables in an implicit or explicit transaction. Do this in case the OLE DB provider that you are using does not support nested transactions.

## Techniques to troubleshoot connectivity issues to Oracle server

To debug the Oracle connectivity issues with either the Microsoft ODBC driver for Oracle or the Microsoft OLE DB Provider for Oracle, follow these steps:

1. Use the Oracle SQL Plus utility (a command line-based query utility) to verify that you can connect to Oracle and retrieve data.

   > [!NOTE]
   > If you cannot connect to Oracle and retrieve data, you either have a bad install or configuration of the Oracle Client Components or you have not correctly created a Transparent Network Substrate (TNS) service alias for the Oracle server when you used the SQL*Net Easy Configuration or Oracle Net8 Easy Configuration utility. Contact your Oracle database administrator (DBA) to verify that the Oracle components that you must have are correctly installed and configured.

1. Verify the version of the Oracle client (SQL\*Net version) that is installed on the computer. Both the Microsoft ODBC driver for Oracle and the Microsoft OLE DB Provider for Oracle require the installation of SQL*Net version 2.3 or later on the client computer.

   The connectivity from SQL Plus (the Oracle client query tool) may appear to function, but you must restart your computer for the ODBC/OLE DB connectivity to function correctly.

   > [!NOTE]
   > When you use Oracle 8i, the .rgs file is empty.

1. If the Oracle client is installed, and you receive an error that indicates that Oracle Client Components 7.3 or later must be installed on the computer, then verify that the environmental variable PATH on the client computer contains the folder in which the Oracle client was installed such as, *Oracle_Root\Bin*. If you cannot find this folder, then add the folder to the PATH variable to resolve the error.

1. Verify that the Ociw32.dll file is in the *Oracle_Root\bin* folder. This .dll file cannot exist at any other location on the client computer. Make sure that the Oracle Client Component DLLs (for example, the Core40.dll file and the Ora\*.dll file) do not exist outside the *Oracle_Root* folder or subfolders.

1. Verify that a single Oracle client version is installed on the computer. Multiple versions of SQL*Net cannot exist on the same client computer with interferes and with critical operations (for example, TNS and alias lookups).

1. Microsoft recommends that you have a local install of the Oracle client and not do this by mapping a remote Oracle client on your computer and then include it in the path of the system to connect to Oracle through ODBC/OLE DB. But the provider and driver are tested with a locally installed Oracle client and not on a network share.

## See Also

- [Driver history for Microsoft SQL Server](/sql/connect/connect-history)

- [Linked Servers (Database Engine)](/sql/relational-databases/linked-servers/linked-servers-database-engine)

