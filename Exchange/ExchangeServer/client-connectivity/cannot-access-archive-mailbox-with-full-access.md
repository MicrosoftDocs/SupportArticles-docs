---
title: Can't access archive mailbox with Full Access
description: Discusses an issue in which on-premises users can't access cloud archive mailbox that they have Full Access permission to in the Outlook client. Provides workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Outlook
  - CI 160833
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, wloudermilk, ninob, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# On-premises users can't access cloud archive mailboxes with Full Access permission in Outlook

_Original KB number:_ &nbsp; 4486479

## Symptoms

Consider the following scenario:

- In a Microsoft Exchange Server hybrid environment, the primary mailboxes for User A and User B are hosted on-premises, and the archive mailboxes for both users are hosted in Exchange Online.
- User A has delegated, Full Access permission to User B's mailboxes.
- User A adds User B as another account in the Microsoft Outlook client.

In this scenario, User A can access User B's primary mailbox in Outlook, but User A can't see or access User B's archive mailbox.

## Cause

The issue occurs because the automapping feature doesn't work correctly in the scenario that's described in the Symptoms section. It's a limitation of the feature.

## Workarounds - Method 1

Use Outlook Web App (Outlook Web App) to access the delegated archive mailbox. To add the mailbox to Outlook Web App, follow these steps:

1. Sign in to your mailbox by using Outlook Web App.
2. Right-click your name in the folder list, and then select **Add shared folder**.
3. In the **Add shared folder** dialog box, type the name of the mailbox that you have been provided access to, and then select **Add**.

The primary mailbox and archive mailbox appear in Outlook in the web folder list.

## Workarounds - Method 2

> [!IMPORTANT]
> Don't share your passwords with anyone. This workaround assumes User A is administering additional accounts or the shared mailbox.

Create a new Outlook profile for the shared User B's mailbox, using User B's account credentials to sign in. To create a profile, follow these steps:

1. In Outlook, select **File** > **Account Settings** > **Manage Profiles**.
2. Select **Show Profiles** > **Add**.
3. In the **Profile Name** box, type a name for the profile, and then select **OK**.
4. Enter the email address for User B.
5. When prompted, enter the credentials for User B.
