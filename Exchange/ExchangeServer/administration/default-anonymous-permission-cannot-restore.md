---
title: Removed Default or Anonymous permission can't be restored
description: Fixes an issue in which you can't use the Add-MailboxFolderPermission cmdlet to add Outlook folder Default or Anonymous permission.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: borget, heleli, v-six
ms.custom: 
  - sap:Permissions\Need help with Mailbox permissions (Send As, Send on Behalf, Full Access)
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
---
# Removed Default or Anonymous permission for Outlook folders can't be restored in an Exchange Server 2013 environment

_Original KB number:_ &nbsp; 2983066

## Symptoms

After you remove the Default or the Anonymous permission from a Microsoft Outlook folder in an Exchange Server 2013 environment, you can't add the permissions back by running the `Add-MailboxFolderPermission` cmdlet in Exchange Management Shell (EMS).

> [!NOTE]
> When you run the `Add-MailboxFolderPermission` cmdlet to add the permissions back, the result indicates that the operation succeeds. Actually, when you run the `Get-MailboxFolderPermission` cmdlet, the permissions are not added as expected.

## Resolution

To resolve this issue, install the following cumulative update:  
[Cumulative Update 6 for Exchange Server 2013](https://support.microsoft.com/help/2961810)

> [!NOTE]
> We don't recommend removing the Default or the Anonymous permission from an Outlook folder.

## Cause

This issue occurs because the `Add-MailboxFolderPermission` cmdlet doesn't set the Access rights parameter correctly.

## Status

Microsoft has confirmed that this is a problem.

## More information

By default, the Anonymous and the Default accounts have the Access rights parameter set to **None** on every folder in an Exchange Server 2013 mailbox.

Here is a sample of the result when you run the `Get-MailboxFolderPermission` cmdlet for default settings in EMS:

```console
[PS] C:\>Get-MailboxFolderPermission usermbx:\inbox
FolderName User AccessRights
---------- ---- ------------
Inbox Default {None}
Inbox Anonymous {None}
```

## References

- [Get-MailboxFolderPermission](/powershell/module/exchange/get-mailboxfolderpermission)

- [Add-MailboxFolderPermission](/powershell/module/exchange/add-mailboxfolderpermission)
