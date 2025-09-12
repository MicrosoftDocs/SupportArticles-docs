---
title: Error 0x8004de80 or 0x8004de86 when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004de80 or 0x8004de86.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 167727
  - CSSTroubleshoot
ms.reviewer: prbalusu, salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---

# Error 0x8004de80 or 0x8004de86 when signing in to OneDrive

## Symptoms

When you try to sign in to Microsoft OneDrive, you can't sign in, and you receive error code 0x8004de80 or 0x8004de86.

## Cause  

This issue might occur for the following reasons:

- A problem affects your OneDrive account or configuration.
- Identity problems exist between multiple accounts.

To resolve this issue, try the following solutions.

## Solution 1: Unlink and relink OneDrive  

If you've added a different account or old account to OneDrive, unlink the account and relink OneDrive to a correct account. For more information, see [Unlink and relink OneDrive](https://support.microsoft.com/office/unlink-and-re-link-onedrive-3c4680bf-cc36-4204-9ca5-e7b24cdd23ea).

## Solution 2: Uninstall and reinstall OneDrive  

**Note:** You won't lose any data by resetting or uninstalling OneDrive.

1. Select the Windows logo key (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de80-or-0x8004de86/windows-icon.png":::), type *Programs* in the search box, and then select **Add or remove programs**.
1. Under **Apps & features**, find and select **Microsoft OneDrive**.
1. Select **Uninstall**.
1. Download the [Microsoft OneDrive app](https://www.microsoft.com/microsoft-365/onedrive/download) from the website.
1. Open the downloaded file, and follow the prompts to sign in and get started.

For more information, see [Reinstall OneDrive](https://support.microsoft.com/office/reinstall-onedrive-0660f354-6a69-46eb-b817-7f4e0d7b45b5).

## Solution 3: Clear out multiple identities

To clear out multiple identities, [remove the cached Office account identities from the registry](sign-into-onedrive-error-0x8004dec5.md#resolution).
