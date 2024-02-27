---
title: Can't send files from an application through email
description: This article helps fix errors that occur when you send a file from an application other than Microsoft Outlook through an email.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: gregmans
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
  - Outlook 2010
ms.date: 01/30/2024
---
# Error sending a file from an application when two versions of Outlook are installed

_Original KB number:_ &nbsp; 2785945

## Symptoms

When you are in a program other than Outlook, you may receive the following error message if you try to send a file from that program through an email.

> This action is not supported while an older version of Outlook is running.

If you click **OK**, you may receive another error message. This second error message depends on the program that you're using when you try send a file using email. Here is a couple of example error messages from different programs.

- Word

    > Word couldn't send mail because of MAPI failure: "Operation is not supported".
- Excel

    > General mail failure. Quit Microsoft Excel, restart the mail system, and try again.

- PowerPoint

    > An error occurred while sending the presentation.

## Cause

This problem occurs if all of the following conditions exist:

- You have Outlook 2013 installed along with an earlier version of Outlook.
- You have a version of Outlook earlier than Outlook 2013 running when you attempt to send the file.

In this scenario where you have multiple versions of Office installed, you need to have the latest version of Outlook running in order to send a file through email from another program.

## Resolution

To resolve this problem, use the following steps.

1. Exit the earlier version of Outlook that is currently running (*earlier* is any version before Outlook 2013).
2. Start Outlook 2013.
3. Send your file from the other program.

If you must send the file from an earlier version of Outlook, attach the file to an email message you initiate from Outlook. In other words, don't initiate the email process from the other program (such as Word or Excel).

## More information

In some scenarios, you may instead receive the following error as the first error:

> Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.

After you click **OK** to this error, the application-specific error messages provided in the [Symptoms](#symptoms) section of this article are then displayed.

The resolution for this alternative scenario is the same as that listed in the **Resolution** section of this article.
