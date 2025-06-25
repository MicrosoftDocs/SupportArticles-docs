---
title: Your mailbox reaches its quota though it has an archive enabled
description: Fixes an issue in which your mailbox reaches its quota even though an archive is enabled on the mailbox.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CI 125839
  - CSSTroubleshoot
ms.reviewer: wesmils
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---
# Your mailbox reaches its quota even if the Archive feature is enabled

## Symptoms

The Archive feature is enabled on your mailbox, but the mailbox reaches its quota.

## Cause

This issue occurs because the Archive feature doesn't automatically move items to the Archive folder.

## Resolution

To resolve this issue, set up the Archive feature by using one of the following methods:

### Move messages to the Archive folder manually

You can manually move items to your mailbox archive by using Outlook, Outlook on the web, or Outlook for iOS and Android. To learn more, see [Archive items manually](https://support.microsoft.com/office/archive-items-manually-ecf54f37-14d7-4ee3-a830-46a5c33274f6).

### Move messages to the Archive folder automatically

If your organization didn't assign a specific retention policy, you can configure the automatic archive folder policies to move items to the Archive folder automatically. To learn more, see:

- Outlook for Windows  
  [Archive older items automatically](https://support.microsoft.com/office/archive-older-items-automatically-25f44f07-9b80-4107-841c-41dc38296667)

- Outlook on the web  
  [Retention and archive policies in Outlook Web App](https://support.microsoft.com/office/retention-and-archive-policies-in-outlook-web-app-465372e4-e16b-47db-bee0-aba44799085e)

**Note:** If your organization assigned a specific retention policy, you must contact your administrator to configure policies. Also, if you use the retention and archive policies, the policies will move items to the Archive mailbox (not to the Archive folder) based on the retention period configured on the policy.

Administrators can also configure policies for users to automatically move items from a mailbox to its archive. To learn more, see [Set up an archive and deletion policy for mailboxes in your organization](/microsoft-365/compliance/set-up-an-archive-and-deletion-policy-for-mailboxes).

## More information

For more information about the Archive feature, see [Archive in Outlook for Windows](https://support.microsoft.com/office/archive-in-outlook-for-windows-25f75777-3cdc-4c77-9783-5929c7b47028).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
