---
title: An error has occurred when you load an Access web app in Internet Explorer
description: Describes an issue that triggers an Error has occurred. Sorry, something went wrong. Please try again later error. Occurs when you try to load a Microsoft Access web app in Internet Explorer. A resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
search.appverid: 
  - MET150
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
ms.date: 03/31/2022
---

# "An error has occurred" message when you load an Access web app in Internet Explorer

## Symptoms

When you try to load a Microsoft Access web app in Internet Explorer, the app may not load completely, and then you receive an "Error has occurred. Sorry, something went wrong. Please try again later" error message.

:::image type="content" source="media/load-access-web-app-in-ie/error-message.png" alt-text="Screenshot of the error message when the app may not load completely." border="false":::

> [!NOTE]
> The "TECHNICAL DETAILS" section of the error does not show a value for the Correlation ID.

## Cause

Internet Explorer imposes a time-out limit for the server to return data through the ReceiveTimeout registry key. The value that's specified for this time-out may have been changed to a value that's less than what's needed for the server to respond to the Access app request.

## Resolution

To resolve this issue, change the default time-out setting for Internet Explorer by following these steps:

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

1. Start Registry Editor.
2. Locate the following subkey:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`

3. In this subkey, add a `ReceiveTimeout` DWORD entry that has a value of (\<number of seconds>)\*1000. For example, if you want the time-out duration to be 5 minutes, set the value of the `ReceiveTimeout` entry to 300000 (\<300>*1000).
4. Restart the computer.

> [!NOTE]
> This setting becomes the new global timeout which applies to both Internet Explorer and any WinINet application.
