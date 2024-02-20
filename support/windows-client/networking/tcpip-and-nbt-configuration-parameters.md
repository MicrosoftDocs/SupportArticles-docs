---
title: TCP/IP and NBT configuration parameters for Windows XP
description: Describes how to use Registry Editor to change TCP/IP and NBT configuration parameters in the rare circumstance where you must use this configuration. Defines standard and optional parameters and describes the parameters that should not be changed.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# TCP/IP and NBT configuration parameters for Windows XP

This article defines all the registry parameters that are used to configure the protocol driver, Tcpip.sys. Tcpip.sys implements the standard TCP/IP network protocols.

_Applies to:_ &nbsp; Windows XP  
_Original KB number:_ &nbsp; 314053

## Introduction

The TCP/IP protocol suite implementation for Windows XP reads all its configuration data from the registry. This information is written to the registry by the Network tool in Control Panel as part of the Setup process. Some of this information is also supplied by the Dynamic Host Configuration Protocol (DHCP) Client service if the DHCP Client service is enabled.

The implementation of the protocol suite should perform correctly and efficiently in most environments by using only the configuration information that is gathered by DHCP and by the Network tool in Control Panel. Optimal default values for all other configurable aspects of the protocols have been encoded in the drivers.

There may be some unusual circumstances in customer installations where changes to certain default values are appropriate. To handle these cases, optional registry parameters can be created to modify the default behavior of some parts of the protocol drivers.

> [!NOTE]
> The Windows XP TCP/IP implementation is largely self-tuning. Adjusting registry parameters without careful study may reduce your computer's performance.

## How to change parameters

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To change these parameters, follow these steps:

