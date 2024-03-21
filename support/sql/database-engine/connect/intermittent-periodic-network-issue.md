---
title: Intermittent or periodic issues with connecting to SQL Server
description: Troubleshoots intermittent or periodic network issues in SQL Server connectivity.
ms.date: 03/08/2024
ms.custom: sap:Connection issues
ms.reviewer: mastewa, prmadhes, jopilov, v-sidong
---
# Troubleshoot intermittent or periodic issues with connecting to SQL Server

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

Network stability is essential for the smooth operation of various services and applications. However, there are times when network issues disrupt this stability. This article helps you understand and address intermittent or periodic network issues and their typical error messages. These issues can be frustrating, but you can resolve them more effectively with a better understanding and proper troubleshooting techniques.

## The most common error messages

Intermittent issues occur irregularly, while periodic issues tend to happen at predictable intervals. Identifying the type of issue is the first step in troubleshooting. When intermittent or periodic network issues occur, you might encounter the following error messages:

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

## Cause

The most common issues are related to packet drops due to antivirus, network optimization, older network drivers, bad routers or switches, and non-pooled connections in the application.

Some causes, such as antivirus, can be difficult to prove, but are still common. You might have to uninstall and reboot the computer to prove it, without clear evidence. Creating an exception for SQL Server might also work. But turning off the antivirus usually doesn't work because the network filter drivers are still loading even if they aren't being monitored.

## Troubleshooting process

> [!NOTE]
> This process is designed for SQL Server client and server connections. Other communications, such as SQL Server Mirroring, Always-On, and Service Broker synchronization traffic over port 5022, aren't addressed.

### Collect SQLCHECK on each machine

[Collect SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) on each machine.

### Collect network traces on the client and server

- On Windows machines, collect network traces using *SQLTrace.ps1*.

  Select the download link on the [SQL Trace home page](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE) and unzip to a folder, such as *C:\MSDATA*.

  Follow these steps to prepare and take the trace. Steps 1 and 2 only need to be done once.

  1. Open the *SQLTrace.ini* file and turn off the following settings:

     BIDTrace=no, AuthTrace=no, and EventViewer=no

  1. Save the file.
  1. Open PowerShell as an Administrator and change directory to the folder containing *SQLTrace.ps1*.

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

  1. Zip the output folder and upload to Microsoft.

- On non-Windows computers, use TCPDUMP or WireShark to collect a packet capture.

### Run SQL Server Network Analyzer

- [SQL Network Analyzer (SQLNA)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA)
- [SQL Network Analyzer UI (SQLNAUI)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI)

Process client and server traces separately. If you have chained traces, process them at the same time. The total size of these files shouldn't exceed 80% of your computer's memory. Ensure you have sufficient memory to process all related trace files.

This tool will generate a report of suspected problems and a CSV file that you can explore in Excel for alternate research.

Try to locate matched conversations in the client trace and the server trace. Generally, the IP addresses and port numbers match. However, if the connections go through any sort of network address translation or port mapping, it might be more difficult, and you might have to line up using IPV4 packet IDs and compare the payloads.

### Patterns to look for in network trace analysis

Examine how the conversations end in NETMON or WireShark. Check if the client and server agree on the same thing, or if they tell a different story.

#### Connection closed during SSL handshake

In the ServerHello packet, if the cipher suite used is a Diffie-Hellman suite, and the traffic is between Windows 2012 or earlier and Windows 2016 or later, this algorithm changes starting with Windows 2016 security patches. You should disable this group of cipher suites. For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](/troubleshoot/windows-server/identity/apps-forcibly-closed-tls-connection-errors).

If the connection is closed after the ClientHello, check if there's a TLS 1.0 or TLS 1.2 mismatch between the client and server. If they're the same, check the enabled cipher suites and enabled hashes on both machines.

#### Dropped packets

View the end of the matched conversations. If one has many retransmitted packets (or 10 Keep-Alive packets, 1-second apart) followed by an ACK+RESET and the other doesn't, or one reports a timely response and the other sees it delayed and closes or resets the conversation, this indicates a problem with the network device and packets are dropped or delayed.

You might also see the client report indicating that the server resets the conversation, and the server report indicating that the client resets the conversation. This is due to a bad switch or router closing the connection from the middle, and they can sometimes be configured to do so if they detect that the connection has been idle for a while - often ignoring Keep-Alive packets.

For more information about dropped connections, see:

- [Connection Dropped in both Directions](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-both-Directions)
- [Connection Dropped in one Direction](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-one-Direction)
- [Connection Dropped in one Direction One Sided Trace](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Connection-Dropped-in-one-Direction-One-Sided-Trace)

#### Both the server trace and the client trace agree the issue is on the client

