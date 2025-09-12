---
title: The specified program requires a newer version of Windows
description: Provides a resolution for the error "The specified program requires a newer version of Windows".
ms.date: 04/07/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Error "The specified program requires a newer version of Windows"

This article provides a resolution for the error "The specified program requires a newer version of Windows".

_Applies to:_&nbsp;Visual Studio 2015

## Symptoms

You want to install Visual Studio 2015 on a computer that already has Windows 7 SP1 or newer installed, but you receive the following error message:

> The specified program requires a newer version of Windows

## Resolution

You may receive this error during a Visual Studio 2015 installation due to automatically applied compatibility settings that lower the Windows run-time incorrectly. To work around this issue, follow these steps to remove compatibility settings in the Visual Studio installer:

1. Right-click the **Visual Studio Installer** icon.
1. Select **Properties** > **Compatibility**.
1. Select **Change settings for all users**.
1. Uncheck **Run this program in compatibility mode for:** and select your operating system.
1. Select **Ok**.
1. Exit the configuration window.
1. Launch Visual Studio Installer again.
