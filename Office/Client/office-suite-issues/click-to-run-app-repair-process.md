---
title: Repair process does not start for Office Click-to-Run application
description: Works around an issue in which the repair process for an Office 2013 or Office 2016 Click-to-Run application does not start. This issue occurs when you try to repair the application after the application crashes multiple times.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: Abdias Ruiz, offspms
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\InstallErrors\AppLaunchErrors
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office Professional Plus 2019
  - Office Standard 2016
  - Office Professional Plus 2016
  - Office Standard 2013
  - Office Professional Plus 2013
  - Office Professional 2013
  - Office Home and Student 2013
  - Office Home and Business 2013
ms.date: 06/06/2024
---

# Repair process for an Office Click-to-Run application does not start

## Symptoms

Assume that a Microsoft Office Click-to-Run application crashes multiple times when you try to start it, and then you receive the following message:

> Outlook failed to launch in safe mode. Do you want to start repair?

:::image type="content" source="media/click-to-run-app-repair-process/outlook-fail-to.png" alt-text="You receive a message that states that Outlook failed to launch in safe mode." border="false":::

When you click Yes in the dialog box, the repair process does not start.

## Cause

This is a known issue in Office Click-to-Run applications.

## Workaround

To repair the Office Click-to-Run application, follow these steps as appropriate for the version of Windows that the computer is running.

Windows 10, Windows 8.1 and Windows 8:

1. On the Windows Start screen, type **Control Panel**.
2. Click or tap **Control Panel**.
3. Under **Programs**, click or tap **Uninstall a program**.
4. Click or tap **Microsoft 365**, and then click or tap **Change**.
5. Click or tap **QuickRepair**, and then click or tap **Repair**. You may have to restart your computer after the repair process is complete.

Windows 7:


1. Click **Start**, and then click **Control Panel**.
2. Double-click **Programs and Features**.
3. Click **Microsoft 365**, and then click **Change**.
4. Select **Quick Repair**, and then click **Repair**. You may have to restart your computer after the repair process is complete.

   **Note** If the crash issue is not resolved after you use the Quick Repair option, use the Online Repair option as displayed in the following dialog box:

   :::image type="content" source="media/click-to-run-app-repair-process/repair-office-programs.png" alt-text="Select the Quick Repair option to repair office programs." border="false":::

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
