---
title: Optimize domain controller location
description: Explains how to optimize the location of a domain controller or global catalog that resides outside of a client's site. Provides steps for Windows 2000 and Windows Server 2003.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# How to optimize the location of a domain controller or global catalog that resides outside of a client's site

This article provides the steps to optimize the location of a domain controller or global catalog that resides outside of a client's site.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 306602

## Summary

The domain controller locator mechanism in Windows 2000 always prefers a domain controller that resides in the site of the client that is searching for a domain controller. This is achieved by a domain controller that registers site-specific domain controller locator DNS SRV resource records for the site in which the domain controller resides.

Additionally, a domain controller may register site-specific domain controller locator DNS SRV resource records for any other sites that do not contain a domain controller in the same role to which the site of the domain controller is the closest. Such roles include a role that hosts the same domain, or that is a global catalog). This mechanism ensures that clients will locate the nearest domain controller in cases in which no domain controller is located in the client's site.

For more information about this mechanism, refer to the Windows 2000 Server Resource Kit, "Distributed Systems Guide" book, Chapter 3: "Name Resolution in Active Directory."

In a case in which all the domain controllers in the same role (that is, that are hosting the same domain or are being global catalogs) in a particular site become unavailable, clients that are located in the same site will fail over to any other domain controller in any other site without optimization.

## More information

The following information describes the recommended configuration that you should use to optimize the location of the domain controllers or global catalogs when all of the domain controllers/global catalogs that are serving a particular site become unavailable. "Section I" describes the configuration for hub-and-spoke topologies. "Section II" describes the configuration for other topologies.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

### Section I: Hub-and-spoke topology

The recommendations in this section are based upon the following assumption in the hub-and-spoke topology:

It is preferable that if all domain controllers and global catalogs in a satellite site become unavailable, a client that's searching for a domain controller or global catalog in that site fails over to a domain controller or global catalog that's in a central hub and not in another satellite site. This solution is suitable for topologies that have a single hub site or multiple central hubs to accommodate cases in which it's irrelevant to which central site a satellite client fails over.

To achieve this behavior, the domain controllers and global catalogs in the satellite offices should not register generic (non-site-specific) domain controller locator DNS records. These records are registered only by the domain controllers and global catalogs in the central hub. When clients cannot locate the domain controllers and global catalogs that serve their site, they try to locate any domain controllers or global catalogs by using these generic (non-site-specific) domain controller locator DNS records.

The following records should not be registered by the domain controllers or global catalogs in the satellite sites:  

- Windows Server 2003-based domain controllers
- Windows 2000-based domain controllers with Service Pack 2 (SP2) or later installed, or with the hotfix that is specified in Knowledge Base article 267855

### To configure domain controllers or global catalogs not to register generic records

#### Windows 2000

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    Value name: DnsAvoidRegisterRecords  
    Data type: REG_MULTI_SZ  

    Set the value to the list of the enter-delimited mnemonics that are specified in the "Reference tables" section.

4. Exit Registry Editor.

#### Windows Server 2003

To configure Windows Server 2003-based domain controllers, use the "DC locator DNS records not registered by the DCs" Net Logon service group policy. To do this, specify the list of the space-delimited mnemonics that are specified in the "Reference tables" section.

#### Reference tables

The following tables contain mnemonics, types, and owner names of the domain controller locator DNS records that should not be registered by the satellite domain controllers and global catalogs to optimize the domain controller location.

Domain controller-specific records  

|Mnemonic|Type|DNS Record|
|---|---|---|
|LdapIpAddress|A|\<DnsDomainName>|
|Ldap|SRV|_ldap._tcp.\<DnsDomainName>|
|DcByGuid|SRV|_ldap._tcp.\<DomainGuid>.domains._msdcs.\<DnsForestName>|
|Kdc|SRV|_kerberos._tcp.dc._msdcs.\<DnsDomainName>|
|Dc|SRV|_ldap._tcp.dc._msdcs.\<DnsDomainName>|
|Rfc1510Kdc|SRV|_kerberos._tcp.\<DnsDomainName>|
|Rfc1510UdpKdc|SRV|_kerberos._udp.\<DnsDomainName>|
|Rfc1510Kpwd|SRV|_kpasswd._tcp.\<DnsDomainName>|
|Rfc1510UdpKpwd|SRV|_kpasswd._udp.\<DnsDomainName>|

Global catalog-specific records  

|Mnemonic|Type|DNS Record|
|---|---|---|
|Gc|SRV|_ldap._tcp.gc._msdcs.\<DnsForestName>|
|GcIpAddress|A|gc._msdcs.\<DnsForestName>|
|GenericGc|SRV|_gc._tcp.\<DnsForestName>|

For the complete list of the domain controller locator DNS records, see the Windows 2000 Server Resource Kit, "Distributed Systems Guide" book, Chapter 3: "Name Resolution in Active Directory." For the complete list of the domain controller locator DNS records, refer to KB article Q267855 that is referenced in this article.

### Section II: Other topologies

If the failover to the central hubs when local domain controllers and global catalogs become unavailable does not satisfy your requirements, you can use the following configuration.

If the clients (such as servers that run Microsoft Exchange Servers) in site A fail over to the domain controllers and global catalogs in site B, an administrator can configure some or all the domain controllers and global catalogs in site B to register site-specific records for site A when domain controllers and global catalogs in site A become unavailable. To make sure that domain controllers and global catalogs from site B are chosen by the clients in site A only if the domain controllers and global catalogs from site A are not available, the domain controllers and global catalogs in site B that are covering site A should register SRV records that containing lower (higher in absolute value) priority.

> [!NOTE]
> The priority setting is applied to all SRV records that are registered by a domain controller. Therefore, the administrator should be cautious when setting a lower priority to be used by a domain controller because the domain controller will register a lower priority for the site-specific-records, including for its own site.

### To configure a domain controller to register site-specific records for a different site

#### Windows 2000

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    Value name: SiteCoverage  
    Data type: REG_MULTI_SZ  

    Set the value to the list of the space-delimited site names for which the domain controller should register.  

4. Exit Registry Editor.

#### Windows Server 2003

To configure Windows Server 2003-based domain controllers, use the "Sites Covered by the domain controller locator DNS SRV Records" Net Logon service group policy. To do this, specify the list of the space-delimited site names for which the domain controller should register.

### To configure a Global Catalog to register site-specific records for a different site

#### Windows 2000

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    Value name: GcSiteCoverage  
    Data type: REG_MULTI_SZ

    Set the value to the list of the space-delimited site names for which the global catalog should register.

4. Exit Registry Editor.

#### Windows Server 2003

Use the "Sites Covered by the global catalog locator DNS SRV Records" Net Logon service Group Policy by specifying the list of the carriage return-delineated site names for which the global catalog should register.  

### To Configure a domain controller to Register SRV Records with Particular Priority

#### Windows 2000

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    Value name: LdapSrvPriority  
    Data type: REG_DWORD  

    Set the value to the desired value of the priority. Exit

4. Exit Registry Editor.

#### Windows Server 2003

To configure Windows Server 2003-based domain controllers, use the "Priority Set in the domain controller locator DNS SRV Records" Net Logon service Group Policy.