1. Click **Start**, click **Run**, and then type *regedit* in the **Open** box.
2. Locate the following registry key:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`
3. Click **Add Value** on the **Edit** menu, type the value that you want, and then set the value type under **Data Type**.
4. Click **OK**.
5. Quit Registry Editor.
6. Restart the computer to make the change take effect.

All the TCP/IP parameters are registry values that are located under one of two different subkeys of `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`:

- `Tcpip\Parameters`
- `Tcpip\Parameters\Interfaces\ID for Adapter`

> [!NOTE]
> **ID for Adapter** is the network adapter that TCP/IP is bound to. To determine the relationship between an Adapter ID and a network connection, view `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}\<ID for Adapter>\Connection`. The Name value in these keys provides the friendly name for a network connection that is used in the Network Connections folder. Values under these keys are specific to each adapter. Parameters that have a DHCP configured value and a statically configured value may or may not exist. Their existence depends on whether the computer or the adapter is DHCP configured and whether static override values are specified. You must restart the computer for a change to take effect.

## Standard TCP/IP parameters that you can configure by using Registry Editor

The following parameters are installed with default values by the Network tool in Control Panel during the installation of the TCP/IP components. You can use Registry Editor to modify them.

- DatabasePath
  - Key: `Tcpip\Parameters`
  - Value type: REG_EXPAND_SZ - Character string
  - Valid range: A valid Windows NT file path
  - Default: %SystemRoot%\\System32\\Drivers\\Etc
  - Description: This parameter specifies the path of the standard Internet database files (HOSTS, LMHOSTS, NETWORKS, PROTOCOLS). It is used by the Windows Sockets interface.

- ForwardBroadcasts
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: Forwarding of broadcasts is not supported. This parameter is ignored.

- UseZeroBroadcast
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: If this parameter is set to 1 (True), the IP will use zeros-broadcasts (0.0.0.0) instead of ones-broadcasts (255.255.255.255). Most computers use ones-broadcasts, but some computers that are derived from BSD implementations use zeros-broadcasts. Computers that use different broadcasts do not interoperate well on the same network.

## Optional TCP/IP parameters that you can configure by using Registry Editor

Generally, these parameters do not exist in the registry. You can create them to modify the default behavior of the TCP/IP protocol driver.

- ArpAlwaysSourceRoute
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False or True)
  - Default: 0 (False)
  - Description: If you set this parameter to 1, TCP/IP transmits ARP queries with source routing enabled on Token Ring networks. By default, the stack transmits ARP queries without source routing first and retries with source routing enabled if no reply was received.

- ArpUseEtherSNAP
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False or True)
  - Default: 0 (False)
  - Description: If you set this parameter to 1, TCP/IP transmits Ethernet packets using 802.3 SNAP encoding. By default, the stack transmits packets in DIX Ethernet format. It will always receive both formats.

- DefaultTTL
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number of seconds/hops
  - Valid range: 1-255
  - Default: 128 for Windows XP
  - Description: This parameter specifies the default Time To Live (TTL) value that is set in the header of outgoing IP packets. The TTL determines the maximum time that an IP packet can live in the network without reaching its destination. It is effectively a limit on the number of routers an IP packet can pass through before it is discarded.

- EnableDeadGWDetect
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False, True)
  - Default: 1 (True)
  - Description: If you set this parameter to 1, TCP uses the Dead Gateway Detection feature. With this feature, TCP requests IP to change to a backup gateway if it retransmits a segment several times without receiving a response. Backup gateways may be defined in the **Advanced** section of the **TCP/IP configuration** dialog box in the Network Control Panel.

- EnablePMTUBHDetect
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False, True)
  - Default: 0 (False)
  - Description: If you set this parameter to 1 (True), TCP tries to detect "Black Hole" routers while doing Path MTU Discovery. A "Black Hole" router does not return ICMP Destination Unreachable messages when it must fragment an IP datagram with the Don't Fragment bit set. TCP must receive these messages to perform Path MTU Discovery. With this feature enabled, TCP will try to send segments without the Don't Fragment bit set if several retransmissions of a segment are unacknowledged. If the segment is acknowledged, the MSS will be decreased and the Don't Fragment bit will be set in future packets on the connection. Enabling black hole detection increases the maximum number of retransmissions that are performed for a particular segment.

- EnablePMTUDiscovery
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False, True)
  - Default: 1 (True)
  - Description: If you set this parameter to 1 (True), TCP tries to discover the Maximum Transmission Unit (MTU or largest packet size) over the path to a remote host. By discovering the Path MTU and limiting TCP segments to this size, TCP can eliminate fragmentation at routers along the path that connect networks with different MTUs. Fragmentation adversely affects TCP throughput and causes network congestion. If you set this parameter to 0, an MTU of 576 bytes is used for all connections that are not to computers on the local subnet.

- ForwardBufferMemory
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number of bytes
  - Valid range: network MTU - some reasonable value smaller than 0xFFFFFFFF
  - Default: 74240 (sufficient for fifty 1480-byte packets, rounded to a multiple of 256)
  - Description: This parameter determines how much memory IP allocates to store packet data in the router packet queue. When this buffer space is filled, the router starts to discard packets at random from its queue. Packet queue data buffers are 256 bytes in length. Therefore, the value of this parameter must be a multiple of 256. Multiple buffers are chained together for larger packets. The IP header for a packet is stored separately. This parameter is ignored and no buffers are allocated if the IP router is not enabled.

- IGMPLevel
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 0,1,2
  - Default: 2
  - Description: This parameter determines how well the computer supports IP multicasting and participates in the Internet Group Management Protocol. At level 0, the computer provides no multicast support. At level 1, the computer can only send IP multicast packets. At level 2, the computer can send IP multicast packets and fully participate in IGMP to receive multicast packets.

- KeepAliveInterval
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 1 - 0xFFFFFFFF
  - Default: 1000 (one second)
  - Description: This parameter determines the interval that separates keepalive retransmissions until a response is received. After a response is received, KeepAliveTime again controls the delay until the next keepalive transmission. The connection is aborted after the number of retransmissions that are specified by TcpMaxDataRetransmissions are unanswered.

- KeepAliveTime
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 1 - 0xFFFFFFFF
  - Default: 7,200,000 (two hours)
  - Description: The parameter controls how frequently TCP tries to verify that an idle connection is still intact by sending a keepalive packet. If the remote computer is still reachable and functioning, the remote computer acknowledges the keepalive transmission. By default, keepalive packets are not sent. A program can turn on this feature on a connection.

- MTU
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD Number
  - Valid range: 68 - the MTU of the underlying network
  - Default: 0xFFFFFFFF
  - Description: This parameter overrides the default Maximum Transmission Unit (MTU) for a network interface. The MTU is the maximum packet size in bytes that the transport transmits over the underlying network. The size includes the transport header. An IP datagram can span multiple packets. Values larger than the default value for the underlying network cause the transport to use the network default MTU. Values smaller than 68 cause the transport to use an MTU of 68.

- NumForwardPackets
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD Number
  - Valid range: 1 - some reasonable value smaller than 0xFFFFFFFF
  - Default: 50
  - Description: This parameter determines the number of IP packet headers that are allocated for the router packet queue. When all headers are in use, the router begins to discard packets at random from the queue. This value should be at least as large as the ForwardBufferMemory value divided by the maximum IP data size of the networks that are connected to the router. This value must be no larger than the ForwardBufferMemory value divided by 256 because at least 256 bytes of forward buffer memory are used for each packet. The optimal number of forward packets for a particular ForwardBufferMemory size depends on the type of traffic that is carried on the network and will be somewhere between these two values. This parameter is ignored and no headers are allocated if the router is not enabled.

- TcpMaxConnectRetransmissions
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 0 - 0xFFFFFFFF
  - Default: 2
  - Description: This parameter determines the number of times that TCP retransmits a connect request (SYN) before aborting the attempt. The retransmission timeout is doubled with each successive retransmission in a particular connect attempt. The initial timeout value is three seconds.

- TcpMaxDataRetransmissions
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 0 - 0xFFFFFFFF
  - Default: 5
  - Description: This parameter controls the number of times that TCP retransmits an individual data segment (non-connect segment) before it aborts the connection. The retransmission timeout is doubled with each successive retransmission on a connection. It is reset when responses resume. The base timeout value is dynamically determined by the measured round-trip time on the connection.

- TcpNumConnections
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 0 - 0xfffffe
  - Default: 0xfffffe
  - Description: This parameter limits the maximum number of connections that TCP can have open at the same time.

- TcpTimedWaitDelay
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Time in seconds
  - Valid range: 30-300 (decimal)
  - Default: 0x78 (120 decimal)
  - Description: This parameter determines the time that a connection stays in the TIME_WAIT state when it is closing. As long as a connection is in the TIME_WAIT state, the socket pair cannot be re-used. This is also known as the "2MSL" state. According to RFC793, the value should be two times the maximum segment lifetime on the network. See RFC793 for more information.

    > [!NOTE]
    > In Microsoft Windows 2000, the default value is 240 seconds. For Windows XP and Microsoft Windows Server 2003, the default was changed to 120 seconds for the IPv4 stack to increase performance. The default value for the IPv6 stack is 240 seconds.

- TcpUseRFC1122UrgentPointer
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0,1 (False, True)
  - Default: 0 (False)
  - Description: This parameter determines whether TCP uses the RFC 1122 specification for urgent data or the mode that is used by BSD-derived computers. The two mechanisms interpret the urgent pointer in the TCP header and the length of the urgent data differently. They are not interoperable. By default, Windows XP uses the BSD mode.

- TcpWindowSize
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Number of bytes
  - Valid range: 0 - 0xFFFF
  - Default: The smaller of 0xFFFF OR the larger of four times the maximum TCP data size on the network OR 8192 rounded up to an even multiple of the network TCP data size.
  - Ethernet default: 8760
  - Description: This parameter determines the maximum TCP receive window size of the computer. The receive window specifies the number of bytes a sender can transmit without receiving an acknowledgment. Generally, larger receive windows improve performance over high (delay * bandwidth) networks. For highest efficiency, the receive window must be an even multiple of the TCP Maximum Segment Size (MSS).

## TCP/IP parameters that are configurable from the properties of a network connection

The following parameters are created and modified automatically by the connection properties interface through user-supplied information. You do not have to configure them directly in the registry.

- DefaultGateway
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_MULTI_SZ - List of dotted decimal IP addresses
  - Valid range: Any set of valid IP addresses
  - Default: None
  - Description: This parameter specifies the list of gateways to route packets that are not destined for a subnet that the computer is directly connected to and that do not have a more specific route. This parameter overrides the DhcpDefaultGateway parameter.

- Domain
  - Key: `Tcpip\Parameters`
  - Value type: REG_SZ - Character string
  - Valid range: Any valid DNS domain name
  - Default: None
  - Description: This parameter specifies the DNS domain name of the computer. It is used by the Windows Sockets interface.

- EnableDhcp
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: If this parameter is set to 1 (True), the DHCP client service tries to use DHCP to configure the first IP interface on the adapter.

- Hostname
  - Key: `Tcpip\Parameters`
  - Value type: REG_SZ - Character string
  - Valid range: Any valid DNS hostname
  - Default: The computer name of the computer
  - Description: This parameter specifies the DNS hostname of the computer that will be returned by the hostname command.

- IPAddress
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_MULTI_SZ - List of dotted- decimal IP addresses
  - Valid range: Any set of valid IP addresses
  - Default: None
  - Description: This parameter specifies the IP addresses of the IP interfaces to be bound to the adapter. If the first address in the list is 0.0.0.0, the primary interface on the adapter will be configured from DHCP. A computer with more than one IP interface for an adapter is known as "logically multihomed." There must be a valid subnet mask value in the SubnetMask parameter for each IP address that is specified in this parameter.

- IPEnableRouter
  - Key: `Tcpip\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: Setting this parameter to 1 (True) causes the computer to route IP packets between the networks that it is connected to.

