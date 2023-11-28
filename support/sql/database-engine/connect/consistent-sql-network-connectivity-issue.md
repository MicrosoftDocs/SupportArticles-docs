---
title: Consistent SQL Server network connectivity issues
description: Troubleshoots consistent SQL Server network connectivity issues.
ms.date: 11/24/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Consistent SQL Server network connectivity issues

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

This article helps troubleshoot network connectivity errors in SQL Server. These errors are consistent and repeatable every time. They point to some configuration issues, such as SQL Server not enabling the Transmission Control Protocol (TCP) or a firewall blocking the connection. The troubleshooting focuses on remote TCP connections because it's the most common connection type in most data centers, but many of the techniques can also be applied to Named Pipes.

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

## Narrow the scope of the issue to a focused area

The following steps help narrow the troubleshooting to a focused area:

- Client: application, connection string, driver (lacking Transport Layer Security (TLS) 1.2), SQL alias (64/32-bit), `hosts` file, and incorrect [Domain Name System (DNS)](/previous-versions/windows/it-pro/windows-server-2003/cc787921(v=ws.10)) suffix (full name connects; short name fails).
- SQL Server: database engine, enabled protocols, and firewall.
- Network: DNS alias, gateway, router, and firewall.

### 1. Can you connect to SQL Server locally using SQL Server Management Studio (SSMS) and TCP?

For example, use the connection string `tcp:<InstanceName>.<DomainName>.COM,1433`.

> [!NOTE]
> `tcp` added before the server name must be lowercase.

