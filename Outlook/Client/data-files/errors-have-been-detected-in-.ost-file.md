---
title: Errors have been detected in .ost file
description: Describes an issue where you receive Errors have been detected in the .ost file error. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Errors have been detected in your .ost file in Outlook

_Original KB number:_ &nbsp; 3186812

## Symptoms

In Microsoft Outlook 2013 or later versions, you receive the following error message:

> Errors have been detected in the file C:\Users\<name>\AppData\Local\Microsoft\Outlook\user@org.com.ost

When you examine the application event log, you find an event with ID 2000.

## Cause

Corruption is detected in your offline Outlook Data File (`.ost`).

## Resolution

To resolve this issue, delete your `.ost` file and that you let Outlook redownload the information from the server that is running Microsoft Exchange Server.

1. Close Outlook.
2. Browse to the following location:

   %localappdata%\Microsoft\outlook

3. Find the `.ost` file that the error message reported to have errors, and then delete it.
4. Start Outlook.

## More information

In earlier versions of Outlook, we previously recommended that you use the Scanost.exe tool for errors that occur with your offline Outlook Data File (`.ost`). The Scanost.exe tool is no longer available starting in Outlook 2010. We now recommend that you delete your offline Outlook Data File (`.ost`) and that you let Outlook redownload the information from the server that is running Exchange Server.

You can use the following steps to review the Application event log:

1. In Control Panel, open **Administrative Tools**.
2. Double-click **Event Viewer**.
3. In the left pane, select **Application** under **Windows Logs**.
4. In the **Actions** pane, select **Filter Current Log**.
5. In the **Filter Current Log** dialog box, enter *2000* and then select **OK**.
