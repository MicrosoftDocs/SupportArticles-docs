---
title: Consistent SQL network connectivity issue
description: Troubleshoots consistent SQL network connectivity issue.
ms.date: 11/20/2023
ms.reviewer: v-sidong
ms.custom: sap:Connection issues
---
Consistent SQL Network Connectivity Issue
In this article

Typical Error Messages
Moving Parts
Pre-Works
Isolation Shortcuts
Isolation Steps and Hints
Advance Isolation
Bid Trace

These errors are consistent and repeatable every time. They point to a configuration issue of some sort, such as SQL Server does not have TCP enabled or a firewall is blocking the connection. They do not include any text regarding SSPI or user errors, which would be an authentication error. Troubleshooting will be focusing on remote TCP connections as this is the most common connection type for most data centers, but many of the techniques can also be applied to Named Pipes.

1.1 Typical Error Messages

     Below are some of the most common error messages:
•	Communication link failure.
•	General Network Error.
•	The specified network name is unreachable.
•	SQL Server does not exist or access denied. (this can also be an authentication error)
•	A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.
•	Error Locating Server/Instance Specified.
•	Could not open a connection to SQL Server Microsoft SQL Server, Error:53. The network path was not found.
•	No connection could be made because the target machine actively refused it.

1.2 Moving Parts

      The initial goal is to try to isolate which of the moving parts is causing the problem. High level isolation will be Client, Server, or Network.
 
:::image type="content" source="media/consistent-sql-network-connectivity-Issue/client-server-network.png" alt-text="Screenshot shows moving parts.":::
1.3 Pre-Work

   Please perform the initial data collection and narrowing steps. This will help get a macro perspective of the scope        of an issue, such as whether the issue affects multiple computers or just one, or whether only those computers in a specific data center are facing issues. This can help focus the troubleshooting steps. It will also make you prepared for discussing the issue with Microsoft Support should you choose to do so. Getting a SQLCHECK report of each machine will help when checking common settings.

1.4 Isolation Shortcuts

  These steps will help to divide the troubleshooting into a focused area:
•	Client: Application, connection string, driver (lacking TLS 1.2), SQL alias (64/32 bit), HOSTS file, bad DNS suffix (full name connects, short name fails).
•	SQL Server: Database engine, enabled protocols, firewall.
•	Network: DNS alias, gateway, router, firewall.

1.4.1	Can you connect to the SQL Server locally using SQL Server Management Studio and TCP? e.g. tcp:SQLPROD01.CONTOSO.COM,1433
Note: tcp must be lower case when added before the server name.
YES = SQL is okay. Problem area = firewall, network, or client.
NO = Try section 1.5.1 SQL Server Service.

1.4.2 	Can you connect to the SQL Server port from the client machine using TELNET? e.g. TELNET SQLPROD01.CONTOSO.COM 1433
YES = Problem with the driver/provider, security/SSL, SQL Alias, or application.
NO = Problem with hosts file, network, or firewall, assuming 1.4.1 works.
•	If TELENET is not available as a command, add it as a Windows Feature. This does not require a reboot.
•	Newer versions of Windows have the Test-NetConnection PowerShell command, e.g.

   	Test-NetConnection SQLPROD01.CONTOSO.COM -Port 1433

1.4.3.	Assuming 1.4.2 works, can you connect to the server using a UDL file?
YES = the issue is in the application, likely a bad connection string, or in the provider used by the application if different than used in the UDL file.
NO = continue with 1.5.4 Client.

1.4.4.	Can other clients connect to the SQL Server?
YES = Problem with firewall, network, TLS 1.2, or client.
NO = Problem with firewall or server.

1.4.5.	Can the client connect to other servers?
YES = Problem with firewall, network, TLS 1.2, or server.
NO = Problem with firewall, network, or TLS 1.2.

1.5 Isolation Steps and Hints
       
Use the following isolation steps to move backward from the SQL Server machine to try to see what is failing.

1.5.1 	SQL Server Service Validate the service process (sqlserver.exe) is running in Task Manager. If you have multiple instances installed, you can check via SQL Server Configuration Manager or services.msc. If it is not, try starting the instance. If it is a mirrored or clustered configuration, make sure you are on the primary/active node. Use the cluster manager for fail-over clusters or always-on clusters to make sure the resources are on-line. Validate whether the Application Event log, cluster logs, or the SQL Server ERRORLOG file indicates a fatal error that is actionable. If you cannot start the service, the Microsoft database engine team can assist.

