---
title: Troubleshooting WINS error event ID 4102, 4243,  4242, and 4286 messages
description: Describes how to troubleshoot Windows Internet Name Service (WINS) replication-related error messages.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: waltere, v-dehaas, kaushika
ms.custom: sap:Network Connectivity and File Sharing\WINS, csstroubleshoot
---
# Troubleshooting WINS error event ID 4102, 4243, 4242, and 4286 messages

This article describes how to troubleshoot Windows Internet Name Service (WINS) replication-related error messages.

_Applies to:_ &nbsp; Window Server 2003  
_Original KB number:_ &nbsp; 321208

> [!NOTE]
> You may receive different WINS event log messages, depending on the version of Microsoft Windows and the service pack that you have installed on your computer. The Microsoft Knowledge Base contains information about all the changes to event log messages. Always note the error message and the event ID. An event ID alone may mislead you.

## More information

Before you troubleshoot WINS replication-related error messages, make sure that your network uses a true hub-and-spoke replication topology. Make sure that you configure each server to point to itself. Each WINS server that you install on your network must register its own set of unique names and group NetBIOS names in WINS. WINS service problems may occur if different WINS servers own the names that a particular WINS server registers. To prevent these problems, configure each WINS server as its own primary WINS server and secondary WINS server.

You must configure WINS replication correctly to have an efficient WINS-capable network. The most important features of a correct WINS configuration are described in the "Configuring Replication" chapter of the *TCP/IP Core Networking Guide* in the Windows 2000 Server Resource Kit. This information is also included in the "Best Practices for WINS Replication" chapter in the Windows 2000 Server Resource Kit and the "Best practices" topic in the Windows 2000 Server online help file.

> [!NOTE]
> You must avoid push-pull replication in a loop. Microsoft recommends that you use a true hub-and-spoke WINS model.

The "Troubleshooting WINS" section in the Windows 2000 Server Resource Kit describes some basic troubleshooting steps for common problems.

If the servers are located across routers, verify that there isn't a lost network connection or a failed router on an intermediate link. Also make sure that TCP port 42 isn't blocked on an intervening network device, such as a router or a firewall.

### WINS Event ID 4243 Event Message

The following event ID message is an example of an event ID 4243 message. The data section contains important information for troubleshooting: The translation of error code 4243 is WINS_EVT_RPLPULL_PUSH_NTF_EXC.

The WINS Server event log messages contain data that you can use to determine the reason for an error. Change the view of the data section of the event from bytes to words. The second data word in the data section is associated with the type of error that was logged. The type of error that was logged is the key to troubleshooting this issue.
The translation of the second data word (e0000008) in the data section in the example is "WINS_COMM_FAIL - A communication failure occurred. Check for disconnected or unreachable systems."

To troubleshoot this problem, search for disconnected or unreachable computers. Because this error is network-related, you can perform a network trace to determine which WINS server is failing.

> [!NOTE]
> You can use the Event Monitor tool to stop Network Monitor as soon as the event occurs.

#### Possible Causes for the WINS 4243 Event Messages

You may receive this event message if any of the following conditions are true:

- You didn't configure the replication partnership correctly.
- The WINS service isn't running on the replication partner.
- A WINS server has a Pull partner, but the WINS service isn't installed on the Pull partner. In this situation, the target server replies with a "TCP Reset" packet.
- A WINS server has a Pull partner, but the Pull partner isn't reachable for any reason. In this situation, a "TCP Sync" packet is sent, but nothing is received (a "TCP Syn-Ack" packet isn't returned).

#### Resolution for the WINS 4243 Event Messages

To resolve the WINS 4243 event message, perform a Network Monitor trace to find all the obsolete replication partners, and then remove all the obsolete replication partners.

> [!NOTE]
> To identify WINS push or pull replication traffic, examine the traffic on TCP port 42. You can pre-filter the trace for frames on this port.

To perform a Network Monitor trace:

1. Look up the exact timestamp of the error in the system event log of the WINS server that receives the WINS error 4243, and then find occurrences of TCP SYN or RESET frames at that time in the trace.
2. Search the trace for frames where the TCP Flags property includes "Reset the connection." The WINS service isn't installed or isn't running on the computer that sent the TCP Reset.

3. Filter for SYN (Synchronize Sequence numbers) packets.

