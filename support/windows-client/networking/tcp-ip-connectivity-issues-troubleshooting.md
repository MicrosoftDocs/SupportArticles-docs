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

This article is designed to guide you through troubleshooting TCP/IP connectivity errors.

You might come across connectivity errors on the application end or timeout errors. Here are a few common scenarios:

- Connectivity failure between an application and database server

- SQL timeout errors
- BizTalk application timeout errors
- Remote Desktop Protocol (RDP) connection failures

- File share access failures
- General connectivity issues

When you suspect that the issue is on the network, you can collect a network packet capture. The packet capture can then be filtered to identify the problematic TCP connection and understand the cause of failure. 

During troubleshooting connectivity errors, you might come across TCP reset in a network capture that could indicate a network issue.  

- TCP is defined as connection-oriented and reliable protocol. One of the ways in which TCP ensures reliability is through the handshake process. Establishing a TCP session would begin with a three-way handshake, followed by data transfer, and then a four-way closure. 

- The four-way closure where both sender and receiver agree on closing the session is termed as graceful closure. After the four-way closure, the server will allow 4 minutes of time (default), during which any pending packets on the network are to be processed, this period is the TIME_WAIT state. After the TIME_WAIT state completes, all the resources allocated for this connection are released.  
- TCP reset is an abrupt closure of the session; it causes the resources allocated to the connection to be immediately released and all other information about the connection is erased.  
- TCP reset is identified by the RESET flag in the TCP header set to 1.  

A network trace collected simultaneously on the source and the destination helps you to determine the flow of the traffic and identify the point of failure.

The following sections describe some of the scenarios when you'll see a RESET.

## Packet drops

When one TCP peer is sending out TCP packets for which there's no response received from the other end, the TCP peer would end up retransmitting the data and when there's no response received, it would end the session by sending an ACK RESET (this ACK RESET means that the application acknowledges whatever data is exchanged so far, but because of packet drop, the connection is closed).  

The simultaneous network traces on source and destination will help you verify this behavior where on the source side you would see the packets being retransmitted and on the destination none of these packets are seen. This scenario denotes that the network device between the source and destination is dropping the packets.

#### Scenario 1: Initial TCP handshake packet drop

If the initial TCP handshake is failing because of packet drops, then you would see that the TCP SYN packet is retransmitted only three times.

> NOTE: The number of times that the TCP SYN packet is retransmitted can be different based on the OS. This is determined by the value "Max SYN Retransmissions" under TCP Global parameters which can be viewed using the command `netsh int tcp show global`. 

Consider an example where source machine with IP Address 10.10.10.1 is connecting to destination with IP Address 10.10.10.2 over TCP port 445.

Here's a snippet of the network trace collected on source which shows the initial TCP handshake wherein TCP SYN packet is sent and then retransmitted by the source because of no response received from destination.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/source-side-port-445.png" alt-text="Screenshot of frame summary in Network Monitor.":::

The same TCP conversation seen in the network trace collected on the destination shows that none of the above packets were received at the destination machine. This implies that the TCP SYN packet was dropped over the intermediate network.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/destination-side-same-filter.png" alt-text="Screenshot of frame summary with filter in Network Monitor.":::

If you see that the TCP SYN packets are reaching the destination, but the destination is still not responding, then verify if the TCP port that you're trying to connect to is in the LISTENING state on destination (this can be checked in the output of this command `netstat -anob`). 

If the port is listening and there's still no response, then there could be a drop at the Windows Filtering Platform (WFP).

#### Scenario 2: Packet drops during data transfer after TCP connection is established

In a scenario where a data packet which is sent after the TCP connection is established gets dropped over the network, TCP will retransmit the packet five times by default.

Consider an example where source machine with IP Address 192.168.1.62 has established a connection with destination machine having IP Address 192.168.1.2 over TCP port 445. 

It is sending data (SMB Negotiate packet) which is being retransmitted 5 times, as seen below. After no response from destination, the source machine is sending an ACK-RST to close this TCP connection.

Source 192.168.1.62 side trace:

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/source-192-168-1-62.png" alt-text="Screenshot showing packet side trace.":::

