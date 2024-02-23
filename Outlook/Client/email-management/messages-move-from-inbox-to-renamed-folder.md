---
title: Messages move from Inbox to a renamed folder
description: Discusses that messages move from the Inbox to a renamed folder and the old folder name is applied to a new folder in Outlook. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Messages move from the Inbox to a renamed folder in Outlook

_Original KB number:_ &nbsp; 3087043

## Symptoms

When you rename a subfolder of the Inbox in Microsoft Outlook 2013, the following symptoms occur:

- The email messages that were in the Inbox folder move to the folder that you renamed.
- An additional folder appears and has the original name of the folder that you renamed.
- An email message that contains an error message that resembles the following is added to the **Sync Issues** folder:

  > 12:25:00 Synchronizing Hierarchy  
  12:25:02 Error in folder '\<folder name>'  
  12:25:02 [800CCCD2-0-0-733]

See the More Information section for an example of this issue.

## Cause

This issue affects some IMAP accounts that are configured in Outlook 2013.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.

## Workaround

To work around this issue, use an alternative method to rename subfolders of the Inbox. For example, use webmail to rename folders when it's necessary.

## More information

For an example of this issue, consider the following scenario:

- You have an Inbox subfolder that's named Alpha.
- You rename the Alpha folder to Beta.
- You notice that all the email messages that were previously in the Inbox folder are now in the Beta folder.
- You notice also that the Alpha folder appears in the folder list again together with the Beta folder.

In this scenario, if you select the ellipses button, select **Folders** to open the folder list, and then select the **Sync Issues** folder to view the messages it contains, you will find a message that resembles the message in the following screenshot.

:::image type="content" source="media/messages-move-from-inbox-to-renamed-folder/error-example.png" alt-text="Screenshot of the example message in the Sync Error folder.":::
