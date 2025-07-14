---
title: Unable to share files in a large group chat or meeting chat
description: Describes an issue that you can't share files in a large group chat or meeting chat in Microsoft Teams.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Chat (Messaging)\Meeting Chats
  - CI 176308
  - CSSTroubleshoot
ms.reviewer: apoorvsharma,jgupta,sasood
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Can't share files in a large group chat or meeting chat

## Symptoms

When you try to share files in a Microsoft Teams group chat or meeting chat that contains more than 50 participants, the message might not be sent successfully when you select **Send** :::image type="icon" source="media/cannot-share-files-in-large-chat/send-file-icon.png":::.

## Cause

This issue occurs if the default setting for file sharing is **People currently in this chat**. In this case, the [Specific people](/sharepoint/turn-external-sharing-on-or-off#file-and-folder-links) link is used. However, *Specific people* links aren't recommended when you want to share files with more than 50 people.

## Workaround

To work around this issue, follow these steps:

1. Select the file's current sharing setting. For example, select **People currently in this chat with the link can edit**, as shown in the following screenshot.

   > [!NOTE]
   > Selecting this setting opens the **Sharing settings** dialog box.
   >
   :::image type="content" source="media/cannot-share-files-in-large-chat/current-sharing-setting.png" alt-text="Screenshot that shows the current sharing setting. In this example, People currently in this chat with the link can edit.":::
1. In **Sharing settings**, select one of the following settings:

   - If there are people outside your organization in the chat, select **Anyone**.
   - If all the people in the chat are inside your organization, select **People in your organization**.

   > [!NOTE]
   > If the desired setting is disabled, contact your organization's administrator to change the [sharing settings](/sharepoint/turn-external-sharing-on-or-off). For example, admins can follow these steps to enable the **People in your organization** setting and make it the default sharing setting:
   >
   > 1. Sign in to the SharePoint admin center by using an account that has admin permissions for the organization.
   > 1. Select **Sharing**.
   > 1. Make sure that the [People in your organization links](/microsoft-365/solutions/microsoft-365-limit-sharing?view=o365-worldwide#people-in-your-organization-sharing-links&preserve-view=true) aren't disabled.
   > 1. Under **File and folder links**, select **Only people in your organization**.
