---
title: Name computers, domains, sites, and OUs
description: Describes how to name computers, domains, sites, and organizational units in Active Directory.
ms.date: 09/08/2020
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

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 909264

## Summary

This article discusses the following topics:

- The valid characters for names
- The minimum and maximum name lengths
- Reserved names
- Names that we don't recommend
- General recommendations that are based on supporting Active Directory in small, medium, and large deployments

All objects that are named within Active Directory, or within AD/AM and LDS, are subject to name matching based on the algorithm described in the following article:

[You cannot add a user name or an object name that only differs by a character with a diacritic mark](https://support.microsoft.com/help/938447).

In that article, this naming convention applies to computer, OU, and site names.

## Computer names

### NetBIOS computer names

- Allowed characters

    NetBIOS computer names can contain all alphanumeric characters except for the extended characters that are listed in **Disallowed characters**. Names can contain a period, but names can't start with a period.

- Disallowed characters

    NetBIOS computer names can't contain the following characters:

  - backslash (\\)
  - slash mark (/)
  - colon (:)
  - asterisk (*)
  - question mark (?)
  - quotation mark (")
  - less than sign (<)
  - greater than sign (>)
  - vertical bar (|)

    Names can contain a period (.). But the name can't start with a period. The use of non-DNS names with periods is allowed in Microsoft Windows NT. Periods should not be used in Microsoft Windows 2000 or later versions of Windows. If you're upgrading a computer whose NetBIOS name contains a period, change the machine name. For more information, see **Special characters**.

    In Windows 2000 and later versions of Windows, computers that are members of an Active Directory domain can't have names that are composed completely of numbers. This restriction is because of DNS restrictions.

    For more information about the NetBIOS name syntax, see [NetBIOS name syntax](/openspecs/windows_protocols/ms-nbte/6f06fa0e-1dc4-4c41-accb-355aaf20546d).

- Minimum name length: 1 character

- Maximum name length: 15 characters

    > [!NOTE]
    > The 16th character is reserved to identify the functionality that is installed on the registered network device.

- Reserved names

    See [Table of reserved words](#table-of-reserved-words).

- Special characters: Period (.)

    A period character separates the name into a NetBIOS scope identifier and the computer name. The NetBIOS scope identifier is an optional string of characters that identify logical NetBIOS networks that run on the same physical TCP/IP network. For NetBIOS to work between computers, the computers must have the same NetBIOS scope identifier and unique computer names.

    The use of NetBIOS scopes in names is a legacy configuration. It shouldn't be used with Active Directory forests. For more information about NetBIOS scopes, see the following web sites:

  - [rfc1001](https://www.ietf.org/rfc/rfc1001.txt)
  - [rfc1002](https://www.ietf.org/rfc/rfc1002.txt)

### DNS host names

- Allowed characters

    DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they are used to delimit the components of domain style names.

    In the Windows 2000 domain name system (DNS) and the Windows Server 2003 DNS, Unicode characters are supported. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS.

    For more information, see the following websites:

  - [rfc952](https://www.ietf.org/rfc/rfc952.txt)
  - [rfc1123](https://www.ietf.org/rfc/rfc1123.txt)

- Disallowed characters

    DNS host names can't contain the following characters:

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
  - white space (blank)

    The underscore has a special role. It is permitted for the first character in SRV records by RFC definition. But newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).

    More rules are:

  - All characters preserve their case formatting except for American Standard Code for Information Interchange (ASCII) characters.
  - The first character must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.
  - Two-character SDDL user strings that are listed in [well-known SIDs list](/windows/win32/secauthz/sid-strings) can't be used. Otherwise, _import_, _export_, and _take control_ operations fail.

    In Windows 2000 and later versions of Windows, computers that are members of an Active Directory domain can't have names that are composed completely of numbers. This restriction is because of DNS restrictions.

    > [!NOTE]
    > DNS Host Name Registration substitutes a hyphen (-) character for invalid characters.

- Minimum name length: 2 characters

- Maximum name length: 63 characters

    The maximum length of the host name and of the fully qualified domain name (FQDN) is 63 bytes per label and 255 bytes per FQDN.

    > [!NOTE]
    > Windows doesn't permit computer names that exceed 15 characters, and you can't specify a DNS host name that differs from the NETBIOS host name. You might however create host headers for a web site hosted on a computer and that is then subject to this recommendation.

    In Windows 2000 and Windows Server 2003, the maximum host name and the FQDN use the standard length limitations that are mentioned earlier, with the addition of UTF-8 (Unicode) support. Because some UTF-8 characters exceed one octet in length, you can't determine the size by counting the characters.

    Domain controllers must have an FQDN of less than 155 bytes.

- Reserved names per RFC 952

  - -GATEWAY
  - -GW
  - -TAC

    For more information, see [rfc952](https://tools.ietf.org/html/rfc952).

- Reserved names in Windows

    See [Table of reserved words](#table-of-reserved-words).

- Best practices

    When you create names for the DNS computers in a new Windows Server 2003 DNS infrastructure, use the following guidelines:

  - Choose computer names that are easy for users to remember.
  - Identify the owner of the computer in the computer name.
  - Choose a name that describes the purpose of the computer.
  - For ASCII characters, don't use character case to indicate the owner or the purpose of a computer. For ASCII characters, DNS is not case-sensitive, Windows and Windows applications are not case-preserving in all places.
  - Match the Active Directory domain name to the primary DNS suffix of the computer name. For more information, see the [Disjointed namespaces](#disjointed-namespaces) section below.
  - Use a unique name for every computer in your organization. Avoid the same computer name for computers in different DNS domains.
  - Use ASCII characters. This guarantees interoperability with computers that are running versions of Windows that are earlier than Windows 2000.
  - In DNS computer names, use only the characters that are listed in RFC 1123. These characters include A-Z, a-z, 0-9, and the hyphen (-). In Windows Server 2003, DNS allows most UTF-8 characters in names. Don't use extended ASCII or UTF-8 characters unless all the DNS servers in your environment support them.

## Domain names

Here are details for NetBIOS domain names and DNS domain names.

### NetBIOS domain names

- Allowed characters

    NetBIOS domain names can contain all alphanumeric characters except for the extended characters that are listed in **Disallowed characters**. Names can contain a period, but names can't start with a period.

- Disallowed characters

    NetBIOS computer names can't contain the following characters:

  - backslash (\\)
  - slash mark (/)
  - colon (:)
  - asterisk (*)
  - question mark (?)
  - quotation mark (")
  - less than sign (<)
  - greater than sign (>)
  - vertical bar (|)
  
    Names can contain a period (.). But the name can't start with a period. The use of non-DNS names with periods is allowed in Microsoft Windows NT. Periods shouldn't be used in Active Directory domains. If you are upgrading a domain whose NetBIOS name contains a period, change the name by migrating the domain to a new domain structure. Do not use periods in new NetBIOS domain names.

     In Windows 2000 and later versions of Windows, computers that are members of an Active Directory domain can't have names that are composed completely of numbers. This restriction is because of DNS restrictions.

- Minimum name length: 1 character

- Maximum name length: 15 characters.

    > [!NOTE]
    > The 16th character is reserved to identify the functionality that is installed on the registered network device.

- Reserved names in Windows

    See [Table of reserved words](#table-of-reserved-words).

    The names of an upgraded domain can include a reserved word. However, trust relationships with other domains fail in this situation.

- Special characters: Period (.).

    A period character separates the name into a NetBIOS scope identifier and the computer name. The NetBIOS scope identifier is an optional string of characters that identify logical NetBIOS networks that run on the same physical TCP/IP network. For NetBIOS to work between computers, the computers must have the same NetBIOS scope identifier and unique computer names.

    > [!WARNING]
    > The use of NetBIOS scopes in names is a legacy configuration. It shouldn't be used with Active Directory forests. There is no inherent problem with this, but there may be applications that filter the name and assume a DNS name when a period is found.

### DNS domain names

- Allowed characters

    DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they are used to delimit the components of domain style names.

    In the Windows 2000 domain name system (DNS) and the Windows Server 2003 DNS, Unicode characters are supported. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS.

    For more information, visit the following web sites:

  - [rfc952](https://www.ietf.org/rfc/rfc952.txt)
  - [rfc1123](https://www.ietf.org/rfc/rfc1123.txt)

- Disallowed characters

    DNS domain names can't contain the following characters:

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
  - white space (blank)

    The underscore has a special role. It's permitted for the first character in SRV records by RFC definition. But newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).

    When promoting a new domain, you get a warning that an underscore character might cause problems with some DNS servers. But it still lets you create the domain.

    More rules are:

  - All characters preserve their case formatting except for ASCII characters.
  - The first character must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.

- Minimum name length: 2 characters

- Maximum name length: 255 characters

    The maximum length of the host name and of the fully qualified domain name (FQDN) is 63 bytes per label and 255 characters per FQDN. The latter is based on the maximum path length possible with an Active Directory Domain name with the paths needed in `SYSVOL`, and it needs to obey to the 260 character `MAX_PATH` limitation.

    An example path in `SYSVOL` contains:

    `\\<FQDN domain name>\sysvol\<FQDN domain name>\policies\{<policy GUID>}\[user|machine]\<CSE-specific path>`

    The \<CSE-specific path> might contain user input such as the logon script file name, thus it can also reach a significant length.

    The AD FQDN domain name appears in the path twice, due to that the length of an AD FQDN domain name is restricted to 64 characters.

    In Windows 2000 and Windows Server 2003, the maximum host name and the FQDN use the standard length limitations that are mentioned earlier, with the addition of UTF-8 (Unicode) support. Because some UTF-8 characters exceed one octet in length, you can't determine the size by counting the characters.

- Single-label domain namespaces

    Single-label DNS names are names that don't contain a suffix, such as `.com`, `.corp`, `.net`, `.org`, or *`companyname`*. For example, _host_ is a single-label DNS name. Most Internet registrars don't allow the registration of single-label DNS names.

    Generally, we recommend that you register DNS names for internal and external namespaces with an Internet registrar. This includes the DNS names of Active Directory domains, unless such names are subdomains of DNS names that are registered by your organization name. For example, `corp.example.com` is a subdomain of `example.com`. Registering your DNS name with an Internet registrar may help prevent a name collision. A name collision may occur if another organization tries to register the same DNS name, or if your organization merges with another organization that uses the same DNS name.

    Problems that are associated with single-label namespaces include:

  - Single-label DNS names can't be registered by using an Internet registrar.
  - Domains that have single-label DNS names require additional configuration.
  - The DNS Server service may not be used to locate domain controllers in domains that have single-label DNS names.
  - By default, Windows Server 2003-based domain members, Windows XP-based domain members, and Windows 2000-based domain members don't perform dynamic updates to single-label DNS zones.

    For more information, see [Deployment and operation of Active Directory domains that are configured by using single-label DNS names](https://support.microsoft.com/help/300684).

- Reserved names

    See [Table of reserved words](#table-of-reserved-words).

    Don't use top-level Internet domain names on the intranet, such as `.com`, `.net`, and `.org`. If you use top-level Internet domain names on the intranet, computers on the intranet that are also connected to the Internet may experience resolution errors.

#### Disjointed namespaces

A disjointed namespace occurs when a computer's primary DNS suffix doesn't match the DNS domain of which it is a member. For example, a disjointed namespace occurs when a machine that has the DNS name of `dc1.contosocorp.com` is in a domain that has the DNS name of `contoso.com`.

**How disjointed namespaces occur:**

1. A Windows NT 4.0 primary domain controller is upgraded to a Windows 2000 domain controller by using the original release version of Windows 2000. In the Networking item in Control Panel, multiple DNS suffixes are defined.

2. The domain is renamed when the forest is at the Windows Server 2003 forest functional level. And the primary DNS suffix isn't changed to reflect the new DNS domain name.

**Effects of a disjointed namespace:**

Suppose a domain controller named _DC1_ resides  in a Windows NT 4.0 domain whose NetBIOS domain name is contoso. This domain controller is upgraded to Windows 2000. When this upgrade occurs, the DNS domain is renamed `contoso.com`. In the original release version of Windows 2000, the upgrade routine clears the check box that links the primary DNS suffix of the domain controller to its DNS domain name. So, the primary DNS suffix of the domain controller is the Windows NT 4.0 DNS suffix that was defined in the Windows NT 4.0 suffix search list. In this example, the DNS name is `DC1.northamerica.contoso.com`.

The domain controller dynamically registers its service location (SRV) records in the DNS zone that corresponds to its DNS domain name. However, the domain controller registers its host records in the DNS zone that corresponds to its primary DNS suffix.

For more information about a disjoint namespace, see the following articles:

- [Event IDs 5788 and 5789 occur on a Windows-based computer](https://support.microsoft.com/kb/258503)

- [Create a Disjoint Namespace](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731929(v=ws.10))

### Other factors

- Forests that are connected to the Internet

    A DNS namespace that is connected to the Internet must be a subdomain of a top-level or second-level domain of the Internet DNS namespace.

- Maximum number of domains in a forest

    In Windows 2000, the maximum number of domains in a forest is 800. In Windows Server 2003 and later versions, the maximum number of domains at Forest Functional Level 2 is 1200. This restriction is a limitation of multivalued non-linked attributes in Windows Server 2003.

- Best practices

  - The DNS names of all the nodes that require name resolution include the Internet DNS domain name for the organization. So, choose an Internet DNS domain name that is short and easy to remember. Because DNS is hierarchical, DNS domain names grow when you add subdomains to your organization. Short domain names make the computer names easy to remember.

  - If the organization has an Internet presence, use names that are relative to the registered Internet DNS domain name. For example, if you have registered the Internet DNS domain name `contoso.com`, use a DNS domain name such as `corp.contoso.com` for the intranet domain name.

  - Don't use the name of an existing corporation or product as your domain name. You can run into a name collision later on.

  - Avoid a generic name like maybe domain.localhost. Another company you merge with in a few years might follow the same thinking.

  - Don't use an acronym or an abbreviation as a domain name. Users may have difficulty recognizing the business unit that an acronym represents.

  - Avoid the use of underscores (_) in domain names. Applications might be very RFC obedient and reject the name, and will not install or work in your domain. And you might experience problems with older DNS servers.

  - Don't use the name of a business unit or of a division as a domain name. Business units and other divisions will change, and these domain names can be misleading or become obsolete.

  - Don't use geographic names that are difficult to spell and remember.

  - Avoid extending the DNS domain name hierarchy more than five levels from the root domain. You can reduce administrative costs by limiting the extent of the domain name hierarchy.

  - If you are deploying DNS in a private network, and you don't plan to create an external namespace, register the DNS domain name that you create for the internal domain. Otherwise, you may find that the name is unavailable if you try to use it on the Internet, or if you connect to a network that is connected to the Internet.

## Site names

We recommend that you use a valid DNS name when you create a new site name. Otherwise, your site will be available only where a Microsoft DNS server is used. For more information about valid DNS names, see the [DNS host names](#dns-host-names) section.

- Allowed characters

    DNS names can contain only alphabetical characters (A-Z), numeric characters (0-9), the minus sign (-), and the period (.). Period characters are allowed only when they are used to delimit the components of domain style names.

    In the Windows 2000 domain name system (DNS) and the Windows Server 2003 DNS, Unicode characters are supported. Other implementations of DNS don't support Unicode characters. Avoid Unicode characters if queries will be passed to the servers that use non-Microsoft implementations of DNS.

    For more information, visit the following web sites:

  - [rfc952](https://www.ietf.org/rfc/rfc952.txt)
  - [rfc1123](https://www.ietf.org/rfc/rfc1123.txt)

- Disallowed characters

    DNS names can't contain the following characters:

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
  - white space (blank)

    The underscore has a special role. It's permitted for the first character in SRV records by RFC definition. But newer DNS servers may also allow it anywhere in a name. For more information, see [Complying with Name Restrictions for Hosts and Domains](/previous-versions/windows/it-pro/windows-2000-server/cc959336(v=technet.10)).

    More rules are:

  - All characters preserve their case formatting except for ASCII characters.
  - The first character must be alphabetical or numeric.
  - The last character must not be a minus sign or a period.

- Minimum name length: 1 character

- Maximum name length: 63 characters

    The maximum length of the DNS name is 63 bytes per label.

    In Windows 2000 and Windows Server 2003, the maximum host name and the FQDN use the standard length limitations that are mentioned earlier, with the addition of UTF-8 (Unicode) support. Because some UTF-8 characters exceed one octet in length, you can't determine the size by counting the characters.

## OU names

- Allowed characters

    All characters are allowed, even extended characters. Although Active Directory Users and Computers lets you name an OU with extended characters, we recommend that you use names that describe the purpose of the OU and that are short enough to easily manage. Lightweight Directory Access Protocol (LDAP) doesn't have any restrictions, because the CN of the object is put in quotation marks.

- Disallowed characters

    No characters are not allowed.

- Minimum name length: 1 character

- Maximum name length: 64 characters

### Special issues

When the OU at the domain root level has the same name as a future child domain, you might experience database problems. Consider a scenario where you delete an OU named _marketing_ to create a child domain with the same name, for example, `marketing.contoso.com` (leftmost label of the child domain FQDN name has the same name).

The OU is deleted and during the tombstone lifetime of the OU you create a child domain that has the same name is created, deleted, and created again. In this scenario, a duplicate record name in the ESE database causes a phantom-phantom name collision when the child domain is re-created. This problem prevents the configuration container from replicating.

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
|INTERACTIVE|X|X|X|X|
|ENTERPRISE||| |X|
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
