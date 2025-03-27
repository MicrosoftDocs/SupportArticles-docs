---
title: Emulate Out of Office Assistant in Outlook
description: Describes how to emulate the Out of Office Assistant in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Out of Office (OOF)
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, aruiz, sercast
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 03/27/2025
---
# Emulate the Out of Office Assistant in Outlook

_Original KB number:_ &nbsp; 311107

The Out of Office Assistant feature in Microsoft Outlook is a Microsoft Exchange Server service. It is available only when the Exchange Server transport service is included in an Outlook user's profile. You can emulate this feature by creating an e-mail template and defining a rule in the Rules Wizard to automatically reply with the template.

## Define an automatic reply template

Use the following steps:

1. Select **New E-Mail** on the Ribbon.
2. On the **Format Text** tab, select **Plain Text**.
3. Type the information that you want to have in your reply message.
4. Select **File** on the Ribbon, and then select **Save As**.
5. In the **Save As** dialog box, select **Outlook Template** in the **Save as type** list.
6. Type a name for your reply template in the **File name** box, and then select **Save**.

## Define a rule to send an automatic reply

Use the following steps:

1. Select the **File** tab in the Ribbon, and then select the **Info** tab on the menu.
2. Select **Manage Rules & Alerts**, and then select the **New Rule** button on the **E-mail Rules** tab.
3. In the **Rules Wizard** under **Start from a blank rule**, select **Apply rule on messages I receive**, and then select **Next**.
4. Under **Which condition(s) do you want to check**, select the **sent only to me** check box or any other check box that you want, and then select **Next**.
5. Under **What do you want to do with the message**, select the **reply using a specific template** check box.
6. Under **Step 2: Edit the Rule Description**, select the underlined phrase **a specific template**.
7. In the **Select A Reply Template** dialog box, select the reply template that you saved in step 6 of [Define an automatic reply template](#define-an-automatic-reply-template) section, and then select **Open**.
8. Complete the Rules Wizard instructions, select **Finish**, and then select **OK**.

The **reply using a specific template** rule in the Rules Wizard is designed to send the reply only one time to each sender during a session. This prevents Outlook from sending repetitive replies to a sender from whom you receive multiple messages.

Outlook must be running for the Rules Wizard to send a reply automatically. During a session, Outlook remembers the list of users to whom it has responded. When you restart Outlook, this list is deleted and the rule is reset to start again for each sender.
