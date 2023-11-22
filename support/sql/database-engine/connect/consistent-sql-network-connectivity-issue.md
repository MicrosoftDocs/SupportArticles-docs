---
title: Consistent SQL network connectivity issues
description: Troubleshoots consistent SQL network connectivity issues.
ms.date: 11/22/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Consistent SQL network connectivity issues

This article helps troubleshoot network connectivity errors in SQL Server. These errors are consistent and repeatable every time. They point to some configuration issues, such as SQL Server not enabling the Transmission Control Protocol (TCP) or a firewall blocking the connection. They don't include any text about Security Support Provider Interface (SSPI) or user errors, which would be an authentication error. This troubleshooting focuses on remote TCP connections as this is the most common connection type in most data centers, but many of the techniques can also be applied to Named Pipes.

## Typical error messages

The most common error messages are:

- > Communication link failure.
- > General network error.
- > The specified network name is unreachable.
- > SQL Server does not exist or access denied. (This can also be an authentication error)
- > A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.
- > Error Locating Server/Instance Specified.
- > Could not open a connection to SQL Server Microsoft SQL Server, Error:53. The network path was not found.
- > No connection could be made because the target machine actively refused it.

## Moving parts

The initial goal of troubleshooting is to try to isolate which moving part causes the network connectivity issue. High-level isolation will be client, server, or network.

:::image type="content" source="media/consistent-sql-network-connectivity-issue/client-server-network.png" alt-text="Screenshot shows moving parts that might cause the network connectivity issue.":::

## Preliminary work

Perform the [initial data collection] and narrow down steps. This helps understand the scope of an issue from a macro perspective, such as whether the issue affects multiple computers or just one, or whether only those computers in a specific data center are facing issues. It can help focus the troubleshooting steps and prepare you to discuss the issue with Microsoft Support if you choose to do so. Getting a [SQLCHECK] report for each machine will help when checking common settings.

## Isolation shortcuts

The following steps help divide the troubleshooting into a focused area:

- Client: application, connection string, driver (lacking Transport Layer Security (TLS) 1.2), SQL alias (64/32-bit), `hosts` file, and incorrect [Domain Name System (DNS)](/previous-versions/windows/it-pro/windows-server-2003/cc787921(v=ws.10)) suffix (full name connects; short name fails).
- SQL Server: database engine, enabled protocols, and firewall.
- Network: DNS alias, gateway, router, and firewall.

