---
title: Troubleshoot HIS Event 230 warnings
description: This article introduces that how to troubleshoot Host Integration Server Event 230 warnings.
ms.date: 05/11/2020
ms.custom: sap:Network Integration (SNA Gateway)
ms.topic: how-to
---
# Troubleshooting on Host Integration Server Event 230 warnings

This article explains why the Event 230 warning occurs in Host Integration Server and describes how to troubleshoot it.

_Original product version:_ &nbsp; Host Integration Server 2010, BizTalk Adapters for Host Systems 2.0  
_Original KB number:_ &nbsp; 2834567

## Summary

When a Host Integration Server activates an 802.2 Data Link Control (DLC) connection, by default, it submits an unlimited number of Open (Link) requests to the 802.2 DLC link service. If a Host Integration Server 802.2 DLC connection is configured to activate on server startup or by administrator, the server will try indefinitely to activate the connection.

The DLC protocol then sends Logical Link Control (LLC) TEST commands to test link station-to-link station connectivity. The TEST command is provided by the DLC protocol to verify the link station to link station transmission path. The TEST command causes the remote link station to return a TEST Response. Host Integration Server issues a TEST command at the start of every 802.2 DLC connection. Although this command is unnecessary for connection activation, its failure precludes continuing with activation.

You can think of the DLC TEST command as being analogous to a TCP/IP ping command. It verifies the route from the Host Integration Server to the remote IBM host system and back.

When Host Integration Server receives a TEST Response from the remote system, it then sends XID (Exchange Identifier) commands. The process of sending XID commands is the same as sending TEST commands. The XID commands establish mutually agreed upon link station roles and link characteristics. During an 802.2 DLC connection activation process, you may see several XIDs exchanged to negotiate various parameters. To ensure the best chance of discovering the remote system, the DLC protocol submits various types of MAC (Media Access Control) level frames to the NDIS (Network Device Interface Specification) interface. The types of frames submitted depend on the network type (Ethernet or Token Ring) that the DLC protocol is communicating over.

### Ethernet connections

When the 802.2 DLC connection is configured to use Ethernet, the Host Integration Server sends the DLC TEST and XID commands in the following formats:

- Ethernet DIX
- Ethernet 802.3

To accommodate the bit flipping that occurs on Ethernet to Token Ring bridges, the 802.2 DLC link service sends the TEST and XID commands to the bit-flipped remote MAC Address.

Because of above, you'll see four TEST and four XID commands sent by the 802.2 DLC connection during the activation process on Ethernet networks.

### Token Ring connections

On Token Ring, a DLC TEST command is sent to the local ring first. If there's no response to the TEST command, Host Integration Server resends the TEST command with the *all routes broadcast* setting enabled, causing the TEST command to be forwarded to adjacent rings by any source routing bridges that are present on the ring.

If the Host Integration Server doesn't receive a response to the TEST or XID commands, the SNA DLC Link Service logs an Event 230 warning in the application event log.

## Event 230 details

The Event 230 indicates that the remote system isn't responding to either the TEST or XID commands sent by the Host Integration Server system. The formats of the two variations of the event message are shown here:

- Event message for TEST commands

    > Event ID: 230  
    > Source: SNA DLC Link Service  
    > Description:  
    > Remote station not responding to TEST commands  
    >
    > Connection = *connection name*  
    > Local MAC address = *Local MAC address*  
    > Local ring number = *ring number*  
    > Remote MAC address = *Remote MAC address*  
    > Routing data =  
    > Source SAP = *SSAP*  
    > Destination SAP = *DSAP*

- Event message for XID commands

    > Event ID: 230  
    > Source: SNA DLC Link Service  
    > Description:  
    > Remote station not responding to XID commands  
    >
    > Connection = *connection name*  
    > Local MAC address = *Local MAC address*  
    > Local ring number = *ring number*  
    > Remote MAC address = *Remote MAC address*  
    > Routing data =  
    > Source SAP = *SSAP*  
    > Destination SAP = *DSAP*

## Why 802.2 DLC connections log Event 230 warning

In general, an Event 230 warning occurs because of a problem external to the Host Integration Server system. The following are the reasons why 802.2 DLC connections log an Event 230 warning:

- The Remote network address (for example, MAC address) specified for the IBM host system 802.2 DLC connection properties is incorrect.

    > [!NOTE]  
    > The DLC TEST command is sent to Destination SAP (DSAP) 0x00 and should work regardless of what SAP (Service Access Point) addresses the IBM host system is configured to use.

- DLC frames can't reach the network segment where the IBM host system resides.

    Routers/Bridges/Switches/Packet Shapers in the network path aren't be configured to bridge DLC protocol to that remote network segment.

- DLC frames (responses) from the remote IBM system can't reach the network segment where the Host Integration Server resides.

    Routers/Bridges/Switches/Packet Shapers in the network path are not be configured to bridge DLC protocol to the Host Integration Server network segment.

- On a multi-homed Windows Server, the 802.2 DLC Link Service may be bound to the wrong network adapter on the Host Integration Server system.
- DLC protocol isn't active on the remote IBM system.
- Although unlikely, the remote IBM system is returning the TEST Response to the wrong network address.

