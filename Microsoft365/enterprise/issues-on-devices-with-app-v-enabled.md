---
title: Fixes for issues on devices with App-V enabled
description: Add-ins and LOB apps delivered with App-V fail to interact with installed Office apps, and using Internet Explorer to access documents on SharePoint doesn't interact properly with the installed Office apps. 
author: MaryQiu1987
manager: willchen
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.author: v-maqiu
---

# Fixes for issues on devices with App-V enabled and Office 365 ProPlus installed

## Symptoms

You experience one or more of the following issues on devices that are enabled for Microsoft Application Virtualization (App-V) and that have Office products such as Office 365 ProPlus deployed through the Click-to-Run technology.

- Add-ins and line-of-business (LOB) apps that are delivered through App-V cannot interact with the installed Office apps.
- When you try to use Internet Explorer to access documents on SharePoint, the browser cannot interact with the installed Office apps.
- Windows Explorer crashes when you right-click a file and then select **Send To** > **Mail recipient**.

## Resolution

To resolve these issues, create the following registry key, and then restart the device.

> [!WARNING]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) in case problems occur.

Subkey: [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClickToRun\OverRide]

Name: **AllowJitvInAppvVirtualizedProcess**

Type: **REG_DWORD**

Value: **1**

## More Information

Both App-V and Office Click-to-Run use virtualization technologies to manage the applications on the device. This key enables the installed Office Click-to-Run virtualization system to recognize App-V virtualization so that the two  technologies behave well together.