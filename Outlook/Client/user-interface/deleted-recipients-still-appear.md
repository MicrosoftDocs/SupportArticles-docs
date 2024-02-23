---
title: Deleted recipients still appear in the Drafts folder
description: Fixes an issue in which deleted recipients still appear in the list view of the Drafts folder in Outlook in Online mode.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: jmartine, excontent
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 10/30/2023
---
# Deleted recipients still appear in the list view of the Drafts folder in Outlook Online mode

_Original KB number:_ &nbsp; 3105651

## Symptoms

Consider the following scenario:

- You're using Microsoft Outlook in Online mode.
- You view a message in the Drafts folder.
- The draft message was previously saved by having users in the **To** field.
- You remove all recipients from the **To** field, and you resave the message.

In this scenario, the **To** field in the message itself is empty. However, the message entry that's displayed in the message list in the Drafts folder still displays the names of recipients. These persistent names are those that were removed after the message was last saved.

This issue occurs only if the **To** field is completely emptied.

This issue doesn't occur in Outlook in Cached Exchange mode or in Outlook Web App.

## Cause

This issue occurs because the `PR_DISPLAY_TO` property on the message is not cleared when the last recipient is removed from the message's recipient table.

## Workaround

To work around this issue, enter at least one of the intended recipients to reset the view. This causes the recipient table to be re-created and the `PR_DISPLAY_TO` property to be updated.
