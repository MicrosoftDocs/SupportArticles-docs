---
title: Deployment and operation of AD domains
description: This article provides information about the deployment and operation of Windows member computers and domain controllers that are joined to Active Directory domains that are configured by using single-label DNS names.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Deployment and operation of Active Directory domains that are configured by using single-label DNS names

This article contains information about the deployment and operation of Active Directory (AD) domains that are configured by using single-label DNS names.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows 10, version 1809  
_Original KB number:_ &nbsp; 300684

## Summary

The wish to remove the single label domain configuration is a frequent reason to rename a domain. The application compatibility information in this article applies to all scenarios in which you might consider renaming a domain.

For the following reasons, the best practice is to create new Active Directory domains that have fully qualified DNS names:

- Single-label DNS names cannot be registered by using an Internet registrar.
- Client computers and domain controllers that are joined to single-label domains require additional configuration to dynamically register DNS records in single-label DNS zones.
- Client computers and domain controllers may require additional configuration to resolve DNS queries in single-label DNS zones.
- Some server-based applications are incompatible with single-label domain names. Application support may not exist in the initial release of an application, or support may be dropped in a future release.
- Transitioning from a single-label DNS domain name to a fully qualified DNS name is non-trivial and consists of two options. Either [migrate](https://www.microsoft.com/download/details.aspx?id=19188) users, computers, groups, and other states to a new forest. Or, do a domain rename of the existing domain. Some server-based applications are incompatible with the domain rename feature that is supported in Windows Server 2003 and newer domain controllers. These incompatibilities either block the domain rename feature or make the use of the domain rename feature more difficult when you try to rename a single-label DNS name to a fully qualified domain name.

- The Active Directory Installation Wizard (Dcpromo.exe) in Windows Server 2008 warns against creating new domains that have single-label DNS names. Because there's no business or technical reason to create new domains that have single-label DNS names, the Active Directory Installation Wizard in Windows Server 2008 R2 explicitly blocks creating such domains.

Examples of applications that are incompatible with domain renaming include, but aren't limited to, the following products:

- Microsoft Exchange 2000 Server
- Microsoft Exchange Server 2007
- Microsoft Exchange Server 2010
- Microsoft Exchange Server 2013
- Microsoft Internet Security and Acceleration (ISA) Server 2004
- Microsoft Live Communications Server 2005
- Microsoft Operations Manager 2005
- Microsoft SharePoint Portal Server 2003
- Microsoft Systems Management Server (SMS) 2003
- Microsoft Office Communications Server 2007
- Microsoft Office Communications Server 2007 R2
- Microsoft System Center Operations Manager 2007 SP1
- Microsoft System Center Operations Manager 2007 R2
- Microsoft Lync Server 2010
- Microsoft Lync Server 2013

## More information

Best-practice Active Directory domain names consist of one or more subdomains that are combined with a top-level domain that is separated by a dot character ("."). The following ones are some examples:

- contoso.com
- corp.contoso.com

Single-label names consist of a single word like "contoso."

The top-level domain occupies the rightmost label in a domain name. Common top-level domains include the following:

- .com
- .net
- .org
- Two-letter country code top-level domains (ccTLD) such as .nz

Active Directory domain names should consist of two or more labels for the current and the future operating system and for application experience and reliability.

Invalid Top Level domain queries reported by the ICANN Security and Stability Advisory Committee can be found at [Invalid Top Level Domain Queries at the Root Level of the Domain Name System](http://www.icann.org/en/groups/ssac/documents/sac-045-en.pdf).

## DNS name registration with an Internet registrar

We recommend that you register DNS names for the top-most internal and external DNS namespaces with an Internet registrar. Which includes the forest root domain of any Active Directory forests unless such names are subdomains of DNS names that are registered by your organization name (For example, the forest root domain "corp.example.com" is a subdomain of an internal "example.com." namespace.) When you register your DNS names with an Internet registrar, this lets Internet DNS servers resolve your domain now or at some point over the life of your Active Directory forest. And, this registration helps prevent possible name collisions by other organizations.

## Possible symptoms when clients can't dynamically register DNS records in a single-label forward lookup zone

If you use a single-label DNS name in your environment, clients may be unable to dynamically register DNS records in a single-label forward lookup zone. Specific symptoms vary according to the version of Microsoft Windows that is installed.

The following list describes the symptoms that may occur:

- After you configure Microsoft Windows for a single label domain name, all servers that have the domain controller role may be unable to register DNS records. The System log of the domain controller may consistently log NETLOGON 5781 warnings that resemble the following example:
    > [!NOTE]
    > Status code 0000232a maps to the following error code:

    > DNS_ERROR_RCODE_SERVER_FAILURE

- The following additional status codes and error codes may appear in log files such as Netdiag.log:

    > DNS Error Code: 0x0000251D = DNS_INFO_NO_RECORDS  
    DNS_ERROR_RCODE_ERROR  
    RCODE_SERVER_FAILURE

- Windows-based computers that are configured for DNS dynamic updates won't register in a single-label domain. Warning events that resemble the following examples are recorded in the System log of the computer:

## How to enable Windows-based clients to do queries and dynamic updates with single-label DNS zones

By default, Windows doesn't send updates to top-level domains. However, you can change this behavior by using one of the methods that are described in this section. Use one of the following methods to enable Windows-based clients to do dynamic updates to single-label DNS zones.

Also without modification, an Active Directory domain member in a forest that contains no domains that have single-label DNS names doesn't use the DNS Server service to locate domain controllers in domains that have single-label DNS names that are in other forests. Client access to the domains that have single-label DNS names fails if NetBIOS name resolution isn't configured correctly.

### Method 1: Use Registry Editor

- Domain controller locator configuration for Windows XP Professional and later versions of Windows

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    On a Windows-based computer, an Active Directory domain member requires additional configuration to support single-label DNS names for domains. Specifically, the domain controller locator on the Active Directory domain member doesn't use the DNS server service to locate domain controllers in a domain that has a single-label DNS name unless that Active Directory domain member is joined to a forest that contains at least one domain, and this domain has a single-label DNS name.

    To enable an Active Directory domain member to use DNS to locate domain controllers in domains that have single-label DNS names that are in other forests, follow these steps:

    1. Select **Start**, select **Run**, type regedit, and then select **OK**.
    2. Locate and then select the following subkey:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

    3. In the details pane, locate the **AllowSingleLabelDnsDomain** entry. If the **AllowSingleLabelDnsDomain** entry doesn't exist, follow these steps:
          1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
          2. Type **AllowSingleLabelDnsDomain** as the entry name, and then press **ENTER**.
    4. Double-click the **AllowSingleLabelDnsDomain** entry.
    5. In the **Value data** box, type 1, and then select **OK**.
    6. Exit Registry Editor.

- DNS client configuration

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    Active Directory domain members and domain controllers that are in a domain that has a single-label DNS name typically must dynamically register DNS records in a single-label DNS zone that matches the DNS name of that domain. If an Active Directory forest root domain has a single-label DNS name, all domain controllers in that forest typically must dynamically register DNS records in a single-label DNS zone that matches the DNS name of the forest root.

    By default, Windows-based DNS client computers don't attempt dynamic updates of the root zone "." or of single-label DNS zones. To enable Windows-based DNS client computers to try dynamic updates of a single-label DNS zone, follow these steps:
    1. Select **Start**, select **Run**, type regedit, and then select **OK**.
    2. Locate and then select the following subkey:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DnsCache\Parameters`

    3. In the details pane, locate the **UpdateTopLevelDomainZones** entry. If the **UpdateTopLevelDomainZones** entry doesn't exist, follow these steps:
        1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
        2. Type **UpdateTopLevelDomainZones** as the entry name, and then press **ENTER**.
    4. Double-click the **UpdateTopLevelDomainZones** entry.
    5. In the **Value data** box, type 1, and then select **OK**.
    6. Exit Registry Editor.

    These configuration changes should be applied to all domain controllers and members of a domain that have single-label DNS names. If a domain that has a single-label domain name is a forest root, these configuration changes should be applied to all the domain controllers in the forest, unless the separate zones _msdcs. _ForestName_, _sites. *ForestName*, _tcp. *ForestName*, and_udp. *ForestName* are delegated from the *ForestName* zone.

    For the changes to take effect, restart the computers where you changed the registry entries.

    > [!NOTE]
    >
    > - For Windows Server 2003 and later versions, the UpdateTopLevelDomainZones entry has moved to the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient`
    > - On a Microsoft Windows 2000 SP4-based domain controller, the computer will report the following name registration error in the System event log if the UpdateTopLevelDomainZones setting is not enabled:
    > - On a Windows 2000 SP4-based domain controller, you must restart your computer after you add the UpdateTopLevelDomainZones setting.

### Method 2: Use Group Policy

Use Group Policy to enable the Update Top Level Domain Zones policy and the Location of the DCs hosting a domain with single label DNS name policy as specified in the following table under the folder location on the root domain container in Users and Computers, or on all organizational units (OUs) that host computer accounts for member computers, and for domain controllers in the domain.

|Policy|Folder location|
|---|---|
|Update Top Level Domain Zones|Computer Configuration\Administrative Templates\Network\DNS Client|
|Location of the DCs hosting a domain with single label DNS name|Computer Configuration\Administrative Templates\System\Net Logon\DC Locator DNS Records|
  
> [!NOTE]
> These policies are supported only on Windows Server 2003-based computers and on Windows XP-based computers.

To enable these policies, follow these steps on the root domain container:

1. Select **Start**, select **Run**, type gpedit.msc, and then select **OK**.
2. Under **Local Computer Policy**, expand **Computer Configuration**.
3. Expand **Administrative Templates**.
4. Enable the Update Top Level Domain Zones policy. To do it, follow these steps:
    1. Expand **Network**.
    2. Select **DNS Client**.
    3. In the details pane, double-click **Update Top Level Domain Zones**.
    4. Select **Enabled**.
    5. Select **Apply**, and then select **OK**.
5. Enable the Location of the DCs hosting a domain with single label DNS name policy. To do this, follow these steps:
    1. Expand **System**.
    2. Expand **Net Logon**.
    3. Select **DC Locator DNS Records**.
    4. In the details pane, double-click **Location of the DCs hosting a domain with single label DNS name**.
    5. Select **Enabled**.
    6. Select **Apply**, and then select **OK**.
6. Exit Group Policy.

On Windows Server 2003-based and later versions DNS servers, make sure that root servers aren't created unintentionally.

On Windows 2000-based DNS servers, you may have to delete the root zone "." to have the DNS records correctly declared. The root zone is automatically created when the DNS server service is installed because the DNS server service can't reach the root hints. This issue was corrected in later versions of Windows.

Root servers may be created by the DCpromo Wizard. If the "." zone exists, a root server has been created. For name resolution to work correctly, you may have to remove this zone.

## New and modified DNS policy settings for Windows Server 2003 and later versions

- The Update Top Level Domain Zones policy

    If this policy is specified, it creates a `REG_DWORD UpdateTopLevelDomainZones` entry under the following registry subkey:
        `HKLM\Software\Policies\Microsoft\Windows NT\DNSClient`  
    The following are the entry values for `UpdateTopLevelDomainZones`:
      - Enabled (0x1). A 0x1 setting means that computers may try to update the TopLevelDomain zones. That is, if the `UpdateTopLevelDomainZones` setting is enabled, computers to which this policy is applied send dynamic updates to any zone that is authoritative for the resource records that the computer must update, except for the root zone.
      - Disabled (0x0). A 0x0 setting means that computers aren't permitted to try to update the TopLevelDomain zones. That is, if this setting is disabled, computers to which this policy is applied don't send dynamic updates to the root zone or to the top-level domain zones that are authoritative for the resource records that the computer must update. If this setting isn't configured, the policy isn't applied to any computers, and computers use their local configuration.

- The **Register PTR Records** policy

    A new possible value, 0x2, of the `REG_DWORD RegisterReverseLookup` entry was added under the following registry subkey:  
        `HKLM\Software\Policies\Microsoft\Windows NT\DNSClient`  

    The following are the entry values for `RegisterReverseLookup`:
      - 0x2. Register only if "A" record registration succeeds. Computers try to implement PTR resource records registration only if they successfully registered the corresponding "A" resource records.
      - 0x1. Register. Computers try to implement PTR resource records registration whatever the success of the "A" records registration.
      - 0x0. Don't register. Computers never try to implement PTR resource records registration.

## References

- [DNS namespace planning](../networking/dns-namespace-design.md)

- [Unable to select DNS Server role when adding a domain controller into an existing Active Directory domain](auto-install-dns-server-role-disabled-promte-domain-controller.md)

- [ADMT Guide: Migrating and Restructuring Active Directory Domains](https://www.microsoft.com/download/details.aspx?id=19188)

- [Active Directory Migration Tool (ADMT) Guide: Migrating and Restructuring Active Directory Domains](https://www.microsoft.com/download/details.aspx?id=19188)
