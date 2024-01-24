---
title: DNS client resolution timeouts
description: Describes the fallback and timeout behavior that exist when one or more Domain Name System (DNS) Servers IPs are configured on a Windows DNS client.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, arrenc, dpracht
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
---
# NET: DNS: DNS client resolution timeouts

This document describes the fallback and timeout behavior that exist when one or more Domain Name System (DNS) Servers IPs are configured on a Windows DNS client.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2834226

## Summary

For more information, see [NET: DNS: Forwarders and Conditional Forwarders resolution timeouts](https://support.microsoft.com/kb/2834250).

Configuring DNS clients with more than one DNS Server IP adds additional fault tolerance to your DNS infrastructure. Adding multiple DNS Servers IPs allows DNS names to continue to be resolved if failures of the only configured DNS Server, of the underlying network link, or the supporting network infrastructure that connects a given client to a DNS Server. Such name failures may cause application or component hangs, resource outages waiting for dependent timeout expirations that directly or indirectly cause operational failures.

For these reasons, it's recommended to configure any Windows client with more than one DNS server, but it's important to be aware of the Windows client resolution process, as it's different based on how many DNS servers we've configured.

## What is the default behavior of a DNS client when a single DNS server is configured on the NIC

The behavior is the following (tested on Windows XP, Windows 7, and Windows 8 clients with a single NIC):  

|Time (seconds since start)|Action|
|---|---|
| 0| Client queries the DNS server |
| 1| If no response is received after 1 second, client queries again the DNS server |
| 2| If no response is received after 1 more second, client queries again the DNS server |
| 4| If no response is received after 2 more seconds, client queries again the DNS server |
| 8| If no response is received after 4 more seconds, client queries again the DNS server |
| 10| If no response is received after 2 more seconds, client stops querying |
  
Any Name Error response by the DNS server will cause the process to stop - client doesn't retry if the response was negative.

In this scenario, the client is then trying to query the same DNS server five times before timing out.

Example

Windows 8 Client with a single DNS server configured, querying for Microsoft.com

Ipconfig on the client

> IPv4 Address. . . . . . . . . . . : 10.0.0.31(Preferred)  
DNS Servers . . . . . . . . . . . :  10.0.0.1

Network Monitor output

> Time                      Time Offset    TimeDelta      Source        Dest          Details  
>
> 6:23:33.8063812     0.0000000     0.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0xA5B4, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:23:34.8026943     0.9963131     0.9963131     10.0.0.31     10.0.0.1     DNS:QueryId = 0xA5B4, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:23:35.8042696     1.9978884     1.0015753     10.0.0.31     10.0.0.1     DNS:QueryId = 0xA5B4, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:23:37.8184257     4.0120445     2.0141561     10.0.0.31     10.0.0.1     DNS:QueryId = 0xA5B4, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:23:41.8394589     8.0330777     4.0210332     10.0.0.31     10.0.0.1     DNS:QueryId = 0xA5B4, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet

## What is the default behavior of a Windows XP DNS client when two DNS servers are configured on the NIC

The behavior is the following (tested on Windows XP clients with a single NIC):

|Time (seconds since start)| Action|
|---|---|
|0| Client queries the first DNS server of the list |
|1| If no response is received after 1 second, client queries the second DNS server of the list and at the same time queries again the first DNS server |
|3| If no response is received after 2 more seconds, client queries again the first DNS server |
|7| If no response is received after 4 more seconds, client queries again the first DNS server |
|9| If no response is received after 2 more seconds, client stops querying |
  
Any Name Error response by any of the DNS servers will cause the process to stop - client doesn't retry with the next server if the response was negative. Client tries new servers only if the previous are unreachable.

In this scenario, the client is then trying to query mostly the first DNS server, and the secondary once.

Example

Windows XP Client with two DNS servers configured querying for Microsoft.com

Ipconfig on the client

```console
IPv4 Address. . . . . . . . . . . : 10.0.0.31(Preferred)  
DNS Servers . . . . . . . . . . . : 10.0.0.1  
                                10.0.0.2
```

Network Monitor output

> Time                      Time Offset    TimeDelta      Source        Dest          Details
>
> 6:39:09.8013750     0.0000000     0.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0x1960, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:39:10.8013750     1.0000000     1.0000000     10.0.0.31     10.0.0.2     DNS:QueryId = 0x1960, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:39:10.8013750     1.0000000     0.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0x1960, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:39:12.8013750     3.0000000     2.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0x1960, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:39:16.8013750     7.0000000     4.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0x1960, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet  

## What is the default behavior of a Windows 7 or Windows 8 DNS client when two DNS servers are configured on the NIC

The behavior is the following (tested on Windows 7 and Windows 8 clients with a single NIC):

| Time (seconds since start)| Action |
|---|---|
| 0| Client queries the first DNS server of the list |
| 1| If no response is received after 1 second, client queries the second DNS server of the list |
| 2| If no response is received after 1 more second, client queries again the second DNS server of the list |
| 4| If no response is received after 2 more seconds, client queries all the servers in the list at the same time |
| 8| If no response is received after 4 more seconds, client queries all the servers in the list at the same time |
| 10| If no response is received after 2 more seconds, client stops querying |
  
Any Name Error response by any of the DNS servers will cause the process to stop - client doesn't retry with the next server if the response was negative. Client tries new servers only if the previous are unreachable.

Example

Windows 8 Client with two DNS servers configured querying for Microsoft.com

Ipconfig on the client

```console
IPv4 Address. . . . . . . . . . . : 10.0.0.31(Preferred)
DNS Servers . . . . . . . . . . . : 10.0.0.1
                                10.0.0.2  
```

Network Monitor output

> Time                      Time Offset    TimeDelta      Source        Dest          Details
>
>6:28:12.5060330     0.0000000     0.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:13.5129164     1.0068834     1.0068834     10.0.0.31     10.0.0.2     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:14.5124283     2.0063953     0.9995119     10.0.0.31     10.0.0.2     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:16.5288823     4.0228493     2.0164540     10.0.0.31     10.0.0.1     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:16.5289050     4.0228720     0.0000227     10.0.0.31     10.0.0.2     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:20.5582196     8.0521866     4.0293146     10.0.0.31     10.0.0.1     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 6:28:20.5582475     8.0522145     0.0000279     10.0.0.31     10.0.0.2     DNS:QueryId = 0x7B1C, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet  

## What is the default behavior of a DNS client when three or more DNS servers are configured on the NIC

How many of them are used and what are the timeouts?

The behavior is the following (tested on Windows XP, Windows 7, and Windows 8 clients with a single NIC):

| Time (seconds since start)| Action |
|---|---|
| 0| Client queries the first DNS server of the list |
| 1| If no response is received after 1 second, client queries the second DNS server of the list |
| 2| If no response is received after 1 more second, client queries the third DNS server of the list |
| 4| If no response is received after 2 more seconds, client queries all the servers in the list at the same time |
| 8| If no response is received after 4 more seconds, client queries again all the servers in the list at the same time |
| 10| If no response is received after 2 more seconds, client stops querying |
  
Any Name Error response by any of the DNS servers will cause the process to stop - client doesn't retry with the next server if the response was negative. Client tries new servers only if the previous are unreachable.

If the only reachable server is in position 4 or higher, we have an expected delay of at least 4 seconds after the original query before actually trying it. This can cause issues if the application that has requested the DNS resolution has an application resolution timeout lower than this value. The only way to have this server queried earlier will be to set it in the first three positions.

Example

Client with five DNS servers configured querying for Microsoft.com

Ipconfig on the client

```console
Pv4 Address. . . . . . . . . . . : 10.0.0.31(Preferred)
DNS Servers . . . . . . . . . . . : 10.0.0.1
                                10.0.0.2
                                10.0.0.3
                                10.0.0.4
                                10.0.0.5
```

Network Monitor output

> Time                      Time Offset    TimeDelta      Source        Dest          Details
>
> 9:50:19.4165728     0.0000000     0.0000000     10.0.0.31     10.0.0.1     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:20.4030068     0.9864340     0.9864340     10.0.0.31     10.0.0.2     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:21.4053190     1.9887462     1.0023122     10.0.0.31     10.0.0.3     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:23.4022371     3.9856643     1.9969181     10.0.0.31     10.0.0.1     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:23.4022575     3.9856847     0.0000204     10.0.0.31     10.0.0.2     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:23.4022646     3.9856918     0.0000071     10.0.0.31     10.0.0.3     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:23.4023130     3.9857402     0.0000484     10.0.0.31     10.0.0.4     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:23.4023347     3.9857619     0.0000217     10.0.0.31     10.0.0.5     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:27.4113578     7.9947850     4.0090231     10.0.0.31     10.0.0.1     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:27.4113788     7.9948060     0.0000210     10.0.0.31     10.0.0.2     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:27.4113860     7.9948132     0.0000072     10.0.0.31     10.0.0.3     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:27.4113932     7.9948204     0.0000072     10.0.0.31     10.0.0.4     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet
>
> 9:50:27.4114034     7.9948306     0.0000102     10.0.0.31     10.0.0.5     DNS:QueryId = 0xE2A2, QUERY (Standard query), Query  for microsoft.com of type Host Addr on class Internet  

## More information

Shall the client have more than one NIC active with different DNS servers configured on them, the client resolution behavior is slightly different.
