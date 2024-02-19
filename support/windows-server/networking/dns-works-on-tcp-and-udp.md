---
title: DNS works on both TCP and UDP
description: Explains why some services use both the protocols TCP and UDP.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-nirmsh
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# DNS or other Services works on both TCP and UDP

This article explains why some services use both the protocols TCP and UDP.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556000

## SUMMARY

DNS and some other services work on both the protocols. We'll take an example of DNS Service. Two protocols are different from each other. TCP is a connection-oriented protocol and it requires data to be consistent at the destination and UDP is connection-less protocol and doesn't require data to be consistent or don't need a connection to be established with host for consistency of data.

UDP packets are smaller in size. UDP packets can't be greater than 512 bytes. So any application needs data to be transferred greater than 512 bytes require TCP in place. For example, DNS uses both TCP and UDP for valid reasons described below. UDP messages aren't larger than 512 Bytes and are truncated when greater than this size. DNS uses TCP for Zone transfer and UDP for name, and queries either regular (primary) or reverse. UDP can be used to exchange small information whereas TCP must be used to exchange information larger than 512 bytes. If a client doesn't get response from DNS, it must retransmit the data using TCP after 3-5 seconds of interval.

There should be consistency in DNS Zone database. To make this, DNS always transfers Zone data using TCP because TCP is reliable and make sure zone data is consistent by transferring the full zone to other DNS servers who has requested the data.

The problem occurs when Windows 2000 server and Advanced Server products uses Dynamic ports for all above 1023. In this case, your DNS server should not be internet facing that is, doing all standard queries for client machines on the network. The router (ACL) must permitted all UDP inbound traffic to access any high UDP ports for it to work.

LDAP always uses TCP - this is true and why not UDP because a secure connection is established between client and server to send the data and this can be done only using TCP not UDP. UDP is only used when finding a domain controller (Kerberos) for authentication. For example, a domain client finding a domain controller using DNS.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]

