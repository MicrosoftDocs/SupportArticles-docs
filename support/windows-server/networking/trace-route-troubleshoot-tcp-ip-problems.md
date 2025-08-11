---
title: Use TRACERT to Troubleshoot TCP/IP Problems
description: Provides information about how to use TRACERT to troubleshoot TCP/IP problems in Windows.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# How to use TRACERT to troubleshoot TCP/IP problems in Windows

## Summary

This article describes TRACERT (Trace Route), a command-line utility that you can use to trace the path that an Internet Protocol (IP) packet takes to its destination.

This article discusses the following items:

- How to use the TRACERT utility
- How to use TRACERT to troubleshoot
- How to use TRACERT options

## More information

### How to use the TRACERT utility

The TRACERT diagnostic utility determines the route to a destination by sending Internet Control Message Protocol (ICMP) echo packets to the destination. In these packets, TRACERT uses varying IP Time-To-Live (TTL) values. Because each router along the path is required to decrement the packet's TTL by at least 1 before forwarding the packet, the TTL is effectively a hop counter. When the TTL on a packet reaches zero (0), the router sends an ICMP "Time Exceeded" message back to the source computer.

TRACERT sends the first echo packet with a TTL of 1 and increments the TTL by 1 on each subsequent transmission, until the destination responds or until the maximum TTL is reached. The ICMP "Time Exceeded" messages that intermediate routers send back show the route. Note however that some routers silently drop packets that have expired TTLs, and these packets are invisible to TRACERT.

TRACERT prints out an ordered list of the intermediate routers that return ICMP "Time Exceeded" messages. Using the `-d` option with the `tracert` command instructs TRACERT not to perform a Domain Name System (DNS) lookup on each IP address, so that TRACERT reports the IP address of the near-side interface of the routers.

In the following example of the `tracert` command and its output, the packet travels through two routers (\<Router 1 IP Address\> and \<Router 2 IP Address\>) to get to host \<Host IP Address\>. In this example, the default gateway is \<Router 1 IP Address\> and the IP address of the router on the 11.1.0.0 network is at \<Router 2 IP Address\>.

The command:

```console
C:\>tracert <Host IP Address>
```

The output from the command:

```output
Tracing route to <Host IP Address> over a maximum of 30 hops
---------------------------------------------------
1 2 ms 3 ms 2 ms <Router 1 IP Address>
2 75 ms 83 ms 88 ms <Router 2 IP Address>
3 73 ms 79 ms 93 ms <Host IP Address>

Trace complete.
```

## How to use TRACERT to troubleshoot

You can use TRACERT to find out where a packet stopped on the network. In the following example, the default gateway has found that there's no valid path for the host on \<IP Address\>. Probably, either the router has a configuration problem, or the 22.110.0.0 network doesn't exist, reflecting a bad IP address.

The command:

```console
C:\>tracert <IP Address>
```

The output from the command:

```output
Tracing route to <IP Address> over a maximum of 30 hops
-----------------------------------------------------
1 <Router 1 IP Address> reports: Destination net unreachable.

Trace complete.
```

TRACERT is useful for troubleshooting large networks where several paths can lead to the same point or where many intermediate components (routers or bridges) are involved.

### How to use TRACERT options

There are several command-line options that you can use with TRACERT, although the options aren't necessary for standard troubleshooting.

The following example of command syntax shows all of the possible options:

```console
tracert -d -h maximum_hops -j host-list -w timeout target_host
```

What the parameters do:

- `-d`: Specifies to not resolve addresses to host names.
- `-h maximum_hops`: Specifies the maximum number of hops to search for the target.
- `-j host-list`: Specifies loose source route along the host-list.
- `-w timeout`: Waits the number of milliseconds specified by timeout for each reply.
- `target_host`: Specifies the name or IP address of the target host.
