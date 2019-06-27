---
title: Cautions against bypassing Office 365 spam filters.
description: Describes cautions against bypassing Office 365 spam filters.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: o365-proplus-itpro
ms.topic: article
ms.author: v-zht
---

# Cautions against bypassing Office 365 spam filters

## Summary

This article discusses why you should not bypass spam filters in Microsoft Office 365. This article applies to both users and administrators who do the following:

- Enable Allow or Block lists in Spam Filter policies.
- Skip scanning in Transport Rules.
- Enable Safe and Blocked senders in Outlook or Outlook on the Web.

If you use these lists or options, consider the following guidelines:

- We recommend that you do not use these features because they may override the verdict that is set by Office 365 spam filters. Instead, we suggest that you [report junk email messages to Microsoft](https://docs.microsoft.com/office365/SecurityCompliance/report-junk-email-messages-to-microsoft) for analysis to help reduce the number and effect of future junk email messages.
- If you have to set bypassing, you should do this carefully because Microsoft will honor your configuration request and potentially let harmful messages pass through. Additionally, bypassing should be done only on a temporary basis. This is because spam filters can evolve, and verdicts could improve over time.
- It is very important that you take the following precautions:
    - Never put domains that you own onto the Allow and Block lists.
    - Never put common domains, such as microsoft.com and office.com, onto the Allow and Block lists.
    - Do not keep domains on the lists permanently unless you disagree with the verdict of Microsoft.