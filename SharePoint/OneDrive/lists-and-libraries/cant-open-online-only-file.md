---
title: Can't open online-only file error when opening a file in OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - OneDrive
ms.custom: 
  - CI 113498
  - CSSTroubleshoot
ms.reviewer: hdonald
description: Describes how to resolve an issue where you can't open a file in OneDrive.
---

# "Can't open online-only file" error when opening a file in OneDrive

## Symptoms

When opening an online-only file in your OneDrive folder, you receive the following error:

> Can't open online-only file<br />
Make sure you're connected to the internet, then try again.<br />
We can download the file next time you're online.

The error displays even when you are online.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Ensure that Windows 10 version 1809 or newer is installed. For more information, see [Update Windows 10](https://support.microsoft.com/help/4027667/windows-10-update).
2. Using Registry Editor, navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\UEV\Agent\Configuration.
3. Right-click **Configuration**, select **New** > **DWORD** value.
4. Name the value **ApplyExplorerCompatFix** with a value of 1.
5. Close Registry Editor and open the online-only file.