Validate the expected protocols are enabled in the SQL Server Configuration Manager and in the SQL Server ERRORLOG file (see sample below). If not, enable them and restart the SQL Server. TCP should always be enabled if remote connections are allowed. E.g.

2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv6> 1433].
2013-11-20 09:42:03.90 Server Server is listening on [ 'any' <ipv4> 1433].
2013-11-20 09:42:03.94 Server Server local connection provider is ready to accept connection on [ \\.\pipe\SQLLocal\KJ].
2013-11-20 09:42:03.94 Server Server named pipe provider is ready to accept connection on [ \\.\pipe\MSSQL$KJ\sql\query].

In an SSMS, UDL, or ODBC Administrator connection, bypass the SQL Browser by specifying the server name in the following format: tcp:SQLProd01.Contoso.com,1433. By using the fully qualified name and tcp: and the port number, this should be the most reliable and resilient connection. Note: tcp: must be lower case. If this test works:

•	Validate SQL Browser is running. If SQL is the default instance listening on port 1433, it does not have to be running. You should be able to leave off the port number and have it still work.
•	If leaving off the tcp: prefix causes it to fail, you may be connecting via Named Pipes by default. You can validate by using np:hostname\instancename as the server name.
•	If using the NETBIOS name fails, you may have a SQL Alias (SQL Server configuration Manager) or an incorrect DNS suffix in the network configuration. Check 32-bit Aliases, too.

If SSMS fails to connect, try connecting with a UDL file or via the ODBC Administrator.

•	Try using the IP address of the server instead of the host name, or even 127.0.0.1 if non clustered (Server is listening on 'any').
•	Try different drivers. Newer drivers support TLS 1.2 and give better error messages.
•	Try different protocols: tcp:SQLProd01.contoso.com,1433 or np:SQLProd01.contoso.com\instancename or lpc:SQLProd01.contoso.com\instancename. Use the SQL Server Configuration Manager to change. Restart SQL Server afterwards and use the ERORLOG to confirm the changes.
•	Has the SQL Server (2014 or earlier) been upgraded to support TLS 1.2? Has the client? Are these protocols enabled?
•	Check for a SQL Alias in SQL Server Configuration Manager or CLICONFG.EXE (on all Windows machines). Check 64-bit and 32-bit.
•	Check the ERRORLOG file for failure messages, such as the database may not be available or in recovery, etc.
•	Check NETSTAT output to validate SQL is owning the expected port. e.g. NETSTAT -abon > c:\temp\ports.txt ... from an Admin command prompt.

If SQL is using a port other than 1433: if you can connect by hard-coding the port number but not when it is omitted, then this is a SQL Browser issue, if it happens on the server, or more likely, a firewall issue if it only happens remotely. The SQL Browser service may have to be restarted.

If using Always On, connecting to the Listener does not use SQL Browser, so you have to hard-code the port number in the connection string. If that doesn't work, try connecting directly to the Primary node on its regular SQL port. If that works, then the Listener may be bad for some reason. Engage SQL High Availability to check the cluster and Listener configuration.

If none of the above works, restart the SQL Server computer. If the problem persists after that, you may want to engage the SQL Server database engine team.

The worst case scenario would be to stop the SQL Server Service and install a new instance or potentially rebuild the machine, then reattach the databases or restore from backup. If using TDE encryption, e.g. the SSISDB database, make sure the encryption keys are saved before doing this step. It is offered as an option as rebuilding can sometimes be faster than a root cause analysis for intractable problems. For clustered installations, the impact can be less as you can rebuild a node while it is running on the alternate node.

1.5.2	Firewall In general, the firewall default behavior is to block the SQL Server and SQL Browser ports. If this is the case, remote connections will fail while local ones will succeed. Test by using TELNET or PORTQRY:

TELNET SQLProd01 1433
PORTQRY -n SQLPROD01 -p udp -e 1434          # SQL Browser uses UDP Port 1434

	If TELNET is not available, use the PowerShell Test-NetConnection command:

Test-NetConnection SQLPROD01 -Port 1433   
Test-NetConnection SQLPROD01.CONTOSO.COM -Port 1433

