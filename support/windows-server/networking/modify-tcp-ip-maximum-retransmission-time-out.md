---
title: Modify the TCP/IP Maximum Retransmission Time-out
description: Provides information about how to modify the TCP/IP maximum retransmission time-out.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# How to modify the TCP/IP maximum retransmission time-out

## Summary

TCP starts a retransmission timer when each outbound segment is handed down to IP. If no acknowledgment has been received for the data in a given segment before the timer expires, the segment is retransmitted, up to the `TcpMaxDataRetransmissions` value. The default value for this parameter is `5`.

The retransmission timer is initialized to three seconds when a TCP connection is established. However, it's adjusted on the fly to match the characteristics of the connection by using Smoothed Round Trip Time (SRTT) calculations as described in RFC793. The timer for a given segment is doubled after each retransmission of that segment. By using this algorithm, TCP tunes itself to the normal delay of a connection. TCP connections that are made over high-delay links take longer to time out than those that are made over low-delay links.

By default, after the retransmission timer hits 240 seconds, it uses that value for retransmission of any segment that has to be retransmitted. This can cause long delays for a client to time-out on a slow link.

## More information

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

The `TcpMaxDataRetransmissions` registry value controls the number of times that TCP retransmits an individual data segment before it aborts the connection. This value isn't configured by default, but it can be entered to change the default number of retries.

Change the following subkey in Windows:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`

Value Name: `TcpMaxDataRetransmissions`  
Data Type: `REG_DWORD - Number`  
Valid Range: `0 - 0xFFFFFFFF`  
Default: `5`

Description: This parameter controls the number of times TCP retransmits an individual data segment (non connect segment) before aborting the connection. The retransmission time-out is doubled with each successive retransmission on a connection. It's reset when responses resume. The base time-out value is dynamically determined by the measured round-trip time on the connection.

Windows provides a mechanism to control the initial retransmit time, and the retransmit time is then dynamically self-tuned. To change the initial retransmit time, modify the following registry values.

Change the following subkey in Windows:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\ID for Adapter`

Value Name: `TCPInitialRtt`  
Data Type: `REG_DWORD`  
Valid Range: `300-65535` (milliseconds in decimal)  
Default: `0xBB8` (3,000 milliseconds expressed in hexadecimal)

Description: This parameter controls the initial retransmission time-out that is used by TCP on each new connection. It applies to the connection request (SYN) and to the first data segments that is sent on each connection. For example, the value data of "5000 decimal" sets the initial retransmit time to five seconds.

> [!NOTE]
> You can increase the value only for the initial time-out. Decreasing the value isn't supported.

Change the following key in Windows:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`

Value Name: `InitialRttData`  
Type: `REG_DWORD`  
Valid Range: `0-65535` (decimal)  
Default: `0xBB8` (3000 decimal)

Description: This parameter controls the initial retransmission time-out used by TCP on each new connection. It applies to the connection request (SYN) and to the first data segment(s) sent on each connection.

For example, the value data of "5000 decimal" sets the initial retransmit time to five seconds.

The Initial RTO in Windows can be controlled by using the `netsh` command by initialRTO.

For prerequisites and more information, see [You can't customize some TCP configurations by using the netsh command in Windows Server 2008 R2](https://support.microsoft.com/topic/you-cannot-customize-some-tcp-configurations-by-using-the-netsh-command-in-windows-server-2008-r2-c1feebea-82a8-cb05-83c7-46ffb5fd9cec).

For more information, search the web for "RFC 793 (Section 3.7) TCP Protocol Specification."
