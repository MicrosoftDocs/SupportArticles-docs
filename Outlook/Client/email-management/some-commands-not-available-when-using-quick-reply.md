---
title: Some commands not available when using Quick Reply
description: The quick response pane does not allow you to use all message and compose features in Microsoft Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, wbrandt
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Some Outlook 2013 commands are not available when you use Quick Reply

_Original KB number:_ &nbsp; 2835452

## Symptoms

When you use the Quick Reply feature to reply to or forward an email message in Microsoft Outlook 2013, you cannot change the message format. Outlook message formats include HTML, Plain Text, and Rich Text (RTF). Additionally, you cannot insert a picture or object inline. Some Proofing and Language options are also unavailable.

## Cause

By design, the Quick Reply feature only provides a basic subset of commands.

## Workaround

When you use Quick Reply, you can perform some actions by using other methods.

### Insert a picture or object inline

To insert a picture inline, open the picture in a graphics application, such as Microsoft Paint. Copy the image and then paste it into the body of the reply or forward message.

To insert an object, such a Microsoft Excel spreadsheet, open the spreadsheet in Excel. Copy the desired cell range and paste it into the body of the Quick Reply message.

### Spelling Checker

To perform a spelling check, select the body of the Quick Reply message and press F7.

### Message Options

To access additional message options, in the **Tags** group, select the Properties Dialog Box Launcher. This dialog lets you change **Voting** and **Tracking** options, **Delivery** options, and more.

## More information

The Quick Reply feature only provides a basic subset of commands. To access all available message commands, use one of the following steps:

- Double-click the email message to open it in a new window.
- Select **POP OUT** in the **Quick Reply** pane.

To disable the Quick Reply feature, follow these steps:

1. On the **File** tab, select **Options**.
2. Select **Mail**.
3. Under the **Replies and forwards** section, check the box to **Open replies and forwards in a new window**.

    > [!NOTE]
    > Enabling this option sets the following registry value:  
    > Key: `HKCU\Software\Microsoft\Office\15.0\Outlook\Message`  
    > DWORD: **DisableReadingPaneCompose**  
    > Value: **1**
4. Select **OK**.
