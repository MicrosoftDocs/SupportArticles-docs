---
title: Best Practices for Active Directory Domains that Use Single-label DNS Names
description: This article provides information about the deployment and operation of Windows member computers and domain controllers that are joined to Active Directory domains use single-label DNS names.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, arrenc, herbertm, v-appelgatet
ms.custom:
- sap:active directory\dcpromo and the installation or removal of domain controllers
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Best practices for Active Directory domains that use single-label DNS names

## Summary

This article provides information about the deployment and operation of Active Directory Domain Services (AD DS) domains that use single-label DNS names.

_Original KB number:_ &nbsp; 300684

This article provides application compatibility information for scenarios in which you're considering renaming a domain. Typically, you might consider this approach in order to remove a single-label domain name system (DNS) configuration.

For the following reasons, create new Active Directory domains that have fully qualified DNS names (FQDNs):

- You can't use an internet registrar to register single-label DNS names.
- When joined to single-label domains, client computers (both domain-joined and nondomain-joined) and domain controllers (DCs) require extra configuration to dynamically register DNS records in single-label DNS zones.
- Client computers (domain-joined, nondomain-joined, and Microsoft Entra ID-joined) and DCs require extra configuration to resolve DNS queries in single-label DNS zones.
- Some server-based applications are incompatible with single-label domain names. Newly released applications might not support single-label DNS names, and applications that support single-label DNS names might drop that support in the future.
- Transitioning from a single-label DNS domain name to an FQDN is nontrivial and consists of two options:

  - Migrate users, computers, groups, and other states to a new forest.
  - Rename the existing domain.

    > [!IMPORTANT]  
    > Current Microsoft applications don't support domain renaming. Therefore, don't try to rename a single-label DNS name to an FQDN.

- In Windows Server 2008, the Active Directory Installation Wizard (Dcpromo.exe) warns against creating new domains that have single-label DNS names. There's no business or technical reason to create new domains that have single-label DNS names. In Windows Server 2008 R2 and later versions, the Active Directory Installation Wizard explicitly blocks creating such domains.

Previous versions of this article listed Microsoft applications that specifically didn't support domain renaming. Currently, no Microsoft applications support domain renaming. Therefore, the distinction that's provided by that list is no longer needed.

## More information

Single-label names consist of a single word, such as "contoso."

Best-practice Active Directory domain names consist of one or more subdomains that you combine with a top-level domain. A period (".") separates the two components, as shown in the following examples:

- contoso.com
- corp.contoso.com

The top-level domain occupies the rightmost label in a domain name. A large number of top-level domains are available. Common top-level domains include the following examples:

- .com
- .net
- .org
- Two-letter country code top-level domains (ccTLD), such as .nz
- Generic names such as "local." However, in these situations, generic names might cause other issues.