Destination 192.168.1.2 side trace:

You wouldn't see any of the above packets reaching the destination. 

You will need to engage your internal network team to investigate the different hops between source and destination and see if any of them are potentially causing packet drops. 

## Incorrect parameter in the TCP header

You see this behavior when the packets are modified in the network by middle devices and TCP on the receiving end is unable to accept the packet. An example could be the TCP sequence number being modified or packets being re-played by middle device by changing the TCP sequence number. 

A simultaneous network trace on the source and destination will be helpful to check if any of the TCP headers are modified. 

You will need to start by comparing the source trace and destination trace, you'll be able to notice if there's a change in the packets itself or if any new packets are reaching the destination on behalf of the source.  

In this case, you'll again need help from the internal network team to identify any device that's modifying packets or re-playing packets to the destination. The most common ones are Riverbed devices or WAN accelerators.

## Application side reset

When you've identified that the resets aren't due to packet drops or incorrect parameter or packets being modified with the help of network trace, then you've narrowed it down to an application-level reset.

The application resets are the ones where you see the Acknowledgment flag (ACK) set to 1 along with the Reset (R) flag. This setting would mean that the server is acknowledging the receipt of the packet but for some reason it will not accept the connection. This stage is when the application that received the packet didn't like something it received.  

In the below screenshots, you see that the packets seen on the source and the destination are the same without any modification or any drops, but you see an explicit reset sent by the destination to the source.

Source-side trace:

![Screenshot of packets on source side in Network Monitor.](media/tcp-ip-connectivity-issues-troubleshooting/7mbeof6d.png)

Destination-side trace:

![Screenshot of packets on destination side in Network Monitor.](media/tcp-ip-connectivity-issues-troubleshooting/uv8snmuo.png)

An ACK+RST flagged TCP packet can also be seen in a case when the TCP establishment packet SYN is sent out. The TCP SYN packet is sent when the client wants to connect on a particular port, but if the destination/server for some reason doesn't want to accept the packet, it would send an ACK+RST packet.  

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/ack-rst-flag-packet.png" alt-text="Screenshot of packet with ACK RSK flag.":::

In this case, the application that's causing the reset (identified by port numbers) should be investigated further to understand why it is resetting the connection.

> [!NOTE]
> The above information is about resets from a TCP standpoint and not UDP. UDP is a connectionless protocol, and the packets are sent unreliably. You wouldn't see retransmission or resets when using UDP as a transport protocol. However, UDP makes use of ICMP as an error reporting protocol. When there's a UDP packet sent out on a port and the destination does not have port listed, you'll see the destination sending out **ICMP Destination host unreachable: Port unreachable** message immediately after the UDP packet.
```output
10.10.10.1  10.10.10.2  UDP UDP:SrcPort=49875,DstPort=3343
 
10.10.10.2  10.10.10.1  ICMP    ICMP:Destination Unreachable Message, Port Unreachable,10.10.10.2:3343
```

During troubleshooting TCP/IP connectivity issues, you might also see in the network trace that a machine receives packets but doesn't respond to them. In such cases, there could be a drop at the destination server network stack.

To understand whether the local Windows Firewall is dropping the packet, enable the auditing for Windows Filtering Platform (WFP) on the machine using the following command.

```console
auditpol /set /subcategory:"Filtering Platform Packet Drop" /success:enable /failure:enable
```

You can then review the Security event logs to find a packet drop on a particular TCP Port and IP Address with a WFP filter ID associated.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/security-event-log.png" alt-text="Screenshot of Event Properties with filter id." border="false":::

You can then run the command `netsh wfp show state` which will generate a *wfpstate.xml* file. 

You can open this file with Notepad and filter for the ID that you find in the above event (for example, 2944008 in the sample event above), you'll be able to see a firewall rule name that's associated with this ID that's blocking the connection.

:::image type="content" source="media/tcp-ip-connectivity-issues-troubleshooting/wfpstate-file.png" alt-text="Screenshot of the wfpstate xml file which includes the firewall rule name that's associated with the filter id that's blocking the connection.":::
