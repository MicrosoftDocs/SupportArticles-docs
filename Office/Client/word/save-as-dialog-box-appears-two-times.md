---
title: Save As dialog box appears two times
description: This article provides a resolution for the problem where the Save As dialog box appears two times when you save a file in Word.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Save
  - CSSTroubleshoot
appliesto: 
- Word 2013
- Word 2016
- Word 2019
- Word 2021
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# The Save As dialog box appears two times when you try to save a file in Word

When you select **Save** or **Save As**  to save a file in Microsoft Word, the **Save As**  dialog box appears two times.

:::image type="content" source="media/save-as-dialog-box-appears-two-times/save-as-dialog-box.png" alt-text="Screenshot of Save As in Microsoft Word.":::

## Cause

This problem occurs because the Normal.dotm template is corrupted.

## Resolution

To resolve this problem, create a new Normal.dotm file by changing the name of the old file. To do this, follow these steps:

1. Start Windows Explorer, type *%appdata%\Microsoft\Templates* in the address bar, and then select **Enter**.

   :::image type="content" source="media/save-as-dialog-box-appears-two-times/address-bar-in-windows-explorer.png" alt-text="Screenshot of typing %appdata%\Microsoft\Templates in the address bar of Windows Explorer.":::

2. Right-click **Normal.dotm**, and then select **Rename**.

   :::image type="content" source="media/save-as-dialog-box-appears-two-times/rename-option-to-normal-dotm.png" alt-text="Screenshot of right-click Normal.dotm and select Rename.":::

3. Change the file name to *Normal.old.dotm*.

   :::image type="content" source="media/save-as-dialog-box-appears-two-times/change-file-name.png" alt-text="Screenshot of changing the file name to Normal.old.dotm.":::

4. Restart Word. A **Normal.dotm** template is automatically generated.

   :::image type="content" source="media/save-as-dialog-box-appears-two-times/template-of-normal-dotm.png" alt-text="Screenshot of generated Normal.dotm.":::

5. Try to save a file to check whether the problem is resolved.
