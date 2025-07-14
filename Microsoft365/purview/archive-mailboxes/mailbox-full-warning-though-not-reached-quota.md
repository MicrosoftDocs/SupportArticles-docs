---
title: (Mailbox is full) warning when it hasn't reached quota
description: Fixes an issue in which your receive receives a mailbox is full warning even if the mailbox hasn't reached the quota. Also you may not delete message and not change or accept any calendar invitation.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CI 125840
  - CSSTroubleshoot
ms.reviewer: wesmils
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---
# "Mailbox is full" warning even if the mailbox hasn't reached the storage limit

## Symptoms

A user experiences one of the following symptoms.

### Symptom 1

The user receives a "mailbox is full" warning message for a mailbox that hasn't reached the storage limit.

### Symptom 2

When the user deletes email messages, the following warning message is displayed:

> The operation could not be completed.

### Symptom 3

The user can't change or accept a calendar invitation.

## Cause

This issue occurs if the mailbox size exceeds the mailbox quota. The mailbox size that the user sees isn't the actual size because it doesn't include the Recoverable Items folder. This folder isn't visible to users.

## Resolution

Here's how to resolve this issue:

1. Verify the storage quotas of the user's mailbox by running the following cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl ProhibitSendReceiveQuota,RecoverableItemsQuota
   ```

   Then, verify the status of the mailbox quota by running this cmdlet:

   ```powershell
   Get-MailboxStatistics user@contoso.com | fl StorageLimitStatus,TotalItemSize,TotalDeletedItemSize
   ```

    - If the `StorageLimitStatus` value isn't blank, this means that the mailbox size exceeds the quota. The user will encounter the issue that's mentioned in the "Symptoms" section.
    - The `TotalItemSize` value refers to the portion of the mailbox that's visible to the user. The `TotalDeletedItemSize` value refers to the size of the Recoverable Items folder that isn't visible to the user.

2. If the `TotalItemSize` value exceeds the `ProhibitSendReceiveQuota` value, or if the `TotalDeletedItemSize` value exceeds the `RecoverableItemsQuota` value:

    - For Symptoms 1 and 3, you can either ask the affected user to delete items from the mailbox, or you can follow the next steps.
    - For Symptom 2, follow the next steps.

Here are the steps to fix this issue:

1. Verify that an archive is enabled for the affected user's mailbox by running the following cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl ArchiveStat*
   ```

   If the `ArchiveStatus` value is **Archive**, and if the `ArchiveState` value is **Local**, an archive is enabled in the cloud service. In this case, go to step 3.

   If no archive is enabled, check whether the user is on hold by running the following cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl *HoldEnabled
   ```

   If at least one of the returned values is **True**, this means that the user is on hold. If you don't want to enable an archive for that user, you must remove messages from the Recoverable Items folder. To learn more about the Recoverable Items folder, the storage quota, and how the folder interacts with In-Place Hold and Litigation Hold, see [Recoverable Items folder in Exchange Online](/exchange/security-and-compliance/recoverable-items-folder/recoverable-items-folder).

2. Enable an archive, and set up a retention or deletion policy to automatically process email messages. To learn more, see [Set up an archive and deletion policy for mailboxes in your organization](/microsoft-365/compliance/set-up-an-archive-and-deletion-policy-for-mailboxes).

3. Verify which retention policy is applied to the affected user by running the following cmdlet:

   ```powershell
   Get-Mailbox user@contoso.com | fl RetentionPolicy
   ```

   Be aware that such policies automatically archive or delete items from the mailbox after some time.

4. If a retention policy was recently modified or applied to the affected user, run mailbox processing manually by using the following cmdlet:

   ```powershell
   Start-ManagedFolderAssistant user@contoso.com
   ```

   This cmdlet starts the mailbox processing tasks that run retention policies and clear messages as configured. Wait at least one hour, and then check the mailbox again.

If these steps don't resolve the issue, contact [Microsoft Support](https://support.microsoft.com/contactus) for assistance.  

## More information

For information about other issues that might prevent retention policies from deleting email messages, see [Resolve email archive and deletion issues when using retention policies](/microsoft-365/troubleshoot/retention/troubleshoot-mrm-email-archive-deletion).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