Make sure you checked which port SQL Server is listening on in the ERRORLOG file.
You may have to enable TELNET by adding it as a Windows Feature. This does not require a reboot. SQL Server must also be listening on TCP.
PORTQRY can be downloaded from the Microsoft download site.
If using the SQL Browser, make sure the UDP port 1434 is opened in the firewall, as well as the SQL Server TCP port.

1.5.3 	Network The client or app server can connect to a SQL Server on a different machine.
Perhaps multiple clients on a particular network or subnet have trouble connecting to a server outside the subnet or in a specific other subnet.
We have seen issues where a network firewall blocked a specific client from connecting to a specific SQL Server, i.e. the client could connect to other SQL Servers and other clients could connect to the problem SQL Server.

1.5.3.1 	VPN If the issue only happens over a VPN and not when the laptop is brought in-house, then the VPN vendor needs to resolve the issue. You can get a client and server network trace and that may help show what type of problem the VPN is causing, e.g. dropped packets are most likely. The VPN may also change the internal route between the client and server, exposing it to some other network device that is blocking the connection. Collecting network traces on intermediate devices will help isolate the issue by subdividing the network. The TRACERT servername command may reveal the route.

1.5.4	Client Other confirming indicators:
•	Other clients can connect to the server just fine.
•	No applications can connect from this machine.
•	A UDL cannot connect, nor can a connection made from the ODBC Administrator. This could be an outbound firewall rule. This could be bad default DNS suffixes. Try the fully qualified server name to test, e.g.

	TELNET SQLProd01 1433                     
TELENET SQLProd01.Contoso.com 1433

	PORTQRY -n SQLPROD01 -p udp -e 1434       
PORTQRY -n SQLPROD01.Contoso.com -p udp -e 1434

	PING SQLProd01                            
PING SQLProd01.Contoso.com
	
If TELNET is not available, use the PowerShell Test-NetConnection command:

	Test-NetConnection SQLPROD01 -Port 1433   
Test-NetConnection SQLPROD01.CONTOSO.COM -Port 1433

This could be a TLS issue, e.g. the server uses TLS 1.2 and the client drivers have not been upgraded for it.
There could be a HOSTS file entry or a SQL Alias or a DNS Alias that directs the connection to another server. Use PING and TELNET. If they work and the driver fails, suspect a SQL Alias or TLS issue.

1.5.5 	Driver Try different drivers. If some work and others fail, suspect a TLS issue. Download the latest driver, such as MSOLEDBSQL or the ODBC Driver 17 for SQL Server and try that. If using .NET, make sure you are on the latest version of the framework. If it still fails, it should give a better error message. You can also download the latest version of SQL Server Management Studio independent of SQL Server and install on any client. This uses the SqlClient .NET Class.

1.5.6 	User Have another user log into this machine. If they can connect, see what is different about the failing user, such as a bad Windows user profile, or perhaps they belong to a different OU or domain. If there are users from multiple domains, try one from the same domain that the server belongs to. Typically, user issues result in authentication errors and have a different troubleshooting workflow. If not an authentication issue, a Process Monitor log may help identify local permission issues that might be affecting connectivity, e.g. the user has a User DSN or some sort of registry redirect to a different driver or a local permission restriction or something that may explain the connectivity failure.

1.5.7 	Application If only a particular application fails and a UDL file succeeds, then it may be a driver issue or the application has a bad connection string. Have the application development team or 3rd-party vendor check the connection string. You can use Process Explorer from www.sysinternals.com to see what driver is being used if the customer is not sure.

1.6 Advanced Isolation

Capture a client and server network trace (Collect a Network Trace). *** run on both the client and server at the same time ***

Install WireShark with the NCAP driver to trace when the client and server are on the same machine.
Your organization may have its own network infrastructure team that you can engage and may have a preferred tracing tool to perform the capture. They can use any tool as long as it saves in a format compatible with NETMON or WireShark. PCAP format is the most popular.
Run SQL Network Analyzer [SQLNA] and [SQLNAUI] against the network trace for an easy-to-read report.

1.6.1 BID Trace

Collect a SQL Driver BID Trace

For JDBC drivers, this page has instructions: Tracing driver operation (logging) - JDBC Driver for SQL Server | Microsoft Learn

Collect a network trace in addition to the BID Trace or JDBC trace. Microsoft can help interpret the results.

See Also
Reasons for Consistent Auth Issues
