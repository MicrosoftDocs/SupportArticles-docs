---
title: Intermittent or periodic network issue
description: Troubleshoots the intermittent or periodic network issue.
ms.date: 03/05/2024
ms.custom: sap:Connection issues
ms.reviewer: 
---
# Intermittent or periodic network issue

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](resolve-connectivity-errors-checklist.md#recommended-prerequisites) and go through the checklist. For more information, see [Self-Help Articles](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0015-Self-Help-Articles).

Network stability is essential for the smooth operation of various services and applications. However, there are times when network issues disrupt this stability. This article helps you understand and address intermittent or periodic network problems and the typical error messages associated with them. These issues can be frustrating, but with a better understanding and proper troubleshooting techniques, you can resolve them more effectively.

Intermittent issues are those that occur irregularly, while periodic issues tend to happen at predictable intervals. Identifying the type of issue is the first step in troubleshooting. Here are some common signs:

## Error messages

When intermittent or periodic network issues occur, you might encounter the following error messages:

- **Communication Link Failure**: This error indicates a disruption in communication between network components.
- **Connection Timeout Expired**: The connection to the server timed out, suggesting a delay or unavailability of the server.
- **General Network Error**: A general network error message often indicates an unspecified issue with the network.
- **Transport-Level Error**: This error occurs at the transport layer, suggesting problems with data transmission.
- **The Specified Network Name is Unavailable**: This message implies that the specified network resource can't be reached.
- **Semaphore Timeout**: This error points to a timeout condition related to the use of semaphores in the network.
- **The Wait Operation Timed Out**: A wait operation has exceeded its allowed time, typically due to network delays.
- **A Fatal Error Occurred While Reading from the Input Stream**: This message suggests a critical error when reading data from the network.
- **Protocol Error in TDS Stream**: TDS (Tabular Data Stream) is a protocol used by SQL Server. This error indicates a problem with the protocol.
- **The Server was Not Found or Was Not Accessible**: This error message suggests that the server you're trying to reach is either unavailable or can't be found.
- **SQL Server Does Not Exist or Access Denied**: This error can indicate both the absence of the SQL Server or an authentication error when attempting to access it.

## Cause

The most common issues are related to packet drop due to Antivirus, Network optimization, older network drivers, bad router or switch, and not pooling connections in the application.

Some causes, such as Antivirus can be difficult to prove, but are common, nonetheless. You may have to uninstall and reboot the computer to prove it without hard proof. Creating an exception might work, also. But turning off the AV generally doesn't work because the network filter drivers are still being loaded even if they aren't being monitored.

## Troubleshooting process

> [!NOTE]
> This process is designed for SQL Server client and server connections. Other communications, such as SQL Server Mirroring, Always-On, and Service Broker synchronization traffic over port 5022, are not addressed.

### Collect SQLCHECK on each machine

[Collect SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) on each machine.

### Collect Network Traces on Client and Server

[Collect Network Traces](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-a-Network-Trace) on Client and Server.

### Run SQL Server Network Analyzer

- [SQL Network Analyzer (SQLNA)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA)
- [SQL Network Analyzer UI (SQLNAUI)](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNAUI)

Process client and server traces separately. If you have chained traces, process these at the same time. The combined size of these files shouldn't exceed 80% of your computer's memory. Ensure you have sufficient memory to process all related trace files.

This tool will generate a report of suspected problems and a CSV file you can explore in Excel for alternate research.

Try to locate matched conversations in the client trace and the server trace. Generally, the IP addresses and port numbers match. However, if the connections go through any sort of Network Address Translation or port mapping, it might be a bit more difficult and you might have to line up using IPV4 packet IDs and comparing payloads.

Examine how the conversations end in NETMON or WireShark. Check if the client and server agree on the same thing or they tell a different story.

### Connection closed during SSL handshake

In the ServerHello packet, if the Cipher Suite used is a Diffie-Hellman suite and traffic is between Windows 2012 or earlier and Windows 2016 or later, there was a change in this algorithm starting with Windows 2016 security patches. You should disable this group of cipher suites. For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](/troubleshoot/windows-server/identity/apps-forcibly-closed-tls-connection-errors).

If the connection is closed after the ClientHello, check if there's a TLS 1.0/TLS 1.2 mismatch between client and server. If they're the same, check the enabled Cipher Suites on both machines and enabled hashes.

### Dropped packets

Look at the tail end of the matched conversations. If one has many retransmitted packets (or 10 Keep-Alive packets 1-second apart) followed by an ACK+RESET and the other doesn't or one reports a timely response and the other sees it delayed and closes or resets the conversation, this is indicative of a network device having a problem and dropping or delaying packets.

You might also see the client report indicate the server resets the conversation and the server report indicate the client resets the conversation. This is due to a bad switch or router closing the connection from the middle, and they can sometimes be configured to do so if they detect the connection has been idle for a while - often ignoring Keep-Alive packets.

### Both the Server trace and the client trace agree the issue is on the client

