---
title: 550-DKIM NDR when send emails to an external domain.
description: Describes an issue in which Office 365 users receive NDRs that contain 550.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: divyarp, romccart
appliesto:
- Exchange Online
- Exchange Online Protection
search.appverid: MET150
---

# "550-DKIM" NDR error when Office 365 users send mail to an external domain

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_ &nbsp; 3145666

## Problem

When Office 365 users try to send email messages to one or more external domains, they receive one or more nondelivery reports (NDRs) that contain one of the following error codes:

>550-DKIM: encountered the following problem validating
>
>550 contoso.onmicrosoft.com: signature_incorrect
>
>550-dkim:Bodyhash_mismatch

This issue may occur if the recipient domain doesn't comply with Domain Keys Identified Mail (DKIM) RFC 6376.

## Solution

Do one of the following:

- Recommended method: Enable DKIM by creating a CNAME record for your domain in Office 365. For more information, see [Use DKIM to validate outbound email sent from your custom domain in Office 365](/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email?preserve-view=true&view=o365-worldwide).
- Contact the recipient domain and suggest that they comply with DKIM RFC 6376. Consider the message to be unsigned if a DKIM authentication failure occurs.

## More information

For more information about DKIM RFC 6376, see [http://www.rfc-editor.org/rfc/rfc6376.txt](http://www.rfc-editor.org/rfc/rfc6376.txt).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).