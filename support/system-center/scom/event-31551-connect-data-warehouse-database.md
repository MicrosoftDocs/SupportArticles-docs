---
title: Event 31551 when connecting to the data warehouse database
description: Fixes an issue that triggers event ID 31551 in a Systems Center Operations Manager environment.
ms.date: 04/15/2024
ms.reviewer: irfanr
---
# Event 31551 when management server tries to connect to the data warehouse database

This article fixes an issue in which Operations Manager management server can't connect to the SQL Server cluster that hosts the data warehouse database.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3084547

## Symptoms

A System Center Operations Manager management server cannot connect to or communicate with the SQL Server cluster that hosts the data warehouse database. In this situation, event ID 31551 is logged in the Operations Manager log, together with a description that resembles the following for various workflow names:

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Date:  
> Event ID: 31551  
> Task Category: Data Warehouse  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: server.Contoso.com  
> Description:  
> Failed to store data in the Data Warehouse. The operation will be retried.  
> Exception 'SqlException': A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified)
>
> One or more workflows were affected by this.
>
> Workflow name: Microsoft.SystemCenter.DataWarehouse.CollectEventData  
> Instance name: server.Contoso.com  
> Instance ID: {8A13A832-776E-096E-32E7-DC479FCD6DBC}  
> Management group: SupportGroup

## Cause

The focus here should be on the following string:

> error: 26 - Error Locating Server/Instance Specified

This error is often thought to occur because a remote connection is not enabled on the server. However, this error is actually generated when the client cannot receive a SQL Server Resolution Protocol (SSRP) response UDP packet from SQL Server Browser. This behavior typically occurs because UDP port communication is blocked between the management server and the SQL Server cluster that hosts the Operations Manager data warehouse.

> [!NOTE]
> This error occurs only when you try to connect to a SQL Server named instance. It should not occur when you connect to the default instance. This is, even if the connection attempt fails at this stage (for example, because of an error locating the specified server or instance), it will continue trying to connect by using the default values (for example, by using the default TCP port of 1433, the default pipe name for **Named Pipes**, and so on). Other error messages may be generated because of a later failure, but not this error message.

## Resolution

To resolve this issue, you must resolve whatever problem is causing UDP port communication to fail between the management server and the SQL Server cluster. In most cases, it's fairly easy to isolate the problem by following these steps:

1. Make sure that the server name is correct (for example, make sure there's no error in the name).
2. Make sure that the instance name is correct and that the instance actually exists on your target computer. Some applications convert \\\\ to \\. If you are not sure about your application, try both `server\instance` and `server\\instance` in the connection string.
3. Make sure that the server is reachable. Make sure that DNS can be resolved correctly and that you can ping the server.
4. Make sure that the SQL Server Browser service is running on the server.
5. If the firewall is enabled on the server, make sure there's an exception for sqlbrowser.exe and UDP port 1434.

You can download the `PortQry` utility from [New features and functionality in PortQry version 2.0](https://support.microsoft.com/help/832919) to test steps 4 and 5.

After you have `PortQry`, run the following command:

```console
portqry.exe -n serverName -p UDP -e 1434
```

If this command returns information and contains the target instance, you can rule out the scenarios in steps 4 and 5. This means that SQL Browser is running and that the firewall is not blocking SQL Server Browser UDP packets.

After you've finished with these steps, the error should no longer occur. The management server may still fail to connect to the SQL Server, but if so, a different error message should be triggered at this point. If the management server still fails to connect, replace `server\instance` with `tcp:server\instance` or with `np:server\instance`, and then see whether that succeeds with either TCP or the NP protocol.

## More information

This issue is caused by a combination of the following:

- Windows cluster specifics
- How the SQL Server named instance is discovered

When you connect to SQL Server named instances, the client components rely on SQL Server Browser to discover the server and its parameters. The discovery process runs as follows:

- The client sends a UDP packet to SQL Server Browser on the target computer. When the named instance is on a Windows cluster, the packet is sent to the cluster IP, or more specifically, to the IP address that corresponds to the virtual machine that's running SQL Server. However, SQL Browser is not cluster-aware, and it listens on IP any.
- When SQL Server Browser receives the UDP request packet, it sends a response UDP packet back the client. Although the destination IP address is the client's IP address, the source IP address is changed. It is now the IP address of the network adapter on the physical computer instead of the virtual SQL Server IP address.
- The source IP address of the response UDP packet is determined by the Windows OS, based on the routing table. Because both the virtual SQL Server IP address and the IP address that's attached to the physical network adapter are typically on the same subnet and therefore belong to same route, the physical IP address is selected. Depending on the security settings on the client and server computers, this response UDP packet may be dropped by either a third-party firewall or by IPsec because the peer IP address is changed. Windows Firewall will not drop the packet.
- If the client is a Windows Vista-based computer, IPsec may drop the packet if IPsec policy is enabled on the client and if it cannot establish a trust connection between the client and server. To work around this problem, manually specify the TCP port or pipe name in the connection string.
