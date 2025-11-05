---
title: Deployment and operation of AD domains
description: This article provides information about the deployment and operation of Windows member computers and domain controllers that are joined to Active Directory domains that are configured by using single-label DNS names.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, arrenc
ms.custom:
- sap:active directory\dcpromo and the installation or removal of domain controllers
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Deployment and operation of Active Directory domains that are configured by using single-label DNS names

This article contains information about the deployment and operation of Active Directory (AD) domains that are configured by using single-label DNS names.

_Original KB number:_ &nbsp; 300684

## Summary

The wish to remove the single label domain configuration is a frequent reason to rename a domain. The application compatibility information in this article applies to all scenarios in which you might consider renaming a domain.

For the following reasons, the best practice is to create new Active Directory domains that have fully qualified DNS names:

- Single-label DNS names cannot be registered by using an Internet registrar.
- Client computers and domain controllers that are joined to single-label domains require additional configuration to dynamically register DNS records in single-label DNS zones, as well as when the computer isn't a domain member.
- Client computers and domain controllers may require additional configuration to resolve DNS queries in single-label DNS zones.
- Some server-based applications are incompatible with single-label domain names. Application support may not exist in the initial release of an application, or support may be dropped in a future release.
- Transitioning from a single-label DNS domain name to a fully qualified DNS name is non-trivial and consists of two options:

  -  [Migrate](https://www.microsoft.com/download/details.aspx?id=19188) users, computers, groups, and other states to a new forest.
  - Rename the existing domain.

    > [!IMPORTANT]  
    > Current Microsoft applications don't support domain renaming. As a result, we don't recommend that you try to rename a single-label DNS name to a fully qualified domain name.

- In Windows Server 2008, the Active Directory Installation Wizard (Dcpromo.exe) warns against creating new domains that have single-label DNS names. There's no business or technical reason to create new domains that have single-label DNS names. In Windows Server 2008 R2 and later versions, the Active Directory Installation Wizard explicitly blocks creating such domains.

## More information

Best-practice Active Directory domain names consist of one or more subdomains that are combined with a top-level domain that is separated by a dot character ("."). The following ones are some examples:

- contoso.com
- corp.contoso.com

Single-label names consist of a single word like "contoso."

The top-level domain occupies the rightmost label in a domain name. A large number of top-level domains are available. Common top-level domains include the following:

- .com
- .net
- .org
- Two-letter country code top-level domains (ccTLD) such as .nz
- Generic names such as "local." However, in these circumstances generic names might cause other issues.

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

[!INCLUDE [registry important alert](../../../includes/registry-important-alert.md)]

- Domain controller locator configuration for Windows XP Professional and later versions of Windows

    A Windows-based computer requires additional configuration to support single-label DNS names for Active Directory domains. Specifically, the domain controller locator on the Active Directory domain member doesn't use the DNS server service to locate domain controllers in a domain that has a single-label DNS name. This requirement applies to domain members and also non-domain joined computers such as computers that are only Entra ID-joined.

    To enable a Windows computer to use DNS to locate domain controllers in domains that have single-label DNS names, follow these steps:

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

    Active Directory domain members and domain controllers that are in a domain that has a single-label DNS name typically must dynamically register DNS records in a single-label DNS zone that matches the DNS name of that domain. If an Active Directory forest root domain has a single-label DNS name, all domain controllers in that forest typically must dynamically register DNS records in a single-label DNS zone that matches the DNS name of the forest root.

    By default, Windows-based DNS client computers don't attempt dynamic updates of the root zone "." or of single-label DNS zones. To enable Windows-based DNS client computers to try dynamic updates of a single-label DNS zone, follow these steps:
    1. Select **Start**, select **Run**, type regedit, and then select **OK**.
    2. Locate and then select the following subkey:
        `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient`

    3. In the details pane, locate the **UpdateTopLevelDomainZones** entry. If the **UpdateTopLevelDomainZones** entry doesn't exist, follow these steps:
        1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
        2. Type **UpdateTopLevelDomainZones** as the entry name, and then press **ENTER**.
    4. Double-click the **UpdateTopLevelDomainZones** entry.
    5. In the **Value data** box, type 1, and then select **OK**.
    6. Exit Registry Editor.

    These configuration changes should be applied to all domain controllers and members of a domain that have single-label DNS names. If a domain that has a single-label domain name is a forest root, these configuration changes should be applied to all the domain controllers in the forest, unless the separate zones _msdcs. _ForestName_, _sites. *ForestName*, _tcp. *ForestName*, and_udp. *ForestName* are delegated from the *ForestName* zone.

    For the changes to take effect, restart the computers where you changed the registry entries.

### Method 2: Use Group Policy

Use Group Policy to enable the Update Top Level Domain Zones policy and the Location of the DCs hosting a domain with single label DNS name policy as specified in the following table under the folder location on the root domain container in Users and Computers, or on all organizational units (OUs) that host computer accounts for member computers, and for domain controllers in the domain.

|Policy|Folder location|
|---|---|
|Update Top Level Domain Zones|Computer Configuration\Administrative Templates\Network\DNS Client|
|Location of the DCs hosting a domain with single label DNS name|Computer Configuration\Administrative Templates\System\Net Logon\DC Locator DNS Records|
  
To enable these policies, follow these steps on the root domain container:

[Revise the following--need to jump from gpmc to gpedit for group policy instead of local policy]
1. In the Group Policy Management Console (GPMC), select the Domain Policy where you want to enable the settings. This can be a quite global policy like the "Default Domain Policy" as you want that all machines behave the same.

1. Under **Local Computer Policy**, expand **Computer Configuration**.
1. Expand **Administrative Templates**.
1. Enable the Update Top Level Domain Zones policy. To do it, follow these steps:
    1. Expand **Network**.
    2. Select **DNS Client**.
    3. In the details pane, double-click **Use DNS name resolution with a single-label domain name instead of NetBIOS name resolution to locate the DC**.
    4. Select **Enabled**.
    5. Select **Apply**, and then select **OK**.
1. Enable the Location of the DCs hosting a domain with single label DNS name policy. To do this, follow these steps:
    1. Expand **System**.
    2. Expand **Net Logon**.
    3. Select **DC Locator DNS Records**.
    4. In the details pane, double-click **Location of the DCs hosting a domain with single label DNS name**.
    5. Select **Enabled**.
    6. Select **Apply**, and then select **OK**.
1. Close the Group Policy Editor and GPMC.

> [!NOTE]  
> You can define the settings by using configuration service policies (CSPs). For more information, see the following articles:
>
> - [](/windows/client-management/mdm/policy-csp-admx-dnsclient#dns_updatetopleveldomainzones)
> - [](/windows/client-management/mdm/policy-csp-admx-netlogon#netlogon_allowsinglelabeldnsdomain)

On the DNS servers, make sure that root servers aren't created unintentionally.

Root servers may be created by the DCpromo Wizard. If the "." zone exists, a root server has been created. For name resolution to work correctly, you may have to remove this zone.

## New and modified DNS policy settings for Windows

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
