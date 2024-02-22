---
title: New PST is created by default when adding new POP3 account
description: Explains the new Outlook 2010 feature where you add a new POP3 account, and this creates a new Outlook Data File (.pst). Also explains how you can change this folder to use an existing folder for new email messages.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: aruiz, gregmans, tsimon, laurentc, amkanade, Najmal, doakm, randyto, gbratton, bobcool, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# A new Outlook Data File (.pst) is created by default in Outlook 2010 when you add a new POP3 account

## Summary

Microsoft Office Outlook 2010 introduces changes to accounts that help you keep email messages better organized when those email messages come from multiple accounts. By default, Outlook 2010 automatically adds a new Outlook Data File (.pst) when you add a new POP3 account. However, earlier versions of Outlook let you select an existing Personal Folders file as the default delivery location. This could result in email messages from different accounts being delivered to the same Inbox.

## More information

This new functionality lets you easily determine through which account an email message was delivered. The new functionality also lets you select through which account an outgoing email message is sent. And this includes email messages that are replies or that are forwarded.

Although this new functionality is the default when you create a new account, you can manually configure a new Internet Email account that uses an existing Outlook Data File (.pst).

## How to manually configure accounts to use an existing Outlook Data File

To create a new account and have that account use an existing Outlook Data File (.pst), follow these steps:

1. On the **File** tab, select **Info**, select **Account Settings**, and then select **Account settings**.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/email-account.png" alt-text="The screenshot of the Account Settings page." border="false":::

2. In the **Account Settings** dialog box, on the **E-mail** tab, select **New**.
3. Select **E-mail Account**, and then select **Next**.
4. Select **Internet E-mail**, and then select **Next**.
5. Under **Internet E-mail Settings**, complete the form with the necessary information for the new account.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/add-new-account.png" alt-text="The screenshot of the Add New Account page." border="false":::

6. Under **Deliver new messages to**, select **Existing Outlook Data File**, and then select **Browse**.
7. Locate and then select the existing Outlook Data File (.pst).
8. Select **OK**.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/existing-outlook-data-file-option.png" alt-text="Select the Existing Outlook Data File option under Deliver new messages to." border="false":::

9. Select **Next**, and then select **Finish**.

If you are starting Outlook 2010 for the first time, when you create an Internet email account, follow these steps:

1. When you start Outlook 2010, the **Add New Account**, dialog box appears.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/start-outlook-for-the-first-time-to-create-internet-email-account.png" alt-text="Select the Manually configure server settings or additional server types option to add a new account.":::

2. Select **Manually configure server settings or additional server types**, and then select **Next.**  
3. Select **Internet E-mail**, and then select **Next**.
4. Under **Internet E-mail Settings**, complete the form with the necessary information for the new account.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/add-new-account.png" alt-text="Complete the form with the necessary information for the new account.":::

5. Under **Deliver new messages to**, select **Existing Outlook Data File**, and then select **Browse**.
6. Locate and then select the existing Outlook Data File (.pst).
7. Select **OK**.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/existing-outlook-data-file-option.png" alt-text="Select the Existing Outlook Data File option under Deliver new messages to." border="false":::

8. Select **Next**, and then select **Finish**.

## How to change the default delivery location

If the account is already configured to use the default settings, the default delivery location can be changed. To do this, access **Account Settings**, and then use the **Change Folder** option for the POP account.

To change the Outlook Data File (.pst) that an existing account uses, follow these steps:

1. On the **File** tab, select **Info**, select **Account Settings**, and then select **Account settings**.
2. In the **Account Settings** dialog box, on the **E-mail** tab, select the existing account that you want to change.
3. Select **Change Folder**, and then select the Outlook Data File (.pst) that you want to deliver new email messages to.

   :::image type="content" source="media/new-outlook-data-file-is-created-default-adding-pop3-account/email-account.png" alt-text="Select the existing account that you want to change." border="false":::

4. Select **OK**, and then select **Close**.
