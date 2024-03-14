---
title: Messages aren't moved to archive mailbox after you create retention policy
description: Describes a scenario in Exchange Online in Microsoft 365 in which a retention policy that you create to move messages to a user's archive mailbox doesn't automatically run. Provides a workaround.
author: helenclu
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 03/31/2022
---

# Messages aren't moved to archive mailboxes after you create a retention policy in Exchange Online

## Problem

In Microsoft Exchange Online for Microsoft 365, you use the New-RetentionPolicy Windows PowerShell cmdlet to create a retention policy that moves email messages from a user's' mailbox to the user's archive mailbox. For example, you create a retention policy by using the following series of PowerShell cmdlets.

```powershell
New-RetentionPolicyTag "ArchiveTag" –Type All –RetentionEnabled $true –AgeLimitForRetention 90 –RetentionAction MoveToArchive 

New-RetentionPolicy "CorpPolicy" –RetentionPolicyTagLinks "ArchiveTag" 

Set-Mailbox <mailbox> -RetentionPolicy "CorpPolicy" 

Start-ManagedFolderAssistant –Identity <mailbox>
```

However after you create the retention policy, the policy doesn't automatically run. That is, messages that have reached the age limit that's set in the policy aren't automatically moved to the user's archive mailbox. 

## Cause 

This issue occurs if the size of the mailbox in Exchange Online is less than 10 megabytes (MB). The retention policy runs automatically one time every seven days for mailboxes that are larger than 10 MB. However, the retention policy doesn't automatically run for mailboxes that are smaller than 10 MB.

This issue also occurs if the primary mailbox has an associated user account that's disabled, unless the mailbox is a shared mailbox. In this case, messaging records management (MRM) doesn't currently support moving items to the archive mailbox. Microsoft is aware of the issue and is working on a fix.

## Workaround 

For mailboxes that are smaller than 10 MB, manually run the `Start-ManagedFolderAssistant –Identity <mailbox>` cmdlet every time that you want to move messages to the archive.

## More information

For more information about the Managed Folder Assistant, see [Configure and run the Managed Folder Assistant](/Exchange/policy-and-compliance/mrm/configure-managed-folder-assistant?view=exchserver-2019&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
