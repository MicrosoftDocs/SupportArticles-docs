---
title: Can't sync recurring Calendar items with error 0x80004005
description: Fixes an issue in which Outlook doesn't sync recurring Calendar items with error 0x80004005.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Lists and Libraries\Lists Offline sync
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Online
search.appverid: MET150
ms.date: 12/17/2023
---
# Recurring Calendar items can't be synchronized in Outlook

_Original KB number:_ &nbsp; 3013532

## Symptoms

When you add a recurring Calendar item by sending a meeting invitation email message to a list, the event is added correctly on the Microsoft SharePoint Online list. But when you click **Connect to Outlook** and then sync with Microsoft Outlook, you experience the following symptoms:

- The recurring event isn't listed in the Outlook Calendar.
- Outlook doesn't sync the recurring Calendar item.
- You receive the following error message:

    > Receiving error "Task 'SharePoint' reported error (0x80004005) : 'Failed to copy one or more items. For details, see the log file .'"

## Cause

When incoming email messages are used for Calendar lists, SharePoint Online doesn't support recurring Calendar items that are sent through Outlook. SharePoint Online will import them. However, these Calendar items cannot be synchronized in Outlook.

## Resolution

To resolve this issue, you can try one of the following options:

### Option 1

Follow these steps:

1. Connect the SharePoint Online Calendar to Outlook.
2. In Outlook view, create the recurring Calendar item directly instead of sending an email message to the SharePoint Online Calendar.

### Option 2

Browse to SharePoint Online to create all recurring Calendar items.