- NameServer
  - Key: `Tcpip\Parameters`
  - Value type: REG_SZ - A space delimited list of dotted decimal IP addresses
  - Valid range: Any set of valid IP address
  - Default: None (Blank)
  - Description: This parameter specifies the DNS name servers to be queried by Windows Sockets to resolve names.

- SearchList
  - Key: `Tcpip\Parameters`
  - Value type: REG_SZ - Delimited list of DNS domain name suffixes
  - Valid range: Any set of valid DNS domain name suffixes
  - Default: None
  - Description: This parameter specifies a list of domain name suffixes to append to a name to be resolved by the DNS if resolution of the unadorned name fails. By default, the value of the Domain parameter is appended only. This parameter is used by the Windows Sockets interface.

- SubnetMask
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`  
  - Value type: REG_MULTI_SZ - List of dotted decimal IP addresses
  - Valid range: Any set of valid IP addresses.
  - Default: None
  - Description: This parameter specifies the subnet masks to be used with the IP interfaces bound to the adapter. If the first mask in the list is 0.0.0.0, the primary interface on the adapter will be configured by DHCP. There must be a valid subnet mask value in this parameter for each IP address that is specified in the IPAddress parameter.

## Non-configurable TCP/IP parameters

The following parameters are created and used internally by the TCP/IP components. They should never be modified by using Registry Editor. They are listed here for reference only.

- DhcpDefaultGateway
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_MULTI_SZ - List of dotted decimal IP addresses
  - Valid range: Any set of valid IP addresses
  - Default: None
  - Description: This parameter specifies the list of default gateways to route packets that are not destined for a subnet that the computer is directly connected to, and that do not have a more specific route. This parameter is written by the DHCP client service, if enabled. This parameter is overridden by a valid DefaultGateway parameter value.

- DhcpIPAddress
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`  
  - Value type: REG_SZ - Dotted decimal IP address
  - Valid range: Any valid IP address
  - Default: None
  - Description: This parameter specifies the DHCP-configured IP address for the interface. If the IPAddress parameter contains a first value other than 0.0.0.0, that value will override this parameter.

