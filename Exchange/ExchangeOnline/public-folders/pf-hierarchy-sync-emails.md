---
title: Public folder hierarchy synchronization messages
description: Fixes an issue in which public folder hierarchy synchronization messages are sent incorrectly because of a transport rule.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 150753
- Exchange Online
- CSSTroubleshoot
ms.reviewer: batre
appliesto: 
- Exchange Online via Office 365 E Plans
- Exchange Online via Office 365 P Plans
- Exchange Server 2016
- Exchange Server 2019 
search.appverid: MET150
---
# Email messages with the "HierarchySync_" subject in message tracking

Email messages with the "HierarchySync_" subject are displayed in message tracking, flooding the queue, or delivered to unintended recipients.

If the public folder hierarchy synchronization messages are sent incorrectly, the public folder hierarchy is synchronized by using SMTP messages that has subject starting with "HierarchySync_". In the synchronization process, all public folder mailboxes in the organization are added to a special system group. The primary hierarchy mailbox sends hierarchy sync notification email messages to this special group. The message class of these notification email messages is "IPM.HierarchySync.Message". For more information about the hierarchy sync, see [Introduction to Public Folder Hierarchy Sync](https://techcommunity.microsoft.com/t5/exchange-team-blog/introduction-to-public-folder-hierarchy-sync/ba-p/609344).

Since these notification email messages are SMTP messages, they are displayed in message tracking reports. Therefore, if you see email messages with the "HierarchySync_" subject, this behavior is by design, and you can safely ignore these email messages.

However, if you see these messages being delivered to unintended recipients, this issue occurs if your organization has created a catch-all transport rule to process all email messages that are generated from the organization or has enabled global journaling of email messages. If you're using global journaling, the behavior to see hierarchy sync emails being sent to a journal recipient is by design.

To work around this issue, use one of the following methods:

## Workaround 1: Add an exception for the transport rule

Here's how to add an exception for the transport rule that processes all email messages in the organization to exclude messages that have the words "HierarchySync_" included in the subject.

1. In the Exchange admin center, go to **Mail flow** > **Rules**.

1. Check the rules and find the one that's acting on all messages.

1. Double-click the transport rule to open the rule editor window, select **Add exception**, and then select **The subject includes** in the **Except if...** dropdown as in the following screenshot.

    :::image type="content" source="media/pf-hierarchy-sync-emails/transport-rule.png" alt-text="Screenshot of adding exception to the transport rule.":::

## Workaround 2: Exclude email messages sent from the primary hierarchy mailbox

1. Find the email address of the primary hierarchy mailbox by running the following Exchange Online PowerShell command:

    ```powershell
    Get-Mailbox -PublicFolder |?{$_.IsRootPublicFolderMailbox -eq "True"} | ft emailaddresses 
    ```

1. Add an exception in the Exchange transport rule by running the following cmdlet:

    ```powershell
    Set-TransportRule -Identity "[Apply to all messages]" -ExceptIfFrom "<primary hierarchy mailbox address>"
    ```

    **Note:** You must find the transport rule that's working on public folder hierarchy sync email messages. Replace \<primary hierarchy mailbox address> with the address that you get from step 1.