If yes, SQL Server works well. The issue is related to [firewalls](#firewall), [networks](#network), or [clients](#client).

If not, the issue is related to [SQL Server Service](#sql-server-service).

### 2. Can you connect to the SQL Server port from the client machine using telnet?

For example, the command to establish a [telnet](/windows-server/administration/windows-commands/telnet) connection to the SQL Server instance is `telnet <InstanceName>.<DomainName>.COM 1433`.

If yes, the issue is related to [drivers/providers](#driver), security/Secure Sockets Layer (SSL), SQL aliases, or [applications](#application).

If not, the issue is related to `hosts` files, [networks](#network), or [firewalls](#firewall) when [step 1](#1-can-you-connect-to-sql-server-locally-using-sql-server-management-studio-ssms-and-tcp) works.

- If `telnet` isn't available as a command, add it as a Windows feature. This doesn't require a reboot.
- Newer versions of Windows have the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) PowerShell command.

   For example, use the command `TCP/IPTest-NetConnection <InstanceName>.<DomainName>.com -Port 1433` to test the network connection to a SQL Server instance.

### 3. Can you connect to the server using a UDL file if step 2 works?

If yes, the issue is related to [applications](#application), like an incorrect connection string, or the provider used by the application if different from the provider used in the [Universal Data Link](test-oledb-connectivity-use-udl-file.md) (UDL) file.

If not, the issue is related to [clients](#client).

### 4. Can other clients connect to SQL Server?

If yes, the issue is related to [firewalls](#firewall), [networks](#network), TLS 1.2, or [clients](#client).

If not, the issue is related to [firewalls](#firewall) or [servers](#sql-server-service).

### 5. Can the client connect to other servers?

If yes, the issue is related to [firewalls](#firewall), [networks](#network), TLS 1.2, or [servers](#sql-server-service).

If not, the issue related to [firewalls](#firewall), [networks](#network), or TLS 1.2.

## SQL Server Service

If the issue is related to SQL Server Service, follow these steps:

1. Validate the service process (*sqlserver.exe*) is running in **Task Manager**. (Or check via SQL Server Configuration Manager or *services.msc* if you have multiple instances installed.)

   If it's not running, try starting the instance. If it's a mirrored or clustered configuration, make sure you're on the primary or active node. Use the cluster manager for failover or always on clusters to make sure the resources are online.

1. Validate whether the application event log, cluster logs, or the SQL Server *ERRORLOG* file indicates an actionable fatal error.

1. Validate the expected protocols are enabled in SQL Server Configuration Manager and the SQL Server *ERRORLOG* file (see the following sample).

   If not, enable them and restart SQL Server. TCP should always be enabled if remote connections are allowed.

   ```Output
   2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv6> 1433].
   2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv4> 1433].
   2013-11-20 09:42:03.94 Server Server local connection provider is ready to accept connection on [ \\.\pipe\SQLLocal\KJ].
   2013-11-20 09:42:03.94 Server Server named pipe provider is ready to accept connection on [ \\.\pipe\MSSQL$KJ\sql\query].
   ```

1. In an SSMS, [UDL](test-oledb-connectivity-use-udl-file.md), or [ODBC Data Source Administrator](/sql/integration-services/import-export-data/connect-to-an-odbc-data-source-sql-server-import-and-export-wizard) connection, bypass the SQL Server Browser by specifying the server name in the format: `tcp:<InstanceName>.<DomainName>.com,1433`.

   > [!NOTE]
   > Using the fully qualified domain name (FQDN), `tcp:`, and the port number to create a connection is the most reliable and resilient method. `tcp:` must be lowercase.

   - If the connection is successful:

     - Validate SQL Server Browser is running. If SQL Server is a default instance listening on port 1433, it doesn't have to be running. You can remove the port number and have it still work.
     - If removing the `tcp:` prefix causes it to fail, you may be connecting via Named Pipes by default. You can validate by using `np:hostname\instancename` as the server name.
     - If using the Network Basic Input/Output System (NetBIOS) name fails, you may have a SQL alias that overrides the NetBIOS name or an incorrect DNS suffix in the network configuration. Also, check 32-bit aliases.

   - If SSMS fails to connect, try [connecting with a UDL file](test-oledb-connectivity-use-udl-file.md) or via the [ODBC Data Source Administrator](/sql/integration-services/import-export-data/connect-to-an-odbc-data-source-sql-server-import-and-export-wizard).

     - Try using the IP address of the server instead of the host name. You can even try using 127.0.0.1 if the server isn't clustered and is listening on "any."
     - Try different drivers. Newer drivers support TLS 1.2 and give better error messages.
     - Try different protocols: `tcp:<InstanceName>.<DomainName>.com,1433`, `np:<InstanceName>.<DomainName>.com\instancename`, or `lpc:<InstanceName>.<DomainName>.com\instancename`. Use the SQL Server Configuration Manager to make changes. Then, restart SQL Server and use the *ERORLOG* file to confirm the changes.
     - Has SQL Server (2014 or earlier) been upgraded to support TLS 1.2? Has the client been upgraded to support TLS 1.2? Are these protocols enabled?
     - Check for a SQL alias in SQL Server Configuration Manager or *cliconfg.exe* on all Windows machines. Check 64-bit and 32-bit aliases.
     - Check the *ERRORLOG* file for failure messages, such as the database being unavailable or in recovery.
     - Check the `NETSTAT` output to validate if SQL Server owns the expected port. For example, run `NETSTAT -abon > c:\temp\ports.txt` from a command prompt with admin permissions.

   - If SQL Server is using a port other than 1433:

     - If you can connect by specifying the port number but not when you omit the port number, this is a SQL Server Browser issue. It means that the SQL Browser service isn't able to provide the correct port number for the SQL Server instance that you want to connect to. You may also need to restart the SQL Browser service to refresh its information.

     - If you can't connect even when you specify the port number, and this only happens when you connect remotely, it's a firewall issue. You should check the firewall settings and make sure that the port is allowed for inbound and outbound connections. You may also need to create a firewall rule to allow the SQL Server application or service to communicate through the firewall.

     - If using Always On, connecting to the listener doesn't use SQL Server Browser, so you have to specify the port number in the connection string. If that doesn't work, try connecting directly to the primary node on its regular SQL port. (This means connecting directly to the SQL Server instance that's currently serving as the primary replica, rather than connecting to the listener.) If that works, the issue is related to listener. Engage SQL Server High Availability to check the cluster and listener configuration.

If none of the above methods work, restart the SQL Server computer.

The worst case scenario is to stop the SQL Server Service, install a new instance, or potentially rebuild the machine, and then reattach the database or restore from the backup. If using [transparent data encryption](/sql/relational-databases/security/encryption/transparent-data-encryption) (TDE), such as the [SSISDB](/sql/integration-services/catalog/ssis-catalog) database, make sure the encryption keys are saved before doing this step. It's offered as an option as rebuilding can sometimes be faster than a root cause analysis of intractable problems. For clustered installations, the impact can be less as you can rebuild a node while it's running on the alternate node.

## Firewall

In general, the firewall's default behavior is to block the SQL Server and SQL Server Browser ports. If so, remote connections fail, while local ones succeed. Test it by using `telnet` or [PortQry](/troubleshoot/windows-server/networking/portqry-command-line-port-scanner-v2):

- `telnet <InstanceName> 1433`
- `portqry -n <InstanceName> -p udp -e 1434`

> [!NOTE]
> SQL Server Browser uses UDP port 1434.

If `telnet` isn't available, use the `Test-NetConnection` PowerShell command:

```powershell
Test-NetConnection <InstanceName> -Port 1433   
Test-NetConnection <InstanceName>.<DomainName>.com -Port 1433
```

Make sure to check which port SQL Server is listening on in the *ERRORLOG* file. You may have to enable `telnet` by adding it as a Windows feature. This doesn't require a reboot. SQL Server must also be listening on TCP. `PortQry` can be downloaded from the Microsoft download site. If using the SQL Server Browser, make sure the UDP port 1434 is opened in the firewall and the SQL Server TCP port.

## Network

The client or application server can connect to SQL Server on a different machine. Perhaps multiple clients on a particular network or subnet are having trouble connecting to a server outside the subnet or in another specific subnet. A network firewall might block a specific client from connecting to a specific SQL Server. For example, the client can connect to other SQL Servers, and other clients can connect to the problem SQL Server.

### VPN

If the issue only happens on a virtual private network (VPN) and not when the laptop is brought in-house, the VPN vendor needs to resolve the issue. You can get a client and server network trace, which may help show the type of problems the VPN is causing. For example, dropped packets are the most likely ones. The VPN may also change the internal routing between the client and server, exposing it to another network device that's blocking the connection. Collecting network traces on intermediate devices help isolate the issue by subdividing the network. The [tracert](/windows-server/administration/windows-commands/tracert) command may reveal the routing.

## Client

If the issue is related to clients, you might see the following indicators:

- Other clients can connect to the server normally.
- No applications can connect from this machine.
- You can't connect using a [UDL](test-oledb-connectivity-use-udl-file.md) or [ODBC Data Source Administrator](/sql/integration-services/import-export-data/connect-to-an-odbc-data-source-sql-server-import-and-export-wizard).

  This might be caused by an outbound firewall rule or incorrect default DNS suffixes. Try testing with the fully qualified server name, for example:

  - `telnet <InstanceName> 1433`
  - `telnet <InstanceName>.<DomainName>.com 1433`

  - `portqry -n <InstanceName> -p udp -e 1434`
  - `portqry -n <InstanceName>.<DomainName>.com -p udp -e 1434`

  - `ping <InstanceName>`
  - `ping <InstanceName>.<DomainName>.com`

  If `telnet` isn't available, use the `Test-NetConnection` PowerShell command:

   ```powershell
   Test-NetConnection <InstanceName> -Port 1433   
   Test-NetConnection <InstanceName>. <DomainName>.com -Port 1433
   ```

   This might be a TLS issue. For example, the server uses TLS 1.2, and the client drivers haven't been upgraded for it.

   There might be a `hosts` file entry, a SQL alias, or a DNS alias that directs the connection to another server. Use [ping](/windows-server/administration/windows-commands/ping) and `telnet`. If they work, but the driver fails, suspect a SQL alias or TLS issue.

## Driver

If the issue is related to drivers, try different drivers.

- If some drivers work and others fail, suspect a TLS issue. Download the latest driver, such as [Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/download-oledb-driver-for-sql-server) or [ODBC Driver 17 for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server), and try that.

- If using .NET, make sure you're using the latest version of the framework. If it still fails, it should give a better error message. You can also download the latest version of [SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms) that's independent of SQL Server and install it on any client. This uses the `SqlClient .NET` class.

## User

If the issue is related to users, have another user log in to this machine.

- If the connection is successful, see what's different about the failing user. For example, the Windows user profile is incorrect, or perhaps the users belong to a different organizational unit (OU) or domain.

- If there are users from multiple domains, try using a user from the same domain as the server. Typically, user issues result in authentication errors and have a different troubleshooting workflow.

- If it's not an authentication issue, a Process Monitor log may help identify local permission issues affecting connectivity. For example, the user has a data source name (DSN) or some sort of registry redirect to a different driver, a local permission restriction, or something that may explain the connectivity failure.

## Application

If only a particular application fails and a [UDL](test-oledb-connectivity-use-udl-file.md) file succeeds, it may be a driver issue, or the application has an incorrect connection string. Have the application development team or third-party vendor check the connection string. You can use Process Explorer from `www.sysinternals.com` to see which driver is being used if the customer is unsure.

## Tracing tools to capture

Capture a [client and server network trace](/sql/relational-databases/sql-trace/sql-trace). Run SQL trace on both the client and server at the same time.

Install [WireShark](https://www.wireshark.org/download.html) with the Npcap driver to trace when the client and server are on the same machine.

Your organization may have its own network infrastructure team that you can engage with and may have a preferred tracing tool to perform the capture. They can use any tool as long as it's saved in a format compatible with [Network Monitor (NetMon.exe)](/windows-hardware/drivers/portable/using-the-netmon-tool) or WireShark. PCAP format is the most popular.

Run [SQL Network Analyzer (SQLNA)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA) and [SQL Network Analyzer UI (SQLNAUI)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI#sql-network-analyzer-ui-sqlnaui) against the network trace to get an easy-to-read report.

## More information

- [Reasons for Consistent Auth Issues](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0420-Reasons-for-Consistent-Auth-Issues)
- [Tracing driver operation](/sql/connect/jdbc/tracing-driver-operation)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
