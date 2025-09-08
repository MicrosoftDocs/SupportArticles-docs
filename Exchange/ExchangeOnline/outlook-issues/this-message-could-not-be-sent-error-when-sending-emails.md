---
title: This message could not be sent error
description: Describes an issue in Microsoft 365 in which users who have Send As permission to a distribution group receive a non-delivery report when they try to send an email message to other users in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# This message could not be sent NDR when an approved user sends mail in Microsoft 365

_Original KB number:_ &nbsp; 2918777

## Symptoms

When a user who has Send As permission to a distribution group tries to send an email message to other users by using Microsoft Outlook in Microsoft 365, the user receives a non-delivery report (NDR) that contains the following error message:

> This message could not be sent. Try sending the message again later, or contact your network administrator.  
Error is [0x80070005-00000000-00000000]

## Cause

This issue may occur if the address book in Outlook isn't updated.

## Resolution

To resolve this issue, follow these steps:

1. Update the address book in Outlook by following these steps:

   1. On the Office ribbon, select the **Send/Receive** tab, select the down arrow next to **Send/Receive Groups**, and then select **Download Address Book**.

      :::image type="content" source="media/this-message-could-not-be-sent-error-when-sending-emails/download-address-book.png" alt-text="Screenshot of the Download Address Book command on the Send/Receive tab.":::

   2. In the **Offline Address Book** dialog box, make sure that the **Download changes since last Send/Receive** check box is selected and that **Offline Global Address List** is selected as the address book, and then select **OK**.

      :::image type="content" source="media/this-message-could-not-be-sent-error-when-sending-emails/offline-address-book.png" alt-text="Screenshot of the Offline Address Book dialog box.":::

   3. Test to see whether the issue is resolved by sending an email message as the distribution group. When you create the message, use the global address list (GAL) to populate the **From** field.

      If it doesn't resolve the issue, go to step 2.

2. Delete all files and folders in the Offline Address Books folder. To do so, follow these steps:

   1. Exit Outlook.
   2. Locate the Offline Address Books folder. In Windows 8 and Windows 7, the folder is located along the following path:

      \Users\<UserName>\AppData\Local\Microsoft\Outlook\Offline Address Books

      :::image type="content" source="media/this-message-could-not-be-sent-error-when-sending-emails/folder-path.png" alt-text="Screenshot of Windows Explorer showing the path to the Offline Address Books folder.":::

      > [!NOTE]
      > The folder may be hidden. To unhide it, select **Start**, type folder options in the search box, select **Folder Options**, select the **View** tab, select **Show hidden files, folders, and drives**, and then select **OK**.

   3. Delete the contents of the Offline Address Books folder. (The contents of the folder are re-created when you restart Outlook).
   4. Start Outlook, and then test to see whether the issue is resolved by sending an email message as the distribution group.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
