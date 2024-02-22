---
title: How to emulate Out of Office Assistant
description: Describes how to emulate the Out of Office Assistant in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sercast
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# How to emulate the Out of Office Assistant in Microsoft Outlook

_Original KB number:_ &nbsp; 311107

## Summary

The Out of Office Assistant feature in Microsoft Outlook is a Microsoft Exchange Server service. It is available only when the Exchange Server transport service is included in an Outlook user's profile. You can emulate this feature by creating an e-mail template and defining a rule in the Rules Wizard to automatically reply with the template.

> [!NOTE]
> Microsoft has confirmed there is no working process to achieve these end results for Microsoft Office Outlook 2007.

## How to define an automatic reply template

### Microsoft Office Outlook 2010 and later versions

1. Select **New E-Mail** on the Ribbon.
2. On the **Format Text** tab, select **Plain Text**.
3. Type the information that you want to have in your reply message.
4. Select **File** on the Ribbon, and then select **Save As**.
5. In the **Save As** dialog box, select **Outlook Template** in the **Save as type** list.
6. Type a name for your reply template in the **File name** box, and then select **Save**.

### Microsoft Office Outlook 2003 and earlier versions of Outlook

> [!NOTE]
> To complete these steps, do not use Microsoft Word as your e-mail editor. If Microsoft Word is currently set to be your default email editor, you will need to turn that off. Otherwise, the **Outlook Template** option will not be visible in step 4. After you complete step 5, you may return Word back to being your default email editor.

1. Open a new Outlook message formatted as plain text.
2. Type the information that you want to have in your reply message.
3. On the **File** menu, select **Save As**.
4. In the **Save As** dialog box, select the **Outlook Template** check box in the **Save As Type** list.
5. Type a name for your reply template in the **File Name** box, and then select **Save**.

## How to define a rule to send an automatic reply

### Office Outlook 2010 and later versions

1. Select the **File** tab in the Ribbon, and then select the **Info** tab on the menu.
2. Select **Manage Rules & Alerts**, and then select the **New Rule** button on the **E-mail Rules** tab.
3. In the **Rules Wizard** under **Start from a blank rule**, select **Apply rule on messages I receive**, and then select **Next**.
4. Under **Which condition(s) do you want to check**, select the **Sent Only To Me** check box or any other check box that you want, and then select **Next**.
5. Under **What do you want to do with the message**, select the **Reply using a specific template** check box.
6. Under **Step 2: Edit the Rule Description**, select the underlined phrase **a specific template**.
7. In the **Select A Reply Template** dialog box, select the template that you saved in step 6 of the [How to define an automatic reply template](#how-to-define-an-automatic-reply-template) section, and then select **Open**.
8. Complete the Rules Wizard instructions, select **Finish**, and then select **OK**.

### Office Outlook 2003

1. On the **Tools** menu, select **Rules and Alerts**.
2. In the **Rules and Alerts** dialog box, select the **New Rule** button on the **E-mail Rules** tab.
3. In the **Rules Wizard**, select the **Start from a blank rule** button, select **Check messages when they arrive**, and then select **Next**.
4. Under **Which condition(s) do you want to check?**, select the **Sent Only To Me** check box or any other check box that you want, and then select **Next**.
5. Under **What do you want to do with the message?**, select the **Reply using a specific template** check box.
6. On the Step 2: Edit the Rule Description page of the wizard, select the underlined phrase **a specific template**.
7. In the **Select A Reply Template** dialog box, select the template that you saved in step 5 of the [How to define an automatic reply template](#how-to-define-an-automatic-reply-template) section, and then select **Open**.
8. Complete the Rules Wizard instructions, select **Finish**, and then select **OK**.

### Outlook 2002, in Outlook 2000, and in Outlook 98

1. On the **Tools** menu, select **Rules Wizard**.
2. In the **Rules Wizard** dialog box, select **New**.
3. Under **Which type of rule do you want to create?**, select **Start from a blank rule**, select **Check messages when they arrive**, and then select **Next**.
4. Under **Which condition(s) do you want to check?**, select the **Sent Only To Me** check box or any other criteria that you want, and then select **Next**.
5. Under **What do you want to do with the message?**, select the **Reply using a specific template** check box.
6. Under **Rule Description**, select the underlined phrase, **a specific template**.
7. In the **Select A Reply Template** dialog box, select the template that you saved in step 5 of the [How to define an automatic reply template](#how-to-define-an-automatic-reply-template) section and then select **Open**.
8. Complete the Rule Wizard instructions, select **Finish**, and then select **OK**.

The Rules Wizard rule to **reply using a specific template** is designed to send the reply only one time to each sender during a session. This prevents Outlook from sending repetitive replies to a sender from whom you receive multiple messages.

During a session, Outlook remembers the list of users to whom it has responded. When you restart Outlook, this list is deleted and the rule is reset to start again for each sender.

> [!NOTE]
> Outlook must be running for the Rules Wizard to automatically reply. Additionally, Outlook 2007 must be running and configured to check periodically for new messages.
