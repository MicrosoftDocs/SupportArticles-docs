---
title: DNS records not shown in DNS zones
description: Lists different reasons why DNS records disappear from DNS zones.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Cumulative list of reasons that cause DNS records to disappear from DNS zones

This article lists the causes of the issue where DNS records don't show in a DNS zone.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2985877

## Symptoms

Successfully registered DNS records are no longer present in a DNS zone.

## Cause

Multiple root causes exist, and they're listed in the following table:

|Cause|Issue|Synopsis|
|---|---|---|
|1|DNS Scavenging is misconfigured.|The Scavenging feature on one or more DNS Servers was configured to have overly aggressive settings and is prematurely deleting DNS records for AD-integrated DNS zones.|
|2|DNS zones are CNF or conflict mangled in Active Directory.|The container representing the DNS zone in Active Directory has become CNF or conflict mangled. It was replaced by a different container that may first be empty or contain a subset of the records contained in the previous instance of the zone.|
|3|DnsAvoidRegisterRecord defined in a Group Policy Object (GPO).|A code defect exists if SRV record registration is excluded by using the **DC locator DNS records not registered by the DCs** Group Policy setting. It modifies the DnsAvoidRegisterRecords registry setting under the `hklm\software\policies\microsoft\netlogon\parameters` registry subkey.|
|4|Windows Server 2008 zone transfer deletion bug.|The bug causes records to be deleted from secondary zones on Windows Server 2008 DNS Servers following zone transfer.|
|5|Host "A" record is deleted when the IP address is changed. It occurs in Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2.|A timing bug causes the premature deletion of host "A" records when the DNS Server IP is changed.|
|6|DHCP clients configured with Option 81 deregister host "A" records during host "AAAA" registration.|Windows 7 and Windows Server 2008 R2-based computers which receive DHCP-assigned addresses have Option 81 defined on the DHCP server. They deregister host "A" records during "AAAA" record registration.|
|7|Timing issue caused when you change DNS server IP unless KB2520155 is installed.|A DNS client's DNS Host record is deleted after you change the DNS server IP address on the same client. |
|8|Record registration failures make records vulnerable to the scavenging process.|DNS dynamic update protocol updates for existing records fail. So the records timestamp doesn't update. It makes the record vulnerable to deletion by a correctly configured DNS Scavenging process.|
|9|DNS records are deleted when a given Windows client dynamic lease is changed to a reservation.|DNS records that are currently registered by a DHCP-enabled Windows client are deleted by the DHCP server. The deletion occurs when the client's dynamic lease is transitioned to a reservation, and the following settings are enabled:<ul><li>"Always dynamically update DNS A and PTR records" </li><li>"Discard A and PTR records when lease is deleted"</li><li>"Dynamically update DNS A and PTR records for DHCP clients that don't request update"</li></ul>Affected DNS records include the host "A," host "AAAA," and PTR records.|
  
## Resolution

### Cause 1: DNS scavenging is misconfigured

Scavenging is the most common culprit when DNS records go missing from DNS zones. Even Windows-based computers that have statically assigned servers register their records every 24 hours. Verify that the NoRefresh and Refresh intervals are too low. For example, if these values are both less than 24 hours, then you'll lose DNS records.

