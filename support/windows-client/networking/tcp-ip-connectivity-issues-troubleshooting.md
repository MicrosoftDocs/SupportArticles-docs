---
title: TCP/IP connectivity issues troubleshooting
description: Learn how to troubleshoot TCP/IP connectivity and what you should do if you come across TCP reset in a network capture.
ms.date: 05/10/2024
ms.topic: troubleshooting
manager: dcscontentpm
ms.collection: highpri
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
ms.reviewer: dansimp
audience: itpro
---
# Troubleshoot TCP/IP connectivity

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806409" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Active Directory replication issues.

_Applies to:_ &nbsp; All Windows Client and Server OS versions

This article aims to provide a comprehensive guide for troubleshooting TCP/IP connectivity errors.

You may encounter connectivity issues at the application level or experience timeout errors. A few common scenarios include:

- Application connectivity to a database server
- SQL timeout errors
- BizTalk application timeout errors
- Remote Desktop Protocol (RDP) failures
- File share access failures
- General connectivity

When a network-related issue is suspected, it is advisable to collect a network packet capture. This capture can be filtered to identify the problematic TCP connection and determine the cause of the failure.

During the troubleshooting process, you may encounter a TCP reset in the network capture, which could indicate a network issue.

TCP is characterized as a connection-oriented and reliable protocol. It ensures reliability through the handshake process. A TCP session initiates with a three-way handshake, followed by data transfer, and concludes with a four-way closure.

- A four-way closure, where both the sender and receiver agree to close the session, is known as a graceful closure. This is identified by the FIN flag in the TCP header being set to 1.

- After the four-way closure, the machine waits for 4 minutes (by default) before releasing the port. This is termed as TIME_WAIT state. During this TIME_WAIT state, any pending packets for the TCP connection can be processed. Once the TIME_WAIT state completes, all resources allocated for the connection are released.  
- A TCP reset is an abrupt session closure, causing the immediate release of allocated resources and erasure of all connection information. This is identified by the RESET flag in the TCP header being set to 1. 
A network trace collected simultaneously on the source and the destination helps you to determine the flow of the traffic and identify the point of failure.

The following sections outline scenarios in which a RESET may occur.

## Packet loss over the network

When a TCP peer sends packets without receiving a response, it will retransmit the data. If there is still no response, the session will end with an ACK RESET, indicating that the application acknowledges the exchanged data but closes the connection due to packet loss.

Simultaneous network traces at both the source and destination can verify this behavior. On the source side, you will see retransmitted packets, while on the destination side, these packets will not be present. This scenario indicates that a network device between the source and destination is dropping the packets.

#### Scenario 1: Packet Loss During Initial TCP Handshake

If the initial TCP handshake fails due to packet drops, the TCP SYN packet will be retransmitted 3 times by default.

> NOTE: The number of times that the TCP SYN packet is retransmitted can be different based on the OS. This is determined by the value "Max SYN Retransmissions" under TCP Global parameters which can be viewed using the command `netsh int tcp show global`. 

Consider an example where source machine with IP Address 10.10.10.1 is connecting to destination with IP Address 10.10.10.2 over TCP port 445.

Here's a snippet of the network trace collected on source which shows the initial TCP handshake wherein TCP SYN packet is sent and then retransmitted by the source since no response was received from destination.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/source-side-port-445.png" alt-text="Screenshot of frame summary in Network Monitor.":::

The same TCP conversation seen in the network trace collected on the destination shows that none of the above packets were received by the destination. This implies that the TCP SYN packet was dropped over the intermediate network.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/destination-side-same-filter.png" alt-text="Screenshot of frame summary with filter in Network Monitor.":::

If you see that the TCP SYN packets are reaching the destination, but the destination is still not responding, then verify if the TCP port that you're trying to connect to is in the LISTENING state on destination (this can be checked in the output of the command `netstat -anob`). 

If the port is listening and there's still no response, then there could be a drop at the Windows Filtering Platform (WFP).

#### Scenario 2: Packet Loss During Data Transfer Post TCP Connection Establishment

In a scenario where a data packet sent after the TCP connection is established gets dropped over the network, TCP will retransmit the packet 5 times by default.

Consider an example where source machine with IP Address 192.168.1.62 has established a connection with destination machine having IP Address 192.168.1.2 over TCP port 445. 

