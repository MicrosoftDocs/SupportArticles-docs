---
title: Recoverable Items folder not emptied for mailbox on litigation or retention hold
description: Provides a fix for an issue when the items in the Recoverable Items folder are not moved to the Archive mailbox.
author: MaryQiu1987
ms.author: v-maqiu
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

In this scenario, the Recoverable Items folder of the mailbox becomes full, and you may experience the following issues:

- You can't accept calendar invitations.  
- You can't delete or archive items so that your mailbox becomes full.

When you run the [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant) cmdlet to process the retention of items, the items in the Recoverable Items folder are not moved to the Archive mailbox. However, the mailbox diagnostic logs show that the Managed Folder Assistant has run successfully on both the primary and Archive mailboxes.

## Cause

This issue occurs if a new or changed retention policy has acted on the mailbox, which results in a large number of items being deleted. Consequently, the Managed Folder Assistant moves the deleted items to the Recoverable Items folder, which causes the folder to reach its quota.

The items in the Recoverable Items folder are not moved to the Archive mailbox as expected and the folder is not emptied before it reaches its quota because the default retention policy tag (**Recoverable Items 14 days Move to Archive**) has been applied to it. Due to this tag, the Recoverable Items folder remains full for 14 days before it is emptied.

## Resolution

To resolve this issue, configure the retention policy tag for Recoverable Items to move deleted items to the Archive folder earlier than the default time frame.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following cmdlet to verify the action and age limit of the retention policy tag for the type **RecoverableItems**:

    ```powershell
    Get-RetentionPolicyTag | ft Name,Type,RetentionAction,AgeLimitForRetention
    ```

3. Run the [Set-RetentionPolicyTag](/powershell/module/exchange/set-retentionpolicytag) cmdlet to set the age limit for the retention policy tag from the output of the cmdlet in step 2 to 1 day.

    ```powershell
    Set-RetentionPolicyTag "<Retention_policy_tag>" -AgeLimitForRetention 1
    ```

    **Note:** Replace \<Retention_policy_tag> with the name of the policy tag that's applied to the Recoverable Items folder.

4. Run the `Start-ManagedFolderAssistant` cmdlet to process the items to the archive mailbox and free up the space in the Recoverable Items folder.
