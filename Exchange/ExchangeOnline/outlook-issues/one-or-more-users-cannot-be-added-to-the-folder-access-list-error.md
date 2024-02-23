---
title: Cannot add public folder permissions
description: Describes an error message that occurs when a user in a hybrid deployment tries to add public folder permissions for a cross-forest user in Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: chwillia, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# One or more users cannot be added to the folder access list error when adding public folder permissions in Outlook

_Original KB number:_ &nbsp; 3184240

## Symptoms

You have a public folder hybrid access configuration in which some mailbox users are located in Exchange Online and some mailbox users are located in the on-premises environment. In this situation, an on-premises user wants to use Microsoft Outlook to add permissions for Exchange Online users to access a legacy public folder. Or, an Exchange Online user wants to use Outlook to add permissions for on-premises users to access a legacy public folder.

However, when the user tries to add the cross-forest user, they receive the following error message:

> One or more users cannot be added to the folder access list. Non-local users cannot be given rights on this server.

Additionally, a red stop symbol is displayed next to the user's name in the **Add Users** list.

## Cause

You can't use Outlook to add permissions for objects that are located in different forests. Use Outlook to add permissions only when users reside in the same forest. For example:

- On-premises mailbox users can use Outlook to add public folder permissions for other on-premises mailbox users.
- Exchange Online mailbox users can use Outlook to add public folder permissions for other Exchange Online mailbox users.

## Workaround

On-premises Exchange admins can use the `Add-PublicFolderClientPermission` PowerShell cmdlet to assign public folder permissions to cross-forest users.

For example:

```powershell
Add-PublicFolderClientPermission -Identity \SalesFolder -AccessRights EditAllItems -User CrossForestUser
```

For more information about this cmdlet, see [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission?view=exchange-ps&preserve-view=true).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
