---
title: Outlook disconnected after enabling modern authentication
description: Describes an issue in which Outlook cannot connect to a Microsoft 365 mailbox that does not match the account that users use to sign in to the mailbox.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
- Microsoft 365
search.appverid: MET150
ms.reviewer: jonl, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# Outlook shows "Disconnected" after you enable modern authentication in Microsoft 365

## Symptoms

After [you enable modern authentication for Outlook in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/enable-or-disable-modern-authentication-in-exchange-online) in a Microsoft 365 tenant, Microsoft Outlook can't connect to a mailbox if the user's primary Windows account is a Microsoft 365 account that doesn't match the account they use to sign in to the mailbox. The mailbox shows "Disconnected" in the status bar.

## Cause

A known issue in Office creates a miscommunication between Office and Windows that causes Windows to provide the default credential instead of the appropriate account credential that is required to access the mailbox.

This issue most commonly occurs if more than one mailbox is added to the Outlook profile, and at least one of these mailboxes uses a sign-in account that is not the same as the user's Windows sign-in account.

## Resolution

The most effective solution to this issue is to [re-create your Outlook profile.](https://support.microsoft.com/office/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d).

## More information

For **Monthly** Channel Microsoft 365 subscribers, the fix to prevent this issue from occurring is available in builds **16.0.11901.20216** and later.

For **Semi-Annual** Customers, the fix is included in builds **16.0.11328.20392** and later.

For devices that are already affected by this issue, refer to the Resolution section.
