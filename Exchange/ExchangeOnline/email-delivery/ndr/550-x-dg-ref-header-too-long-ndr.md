---
title: NDR error 550 5.0.350 550 x-dg-ref header is too long
description: Fixes an issue in which you can't send mail and you receive a 550 x-dg-ref header is too long non-delivery report when you use Rich Text formatting in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: braalf, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 x-dg-ref header is too long" when sending mail in Exchange Online

_Original KB number:_ &nbsp; 4467875

## Symptoms

When you send mail from Outlook in Exchange Online, you receive a non-delivery report (NDR) that resembles the following:

> 550 5.0.350 Remote server returned an error -> 550 x-dg-ref header is too long.

## Cause

This issue occurs if you use **Rich Text** formatting in Outlook and the message has at least one attachment. The attachment may also be nested so that it contains another attached message.

## Resolution

To resolve this issue so that the message can be delivered successfully, select the **HTML** option instead of **Rich Text Format** when you compose email messages.

The **HTML** option prevents the attachment from being part of the Transport Neutral Encapsulation Format (TNEF) header.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
