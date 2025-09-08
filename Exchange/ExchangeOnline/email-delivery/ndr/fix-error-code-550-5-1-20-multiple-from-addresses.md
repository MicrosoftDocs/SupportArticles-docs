---
title: NDR error code 550 5.1.20 (Multiple From addresses are not allowed without Sender address)
description: Provides a fix for NDR 550 5.1.20.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 189465
ms.reviewer: iamcdo, stanalek, arindamt, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/18/2024
---

# NDR error code 550 5.1.20 "Multiple From addresses are not allowed without Sender address"

This NDR is generated if an email message has multiple email addresses in the **From** field, but no email address in the **Sender** field. For more information, see [RFC 5322 - Originator fields](https://www.rfc-editor.org/rfc/rfc5322.html#section-3.6.2).

## How do I fix this?

In general, don't send email messages that have multiple addresses in the **From** field because many email clients don't support this configuration. Email messages that have multiple email addresses in the **From** field are rare.

If you must send a message that has multiple email addresses in the **From** field, make sure that you have a single email address in the **Sender** field. If you're unsure about how to configure your message correctly, ask your email admin.
