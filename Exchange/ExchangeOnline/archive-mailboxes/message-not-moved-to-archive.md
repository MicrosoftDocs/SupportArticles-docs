---
title: Messages aren't moved to archive mailbox after you create retention policy
description: Describes a scenario in Exchange Online in Office 365 in which a retention policy that you create to move messages to a user's archive mailbox doesn't automatically run. Provides a workaround.
author: simonxjx
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Messages aren't moved to archive mailboxes after you create a retention policy in Exchange Online

## Problem 

In Microsoft Exchange Online for Microsoft Office 365, you use the New-RetentionPolicy Windows PowerShell cmdlet to create a retention policy that moves email messages from a user's' mailbox to the user's archive mailbox. For example, you create a retention policy by using the following series of PowerShell cmdlets.

```powershell
New-RetentionPolicyTag "ArchiveTag" –Type All –RetentionEnabled $true –AgeLimitForRetention 90 –RetentionAction MoveToArchive 

New-RetentionPolicy "CorpPolicy" –RetentionPolicyTagLinks "ArchiveTag" 

Set-Mailbox <mailbox> -RetentionPolicy "CorpPolicy" 

Start-ManagedFolderAssistant –Identity <mailbox>
```

However after you create the retention policy, the policy doesn't automatically run. That is, messages that have reached the age limit that's set in the policy aren't automatically moved to the user's archive mailbox. 

## Cause 

This issue occurs if the size of the mailbox in Exchange Online is less than 10 megabytes (MB). The retention policy runs automatically one time every seven days for mailboxes that are larger than 10 MB. However, the retention policy doesn't automatically run for mailboxes that are smaller than 10 MB. 

## Workaround 

For mailboxes that are smaller than 10 MB, manually run the Start-ManagedFolderAssistant –Identity \<mailbox> cmdlet every time that you want to move messages to the archive.

## More information 

For more information about how to set up and manage retention policies in Exchange Online, see [Set Up and Manage Retention Policies in Exchange Online with Windows PowerShell](https://technet.microsoft.com/exchangelabshelp/gg271153#defaulttags).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
