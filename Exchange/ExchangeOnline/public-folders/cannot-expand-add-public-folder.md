---
title: Can't expand or add public folders in Outlook or OWA
description: Provide a resolution to an issue in which users who have sufficient permissions to a public folder can't expand or add public folders in Outlook or OWA.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CSSTroubleshoot
  - CI 125428
  - Exchange Online
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
ms.reviewer: v-six
---

# Can't expand or add public folders in Outlook or OWA

## Symptoms

In Microsoft Outlook, if a user who has sufficient permissions to a public folder tries to expand the public folder tree, the following error message is displayed:

> Unable to expand folder. failed attempt to connect to Microsoft Exchange.

In Outlook on the web, if the user tries to add the public folder to **Favorites**, the "adding public folder" window does not appear. Additionally, if you look for the **GetFolder** request by using the [F12 diagnostic tools](/archive/microsoft-edge/legacy/developer/), you can capture the following error message in the response text:

> "Mailbox must be accessed as owner. Owner: public folder mailbox guid; Accessing user: User ExchangelegacyDN"

> [!NOTE]
> Microsoft does not support third-party solutions that allow access to public folder information through impersonation without a licensed user getting access to the folder through default permissions.

## Cause

This issue occurs if the user has explicit permissions, such as **Full Access**, to the *EffectiveDefaultPublicFolderMailbox* property.

To verify this condition, run the following cmdlets:

```powershell
Get-Mailbox <mailbox name of the affected user> | FL *public*
```

```powershell
Get-MailboxPermission <EffectiveDefaultPublicFolderMailbox name>
```

For example:

:::image type="content" source="media/cannot-expand-add-public-folder/validate-permission.png" alt-text="Screenshot of checking permission.":::

## Resolution

To fix this issue, run the [Remove-MailboxPermission](/powershell/module/exchange/remove-mailboxpermission?view=exchange-ps&preserve-view=true) cmdlet to remove the explicit permissions to the *EffectiveDefaultPublicFolderMailbox* property:

```powershell
Remove-MailboxPermission pfmbx1 -User exo1 -AccessRights FullAccess
```

Next, run the [Get-MailboxPermission](/powershell/module/exchange/get-mailboxpermission?view=exchange-ps&preserve-view=true) cmdlet to verify that those explicit permissions are removed:

```powershell
Get-MailboxPermission pfmbx1
```
