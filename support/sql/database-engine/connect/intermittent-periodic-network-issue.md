---
title: Troubleshoot Intermittent SQL Server Connectivity Issues
description: Learn how to diagnose and fix intermittent or periodic SQL Server connectivity issues using network traces, SQLCHECK, SQLTRACE, and targeted empirical tests.
ms.date: 07/28/2026
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: prmadhes, jopilov, v-sidong
---
# Troubleshoot intermittent or periodic issues with connecting to SQL Server

## Summary

This article explains how to troubleshoot intermittent or periodic network-related issues that cause SQL Server connections to fail, time out, or reset unexpectedly. It describes the most common error messages, the underlying causes (such as dropped packets, antivirus filters, or exhausted ephemeral ports), and a data-driven troubleshooting process based on [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK), [SQLTRACE](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE), and network trace analysis with [SQL Network Analyzer (SQLNA)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA). Use it to identify whether the issue lies on the client, on the server, or in the network path between them.

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

## Common error messages for intermittent SQL Server connectivity issues

Intermittent issues occur irregularly, while periodic issues tend to happen at predictable intervals. Identifying the type of issue is the first step in troubleshooting. When intermittent or periodic SQL Server connectivity issues occur, you might encounter the following error messages:

- **Communication link failure**: This error indicates a disruption in communication between network components.
- **Connection Timeout Expired**: The connection to the server timed out, suggesting a delay or unavailability of the server.
- **General network error**: A general network error message often indicates an unspecified issue with the network.
- **Transport-level error**: This error occurs at the transport layer, suggesting problems with data transmission.
- **The specified network name is no longer available**: This message implies that the specified network resource can't be reached.
- **Semaphore timeout**: This error points to a timeout condition related to the use of semaphores in the network.
- **The Wait Operation Timed Out**: A wait operation has exceeded its allowed time, typically due to network delays.
- **A fatal error occurred while reading the input stream from the network**: This message suggests a critical error when reading data from the network.
- **Protocol error in TDS stream**: Tabular Data Stream (TDS) is a protocol used by SQL Server. This error indicates a problem with the protocol.
- **The server was not found or was not accessible**: This error message suggests that the server you're trying to access is unavailable or can't be found.
- **SQL Server does not exist or access denied**: This error can indicate the absence of the SQL Server or an authentication error when attempting to access SQL Server.

## Common causes of intermittent SQL Server connectivity issues

The most common problems are packet drops caused by antivirus software, network optimization, outdated network drivers, bad routers or switches, and non-pooled connections in the application.

Some causes, such as antivirus software, can be difficult to prove but are still common. You might need to uninstall the software and reboot the computer to prove it, without clear evidence. Creating an exception for SQL Server might also work. But turning off the antivirus usually doesn't work because the network filter drivers still load even if they aren't being monitored.

## Troubleshooting process

> [!NOTE]
> This process is designed for SQL Server client and server connections. It doesn't address other communications, such as SQL Server Mirroring, Always On, and Service Broker synchronization traffic over port 5022.

In general, troubleshooting should be data driven, which might give way to empirical tests in a more focused context. If the problem is very intermittent and network traces are difficult to capture, apply the [empirical methods](#empirical-and-other-actions) first.

### Collect a report using SQLCHECK on each machine

Run [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) on each machine to produce a report. It's useful to determine why a connection might be failing.

### Collect network traces on the client and server

- On Windows machines, collect network traces by using SQLTRACE.

  Follow these steps to prepare and take the trace. Steps 2 and 3 only need to be done once.

  1. Download the latest version of [SQLTRACE](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE) and unzip it to a folder, such as *C:\MSDATA*.
  1. Open the *SQLTrace.ini* file and turn off the following settings:

     `BIDTrace=no`, `AuthTrace=no`, and `EventViewer=no`

  1. Save the file.
  1. Open PowerShell as an administrator and change the directory to the folder containing *SQLTrace.ps1*.

     ```powershell
     CD C:\MSDATA
     ```

  1. Start the trace collection.

     ```powershell
     .\SQLTrace.ps1 -start
     ```

  1. Reproduce the issue or wait for the error to occur.
  1. Stop the trace.

     ```powershell
     .\SQLTrace.ps1 -stop
     ```

  The process creates an output folder in the current directory. Use this folder for further analysis.

- On non-Windows computers, use TCPDUMP or WireShark to collect a packet capture.

### Run SQL Server Network Analyzer

[SQL Network Analyzer UI (SQLNAUI)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI) provides a graphical interface to select trace files for parsing and setting options. Download it from [SQL Network Analyzer (SQLNA)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA).

Process client and server traces separately. If you have chained traces, process them at the same time. The total size of these files shouldn't exceed 80% of your computer's memory. Ensure you have sufficient memory to process all related trace files.

This tool will generate a report of suspected problems and a CSV file that you can explore in Excel for alternate research.

Try to locate matched conversations in the client trace and the server trace. Generally, the IP addresses and port numbers match. However, if the connections go through any sort of network address translation or port mapping, it might be more difficult, and you might have to line up using IPV4 packet IDs and compare the payloads.

### Patterns to look for in network trace analysis

Examine how the conversations end in NETMON or WireShark. Check if the client and server agree on the same thing, or if they tell a different story.

#### Connection closed during SSL handshake

In the ServerHello packet, if the cipher suite used is a Diffie-Hellman suite, and the traffic is between Windows 2012 or earlier and Windows 2016 or later, this algorithm changes starting with Windows 2016 security patches. You should disable this group of cipher suites. For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](../../../windows-server/certificates-and-public-key-infrastructure-pki/apps-forcibly-closed-tls-connection-errors.md).

