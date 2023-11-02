---
title: Information about the TCP Chimney Offload, Receive Side Scaling, and Network Direct Memory Access features in Windows Server 2008
description: Describes the TCP Chimney offload feature in Windows Server 2008. Describes how you can enable or disable this feature.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Information about the TCP Chimney Offload, Receive Side Scaling, and Network Direct Memory Access features in Windows Server 2008

This article describes the TCP Chimney Offload, Receive Side Scaling (RSS), and Network Direct Memory Access (NetDMA) features that are available for the TCP/IP protocol in Windows Server 2008.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951037

## TCP Chimney Offload overview

TCP Chimney Offload is a networking technology that helps transfer the workload from the CPU to a network adapter during network data transfer. In Windows Server 2008, TCP Chimney Offload enables the Windows networking subsystem to offload the processing of a TCP/IP connection to a network adapter that includes special support for TCP/IP offload processing.

TCP Chimney Offload is available in all versions of Windows Server 2008 and Windows Vista. Both TCP/IPv4 connections and TCP/IPv6 connections can be offloaded if the network adapter supports this feature.

## How to enable and disable TCP Chimney Offload in Windows Server 2008

TCP Chimney Offload can be enabled or disabled in the following two locations:

- The operating system
- The advanced properties page of the network adapter

TCP Chimney Offload will work only if it is enabled in both locations. By default, TCP Chimney Offload is disabled in both these locations. However, OEM installations may enable TCP Chimney Offload in the operating system, in the network adapter, or in both the operating system and the network adapter.

### How to configure TCP Chimney Offload in the operating system

- To enable TCP Chimney Offload, follow these steps:

    1. Use administrative credentials to open a command prompt.
    2. At the command prompt, type the `netsh int tcp set global chimney=enabled` command, and then press ENTER。  

- To disable TCP Chimney Offload, follow these steps:

    1. Use administrative credentials to open a command prompt.
    2. At the command prompt, type the `netsh int tcp set global chimney=disabled` command, and then press ENTER.

- To determine the current status of TCP Chimney Offload, follow these steps:

    1. Use administrative credentials to open a command prompt.
    2. At the command prompt, type the `netsh int tcp show global` command, and then press ENTER.

### How to configure TCP Chimney Offload on the network adapter

To enable or disable TCP Chimney Offload, follow these steps:

1. Open Device Manager.
2. Under **Network Adapters**, double-click the network adapter that you want.
3. On the **Advanced** tab, click **Enabled** or **Disabled** in the box next to the TCP offload entry.

> [!NOTE]
> Different manufacturers may use different terms to describe TCP Chimney Offload on the **Advanced** properties page of the network adapter.

## How TCP Chimney Offload coexists with other programs and services

When the TCP Chimney Offload technology offloads TCP/IP processing for a given TCP connection to a dedicated network adapter, it must coexist with other programs or services that rely on lower layer services in the networking subsystem. The following table shows how TCP Chimney Offload coexists with other programs and services.

|Program or service|Works together with TCP Chimney Offload|Expected behavior when both the service and TCP Chimney Offload are enabled|
|---|---|---|
|Windows Firewall|Yes|If the firewall is configured to allow for a given TCP connection, the TCP/IP stack will offload that TCP connection to the network adapter.|
|Third-party firewall|Implementation-specific|Some firewall vendors have decided to implement their product in such a way that TCP Chimney Offload can be used while the firewall service is running. Refer to the firewall documentation to find out whether the product you are using supports TCP Chimney Offload.|
|Internet Protocol security (IPsec) policy|No|If the system has an IPsec policy applied, the TCP/IP stack will not try to offload any TCP connections. This lets the IPsec layer inspect every packet to provide the desired security.|
|Network Adapter teaming service (This service is also known as the Load Balancing and Failover service. It is usually provided by an OEM.)|Implementation-specific|Some OEMs have decided to implement their network adapter teaming solutions so that they coexist with TCP Chimney Offload. See the network adapter teaming service documentation to determine whether you can use TCP Chimney offload together with this service.|
|Windows Virtualization (Hyper-V technology)|No|If you are using the Microsoft Hyper-V technology to run virtual machines, no operating system will take advantage of TCP Chimney offload.|
|Network monitoring tools, such as Network Monitor and Wireshark|Implementation-specific|Some network monitoring tools may coexist with TCP Chimney but may not monitor offloaded connections.<br/>|
|Network Load Balancing (NLB) service|No|If you configure the NLB service on a server, the TCP/IP stack does not offload TCP connections.|
|Cluster service|Yes|However, note that TCP connections using the Network Fault Tolerant driver (NetFT.sys) will not be offloaded. NetFT is used for fault-tolerant inter-node cluster communication.|
|Network Address Translation (NAT) service (also known as the Internet Connection Sharing service)|No|If this service is installed and running, the TCP/IP stack does not offload connections.|
  
## How to determine whether TCP Chimney Offload is working

When TCP Chimney Offload is enabled in the operating system and in the network adapter, the TCP/IP stack tries to offload suitable TCP connections to the network adapter. To find out which of the currently established TCP connections on the system are offloaded, follow these steps:

1. Use administrative credentials to open a command prompt.
2. Type the `netstat -t` command, and then press ENTER.

    You receive output that resembles the following:

    ```output
    Active Connections

    Proto Local Address Foreign Address State Offload State
    
    TCP 127.0.0.1:52613 computer_name:52614 ESTABLISHED InHost
    TCP 192.168.1.103:52614 computer_name:52613 ESTABLISHED Offloaded
    ```

    In this output, the second connection is offloaded.

## How to enable and disable RSS in Windows Server 2008

To enable RSS, follow these steps:

1. Use administrative credentials to open a command prompt.
2. At the command prompt, type the `netsh int tcp set global rss=enabled` command, and then press ENTER.

To disable RSS, follow these steps:

1. Use administrative credentials to open a command prompt.
2. At the command prompt, type the `netsh int tcp set global rss=disabled` command, and then press ENTER.

To determine the current status of RSS, follow these steps:

1. Use administrative credentials to open a command prompt.
2. At the command prompt, type the `netsh int tcp show global` command, and then press ENTER.

When you use a command to enable RSS, you receive the following message:

```output
TCP Global Parameters  
----------------------------------------------  
Receive-Side Scaling State: enabled
```

> [!NOTE]
> By default, RSS is enabled.

## How to enable and disable NetDMA in Windows Server 2008

To enable or disable NetDMA, follow these steps:

1. Click **Start**, click **Run**, type _regedit_, and then click **OK**.
2. Locate the following registry subkey, and then click it:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`
3. Double-click the **EnableTCPA** registry entry.

    > [!NOTE]
    > If this registry entry does not exist, right-click **Parameters**, point to **New**, click **DWORD Value**, type EnableTCPA , and then press ENTER.
4. To enable NetDMA, type _1_ in the **Value data** box, and then click **OK**.
5. To disable NetDMA, type _0_ in the **Value data** box, and then click **OK**.
6. If the EnableTCPA registry entry does not exist, enable the NetDMA functionality.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
