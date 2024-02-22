---
title: Cannot edit message subject
description: You cannot edit the message subject through Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013 Service Pack 1
search.appverid: MET150
ms.date: 10/30/2023
---
# You cannot edit the message subject through Outlook

_Original KB number:_ &nbsp; 4022843

## Symptoms

When you open a message in Outlook and select the subject, the text cursor does not appear, making it impossible to edit the subject of the message.

## Cause

This issue occurs when the message header is collapsed.

Outlook 2013 Service Pack 1 and newer versions can collapse the message header to compact the size of the message.

## Resolution

Expand the Outlook Infobar by selecting in the lower right arrow to expand the header for editing.

:::image type="content" source="media/cannot-edit-message-subject/expand-outlook-infobar.png" alt-text="Screenshot of the lower right arrow to expand the header.":::

## More information

In Outlook 2013, the default behavior is the expanded header while Outlook 2016 the default behavior is collapsed header. When the header is collapsed, the subject field is NOT editable.

We can change the default behavior of the Outlook to always expand the header using the registry key below:

`HKEY_CURRENT_USER\​SOFTWARE\​Policies\​Microsoft\​Office\​16.0\​outlook\​options\​mail`  
DWORD: MinimalHeaderOn  
Value: 0

0 = expanded  
1 = collapsed