- DhcpNameServer
  - Key: `Tcpip\Parameters`
  - Value type: REG_SZ - A space delimited list of dotted decimal IP addresses
  - Valid range: Any set of valid IP address
  - Default: None
  - Description: This parameter specifies the DNS name servers to be queried by Windows Sockets to resolve names. It is written by the DHCP client service, if enabled. The NameServer parameter overrides this parameter.

- DhcpServer
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP address
  - Valid range: Any valid IP address
  - Default: None
  - Description: This parameter specifies the IP address of the DHCP server that granted the lease on the IP address in the DhcpIPAddress parameter.

- DhcpSubnetMask
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP subnet mask
  - Valid range: Any subnet mask that is valid for the configured IP address
  - Default: None
  - Description: This parameter specifies the DHCP-configured subnet mask for the address that is specified in the DhcpIPAddress parameter.

- IPInterfaceContext
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD
  - Valid range: 0 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is written by the TCP/IP driver for use by the DHCP client service.

- Lease
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Time in seconds
  - Valid range: 1 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is used by the DHCP client service to store the time (in seconds) that the lease on the IP address for this adapter is valid for.

- LeaseObtainedTime
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Absolute time in seconds since midnight of 1/1/70
  - Valid range: 1 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is used by the DHCP client service to store the time that the lease on the IP address for this adapter obtained.

