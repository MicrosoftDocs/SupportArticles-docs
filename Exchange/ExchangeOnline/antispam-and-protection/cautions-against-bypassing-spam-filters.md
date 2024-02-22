---
title: Cautions against bypassing Microsoft 365 spam filters.
description: Describes cautions against bypassing Microsoft 365 spam filters.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Cautions against bypassing Microsoft 365 spam filters

## Summary

This article discusses why you shouldn't bypass spam filters in Microsoft 365. This article applies to both users and administrators who do the following:

- [Manage the Tenant Allow/Block List](/microsoft-365/security/office-365-security/tenant-allow-block-list?view=o365-worldwide&preserve-view=true).
- Enable Allow or block lists in [Spam Filter policies](/microsoft-365/security/office-365-security/configure-your-spam-filter-policies?view=o365-worldwide&preserve-view=true).
- Skip scanning in Transport Rules.
- Enable Safe and Blocked senders in Outlook or [Outlook on the Web](https://support.microsoft.com/office/block-senders-or-unblock-senders-in-outlook-on-the-web-9bf812d4-6995-4d19-901a-76d6e26939b0).

If you use these lists or options, consider the following guidelines:

- We recommend that you don't use these features because they may override the verdict that is set by Microsoft 365 spam filters. Instead, we suggest that you [report junk email messages to Microsoft](/office365/SecurityCompliance/report-junk-email-messages-to-microsoft) for analysis to help reduce the number and effect of future junk email messages.
- If you have to set bypassing, you should do this carefully because Microsoft will honor your configuration request and potentially let harmful messages pass through. Additionally, bypassing should be done only on a temporary basis. This is because spam filters can evolve, and verdicts could improve over time.
- It's important that you take the following precautions:

  - Never put domains that you own onto the Allow and blocklists.
  - Never put common domains, such as microsoft.com and office.com, onto the Allow and blocklists.
  - Don't keep domains on the lists permanently unless you disagree with the verdict of Microsoft.

For more information, see the various methods available to create [safe sender](/office365/securitycompliance/create-safe-sender-lists-in-office-365) and [block sender](/office365/securitycompliance/create-block-sender-lists-in-office-365) lists and when to use them.