If the connection is closed after the ClientHello, check if there's a TLS 1.0 or TLS 1.2 mismatch between the client and server. If they're the same, check the enabled cipher suites and enabled hashes on both machines.

For more information, see [Advanced Secure Sockets Layer data capture](troubleshoot-ssl-errors-login-process.md).

#### Dropped packets

View the end of the matched conversations. If one has many retransmitted packets (or 10 Keep-Alive packets, 1-second apart) followed by an ACK+RESET and the other doesn't, or one reports a timely response and the other sees it delayed and closes or resets the conversation, this indicates a problem with the network device and packets are dropped or delayed.

You might also see the client report indicating that the server resets the conversation, and the server report indicating that the client resets the conversation. This is due to a bad switch or router closing the connection from the middle, and they can sometimes be configured to do so if they detect that the connection has been idle for a while - often ignoring Keep-Alive packets.

For more information about dropped connections, see:

- [Connection Dropped in both Directions](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-both-Directions)
- [Connection Dropped in one Direction](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-one-Direction)
- [Connection Dropped in one Direction One Sided Trace](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-one-Direction-One-Sided-Trace)
- [Network Device Reset Connection](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Network-Device-Reset-Connection)

#### Both the server trace and the client trace agree the issue is on the client

If both traces show a delay or no response on the client, or if the client issues an ACK+RESET after acknowledging a server response, or otherwise, closes the connection early during the login sequence, you need to take a BID trace and a NETSH trace on the client to look inside the TCP/IP stack and what the driver is thinking. This is common if the antivirus or other network filter drivers delay receiving the packet or sending the reply. Connection timeouts could also be due to a slow DNS response or slow security API that was called before the initial SYN packet was sent over the wire.

Check SQL Network Analyzer's ephemeral ports report and make sure the client isn't running out of outbound ports.

If the client has a long delay before sending the SYN packet, you may see a pattern showing only the TCP 3-way opening handshake, followed immediately, or sometimes after sending the PreLogin packet, by an ACK+FIN originating from the client.

##### Collect a network trace and BID trace to isolate client issues on Windows

1. Open the *SQLTrace.ini* file and turn the following settings back on:

   `BIDTrace=Yes`, `AuthTrace=Yes`, and `EventViewer=Yes`

