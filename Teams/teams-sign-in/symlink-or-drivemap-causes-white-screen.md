---
title: Using a symlink or drive map causes Teams to open with white screen
ms.author: meerak
author: Cloud-Writer
ms.date: 03/14/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Identity and Auth\
  - CI 113425
  - CI 187816
  - CSSTroubleshoot
ms.reviewer: scapero
description: Resolves an issue where Teams opens with a white screen when you use a Unix symlink or drive map to C:\users.
---

# Teams starts with a white screen

## Symptoms

When you use a Unix symlink or map a drive to C:\users, a white screen appears when the Teams app starts.

## Cause

When you use an installation script to install Microsoft Teams to Program Files instead of the default location, the client won't automatically update when a new version is available. This is an expected limitation of Teams if the installation location is changed by a custom script.

## Resolution

Make sure that you install the application in the default location: `user\Appdata`. If the mapping must exist, use the web version of Microsoft Teams instead.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
