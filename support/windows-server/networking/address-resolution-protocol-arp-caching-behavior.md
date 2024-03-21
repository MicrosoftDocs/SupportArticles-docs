---
title: Address Resolution Protocol caching behavior
description: Describes ARP caching behavior in Windows Vista TCP/IP implementations.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, muratka
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Description of Address Resolution Protocol (ARP) caching behavior in TCP/IP implementations

This article provides a description of Address Resolution Protocol (ARP) caching behavior in TCP/IP implementations.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 949589

## Introduction

This article describes the Address Resolution Protocol (ARP) caching behavior in Windows Vista TCP/IP implementations.

## More information

ARP caching behavior has been changed in Windows Vista. The TCP/IP stack implementations in Windows Vista comply with RFC4861 (Neighbor Discovery protocol for IP version 6 [Ipv6]) for both the IPv4 and the IPv6 Neighbor Discovery process.

The ArpCacheLife and ArpCacheMinReferencedLife registry entries determine how the ARP cache is maintained in Windows XP and in Windows Server 2003. These registry entries no longer apply to Windows Vista.

In the new Windows Vista TCP/IP stack implementation, hosts create the neighbor cache entries when there is no matching entry in the neighbor cache. ARP cache entry for IPv4 is an example of a neighbor cache entry. After the entry is successfully created in the neighbor cache, the entry may change to the "Reachable" state if the entry meets certain conditions. If the entry is in the "Reachable" state, Windows Vista TCP/IP hosts do not send ARP requests to the network. Therefore, Windows Vista TCP/IP hosts use the information in the cache. If an entry is not used, and it stays in the "Reachable" state for longer than its "Reachable Time" value, the entry changes to the "Stale" state. If an entry is in the "Stale" state, the Windows Vista TCP/IP host must send an ARP request to reach that destination.

The "Reachable Time" value is calculated as follows:  
Reachable Time = BaseReachable Time × (A random value between MIN_RANDOM_FACTOR and MAX_RANDOM_FACTOR)  
RFC provides the following calculated results.

|BaseReachable Time|30,000 milliseconds (ms)|
|---|---|
|MIN_RANDOM_FACTOR|0.5|
|MAX_RANDOM_FACTOR|1.5|

Therefore, the "Reachable Time" value is somewhere between 15 seconds (30 × 0.5 seconds) and 45 seconds (30 × 1.5 seconds). If an entry is not used for a time between 15 to 45 seconds, it changes to the "Stale" state. Then, the host must send an ARP Request for IPV4 to the network when any IP datagram is sent to that destination.

To see the current "Reachable Time" value, follow these steps:

1. Click **Start**, type *cmd* in the **Start Search** box, and then click **cmd** in the **Programs** list.

2. If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**.
3. At the command prompt, type the following command:  
`netsh interface ipv4 show interfaces`  
 Example result:  

    ```console
    Idx Met MTU        State       Name
    --- --- -----      ----------- -------------------
     1  50  4294967295 connected   Loopback Pseudo-Interface 1
     9  20  1500       connected   Local Area Connection

    ```

4. In step 2, the "Local Area Connection" `Idx` is 9. Therefore, you can show interface 9 by typing the following command at the command prompt:  
`netsh interface ipv4 show interface 9`  
Example result:  

    ```console
    Interface Local Area Connection Parameters
    ----------------------------------------------
    IfLuid                          : ethernet_7
    IfIndex                         : 9
    Compartment Id                  : 1
    State                           : connected
    Metric                          : 20
    Link MTU                        : 1500 bytes
     Reachable Time                 : 19000 ms Base Reachable Time : 30000 ms Retransmission Interval : 1000 ms
    DAD Transmits : 3 Site Prefix Length : 64 Site Id : 1 Forwarding : disabled  
    Advertising : disabled Neighbor Discovery : enabled Neighbor Unreachability  
    Detecion : enabled Router Discovery : dhcp Managed Address Configuration :
    enabled Other Stateful Configuration : enabled Weak Host Sends : disabled Weak  
    Host Receives : disabled Use Automatic Metric : enabled Ignore Default routes :  
    disabled
    ```

5. You can change the "BaseReachable Time" value by typing the following example command at the command prompt:  
`netsh interface ipv4 set interface 9 basereachable=60000`  

6. To see the result of step 4, type the following command at the command prompt:  
`netsh interface ipv4 show interface 9`  
 Example result:  

    ```console
    Interface Local Area Connection Parameters
    ----------------------------------------------
    IfLuid                            : ethernet_7
    IfIndex                           : 9
    Compartment Id                    : 1
    State                             : connected
    Metric                            : 20
    Link MTU                          : 1500 bytes
    Reachable Time                    : 61500 ms
     Base Reachable Time              : 60000 ms Retransmission Interval : 1000 ms DAD Transmits : 3 Site Prefix
    Length : 64 Site Id : 1 Forwarding : disabled Advertising : disabled Neighbor
    Discovery : enabled Neighbor Unreachability Detecion : enabled Router Discovery
    : dhcp Managed Address Configuration : enabled Other Stateful Configuration :
    enabled Weak Host Sends : disabled Weak Host Receives : disabled Use Automatic
    Metric : enabled Ignore Default routes : disabled
    ```

    >[!NOTE]
    >The "Base Reachable Time" value has changed to 60000 ms.  

7. You can increase the neighbor cache limit by typing the following command at the command prompt:  
`netsh interface ipv4 set global neighborcachelimit = 4096`  

    >[!NOTE]
    >The default neighbor cache limit is 256 for client versions of Windows, and is 1024 for Windows Server.  

For more information about the neighbor cache entry states, visit the following Web site:  
[https://www.ietf.org/rfc/rfc2461.txt](http://www.ietf.org/rfc/rfc2461.txt)  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
