---
title: Can't remove the access control entry
description: You can't remove mailbox permissions by using the Remove-ADPermission or Remote-MailboxPermission cmdlet for Office 365 dedicated/ITAR customers. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipients management
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Exchange Online Dedicated
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Can't remove mailbox permissions in Office 365 dedicated/ITAR

## Symptoms

In Microsoft Office 365 dedicated/ITAR, you try to remove mailbox permissions from a mailbox by using the `Remove-ADPermission` or `Remove-MailboxPermission` cmdlet in Remote PowerShell. When you do this, you receive an error message that states that the access control entry cannot be removed.

For example, you try to use the following cmdlet to remove mailbox permissions:

```powershell
Remove-MailboxPermission -Identity MailboxAccount -User UserAccount -AccessRights FullAccess -Confirm:$false
```

When you run the cmdlet, you receive the following error message:

> WARNING
>
> Can't remove the access control entry on the object "User" for the user account because the ACE doesn't exist on the object.

## Cause

This behavior is by design for Office 365 dedicated/ITAR customers in the legacy environment and for customers who run Microsoft Exchange Server 2016 in an Exchange resource forest design.

## Workaround

To work around this behavior, use the new `BypassMasterAccountSid` parameter when you remove permissions by using the `Remove-ADPermission` or `Remove-MailboxPermission` cmdlet.

For example, run the following cmdlet:

```powershell
Remove-MailboxPermission -Identity MailboxAccount -User UserAccount -AccessRights FullAccess -Confirm:$false –BypassMasterAccountSid
```
