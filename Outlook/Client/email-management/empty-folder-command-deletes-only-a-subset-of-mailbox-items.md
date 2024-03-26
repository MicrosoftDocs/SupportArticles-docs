---
title: Empty Folder command deletes only a subset of mailbox items 
description: In Outlook 2013, when you connect to an Exchange Server mailbox and use the Empty Folder command to delete the contents of the Deleted Items folder, only a subset of items are deleted. Similar behavior occurs when you use the Delete All command or the Empty Deleted Items folders when exiting Outlook option.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
- Exchange
search.appverid: MET150
ms.reviewer: aruiz, rakeshs, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# The Empty Folder command deletes only a subset of Exchange mailbox items in Outlook 2013

## Summary

Consider the following scenario:

- You are using Microsoft Outlook 2013.
- You are connected to a Microsoft Exchange Server mailbox.
- Your Exchange email account is configured to use Cached Exchange Mode.

In this scenario, when you use the **Empty Folder** command to delete the contents of the Deleted Items folder, only a subset of items is deleted. Similarly, when you use the **Delete All** command to delete the contents of other Outlook email folders, only a subset of items is deleted. Additionally, if you enable the **Empty Deleted Items folders when exiting Outlook** option, only a subset of items are deleted from any Deleted Items folders when you exit Outlook.

## More information

This behavior occurs because of the new Cached Exchange Mode Sync Slider feature that is introduced in Outlook 2013. By default, Sync Slider is set to synchronize only the last 12 months of email messages and deleted items. In the default configuration, only the last 12 months of items are displayed in the email and Deleted Items folders. When you select the **Delete All** command, only the email messages that are displayed in the folder are deleted. If you browse to the Deleted Items folder and then select the **Empty Folder** command, only the email messages that are displayed in the folder are permanently deleted. The same is true if you enable the **Empty Deleted Items folders when exiting Outlook** option. When you exit Outlook, items more than 12 months old are not permanently deleted.

### How to force Outlook to delete all items in a folder

To force Outlook to delete all items in a folder, make sure that Outlook displays all the items in the folder. To display and delete all items in a folder, follow these steps:

1. Start Outlook, and then browse to the desired folder. For example, select the Deleted Items folder or another built-in email folder such as the Inbox folder or the Sent Items folder.

2. At the bottom of the view and under the "There are more items in this folder on the server", select the **Click here to view more on Microsoft Exchange** hyperlink.

    > [!NOTE]
    > You may have to scroll to the bottom of the folder view to see the message and link.

3. To delete the items in the folder, select the **Folder** tab on the Ribbon, and then select **Delete All**. If you are working in the Deleted Items folder or the Junk E-Mail folder, the **Empty Folder** command is available.

    > [!NOTE]
    > The **Delete All** command is available only in the default Outlook email folders. This command is disabled for custom folders that you create.

### How to force Outlook to empty all the items in the Deleted Items folder on exit

If you enabled the **Empty Deleted Items folders when exiting Outlook** option, make sure that Outlook displays all the items before you exit Outlook. When you do this, all the items in the Deleted Items folder are permanently deleted when you exit Outlook. To have Outlook empty the Delete Items folder when you next exit, follow these steps:

1. Start Outlook, and then browse to the Deleted Items folder.
2. At the bottom of the view and under the "There are more items in this folder on the server", select the **Click here to view more on Microsoft Exchange** hyperlink.

    > [!NOTE]
    > You may have to scroll to the bottom of the folder view to see the message and link.

3. Exit Outlook.

    > [!NOTE]
    > When you receive the following message, select **Yes**:  
    > Do you want to permanently delete everything in the "Deleted Items" folder for all accounts?

### How to force the Empty Deleted Items Folder feature to delete all items in the Deleted Items folder

The Empty Deleted Items Folder tool is one of the Cleanup Tools that is available as part of the Mailbox Cleanup feature. If you want this tool to delete all the items in the Deleted Items folder, you must first make sure that Outlook displays all the items in the folder. To have Outlook permanently delete all the items in the Deleted Items folder when you run the tool, follow these steps:

1. Start Outlook, and then browse to the Deleted Items folder.
2. At the bottom of the view and under the "There are more items in this folder on the server", select the **Click here to view more on Microsoft Exchange** hyperlink.

    > [!NOTE]
    > You may have to scroll to the bottom of the folder view to see the message and link.

3. Select the **File** tab on the Ribbon.
4. Select **Cleanup Tools**, and then select **Empty Deleted Items Folder**.

For more information about how to administer the Outlook 2013 Sync Slider feature, see [Only a subset of your Exchange mailbox items are synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).
