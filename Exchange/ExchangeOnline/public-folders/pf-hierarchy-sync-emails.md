---
title: Public folder hierarchy synchronization messages
description: Fixes an issue in which public folder hierarchy synchronization messages are sent incorrectly because of a transport rule.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 150753
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre
editor: v-jesits
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Email messages with the "HierarchySync_" subject in message tracking

Email messages that have the "HierarchySync_" subject are displayed in message tracking, are flooding the queue, or are delivered to unintended recipients.

This issue occurs if the public folder hierarchy synchronization messages are sent incorrectly. The public folder hierarchy is synchronized by using SMTP messages that have subject lines that start at "HierarchySync_". In the synchronization process, all public folder mailboxes in the organization are added to a special system group. The primary hierarchy mailbox sends hierarchy sync notification email messages to this special group. The message class of these notification email messages is "IPM.HierarchySync.Message". For more information about the hierarchy sync, see [Introduction to Public Folder Hierarchy Sync](https://techcommunity.microsoft.com/t5/exchange-team-blog/introduction-to-public-folder-hierarchy-sync/ba-p/609344).

Because these notification messages are SMTP messages, they are displayed in message tracking reports. Therefore, if you see email messages that have the "HierarchySync_" subject, you can trust that this behavior is by design, and you can safely ignore these email messages.

However, if you see these messages getting delivered to unintended recipients, this is because your organization has created a catch-all transport rule to process all email messages that are generated from the organization or that have enabled global journaling of email messages. If you're using global journaling, the behavior to see hierarchy sync email messages being sent to a journal recipient is by design.

To fix this issue, use one of the following methods.

## Resolution 1: Add an exception for the transport rule

Add an exception for the transport rule that processes all email messages in the organization to exclude messages that have the words "HierarchySync_" in the subject line. Here's how:

1. In the Exchange admin center, go to **Mail flow** > **Rules**.

1. Check the rules, and find the one that's acting on all messages.

1. Double-click the transport rule to open the rule editor window, select **Add exception**, and then select **The subject includes** in the **Except if...** list, as shown in the following screenshot.

    :::image type="content" source="media/pf-hierarchy-sync-emails/transport-rule.png" alt-text="Screenshot of adding exception to the transport rule.":::

## Resolution 2: Exclude messages sent from the primary hierarchy mailbox

Exclude email messages that are sent from the primary hierarchy mailbox. Here's how:

1. Find the email address of the primary hierarchy mailbox by running the following Exchange Online PowerShell command:

    ```powershell
    Get-Mailbox -PublicFolder |?{$_.IsRootPublicFolderMailbox -eq "True"} | ft emailaddresses 
    ```

1. Add an exception in the Exchange transport rule by running the following cmdlet:

    ```powershell
    Set-TransportRule -Identity "[Apply to all messages]" -ExceptIfFrom "<primary hierarchy mailbox address>"
    ```

    **Note:** You must find the transport rule that's working on public folder hierarchy sync email messages. Replace \<primary hierarchy mailbox address> with the address that you obtained in step 1.