4. Search the trace for frames where the TCP Flags property includes "Synchronize Sequence numbers," and then determine if all these frames were answered.
5. An obsolete replication partner is a server that sends a TCP Reset packet or a server that doesn't answer. Remove the obsolete replication partners from the list of replication partners for your WINS server. If Windows 2000 WINS server clusters are involved, use only the virtual IP resource for each WINS server cluster as a replication partner. On all WINS servers, remove the Windows 2000 physical nodes from the replication partner list for Windows 2000 WINS server clusters.

### WINS Event ID 4102 Event Message

The following event message is an example of an event ID 4102 event message. The data section contains important information for troubleshooting. Change the view of the data section of the event from bytes to words. If a WINS server has set up a Pull partner, but the Pull partner has not set up a Push partner, the Pull partner logs an event ID 4102.

If you run a Network Monitor trace, you see that the TCP session is established (TCP three-way handshake). To analyze this type of error, configure Network Monitor with the WINS parser. When you use the correct Network Monitor WINS parser, the "Start Association" request and reply appears for the source WINS server and the target WINS server.

When the source client sends a "WINS Add version Number Map Table Request" message, the target WINS server (that doesn't have a partner set up) sends the following error message:

> WINS: Stop Reason = Message Error  

When this error occurs, the WINS server that initiates the replication replies with the following error message:

> WINS: Stop Reason = User Initiated

When this occurs, the TCP session is dropped (TCP FIN).

#### Possible Causes for the WINS 4102 Event Messages

A WINS event ID 4102 event message typically means that there's a communication failure during a WINS connection. This may occur if a WINS server is configured as a Push or Pull partner with a computer that isn't configured as a partner with the first WINS server. Verify that all WINS Servers in the environment are correctly configured.

You may also receive a WINS event ID 4102 event message if a rogue WINS Server is running on the network.

#### Resolution for WINS 4102 Event Messages

To resolve the WINS 4102 event message:

1. Run a Network Monitor trace, and then identify the remote WINS server (Pull partner) that sends the "WINS: Stop Reason = Message Error" error message.
2. Follow either of the following steps:

- On the WINS server where the event ID 4102 is logged, remove the remote WINS server from the list of replication partners.

- On the remote WINS server (the pull partner), configure a push partner to replicate to. The push partner is the WINS server that logs the event ID 4102 message.

### WINS Event ID 4281 Event Message

The following event ID message is an example of an event ID 4281 event message. The data section contains important information for troubleshooting. Change the view of the data section of the event from bytes to words. This error message is typically logged in combination with other WINS error messages. An event ID 4281 message typically is logged as a side effect of other WINS errors. Typically, you resolve this error message when you resolve the other WINS error messages.

### WINS Event ID 4242 Event Message

The following event ID message is an example of an event ID 4242 event message. The data section contains important information for troubleshooting. Change the view of the data section of the event from bytes to words. Because the error code in the data section is network-related, see the troubleshooting steps in the "WINS Error Event ID 4102" section of this article.

### WINS Event ID 4286 Event Message

The following event ID message is an example of an event ID 4286 event message. The data section contains important information for troubleshooting. Change the view of the data section of the event from bytes to words. The situation that this error message describes is temporary and resolves automatically over time. Typically, you receive this event message on WINS servers that have a very long list of replication partners. Typically, a shortage of ephemeral ports causes this issue.

#### Resolution for the WINS Event ID 4286 Event Message

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this issue, you can either wait for the issue to resolve by itself or follow these troubleshooting steps:

1. Examine your replication topology, and make sure that you're configured for a true Hub-and-Spokes replication topology.
2. Verify that there isn't a TCP connection shortage. Before the TCP packet is sent, the computer verifies that it has sufficient resources, for example free outgoing TCP ports. To verify that there isn't a TCP connection shortage, follow these steps:

    1. Run the following command on the failing computer (at the time that this computer is logging the event ID 4286 errors), and then save the output to a file. To do so, run the following command from a command prompt:

        ```console
        netstat -a
        ```

    2. Look for total number of sessions and used ports, examine the state of the sessions to determine whether the number of sessions has reached the maximum value. By default, the maximum value is 5000.

If the output indicates that the server has exhausted all the ports between 1024 and 5000, the server has run out of ephemeral ports. To resolve this issue, follow these steps:

1. Start Registry Editor.
2. Locate the MaxUserPort value under the following key in the registry:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

3. Double-click the MaxUserPort value, type *65534* in the **Value data** box, and then click **OK**.
    > [!NOTE]
    > 65534 is the maximum value for the MaxUserPort value.
4. Quit Registry Editor.
5. Restart the WINS server.

### WINS Event ID 4121 (or 4116 on NT4) Event Message

The following event ID message is an example of Windows 2000 event ID 4121 error message. The data section contains important information for troubleshooting. Change the view of the data section of the event from bytes to words.

> [!NOTE]
> The corresponding event ID on a Windows NT4-based computer is 4116.

> Data Words:  
00000f58 0a080b73 0000164e 00000000 00001652 00000000  
00000f58 0a05f0c6 00005fcf 00000000 000061ac 00000000  
00000f58 dc0f05c9 00005c76 00000000 000068c8 00000000  

The translation of error code 4121 is WINS_EVT_NO_RPL_RECS_RETRIEVED.

On Windows 2000, you may receive the WINS 4121 event log event messages if any of the following conditions is true:

- A computer receives a push notification. Based on this notification the computer uses the pull mechanism to obtain all the newer records than are indicated by the highest version ID. When a pull partner tries to obtain the records based on the version IDs that the pull partner was informed about, those records no longer exist on the partner's database.

    This issue may occur if a push partner lists an entry that is already outdated before the pull time is reached. For example, if you send a push, the entry is updated, and then you send the push again before a pull occurs, you may receive this event message. To resolve this behavior, tune the push count and pull time. Increase the push count and decrease the pull time until the behavior stops.
- A PersonaNonGrata registry entry includes the server that is a replication partner.

Otherwise, you may receive the WINS 4121 event log event message if both of the following conditions are true:

- You have two WINS servers: one push partner and one pull partner.
- When the pull partner initiates a replication (for example, a pull request), the following behavior may occur:

    > [!NOTE]
    > The arrow indicates the direction of traffic.

1. Pull partner -> Push partner

    The pull partner sends to the push partner a query for a list of WINS servers and the highest version ID.
2. Pull partner <- Push partner

    The push partner sends back the list of WINS servers and the highest version ID. The push partner returns a list because the push partner may also be a pull partner of other WINS servers and have in its database IP addresses that other WINS servers own.
3. Pull partner <- Push partner

    On the push partner: For each WINS server, compare the highest version ID with the latest version ID that was replicated. If the highest version ID is higher than the one replicated, the push partner issues a query to the pull partner with the highest version ID.
4. Pull partner -> Push partner

    The pull partner sends a list of entries. If the list is empty, all the new records no longer exist and a 4121 WINS event (or on Windows NT4, a 4116 WINS event) is logged with the IP address of the WINS server that owns the records. (This can be the pull partner or any partner. The partner is in its turn a pull partner of this pull partner).

This event is informational only and doesn't report a problem. Use the following guide to help you to interpret the data that is included in the event message:

> Each line in the "Data Words" section of the event message has the following structure  
4 bytes = Line number in the source code (only used by Microsoft for debugging purposes)  
4 bytes = IP address of a WINS Server (the pull partner or any WINS server that replicates with the pull partner)  
8 bytes = 64-bits number for the minimum version ID  
8 bytes = 64-bits number for the maximum version ID  

In the previous example, the three lines of data words translate as:

IP-Address, Min-Version, Max-Version  
\------------- -------------- -------------  
 **10.8.11.115**, 164E 0, 1652 0 (The difference of hex1652 - 164E = 4 is the number of records to replicate)  

**10.5.240.198**, 5fcf 0, 61ac 0 (477 records to replicate)  
 **220.15.5.201**, 5c76 0, 68c8 0(3154 records to replicate)  

This behavior is by design, and WINS continues to log the event message. In Windows NT 4.0 and later, the computer logs this event only if you've enabled the **Log detailed events** option.

To disable detailed logging, follow these steps:

1. In WINS Manager, click **Configuration** on the **Server** menu.
2. Click **Advanced**, and then click to clear the **Log Detailed Events** check box.

### Corrupted WINS Database

In rare situations the WINS database may be corrupted. To recover from this situation, follow these steps:

1. Stop replication.
2. Delete the replication partners.
3. Use the Jetpack tool on the database on the hub server.
4. Reestablish replication, and then force a replication.
5. Use the WINS Microsoft Management Console (MMC) to examine the consistency of the WINS database.

In a large WINS environment where IP addresses constantly change, don't configure the Replicate on Address change option on an NT4 WINS server. The equivalent setting on a Windows 2000 WINS server is the **When address changes** check box in the WINS snap-in. Click to clear the check box to restore the default setting.

For additional information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[150737](https://support.microsoft.com/help/150737) Setting primary and secondary WINS server options  

For more information, see the white paper "Windows Internet Naming Service (WINS): Architecture and Capacity Planning". To do so, visit the following Microsoft Web site:

[Windows 2000 Server Windows Internet Naming Service (WINS) Overview](https://technet.microsoft.com/library/bb742607.aspx)

### Running WINS on a Cluster

On a Windows 2000 server cluster, configure all WINS replication partners to replicate with the virtual server on the server cluster. On a Windows NT 4.0 server cluster, you must configure the single nodes as replication partners because the failover feature isn't available for the WINS service on Windows NT 4.0 server clusters.

### How to Configure Network Monitor to Use the WINS Parser

Microsoft Windows 2000 Server Resource Kit includes the WINS Replication Network Monitor parser (Wins.dll) that can be useful for troubleshooting issues.

To download the updated version of the Wins.dll file, see "Supplement One" of the Windows 2000 Server Resource Kit. To use the WINS replication parser:

1. Copy the WINS replication parser (Wins.dll) to the System32\\NetmonFull\\Parsers folder.
2. Add the following line to the [PARSERS] section in the Parser.ini file:

    ```ini
    wins.dll =0: WINS
    ```

3. Add the following section to the Parser.ini file:

    ```ini
    [WINS]  
    Comment="WINS Protocol"  
    FollowSet=  
    HelpFile=  
    ```

    > [!NOTE]
    > The Parser.ini file is located in the System32\\NetmonFull folder.
4. Add the following line to the [TCP_HandoffSet] section in the Tcpip.ini file:

    ```ini
    42 = WINS; added
    ```

    > [!NOTE]
    > The Tcpip.ini file is located in the System32\\NetmonFull\\Parsers folder.

#### Example of a WINS Replication Frame

After you configure the WINS parser, you can see the details of each WINS replication package when you run a Network Monitor trace. For example:

> #2725 10:05:01.208 00307B967C50 0002A56BB95B WINS Replication Packet
>
> IP: Source Address = 10.46.4.201  
IP: Destination Address = 10.12.49.23 IP  
>
> TCP: .AP..., len: 45, seq: 44355679-44355724, ack: 799772100, win: 8760, src: 2874 dst: 42  
TCP: Source Port = 0x0B79  
TCP: Destination Port = Host Name Server  
>
> WINS: WINS Replication Packet  
WINS: WINS Data Size = 41 (0x29)  
WINS: WINS Opcode = Non NBT Frame  
WINS: WINS Association Context = 0 (0x0)  
WINS: WINS Message Type = Start Association Request  
WINS: WINS Association Context = 807300098 (0x301E6C02)  
WINS: WINS Minor Version = 1 (0x1)  
WINS: WINS Major Version = 1 (0x1)  

To determine whether the replication partner is running a Windows NT 4.0-based computer or a Windows 2000-based computer, view the major and minor version. Windows 2000-based computers appear as minor version 2 and major version 5, and Windows NT 4.0 computers appear as minor version 1 and major version 1.

#### Corresponding Frame for a WINS Event ID 4102 Event Message

The WINS server that initiates the replication and sends this frame records the WINS Error 4102 in the system event log.2330 10:04:57.896 0002A56BB95B CISCO 07AC45 WINS Replication Packet **Source Address** -> **Destination Address** IP

> IP: Source Address = **IP Address**  
IP: Destination Address = **IP Address**  
>
> TCP: .AP..., len: 44, seq: 498801786-498801830, ack: 522782479, win: 17475, src: 2937 dst: 42  
TCP: Source Port = 0x0B79  
TCP: Destination Port = Host Name Server  
>
> WINS: WINS Replication Packet  
WINS: WINS Data Size = 40 (0x28)  
WINS: WINS Opcode = Non NBT Frame  
WINS: WINS Association Context = 942499842 (0x382D6802)  
WINS: WINS Message Type = Stop Association Message  
WINS: Stop Reason = User Initiated  

> [!NOTE]
> If you see this frame in a Network Monitor trace it does not automatically imply an error because this frame is also sent after a successful replication.
