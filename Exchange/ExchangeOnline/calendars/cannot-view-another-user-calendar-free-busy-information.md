---
title: Can't view other user's free/busy information
description: Describes a problem that prevents you from viewing free/busy information for a specific user in Exchange Online. And if troubleshooting logging is enabled for the user, the Outlook log contains a The result set contains too many calendar entries error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Outlook 2016
  - Outlook 2019
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't view free/busy information on another user's Calendar in Exchange Online

_Original KB number:_ &nbsp; 2962513

## Problem

You cannot view free/busy information for a specific user in Exchange Online. You experience this issue in Outlook Web App and Microsoft Outlook (including Outlook for Mac 2011). Specifically, you experience the following symptoms:

- When you try to view the user's Calendar in Outlook, you receive the following error message:

    > could not be updated

   :::image type="content" source="media/cannot-view-another-user-calendar-free-busy-information/could-not-be-updated.png" alt-text="Screenshot of could not be updated error.":::

- When you try to view the user's Calendar through Outlook Web App, you see a red triangle with an exclamation mark.

   :::image type="content" source="media/cannot-view-another-user-calendar-free-busy-information/red-triangle.png" alt-text="Screenshot of the user's Calendar showing a red triangle with an exclamation mark.":::

## Cause

This issue occurs if the user's Calendar has a time slot that contains more than 1,000 entries.

## Solution

Delete unwanted items from the user's Calendar so that there are fewer than 1,000 items in that particular time slot.

## More information

To confirm that this is the issue that you're experiencing (if the user is running Outlook 2010 or Outlook 2007), follow these steps:

1. Enable troubleshooting logging in Outlook. For more info about how to do this, see [How to enable global and advanced logging for Microsoft Outlook](https://support.microsoft.com/help/831053).
2. In the `%temp%\OLkAS` folder, look for the availability service log file that's named \<date>-\<time>-AS.log or \<date>-\<time>-fb.log.
3. Search the log file for an entry that resembles the following:

    > \<MessageResponseClass="Error">\<MessageText>Microsoft.Exchange.InfoWorker.Common.Availability. ResultSetTooBigException: The result set contains too many calendar entries. The allowed size = 1000; the actual size = \<xxxx>

    The number that's represented by the \<xxxx> placeholder. If you're experiencing this issue, this number will be more than 1,000.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
