---
title: Troubleshoot DNS Event ID 4013
description: Solves an issue that the DNS server can't load AD-integrated DNS zones.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nibinpm, arrenc,
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshoot DNS Event ID 4013 (The DNS server was unable to load AD-integrated DNS zones)

This article resolves the event ID 4013 logged in the DNS event log of domain controllers that are hosting the DNS server role after Windows starts.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2001093

## Symptoms

- On a Windows-based computer that's hosting Active Directory domain controllers, the DNS server roles stop responding for 15 to 25 minutes. This issue occurs after the **Preparing network connections** message is displayed, and before the Windows logon prompt (Ctrl+Alt+Del) is displayed.
- The following DNS Event ID 4013 is logged in the DNS event log of domain controllers that are hosting the DNS server role after Windows starts:

  ```output
  Event Type: Warning  
  Event Source: DNS  
  Event Category: None  
  Event ID: 4013  
  Date: Date  
  Time: Time  
  User: N/A  
  Computer: ComputerName  
  Description:  
  The DNS server was unable to open the Active Directory. This DNS server is configured to use directory service information and can not operate without access to the directory. The DNS server will wait for the directory to start. If the DNS server is started but the appropriate event has not been logged, then the DNS server is still waiting for the directory to start.
  
  For more information, see Help and Support Center at https://go.microsoft.com/fwlink/events.asp.  
  Data:  
  0000: <%status code%>
  ```

  In this log entry, values of <%Status code%> may not be logged. Or, they include but aren't limited to the following values:

    |Hex|Byte|Decimal|Symbolic|Error String|
    |---|---|---|---|---|
    | 000025f5| f5 25 00 00| 9717| DNS_ERROR_DS_UNAVAILABLE| The directory service is unavailable |
    | 0000232d| 2d 23 00 00| 9005| DNS_ERROR_RCODE_REFUSED| DNS operation refused. |
    | 0000232a| 2a 23 00 00| 9002| DNS_ERROR_RCODE_SERVER_FAILURE| DNS server failure. |

### Example customer scenarios

- Multiple domain controllers in an Active Directory site that are simultaneously rebooted.
  - A two-domain controller domain is deployed in the same data center.
  - The DNS server role is installed on both domain controllers, and it hosts AD-integrated copies of the _msdcs.\<forest root domain> and Active Directory domain zones.
  - DC1 is configured to use DC2 for preferred DNS and itself for alternate DNS.
  - DC2 is configured to use DC1 for preferred DNS and itself for alternate DNS.
  - All domain controllers have uninterruptible power supplies (UPS) and electrical generator backups.
  - The data center experiences frequent power outages of 2 to 10 hours. UPS devices keep the domain controllers operating until generators supply power, but they can't run the HVAC system. Temperature protection built into server class computers shuts down the domain controllers when internal temperatures reach manufacturer limits.
  - When power is eventually restored, the domain controllers hang for 20 minutes. This issue occurs after **Preparing network connections** is displayed, and before the logon prompt is displayed.
  - DNS Event ID 4013 is logged in the DNS event log.

   Opening the DNS management console (DNSMGMT.MSC) fails and generates the following error message:

   > The server \<computername> could not be contacted. The error was: The server is unavailable. Would you like to add it anyway?

  Opening the Active Directory Users and Computers snap-in (DSA.MSC) generates the following error message:

  > Naming information could not be located

- Single domain controllers in an Active Directory site
  - One domain controller is deployed in a site.
  - The DNS Server role is installed, and it hosts AD-integrated copies of the _msdcs.\<forest root domain> and Active Directory domain zones.
  - The domain controller points to itself for preferred DNS.
  - The domain controller has no alternative DNS server specified or points to a domain controller over a wide-area network (WAN) link.
  - The domain controller is restarted because of a power outage.
  - During restart, the WAN link may not be operational.
  - When the domain controller is started, it may hang for 20 minutes. This issue occurs after **Preparing network connections** is displayed, and before the logon prompt is displayed.
  - DNS Event ID 4013 is logged in the DNS event log.
  - Opening the DNS management console (DNSMGMT.MSC) fails and generates the following error message:

    > The server \<computername> could not be contacted. The error was: The server is unavailable. Would you like to add it anyway?

  Opening the Active Directory Users and Computers snap-in (DSA.MSC) generates the following error message:

  > Naming information could not be located.

