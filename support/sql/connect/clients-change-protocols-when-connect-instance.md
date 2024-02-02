---
title: SQL Server clients may change protocols
description: This article describes that client computers that have MDAC version 2.6, or later, can try multiple protocols or IPC mechanisms to establish connections to SQL Server.
ms.date: 09/25/2020
ms.custom: sap:MDAC and ADO
---
# SQL Server clients may change protocols when the client computers try to connect to an instance of SQL Server

This article introduces SQL Server clients may change protocols when the client computers try to connect to an instance of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 328383

## Summary

Client computers that have Microsoft Data Access Components (MDAC) version 2.6, or later, can try multiple protocols or Interprocess Communication (IPC) mechanisms to establish connections to SQL Server.

## More information

An enhancement has been made to the client-side network library, Dbnetlib.dll for MDAC version 2.6, and later. With MDAC version 2.6, and later, if multiple protocols are available, and a connection attempt with the first protocol fails, the client application immediately tries to use one of the other protocols.

By default, clients have TCP and Named Pipes as available protocols. You can manipulate the protocol ordering by using the SQL Server Client utility. The client application uses the protocols in the order specified on the client computer. The protocol order is stored at the following registry key location under the value **ProtocolOrder**:

`HKLM\Software\Microsoft\MSSQLServer\Client\SuperSocketNetLib`

If you are using SQL Server 2005, the protocol order is stored in the **ProtocolOrder** registry entry under the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Client\SNI<version>`

For example, if a client computer has both TCP and Named Pipes available, and the order is:

- TCP
- Named Pipes

When the client computer tries to make a TCP connection to the server and the connection attempt returns a non-zero return code, the client transparently tries a connection by using the next protocol in the list, which is Named Pipes. In this scenario, the client cannot make a TCP connection; however, the client successfully makes a Named Pipes connection.

> [!NOTE]
> The client does not receive an error that indicates the first protocol failed.

If the client application uses the second protocol, and it also returns an error, an error is returned to the client.

If you make an alias by using one of the following methods, the client application uses the alias information to establish a connection to the server and does not use any additional protocols.

- By using the SQL Server Client Network utility
- By using SQL Server Configuration Manager
- When you create an ODBC data source name (DSN)

If you want to control the protocol that a client application uses for every connection attempt, and not allow the client to try multiple protocols, you can do one of the following:

- Use the SQL Client Network utility or SQL Server Configuration Manager to create an alias by specifying the protocol you prefer.

- Specify the protocol in your connection string. For example:

    ```xml
    DSN=DSNName;SERVER=servername;DATABASE=YourDataBaseName;Network=DBMSSOCN;Address=IP_Address,1433;UID=YourUID;PWD=YourPassword;
    ```

    In this example, you specify the network protocol as `DBMSSOCN`, which means that you want to use the TCP/IP protocol. If you specify the protocol inside your connection string, Dbnetlib only uses the specified protocol and does not try any other protocol. Similarly, to enable Named Pipe protocol only, use a connection string similar to this:

    ```xml
    DSN=DSNName;SERVER=servername;DATABASE=YourDataBaseName;Network=DBNMPNTW;Address=\\.\pipe\sql\query;UID=YourUID;PWD=YourPassword;
    ```

- Use the Client Network utility to remove other protocols.

## REFERENCES

[Solving Connectivity errors to SQL Server](https://support.microsoft.com/sbs/topic/solving-connectivity-errors-to-sql-server-ae23c94b-b64b-5056-8b62-22e1694bb889)

