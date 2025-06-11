---
title: Can't Access PowerShell.exe When You Install Microsoft 365 Apps
description: Provides a workaround for an issue that prevents you from installing Microsoft 365 apps because PowerShell is blocked.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CI 171120
  - CSSTroubleshoot
ms.reviewer: balram, bcorob, ansons
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Apps for business
  - Office 2021
  - Office 2019
search.appverid: MET150
ms.date: 06/11/2025
---

# Error "Windows cannot access the specified device, path, or file" when you install Microsoft 365 apps

## Symptoms

When you install Microsoft 365 apps from [Microsoft 365 portal](https://www.office.com/?auth=2) or by using enterprise-level deployment methods, you receive the following error message about the *PowerShell.exe* file:

> Windows cannot access the specified device, path, or file. You may not have the appropriate permissions to access the item.

:::image type="content" source="media/cannot-access-powershell-file-error/powershell-file-error.png" alt-text="Screenshot of the error message that indicates Windows cannot access the PowerShell.exe file.":::

This error also occurs in the following scenarios:

- Adding language packs or products such as Microsoft Visio or Microsoft Project to your device if Microsoft 365 apps are already installed
- Making online repairs of Microsoft 365 apps
- Uninstalling Microsoft 365 apps

**Important:** If you set [**Display Level**](/deployoffice/office-deployment-tool-configuration-options#display-element) to **None** (Display Level = "None") when you use the Office Deployment Tool, the installation fails without generating an error message or any progress bars.

## Cause

This error occurs for one or both of the following reasons:

- Permissions for PowerShell.exe are restricted or blocked by a policy.
- PowerShell is blocked by your security software.

## Workaround

**Note:** You must have administrator permissions to take the following actions.

To work around this issue, enable *PowerShell.exe* only during the scenario in which the error occurs. After the error is fixed, block or disable *PowerShell.exe* again on the device.

## Status

Microsoft is researching this problem and will post more information in this article when it becomes available.
