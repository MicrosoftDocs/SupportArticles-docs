---
title: Cannot add permissions to user or room mailbox
description: Describes an issue that prevents you from adding a security group to a room mailbox cross-forest through Microsoft Outlook in Microsoft 365 hybrid. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't add permissions to Outlook user or room mailbox in another forest in Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 3195201

## Symptoms

In Microsoft 365, you can't add a security group or user to the permissions of a cross-forest room (or shared) mailbox in Microsoft Outlook. Specifically, this issue occurs in the following scenario:

- You were granted Full Access or folder level rights to a room mailbox in another forest.
- You add the room mailbox as a shared Calendar in Outlook.
- You right-click the Calendar folder and then select the **Permissions** tab:

  :::image type="content" source="media/cannot-add-permissions-to-user-or-room-mailbox-in-another-forest/permissions-tab.png" alt-text="Screenshot of the Permissions tab in the Room 1 on-prem Properties window.":::

- You select **Add**, select a user or security group from the People Picker, and then select **OK**. The user or security group is displayed, and you can select a permission level:

  :::image type="content" source="media/cannot-add-permissions-to-user-or-room-mailbox-in-another-forest/added-user-in-permissions-tab.png" alt-text="Screenshot of the Permissions tab with a new user added.":::

- When you select **Apply** or **OK** and then return to the **Permissions** tab, the user or security group is no longer listed:

  :::image type="content" source="media/cannot-add-permissions-to-user-or-room-mailbox-in-another-forest/no-user-or-security-group.png" alt-text="Screenshot shows that the user or security group is no longer listed under the Permissions tab.":::

> [!NOTE]
> This issue can be reproduced if the room mailbox is on-premises and the user is in Exchange Online. This issue also occurs if the room mailbox was moved to Exchange Online and the user has a mailbox on-premises.

In addition, when you right-click an Outlook folder of the user or room mailbox, and then select **Properties** to add folder permissions, you receive the following error message:

> Cannot display the folder properties. The folder may have been deleted or the server where the folder is stored may be unavailable. Cannot display folder properties.

## Cause

This issue occurs if the mailbox account isn't added to the profile correctly. The folder properties will not be accessible.

## Resolution

To work around this issue, use one of the following methods:

- Add folder-level permissions to a room mailbox by using the [Add-MailboxFolderPermission](/powershell/module/exchange/add-mailboxfolderpermission?view=exchange-ps&preserve-view=true) cmdlet.
- A user in the same forest as the room mailbox can add permissions in Outlook.

If the mailbox is a user or a shared mailbox, add the mailbox as an additional email account. To do this, follow these steps:

1. Select **File** > **Info**, and then select **Account Settings**.
2. Select **Account Settings**.
3. On the **E-mail** tab, select **New**.
4. On the **Auto Account Setup** page, enter the room or user mailbox name, email address, and your account password.
5. Select **Next**.

You will then be able to add permissions.
