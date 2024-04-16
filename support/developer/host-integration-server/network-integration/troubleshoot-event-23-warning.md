---
title: Troubleshooting on Event 23 warnings
description: This article discusses about Event 23 warnings in HIS 2010.
ms.date: 05/11/2020
ms.custom: sap:Network Integration (SNA Gateway)
ms.topic: article
---
# Troubleshooting on Host Integration Server Event 23 warnings

This article introduces about the Event 23 warnings in Microsoft Host Integration Server (HIS) 2010 and HIS 2009.

_Original product version:_ &nbsp; Host Integration Server 2010, BizTalk Adapters for Host Systems 2.0  
_Original KB number:_ &nbsp; 2824716

## Summary

When you configure a HIS to connect to an IBM mainframe or iSeries (AS/400) system, you install and configure one or more link services. The link services provide the communication link between the SNA Server service and device drivers, to support SNA communication over the various link types.

Once the link services are installed and configured, you need to define the actual host connections over which the SNA Server service will communicate with the IBM host systems to access the business applications. Connections as defined in the HIS configuration provide the SNA link level connection used to communicate with the IBM host system.

If the underlying link service detects a problem with the physical link to the IBM host system, an outage code is generated. This outage code is returned to the SNA Server service. When notified that an outage on the connection has occurred, the SNA Server service takes the following actions:

- Logs an Event 23 warning in the application event log
- Cleans up the active SNA sessions on the affected connection.
- Issues a Close(LINK) Request message to the link service to close the connection

When a connection outage occurs, all of the active SNA sessions (LUs) defined on this connection are closed which means that the end users lose their connectivity to the backend IBM applications to which they were interacting with.

## Event 23 warning details

The Event 23 indicates that a host connection failed. The details included in the event message provide more specifics on the reason for the failure. The format of the event message is shown here:

> Event ID: 23  
Source: SNA Server  
Description:
Connection Failure
Connection = *connection name*  
Link Service = *link service name*  
Qualifier = *outage code*  
>
> Explanation  
A link service reported a connection failure to the node. See below for more information on the outage code that caused the connection to fail.
>
> *TOKEN RING, ETHERNET OR FDDI*  
>
> 0029  

The remote system isn't responding to the Host Integration Server computer's attempt to activate an SNA connection.

- 00AE

    The connection has failed because of either a connection timeout, because of slow response from the remote system, or the remote system has deactivated the connection by sending Host Integration Server SNA Service a DISC (connect) or DM frame.

    If slow response from the remote system is suspected, then the Host Integration Server SNA connection t1 and ti timers should be increased.

    If you're connecting to an AS/400 and there are no active user sessions, the AS/400 will drop the connection if the AS/400 APPC controller **Switched Disconnect** setting is set to **YES**.

    To isolate the problem, a Network Monitor trace (or similar utility) must be used to capture an occurrence of the failure.

- 00AF

    The connection to the remote system has been lost. This could occur because of a media error on your LAN, a failure of an intermediate bridge or router, or if the remote system has stopped responding.

- 00AC

    The Windows NT DLC driver has detected a DLC protocol error in a frame received by the remote system and has sent a Frame Reject (FRMR) causing the connection to end. Event 228 should be logged when this error occurs. See the FRMR code in Event 228 for more information describing why the FRMR occurred.

- 00AD

    The remote system has detected a DLC protocol error in a frame sent by Windows NT, and has sent a FRMR causing the connection to end. Event 227 should be logged when this error occurs.

> [!NOTE]
> Related to IP-DLC link services: Connections using an IP-DLC link service also log event warnings when the connection fails. In these instances, the two outage codes that can be logged are 0029 and 00AE which have basically the same meaning as they do for connections using an 802.2 DLC link service. In the case of a 00AE outage for IP-DLC, the information regarding t1 and ti DLC timers don't apply as these are DLC specific settings.

The Event 23 message when view in the Application Event log also includes outage codes for SDLC link services. SDLC outages aren't discussed here because the use of SDLC link services is rare.

## Troubleshooting Event 23 connection failures

In general, Host Integration Server connection failures that result in the logging of Event 23 warnings occur because of conditions external to the HIS Server system. Therefore, troubleshooting steps usually require actions to be taken external to the HIS Server.

Event 23 connection outages are most common in Host Integration Server environments that use the 802.2 DLC link service to connection to IBM host systems via the DLC protocol. There used to be a fair number of Event 23 connection outages with SNA Server and Host Integration Server environments using SDLC or X.25 link services, but the use of SDLC and X.25 protocols is rare these days. The use of IP-DLC link services is growing rapidly, however we don't see Event 23 warnings logged all that often in these environments. The IP-DLC link service does log a number of its own specific event messages when it has problems with the underlying TCP/IP connections that it uses for communication. An Event 23 is likely to occur for an extended outage that prevents the IP-DLC link service from establishing its required TCP/IP sessions to the Network Node Server (NNS).

For Host Integration Server environments using 802.2 DLC and IP-DLC link services, the following traces are required to help determine the root cause of the connection failures that result in the logging of Event 23 warnings:

- Host Integration Server traces

    These traces are captured using the SNA Trace Utility (snatrace.exe).

- Network traces

    Network capture utilities such as Network Monitor, Wireshark, Ethereal are common used.

The basic idea is to enable the HIS and network traces before a connection failure. Once a connection failure occurs, you'll need to stop the traces as soon as possible to prevent the trace data that contains the failure from being overwritten.

## Host Integration Server traces

