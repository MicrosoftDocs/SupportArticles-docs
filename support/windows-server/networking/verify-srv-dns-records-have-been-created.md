---
title: Verify that SRV Domain Name System (DNS) records have been created
description: Describes how to verify Service Location (SRV) locator resource records for a domain controller after you install the Active Directory directory service.
ms.date: 01/04/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# How to verify that SRV DNS records have been created for a domain controller

This article describes how to verify Service Location (SRV) locator resource records for a domain controller after you install the Active Directory directory service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816587

## Summary

The SRV record is a Domain Name System (DNS) resource record. It's used to identify computers hosting specific services. SRV resource records are used to locate domain controllers for Active Directory. To verify SRV locator resource records for a domain controller, use one of the following methods.

## Method 1: Use DNS Manager

After you install Active Directory on a server that's running the DNS service, you can use the DNS Management Console to verify that the appropriate zones and resource records are created for each DNS zone.

Active Directory creates its SRV records in the following folders, where \<Domain_Name> is the name of your domain:

- `Forward Lookup Zones/Domain_Name/_msdcs/dc/_sites/Default-First-Site-Name/_tcp`
- `Forward Lookup Zones/Domain_Name/_msdcs/dc/_tcp`

In these locations, an SRV record should appear for the following services:

- _kerberos
- _ldap

## Method 2: View Netlogon.dns

If you're using non-Microsoft DNS servers to support Active Directory, you can verify SRV locator resource records by viewing Netlogon.dns. Netlogon.dns is located in the `%systemroot%\System32\Config` folder. You can use a text editor, such as Notepad, to view this file.

The first record in the file is the domain controller's Lightweight Directory Access Protocol (LDAP) SRV record. This record should appear similar to the following one:

`_ldap._tcp. <Domain_Name>`

## Method 3: Use `Nslookup`

`Nslookup` is a command-line tool that displays information you can use to diagnose Domain Name System (DNS) infrastructure.

To use `Nslookup` to verify the SRV records, follow these steps:

1. On your DNS, select **Start** > **Run**.
2. In the **Open** box, type `cmd`.
3. Type `nslookup`, and then press ENTER.
4. Type `set type=all`, and then press ENTER.
5. Type `_ldap._tcp.dc._msdcs.Domain_Name`, where \<Domain_Name> is the name of your domain, and then press ENTER.

`Nslookup` returns one or more SRV service location records that appear in the following format, where \<Server_Name> is the host name of a domain controller, and where \<Domain_Name> is the domain where the domain controller belongs to, and \<Server_IP_Address> is the domain controller's Internet Protocol (IP) address:

```console
Server: localhost
Address: 127.0.0.1
_ldap._tcp.dc._msdcs.Domain_Name
SRV service location:
priority= 0
weight= 100
port= 389 srv hostname= Server_Name . Domain_Name Server_Name . Domain_Name internet address = Server_IP_Address
```

For more information about the SRV records that are registered by Netlogon, see [SRV Records Registered by NetLogon](https://social.technet.microsoft.com/wiki/contents/articles/7608.srv-records-registered-by-net-logon.aspx).
