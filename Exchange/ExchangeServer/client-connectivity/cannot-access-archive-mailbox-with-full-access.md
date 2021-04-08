---
title: Cannot access archive mailbox with Full Access
description: Discusses an issue in which on-premises users can't access cloud archive mailbox that they have Full Access permission to in the Outlook client. Provides workarounds.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Server 2016
- Exchange Server 2013
- Exchange Server 2010
- Exchange Online
search.appverid: MET150
---
# On-premises users can't access cloud archive mailboxes with Full Access permission in Outlook

_Original KB number:_ &nbsp; 4486479

## Symptoms

Consider the following scenario:

- In a Microsoft Exchange Server hybrid environment, the primary mailboxes for User A and User B are hosted on-premises, and the archive mailboxes for both users are hosted in Exchange Online.
- User A has delegated, Full Access permission to User B's mailboxes.
- User A adds User B as an additional account in the Microsoft Outlook client.

In this scenario, User A can access User B's primary mailbox in Outlook, but User A cannot see or access User B's archive mailbox.

## Cause

The issue occurs because the automapping feature doesn't work correctly in the scenario that is described in the Symptoms section. This is a limitation of the feature.

## Workarounds - Method 1

Use Outlook Web App (Outlook Web App) to access the delegated archive mailbox. To add the mailbox to Outlook Web App, follow these steps:

1. Sign in to your mailbox by using Outlook Web App.
2. Right-click your name in the folder list, and then select **Add shared folder**.
3. In the **Add shared folder** dialog box, type the name of the mailbox that you have been provided access to, and then select **Add**.

The primary mailbox and archive mailbox appear in Outlook in the web folder list.

## Workarounds - Method 2

Create a new Outlook profile for the User B account. To create a profile, follow these steps:

1. In Outlook, select **File** > **Account Settings** > **Manage Profiles**.
2. Select **Show Profiles** > **Add**.
3. In the **Profile Name** box, type a name for the profile, and then select **OK**.