## Cause

The copy of Active Directory in some domain controllers contains references to other domain controllers in the forest. These domain controllers try to inbound replicate all locally held directory partitions during Windows startup, as part of an initial synchronization or **init sync**.

In an attempt to boot with the latest DNS zone contents, Microsoft DNS servers that host AD-integrated copies of DNS zones delay DNS service startup for several minutes after Windows startup. The delay won't occur if Active Directory has completed its initial synchronization during Windows startup. Meanwhile, Active Directory is delayed from inbound replicating directory partitions. Replication is delayed until it can resolve the CNAME GUID of its source domain controller to an IP address on the DNS servers used by the destination domain controller for name resolution. The duration of the hang while preparing network connections depends on the number of locally held directory partitions residing in a domain controller's copy of Active Directory. Most domain controllers have at least the following five partitions:

- schema
- configuration
- domain
- forest-wide DNS application partition
- domain-wide DNS application partition

And these domain controllers can experience a 15-20 minute startup delay. The existence of extra partitions increases the startup delay.

DNS Event ID 4013 in the DNS event log indicates that DNS service startup was delayed. It's because inbound replication of Active Directory partitions hadn't occurred.

Multiple conditions can exacerbate the following issues:

- slow Windows startup
- the logging of DNS event 4013 on DNS servers that are configured to host AD-integrated zones, which implicitly reside on computers acting as domain controllers.

These conditions include:

- Configuring a DNS server hosting AD-integrated DNS zones. Its copy of Active Directory contains knowledge of other domain controllers in the forest to point to itself exclusively for DNS name resolution.
- Configuring a DNS server hosting AD-integrated DNS zones. Its copy of Active Directory contains knowledge of other domain controllers in the forest to point DNS servers that either don't exist, are currently offline, aren't accessible on the network, or that don't host the required zones and records that are needed to inbound-replicate Active Directory. Examples include the domain controller CNAME GUID record and its corresponding host A or AAAA record of potential source domain controllers.
- Booting a domain controller and DNS server hosting AD-integrated DNS zones. Its copy of Active Directory contains knowledge of other domain controllers on what is effectively an isolated network because:
  - The network adapter or network stack on the caller or target computer is either disabled or non-functional.
  - The domain controller has been booted on an isolated network.
  - The local domain controller's copy of Active Directory contains references to stale domain controllers that no longer exist on the network.
  - The local domain controller's copy of Active Directory contains references to other domain controllers who are currently turned off.
  - There's a problem on either the source domain controller, the destination domain controller, or the DNS or network infrastructure. So the local domain controller's copy of Active Directory contains references to other domain controllers that are online and accessible but can't be successfully replicated from.

In Windows Server 2003 and Windows 2000 Server SP3 or later, the domain controllers that host operations master roles must also successfully replicate inbound changes on the directory partition that maintains the operations master role's state. Successful replication must occur before FSMO-dependent operations can be performed. Such initial synchronizations were added to ensure domain controllers were in agreement about FSMO role ownership and role state. The initial sync requirements required for FSMO roles to become operational is different from the initial sync discussed in this article, where Active Directory must inbound replicate to start the DNS Server service immediately.

## Resolution

Some Microsoft and external content have recommended setting the registry value `Repl Perform Initial Synchronizations` to **0** to bypass initial synchronization requirements in Active Directory. The specific registry subkey and the values for that setting are as follows:

> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters  
Value name:  Repl Perform Initial Synchronizations  
Value type:  REG_DWORD  
Value data: 0

This configuration change isn't recommended for use in production environments, or in any environment on an ongoing basis. The use of `Repl Perform Initial Synchronizations` should be used only in critical situations to resolve temporary and specific problems. The default setting should be restored after such problems are resolved.

Other feasible options include:

- Remove references to stale domain controllers.
- Make offline or non-functioning domain controllers operational.
- Domain controllers hosting AD-integrated DNS zones shouldn't point to a single domain controller and especially only to themselves as preferred DNS for name resolution.

  DNS name registration and name resolution for domain controllers is a relatively lightweight operation that's highly cached by DNS clients and servers.

  Configuring domain controllers to point to a single DNS server's IP address, including the 127.0.0.1 loopback address, represents a single point of failure. This setting is tolerable in a forest with only one domain controller, but not in forests with multiple domain controllers.

  Hub-site domain controllers should point to DNS servers in the same site as them for preferred and alternate DNS server and then finally to itself as another alternate DNS server.

  Branch site domain controllers should configure the preferred DNS server IP address to point to a hub-site DNS server, the alternate DNS server IP address to point to an in-site DNS server or one in the closest available site, and finally to itself using the 127.0.0.1 loopback address or current static IP address.

  Pointing to hub-site DNS servers reduces the number of hops required to get critical domain controller SRV and HOST records fully registered. Domain controllers within the hub site tend to get the most administrative attention, typically have the largest collection of domain controllers in the same site. Because they're in the same site, replicate changes between each other occur:
  - every 15 seconds in Windows Server 2003 or later
  - every five minutes in Windows 2000 Server
  
  This behavior makes such DNS records **well known**.

  Dynamic domain controller SRV and host A and AAAA record registrations may not make it off-box if the registering domain controller in a branch site is unable to outbound replicate.

  Member computers and servers should continue to point to site-optimal DNS servers as preferred DNS. And they may point to off-site DNS servers for additional fault tolerance.

  Your ultimate goal is to prevent everything from causing a denial of service while balancing costs, risks, and network utilization, such as:

  - replication latency and replication failures
  - hardware failures, software failures
  - operational practices
  - short and long-term power outages
  - fire, theft, flood, and earthquakes
  - terrorist events

- Make sure that destination domain controllers can resolve source domain controllers using DNS (for example, avoid fallback).

  You should ensure that domain controllers can successfully resolve the guided CNAME records to host records of current and potential source domain controllers. Doing so can avoid high latency that's introduced by name resolution fallback logic.

  Domain controllers should point to DNS servers that:

  - Are available at Windows startup.
  - Host, forward, or delegate the _msdcs.\<forest root domain> and primary DNS suffix zones for current and potential source domain controllers.
  - Can resolve the current CNAME GUID records (for example, `dded5a29-fc25-4fd8-aa98-7f472fc6f09b._msdcs.contoso.com`) and host records of current and potential source domain controllers.

  Missing, duplicate, or stale CNAME and host records all contribute to this problem. Scavenging isn't enabled on Microsoft DNS servers by default, increasing the probability of stale host records. At the same time, DNS scavenging can be configured too aggressively, causing valid records to be prematurely purged from DNS zones.

- Optimize domain controllers for name resolution fallback.

  The inability to configure DNS properly so that domain controllers could resolve the domain controller CNAME GUID records to host records in DNS was common. To ensure end-to-end replication of Active Directory partitions, Windows Server 2003 SP1 and later domain controllers were modified to perform name resolution fallback:

  - from domain controller CNAME GUID to fully qualified hostname.
  - from fully qualified hostname to NetBIOS computer name.

  The NTDS replication Event IDs 2087 and 2088 in the Directory Service event logs indicate that:
  - a destination domain controller couldn't resolve the domain controller CNAME GUID record to a host record.
  - name resolution fallback is occurring.

  WINS, HOST files, and LMHOST files can all be configured. So destination domain controllers can resolve the names of current and potential source domain controllers. Of the three solutions, the use of WINS is more scalable, because WINS supports dynamic updates.

  The IP addresses and names for computers inevitably become stale. This issue causes static entries in HOST and LMHOST files to become invalid over time. When this issue occurs, queries for one domain controller may be incorrectly resolved to another domain controller. And no name query is observed in a network trace.