1. Configure the `BIDProviderList` in *SQLTrace.ini* to match the driver your application is using.

   `.NET System.Data.SqlClient` is enabled by default. If that's not the driver you're using, disable `BIDProviderList` by adding `#` to the front of the line and remove it from the beginning of the ODBC or OLEDB list. This will capture all supported drivers of that type. For more information, see [INI Configuration](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE#ini-configuration).
1. Save the file.
1. Open PowerShell as an administrator and change the directory to the folder containing *SQLTrace.ps1*.

   ```powershell
   CD C:\MSDATA
   ```

1. Initialize the BID Tracing registry, if collecting BID traces.

   > [!NOTE]
   > BID Tracing is enabled by default.

   ```powershell
   .\SQLTrace.ps1 -setup
   ```

1. Restart the service or application you're tracing.

   For some applications, such as SQL Server Integration Services (SSIS) packages, a new instance of DTEXEC or ISServerExec is launched when the package is run, so a restart doesn't make sense.

1. Start the trace collection.

   ```powershell
   .\SQLTrace.ps1 -start
   ```

1. Reproduce the issue or wait for the error to occur.
1. Stop the trace.

   ```powershell
   .\SQLTrace.ps1 -stop
   ```

The process creates an output folder in the current directory. Use this folder for further analysis.

To trace other Microsoft SQL Server drivers, see the following articles. Perform using a network trace.

- [Linux and Mac ODBC Driver BID Tracing](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-SQL-Driver-BID-Trace#linux-and-mac-odbc-driver-bid-tracing)
- [Collect a .NET Core SQL Driver Trace](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-.NET-Core-SQL-Driver-Trace)
- [Downloading PerfView](https://github.com/Microsoft/perfview/blob/main/documentation/Downloading.md)
- [Use PerfView to collect trace log](/sql/connect/ado-net/enable-eventsource-tracing#use-perfview-to-collect-trace-log)
- [Microsoft JDBC Driver](/sql/connect/jdbc/tracing-driver-operation)

To trace third-party drivers, see the vendor documentation.

#### Both the server trace and the client trace agree the issue is on the server

If both traces show a delay or no response on the server, or if the server closes the connection at an unexpected point in the login sequence, or if the server closes many connections at the same time, this indicates there are some problems on the server.

The most likely causes are poor server performance, high MAXDOP, large parallel queries, and blocking. These conditions can cause thread starvation, which prevents a authentication request from being handled promptly, especially if many connection timeouts end at the same time and the LoginAck column shows "Late." The SQL Server *ERRORLOG* file might show IO operations taking longer than 15 seconds, which is another indicator of performance problems. In the network trace, you might also see many conversations in the Reset report with six frames or fewer, which indicates the TCP 3-way handshake might not be completed. For more information, see [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer).

Run the `RingBufferConnectivity` query and paste the results into Excel. Since this list is historical, you can run it after the problem occurs. But for a busy server, it might end quickly. For a slow server, it might have data for a couple of days.

If your application uses Multiple Active Result Sets (MARS), it ends with a RESET as part of the closing sequence. This is benign if the SMP:FIN and ACK+FIN packets have already been sent from the client. The server's SMP:FIN packet will arrive after ACK+FIN from the client, and Windows will issue an ACK+RESET and then a RESET for any other server responses as part of the connection closing sequence.

#### Connection pooling

For more information, see [Connection pooling](intermittent-periodic-authentication.md#connection-pooling).

If you use connection pooling, conversations in the network trace are typically quite long. You can use the CSV file generated by [SQL Server Network Analyzer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA) to sort and filter by protocols and frames. You probably don't see the beginning or end frames if the network capture is less than half an hour. If many conversations are shorter than 30 frames from the SYN packet to the ACK+FIN packet, this condition indicates non-pooled connections. If these non-pooled connections are mixed with a few longer conversations, suspect background non-pooled connections caused by executing commands on a non-MARS connection while reading a result set.

The ephemeral port report will show the number of new connections over the lifetime of the trace. You can judge the connection rate by the number of connections per second.

#### RESET vs. ACK+RESET

You typically see ACK+RESET when the application or Windows aborts a connection. This condition is generally due to a low-level TCP error. The packet informs the other computer to stop sending immediately. However, if the server is in the middle of transmitting, one or two packets might arrive at the client after the ACK+RESET is sent. Since the port is closed, the operating system sends a RESET packet. This condition also happens if packets arrive after the ACK+FIN packet that's not part of the normal closing handshake.

Some third-party drivers also send an ACK+RESET packet to close the connection instead of an ACK+FIN. Some probe connections can also do this action. If the ACK+RESET packet isn't preceded by Keep-Alive packets, Retransmitted packets, or Zero Windows packets, and it comes from the client when a normal closing of ACK+FIN is expected, it might be benign.

### Use NETSTAT to analyze network issues

NETSTAT is automatically collected when you run *SQLTrace.ps1* for data collection.

Or, you can run `NETSTAT -abon > c:\ports.txt` in **Command Prompt** as an administrator to collect information related to network problems.

The *ports.txt* file contains a list of all inbound and outbound ports, port numbers, process IDs, and names of applications owning the ports. Use this list to see the worst offenders and whether the port limit is reached. Turn on **Status bar** in Notepad and turn off **Word wrap**. The status bar gives a line count. You can divide by two to get an approximate port usage.

### Adjust TcpTimedWaitDelay and MaxUserPort

If an application is exhausting the outbound ports on the host machine and you can't make any immediate changes to the application, you can decrease `TcpTimedWaitDelay` from 240 to as low as 30 seconds, thus allowing outbound ports to be recycled faster.

You can also widen the dynamic client port range on the host machine by using the `netsh int ipv4 set dynamicport tcp` (or `ipv6`) command. This action doesn't eliminate the inefficiencies of non-pooled connections or non-pooled background connections. Ideally the application should be changed to use connection pooling.

Current supported versions of Windows already use the IANA-compliant default dynamic client port range of 49152 through 65535, which provides approximately 16,384 ephemeral ports.

For more information, see [Adjust the MaxUserPort and TcpTimedWaitDelay settings](/biztalk/technical-guides/settings-that-can-be-modified-to-improve-network-performance).

### Issues related to antivirus or network filter driver

Almost all packets sent from the client to the server or the server to the client are responded to with an ACK packet going in the opposite direction. The *TCP.SYS* layer generates the ACK. If a packet is received on the client, and the client trace shows it coming in but no ACK is returned to the server, this condition is a good indication that the antivirus or some other network filter driver lost or dropped the packet or held on to it for a long time (past the end of the network trace collection). Likewise, if the server trace shows a packet coming in from a client but no ACK is sent back to the client, this condition indicates the server antivirus on the server might have a problem.

However, when uploading or downloading a large amount of data, the ACK packets might come after a series of data packets to help with flow control.

It's very difficult to prove that the antivirus and filter drivers are the culprit. You almost always need to run an empirical test. Create an exception for the application or SQL Server in the antivirus, and then monitor it for 48 hours to see if the behavior improves. If you can't set an exception, uninstall the antivirus program and reboot. Disabling it typically doesn't help as the antivirus filter driver will still load. Only do this as a last resort if your edge protection is in place.

Consult your network security admins. If the situation improves, you might need to work with the antivirus vendor to mitigate the problem. If it doesn't, other network filter drivers might be the culprit.

### Enable Windows Firewall auditing

To determine whether the firewall drops any packets, [enable firewall auditing in Windows](../../../windows-client/networking/tcp-ip-connectivity-issues-troubleshooting.md#application-level-reset).

For SQL Server, this issue could be related to the client or server machine. The network trace will show that the machine received a packet but didn't respond. The packet may then be retransmitted, again get no response, and eventually, the connection is reset.

## Empirical and other actions

### Ephemeral ports

Running out of ephemeral ports is a relatively common cause of intermittent connection timeouts, especially if you don't see the SYN packet on the wire.

For incoming requests on the server, ports such as 80 or 1433 can handle up to 64,000 incoming connections per client IP address and are generally unlimited for all practical purposes.

For outbound connections, the number of ports is limited and shared among all server connections. On current supported versions of Windows, the default dynamic client port range is 49152 through 65535, which provides approximately 16,384 ephemeral ports.

Normally, the operating system holds ports for four minutes (240 seconds) before recycling them and allowing applications to reuse them. This delay prevents port spoofing by malicious software or accidental redirection of a new connection to the previous holder of that port. Because of this delay, a client application that uses the default dynamic port range and the default `TcpTimedWaitDelay` of 240 seconds can open only about 68 new outbound connections per second to SQL Server before it exhausts the roughly 16,384 ephemeral ports. Lowering `TcpTimedWaitDelay` or widening the dynamic port range by using `netsh int ipv4 set dynamicport tcp` raises that ceiling.

For applications such as IIS, each HTTP client might have one outgoing port to SQL Server. For a busy web server, running out of outbound ports is a real possibility when the load is high. A web farm can mitigate this situation.

### Adjust max server memory (MB)

To solve problems related to low kernel memory, [adjust the max server memory (MB)](intermittent-periodic-authentication.md#issues-related-to-low-kernel-memory).

### Disable offloading

For testing purposes, you can disable some offloading via an administrative command prompt:

```cmd
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int tcp set global NetDMS=disabled
netsh int tcp set global autotuninglevel=disabled
```

Don't keep these settings disabled for a long time unless they alleviate an issue. They're enabled by default on current supported versions of Windows.

For other offloading, you have to go to the network adapter properties to view and disable them.

### VMware network buffer issues

The ESX host that contains the virtual machine (VM) has a small network buffer that can cause reliability issues if there's a burst in traffic. The following VMware article describes how to increase the buffer size. No reboot is required. This operation must be done on the ESX host machine, not the VM.

[Large packet loss in the guest OS using VMXNET3 in ESXi](https://kb.vmware.com/s/article/2039495)

In addition, try moving the VMs to a different ESX host server or moving the client and server to the same ESX host server and see whether the problem goes away. If it does, it's a base network issue.

### VMware snapshots

Check for VMware snapshots happening during the error and disable them.

### Receive Side Scaling (RSS) disabled on the host machine

When RSS is disabled, the SQL Server host uses only a single CPU to process all network requests. This could spike the CPU to 100% and cause issues, even if the other CPUs' (and the overall CPU) levels are low.

For more information, see [Introduction to Receive Side Scaling](/windows-hardware/drivers/network/introduction-to-receive-side-scaling) and [Receive Side Scaling Version 2 (RSSv2)](/windows-hardware/drivers/network/receive-side-scaling-version-2-rssv2-).

## Related content

- [Intermittent or periodic authentication issues in SQL Server](intermittent-periodic-authentication.md)
- [Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md)
- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)
- [Collect a Network Trace](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-Network-Trace)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
