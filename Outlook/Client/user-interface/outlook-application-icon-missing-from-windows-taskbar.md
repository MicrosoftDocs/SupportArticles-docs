---
title: Outlook icon missing from Windows taskbar
description: Provides a resolution to show the Outlook icon in the Windows taskbar.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook application icon missing from the Windows taskbar

_Original KB number:_ &nbsp; 2847732

## Symptoms

When you examine the Windows taskbar, the Outlook icon is not displayed even though Outlook is running and there is an Outlook icon in the notification area of the taskbar. The following figure demonstrates this problem.

:::image type="content" source="media/outlook-application-icon-missing-from-windows-taskbar/task-bar-not-show-outlook-icon.png" alt-text="Screenshot shows the Outlook icon doesn't display on the taskbar, but appears in the notification area." border="false":::

## Cause

This scenario occurs when you have enabled the Hide When Minimized option for Outlook and you minimize the main Outlook window. This option is available when you select the Outlook icon in the notification area.

:::image type="content" source="media/outlook-application-icon-missing-from-windows-taskbar/hide-when-minimized-option.png" alt-text="Screenshot shows the Outlook Hide When Minimized option is selected." border="false":::

## Resolution

To change your Outlook configuration so that the Outlook icon is displayed in the taskbar when Outlook is running, use the following steps:

1. Start Outlook if it is not running.
2. Select the Outlook icon in the notification area.
3. Select **Hide When Minimized**.

## More information

The **Hide When Minimized** option is controlled by the following registry data.

Key: `HKEY_CURRENT_USER\software\Microsoft\office\<x.0>\Outlook\Preferences`  
DWORD: MinToTray  
Values:  
0 (or missing DWORD value) = Outlook icon displayed in the taskbar when Outlook is running  
1 = Outlook icon is not displayed in the taskbar when Outlook is running and you minimize the Outlook window

> [!NOTE]
> The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010, 12.0 = Office 2007, 11.0 = Office 2003).
