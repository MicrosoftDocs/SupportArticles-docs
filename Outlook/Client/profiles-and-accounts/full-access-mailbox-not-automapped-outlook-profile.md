---
title: Mailboxes aren't automapped to Outlook profile
description: Discusses an issue in which mailboxes to which your account has full access aren't automapped to your Outlook profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 10/30/2023
---
# Mailboxes to which your account has full access aren't automapped to Outlook profile

_Original KB number:_ &nbsp; 3190323

## Symptoms

When you assign full mailbox access to a specific set of mailboxes through a security group, the members of the assigned group don't see the mailbox get automapped to their Outlook profile. However, the mailbox can be accessed if the mailbox is manually added to the Outlook profile or by using Outlook on the Web.

## Cause

The autodiscover process examines the `msExchDelegateListBL` mailbox attribute to determine which mailboxes should be automapped to the Outlook profile. Currently, the **securitygroup** group membership list isn't expanded during the autodiscover process. This, in turn, prevents the mailboxes from being automapped to the user's Outlook profile.

## Resolution

For automapping to work correctly, users must explicitly add full mailbox access to each mailbox that they want to have automapped to their Outlook profile.
