---
title: Can't access PowerShell.exe when installing Microsoft 365 apps
description: Provides a workaround for an issue in which you can't install Microsoft 365 apps because PowerShell is blocked.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 171120
  - CSSTroubleshoot
ms.reviewer: balram, bcorob, ansons
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Apps for business
  - Office 2021
  - Office 2019
search.appverid: MET150
ms.date: 1/19/2023
---

# "Windows cannot access the specified device, path, or file" error when installing Microsoft 365 apps

## Symptoms

When you install Microsoft 365 apps from [Microsoft 365 portal](https://www.office.com/?auth=2) or by using enterprise deployment methods, you receive the following error message about the *PowerShell.exe* file:

> Windows cannot access the specified device, path, or file. You may not have the appropriate permissions to access the item.

:::image type="content" source="media/cannot-access-powershell-file-error/powershell-file-error.png" alt-text="Screenshot of the error message that indicates Windows cannot access the PowerShell.exe file.":::

This error will also occur in the following scenarios:

- Add language packs or products like Visio or Project to your device where Microsoft 365 apps are already installed.
- Online repair Microsoft 365 apps.
- Uninstall Microsoft 365 apps.

**Important:** If you set [**Display Level**](/deployoffice/office-deployment-tool-configuration-options#display-element) to **None** (Display Level = "None") when you use the Office Deployment Tool, the installation fails silently or gets stuck in the background.

## Cause

This error occurs for one or both of the following reasons:

- PowerShell is blocked or restricted with permissions by a policy.
- PowerShell is blocked by your security software.

## Workaround

**Note:** You must have administrator permissions to perform the following actions.

To work around this issue, enable *PowerShell.exe* only during the scenario where the error occurs. After the error is fixed, block or disable PowerShell.exe again on the device.

## Status

Microsoft is aware of this issue and will post more information in this article when the information or a fix becomes available.
