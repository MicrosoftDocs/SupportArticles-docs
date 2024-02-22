---
title: Cannot access another user's mailbox folder
description: Describes an issue in which a user receives an error message when trying to access another user's mailbox folder in Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Unable to open default folders-you do not have permissions to logon error when accessing another user's mailbox folder

_Original KB number:_ &nbsp; 2796317

## Symptoms

A Microsoft 365 user tries to open another user's Microsoft Outlook mailbox folder to which the user was granted access. However, the mailbox folder doesn't open. Instead, the user receives the following error message:

> Unable to open default folders-you do not have permissions to logon

This issue occurs if the user doesn't have sufficient permissions to access the mailbox folder.

## Resolution

When a user wants to give another person access to one of their own mailbox folders in Outlook, the user has to grant the other person access to the specific folder that the user wants to share and also to all other parent folders in the folder hierarchy. It's not enough for the user to grant permissions only to the specific folder that they want to share.

For example, user B wants to grant user A access to the Invoices folder, and the Invoices folder is a subfolder of the user's Inbox folder. To grant this access, user B has to grant permissions to user A for the following folders in Outlook:

- The Invoices subfolder
- The Inbox folder
- The parent Mailbox folder

For more information about how to set up mailbox permissions in Outlook, see [Allow someone else to manage your mail and calendar](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926).

For more information about how to manage another user's mailbox data in your Outlook profile, see [Manage another person's mail and calendar items](https://support.microsoft.com/office/manage-another-person-s-mail-and-calendar-items-afb79d6b-2967-43b9-a944-a6b953190af5).

> [!NOTE]
> The root folder (the Mailbox folder) in Outlook must be assigned at least **Folder visible** permissions for the default role.

## More information

In Microsoft 365, Exchange Online admins can also grant mailbox folder permissions by using Exchange Online PowerShell. The `Add-MailboxFolderPermission` cmdlet can be used to grant access to specific folders in a user's mailbox. For more information about how to use this cmdlet, see [Add-MailboxFolderPermission](/powershell/module/exchange/add-mailboxfolderpermission?view=exchange-ps&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