To support current and future operating systems and reliable applications, use two or more labels for Active Directory domain names. For examples of invalid top-level domain queries, see [Invalid Top Level Domain Queries at the Root Level of the Domain Name System (ICANN Security and Stability Advisory Committee)](http://www.icann.org/groups/ssac/documents/sac-045-en.pdf).

### Registering DNS names with an internet registrar

Use an internet registrar to register DNS names for the top-most internal and external DNS namespaces of your domain. These DNS namespaces include the forest root domains of any Active Directory forests, unless such names are subdomains of previously-registered domains. (For example, the forest root domain "corp.example.com" is a subdomain of an internal "example.com." namespace.) When you register your DNS names with an internet registrar, internet DNS servers resolve your domain either now or at some point over the life of your Active Directory forest. This registration also helps prevent name collisions by other organizations.

### Symptoms that indicate clients can't dynamically register DNS records in a single-label forward lookup zone

If you use a single-label DNS name in your environment, clients might be unable to dynamically register DNS records in a single-label forward lookup zone. Specific symptoms vary for different versions of Windows, but might include the following symptoms:

- After you configure single label domain name, DCs can't register DNS records. The system logs of the DC consistently log NetLogon Event ID 5781, "Dynamic registration or deletion of one or more DNS records associated with DNS domain 'intranet.example.com.' failed."

- Clients receive DNS errors that resemble the following error codes:

  - `0000232A DNS_ERROR_RCODE_SERVER_FAILURE`
  - `0x0000251D DNS_INFO_NO_RECORDS`
  - `DNS_ERROR_RCODE_ERROR`
  - `0x0000232A RCODE_SERVER_FAILURE`

- Windows-based computers that are configured for DNS dynamic updates don't register in a single-label DNS domain. Windows logs corresponding events in the System log.

### How to enable Windows-based clients to send queries and dynamic updates when using single-label DNS zones

A Windows-based computer requires additional configuration to support single-label DNS names for Active Directory domains. Specifically, in a domain that has a single-label DNS name, the DC Locator service on an Active Directory domain member doesn't use the DNS Server service to locate domain controllers. You have to apply this additional configuration to all computers in all forests.

Consider the following configuration:

- Domain member computers reside in a forest that doesn't contain any single-label DNS domains.
- DCs reside in single-label DNS domains in a different forest.

In this configuration, you see the following default behaviors:

- By default, the client computers don't use the DNS Server service to locate the DCs.
- By default, Windows DNS clients don't send updates to top-level domains.

These behaviors cause DNS resolution issues. To mitigate the issues, you have to change the configurations of the Windows client computers (domain-joined, nondomain-joined, or Microsoft Entra ID-joined) and the DCs. To change the configurations, use one of the two methods in this section.

> [!IMPORTANT]  
> Before you use either method, make sure that NetBIOS name resolution works correctly in your environment. Otherwise, clients can't access the domains that have single-label DNS names.

#### Method 1: Use Registry Editor

[!INCLUDE [registry important alert](../../../includes/registry-important-alert.md)]

##### Step 1: Change the DC Locator service configuration

On the domain-joined Windows client computers, follow these steps:

1. In the Search box, enter regedit, and then select **Registry editor**.
1. Locate and select the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters` subkey.
1. In the details pane, locate the `AllowSingleLabelDnsDomain` entry. If the entry doesn't exist, follow these steps:
   1. Select **Edit** > **New** > **DWORD Value**.
   1. In the **Name** box, enter **AllowSingleLabelDnsDomain**.
1. Double-click the **AllowSingleLabelDnsDomain** entry, and then in **Value data**, enter **1**.
1. Close Registry Editor, and restart the computer.

##### Step 2: Change the dynamic update configuration for the DNS root zone or single-label DNS zones

Apply these changes to all DCs and Windows clients (domain-joined, nondomain-joined, or Microsoft Entra ID-joined) that have single-label DNS suffixes. If a domain that has a single-label DNS name is a forest root domain, apply these changes to all the DCs in the forest, unless the following individual zones are delegated from the *ForestName* zone: \_msdcs. *ForestName*, \_sites. *ForestName*, _tcp. *ForestName*, and \_udp. *ForestName*.

Follow these steps:

1. In the Search box, enter regedit, and then select **Registry editor**.
1. Locate and then select the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient` subkey.
1. In the details pane, locate the `UpdateTopLevelDomainZones` entry. If the entry doesn't exist, follow these steps:
   1. Select **Edit** > **New** > **DWORD Value**.
   1. In the **Name** box, enter **UpdateTopLevelDomainZones**.
1. Double-click the **UpdateTopLevelDomainZones** entry, and then enter **1** in **Value data**.
1. Close Registry Editor, and restart the computer.

#### Method 2: Use Group Policy

Use Group Policy to enable the **Update Top Level Domain Zones** policy and the **Location of the DCs hosting a domain with single label DNS name** policy. Configure these policies under the folder location on the root domain container in **Users and Computers**, or on all organizational units (OUs) that host computer accounts for member computers and for DCs in the domain. Use the values that are specified in the following table.

|Policy|Folder location|
|---|---|
|Update Top Level Domain Zones|Computer Configuration\Administrative Templates\Network\DNS Client|
|Location of the DCs hosting a domain with single label DNS name|Computer Configuration\Administrative Templates\System\Net Logon\DC Locator DNS Records|

To enable these policies, follow these steps on the root domain container:

1. In the Group Policy Management Console (GPMC), double-click the domain policy that you want to configure. If you want all computers to behave in the same manner, double-click a global policy such as **Default Domain Policy**.

1. Expand **Computer Configuration** > **Administrative Templates** > **Network** > **DNS Client**.
1. In the details pane, double-click **Use DNS name resolution with a single-label domain name instead of NetBIOS name resolution to locate the DC**.
1. Select **Enabled**, select **Apply**, and then select **OK**.
1. Under **Administrative Templates**, expand **System** > **Net Logon** > **DC Locator DNS Records**.
1. In the details pane, double-click **Location of the DCs hosting a domain with single label DNS name**.
1. Select **Enabled**, select **Apply**, and then select **OK**.
1. Close the Group Policy Editor and GPMC.

> [!NOTE]  
> You can define the settings by using configuration service policies (CSPs). For more information, see the following articles:
>
> - [Policy CSP - ADMX_DnsClient](/windows/client-management/mdm/policy-csp-admx-dnsclient#dns_updatetopleveldomainzones)
> - [Policy CSP - ADMX_Netlogon](/windows/client-management/mdm/policy-csp-admx-netlogon#netlogon_allowsinglelabeldnsdomain)

Check the DNS servers to make sure that root servers aren't created unintentionally. The DCpromo Wizard might create root servers. If the "." zone exists, DCpromo created a root server. For name resolution to work correctly, you might have to remove this zone.

### New and modified DNS policy settings for Windows

- **Update Top Level Domain Zones**

  If you enable this policy, it creates a `REG_DWORD UpdateTopLevelDomainZones` entry under the `HKLM\Software\Policies\Microsoft\Windows NT\DNSClient` registry subkey. You can select one of the following values.

  | Value | Name | Description |
  | --------- | - | --------- |
  | 0x1 | Enabled | Computers can try to update the TopLevelDomain zones. If you enable the `UpdateTopLevelDomainZones` setting, computers send dynamic updates to any zone that's authoritative for the resource records that the computer must update, except for the root zone. |
  | 0x0 | Disabled | Computers can't try to update the TopLevelDomain zones. If you disable this setting, computers don't send dynamic updates to the root zone or to the top-level domain zones that are authoritative for the resource records that the computer must update. If you don't configure this setting, the policy isn't applied to any computers, and computers use their local configuration. |

- **Register PTR Records**

  This policy isn't new, but it has a new possible value. If you enable this policy, it creates a `REG_DWORD RegisterReverseLookup` entry under the `HKLM\Software\Policies\Microsoft\Windows NT\DNSClient` registry subkey. You can select one of the following values.

  | Value | Name | Description |
  | --------- | - | --------- |
  | 0x2 | Register only if "A" record registration succeeds. | Computers try to implement PTR resource records registration only if they successfully registered the corresponding "A" resource records. |
  | 0x1 | Register | Computers try to implement PTR resource records registration regardless of the success of the "A" records registration. |
  | 0x0 | Don't register | Computers never try to implement PTR resource records registration. |

## References

- [DNS namespace planning](../networking/dns-namespace-design.md)
- [Unable to select DNS Server role when adding a domain controller into an existing Active Directory domain](auto-install-dns-server-role-disabled-promte-domain-controller.md)