- LeaseTerminatesTime
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Absolute time in seconds since midnight of 1/1/70
  - Valid range: 1 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is used by the DHCP client service to store the time that the lease on the IP address for this adapter expires.

- LLInterface
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_SZ - NT device name
  - Valid range: A valid NT device name
  - Default: Empty string (Blank)
  - Description: This parameter is used to direct IP to bind to a different link-layer protocol than the built-in ARP module. The value of the parameter is the name of the Windows NT-based device that IP should bind to. This parameter is used in conjunction with the RAS component, for example.

- T1
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`  
  - Value type: REG_DWORD - Absolute time in seconds since midnight of 1/1/70
  - Valid range: 1 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is used by the DHCP client service to store the time that the service will first try to renew the lease on the IP address for the adapter. To renew the lease, he service contacts the server that granted the lease.

- T2
  - Key: `Tcpip\Parameters\Interfaces\ID for Adapter`
  - Value type: REG_DWORD - Absolute time in seconds since midnight of 1/1/70
  - Valid range: 1 - 0xFFFFFFFF
  - Default: None
  - Description: This parameter is used by the DHCP client service to store the time that the service will try to renew the lease on the IP address for the adapter. To renew the lease, the service broadcasts a renewal request. Time T2 should be reached only if the service was not able to renew the lease with the original server.

All the NBT parameters are registry values that are located under one of two different subkeys of `HKEY_LOCAL_MACHINE\computer\CurrentControlSet\Services`:

- `Netbt\Parameters`
- `Netbt\Parameters\Interfaces\Tcpip_ID for Adapter`

where **ID for Adapter** represents the network adapter that NBT is bound to. The relationship between an Adapter ID and Network Connection can be determined by examining `HKEY_LOCAL_MACHINE\computer\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}\ID for Adapter\Connection`. The Name value in these keys provides the name that is used for a network connection used in the Network Connections folder. Values under the latter keys are specific to each adapter. If the computer is configured through DHCP, a change in parameters takes effect if the command `ipconfig /renew` is issued in a command shell. Otherwise, you must restart the computer for a change in any of these parameters to take effect.

## Standard NBT parameters configurable from Registry Editor

The following parameters are installed with default values by the Network tool in Control Panel during the installation of the TCP/IP components. They may be modified by using Registry Editor (Regedit.exe).

- BcastNameQueryCount
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Count
  - Valid range: 1 to 0xFFFF
  - Default: 3
  - Description: This value determines the number of times NetBT broadcasts a query for a particular name without receiving a response.

- BcastQueryTimeout
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 100 to 0xFFFFFFFF
  - Default: 0x2ee (750 decimal)
  - Description: This value determines the time interval between successive broadcast name queries for the same name.

- CacheTimeout
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 60000 to 0xFFFFFFFF
  - Default: 0x927c0 (600000 milliseconds = 10 minutes)
  - Description: This value determines the time interval that names are cached for in the remote name table.

- NameServerPort
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - UDP port number
  - Valid range: 0 - 0xFFFF
  - Default: 0x89
  - Description: This parameter determines the destination port number that NetBT sends packets to that are related to name service, such as name queries and name registrations to WINS. The Microsoft WINS listens on port 0x89. NetBIOS name servers from other vendors can listen on different ports.

- NameSrvQueryCount
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Count
  - Valid range: 0 - 0xFFFF
  - Default: 3
  - Description: This value determines the number of times NetBT sends a query to a WINS server for a specified name without receiving a response.

- NameSrvQueryTimeout
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 100 - 0xFFFFFFFF
  - Default: 1500 (1.5 seconds)
  - Description: This value determines the time interval between successive name queries to WINS for a particular name.

- SessionKeepAlive
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 60,000 - 0xFFFFFFFF
  - Default: 3,600,000 (1 hour)
  - Description: This value determines the time interval between keepalive transmissions on a session. Setting the value to 0xFFFFFFF disables keepalives.

- Size/Small/Medium/Large
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD
  - Valid range: 1, 2, 3 (Small, Medium, Large)
  - Default: 1 (Small)
  - Description: This value determines the size of the name tables that are used to store local and remote names. Generally, Small is adequate. If the computer is acting as a proxy name server, the value is automatically set to Large to increase the size of the name cache hash table. Hash table buckets are sized as follows: Large: 256 Medium: 128 Small: 16

## Optional NBT parameters configurable from Registry Editor

These parameters generally do not exist in the registry. They may be created to modify the default behavior of the NetBT protocol driver.

- BroadcastAddress
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Four bytes, little- endian encoded IP address
  - Valid range: 0 - 0xFFFFFFFF
  - Default: The ones-broadcast address for each network.
  - Description: This parameter can be used to force NetBT to use a specific address for all broadcast name-related packets. By default, NetBT uses the ones-broadcast address that is appropriate for each net (that is, for a network of 11.101.0.0 with a subnet mask of 255.255.0.0, the subnet broadcast address would be 11.101.255.255). This parameter would be set, for example, if the network uses the zeros-broadcast address (set by using the UseZeroBroadcast TCP/IP parameter). The appropriate subnet broadcast address would then be 11.101.0.0 in the earlier example. This parameter would then be set to 0x0b650000. This parameter is global and is used on all subnets that NetBT is bound to.

- EnableProxy
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: If this value is set to 1 (True), the computer acts as a proxy name server for the networks that NBT is bound to. A proxy name server answers broadcast queries for names that it has resolved through WINS. With a proxy name server, a network of B-node implementations can connect to servers on other subnets that are registered with WINS.

- EnableProxyRegCheck
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: If this parameter is set to 1 (True), the proxy name server sends a negative response to a broadcast name registration if the name is already registered with WINS or is in the proxy's local name cache with a different IP address. The hazard of enabling this feature is that it prevents a computer from changing its IP address as long as WINS has a mapping for the name. Therefore, it is disabled by default.

- InitialRefreshT.O.
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 960000 - 0xFFFFFFF
  - Default: 960000 (16 minutes)
  - Description: This parameter specifies the initial update timeout used by NBT during name registration. NBT tries to contact the WINS servers at 1/8th of this time interval when it is first registering names. When it receives a successful registration response, that response contains the new update interval to use.

- LmhostsTimeout
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 1000 - 0xFFFFFFFF
  - Default: 6000 (6 seconds)
  - Description: This parameter specifies the timeout value for LMHOSTS and DNS name queries. The timer has a granularity of the timeout value. Therefore, the actual timeout might be as much as two times the value.

- MaxDgramBuffering
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Count of bytes
  - Valid range: 0 - 0xFFFFFFFF
  - Default: 0x20000 (128 Kb)
  - Description: This parameter specifies the maximum memory that NetBT dynamically allocates for all outstanding datagram sends. After this limit is reached, additional sends will fail because the available resources are not sufficient resources.

- NodeType
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 1,2,4,8 (B-node, P-node, M-node, H-node)
  - Default: 1 or 8 based on the WINS server configuration
  - Description: This parameter determines what methods NetBT uses to register and resolve names. A B-node computer uses broadcasts. A P-node computer uses only point- to-point name queries to a name server (WINS). An M-node computer broadcasts first, and then queries the name server. An H-node computer queries the name server first, and then broadcasts. Resolution through LMHOSTS or DNS follows these methods. If this key is present, it will override the DhcpNodeType key. If neither key is present, the computer uses B-node if there are no WINS servers configured for the network. The computer uses H-node if there is at least one WINS server configured.

- RandomAdapter
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: This parameter applies to a multihomed host only. If it is set to 1 (True), NetBT will randomly select the IP address to put in a name query response from all its bound interfaces. Frequently, the response contains the address of the interface that the query arrived on. This feature would be used by a server with two interfaces on the same network for load balancing.

- RefreshOpCode
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 8, 9
  - Default: 8
  - Description: This parameter forces NetBT to use a specific opcode in name update packets. The specification for the NetBT protocol is somewhat ambiguous in this area. Although the default of 8 that is used by Microsoft implementations appears to be the intended value, some other implementations, such as those by Ungermann-Bass, use the value 9. Two implementations must use the same opcode to interoperate.

- SingleResponse
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: This parameter applies to a multihomed host only. If this parameter is set to 1 (True), NBT will only supply an IP address from one of its bound interfaces in name query responses. By default, the addresses of all bound interfaces are included.

- WinsDownTimeout
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Time in milliseconds
  - Valid range: 1000 - 0xFFFFFFFF
  - Default: 15,000 (15 seconds)
  - Description: This parameter determines the time that NBT waits before again trying to use WINS after it does not contact any WINS server. With this feature, computers that are temporarily disconnected from the network can proceed through boot processing without waiting to time out each WINS name registration or query individually.

## NBT parameters configurable from the Connection Properties

The following parameters can be set through the Connection Properties from the Network Connections folder. You do not have to configure them directly.

- EnableDns
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 0 (False)
  - Description: If this value is set to 1 (True), NBT queries the DNS for names that cannot be resolved by WINS, broadcast, or the LMHOSTS file.

- EnableLmhosts
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Boolean
  - Valid range: 0 or 1 (False or True)
  - Default: 1 (True)
  - Description: If this value is set to 1 (True), NBT searches the LMHOSTS file, if it exists, for names that cannot be resolved by WINS or broadcast. By default, there is no LMHOSTS file database directory (specified by `Tcpip\Parameters\DatabasePath`). Therefore, NBT takes no action. This value is written by the Advanced TCP/IP configuration under the Network tool in Control Panel.

- NameServer
  - Key: `Netbt\Parameters\Interfaces\Tcpip_ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP address (for example,11.101.1.200)
  - Valid range: Any valid IP address
  - Default: blank (no address)
  - Description: This parameter specifies the IP address of the primary WINS server. If this parameter contains a valid value, it overrides the DHCP parameter of the same name.

