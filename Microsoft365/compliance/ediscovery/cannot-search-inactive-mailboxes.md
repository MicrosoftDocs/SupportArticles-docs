---
title: Can't search inactive mailboxes
description: Describes an issue in which no inactive mailboxes are listed when you run an In-Place eDiscovery search. Occurs if your user account is a member of the Discovery Management role group but isn't a member of the Organization Management role group.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: umeshk
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 03/31/2022
---
# You can't search inactive mailboxes in Exchange Online

_Original KB number:_ &nbsp; 2898413

## Problem

You want to use In-Place eDiscovery to search the contents of inactive mailboxes in your Microsoft Exchange Online organization. However, after you select **Specify mailboxes to search** on the Mailboxes page of the Exchange admin center, no inactive mailboxes are listed.

## Cause

This issue occurs if the Microsoft 365 user account that you're using to search is a member of the Discovery Management role group but is not a member of the Organization Management role group.

## Workaround

To work around this issue, add the View-Only Recipients role to the Discovery Management role group.

## Status

This is a known issue. Microsoft is working to address the issue and will post more information in this article when it becomes available.

## More information

For more info about inactive mailboxes, go to [Manage inactive mailboxes in Exchange Online](/microsoft-365/security/office-365-security/exchange-online-protection-overview).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
