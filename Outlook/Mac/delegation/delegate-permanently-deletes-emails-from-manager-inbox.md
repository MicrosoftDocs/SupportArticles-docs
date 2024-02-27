---
title: Delegate permanently removes emails from manager's inbox
description: Fixes an issue in which delegates permanently delete a manager's email message in Outlook for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae, tsimon
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook for Mac delegate permanently deletes messages from manager's inbox

_Original KB number:_ &nbsp; 2771915

## Symptoms

In a delegate and manager scenario, when the delegate deletes an e-mail message from the manager's mailbox using Outlook 2016 for Mac or Outlook for Mac 2011, the delegate receives the following warning dialog:

> Are you sure you want to permanently delete the selected message?

If the delegate selects **Delete** from the popup dialog, the message is permanently deleted from the manager's mailbox, the item cannot be found in the manager's **Deleted Items** folder.

## Cause

This behavior occurs because the delegate does not have write access to the manager's **Deleted Items** folder. As a result, the delegate is not able to move the deleted message to the manager's **Deleted Items** folder.

## Resolution

To resolve this issue, grant the delegate write access to the manager's **Deleted Items** folder. To do this, follow these steps:

1. In Outlook for Mac, right-click the manager's **Deleted Items** folder, and select **Sharing Permissions**.
2. Select **Add User**, type the delegate's name, select **Find**, select the delegate from the list, and then select **OK**.
3. Select **Permission Level** and select Author or a higher permissions level.

## More information

The email that was permanently deleted from the manager's mailbox can be recovered from **Recover Deleted Items**, which can be accessed using OWA or Windows Outlook.