1. **Can you connect to SQL Server locally using SQL Server Management Studio (SSMS) and TCP?**

   For example, the connection string is `tcp:SQLPROD01.CONTOSO.COM,1433`.

   > [!NOTE]
   > `tcp` added before the server name must be lowercase.

   If so, SQL Server works well. The problem is with the firewall, network, or client.  
   If not, try the [SQL Server Service](#sql-server-service) section.

1. **Can you connect to the SQL Server port from the client machine using `TELNET`?**

   For example, the command to establish a `TELNET` connection to the SQL Server instance is `TELNET SQLPROD01.CONTOSO.COM 1433`.

   If so, there's a problem with the driver/provider, security/Secure Sockets Layer (SSL), SQL alias, or application.  
   If not, there's a problem with the `hosts` file, network, or firewall, assuming 1.4.1 works.

   - If `TELNET` isn't available as a command, add it as a Windows feature. It doesn't require a reboot.
   - Newer versions of Windows have the `Test-NetConnection` PowerShell command.

     For example, the command to test the network connection to a SQL Server instance is `TCP/IPTest-NetConnection SQLPROD01.CONTOSO.COM -Port 1433`.

1. **Assuming 1.4.2 works, can you connect to the server using a UDL file?**

   If so, the issue is in the application, likely an incorrect connection string, or in the provider used by the application if different from the provider used in the Universal Data Link (UDL) file.  
   If not, continue with the [Client](#client)section.

1. **Can other clients connect to SQL Server?**

   If so, there's a problem with the firewall, network, TLS 1.2, or client.  
   If not, there's a problem with the firewall or server.

1. **Can the client connect to other servers?**

   If so, there's a problem with the firewall, network, TLS 1.2, or server.  
   If not, there's a problem with the firewall, network, or TLS 1.2.

## Isolation steps and hints

Use the following isolation steps to move backward from the SQL Server machine to try to see what's failing.

### SQL Server Service

Validate the service process (*sqlserver.exe*) is running in **Task Manager**.

If you have multiple instances installed, you can check via SQL Server Configuration Manager or *services.msc*. If it's not running, try starting the instance. If it's a mirrored or clustered configuration, make sure you're on the primary or active node. Use the cluster manager for failover or always on clusters to make sure the resources are online. Validate whether the application event log, cluster logs, or the SQL Server *ERRORLOG* file indicates an actionable fatal error. If you can't start the service, the Microsoft database engine team can assist.

Validate the expected protocols are enabled in the SQL Server Configuration Manager and the SQL Server *ERRORLOG* file (see the following sample). If not, enable them and restart SQL Server. TCP should always be enabled if remote connections are allowed.

```Output
2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv6> 1433].
2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv4> 1433].
2013-11-20 09:42:03.94 Server Server local connection provider is ready to accept connection on [ \\.\pipe\SQLLocal\KJ].
2013-11-20 09:42:03.94 Server Server named pipe provider is ready to accept connection on [ \\.\pipe\MSSQL$KJ\sql\query].
```

In an SSMS, UDL, or ODBC Data Source Administrator connection, bypass the SQL Server Browser by specifying the server name in the format: `tcp:SQLProd01.Contoso.com,1433`. Using the fully qualified name `tcp:` and the port number should be the most reliable and resilient connection.

> [!NOTE]
> `tcp:` must be lowercase.

- If this test works:

  1. Validate SQL Server Browser is running. If SQL Server is the default instance listening on port 1433, it doesn't have to be running. You should be able to leave off the port number and still have it work.
  1. If leaving off the `tcp:` prefix causes it to fail, you may be connecting via Named Pipes by default. You can validate by using `np:hostname\instancename` as the server name.
  1. If using the Network Basic Input/Output System (NetBIOS) name fails, you may have a SQL alias (SQL Server Configuration Manager) or an incorrect DNS suffix in the network configuration. Also, check 32-bit aliases.

- If SSMS fails to connect, try connecting with a UDL file or via the ODBC Data Source Administrator.

  - Try using the IP address of the server instead of the host name. You can even try using 127.0.0.1 if the server isn't clustered and is listening on "any."
  - Try different drivers. Newer drivers support TLS 1.2 and give better error messages.
  - Try different protocols: `tcp:SQLProd01.contoso.com,1433`, `np:SQLProd01.contoso.com\instancename`, or `lpc:SQLProd01.contoso.com\instancename`. Use the SQL Server Configuration Manager to make changes. Then, restart SQL Server and use the *ERORLOG* to confirm the changes.
  - Has SQL Server (2014 or earlier) been upgraded to support TLS 1.2? Has the client? Are these protocols enabled?
  - Check for a SQL alias in SQL Server Configuration Manager or *cliconfg.exe* on all Windows machines. Check 64-bit and 32-bit aliases.
  - Check the *ERRORLOG* file for failure messages, such as the database being unavailable or in recovery.
  - Check the `NETSTAT` output to validate if SQL Server owns the expected port. For example, run `NETSTAT -abon > c:\temp\ports.txt` from a command prompt with admin permissions.

If SQL Server is using a port other than 1433:

If you can connect by hard-coding the port number but can't connect when it's omitted, this is a SQL Server Browser issue. If it happens on the server, it's more likely a firewall issue if it only happens remotely. The SQL Server Browser service may need to be restarted.

If using Always On, connecting to the listener doesn't use SQL Server Browser, so you have to hardcode the port number in the connection string. If that doesn't work, try connecting directly to the primary node on its regular SQL port. If that works, the listener may be bad for some reason. Engage SQL Server High Availability to check the cluster and listener configuration.

If none of the above methods work, restart the SQL Server computer. If the problem persists after that, you may need to contact the SQL Server database engine team.

The worst case scenario is to stop the SQL Server Service, install a new instance, or potentially rebuild the machine, and then reattach the database or restore from the backup. If using transparent data encryption (TDE), such as the SSISDB database, make sure the encryption keys are saved before doing this step. It's offered as an option as rebuilding can sometimes be faster than a root cause analysis of intractable problems. For clustered installations, the impact can be less as you can rebuild a node while it's running on the alternate node.

### Firewall

In general, the firewall's default behavior is to block the SQL Server and SQL Server Browser ports. If so, remote connections will fail, while local ones will succeed. Test it by using `TELNET` or `PORTQRY`:

- `TELNET SQLProd01 1433`
- `PORTQRY -n SQLPROD01 -p udp -e 1434`

> [!NOTE]
> SQL Server Browser uses UDP port 1434.

If `TELNET` isn't available, use the `Test-NetConnection` PowerShell command:

```powershell
Test-NetConnection SQLPROD01 -Port 1433   
Test-NetConnection SQLPROD01.CONTOSO.COM -Port 1433
```

Make sure to check which port SQL Server is listening on in the *ERRORLOG* file. You may have to enable `TELNET` by adding it as a Windows feature. This doesn't require a reboot. SQL Server must also be listening on TCP. `PORTQRY` can be downloaded from the Microsoft download site. If using the SQL Server Browser, make sure the UDP port 1434 is opened in the firewall and the SQL Server TCP port.

### Network

The client or application server can connect to SQL Server on a different machine. Perhaps multiple clients on a particular network or subnet are having trouble connecting to a server outside the subnet or in another specific subnet. A network firewall might block a specific client from connecting to a specific SQL Server. For example, the client can connect to other SQL Servers, and other clients can connect to the problem SQL Server.

### VPN

If the issue only happens on a virtual private network (VPN) and not when the laptop is brought in-house, the VPN vendor needs to resolve the issue. You can get a client and server network trace, which may help show the type of problems the VPN is causing. For example, dropped packets are the most likely ones. The VPN may also change the internal routing between the client and server, exposing it to another network device that's blocking the connection. Collecting network traces on intermediate devices will help isolate the issue by subdividing the network. The `TRACERT` command may reveal the routing.

### Client

Other confirmation indicators:

- Other clients can connect to the server normally.
- No applications can connect from this machine.
- A UDL can't connect, nor can a connection be made from the ODBC Data Source Administrator.

  This might be caused by an outbound firewall rule or incorrect default DNS suffixes. Try testing with the fully qualified server name, for example:

  `TELNET SQLProd01 1433`
  `TELNET SQLProd01.Contoso.com 1433`

  `PORTQRY -n SQLPROD01 -p udp -e 1434`
  `PORTQRY -n SQLPROD01.Contoso.com -p udp -e 1434`

  `PING SQLProd01`
  `PING SQLProd01.Contoso.com`

If `TELNET` isn't available, use the `Test-NetConnection` PowerShell command:

```powershell
Test-NetConnection SQLPROD01 -Port 1433   
Test-NetConnection SQLPROD01.CONTOSO.COM -Port 1433
```

This might be a TLS issue. For example, the server uses TLS 1.2, and the client drivers haven't been upgraded for it.

There might be a `hosts` file entry, a SQL alias, or a DNS alias that directs the connection to another server. Use `PING` and `TELNET`. If they work, but the driver fails, suspect a SQL alias or TLS issue.

### Driver

Try different drivers. If some drivers work and others fail, suspect a TLS issue. Download the latest driver, such as MSOLEDBSQL or ODBC Driver 17 for SQL Server, and try that. If using .NET, make sure you're using the latest version of the framework. If it still fails, it should give a better error message. You can also download the latest version of SQL Server Management Studio that's independent of SQL Server and install it on any client. This uses the `SqlClient .NET` class.

### User

Have another user log in to this machine. If they can connect, see what's different about the failing user. For example, the Windows user profile is incorrect, or perhaps the users belong to a different organizational unit (OU) or domain. If there are users from multiple domains, try using a user from the same domain as the server. Typically, user issues result in authentication errors and have a different troubleshooting workflow. If it's not an authentication issue, a Process Monitor log may help identify local permission issues affecting connectivity. For example, the user has a data source name (DSN) or some sort of registry redirect to a different driver, a local permission restriction, or something that may explain the connectivity failure.

### Application

If only a particular application fails and a UDL file succeeds, it may be a driver issue, or the application has an incorrect connection string. Have the application development team or third-party vendor check the connection string. You can use Process Explorer from `www.sysinternals.com` to see which driver is being used if the customer is unsure.

## Advanced isolation

Capture a client and server network trace ([Collect a Network Trace]). Run it on both the client and server at the same time.

Install WireShark with the NCAP driver to trace when the client and server are on the same machine.

Your organization may have its own network infrastructure team that you can engage with and may have a preferred tracing tool to perform the capture. They can use any tool as long as it's saved in a format compatible with NETMON or WireShark. PCAP format is the most popular.

Run SQL Network Analyzer [SQLNA] and [SQLNAUI] against the network trace to get an easy-to-read report.

### BID trace

[Collect a SQL driver BID trace]

For JDBC drivers, see instructions in [Tracing driver operation (logging)](/sql/connect/jdbc/tracing-driver-operation).

Collect a network trace in addition to the BID trace or JDBC trace. Microsoft can help interpret the results.

## More information

[Reasons for Consistent Auth Issues](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0420-Reasons-for-Consistent-Auth-Issues)