- Change the startup value for the DNS server service to manual if booting into a known bad configuration.

  If booting a domain controller in a known bad configuration that's discussed in this article, follow these steps:
    1. Set the DNS Server service startup value to manual.
    2. Reboot, wait for the domain controller to advertise.
    3. Restart the DNS Server service.

  If the service startup value for DNS Server service is set to manual, Active Directory doesn't wait for the DNS Server service to start.

### Additional considerations

- Avoid single points of failure.

  Examples of single points of failure include:

  - Configuring a DC to point to a single-DNS Server IP
  - Placing all DNS servers on guest virtual machines on the same physical host computer
  - Placing all DNS servers in the same physical site
  - Limiting network connectivity such that destination domain controllers have only a single network path to access a KDC or DNS Server

  Install enough DNS servers for local, regional, and enterprise-wide redundancy performance but not so many that management becomes a burden. DNS is typically a lightweight operation that is highly cached by DNS clients and DNS servers.

  Each Microsoft DNS server running on modern hardware can satisfy 10,000-20,000 clients per server. Installing the DNS role on every domain controller can lead to an excessive number of DNS servers in your enterprise. And doing so will increase cost.

- Stagger the reboots of DNS servers in your enterprise when possible.

  - The installation of some hotfixes, service packs, and applications may require a reboot.
  - Some customers reboot domain controllers on a scheduled basis (every seven days, every 30 days).
  - Schedule reboots, and the installation of software that requires a reboot, in a smart way. Doing so to prevent the only DNS server, or potential source replication partner that a destination domain controller points to for name resolution, from being rebooted at the same time.

  If Windows Update or management software is installing software that requires reboot, stagger the installs on targeted domain controllers so that half the available DNS servers that domain controllers point to for name resolution reboot at the same time.

- Install UPS devices in strategic places to ensure DNS availability during short-term power outages.
- Augment your UPS-backed DNS servers with on-site generators.

  To deal with extended outages, some customers have deployed on-site electrical generators to keep key servers online. Some customers have found that generators can power servers in the data center but not the on-site HVAC. The lack of air conditioning may cause local servers to shut down when internal computer temperatures reach a certain threshold.

## More information

May 10, 2010 testing by the Active Directory development team:

DNS waits for NTDS and it can't start until the initial replication of the directory has been completed. It's because up-to-date DNS data might not be replicated onto the domain controller yet. On the other hand, NTDS needs DNS to resolve the IP address of the source domain controller for the replication. Assume that DC1 points to DC2 as its DNS server, and DC2 points to DC1 as its DNS server. When both DC1 and DC2 reboot simultaneously, there will be a slow startup because of this mutual dependency. The root cause of this slow startup is DNSQueryTimeouts.

If the DNS Server service runs well when NTDS starts, NTDS takes only two DNS queries to resolve the IP address of the source domain controller:

- one for IPv4
- the other for IPv6

And these DNS queries return almost instantaneously.

If the DNS Server service isn't available when NTDS starts, NTDS will need to send out 10 DNS queries to resolve the IP address:

- four for GUID-based name
- four for fully qualified name
- two for single-label name

Latency for each DNS query is controlled by DNSQueryTimeouts. By default, DNSQueryTimeouts is set to **1 1 2 4 4**. It means that DNS client will wait 12 (1 + 1 + 2 + 4 + 4) seconds for the DNS server response. Each naming context source takes 120 seconds to resolve the IP address. Assume that there are five naming contexts (Configuration, Schema, domain, ForestDnsZones, DomainDnsZones), and one single replication source. In this scenario, it will take 850 (170 X 5) seconds, or greater than 14 minutes, for NTDS to finish initial replication.

