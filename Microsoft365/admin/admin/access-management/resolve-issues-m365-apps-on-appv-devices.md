---
title: Resolve issues when using Microsoft 365 apps on App-V enabled devices
description: Provides a resolution to ensure that Microsoft 365 Apps are accessible to add-ins and LOB apps in App-V enabled devices.
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
- CSSTroubleshoot
- CI 7326
- CI 8349
ms.topic: troubleshooting
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 11/20/2025
---

# Resolve issues when using Microsoft 365 Apps on App-V enabled devices

## Symptoms

You experience one or more of the following issues on devices that are enabled for Microsoft Application Virtualization (App-V) and that have Microsoft 365 Apps for enterprise deployed through the Click-to-Run technology.

- Add-ins and line-of-business (LOB) apps that are delivered through App-V cannot interact with the installed Office apps.
- When you try to use [IE mode in Microsoft Edge](/deployedge/edge-ie-mode) to access documents on SharePoint, the browser cannot interact with the installed Office apps.
- Windows Explorer crashes when you right-click a file and then select **Send To** > **Mail recipient**.

## Resolution

To resolve these issues, create the following registry key, and then restart the device.

[!INCLUDE [Important registry alert](../../../../includes/registry-important-alert.md)]

Both App-V and Office Click-to-Run use virtualization technologies to manage the applications on the device. This key enables the installed Office Click-to-Run virtualization system to recognize App-V virtualization so that the two technologies work well together.

Subkey: [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClickToRun\OverRide]

Name: **AllowJitvInAppvVirtualizedProcess**

Type: **REG_DWORD**

Value: **1**
