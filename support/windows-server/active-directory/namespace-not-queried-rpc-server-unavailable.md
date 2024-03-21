---
title: Fail to create a DFS namespace
description: Provides a solution to an error that occurs when you create a DFS namespace.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, randt
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Error when you attempt to create a DFS namespace: The namespace cannot be queried. The RPC server is unavailable

This article provides a solution to an error that occurs when you create a DFS namespace.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2021914

## Symptoms

You may receive the following error when attempting to create a DFS namespace on a Windows Server 2008 computer:

> The namespace cannot be queried. The RPC server is unavailable.

This issue is typically seen in an environment using a third-party DNS server.

## Cause

This error can occur when no DomainDNSName records are registered for the domain. These records are updated by the Netlogon service on domain controllers. These are the *same as parent* A records in domain's forward lookup zone.

The following documentation indicates these records are not a requirement and are only used for DNS clients that do not understand SRV records:  
[How DNS Support for Active Directory Works](/previous-versions/windows/it-pro/windows-server-2003/cc759550(v=ws.10)).

DnsDomainName:

Enables a non-SRV-aware client to locate any domain controller in the domain by looking up an A record. A name in this form is returned to the LDAP client through an LDAP referral. A non-SRV-aware client looks up the name; an SRV-aware client looks up the appropriate SRV resource record.

In a network trace, you will see a DNS lookup for the DomainDNSname A record and the DNS server will respond with the SOA record if these A records do not exist.

DNS lookup query:

> Dns: QueryId = 0x887C, QUERY (Standard query), Query for adatum.com of type Host Addr on class Internet  
QRecord: adatum.com of type Host Addr on class Internet

Response with the SOA record:

> Dns: QueryId = 0x887C, QUERY (Standard query), Response - Success  
QRecord: adatum.com of type Host Addr on class Internet  
AuthorityRecord: adatum.com of type SOA on class Internet: PrimaryNameServer: adadc1.adatum.com, AuthoritativeMailbox: hostmaster.adatum.com

## Resolution

Update the A records on the DNS server, or create a HOSTS file on the Windows Server 2008 computer that includes the fully qualified name and the IP addresses of the domain controller.

Sample HOSTS file:

> adatum.com      192.168.2.10  
adatum.com      192.168.3.10  
adatum.com      192.168.4.10
