---
title: Troubleshoot RDP Shortpath for public networks
description: Helps troubleshoot RDP Shortpath for public networks for Azure Virtual Desktop, which establishes a UDP-based transport between a Remote Desktop client and session host.
ms.topic: troubleshooting
ms.date: 01/21/2025
ms.reviewer: daknappe
ms.custom: pcy:wincomm-user-experience
---
# Troubleshoot RDP Shortpath for public networks

This article helps troubleshoot issues when using Remote Desktop Protocol (RDP) Shortpath for public networks.

## Verify STUN, TURN server connectivity and NAT type

You can validate connectivity to the STUN and TURN endpoints, and verify that basic User Datagram Protocol (UDP) functionality works by running the executable **avdnettest.exe**. Here's a [download link to the latest version of avdnettest.exe](https://raw.githubusercontent.com/Azure/RDS-Templates/master/AVD-TestShortpath/avdnettest.exe).

You can run **avdnettest.exe** by double-clicking the file, or running it from the command line. The output looks similar to this if the connectivity is successful:

```output
Checking DNS service ... OK
Checking TURN support ... OK
Checking ACS server <IP Address:Port Number> ... OK
Checking ACS server <IP Address:Port Number> ... OK

You have access to TURN servers and your NAT type appears to be 'cone shaped'.
Shortpath for public networks is very likely to work on this host.
```

## Error information logged in Log Analytics

Here are some error titles you might see logged in Log Analytics and what they mean.

### ShortpathTransportNetworkDrop

For Transmission Control Protocol (TCP) connections, there are two different paths:

- From the session host to the gateway
- From the gateway to the client

However, for UDP connections, this difference isn't applicable, as there's no gateway involved. The other distinction for TCP is that in many cases one of the endpoints, or maybe some infrastructure in the middle, generates a TCP Reset packet (RST control bit), which causes a hard shutdown of the TCP connection. This works because TCP RST (and also TCP FIN for graceful shutdown) is handled by the operating system and also some routers, but not the application. This means that if an application crashes, Windows notifies the peer that the TCP connection is gone, but no such mechanism exists for UDP.

Most connection errors, such as **ConnectionFailedClientDisconnect** and **ConnectionFailedServerDisconnect**, are caused by TCP Reset packets, not a time-out. There's no way for the operating system or a router to signal anything with UDP, so the only way to know the peer is gone is by a time-out message.

### ShortpathTransportReliabilityThresholdFailure

This error gets triggered if a specific packet doesn't get through, even though the connection isn't dead. The packet is resent up to 50 times, so it's unlikely but can happen in the following scenarios:

- The connection is fast and stable before it suddenly stops working. The time-out required until a packet is declared lost depends on the round-trip time (RTT) between the client and session host. If the RTT is low, one side can try to resend a packet frequently, so the time it takes to reach 50 tries can be less than the usual time-out value of 17 seconds.
- The packet is large. The maximum packet size that can be transmitted is limited. The size of the packet is probed, but it can fluctuate and sometimes shrink. If that happens, it's possible that the packet being sent is too large and will consistently fail.

### ConnectionBrokenMissedHeartbeatThresholdExceeded

This is an RDP-level time-out. Due to misconfiguration, the RDP level time-out would sometimes trigger before the UDP-level time-out.
