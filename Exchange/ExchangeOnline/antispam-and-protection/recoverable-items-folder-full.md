---
title: Recoverable Items folder becomes full
description: Fixes an issue in which Recoverable Items aren't moved to archive when a mailbox is placed on litigation hold or retention hold.
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
# Unable to move Recoverable Items to archive

## Symptoms

Consider the following scenario:

- A user's mailbox is placed on litigation hold or retention hold.
- The archive feature is enabled for the user.  

In this scenario, the Recoverable Items folder becomes full, and the user may experience the following issues:

- They can't accept calendar invitations.  
- They can't delete or archive data so that the Inbox folder also becomes full.

When you run the [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant) cmdlet to process the retention of items, the items are not moved to the archive mailbox. However, the mailbox diagnostic logs show that the Managed Folder Assistant ran successfully on both the primary and archive mailboxes.

## Cause

This issue occurs if a new or changed retention policy has acted on the mailbox. In this case, the mailbox generates amounts of deleted items. This retention change causes the Managed Folder Assistant to move enough deleted items to the Recoverable Items folder. Therefore, the folder reaches its quota.  

The Recoverable Items folder isn't emptied because the retention policy tag applied to Recoverable Items isn't active enough to move items to the archive mailbox. A default retention policy tag (**Recoverable Items 14 days Move to Archive**) can keep the mailbox in this state for over 14 days.

## Resolution

To resolve this issue, configure the retention policy for Recoverable Items more active by following these steps:

1. Confirm the action and age limit of the retention policy tag for the type **RecoverableItems** by running the following cmdlets:

    ```powershell
    $policy = Get-RetentionPolicy "POLICY"
    $policy.RetentionPolicyTagLinks | Get-RetentionPolicyTag | ft Name,Type,RetentionAction,AgeLimitForRetention
    ```

2. Reduce the age limit (to 1 day) for the retention policy tag that you get from step 1. To do this, run the following [Set-RetentionPolicyTag](/powershell/module/exchange/set-retentionpolicytag) cmdlet:

    ```powershell
    Set-RetentionPolicyTag "<Tag_name>" -AgeLimitForRetention 1
    ```

    **Note:** Replace \<Tag_name> with the name of the policy tag that's applied to the Recoverable Items folder.

3. Run the `Start-ManagedFolderAssistant` cmdlet to process the items to the archive mailbox and free up space in the Recoverable Items folder.