The conditions listed above cover virtually all of the scenarios that cause Host Integration Server to log Event 230 warnings.

## Traces to determine root cause of Event 230 connection activation problems

The following traces are normally used to determine the root cause of the Event 230 connection activation problems:

- Host Integration Server traces

    These traces are captured using the SNA Trace Utility (snatrace.exe).

- Network traces

    Network capture utilities such as Microsoft Network Monitor, Wireshark, and Ethereal are commonly used.

The basic idea is to enable the HIS and network traces prior to activating the 802.2 DLC connection in SNA Manager. Once the traces are enabled, you will attempt to start the 802.2 DLC connection that generates the Event 230. When the event message is logged, you will stop the traces as soon as possible to prevent the trace data that contains the failure from being overwritten. In the case of Event 230 warnings, the most critical traces are the network traces. The reason is that the most likely cause of the problem is a network problem that causes the DLC TEST (or XID) commands to not reach the remote system.

### Host Integration Server traces

The following steps outline the Host Integration Server traces to capture for a connection outage:

1. Run snatrace.exe.
2. Select the **Tracing Global Properties** tab.
3. Change the **Trace File Flip Length (bytes)** setting from **20000000** to **200000000** (add a **0** to the default length).
4. Enable the **Allow HIS Administrators to perform tracing** option.
5. Select **Apply**.
6. Select the **Trace Items** tab.
7. Highlight the link service name (for example, SNADLC1) used by the 802.2 DLC connection identified in the Event 230 warning and then select **Properties**.
8. Select the **Message Trace** tab.
9. Enable Level 2 Messages and then select **OK**.
10. Highlight SnaServer in the list of **Trace Items** and select **Properties**.
11. Select the **Message Trace** tab.
12. Enable Data Link Control and then select **OK**.
13. You can minimize the SNA Trace Utility at this point as traces are enabled.

    > [!NOTE]  
    > If you close the SNA Trace Utility, you will be prompted with a warning dialog indicating that leaving traces enabled may impact server performance. You can select OK and close the window if you choose.
14. Once the problem occurs, restore (or reopen) the SNA Trace Utility window and select the Clear All Traces button to turn off tracing. You want to do this as soon as possible because the HIS traces are written to circular traces files. The data will be overwritten if the traces continue to run. On busy servers, the traces can wrap quickly.

### Network traces

The steps to enable a network trace depend on the network capture utility that you choose to use. Therefore, specific network capture steps are not included here. Instead, an overview of what needs to be captures is provided:

1. The network capture needs to include the data that flows between the Host Integration Server system and the IBM host system (mainframe or iSeries). In this case, you want to capture the DLC network traffic. If there are multiple network adapters in the Host Integration Server system, you need to make sure that the network capture utility is tracing the correct network adapter if the network trace is being captured on the Host Integration Server system.

    You can set up a filter to limit the amount of traffic being captured. If you use a filter, one option is to capture all the network traffic to/from the Remote Network Address (MAC address) of the remote IBM host system.

    The risk with using filters is that it is possible that the filter will not capture some traffic that is relevant to the connection problems.

2. If the Host Integration Server system and the IBM host system are separated across a WAN (for example, routers, switches, bridges between the systems), it is recommended to perform concurrent network traces at least on the Host Integration Server network segment and the IBM host system's network segment. This gives visibility into the network traffic on each network segment. This allows you to see if DLC packets are making across the WAN. Having a network trace on only one network segment does not give a complete picture because you cannot determine with certainty if a missing DLC packet reached the other network segment or if a DLC response was lost on the way back.

3. When the problem occurs and the Event 230 is logged, you want to stop and save the network trace as soon as possible.

## Trace analysis

The Microsoft Host Integration Server support team uses the resulting trace data to isolate the root cause of the connection failures. In most cases, the problem is caused by one of the following:

- Configuration problem
  - Incorrect Remote Network Addresses
  - DLC protocol is bound the incorrect network adapter on the Host Integration Server system.

- Network problems
- Router/Switch/Bridge/Packet Shaper configuration problems

Generally, the network traces are the main troubleshooting tools for these types of problems because they are normally external to Host Integration Server. The HIS traces are useful in this case to see the DLC TEST and/or XID commands being sent by the 802.2 DLC Link Service. The link service Level 2 message traces also include DLC return codes (for 802.2 DLC link services) that can also be helpful.

In the network traces, we would look for the DLC TEST (or XID) commands to verify that they reach the network layer. If a matching network trace from the remote network segment was captured, we would then check to see if the DLC commands reached that network segment. If the DLC commands were not captured in the remote network trace, then the likely cause is a network configuration problem somewhere in the WAN that prevented the DLC frames from reaching the remote network segment. The next step would be to engage your network support team to do further isolation of the problem.

If the DLC frames reach the remote network segment, then we would look to see if the remote IBM host system sent appropriate DLC TEST (or XID) responses. If there are no TEST or XID responses in the trace, then the likely cause is related to a configuration issue on the remote IBM host system. If the responses are in the remote network trace, but are not in the network trace on the Host Integration Server network trace, then the problem is occurring because of a network configuration issue that prevents DLC frames from reaching the local network segment.