TechNet: [Using DNS aging and scavenging](https://technet.microsoft.com/library/cc757041%28ws.10%29.aspx)

### Cause 2: DNS zones are CNF or conflict mangled in Active Directory  

With exceptions, Active Directory allows for any domain controller to originate creating an object in a writable directory partition. When two domain controllers create the same object or container inside a replication window, the directory applies conflict resolution logic to determine:

- which object should remain.
- which object should be quarantined.

When the replication of objects causes a name conflict (two objects have the same name within the same container, or have the same container name), the directory automatically renames one of the objects to have a unique name. Specifically, a "*CNF:\<GUID>" string is appended to the DN path of the created object. And the instance created by the last writer domain controller remains.

If the container representing a DNS zone (or subordinate container) becomes conflict mangled, the container representing a more complete copy of a DNS zone can be replaced by container with the same name that's (at first) less complete or even empty.

Determine which copy of the zone should remain. Delete the **bad** copy of the zone, which may be the one with the non-CNF-mangled DN path. Rename the CNF-mangled copy of the zone as required. Then restart the DNS Server service or reload zones.

### Cause 3: DnsAvoidRegisterRecord defined in a GPO  

Cause 3 is related to a code defect in which SRV records are excluded by using the DnsAvoidRegisterRecords setting in a GPO. The DNS server targeted by a Windows client receives record updates once every five minutes. The timestamp and the version number on dnsRecord constantly increase. SRV records are stored in dnsRecord attribute, which is a non-linked multi-valued attribute. The domain controller, or DNS server that receives the incorrect updates always wins the conflict resolution. Some updates are lost,  while other deleted records mysteriously come back.

SRV record loss associated with a mass restart has the same issue with last-writer wins behavior on the non-linked multivalued attributes. But version churn caused by the GPO isn't going to the source of the registrations. The mass restarts of lots of domain controllers is the cause of the concurrent registrations. Some administrators have worked around this behavior by lowering the SRV registration window.

A good solution to this problem is to configure the DNS client on domain controllers point off-box DNS Servers addresses as primary for name resolution. Designate local hub DNS servers per region and have all the DNS servers in that region point that one DNS server. The hublet DNS servers all point to a single DNS server in a tiered hub-and-spoke model. All DNS servers can point themselves as secondary's but not primaries. Because restarts triggered by Windows Update usually occur at 03:00, as long as there's only one hublet DNS server per time zone, you'll never meet this issue.

Check the Active Directory object version on the dnsNode object that contains the missing record. If it's a large number, it might be your issue. A possibility is to move the exclusion of the SRV records to local policy to stop the constant deregistrations.

However, there's an issue with the new behavior. In the new behavior, the SRV records are removed only once, specifically the first time that the policy is applied. Because the records are non-linked multi-valued attribute, the following condition can occur:

> Multiple domain controllers remove SRV records on different DNS servers before Active Directory coverage of the zone.

When the underlying attribute is fully converged, the last DNS server to receive a deletion is the only version that's kept. Only the records that were removed on that DNS server are removed from the SRV record. The SRV records removed on other DNS servers seem to come back. Manual cleanup may be required after all domain controllers have applied the GPO and the affected SRV records are fully converged.

### Cause 4: Windows Server 2008 zone transfer delete bug  

This issue is resolved by installing Windows Server 2008 Service Pack 2, or [KB953317](https://support.microsoft.com/help/953317). This issue is specific to Windows Server 2008 DNS zones that are hosting secondary copies of DNS zones. It doesn't occur when the Microsoft DNS Server role is installed on computers running other versions of Windows.

### Cause 5: Host "A" record is deleted when the IP address is changed

Assume that you change DNS servers' IP addresses on a TCP/IP network stack on Windows Server 2008 or Windows Server 2008 R2. Then you restart the computer. In this scenario, sometimes the deletion of the host "A" record occurs on the original DNS server after the registration of the host A record on the newly configured DNS server IP address (Active Directory Integrated DNS). From a user perspective, anything that depends on name resolution is broken.

When the DNS server IP is changed on the client, the client sends an SOA update to delete its "A" Record from the old DNS server. And it sends another update to register its "A" Record to the new DNS Server.

This DCR is designed to reduce the number stale host "A" records. Problem occurs in Active Directory-integrated zones.

This issue arises when the DNS Server IP is changed on the client. When it changes, client sends the register request to new server and delete request to old server. As both the servers are already synced up, register won't occur. But deletion happens in the old server, and then it's deleted in both servers because of Active Directory.

### Cause 6: DHCP clients configured with Option 81 de-register host "A" records during host "AAAA" registration  

This problem occurs if Option 81 is defined and ISATAP or 6to4 interfaces are present. DNS dynamic update protocol update incorrectly sets TTL to 0, which triggers record deletion for IPv6 record registration.

### Cause 7: Timing issue caused when you change DNS server IP unless KB2520155 is installed  

This issue occurs because of an issue in the DNS Client service. When the DNS server configuration information is changed on a client, the DNS Client service deletes the DNS host record of the client from the old DNS server. It then adds the record to the new DNS server. The DNS record is present on the new server, which is a part of the same domain. So the record isn't updated. But the old DNS server replicates the deletion operation to the new DNS server and to other DNS servers. So the new DNS server deletes the record, and the record is deleted across the domain.

Install [KB2520155](https://support.microsoft.com/help/2520155) on Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2 computers.

### Cause 8: DNS Dynamic Update Protocol updates to existing records fail causing them to be deleted by the scavenging process as aged records  

Multiple root causes exist for DNS record registration failures.

NETLOGON event 577X events are logged for record registration failures of SRV records by the NETLOGON service.

Other events are logged for registration failures of host A and PTR records. Check System logs for these failures. Such events may be logged by the clients that register these records. Or they may be logged by the DHCP servers that register the records on the clients' behalf.

### Cause 9: Converting an active dynamic lease to a reservation deletes the A and PTR records for that client  

This behavior is by design. The DNS records (A record/PTR) are automatically updated during the next DHCP renew request from the client.

## More information

[KB306602](https://support.microsoft.com/help/306602) How to optimize the location of a domain controller or global catalog that resides outside of a client's site

[KB953317](https://support.microsoft.com/help/953317) A primary DNS zone file may not transfer to the secondary DNS servers in Windows Server 2008
