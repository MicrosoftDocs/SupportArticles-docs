---
title: Office 365 groups not visible from shared mailbox
description: Describes a scenario where Office 365 groups aren't visible from a shared mailbox. Provides a workaround.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: alinastr
appliesto:
- Exchange Online
search.appverid: MET150
---
# Office 365 groups aren't visible from a shared mailbox

_Original KB number:_ &nbsp; 3191498

## Symptoms

A profile for an Office 365 shared mailbox can't see any Office 365 groups in Microsoft Outlook or Outlook on the web. This issue occurs even though the shared mailbox is a member of the Office 365 group.

## Cause

This behavior is by design. Office 365 groups don't support explicit logon, and shared mailboxes don't have an enabled user account that's used for logging on.

## Workaround

To work around this issue, convert the shared mailbox to a regular mailbox. For information about how to do this, see [Convert a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/convert-a-mailbox).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
