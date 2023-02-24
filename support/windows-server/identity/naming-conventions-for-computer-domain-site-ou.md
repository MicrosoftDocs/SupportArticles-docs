---
title: Name computers, domains, sites, and OUs
description: Describes how to name computers, domains, sites, and organizational units in Active Directory.
ms.date: 2/27/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Naming conventions in Active Directory for computers, domains, sites, and OUs

This article describes the naming conventions for computer accounts in Windows, NetBIOS domain names, DNS domain names, Active Directory sites, and organizational units (OUs) that are defined in the Active Directory directory service.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 909264

## Summary

This article discusses the following topics:

- The valid characters for names
- The minimum and maximum name lengths
- Reserved names
- Names that we don't recommend
- General recommendations that are based on supporting Active Directory in small, medium, and large deployments

All objects that are named within Active Directory, or within AD/AM and LDS, are subject to name matching based on the algorithm described in the following article:

[You can't add a user name or an object name that only differs by a character with a diacritic mark](https://support.microsoft.com/help/938447).

In that article, this naming convention applies to computer, organizational unit (OU), and site names.

## Computer names

### NetBIOS computer names

- **Allowed characters.** NetBIOS computer names can contain all alphanumeric characters except for the extended characters that appear in the following in **Disallowed characters** list. Names can contain a period, but names can't start with a period.
  > [!NOTE]  
  > Microsoft Windows NT allows non-DNS names to have period. Periods shouldn't be used in Windows. If you're upgrading a computer whose NetBIOS name contains a period, change the computer name. For more information, see **Special characters** later in this section.
- **Disallowed characters.** NetBIOS computer names can't contain the following characters:

  - backslash (\\)
  - slash mark (/)
  - colon (:)
  - asterisk (*)
  - question mark (?)
  - quotation mark (")
  - less than sign (<)
  - greater than sign (>)
  - vertical bar (|)
  - Computers that are members of an Active Directory domain can't have names that only contain numbers. This is a DNS restriction.

  For more information about the NetBIOS name syntax, see [NetBIOS name syntax](/openspecs/windows_protocols/ms-nbte/6f06fa0e-1dc4-4c41-accb-355aaf20546d).

- **Name length rules.**
    - Minimum name length: One character.
    - Maximum name length: 15 characters

    > [!NOTE]
    > The 16th character of a NetBIOS computer name is reserved to identify the functionality that is installed on the registered network device.

- **Reserved names.** See [Table of reserved words](#table-of-reserved-words).

- **Special characters.** Period (.)

    A period character separates the name into a NetBIOS scope identifier and the computer name. The NetBIOS scope identifier is an optional string of characters that identify logical NetBIOS networks that run on the same physical TCP/IP network. For NetBIOS to work between computers, the computers must have the same NetBIOS scope identifier and unique computer names.

    The use of NetBIOS scopes in names is a legacy configuration. It shouldn't be used with Active Directory forests. For more information about NetBIOS scopes, see the following requests for comments (RFCs):

  - [RFC 1001: Protocol Standard for a NetBIOS Service on a TCP/UDP Transport: Concepts and Methods](https://www.ietf.org/rfc/rfc1001.txt)
  - [RFC 1002: Protocol Standard for a NetBIOS Service on a TCP/UDP Transport: Detailed Specifications](https://www.ietf.org/rfc/rfc1002.txt)

### DNS host names

- **Allowed characters.** DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they're used to delimit the components of domain style names.

  Windows domain name system (DNS) supports Unicode characters. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS.

  For more information, see the following RFCs:

  - [RFC 952: DOD Internet Host Table Specification](https://www.ietf.org/rfc/rfc952.txt)
  - [RFC 1123: Requirements for Internet Hosts--Application and Support](https://www.ietf.org/rfc/rfc1123.txt)

- **Disallowed characters.** DNS host names can't contain the following characters:

  - comma (,)
  - tilde (~)
  - colon (:)
  - exclamation point (!)
  - at sign (@)
  - number sign (#)
  - dollar sign ($)
  - percent (%)
  - caret (^)
  - ampersand (&)
  - apostrophe (')
  - period (.)
  - parentheses (())
  - braces ({})
  - white space (blank)
  - underscore (_)
    > [!NOTE]  
    > The underscore has a special role. It's permitted for the first character in SRV records by RFC definition. However, newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).

  > [!NOTE]
  > The DNS host name registration process substitutes a hyphen (-) character for invalid characters.

- **Name length rules.**
  - The FQDN of a domain controller must be smaller than 155 bytes.
  - Minimum name length: Two characters.
  - Maximum name length: 63 characters.  
      > [!NOTE]  
      > - If you use UTF-8 (Unicode) characters, remember that some UTF-8 characters exceed one octet in length. In that case, you can't determine the size of a name by counting the characters. The maximum size of the host name and of the fully qualified domain name (FQDN) is 63 bytes per label and 255 bytes per FQDN.
      >
      > - Windows doesn't permit computer names that exceed 15 characters, and you can't specify a DNS host name that differs from the NetBIOS host name. However, you might create host headers for a web site that's hosted on a computer. Then the host headers are subject to this rule.

- **Additional rules for DNS host names.**

  - All characters preserve their case formatting except for American Standard Code for Information Interchange (ASCII) characters.
  - The first character in a DNS host name must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.
  - Two-character security descriptor definition language (SDDL) user strings that are listed in [well-known SIDs list](/windows/win32/secauthz/sid-strings) can't be used. Otherwise, _import_, _export_, and _take control_ operations fail.
  - Computers that are members of an Active Directory domain can't have names that only contain numbers. This is a DNS restriction.

- **Reserved names as per RFC.** For more information, see [RFC 952](https://www.ietf.org/rfc/rfc952.txt).

  - -GATEWAY
  - -GW
  - -TAC

- **Reserved names in Windows.** See [Table of reserved words](#table-of-reserved-words).

- **Best practices.** When you create names for computers in a Windows DNS infrastructure, use the following guidelines:

  - Use a computer name that's easy for users to remember.

  - Identify the owner of the computer in the computer name.
  - Use a name that describes the purpose of the computer.
  - Match the Active Directory domain name to the primary DNS suffix of the computer name. For more information, see [Disjointed namespaces](#disjointed-namespaces).
  - Use a unique name for every computer in your organization. Avoid using the same computer name for computers in different DNS domains.
  - Use ASCII characters. This guarantees interoperability with computers that aren't running Windows.
  - When you use ASCII characters, don't use character case to indicate the owner or the purpose of a computer. For ASCII characters, DNS isn't case-sensitive. Windows and Windows applications don't preserve case in all situations.
  - Use only the characters that are listed in [RFC 1123](https://www.ietf.org/rfc/rfc1123.txt). These characters include A-Z, a-z, 0-9, and the hyphen (-). Windows DNS allows most UTF-8 characters in names. Don't use extended ASCII or UTF-8 characters unless all the DNS servers in your environment support them.

## Domain names

Here are details for NetBIOS domain names and DNS domain names.

### NetBIOS domain names

- **Allowed characters.** NetBIOS domain names can contain all alphanumeric characters except for the extended characters that appear in the **Disallowed characters** list. Names can contain a period, but names can't start with a period.
  > [!NOTE]  
  > Microsoft Windows NT allows non-DNS names to have period. Periods shouldn't be used in Active Directory NetBIOS domain names. If you're upgrading a computer whose NetBIOS name contains a period, change the name by migrating the domain to a new domain structure. Don't use periods in new NetBIOS domain names.
- **Disallowed characters.** The DNS host name checking function verifies NetBIOS domain names. These names can't contain the following characters:

  - comma (,)
  - tilde (~)
  - colon (:)
  - exclamation point (!)
  - at sign (@)
  - number sign (#)
  - dollar sign ($)
  - percent (%)
  - caret (^)
  - ampersand (&)
  - apostrophe (')
  - period (.)
  - parentheses (())
  - braces ({})
  - underscore (_)
  - white space(blank)
  - backslash (\\)
  - slash mark (/)
  - Computers that are members of an Active Directory domain can't have names that only contain numbers. This restriction is because of DNS restrictions.
- **Name length rules.**  
  - Minimum name length: One character.
  - Maximum name length: 15 characters.
      > [!NOTE]
      > The 16th character of the name is reserved to identify the functionality that is installed on the registered network device.

- Reserved names in Windows. See [Table of reserved words](#table-of-reserved-words).

    The names of an upgraded domain can include a reserved word. However, trust relationships with other domains fail in this situation.

- **Special characters.** Period (.).

    A period character separates the name into a NetBIOS scope identifier and the computer name. The NetBIOS scope identifier is an optional string of characters that identify logical NetBIOS networks that run on the same physical TCP/IP network. For NetBIOS to work between computers, the computers must have the same NetBIOS scope identifier and unique computer names.

    > [!IMPORTANT]  
    > The use of NetBIOS scopes in names is a legacy configuration. It shouldn't be used with Active Directory forests. There is no inherent problem with this, but there may be applications that filter the name and assume a DNS name when a period is found.

### DNS domain names

- **Allowed characters.** DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they're used to delimit the components of domain style names.

    Windows DNS supports Unicode characters. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS. For more information, see [RFC 952](https://www.ietf.org/rfc/rfc952.txt) and [RFC 1123](https://www.ietf.org/rfc/rfc1123.txt).
.
- **Disallowed characters.** DNS domain names can't contain the following characters:

  - comma (,)
  - tilde (~)
  - colon (:)
  - exclamation point (!)
  - at sign (@)
  - number sign (#)
  - dollar sign ($)
  - percent (%)
  - caret (^)
  - ampersand (&)
  - apostrophe (')
  - period (.)
  - parentheses (())
  - braces ({})
  - white space (blank)
  - underscore (_)  
    The underscore has a special role. It's permitted for the first character in SRV records by RFC definition. But newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).  

    When you create a new domain, you get a warning that an underscore character might cause problems with some DNS servers. However, you can still create the domain.

- **Additional rules.**

  - All characters preserve their case formatting except for ASCII characters.
  - The first character must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.

- **Name length rules.**  

  - Minimum name length: Two characters.
  - Maximum name length: 255 characters.
    > [!NOTE]  
    > If you use UTF-8 (Unicode) characters, remember that some UTF-8 characters exceed one octet in length. In that case, you can't determine the size of a name by counting the characters. The maximum size of the host name and of the FQDN is 63 bytes per label and 255 bytes per FQDN.

  - The maximum name length is based on the requirements of `SYSVOL` paths, and also on the `MAX_PATH` limitation of 260 characters.

    A path in `SYSVOL` resembles the following example:

    ```console
    \\<FQDN domain name>\sysvol\<FQDN domain name>\policies\{<policy GUID>}\[user|machine]\<CSE-specific path>
    ```

    > [!NOTE]  
    > - The AD FQDN domain name appears in the path twice. Because of this, the length of an AD FQDN domain name is restricted to 64 characters.
    >  
    > - The \<_CSE-specific path_> might contain user input such as the sign-in script file name. As a result, it can also reach a significant length.

- **Single-label domain namespaces.** Single-label DNS names are names that don't contain a suffix, such as `.com`, `.corp`, `.net`, `.org`, or _`companyname`_. For example, _host_ is a single-label DNS name. Most Internet registrars don't allow the registration of single-label DNS names.

    Generally, we recommend that you register DNS names for internal and external namespaces with an Internet registrar. This includes the DNS names of Active Directory domains, unless such names are subdomains of DNS names that are registered by your organization name. For example, `corp.example.com` is a subdomain of `example.com`. Registering your DNS name with an Internet registrar may help prevent a name collision. A name collision may occur if another organization tries to register the same DNS name, or if your organization merges with another organization that uses the same DNS name.

    Problems that are associated with single-label namespaces include:

  - Single-label DNS names can't be registered by using an Internet registrar.
  - Domains that have single-label DNS names require additional configuration.
  - The DNS Server service can't locate domain controllers in domains that have single-label DNS names.
  - By default, Windows domain members don't perform dynamic updates to single-label DNS zones. For more information, see [Deployment and operation of Active Directory domains that are configured by using single-label DNS names](deployment-operation-ad-domains.md).

- **Reserved names.** See [Table of reserved words](#table-of-reserved-words).

    Don't use top-level internet domain names on the intranet, such as `.com`, `.net`, and `.org`. If you use top-level Internet domain names on the intranet, computers on the intranet that also connect to the internet may experience resolution errors. Additionally, avoid using names that're used in internet-standard special features, such as `.local`.

#### Disjointed namespaces

A disjointed namespace occurs when a computer's primary DNS suffix doesn't match the DNS domain of which it's a member. For example, a disjointed namespace occurs when a computer that has the DNS name of `dc1.contosocorp.com` is in a domain that has the DNS name of `contoso.com`.

**How disjointed namespaces occur:**

1. A Windows NT 4.0 primary domain controller is upgraded to a Windows 2000 Server domain controller by using the original release version of Windows 2000 Server. In the **Networking** item in **Control Panel**, multiple DNS suffixes are defined.
2. The domain is renamed when the forest is at the Windows Server 2003 forest functional level. Additionally, the primary DNS suffix isn't changed to reflect the new DNS domain name.

**Effects of a disjointed namespace:**

Suppose a domain controller that's named _DC1_ resides in a Windows NT 4.0 domain whose NetBIOS domain name is `contoso`. This domain controller is upgraded to Windows 2000 Server. When this upgrade occurs, the DNS domain is renamed `contoso.com`. In the original release version of Windows 2000 Server, the upgrade routine clears the checkbox that links the primary DNS suffix of the domain controller to its DNS domain name. So, the primary DNS suffix of the domain controller is the Windows NT 4.0 DNS suffix that was defined in the Windows NT 4.0 suffix search list. In this example, the DNS name is `DC1.northamerica.contoso.com`.

The domain controller dynamically registers its service location (SRV) records in the DNS zone that corresponds to its DNS domain name. However, the domain controller registers its host records in the DNS zone that corresponds to its primary DNS suffix.

For more information about a disjoint namespace, see the following articles:

- [Event IDs 5788 and 5789 occur on a Windows-based computer](event-ids-5788-5789.md)
- [Create a Disjoint Namespace](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731929(v=ws.10))

### Other factors

- **Forests that connect to the internet.** A DNS namespace that connects to the internet must be a subdomain of a top-level or second-level domain of the internet DNS namespace.

- **Maximum number of domains in a forest.** In Windows Server, the maximum number of domains at Forest Functional Level 2 is 1200. This restriction is a limitation of multivalued non-linked attributes in Windows Server.

- **Best practices.**

  - The DNS names of all the nodes that require name resolution include the organization's internet DNS domain name. So, choose an internet DNS domain name that is short and easy to remember. Because DNS is hierarchical, DNS domain names grow when you add subdomains to your organization. Short domain names make the computer names easy to remember.

  - If the organization has an internet presence, use names that are relative to the registered internet DNS domain name. For example, if you've registered the internet DNS domain name `contoso.com`, use a DNS domain name such as `corp.contoso.com` for the intranet domain name.
  - Don't use the name of an existing corporation or product as your domain name. You can run into a name collision later on.
  - Avoid a generic name such as `domain.localhost`. Another company you merge with in a few years might follow the same thinking.
  - Don't use an acronym or an abbreviation as a domain name. Users may have difficulty recognizing the business unit that an acronym represents.
  - Avoid the use of underscores (_) in domain names. Applications might be very RFC obedient and reject the name, and don't install or work in your domain. And you might experience problems with older DNS servers.
  - Don't use the name of a business unit or of a division as a domain name. Business units and other divisions change, and these domain names can be misleading or become obsolete.
  - Don't use geographic names that are difficult to spell and remember.
  - Avoid extending the DNS domain name hierarchy more than five levels from the root domain. You can reduce administrative costs by limiting the extent of the domain name hierarchy.
  - If you're deploying DNS in a private network, and you don't plan to create an external namespace, register the DNS domain name that you create for the internal domain. Otherwise, if you try to use it on the internet, or if you connect to a network that connects to the internet, you might find that the name is unavailable.

## Site names

We recommend that you use a valid DNS name when you create a new site name. Otherwise, your site will be available only where a Microsoft DNS server is used. For more information about valid DNS names, see the [DNS host names](#dns-host-names) section.

- **Allowed characters.** DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they're used to delimit the components of domain style names.

    Windows DNS supports Unicode characters. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS. For more information, see [RFC 952](https://www.ietf.org/rfc/rfc952.txt) and [RFC 1123](https://www.ietf.org/rfc/rfc1123.txt).
- **Disallowed characters.** DNS names can't contain the following characters:

  - comma (,)
  - tilde (~)
  - colon (:)
  - exclamation point (!)
  - at sign (@)
  - number sign (#)
  - dollar sign ($)
  - percent (%)
  - caret (^)
  - ampersand (&)
  - apostrophe (')
  - period (.)
  - parentheses (())
  - braces ({})
  - white space (blank)
  - underscore (_)  
    The underscore has a special role. It's permitted for the first character in SRV records by RFC definition. But newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).

- **Additional rules.**

  - All characters preserve their case formatting except for ASCII characters.
  - The first character must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.

- **Name length rules.**

  - Minimum name length: One character.
  - Maximum name length: 63 characters.
    > [!NOTE]  
    > If you use UTF-8 (Unicode) characters, remember that some UTF-8 characters exceed one octet in length. In that case, you can't determine the size of a name by counting the characters. The maximum length of the DNS name is 63 bytes per label.

## OU names

- **Allowed characters.** All characters are allowed, even extended characters. Although Active Directory Users and Computers lets you name an OU with extended characters, we recommend that you use names that describe the purpose of the OU and that are short enough to easily manage. Lightweight Directory Access Protocol (LDAP) doesn't have any restrictions, because the CN of the object is put in quotation marks.

- **Disallowed characters.** No characters are disallowed.

- **Name length rules.**

  - Minimum name length: One character.
  - Maximum name length: 64 characters.

### Special issues for OUs

When the OU at the domain root level has the same name as a future child domain, you might experience database problems. Consider a scenario where you delete an OU named _marketing_ to create a child domain with the same name, for example, `marketing.contoso.com` (leftmost label of the child domain FQDN name has the same name).

You delete the OU. During the tombstone lifetime of the deleted OU, you create a child domain that has the same name. Then you delete the child domain, and then create it a second time. In this scenario, a duplicate record name in the ESE database causes a phantom-phantom name collision when the child domain is re-created. This problem prevents the Active Directory Configuration container from replicating.

> [!NOTE]
> A similar name conflict might also happen with other RDN name types under certain conditions, not restricted to DC and OU name types.

## Table of reserved words

|Reserved words for names|Windows NT 4.0|Windows 2000|Windows Server 2003|Windows Server 2008 and later|
|---|---|---|---|---|
|ANONYMOUS|X|X|X|X|
|AUTHENTICATED USER||X|X|X|
|BATCH|X|X|X|X|
|BUILTIN|X|X|X|X|
|CREATOR GROUP|X|X|X|X|
|CREATOR GROUP SERVER|X|X|X|X|
|CREATOR OWNER|X|X|X|X|
|CREATOR OWNER SERVER|X|X|X|X|
|DIALUP|X|X|X|X|
|DIGEST AUTH|||X|X|
|DOMAIN | | | |X|
|ENTERPRISE||| |X|
|INTERACTIVE|X|X|X|X|
|INTERNET||X|X|X|
|LOCAL|X|X|X|X|
|LOCAL SYSTEM|||X|X|
|NETWORK|X|X|X|X|
|NETWORK SERVICE|||X|X|
|NT AUTHORITY|X|X|X|X|
|NT DOMAIN|X|X|X|X|
|NTLM AUTH|||X|X|
|NULL|X|X|X|X|
|PROXY||X|X|X|
|REMOTE INTERACTIVE|||X|X|
|RESTRICTED||X|X|X|
|SCHANNEL AUTH|||X|X|
|SELF||X|X|X|
|SERVER||X|X|X|
|SERVICE|X|X|X|X|
|SYSTEM|X|X|X|X|
|TERMINAL SERVER||X|X|X|
|THIS ORGANIZATION|||X|X|
|USERS|||X|X|
|WORLD|X|X|X|X|
