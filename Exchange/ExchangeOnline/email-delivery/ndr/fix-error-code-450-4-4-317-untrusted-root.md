---
title: NDR error code 450 4.4.317 (Cannot connect to remote server [Message=UntrustedRoot])
description: Provides a fix for NDR 450 4.4.317.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 189299
ms.reviewer: iamcdo, stanalek, arindamt, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/17/2024
---

# NDR error code 450 4.4.317 "Cannot connect to remote server [Message=UntrustedRoot]"

This NDR is generated in the following scenarios:

- Exchange Online connects to a remote email server, also known as a remote message transfer agent (MTA), to send an email message to an external recipient. During the TLS handshake, the remote MTA sends only a leaf certificate to Exchange Online without including the certificates of the intermediate certification authorities (CAs). If Exchange Online can't validate the authenticity of the certificate by building the chain to a [Microsoft-trusted root CA](/security/trusted-root/release-notes), it generates an NDR for the sender.

- A remote MTA connects to Exchange Online to send an email message to an Exchange Online recipient. During the TLS handshake, the remote MTA sends only a leaf certificate to Exchange Online without including the certificates of the intermediate CAs. If Exchange Online can't validate the authenticity of the certificate by building the chain to a Microsoft-trusted root CA, it rejects the email message. The remote MTA then generates an NDR for the sender.

Exchange Online doesn't fetch intermediate certificates on–demand. Therefore, a remote MTA that provides a certificate should include the full certificate chain.

> [!NOTE]
> MTAs that are managed by Exchange Online always provide the full certificate chain.

## How do I fix this?

If you're a user, contact your email admin.

If you're an email admin in the remote MTA organization, configure your remote MTA to provide the full certificate chain.

If you're an email admin in the Exchange Online organization, notify an email admin in the remote MTA organization about the NDR.