Several tests were done to validate the above behavior.

- Reboot domain controller when DNS server is a third domain controller that is online. For each naming context each source, we have two DNS queries and they finished almost instantaneously:

    ```output
    in I_DRSGetNCChanges, NC = CN=Configuration,DC=contoso,DC=com
    in getContextBindingHelper, pszAddress = dded5a29-fc25-4fd8-aa98-7f472fc6f09b._msdcs.contoso.com  
    in resolveDnsAddressWithFallback  
    GUID based DNS name  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:31:40.534  
    end   GetAddrInfoW: 22:31:40.534  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:31:40.534  
    end   GetAddrInfoW: 22:31:40.534
    ```

- Reboot DC1 and DC2 simultaneously. DC1 is using DC2 for DNS DC2 is using DC1 for DNS. For each naming context each source, we have 10 DNS queries and each query takes about 12 seconds:

    ```output
    in I_DRSGetNCChanges, NC = CN=Configuration,DC=contoso,DC=com  
    in getContextBindingHelper, pszAddress = dded5a29-fc25-4fd8-aa98-7f472fc6f09b._msdcs.contoso.microsoft.com  
    in resolveDnsAddressWithFallback  
    GUID based DNS name  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:37:43.066  
    end   GetAddrInfoW: 22:37:55.113  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:37:55.113  
    end   GetAddrInfoW: 22:38:07.131  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:38:07.131  
    end   GetAddrInfoW: 22:38:19.161  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:38:19.176  
     end   GetAddrInfoW: 22:38:31.185  
    FQDN  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:38:31.200  
    end   GetAddrInfoW: 22:38:43.182  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:38:43.182  
    end   GetAddrInfoW: 22:38:55.191  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:38:55.191  
    end   GetAddrInfoW: 22:39:07.216  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:39:07.216  
    end   GetAddrInfoW: 22:39:19.286  
    NetBios  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:39:19.286  
    end   GetAddrInfoW: 22:39:31.308d  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 22:39:31.308  
    end   GetAddrInfoW: 22:39:43.324
    ```

- To further study the relationship between DNSQueryTimeouts and the slow startup, DNSQueryTimeouts were set to **1 1 2 4 4** to make DNS client wait for 31 (1 + 1 + 2 + 4 + 4) seconds. In this test, 31 seconds were spent waiting:

    ```output
    in I_DRSGetNCChanges, NC = CN=Configuration,DC=contoso,DC=com  
    in getContextBindingHelper, pszAddress = dded5a29-fc25-4fd8-aa98-7f472fc6f09b._msdcs.contoso.com  
    in resolveDnsAddressWithFallback  
    GUID based DNS name  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:06:48.143  
    end   GetAddrInfoW: 18:07:19.158  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:07:19.158  
    end   GetAddrInfoW: 18:07:50.162  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:07:50.162  
    end   GetAddrInfoW: 18:08:21.161  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:08:21.161  
    end   GetAddrInfoW: 18:08:52.158  
    FQDN  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:08:52.221  
    end   GetAddrInfoW: 18:09:23.231  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:09:23.231  
    end   GetAddrInfoW: 18:09:54.243  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:09:54.243  
    end   GetAddrInfoW: 18:10:25.239  
     in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:10:25.239  
    end   GetAddrInfoW: 18:10:56.243  
    NetBios  
    in GetIpVxAddrByDnsNameW  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:10:56.243  
    end   GetAddrInfoW: 18:11:27.244  
    in GetIpAddrByDnsNameHelper  
    start GetAddrInfoW: 18:11:27.244  
    end   GetAddrInfoW: 18:11:58.265
    ```
