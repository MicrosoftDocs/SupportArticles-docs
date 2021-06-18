---
title: 550 5.7.1 Message rejected due to content restrictions in Exchange Online Protection
description: Describes the 550 5.7.1 non-delivery report that's returned when you send email to external recipients in Exchange Online Protection. Provides a solution.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- 'Associated content asset: 4555314'
ms.reviewer: rymcgrat, romccart
appliesto: 
- Exchange Online Protection
- Exchange Online
search.appverid: MET150
---

# "550 5.7.1 Message rejected due to content restrictions" when you send email to external recipients in Exchange Online Protection

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;3024906

## Problem

When an Office 365 or Exchange Online Protection user tries to send email to external recipients, the user receives the following non-delivery report (NDR):

> 550 5.7.1 Message rejected due to content restrictions

## Solution

To resolve this issue, the sender or the associated administrator must contact either the recipient or the vendor of the recipient's anti-spam solution for additional analysis. In this situation, an anti-spam solution provider will typically update its signatures or provide a detailed explanation about why the email is being blocked.

## More information

This is not an issue that's caused by, or rooted in, Office 365 or Exchange Online Protection itself.

The sender has probably landed on a third-party anti-spam product's signature list. This may be caused by nonstandard email practices such as a failure to audit mailing lists. Recipients of these email messages have previously submitted those email messages as spam to their anti-spam product vendor. The vendor then added an identifier that's unique to the sender to its anti-spam definitions. It's this identifier that's now blocking the email.

Most frequently, the detection is triggered by something in the email signature. This might be a URL, domain name, or telephone number.

We recommend that you confirm the cause by sending a test email message to the same recipient after you completely remove the signature. If the email message is delivered without issue, you can confirm that a component or characteristic of the signature is causing the blocked email.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