If both traces show a delay or no response on the client, or if the client issues an ACK+RESET after acknowledging a server response, or otherwise, closes the connection early during the login sequence, you need to take a BID trace and a NETSH trace on the client to look inside the TCP/IP stack and what the driver is thinking. This is common if the antivirus or other network filter drivers delay receiving the packet or sending the reply. Connection time-outs could also be due to a slow DNS response or slow security API that was called before the initial SYN packet was sent over the wire.

Check SQL Network Analyzer's ephemeral ports report and make sure the client isn't running out of outbound ports.

If the client has a long delay before sending the SYN packet, you may see a pattern showing only the TCP 3-way opening handshake, followed immediately, or sometimes after sending the PreLogin packet, by an ACK+FIN originating from the client.

##### Collect a Network Trace and BID Trace to isolate client issues on Windows

1. Open the *SQLTrace.ini* file and turn the following settings back on:

   BIDTrace=Yes, AuthTrace=Yes, and EventViewer=Yes

1. Configure the `BIDProviderList` in *SQLTrace.ini* to match the driver your application is using.

   `.NET System.Data.SqlClient` is enabled by default. If that's not the driver you're using, disable `BIDProviderList` by adding # to the front of the line and remove it from the beginning of the ODBC or OLEDB list. This will capture all supported drivers of that type. For more information, see [INI Configuration](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE#ini-configuration)。
1. Save the file.
1. Open PowerShell as an Administrator and change directory to the folder containing *SQLTrace.ps1*.

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

   For some applications, such as SSIS packages, a new instance of DTEXEC or ISServerExec are launched when the package is run, so a restart doesn't make sense.

1. Start the trace collection.

   ```powershell
   .\SQLTrace.ps1 -start
   ```

1. Reproduce the issue or wait for the error to occur.
1. Stop the trace.

   ```powershell
   .\SQLTrace.ps1 -stop
   ```

1. Zip the output folder and upload to Microsoft.

For tracing other Microsoft SQL Server drivers, see the following articles. Perform with a network trace.

