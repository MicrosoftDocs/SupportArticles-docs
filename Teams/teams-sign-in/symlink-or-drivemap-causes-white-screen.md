---
title: 'Using symlink or drivemap to C:\users causes Teams to open with white screen'
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: 'Resolves an issue where Teams will open with a white screen when mapped to C:\users.'
---

# Using a symlink or mapping a drive to C:\users causes Teams to start with a white screen

## Symptoms

When using a Unix symlink or mapping a drive to C:\users, the Teams app with start or launch to a white screen. 

## Cause

When Microsoft Teams is installed to Program Files using installation scripts rather than to the default location, the client will not auto-update when new versions are available.

## More information

This is by design. Make sure you install the application in the default location: `user\Appdata`. If the mapping must exist, use the web version of Microsoft Teams instead.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