- NameServerBackup
  - Key: `Netbt\Parameters\Interfaces\Tcpip_ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP address (for example, 11.101.1.200)
  - Valid range: Any valid IP address.
  - Default: blank (no address)
  - Description: This parameter specifies the IP address of the backup WINS server. If this parameter contains a valid value, it overrides the DHCP parameter of the same name.

- ScopeId
  - Key: `Netbt\Parameters`
  - Value type: REG_SZ - Character string
  - Valid range: Any valid DNS domain name consisting of two dot-separated parts, or a "*".
  - Default: None
  - Description: This parameter specifies the NetBIOS name scope for the node. This value must not start with a period. If this parameter contains a valid value, it will override the DHCP parameter of the same name. A blank value (empty string) will be ignored. Setting this parameter to the value "*" indicates a null scope and will override the DHCP parameter.

## Non-configurable NBT parameters

The following parameters are created and used internally by the NetBT components. They should never be modified by using Registry Editor. They are listed here for reference only.

- DhcpNameServer
  - Key: `Netbt\Parameters\Interfaces\Tcpip_ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP address (for example, 11.101.1.200)
  - Valid range: Any valid IP address
  - Default: None
  - Description: This parameter specifies the IP address of the primary WINS server. It is written by the DHCP client service, if enabled. A valid NameServer value will override this parameter.

