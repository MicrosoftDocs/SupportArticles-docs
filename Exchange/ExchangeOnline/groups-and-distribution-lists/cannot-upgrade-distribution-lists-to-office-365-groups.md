---
title: Cannot upgrade distribution lists to Office 365 groups
description: If a custom email address policy is applied to the tenant for your distribution lists, the distribution lists can't be upgraded to Office 365 groups.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: subansal, ninob
appliesto:
- Exchange Online
- MSfC O365-Exchange Online
search.appverid: MET150
---
# Unable to upgrade distribution lists to Office 365 groups

_Original KB number:_ &nbsp; 4481100

## Symptoms

You can't upgrade your distribution lists (which are also known as distribution groups) to Office 365 groups.

## Cause

This issue occurs if a custom email address policy is applied to the tenant for the Office 365 groups.

## Resolution

To resolve this issue, you have to remove the email address policy for the distribution groups. Then, try again to upgrade the distribution lists to Office 365 groups. For more information about how to remove the email address policy, see [Remove an email address policy](/exchange/remove-an-email-address-policy-exchange-2013-help).

For more information about how to upgrade distribution lists, see [Upgrade distribution lists to Office 365 Groups in Outlook](/microsoft-365/admin/manage/upgrade-distribution-lists?view=o365-worldwide&preserve-view=true).