If both traces show a delay or non-response on the client, or if the client issues an ACK+RESET after acknowledging a server response or otherwise closes the connection early part way through the login sequence, you'll want to take a BID trace and a NETSH trace on the client to see inside the TCP/IP stack and what the driver is thinking. This is common if the antivirus or other network filter driver is delaying the packet being received or the reply being sent. Connection timeouts could also be due to a slow DNS response or slow security API that was called before the initial SYN packet is sent over the wire.

Check the Ephemeral Ports report and make sure the client isn't running out of outbound ports.

If the client has a long delay before sending the SYN packet, you may see a pattern showing just the TCP 3-way opening handshake followed immediately, or sometimes after sending the PreLogin packet, by an ACK+FIN originating from the client.

Suggested `NETSH` command for second level isolation:

> [!NOTE]
> This has a circular buffer, so must be terminated immediately after the error occurs.

```cmd
NETSH TRACE START SCENARIO=NETCONNECTION CAPTURE=YES TRACEFILE=c:\temp\mycap.etl FILEMODE=CIRCULAR MAXSIZE=2048 PACKETTRUNCATEBYTES=180
```

Suggested BID Trace commands can be found in the **Cookbook** section. Remember to run the `NETSH` trace and the `BID` trace at the same time.

### Both the SQL trace and the client trace agree the issue is on the server

If both issues show a delay or non-response on the server, or if the server closes the connection at an unexpected point in the login sequence, or if the server closes many connections at the same time, this indicates there are some problems on the server. The most likely cause is poor server performance or high MAXDOP and large, parallel queries and blocking. These can cause thread starvation, preventing a login request being handled in a timely manner, especially if you see many connection timeouts end at the same time and the LoginAck column says 'Late'. The SQL ERRORLOG file may show IO operations taking longer than 15 seconds, which is another indicator of performance issues. In the network trace, you might also see many conversations in the Reset report of six frames or fewer, indicating perhaps the TCP 3-way handshake may not have completed. For more information, see [Collect the Connectivity Ring Buffer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Collect-the-Connectivity-Ring-Buffer).

Run the `RingBufferConnectivity` query and paste the results into Excel. Since this is a historical list, it can be run after the issue occurs, but for a busy server, it might wrap around fairly quickly. For a slow server, it might have data for a couple of days.

If your application uses Multiple Active Result Sets (MARS), it ends in a RESET as part of the closing sequence. This is benign if the SMP:FIN and ACK+FIN packets have already been sent from the client. The server's SMP:FIN packet will arrive after the ACK+FIN from the client and Windows will issue an ACK+RESET and then a RESET for any additional server responses as part of the connection closing sequence.

### Connection pooling

The lack of [connection pooling](/dotnet/framework/data/adonet/sql-server-connection-pooling) can result in intermittent login failures.

> [!NOTE]
> The lack of connection pooling will show a large number of `TIME_WAIT` status codes in the `NETSTAT` output compared to established connections.

If connection pooling isn't enabled, the client may run out of outbound ports, and also overload the server. This overload can cause the server to reject incoming connection requests or flood a poorly performing domain controller.

The best thing to do is to have the application developer use connection pooling in their applications. Connection pooling is ON by default in .NET and Internet Information Services (IIS) applications, but it might have been turned off for some reason.

It's strongly discouraged for applications to use custom pooling code. Almost all custom pooling implementations we've encountered have had issues. It's better to use the built-in connection pooling mechanism.

If connection pooling is being used, conversations in the network trace should be quite long. You can use the CSV file generated by [SQL Server Network Analyzer](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLNA) to sort and filter by Protocol and Frames. In fact, you probably won't see the beginning or end frames if the network capture was less than half an hour. If there are many, many conversations shorter than 30 frames from SYN packet to ACK+FIN packet, this is indicative of non-pooled connections. If these are mixed in with a few longer conversations, suspect background non-pooled connections caused by executing commands on anon-MARS connection while reading a resultset at the same time.

The Ephemeral Port report will show the number of new connections over the lifetime of the trace. You can judge the connection rate by the number of connections per second.

### NETSTAT

Run an Administrative command prompt and then: NETSTAT -abon > c:\ports.txt
The file will contain a list of all inbound ports and all outgoing ports, their numbers, and Process ID and names of applications owning the ports. You can use this to see the worst offenders and whether the port limit is being reached. Turn on the Status Bar in Notepad and turn off Word Wrap. The status bar will give a line count. You can divide by 2 to get an approximate port usage.

### TcpTimedWaitDelay and MaxUserPort

If application is running out of outbound ports and you can't make any changes to the application right away, you can decrease the TcpTimedWaitDelay from 240 to as low as 30 seconds, thus allowing outbound ports to recycle faster. For windows 2003 and later, you can also increase the MaxUserPort setting. For Windows Vista and later, you set this via the NETSH command. This course of action doesn't eliminate the inefficiencies of not pooling connections or non-pooled background connections and the developer should be highly encouraged to change their application.

For Windows 2008 and later, the default range has been increased from about 4,000 ephemeral ports to 16 K ports, by default.