- [Linux and Mac ODBC Driver BID Tracing](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-SQL-Driver-BID-Trace#linux-and-mac-odbc-driver-bid-tracing)
- [Collect a .NET Core SQL Driver Trace](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-.NET-Core-SQL-Driver-Trace)
- [Downloading PerfView](https://github.com/Microsoft/perfview/blob/main/documentation/Downloading.md)
- [Use PerfView to collect trace log](/sql/connect/ado-net/enable-eventsource-tracing#use-perfview-to-collect-trace-log)
- [Microsoft JDBC Driver](/sql/connect/jdbc/tracing-driver-operation)

For tracing third-party Microsoft SQL Server drivers, please consult the vendor documentation.

#### Both the server trace and the client trace agree the issue is on the server

If both traces show a delay or no response on the server, or if the server closes the connection at an unexpected point in the login sequence, or if the server closes many connections at the same time, this indicates there are some problems on the server. The most likely causes are poor server performance, high MAXDOP, and large parallel queries and blocking. These can cause thread starvation, preventing a login request from being handled promptly, especially if many connection timeouts end at the same time and the LoginAck column shows "Late." The SQL Server *ERRORLOG* file may show IO operations taking longer than 15 seconds, which is another indicator of performance issues. In the network trace, you might also see many conversations in the Reset report with six frames or fewer, indicating the TCP 3-way handshake may not have been completed. For more information, see [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer).

Run the `RingBufferConnectivity` query and paste the results into Excel. Since this is a historical list, it can be run after the issue occurs. But for a busy server, it might end quickly. For a slow server, it might have data for a couple of days.

If your application uses Multiple Active Result Sets (MARS), it ends with a RESET as part of the closing sequence. This is benign if the SMP:FIN and ACK+FIN packets have already been sent from the client. The server's SMP:FIN packet will arrive after ACK+FIN from the client, and Windows will issue an ACK+RESET and then a RESET for any other server responses as part of the connection closing sequence.

#### Connection pooling

See [Connection pooling](intermittent-periodic-authentication.md#connection-pooling) for more details.

If connection pooling is used, conversations in the network trace will typically be quite long. You can use the CSV file generated by [SQL Server Network Analyzer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA) to sort and filter by protocols and frames. You probably won't see the beginning or end frames if the network capture is less than half an hour. If many conversations are shorter than 30 frames from the SYN packet to the ACK+FIN packet, this indicates non-pooled connections. If these are mixed with a few longer conversations, suspect background non-pooled connections caused by executing commands on a non-MARS connection while reading a result set.

The ephemeral port report will show the number of new connections over the lifetime of the trace. You can judge the connection rate by the number of connections per second.

#### RESET vs. ACK+RESET

ACK+RESET is typically seen when the application or Windows aborts a connection. This is generally due to a low-level TCP error. The packet informs the other computer to stop sending immediately. However, if the server is in the middle of transmitting, one or two packets may arrive at the client after the ACK+RESET is sent. Since the port is closed, the operating system sends a RESET packet. This also happens if packets arrive after the ACK+FIN packet that's not part of the normal closing handshake.

Some third-party drivers also send a ACK+RESET packet to close the connection instead of an ACK+FIN. Some probe connections can also do this. If the ACK+RESET packet isn't preceded by Keep-Alive packets, Retransmitted packets, or Zero Windows packets, and it comes from the client when a normal closing ACK+FIN might be expected, it could be benign.

### NETSTAT

Run `NETSTAT -abon > c:\ports.txt` in **Command Prompt** as an administrator.

The *ports.txt* file will contain a list of all inbound and outbound ports, port numbers, process IDs, and names of applications owning the ports. You can use this to see the worst offenders and whether the port limit has been reached. Turn on **Status bar** in Notepad and turn off **Word wrap**. The status bar will give a line count. You can divide by two to get an approximate port usage.

This is automatically collected when using *SQLTrace.ps1* for data collection.

### TcpTimedWaitDelay and MaxUserPort

If an application is exhausting the outbound ports on the host machine and you can't make any immediate changes to the application, you can decrease `TcpTimedWaitDelay` from 240 to as low as 30 seconds, thus allowing outbound ports to be recycled faster. For windows 2003 and later, you can also increase the `MaxUserPort`. For Windows Vista and later, you set this via the `NETSH` command. This course of action doesn't eliminate the inefficiencies of non-pooled connections or non-pooled background connections, and the developer should be highly encouraged to change their applications to use connection pooling.

For Windows 2008 and later, the range has been increased from about 4,000 ephemeral ports to 16,000 ports, by default.

### Antivirus or network filter driver

Almost all packets sent from the client to the server or the server to the client are responded to with an ACK packet going in the opposite direction. The *TCP.SYS* layer generates the ACK. If a packet is received on the client, and the client trace shows it coming in but no ACK is returned to the server, this is a good indication that the antivirus or some other network filter driver has lost or dropped the packet or held on to it for a long time (past the end of the network trace collection). Likewise, if the server trace shows a packet coming in from a client but no ACK is sent back to the client, this indicates the server antivirus on the server may have an issue.

However, when uploading or downloading a large amount of data, the ACK packets may come after a series of data packets to help with flow control.

The antivirus and filter drivers are very difficult to prove as the culprit. An empirical test is almost always required. Create an exception for the application or SQL Server in the antivirus, and then monitor it for 48 hours to see if the behavior improves. If an exception can't be set, uninstall the anti-virus program and reboot. Disabling it typically doesn't help as the anti-virus filter driver will still load. Only do this as a last resort if your edge protection is in place.

Consult your network security admins. If the situation improves, you may need to work with the antivirus vendor to mitigate the issue. If it doesn't, other network filter drivers might be the culprit. The Windows Networking team can help evaluate the network stack.

### Windows Firewall auditing

The [Application side reset](/troubleshoot/windows-client/networking/tcp-ip-connectivity-issues-troubleshooting#application-side-reset) section in the article "Troubleshoot TCP/IP connectivity" describes how to turn on firewall auditing in Windows to determine whether the firewall has dropped any packets.

For SQL Server, this could be the client or server machine. The network trace will show that the machine received a packet but didn't respond. The packet may then be retransmitted, again get no response, and eventually, the connection is reset.

## Empirical and other actions

### Ephemeral ports

Running out of ephemeral ports is a relatively common cause of intermittent connection time-outs, especially if you don't see the SYN packet on the wire.

For incoming requests on the server, ports, such as 80 or 1433, can take up to 64,000 incoming connections per client IP address and are generally "unlimited" for all practical purposes.

For outbound connections, on the other hand, the number of ports is limited and shared among all server connections. For Windows Vista, Windows 2008, and later, the default range is from port 49,152 to 65,535 (2^16 = 16,384 ports).

Normally, ports are held for four minutes (240 seconds) by the operating system before they're recycled and allowed to be reused by applications. This is to prevent port spoofing by malicious software or accidental redirection of a new connection to the previous holder of that port. Because of this delay, on Windows 2003, a client application can make only 17 connections per second to SQL Server, and the outbound port range is exhausted in less than four minutes. For Windows Vista, that number rises to 68 connections per second.

For applications such as IIS, each HTTP client may have one outgoing port to SQL Server. For a busy web server, running out of outbound ports is a real possibility when the load is high. A web farm can mitigate this situation.

### Low kernel memory

See [Issues related to low kernel memory](intermittent-periodic-authentication.md#issues-related-to-low-kernel-memory) for more details.

### Disable offloading

For testing purposes, you can disable some offloading via an administrative command prompt:

```cmd
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int tcp set global NetDMS=disabled
netsh int tcp set global autotuninglevel=disabled
```

Don't keep these settings disabled for a long time unless they alleviate an issue. They should be enabled by default on Windows 2008 and later.

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

## More information

[Intermittent or periodic authentication issues in SQL Server](intermittent-periodic-authentication.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
