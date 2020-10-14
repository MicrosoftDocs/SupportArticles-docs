---
title: Validation errors for a mailbox archive GUID for Microsoft 365 users
description: You receive a validation error in the Microsoft 365 admin center or in Azure Active Directory.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
  - CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
ms.reviewer: kellybos
---
# Validation errors for a mailbox archive GUID for Microsoft 365 users

_Original KB number:_ &nbsp; 4053483

## Symptoms

In Microsoft 365 a user may receive the following validation errors in the Microsoft 365 admin center or in Azure Active Directory:

> Failed to sync the ArchiveGuid 00000000-0000-0000-0000-000000000000 of mailboxMailboxGuid because one cloud archiveCloudArchiveGuid exists.

> Failed to enable the new cloud archiveCloudArchiveGuidof mailboxMailboxGuid because a different archiveArchiveGuid exists. To enable the new archive, first disable the archive on-premises. After the next Dirsync sync cycle, enable the archive on-premises again.

In this situation, updates to other property values cannot be synchronized from Azure Active Directory to Exchange Online.

## Resolution

To resolve the errors, update the **msExchArchiveGUID** (**ArchiveGUID**) property value in the on-premises environment to match the value in the cloud.

If you have a hybrid environment that has Exchange on-premises, run the following command to update the value:

```powershell
Set-RemoteMailboxJohn -ArchiveGUIDCloudArchiveGuid
```

> [!NOTE]
> Archive GUID uses the format of the GUID that's in the validation error.

## More information

For more information, see [Archive mailbox can't be provisioned or deprovisioned after a mailbox is migrated to Office 365 Dedicated/ITAR vNext](/office365/troubleshoot/archive-mailboxes/cannot-provision-deprovision).