### RESET vs ACK+RESET

ACK+RESET is typically seen when the application aborts a connection. This is to inform the server to stop sending immediately. However, if the server is in the middle of transmitting, a packet or two may arrive at the client after the ACK+RESET is sent. Since the port is now closed, the operating system sends a RESET packet. This also happens if packets arrive after the ACK+FIN Packet that aren't part of the normal closing handshake.

Some 3rd-party drivers will also send a RESET packet to close the connection instead of an ACK+FIN. Some probe connections will also do this.

### Antivirus or network filter driver

Almost all packets sent from client to server or server to client are responded to with an ACK packet going in the opposite direction. The TCP.SYS layer generates the ACK. If a packet is received on the client and the client trace shows it coming in but no ACK is returned to the server, this is a good indication that the Antivirus or some other network filter driver has "eaten" the packet or held on to it for a long time [past the end of the network trace]. Likewise, if the server trace shows a packet coming in from a client but no ACK is sent back to the client; this indicates the server Antivirus may be an issue.

However, when uploading or downloading a large amount of data, the ACK packets may come after a series of data packets to help with flow control.

The antivirus and filter drivers are very difficult to prove as the culprit. An empirical test is almost always required. Create an exception for the application or SQL Server in the antivirus and them monitor for 48 hours to see if the behavior improves. If an exception can't be set, uninstall the device and reboot; disabling won't help as the driver will still get loaded. Only do this as a last resort and if your edge protection is in place.

Consult with your network security admins. If the situation improves, you may want to work with the antivirus vendor to mitigate the issue. If it doesn't, perhaps there are other network filter drivers that could be the culprit. The Windows Networking team can help evaluate the network stack.

### Windows Firewall auditing

The following knowledge Base article contains a section ([Application side reset](/troubleshoot/windows-client/networking/tcp-ip-connectivity-issues-troubleshooting#application-side-reset)) on how to turn on firewall auditing in Windows to determine whether the Firewall has dropped any packets.

[Troubleshoot TCP/IP connectivity](/windows/client-management/troubleshoot-tcpip-connectivity).

For SQL Server, this could be the client machine or the server machine. The network trace will show the machine received a packet but doesn't respond to it. This could be followed by retransmitted packets, again not responded to, and eventually the connection gets reset.

## Empirical and other actions

### Ephemeral ports

Running out of ephemeral ports is a relatively common cause of intermittent connection timeouts, especially if you don't see the SYN packet go on the wire.

For incoming requests on the server, ports, such as 80 or 1433, etc., can take up to 64 K incoming connections per client IP address and are generally "unlimited" for all practical purposes. For outbound connections, on the other hand, the number of ports is limited and is shared between all server connections.

For Windows 2003 and XP, the default outbound port range is from port 1025 to 5000 (3975 ports).

For windows Vista, 2008, and later, the default range is from port 49152 to 65535 (2^16 = 16384 ports).

Normally, ports are held for 4 minutes (240 seconds) by the operating system before they're recycled and allowed to be reused by applications. The reason for this is to prevent port spoofing by malicious software or accidental redirection of a new connection to the previous holder of that port. Because of this delay, on Windows 2003, a client application can make just 17 connections/sec to SQL Server and the outbound port range will be exhausted in just under 4 minutes. For windows Vista, that number rises to 68 connections/sec.

For applications, such as IIS, there could be one outgoing port to SQL Server per HTTP client. For a busy web server, running out of outbound ports is a real possibility when the load is high. A web farm can mitigate this.

### Low Kernel Memory

On the low kernel memory front, in SQL Server Management Studio, check **Maximum Server Memory** in **Server Properties** pane. The default is 2,147,483,647 MB, which means the SQL server can starve the OS of memory. It's best to set this to about 4GB-8GB less than the physical memory on the machine; less if there are multiple instances or IIS or some other app server also runs on the machine.

### Disable offloading

For testing purposes, you can disable some off-loading via an Admin command prompt:

```cmd
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int tcp set global NetDMS=disabled
netsh int tcp set global autotuninglevel=disabled
```

Don't keep these setting disabled long term unless they alleviate an issue. They should be enabled by default on Windows 2008 and later.

For other offloading, you have to go to the network adapter properties to view and disable them.

### VMware network buffer issue

The ESX host that contains the VM has a small network buffer that can cause reliability issues if there's a burst in traffic. The following VMware article shows how to increase the buffer size. No reboot is required. This must be done on the ESX host machine, not the VM.

In addition, try moving the VMs to a different ESX host server or move the client and server to the same ESX host server and see whether the problem goes away. If it does, it's a base network issue.

### VMware snapshots

Check for VMware snapshots happening at the time of the error and disable them.

### Receive Side Scaling (RSS) disabled on the Host Machine

With RSS disabled, the host will only use a single CPU to process all network requests. This could spike the CPU to 100%, causing issues, even if the other CPUs (and overall CPU) levels are low.

## More information

[Intermittent or periodic authentication issues in SQL Server](intermittent-periodic-authentication.md)
