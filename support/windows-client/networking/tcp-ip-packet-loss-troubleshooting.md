---
title: Diagnosing Packet Loss on Windows
description: Learn how to troubleshoot TCP/IP packet loss.
ms.date: 04/23/2025
ms.topic: troubleshooting
audience: itpro
---

# Diagnosing Packet Loss on Windows

## Overview

Packet loss occurs whenever a network packet does not reach its intended destination. Some packet loss is normal, and a dropped packet does not automatically imply it is the cause of a higher-level networking issue. At other times, packet loss can cause reduced performance, and APIs or even applications to fail.

## Capturing Packet Loss Diagnostics

The first step when conducting a packet loss investigation is to capture [pktmon](https://learn.microsoft.com/windows-server/networking/technologies/pktmon/pktmon) traces, typically by using the pktmon command-line workflow. Pktmon is capable of capturing packet traces, attributing local packet loss to specific reasons and code locations, and collecting packet loss statistics. When combined with [Wireshark](https://www.wireshark.org/) analysis of protocol-level behavior, pktmon traces are sufficient to root cause many cases of packet loss. Pktmon will also be capable of collecting packet loss statistics within network cards, but as of early 2025, this feature is not available.

If pktmon diagnostics are inconclusive, more exhaustive component-level traces may be captured using netsh.exe trace start scenario=InternetClient or netsh.exe trace start scenario=InternetServer for client and server scenarios respectively, followed by netsh.exe trace stop after the events have been captured. These component-level traces are relatively noisy and opaque, but often contain additional context before or after a local packet is dropped, or for remote loss, an indication the local system has inferred packet loss has occurred. The traces can be converted to text using netsh.exe trace convert nettrace.etl, opened in [Windows Performance Analyzer](https://learn.microsoft.com/windows-hardware/test/wpt/windows-performance-analyzer), or used with any other ETW tool.

If the network interface (NIC) is suspected as a cause of packet loss, its discard counters can be monitored through any [Performance Counters](https://learn.microsoft.com/windows-server/networking/technologies/network-subsystem/net-sub-performance-counters) interface or the [Get-NetAdapterStatistics](https://learn.microsoft.com/powershell/module/netadapter/get-netadapterstatistics?view=windowsserver2025-ps) cmdlet.

## Common Causes of Packet Loss

### Local Packet Loss

Local packet loss is fully observable and can be caused by a variety of internal and external factors.

- Local policy: inspection software will often cause packets from remote machines to be dropped by default, such as when the Windows firewall rejects inbound connection attempts. These can also be caused by cybersecurity/anti-malware software on the system.

- Low resources: if the system or socket has run out of resources to handle the packet, it will be dropped. Examples of resource limits include physical memory on the system and socket send/receive buffers. Depending on the resource limit, these events may last only microseconds, such as when the system’s CPU cannot react quickly enough to a full receive buffer.

- ARP/ND failure: if the next hop for an outbound packet does not respond to ARP or neighbor discovery (ND) requests, then packets sent to that next hop will be dropped on the local system. Packets may also be dropped while ARP/ND is occurring if the ARP/ND packet queue limit is exceeded. The ARP/ND packets themselves are typically not dropped locally and belong to the remote packet loss category.

- No route: if the network layer cannot find a valid route to the destination, packets will be dropped.

- Invalid packet: if the packet headers are invalid, e.g. contain an invalid checksum or field value, the packet will be dropped.

### Remote Packet Loss

Remote packet loss is not directly observable to the local machine at the instant the packet is dropped: the IP protocol and most below it are “best effort” and not reliable. The [end-to-end principle](https://en.wikipedia.org/wiki/End-to-end_principle) requires endpoints to implement reliability within their protocols if resilience to packet loss is required. In some scenarios, the network or remote endpoint sends a protocol-specific error message indicating the reason for loss, but in many cases, the only indication of packet loss is a lack of response.

- Congestion: loss-based congestion control algorithms send faster and faster until a packet is lost. If the algorithm infers the loss was caused by [congestion](https://en.wikipedia.org/wiki/Network_congestion), it temporarily reduces the rate of sending in response. These algorithms require a small amount of loss to provide a feedback signal.

- Remote policy: the network or remote machine may drop packets per its own policy.

- Destination unreachable: this can occur if the remote machine does not have a socket bound to the remote port, remote machine is offline, the network cannot find a path to the remote machine, etc.

- Session loss: if the network (including stateful NAT, firewalls, load balancers, etc.) or the remote machine is reset or has not received a packet recently, its session context may expire, and subsequent packets are dropped.

- MTU drops: may produce an ICMP fragmentation required / packet too big error if the size of the packet exceeds the maximum transmission size of a network link along the path to the remote machine.

## Examples

### Pktmon

Running the following commands:

```cmd
pktmon.exe start -c
pktmon.exe stop
pktmon.exe etl2txt PktMon.etl
```

The resulting PktMon.txt file contains lines such as:

```txt
[30]0000.0000::2025-03-27 16:10:34.934020500 [Microsoft-Windows-PktMon] Drop: PktGroupId 8444249301423149, PktNumber 1, Appearance 0, Direction Rx , Type IP , Component 49, Filter 1, DropReason INET: transport endpoint was not found , DropLocation 0xE000460A, OriginalSize 402, LoggedSize 148
       Drop: ip: 192.168.5.88.50005 > 192.168.5.68.50005: UDP, length 374
```

This indicates the inbound UDP packet destined to port 50005 was dropped because there was no local socket bound to the port.

### Component Traces

Running the following commands:

```cmd
netsh.exe trace start scenario=InternetClient
netsh.exe trace stop
netsh.exe trace convert NetTrace.etl
```

The resulting NetTrace.txt file contains lines such as:

```txt
[30]0000.0000::2025/03/27-16:12:13.966003800 [Microsoft-Windows-TCPIP]TCPIP: Network layer (Protocol 1(ICMP), AddressFamily = 2(IPV4)) dropped 1 packet(s) on interface 13. SourceAddress = 192.168.5.68. DestAddress = 192.168.5.88. Reason = 9(Inspection drop). Direction = 0(Send). NBL = 0xFFFFE189BEAF3AC0.
```

This indicates the outbound ICMP packet was dropped due to WFP inspection. The next step for WFP is to follow the [WFP live drops troubleshooting steps](https://learn.microsoft.com/windows/security/operating-system-security/network-security/windows-firewall/troubleshooting-uwp-firewall#debugging-live-drops).

In another scenario, a previously sent TCP segment has not been acknowledged by the remote endpoint, and eventually a local retransmit timer fires, causing TCP to re-send some of the potentially lost data:

```txt
[31]0000.0000::2025/03/27-16:12:19.937105000 [Microsoft-Windows-TCPIP]TCP: Connection 0xFFFFE189BD811AA0 0(RetransmitTimer) timer has expired.
[31]0000.0000::2025/03/27-16:12:19.937105800 [Microsoft-Windows-TCPIP]TCP: Tail Loss Probe Event Connection = 0xFFFFE189BD811AA0, Event = 2(TimerFired).
[31]0000.0000::2025/03/27-16:12:19.937106600 [Microsoft-Windows-TCPIP]TCP: Tail Loss Probe Send Connection = 0xFFFFE189BD811AA0 SndUna = 2526318360, SndMax = 2526321759, SendAvailable = 3399, TailProbeSeq = 2526320299, TailProbeLast = 2526321759, ControlsToSend = 0, ThFlags = 16.
[31]0000.0000::2025/03/27-16:12:19.937107600 [Microsoft-Windows-TCPIP]TCP: connection 0xFFFFE189BD811AA0 (local=192.168.5.68:55330 remote=6.6.0.27:443): TCP send event, SeqNo = 2526320299, BytesSent = 1460, CWnd = 18538, SndWnd = 197632, SRtt = 17631, RttVar = 4947, RTO = 300, RcvWnd = 65535, PacingRate = 0, State = 4(EstablishedState), CongestionState = 0, SndUna = 2526318360, SndMax = 2526321759, RecoveryMax = 0, RcvBufSet = 0(FALSE), MaxRcvBuf = 65535.
[31]0000.0000::2025/03/27-16:12:19.937110400 [Microsoft-Windows-TCPIP]TCP: connection = 0xFFFFE189BD811AA0 send tracker marked a transmit as rexmit. Start = 2526320299, End = 2526321759, Timestamp = 467744252, InFlightCount = 2, SackedBytes = 0, BytesInFlight = 4859.
[31]0000.0000::2025/03/27-16:12:19.937110800 [Microsoft-Windows-TCPIP]TCP: Connection 0xFFFFE189BD811AA0 0(RetransmitTimer) timer started. Scheduled to expire in 300 ms. Processor 31: LastInterruptTime 305324952689 100-ns ticks; LastMicrosecondCount 30532515324 msec
```

## See Also

- [Troubleshoot TCP/IP connectivity](tcp-ip-connectivity-issues-troubleshooting)

- [https://www.chromium.org/for-testers/providing-network-details/](https://www.chromium.org/for-testers/providing-network-details/ "https://www.chromium.org/for-testers/providing-network-details/")

- [https://learn.microsoft.com/azure/azure-web-pubsub/howto-troubleshoot-network-trace](https://learn.microsoft.com/azure/azure-web-pubsub/howto-troubleshoot-network-trace "https://learn.microsoft.com/azure/azure-web-pubsub/howto-troubleshoot-network-trace")

- [https://learn.microsoft.com/microsoft-edge/devtools-guide-chromium/network/](https://learn.microsoft.com/microsoft-edge/devtools-guide-chromium/network/ "https://learn.microsoft.com/microsoft-edge/devtools-guide-chromium/network/")

- [https://github.com/microsoft/msquic/blob/main/docs/TSG.md](https://github.com/microsoft/msquic/blob/main/docs/TSG.md)