The following steps outline the Host Integration Server traces to capture for a connection outage:

1. Run snatrace.exe.
2. Select the **Tracing Global Properties** tab.
3. Change the **Trace File Flip Length (bytes)** setting from **20000000** to **200000000** (add a 0 to the default length).
4. Enable the **Allow HIS Administrators to perform tracing** option.
5. Select **Apply**.
6. Select the **Trace Items** tab.
7. Highlight the link service name (SNAIP1, SNADLC1, etc.) specified in the Event 23 warning and then select **Properties**.
8. Select the **Message Trace** tab.
9. Enable **Level 2 Messages** and then select **OK**.
10. Highlight SNA server in the list of **Trace Items** and select **Properties**.
11. Select the **Message Trace** tab.
12. Enable Data Link Control and then select **OK**.
13. You can minimize the SNA Trace Utility at this point as traces are enabled.

    > [!NOTE]  
    > If you close the SNA Trace Utility, you will be prompted with a warning dialog indicating that leaving traces enabled may impact server performance. You can select **OK** and close the window if you choose.

14. Once the connection failure occurs, restore (or reopen) the SNA Trace Utility window and Select the **Clear All Traces** button to turn off tracing. You want to do this as soon as possible because the HIS traces are written to circular traces files. The data will be overwritten if the traces continue to run. On busy servers, the traces can wrap quickly.

## Network traces

The steps to enable a network trace depend on the network capture utility that you choose to use. Therefore, specific network capture steps are not included here. Instead, an overview of what needs to be captures is provided:

1. The network capture needs to include the data that flows between the Host Integration Server system and the IBM host system (mainframe or iSeries). If you are using the 802.2 DLC link service, you want to capture the DLC network traffic. If there are multiple network adapters in the Host Integration Server system, you need to make sure that the network capture utility is tracing the correct network adapter if the network trace is being captured on the Host Integration Server system.

    You can setup a filter to limit the amount of traffic being captured. If you use a filter, one option is to capture all the network traffic to/from the MAC address (if using DLC) or the TCP/IP address (if using IP-DLC) of the remote IBM host system.

    The risk with using filters is that it is possible that the filter will not capture some traffic that is relevant to the connection problems. This is most likely to occur with TCP/IP connections. A filter may miss ICMP Redirect or Destination unreachable frames. These kinds of frames may occur when the network path between the HIS server and IBM Host system is having a problem or when a router between does not have the correct setup or has lost connectivity.

    These kinds of frames are sent from a different TCP/IP address (e.g. the router's address) and may get lost when you use a filter setup with HIS TCP/IP Address and IBM Host system TCP/IP Address.

2. If the Host Integration Server system and the IBM host system are separated across a WAN (e.g. routers, switches, bridges between the systems), the recommendation is to perform concurrent network traces at least on the Host Integration Server network segment and the IBM host system's network segment. This gives visibility into the network traffic on each network segment. This allows you to see if network packets are making across the WAN. Having a network trace on only one network segment does not give a complete picture because you cannot determine with certainty if a missing packet reached the other network segment or if a response was lost on the way back.

3. If the connection failures are random, the traces may need to run for an extended period. In these cases, you may want to setup the network capture utility to save network traces at certain intervals in case the traces cannot be stopped immediately when an outage occurs. This helps to make sure that the relevant data is captured.

4. When a connection failure occurs, you want to stop and save the network trace as soon as possible.

## Trace analysis  

The Host Integration Server support team uses the resulting trace data to isolate the root cause of the connection failures. In most cases, the problem is caused by one of the following:

- Configuration problem

  - Incorrect network addresses
  - Incorrect Service Access Points (SAPs)
  - Incorrect firewall settings (IP-DLC)

- Network Problems

  - Transient network issues
  - Router/Switch/Packet Shaper issues

- IBM Host System outages

  - Normal maintenance windows
  - Unexpected outages on mainframe or iSeries systems

Generally, the network traces are the main troubleshooting tools for these types of problems because they are normally external to Host Integration Server. The HIS traces are useful to see the data flow leading up to the outage. The link service Level 2 message traces also include DLC return codes (for 802.2 DLC link services) that can also be helpful.

- For 802.2 DLC connection failures, the outage code in the Event 23 tells you why the connection dropped. If you refer to the specific outage descriptions above, you will see get an idea as to what to look for in the traces.

    The traces help verify or prove the underlying cause as noted by the outage code.

    For example, an outage code of 0029 (Remote system not responding) usually indicates that the 802.2 DLC link service is not getting a response to the DLC TEST or XID commands that it is sending to the remote system to establish the DLC connection. In these cases, you should also see an Event 230 warning logged in the Application Event log that indicates if the problem occurs because of a TEST or XID command. The network traces in this case are used to verify that the TEST and/or XID command is sent on the wire by the 802.2 DLC link service. If concurrent network traces were captured, you can see if the TEST or XID commands reached the remote network segment. If so, then you should see a TEST or XID response being sent back. If you see the response in the remote network trace but not the other network trace, then the packets were dropped/lost while traversing the WAN. At this point, troubleshooting continues with your network support team.

- For the outage codes that indicate a Frame Reject (FRMR) being sent or received, you would search through the network trace for the FRMR and then work backwards to see the sequence that led to the Frame Reject being sent. In these cases, typical causes are DLC frames being sent out of sequence, incorrect sequence numbers, incorrect DLC frame size. Additional details will be included in a corresponding Event 227 warning, which includes a frame reject code that specifies the reason the frame reject was sent.
