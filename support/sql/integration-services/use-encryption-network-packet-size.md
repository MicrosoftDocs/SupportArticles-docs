---
title: Use encryption and network packet size
description: This article provides a resolution for the problem that occurs when you configure your SQL Server to use encrypted connections and network packet size option.
ms.date: 09/15/2020
ms.custom: sap:Integration Services
---
# Error for SSIS packages on SQL servers configured to use encryption and network packet size

This article helps you resolve the problem that occurs when you configure your SQL Server to use encrypted connections and network packet size option.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2006769

## Symptoms

Consider the following scenario for SQL Server environments:  

- You configure your SQL Server to use [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine) for connections.

- You configure your SQL server to use a [network packet size Option](/previous-versions/sql/sql-server-2008-r2/ms187866(v=sql.105)) that is greater than the default value (4K).

In this scenario, you will notice the following:

- An attempt to either save SSIS packages to the MSDB package store will fail with the following error message:

  > The SaveToSQLServer method has encountered OLE DB error code 0x80004005 (Communication link failure).The SQL statement that was issued has failed.  

  > [!NOTE]
  > You also run into the above error message when saving maintenance plans created in SQL Server Management Studio as SSIS packages to MSDB databases since that operation inherently uses encryption for connections to SQL Server.

- Data collector feature in SQL Server that uses SSIS, runs into various issues as noted below:

  - A Data Collection Set job reports the following errors in the Job History:

  > dcexec: Error: Internal error at Main (Reason: The system cannot find the file specified).  
dcexec: Error: Internal error at Main (Reason: The handle is invalid).

  - When running a Data Collection Set directly from the Data, you may encounter the following error message:

  > Package "Set_{7B191952-8ECF-4E12-AEB2-EF646EF79FEF}_Master_Package_Collection" failed.  

If you review the Data Collector logs you will find an error message similar to the following:

> SSIS error. Component name: TaskForCollectionItem_1, Code: -1073602332, Subcomponent: (null), Description: Error 0xC0014062 while preparing to load the package. The LoadFromSQLServer method has encountered OLE DB error code 0x80004005 (Communication link failure). The SQL statement that was issued has failed.

The problem could happen with any operation that uses either [Application.LoadFromSqlServer(String, String, String, String, IDTSEvents) Method](/dotnet/api/microsoft.sqlserver.dts.runtime.application.loadfromsqlserver) or [Application.SaveToSqlServer(Package, IDTSEvents, String, String, String) Method](/dotnet/api/microsoft.sqlserver.dts.runtime.application.savetosqlserver) methods when both the conditions (encryption and large packet size) discussed in this section are true.

## Cause

Secure Socket Layer (SSL) and its replacement, Transport Layer Security(TLS), limit data fragments to 16k (16384) in size. This is documented in the public [RFC 2246](https://tools.ietf.org/html/rfc5246) (section 6.2.2) and the current implementation of [Network Protocols, and TDS Endpoints](/previous-versions/sql/sql-server-2005/ms191220(v=sql.90)) layer adheres to this specification. So when using a network packet size that is greater than 16k in environments where encryption is enabled on SQL Server, you will run into errors discussed in the Symptoms section.

## Resolution

To resolve this problem, specify a network packet size that is smaller than or equal to 16,384 bytes. You may use the following code to set the `network packet size` configuration option of the `sp_configure` system stored procedure:

> [!NOTE]
> If MARS is enabled, the SMUX provider will add a 16-byte header to the packet before SSL encryption, reducing the maximum network packet size to **16368** bytes.

```sql
EXEC sp_configure 'network packet size', 16368
RECONFIGURE WITH OVERRIDE
GO
```

The network packet size can also be altered via the Server Properties page in Object Explorer. Select the **Advanced** option and type in the new value for **Network Packet Size** and click **OK**.

> [!NOTE]
> You do not need to restart SQL Server for the change to be effective. After this setting is changed, all new connections receive the new value.

## More information

[TLS vs. SSL](/windows/win32/secauthn/tls-versus-ssl)

## Steps to reproduce

```sql
sp_configure 'network packet size', 16384
RECONFIGURE WITH OVERRIDE
GO
```

1. Make sure your Data Collector is installed.

2. Set the **Network Packet Size** to a value greater than 16K.

3. Right click on **Data Collection** in **Object Explorer** (OE) and **Disable Data Collection**.

4. Right click on **Data Collection** in OE and select **Enable Data Collection**.

5. Right click on **Server Activity** in the collection sets and select **Start Data Collection Set**.

6. To get the error, right click on **Server Activity** and select **Collect and Upload Now**. (The DC logs show the error in detail).
