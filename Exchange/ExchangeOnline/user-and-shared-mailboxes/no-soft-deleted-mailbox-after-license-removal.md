---
title: Can't access the mailbox of an unlicensed user in Exchange Online
description: Provides a resolution for an issue in which you can't access the mailbox of an unlicensed user in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - CI 195017
ms.reviewer: apascual, lusassl, v-shorestris
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 09/03/2024
---

# Can't access the mailbox of an unlicensed user in Exchange Online

_Original KB number:_ &nbsp; 3158794

## Symptoms

You want to access the mailbox of an unlicensed user in Exchange Online, but you can't locate the mailbox. For example, the mailbox isn't listed in the Exchange admin center or in the output of the following PowerShell cmdlets:

```PowerShell
Get-Mailbox -Identity <mailbox ID> -SoftDeletedMailbox
Get-Mailbox -Identity <mailbox ID> -IncludeInactive
```

## Cause

For a regular user mailbox in Exchange Online that doesn't have a hold applied, Exchange Online immediately disconnects (disables) the mailbox if the Exchange Online license for the user is removed or expires. You can't access a disconnected mailbox.

## Resolution

To reconnect the mailbox, [reassign](/microsoft-365/admin/manage/assign-licenses-to-users#use-the-active-users-page-to-assign-or-unassign-licenses) an Exchange Online license to the user within 30 days from when the license was removed. After 30 days, Exchange Online permanently deletes the mailbox, and the mailbox becomes unrecoverable.

> [!NOTE]
> In an Exchange hybrid environment, if a cloud user that's synced from on-premises becomes unsynced, Exchange Online deletes the user. If the deleted user is unlicensed, you must [restore the deleted user](/microsoft-365/admin/add-users/restore-user#restore-one-or-more-user-accounts) before you can reassign their Exchange Online license.
