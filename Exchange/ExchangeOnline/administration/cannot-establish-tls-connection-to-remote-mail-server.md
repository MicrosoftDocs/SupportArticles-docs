---
title: Cannot establish TLS connection to remote mail server
description: Describes an issue in which TLS negotiation fails because the signature algorithm in the remote mail server's certificate chain is not secure. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: sesteven, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Online
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't establish a TLS connection to a remote mail server in Exchange Online or Exchange Server

_Original KB number:_ &nbsp; 3027536

## Symptoms

You can't establish a Transport Layer Security (TLS) connection to a remote mail server by using the following services and applications:

- Microsoft Exchange Online
- Microsoft Exchange Server 2016
- Microsoft Exchange Server 2013
- Microsoft Exchange Server 2010

For example, in Exchange Server, you see messages in the message queue that are in a Retry state.

## Cause

This issue occurs if a nonsecure signature algorithm is used in the remote mail server's certificate chain. When TLS 1.2 is enabled on servers that are running Exchange Server, additional security checks are introduced during a TLS negotiation. This means that the remote mail server's certification chain is subject to checks for nonsecure signature algorithms. If a certificate in the certificate chain uses MD5 or MD2 hash algorithms, TLS negotiation fails.

Analysis of the certificate chain that's sent by the remote mail server shows that a nonsecure algorithm is used.

## Resolution

To resolve this problem, update the certificate on the remote mail server.

## More information

To work around this problem, you can configure the remote server not to advertise until the certificate can be updated. However, in this configuration, no connection to the server will be encrypted.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
