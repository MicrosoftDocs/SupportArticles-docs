---
title: Cannot create appointment or all day event in the calendar of a shared mailbox
description: Resolves an issue in which a user cannot create an appointment or all day event in the calendar of a shared mailbox. This issue occurs after the user opens the shared mailbox by using Outlook or Outlook Web App in an Exchange Server 2007 or 2010 environment.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---

# User cannot create an appointment or all day event in the calendar of a shared mailbox in an Exchange Server 2007 or 2010 environment

## Symptoms

Assume that a user opens a shared mailbox by using Microsoft Outlook or Outlook Web App in a Microsoft Exchange Server 2007 or 2010 environment. In this situation, the following issues occur: 

- Only the New Meeting requestoption is available in the calendar of the shared mailbox in Outlook. Additionally, the user cannot create an appointment or all day event in the calendar of the shared mailbox by using the **New Meeting Request** or **New All Day Event** options. 

- When the user tries to create an appointment in the calendar of the shared mailbox in Outlook Web App, the user receives the following error message:

    **You don't have the permissions to perform this action.**   


## Cause

This issue occurs because the user does not have the required permissions to create a meeting in the calendar of the shared mailbox. 

## Resolution

To resolve this issue, use one of the following methods:

### Method 1

Use the following Set-MailboxFolderPermissioncmdlet to assign Author rights to the user:

```powershell
Set-MailboxFolderPermission -Identity "Alias of recipient\Calendar" -User "alias to grant access to" -AccessRights "Author"
```

> [!NOTE]
> The "Alias of recipient" is the alias associated with the shared mailbox. The "alias to grant access to" is the alias of the user who wants to create an appointment or all day event in the calendar of the shared mailbox.

For more information about the Set-MailboxFolderPermissioncmdlet, go to the following Microsoft website:

[Set-MailboxFolderPermission](/powershell/module/exchange/set-mailboxfolderpermission)

### Method 2

Use Outlook to assign the Author permission to the user. To do this, follow these steps:

1. Open the shared mailbox by using Outlook.   
2. In the **Navigation** pane, click **Calendar**.
3. Right-click the calendar of the shared mailbox, and then click **Properties**.   
4. On the **Permissions** tab, click Add, and then select the name of the user.   
5. In the **Permission Level** list, select **Author**, and then click **OK**.   

## More Information

In this scenario, Outlook uses the shared mailbox's Free/Busy information to generate a calendar view. Because the calendar view is a read-only view, you cannot create appointments in calendar view. Therefore, when a user double-clicks **New Meeting Request** or **New All Day Event** in the shared mailbox in calendar view to create an appointment or all day event, the appointment or all day event is not directly created in the shared mailbox's calendar. Instead, the appointment or all day event is created in the user's calendar, and the shared mailbox is added as an attendee.