- DhcpNameServerBackup
  - Key: `Netbt\Parameters\Interfaces\Tcpip_ID for Adapter`
  - Value type: REG_SZ - Dotted decimal IP address (for example, 11.101.1.200)
  - Valid range: Any valid IP address
  - Default: None
  - Description: This parameter specifies the IP address of the backup WINS server. It is written by the DHCP client service, if enabled. A valid BackupNameServer value will override this parameter.

- DhcpNodeType
  - Key: `Netbt\Parameters`
  - Value type: REG_DWORD - Number
  - Valid range: 1 - 8
  - Default: 1
  - Description: This parameter specifies the NBT node type. It is written by the DHCP client service, if enabled. A valid NodeType value will override this parameter. See the entry for NodeType for a complete description.

- DhcpScopeId
  - Key: `Netbt\Parameters`
  - Value type: REG_SZ - Character string
  - Valid range: a dot-separated name string such as `microsoft.com`
  - Default: None
  - Description: This parameter specifies the NetBIOS name scope for the node. It is written by the DHCP client service, if enabled. This value must not start with a period. See the entry for ScopeId for more information.

- NbProvider
  - Key: `Netbt\Parameters`
  - Value type: REG_SZ - Character string
  - Valid Range: _tcp
  - Default: _tcp
  - Description: This parameter is used internally by the RPC component. The default value should not be changed.

- TransportBindName
  - Key: `Netbt\Parameters`
  - Value type: REG_SZ - Character string
  - Valid range: N/A
  - Default: \\Device\\
  - Description: This parameter is used internally during product development. The default value should not be changed.
