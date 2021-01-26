---
title: (Mailbox is full) warning when it hasn't reached quota
description: Fixes an issue in which your receive receives a "mailbox is full" warning even if the mailbox hasn't reached the quota. Also you may not delete message and not change or accept any calendar invitation.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom:
- CI 125840
- CSSTroubleshoot
ms.reviewer: wesmils
appliesto: 
- Exchange Online
search.appverid: MET150
---
# "Mailbox is full" warning even if the mailbox hasn't reached the storage limit

## Symptoms

A user experiences one of these issues:

### Symptom 1

The user receives a "mailbox is full" warning for a mailbox that hasn't reached the storage limit.

### Symptom 2

When the user deletes messages, a warning message saying "the operation could not be completed due to the quota" is displayed.

### Symptom 3

The user can't change or accept any calendar invitation.

## Cause

These issues occur if the mailbox size exceeds the mailbox quota. The mailbox size that the user see isn't the actual size because it doesn't include the Recoverable Items folder. This folder isn't visible to users.

## Resolution

Here's how to resolve this issue:

1. Verify the storage quotas of the user's mailbox by running this cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl ProhibitSendReceiveQuota,RecoverableItemsQuota
   ```

   Next, verify the status of the mailbox quota by running this cmdlet:

   ```powershell
   Get-MailboxStatistics user@contoso.com | fl StorageLimitStatus,TotalItemSize,TotalDeletedItemSize
   ```

    - If the `StorageLimitStatus` value isn't blank, the mailbox size exceeds the quota. The user will encounter the issues described in the Symptoms section.
    - The `TotalItemSize` value refers to the portion of the mailbox visible to the user. The `TotalDeletedItemSize` value refers to the size of the Recoverable Items folder that isn't visible to the user.

2. If the `TotalItemSize` value exceeds the `ProhibitSendReceiveQuota` value or if the `TotalDeletedItemSize` value exceeds the `RecoverableItemsQuota` value:

    - For Symptom 1 & 3, you can either ask the affected user to delete items from the mailbox or follow the steps below.
    - For Symptom 2, you just follow the steps below.

Here are the steps to fix the issue of exceeding `RecoverableItemsQuota`:

1. Verify that an archive is enabled for the affected user's mailbox by running this cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl ArchiveStat*
   ```

   If the `ArchiveStatus` value is **Archive** and if the `ArchiveState` value is **Local**, an archive is enabled in the cloud service. Skip directly to step 3.

   If no archive is enabled, check whether the user is on hold by running this cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl *HoldEnabled
   ```

   If at least one of the values returned is **True**, the user is on hold. If you don’t want to enable an archive for that user, you must remove messages from the Recoverable Items folder. To learn more about the Recoverable Items folder, the storage quota, and how the folder interacts with In-Place Hold and Litigation Hold, see [Recoverable Items folder in Exchange Online](/exchange/security-and-compliance/recoverable-items-folder/recoverable-items-folder).

2. Enable an archive and set up a retention or deletion policy to automatically process email messages. To learn more, see [Set up an archive and deletion policy for mailboxes in your organization](/microsoft-365/compliance/set-up-an-archive-and-deletion-policy-for-mailboxes).

3. Verify what retention policy is applied to the affected user by running this cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl RetentionPolicy
   ```

   Be aware that such policies automatically archive or delete items from the mailbox after a period of time.

4. If a retention policy was recently modified or applied to the affected user, run mailbox processing manually by using this cmdlet:

   ```powershell
   Start-ManagedFolderAssistant user@contoso.com
   ```

   This cmdlet starts the mailbox processing tasks that execute retention policies and clears messages as configured. Wait at least one hour and check the mailbox again.

If these steps didn't resolve the issue, contact [Microsoft Support](https://support.microsoft.com/contactus) for assistance.  

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
