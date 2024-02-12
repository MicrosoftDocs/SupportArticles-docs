---
title: Recoverable Items folder not emptied for mailbox on litigation or retention hold
description: Provides a fix for an issue that occurs if the items in the Recoverable Items folder aren't moved to the Archive mailbox.
ms.date: 06/17/2022
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 161323
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: anrich
appliesto: 
  - Exchange Online Archiving
search.appverid: MET150
---
# Recoverable Items folder not emptied for mailbox on litigation or retention hold

## Symptoms

Consider the following scenario:

- Your mailbox is placed on litigation hold or retention hold.
- The archive feature is enabled for your mailbox.  

In this scenario, the Recoverable Items folder of the mailbox becomes full, and you might experience the following symptoms:

- You can't accept calendar invitations.
- You can't delete or archive items. Therefore, your mailbox becomes full.

When you run the [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant) cmdlet to process the retention of items, the items in the Recoverable Items folder aren't moved to the Archive mailbox. However, the mailbox diagnostic logs show that the Managed Folder Assistant has run successfully on both the primary and Archive mailboxes.

## Cause

This issue occurs because a new or changed retention policy has acted upon the mailbox. This causes a large number of items to be deleted. Consequently, the Managed Folder Assistant moves the deleted items to the Recoverable Items folder. This causes the folder to reach its quota.

The items in the Recoverable Items folder aren't moved to the Archive mailbox as expected. Therefore, the folder isn't emptied before it reaches its quota because the default retention policy tag (**Recoverable Items 14 days Move to Archive**) was applied to it. Because of this tag, the Recoverable Items folder remains full for 14 days before it's emptied.

## Resolution

To resolve this issue, configure the retention policy tag for Recoverable Items to move deleted items to the Archive folder earlier than the default time frame.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following cmdlet to verify the action and the age limit of the retention policy tag for the type **RecoverableItems**:

    ```powershell
    Get-RetentionPolicyTag | ft Name,Type,RetentionAction,AgeLimitForRetention
    ```

3. Run the [Set-RetentionPolicyTag](/powershell/module/exchange/set-retentionpolicytag) cmdlet to set the age limit for the retention policy tag from the output of the cmdlet in step 2 to 1 day:

    ```powershell
    Set-RetentionPolicyTag "<Retention_policy_tag>" -AgeLimitForRetention 1
    ```

    **Note:** Replace \<Retention_policy_tag> with the name of the policy tag that's applied to the Recoverable Items folder.

4. Run the `Start-ManagedFolderAssistant` cmdlet to process the items to the Archive mailbox and free up space in the Recoverable Items folder.

## More information

For information about other issues that might prevent retention policies from deleting email messages, see [Resolve email archive and deletion issues when using retention policies](/microsoft-365/troubleshoot/retention/troubleshoot-mrm-email-archive-deletion).
