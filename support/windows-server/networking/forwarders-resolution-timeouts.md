---
title: Forwarders resolution timeouts
description: Describes the fallback and timeout behavior that exist when one or more DNS Servers IPs are configured as forwarders or conditional forwarders on a DNS server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, dpracht, kellyv, stegag
ms.custom: sap:dns, csstroubleshoot
---
# NET: DNS: Forwarders and conditional forwarders resolution timeouts

This article describes the fallback and timeout behavior that exist when one or more DNS Servers IPs are configured as forwarders or conditional forwarders on a DNS server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2834250

## Summary

Check [NET: DNS: DNS client resolution timeouts](https://support.microsoft.com/kb/2834226) for more information about DNS client resolution timeouts.

Similarly to DNS clients, configuring DNS servers with more than one Forwarder or Conditional Forwarder adds additional fault tolerance to your DNS infrastructure. Adding multiple DNS Servers as Forwarders or Conditional Forwarders allows DNS names to continue to be resolved in the event of failures of the only configured Server, of the underlying network link or the supporting network infrastructure.

However, adding fault tolerance on Servers is even more critical because there is potentially a transitive operation that some server is doing on behalf of a plurality of clients that are now hanging. Resources are then being consumed for incrementally longer times.

Make sure to correctly tune the parameters if you want to use three or more forwarders/conditional forwarders because the default settings may not be optimized for this high amount of servers.  

## What is the default behavior of a DNS server when more than two DNS servers are configured as forwarders

In order to understand how this works, the key variables are:  

- **RecursionTimeout** - how long the Domain Name System (DNS) waits for remote servers to respond to a recursive client query before terminating the search.

    It's saved in the registry under `HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters\**RecursionTimeout`, and configurable `via dnscmd /config /RecursionTimeout <value>`.

    The default value is:  
  - 15 seconds on Windows Server 2003  
  - 8 seconds on Windows Server 2008, 2008 R2 and 2012

    The **RecursionTimeout** is defined at DNS server level and is independent from the specific zone queried.

- **ForwardingTimeout** - how long the Domain Name System (DNS) waits for each server in the list in Forwarders to respond to a query.

    It's saved in the registry under `HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters\**ForwardingTimeout` and configurable via `dnscmd /config /ForwardingTimeout <value>`.

    The default value is:

  - 5 seconds on Windows Server 2003
  - 3 seconds on Windows Server 2008, 2008R2 and 2012

    The **ForwardingTimeout** is defined at DNS server level and is independent from the specific zone queried.

When the DNS server receives a query for a record in a zone that it is not authoritative for, and needs to use forwarders, the default behavior is the following:

| Time (seconds since start)| Action |
|---|---|
| 0| Client queries the DNS server. DNS server immediately forwards the query to its first forwarder |
| <forwarding_timeout>| After <forwarding_timeout> seconds, if the first forwarder didn't reply, the DNS server queries the second forwarder. |
| 2 * <forwarding_timeout> +1| After <forwarding_timeout> +1 more seconds, if the second forwarder didn't reply, the DNS server queries the third forwarder. |
| ...| ... |
| N * <forwarding_timeout> +(N-1)| After <forwarding_timeout> + 1 more seconds, if the Nth forwarder didn't reply, the DNS server queries the (N+1)th forwarder. |
  
> [!NOTE]
> In addition to the configured delay, there can be an additional half second delay due to system overhead.

### The algorithm stops when the time elapsed has exceeded the RecursionTimeout value
  
If the **RecursionTimeout** expires, the DNS server will reply back to the client with a Server Failure.

> [!NOTE]
> We don't send the Server Failure immediately after the RecursionTimeout expiration, but only when it is time to try the next forwarder.

If the server manages to contact all forwarders before the RecursionTimeout expires without getting answers, it will try to use the root hints for the name resolution (default setting, unless recursion was disabled at the server level).

This means that with default settings, a 2008R2 server will be able to query at most 3 forwarders. There will not be enough time to arrive to use the fourth forwarder. In fact, with default settings on 2008R2 the server will:

- Query the first forwarder after 0 seconds
- Query the second forwarder after 3.5 seconds
- Query the third forwarder after 3.5 + 4 = 7.5 seconds

At the eighth second, **RecursionTimeout** expires so we'll not reach the point where the fourth forwarder is queried (which would have happened after 3.5 + 4 + 4 = 11.5 seconds).

We'll send the Server Failure response then after 11.5 seconds.

Example:

DNS server with IP address 192.168.0.1 is configured with five forwarders (10.0.0.1-10.0.0.5).

Client has IP address 10.0.0.31 and is querying for `Microsoft.com`

On a network capture, we would see the following Network Monitor output (note 10.0.0.4 and 10.0.0.5 never queried):

> Time Time Offset TimeDelta Source Destination Details  
6:33:51.7507293 0.2731738 0.0000000 10.0.0.31 192.168.0.1 DNS:QueryId = 0xF03, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:33:51.7510021 0.2734466 0.0002728 192.168.0.1 10.0.0.1 DNS:QueryId = 0xBD57, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:33:55.2997074 3.8221519 3.5487053 192.168.0.1 10.0.0.2 DNS:QueryId = 0xBD57, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:33:59.2931644 7.8156089 3.9934570 192.168.0.1 10.0.0.3 DNS:QueryId = 0xBD57, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:34:03.3112753 11.8337198 4.0181109 192.168.0.1 10.0.0.31 DNS:QueryId = 0xF03, QUERY (Standard query), Response - Server failure  

## What is the default behavior of a DNS server when more than two DNS servers are configured as conditional forwarders

Similar to forwarders, there are two key variables for Conditional Forwarders. We still have **RecursionTimeout** (which is operating at server level) but in this scenario we are using **ForwarderTimeout** instead of ForwardingTimeout. Specifically note that **ForwarderTimeout** is operating on a zone basis and has different default values:

- **RecursionTimeout** - how long the Domain Name System (DNS) waits for remote servers to respond to a recursive client query before terminating the search.

    It's saved in the registry under `HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters\RecursionTimeout`

    It's configurable via `dnscmd /config /RecursionTimeout <value>`.

    The default value is:
  - 15 seconds on Windows Server 2003
  - 8 seconds on Windows Server 2008 and 2008R2

    The **RecursionTimeout** is defined at DNS server level and is independent from the specific zone queried  

- **ForwarderTimeout** - how long the Domain Name System (DNS) waits for each server in the list of Conditional Forwarders to respond to a query.

    Since Conditional Forwarders are configured for specific zones, the **ForwarderTimeout** is zone-dependent as well.

    It's saved in the registry under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones\ <zone_name>\ForwarderTimeout`.

    The default value is 5 seconds on Windows Server 2003, 2008, 2008R2 and 2012.

    This is also the setting you can see in the Conditional Forwarders GUI.

When the DNS server receives a query for a record in a zone that it is not authoritative for, and is configured to use Conditional Forwarders for it, the default behavior is the following:

| Time (seconds since start)| Action |
|---|---|
| 0| Client queries the DNS server. DNS server immediately forwards the query to its first conditional forwarder |
| <forwarder_timeout>| After <forwarder_timeout> seconds, if the first conditional forwarder didn't reply, the DNS server queries the second conditional forwarder |
| 2 * <forwarder_timeout> +1| After <forwarder_timeout> +1 more seconds, if the second conditional forwarder didn't reply, the DNS server queries the third conditional forwarder |
| ...| ... |
| N * <forwarder_timeout> +(N-1)| After <forwarder_timeout> +1 more seconds, if the Nth conditional forwarder didn't reply, the DNS server queries the (N+1)th conditional forwarder |
  
> [!NOTE]
> In addition to the configured delay there can be an additional half second delay due to system overhead  

### The algorithm stops when time elapsed has exceeded the RecursionTimeout value
  
If the **RecursionTimeout** expires, the DNS server will reply back to the client with a Server Failure.

> [!NOTE]
> We don't send the Server Failure immediately after the **RecursionTimeout** expiration, but only when it is the time to try the next conditional forwarder.

This means that with default settings, a 2008 R2 server will be able to query at most 2 conditional forwarders. There will not be enough time to arrive to use the third conditional forwarder. In fact, with default settings on 2008R2 the server will:

- Query the first forwarder after 0 seconds
- Query the second forwarder after 5.5 seconds

 At the eighth second, **RecursionTimeout** expires so we'll not reach the point where the third conditional forwarder is queried (which would have happened after 5.5 + 6 = 11.5 seconds).

We'll send the Server Failure response then after 11.5 seconds.  

Example:

DNS server with IP address 192.168.0.1 is configured with five conditional forwarders (10.0.0.1-10.0.0.5) for the zone `Microsoft.com`.

Client has IP address 10.0.0.31 and is querying for `Microsoft.com`.

On a network capture we would see the following Network Monitor output (note 10.0.0.3, 10.0.0.4 and 10.0.0.5 never queried):

> Time Time Offset TimeDelta Source Destination Details  
6:50:32.5481816 0.4306857 0.0000000 10.0.0.33 192.168.0.1 DNS:QueryId = 0x245A, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:50:32.5484341 0.4309382 0.0002525 192.168.0.1 10.0.0.1 DNS:QueryId = 0x252B, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:50:38.1695163 6.0520204 5.6210822 192.168.0.1 10.0.0.2 DNS:QueryId = 0x252B, QUERY (Standard query), Query for `microsoft.com` of type Host Addr on class Internet  
6:50:44.1856567 12.0681608 6.0161404 192.168.0.1 10.0.0.33 DNS:QueryId = 0x245A, QUERY (Standard query), Response - Server failure  

## References

- [ForwardingTimeout](/previous-versions/windows/it-pro/windows-2000-server/cc940784(v=technet.10))

- [RecursionTimeout](/previous-versions/windows/it-pro/windows-2000-server/cc940788(v=technet.10))

- [DNS: The recursion timeout must be greater than the forwarding timeout](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff807363(v=ws.10))

- [DNS: The forwarding timeout value should be 2 to 10 seconds](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff807396(v=ws.10))
