---
title: Can't open or save files in Office programs
description: Fixes an issue in which errors occur in Office programs when you have the __COMPAT_LAYER environment variable and its value contains DisableThemes.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans, gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Word 2013
  - Microsoft Word 2010
  - Excel 2013
  - Excel 2010
  - PowerPoint 2013
  - PowerPoint 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Office program errors when DisableThemes is configured in the __COMPAT_LAYER environment variable

_Original KB number:_ &nbsp; 3028123

## Symptoms

Consider the following scenario when you are running Windows 7 or Windows 8.

- In Microsoft Word, when you attempt to open a document or save as, nothing appears to happen.
- In Microsoft Excel, when you attempt to open a spreadsheet or save as, nothing appears to happen.
- In Microsoft PowerPoint, when you attempt to open a presentation or save as, you receive the following error:

    > An error occurred while opening the file dialog. Please save your presentations, exit, and then restart PowerPoint.

    :::image type="content" source="./media/office-program-errors-when-disablethemes-configured/ppt-error.png" alt-text="Screenshot of the PowerPoint program error." border="false":::


- In Microsoft Outlook:
  - You click **Save As** with an email message and you receive the following error:

    > The server is not available. Contact your administrator if this condition persists.

  - You click **Open Calendar** or **Open Outlook Data File** on the Backstage and receive the following error:

    > The server is not available. Contact your administrator if this condition persists.

    :::image type="content" source="./media/office-program-errors-when-disablethemes-configured/outlook-error.png" alt-text="Screenshot of the Outlook program error." border="false":::

## Cause

These problems occur when you have the `__COMPAT_LAYER` environment variable and its value contains `DisableThemes`. This is shown in the following figure.

:::image type="content" source="./media/office-program-errors-when-disablethemes-configured/disablethemes-value.png" alt-text="Screenshot of the DisableThemes value in the __COMPAT_LAYER environment variable." border="false":::

## Resolution

To resolve this problem, remove the `__COMPAT_LAYER` System variable from **Environment Variables**.

1. Exit all Office programs.
2. Open **Advanced System** settings.
   - Windows 7:
     1. Click **Start**, right-click **Computer**, and then click **Properties**.
     2. Click **Advanced system** settings in the left pane.
   - Windows 8:
     1. Right-click the Windows icon, and then click **System**.
     2. Click **Advanced system** settings in the left pane.
3. On the **Advanced** tab, click **Environment Variables**.
4. Under **System variables**, select `__COMPAT_LAYER`, and then click **Delete**.
5. Start your Office program(s).
