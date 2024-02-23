---
title: Outlook crashes when sending emails with nonexistent delivery location
description: Provides a resolution for the issue that Outlook crashes when you try to send email messages because of a nonexistent delivery location setting in your profile.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: gregmans, dthayer, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# Outlook crashes when trying to send emails because of a nonexistent delivery location setting in your profile

## Symptoms

Microsoft Outlook crashes when you try to send email messages.

If you review the crash details, you see information that resembles the following error signature:

> **Application Name**: Outlook.exe  
> **Application Version**: 14.0.4760.1000  
> **Module Name**: OLMAPI32.dll  
> **Module Version**: 14.0.4760.1000  
> **Offset**: 0x000cf4fb

## Cause

This problem occurs when you are using a POP3 email account, and the default delivery location for this account references a nonexistent folder.

> [!NOTE]
> This problem may occur most frequently when you have a Microsoft Exchange Server mailbox and a POP3 account in the same profile. However, this problem can also occur if you do not have an Exchange Server mailbox in your profile.

## Resolution

To resolve this problem, update your POP3 email account to reference a valid folder. To do this, follow these steps:

1. Exit Outlook if it is running.
2. In the **Mail** control panel, select **Show Profiles**.
3. In the **Mail** dialog box, select your Outlook profile that has the POP3 account, and then select **Properties**.
4. In the **Mail Setup** dialog box, select **E-mail Accounts**.
5. In the **E-mail Accounts** section of the **Account Settings** dialog box, on the **E-mail** tab, select your POP3 account, and then select **Change Folder**.

    :::image type="content" source="media/outlook-crashes-when-sending-emails/change-folder-in-account-settings.png" alt-text="Select Change Folder button in the Account Settings." border="false":::

6. In the **New E-mail Delivery Location** dialog box, select the folder in which new email messages are to be delivered, and then select **OK**.

    :::image type="content" source="media/outlook-crashes-when-sending-emails/new-email-delivery-location.png" alt-text="Select the new emails in New E-mail Delivery Location." border="false":::

    > [!NOTE]
    > The typical delivery location for new email messages is your **Inbox** folder.

7. Select **Close** two times, and then select **OK**.
8. Start Outlook.