It is sending data (SMB Negotiate packet) which is being retransmitted 5 times, as seen below. After no response from destination, the source machine is sending an ACK-RST to close this TCP connection.

Source 192.168.1.62 side trace:

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/source-192-168-1-62.png" alt-text="Screenshot showing packet side trace.":::

Destination 192.168.1.2 side trace:

You wouldn't see any of the above packets reaching the destination. 

You will need to engage your internal network team to investigate the different hops between source and destination and see if any of them are potentially causing packet drops. 

## Incorrect parameter in the TCP header

This behavior occurs when intermediary devices in the network modify packets, causing TCP at the receiving end to reject them. For instance, the TCP sequence number might be altered, or packets could be replayed by an intermediary device with a modified TCP sequence number. 

A simultaneous network trace on the source and destination can help identify any modifications to the TCP headers.

Begin by comparing the source and destination traces to detect any changes in the packets or the presence of new packets reaching the destination on behalf of the source. 

In such cases, it is advisable to seek assistance from the internal network team to identify any devices that are modifying or replaying packets to the destination. Common culprits include Riverbed devices or WAN accelerators.

## Application-level reset

When you have determined that the resets are not due to packet drops, incorrect parameters, or packet modifications (as identified through network traces), you can conclude that the issue is an application-level reset.

Application-level resets are characterized by the Acknowledgment (ACK) flag being set to 1 along with the Reset (R) flag. This indicates that the server acknowledges the receipt of the packet but, for some reason, will not accept the connection. This typically occurs when the application receiving the packet finds something unacceptable in the data.  

In the screenshots below, you can observe that the packets at both the source and destination are identical, with no modifications or drops. However, an explicit reset is sent by the destination to the source.

Source-side trace:

![Screenshot of packets on source side in Network Monitor.](media/tcp-ip-connectivity-issues-troubleshooting/7mbeof6d.png)

Destination-side trace:

![Screenshot of packets on destination side in Network Monitor.](media/tcp-ip-connectivity-issues-troubleshooting/uv8snmuo.png)

An ACK+RST flagged TCP packet can also occur when a TCP SYN packet is sent out. The TCP SYN packet is initiated by the source machine to establish a connection on a specific port. However, if the destination server does not want to accept the packet for any reason, it will respond with an ACK+RST packet.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/ack-rst-flag-packet.png" alt-text="Screenshot of packet with ACK RSK flag.":::In such cases, it is essential to investigate the application causing the reset (identified by port numbers) to understand why the connection is being reset.

> [!NOTE]
> The above information pertains to resets from a TCP perspective and not UDP. UDP is a connectionless protocol, and packets are sent unreliably. Consequently, retransmissions or resets are not observed when using UDP as a transport protocol. However, UDP utilizes ICMP as an error reporting protocol. When a UDP packet is sent to a port that is not listed at the destination, the destination will immediately respond with an ICMP "**Destination Host Unreachable: Port Unreachable**" message.
```output
10.10.10.1  10.10.10.2  UDP UDP:SrcPort=49875,DstPort=3343
 
10.10.10.2  10.10.10.1  ICMP    ICMP:Destination Unreachable Message, Port Unreachable,10.10.10.2:3343
```

During the troubleshooting of TCP/IP connectivity issues, you may observe in the network trace that a machine receives packets but does not respond to them. This could indicate a drop at the destination server's network stack.

To determine whether the local Windows Firewall is dropping the packet, enable auditing for the Windows Filtering Platform (WFP) on the machine using the following command.

```console
auditpol /set /subcategory:"Filtering Platform Packet Drop" /success:enable /failure:enable
```

You can then review the Security event logs to identify a packet drop on a specific TCP port and IP address, along with an associated WFP filter ID.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/security-event-log.png" alt-text="Screenshot of Event Properties with filter id." border="false":::

Next, run the command `netsh wfp show state` which will generate a *wfpstate.xml* file. 

You can open this file with Notepad and filter for the ID found in the event logs (for example, 2944008 in the sample event). This will reveal the firewall rule name associated with the Filter ID that is blocking the connection.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/wfpstate-file.png" alt-text="Screenshot of the wfpstate xml file which includes the firewall rule name that's associated with the filter id that's blocking the connection.":::
