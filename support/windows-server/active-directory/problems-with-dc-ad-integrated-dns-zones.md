---
title: Problems occur with DCs in AD integrated DNS zones
description: Describes problems that can occur with many Domain Controllers in Active Directory integrated DNS zones.
ms.date: 04/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom:
- sap:active directory\active directory lightweight directory services (ad lds)
- pcy:WinComm Directory Services
---
# Problems that can occur with many Domain Controllers in Active Directory integrated DNS zones

_Original KB number:_ &nbsp; 267855  
_Applies to:_ &nbsp; Supported versions of Windows Server

## Symptoms

Domain Name System (DNS) registrations of SRV and domain controller (DC) locator A records (registered by Netlogon) and NS records (added by the authoritative DNS servers) in an Active Directory-integrated DNS zone for some DCs might not work in a domain that contains a large number of DCs.

For Windows Server 2022 and earlier versions, you can have about 1200 DCs and DNS servers register all DNS records relevant to operate the DNS zones and domains. For Windows Server 2025, you can enable an optional feature that allows about 3200 DCs to register their DNS records. See the [References](#references) section for details.

One or more of the following error messages might be logged in the Event log:

```output
Event Type: Error  
Event Source: DNS  
Event Category: None  
Event ID: 4011  
Description: The DNS server was unable to add or write an update of domain name xyz in zone xyz.example.com to the Active Directory. Check that the Active Directory is functioning properly and add or update this domain name using the DNS console. The event data contains the error.  
Data: 0000: 2a 23 00 00 *#..
```

```output
Event Type: Error  
Event Source: DNS  
Event Category: None  
Event ID: 4015  
Description: The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The event data contains the error.  
Data: 0000: 0b 00 00 00 ....  
```

```output
Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1093  
Description: The directory replication agent (DRA) could not apply changes to object DC=@,DC=xyz.example.com,CN=MicrosoftDNS,CN=System,DC=xyz,DC=example, DC=com (GUID <GUID>) because the incoming changes cause the object to exceed the database's record size limit. The incoming change to attribute 9017e (dnsRecord) will be backed out in an attempt to make the update fit. In addition to the change to the attribute not being applied locally, the current value of the attribute on this system will be sent out to all other systems to make that the definitive version. This has the effect of nullifying the change to the rest of the enterprise.
The reversal may be recognized as follows:
Version:
5474
Time of change:
<DateTime>
Update sequence number:
<USN>
```

```output
Event Type: Information  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1101  
Description: The directory replication agent (DRA) was able to successfully apply the changes to object DC=@,DC=xyz.example.com,CN=MicrosoftDNS,CN=System, DC=xyz,DC=example,DC=com (GUID <GUID>) after backing out one or more of the attribute changes. Preceding messages will indicate which attributes were reversed. Please note that this will have the effect of nullifying the change where it was made, causing the original update not to take effect. The originator should be notified that their change was not accepted by the system.
```

## Cause

In an Active Directory-integrated DNS zone, DNS names are represented by dnsNode objects, and DNS records are stored as values in the multi-valued dnsRecord attribute on dnsNode objects, causing the error messages listed earlier in this article to occur.

This problem occurs because Active Directory has a limitation of approximately 1,200 values that can be associated with a single object in Windows Server 2022 and earlier versions. For Windows Server 2025, this limit can be lifted to about 3,200 values.

## Resolution

You can use the following methods to resolve this issue.

## Experiencing the problem for the NS records of a zone

### Method 1

If your DCs are also DNS servers, they all host the AD-integrated zones and all would add themselves to the NS record for the zone by default. If you exceed the limit for nonlinked attributes, updates to the DNS record AD object will fail.

If you want to reduce the list of DNS servers that can add NS records corresponding to themselves to a specified zone, choose a subset of DNS servers and then run **Dnscmd.exe** with the `/AllowNSRecordsAutoCreation` switch. Consider having DCs in the list that are well-connected in the network and well-monitored. It could be a set of DCs running in your central datacenters.

- To set a list of TCP/IP addresses of DNS servers that have permission to automatically create NS records for a zone, use the `/AllowNSRecordsAutoCreation IPList` command. For example:

    ```console
    Dnscmd NS1 /config zonename.com /AllowNSRecordsAutoCreation 10.1.1.1 10.5.4.2
    ```

- To clear the list of TCP/IP addresses of DNS servers that have permission to automatically create NS records for a zone and return the zone to the default state when every primary DNS server automatically adds to a zone an NS record corresponding to it, use the `/AllowNSRecordsAutoCreation` command. For example:

    ```console
    Dnscmd NS1 /config zonename.com /AllowNSRecordsAutoCreation
    ```

- To query the list of TCP/IP addresses of DNS servers that have permission to automatically create NS records for a zone, use the `/AllowNSRecordsAutoCreation` command. For example:

    ```console
    Dnscmd NS1 /zoneinfo zonename.com /AllowNSRecordsAutoCreation
    ```

> [!NOTE]
> Run this command on only one DNS server. Active Directory replication propagates the changes to all DNS servers that are running on DCs in the same domain.

In an environment in which the majority of the DNS DCs for a domain are located in branch offices and a few are located in a central location, you might want to use the `Dnscmd` command described earlier in this article to set the IPList to include only the centrally located DNS DCs. By doing so, only the centrally located DNS DCs add their respective NS records to the Active Directory domain zone.

### Method 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

Similar to method 1, pick a number of DCs you want to have present with an NS record for the zones they host. For the DNS servers you don't want to add NS records corresponding to themselves to any Active Directory-integrated DNS zone, use Registry Editor (Regedt32.exe) to configure the following registry value on each affected DNS server:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters`

Registry value: DisableNSRecordsAutoCreation  
Data type: REG_DWORD  
Data range: 0x0 | 0x1  
Default value: 0x0

This value affects all Active Directory-integrated DNS zones. The values have the following meanings:

|Value  |Meaning  |
|---------|---------|
|0     |   DNS server automatically creates NS records for all Active Directory-integrated DNS zones unless any zone, that is hosted by the server, contains the AllowNSRecordsAutoCreation attribute (described earlier in this article) that doesn't include the server. In this situation, the server uses the AllowNSRecordsAutoCreation configuration. |
|1     |   DNS server doesn't automatically create NS records for all Active Directory-integrated DNS zones, regardless of the AllowNSRecordsAutoCreation configuration in the Active Directory-integrated DNS zones.  |

> [!NOTE]
> To apply the changes to this value, you must restart the DNS Server service.

## Experiencing the problem for the SRV and A records of a zone owned by DCs

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

Netlogon is managing the registration of a DCs DNS record. To prevent a DC from attempting dynamic updates of certain DNS records that by default are dynamically updated by Netlogon, use Regedt32.exe to configure the following registry value:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

Registry value: DnsAvoidRegisterRecords  
Data type: REG_MULTI_SZ

In this value, specify the list of mnemonics corresponding to the DNS records that shouldn't be registered by this DC.

> [!NOTE]
> Set the value to the list of the enter-delimited mnemonics that are specified in the following table.

The list of mnemonics includes:

|Mnemonic  |Type  |DNS Record  |
|---------|---------|---------|
|LdapIpAddress     |A       |\<DnsDomainName>         |
|Ldap     |SRV         |_ldap._tcp.\<DnsDomainName>         |
|LdapAtSite     |SRV         |_ldap._tcp.\<SiteName>._sites.\<DnsDomainName>         |
|Pdc     |SRV         |_ldap._tcp.pdc._msdcs.\<DnsDomainName>         |
|Gc     |SRV         |_ldap._tcp.gc._msdcs.\<DnsForestName>         |
|GcAtSite     |SRV         |_ldap._tcp.\<SiteName>._sites.gc._msdcs.\<DnsForestName>         |
|DcByGuid     |SRV        |_ldap._tcp.\<DomainGuid>.domains._msdcs.\<DnsForestName>         |
|GcIpAddress     |A         |gc._msdcs.\<DnsForestName>         |
|DsaCname     |CNAME         |\<DsaGuid>._msdcs.\<DnsForestName>         |
|Kdc     |SRV         |_kerberos._tcp.dc._msdcs.\<DnsDomainName>         |
|KdcAtSite     |SRV         |_kerberos._tcp.\<SiteName>._sites.dc._msdcs.\<DnsDomainName>         |
|Dc     |SRV         |_ldap._tcp.dc._msdcs.\<DnsDomainName>         |
|DcAtSite     |SRV         |_ldap._tcp.\<SiteName>._sites.dc._msdcs.\<DnsDomainName>         |
|Rfc1510Kdc     |SRV         |_kerberos._tcp.\<DnsDomainName>         |
|Rfc1510KdcAtSite     |SRV         |_kerberos._tcp.\<SiteName>._sites.\<DnsDomainName>         |
|GenericGc     |SRV         |_gc._tcp.\<DnsForestName>         |
|GenericGcAtSite     |SRV         |_gc._tcp.\<SiteName>._sites.\<DnsForestName>         |
|Rfc1510UdpKdc     |SRV         |_kerberos._udp.\<DnsDomainName>         |
|Rfc1510Kpwd     |SRV         |_kpasswd._tcp.\<DnsDomainName>         |
|Rfc1510UdpKpwd     |SRV         |_kpasswd._udp.\<DnsDomainName>         |

> [!NOTE]
> It isn't necessary to restart the Netlogon service. If the DnsAvoidRegisterRecords registry value is created or modified while the Netlogon service is stopped or within the first 15 minutes after Netlogon is started, appropriate DNS updates take place with a short delay (however, the delay is no later than 15 minutes after Netlogon starts).

You can also set the list of DNS records to suppress using a Group Policy:

GPS: Specify DC Locator DNS records not registered by the DCs

DNS registrations of A records performed by Netlogon can be also be modified by using the RegisterDnsARecords registry value. For more information, see [How to enable or disable DNS updates in Windows](../networking/enable-disable-dns-dynamic-registration.md).

Be aware that both the DnsAvoidRegisterRecords and the RegisterDnsARecords registry values need to allow registering the host (A) record:

- RegisterDnsARecords = 0x1<br>
    If you list LdapIpAddress and GcIpAddress in the DnsAvoidRegisterRecords registry value settings, A records aren't registered.
- RegisterDnsARecords = 0x0<br>
    No matter whether you list LdapIpAddress and GcIpAddress in the DnsAvoidRegisterRecords registry value settings, A records aren't registered.

To prevent the problem described earlier in this article from occurring in an environment in which a set of DCs and/or global catalog (GC) servers are located in a central location and a large number of the DCs and/or GC servers are located in branch offices, the administrator can disable registration of some of the DNS records by Netlogon on the DCs/GCs in the branch offices. In this situation, the list of mnemonics that should not be registered includes:

DC-specific records:

|Mnemonic  |Type  |DNS Record  |
|---------|---------|---------|
|LdapIpAddress     |A         |\<DnsDomainName>         |
|Ldap     |SRV         |_ldap._tcp.\<DnsDomainName>         |
|DcByGuid     |SRV         |_ldap._tcp.\<DomainGuid>.domains._msdcs.\<DnsForestName>         |
|Kdc     |SRV         |_kerberos._tcp.dc._msdcs.\<DnsDomainName>         |
|Dc     |SRV         |_ldap._tcp.dc._msdcs.\<DnsDomainName>         |
|Rfc1510Kdc     |SRV         |_kerberos._tcp.\<DnsDomainName>         |
|Rfc1510UdpKdc     |SRV         |_kerberos._udp.\<DnsDomainName>         |
|Rfc1510Kpwd     |SRV         |_kpasswd._tcp.\<DnsDomainName>         |
|Rfc1510UdpKpwd     |SRV         |_kpasswd._udp.\<DnsDomainName>         |

GC-specific records:

|Mnemonic  |Type  |DNS Record  |
|---------|---------|---------|
|Gc     |SRV         |_ldap._tcp.gc._msdcs.\<DnsForestName>         |
|GcIpAddress     |A         |gc._msdcs.\<DnsForestName>         |
|GenericGc     |SRV         |_gc._tcp.\<DnsForestName>         |

> [!NOTE]
> These lists do not include the site-specific records. Therefore, DCs and GC servers in branch offices are located by site-specific records that are usually used by a DC locator. If a program searches for a DC/GC by using generic (non-site-specific) records such as any of the records in the lists that are listed earlier in this article, it finds a DC/GC in the central location.
>
> Read-Only DCs default to registering DNS records specific to their site.

An administrator might also choose to limit the number of the DC locator records such as SRV and A records registered by Netlogon for the same generic DNS name (_ldap._tcp.dc._msdcs.\<DomainName>), even in a scenario with fewer DCs than the non-linked attribute value limit in the same domain, to reduce the size of DNS responses to queries for such records.

You can create this setting in a Group Policy linked to the Domain Controllers OU, put all branch DCs into an "AD Branch DCs" group and set the Group Policy to apply only to members of the "AD Branch DCs" group.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More Information

Every DNS server that is authoritative for an Active Directory-integrated DNS zone adds an NS record. By default, every DC in a domain registers an SRV record for a set of non-site-specific names such as "_ldap._tcp.\<domain_name>" and A record(s) that map(s) the Active Directory DNS domain name to the TCP/IP address(es) of the DC. When a DNS server tries to write a record with many values for the same shared name, Local Security Authority Subsystem Service (LSASS) runs at 100 percent CPU usage for approximately 10 seconds and the registration doesn't succeed. Netlogon retries this registration every hour; the 100 percent CPU usage spike reappears at least once an hour and the attempted registrations don't succeed.

## References

- [Optimize domain controller location](optimize-dc-location-global-catalog.md)
- [Windows Server 2025 optional feature: What's new in Windows Server 2025](/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services)
