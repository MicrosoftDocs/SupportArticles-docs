---
title: Outlook 2010 crashes unexpectedly at startup
description: Provides a resolution to solve the crash issue that occurs when starting Outlook 2010.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: dthayer, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook 2010 crashes unexpectedly at startup

## Symptoms

Microsoft Outlook crashes unexpectedly at startup. If you look in the Event Viewer for the following:

> **Source**: Application Error  
> **EventID**: 1000

you will find the event description contains parameters that resemble the following error signatures:

> **Application Name**: Outlook.exe  
> **Application Version**: 14.0.4760.1000  
> **Module Name**: Kernelbase.dll  
> **Module Version**: 6.1.7600.16385  
> **Offset**: 0x00009617  
> **Application Name**: Outlook.exe  
> **Application Version**: 14.0.4760.1000  
> **Module Name**: kernel32.dll  
> **Module Version**: 5.1.2600.2945  
> **Offset**: 0x00012a5b

## Cause

This problem occurs if you have an older version of olmapi32.dll or mso.dll on the workstation.

## Resolution Step 1 - Remove earlier versions of Outlook

To resolve this problem, remove any earlier Outlook versions from your system. If you have some components of an earlier version of an Office suite installed and you no longer require them, you can remove the Office suite completely. If you do not have Office 2003 or Outlook 2003 installed, proceed with Step 2 below.

To remove only the Outlook component, follow these steps:

For Windows XP:

1. Select **Start**, select **Run**, type _appwiz.cpl_ in the **Open** box, and then press ENTER.
2. If Outlook was installed as a standalone product, select Outlook from the application list, and then select **Remove**.
3. If Outlook was installed as a part of an Office suite, select the Office product from the application list, and then select **Change**. Use the **Add or Remove Features** option to remove the Outlook application (or set it to "Not Available").

For Windows Vista and Windows 7:

1. Select **Start**, type _programs and features_ in the **Search** box, and then press ENTER.
2. If Outlook was installed as a standalone product, select Outlook from the list of installed products. Then, select **Uninstall** from the bar that displays the available tasks.
3. If Outlook was installed as a part of an Office suite, select the Office product from the list of installed products. Then, select **Change** from the bar that displays the available tasks. Use the **Add or Remove Features** option to remove the Outlook application (or set it to "Not Available").

## Resolution Step 2 - Repair Office 2010

To repair Office 2010 on your system, follow these steps:

For Windows XP:

1. Select **Start**, select **Run**, type _appwiz.cpl_ in the **Open** box, and then press ENTER.
2. Select **Microsoft Office 2010** from the list, and then select **Change**.
3. In the Microsoft Office setup dialog that appears, choose **Repair**, then select **Continue**.

For Windows Vista and Windows 7:

1. Select **Start**, type _programs and features_ in the **Search** box, and then press ENTER.
2. In the list of installed programs, right-click **Microsoft Office 2010**, and then select **Repair**.
