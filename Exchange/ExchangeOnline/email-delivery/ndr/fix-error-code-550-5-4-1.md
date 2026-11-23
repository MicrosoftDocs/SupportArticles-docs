---
title: Fix NDR error 550 5.4.1 in Exchange Online
ms.date: 10/02/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: arindamt
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
  - CI 12713
  - CI 13055
search.appverid:
- BCS160
- MOE150
- MET150
description: Learn how to fix email issues for error code 550 5.4.1 Recipient address rejected; Access denied.
---

# Fix NDR error "550 5.4.1" in Exchange Online

## Summary

This article describes what you can do if you see error code 550 5.4.1 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). This automated notification displays when the recipient's email address is invalid.

## Why did I get this bounce message?

You receive the following NDR error message:

> 550 5.4.1 Recipient address rejected: Access denied

The NDR is generated when [directory-based edge blocking](/exchange/mail-flow-best-practices/use-directory-based-edge-blocking) in Microsoft Exchange Online blocks an incoming email message because the recipient's email address is invalid.

## How do I fix this?

If you're an email administrator in the recipient's organization, follow these steps until the issue is fixed:

1. Check the spelling of the recipient's email address in the NDR.
2. Determine whether the issue affects only one recipient or everyone in the recipient's domain. For example, if an email message to "alina@contoso.com" triggers the NDR, check whether messages that are sent to other recipients in the "contoso.com" domain also trigger the NDR.
3. If the issue affects all recipients in the domain, follow these steps to resync the domain:

   1. In the Exchange admin center, select **Mail flow** &gt; **Accepted domains**, and then select the affected domain.
   2. In the flyout pane for the domain, switch the domain type from **Authoritative** to **Internal relay**, and then switch back to **Authoritative**. For more information, see [Manage accepted domains in Exchange Online](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains).

4. If the issue is limited to a specific recipient who has an on-premises user mailbox in an Exchange hybrid environment, and your organization uses directory sync to push changes to Microsoft Entra ID, reset the SMTP proxy address of the recipient's mailbox. To reset, change the proxy address to a temporary address, and then revert it to the original proxy address.

   [!NOTE]
  > When you make changes to the on-premises mailbox, allow up to 24 hours for directory-based edge blocking to fully update.

5. If the issue is limited to a specific recipient that's an on-premises mail-enabled public folder in an Exchange hybrid environment, verify that the folder is synced to Exchange Online. If the folder doesn't appear in Exchange Online, use the [Sync-ModernMailPublicFolder](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-public-folder-migration-scripts-with-modern/ba-p/3382800) PowerShell script to copy your on-premises mail-enabled public folders to Exchange Online.
6. If the issue is limited to a specific recipient that's an on-premises dynamic distribution group in an Exchange hybrid environment, create a mail contact in Exchange Online that has the same external email address as the dynamic distribution group. An on-premises dynamic distribution group in a hybrid environment can't be synced to Exchange Online.

[!NOTE]
> When you set up an Exchange environment, we recommend that you temporarily set the accepted domain type to **Internal Relay**. After you add all intended recipients to Exchange Online and they are fully replicated, change the domain type to **Authoritative** to block all messages to recipient SMTP addresses that aren't in Exchange Online.
