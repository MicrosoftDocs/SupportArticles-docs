---
title: Can't find Windows 10 developer tools
description: This article provides resolution to the issue where you can't find Windows 10 developer tools (SDK) in Visual Studio 2015.
ms.date: 05/18/2022
author: jasonchlus
ms.author: jasonchlus
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.reviewer: terry.g.lee
ms.topic: troubleshooting
---

# Can't find Windows 10 developer tools in Visual Studio 2015

This article helps you resolve the issue where you can't find Windows 10 developer tools (SDK) in Visual Studio 2015.

_Applies to_: Visual Studio 2015

## Symptoms

You've installed Visual Studio 2015 on your Windows 10 but you're unable to find Windows 10 developer tools on your system.

## Cause

If you've chosen the default installation option when installing Visual Studio 2015, custom components such as Windows 10 developer tools don't install.

## Resolution

To install custom components such as Windows developer tools in Visual Studio 2015, follow these steps:

1. Right-click the **Start** menu, and then select **Run**.

1. In the **Run** window, enter *appwiz.cpl*, and then select **OK**.

1. On the **Programs and features** window, right-click the **Microsoft Visual Studio \<Edition\> 2015** or the **Microsoft Visual Studio \<Edition\> 2015 Updates** program, and then select **Change**.

1. On the **Visual Studio 2015 Setup wizard** window, select **Modify**.

1. In the **Select features** list, select the items that you want to install, and then select **Next**.

    > [!TIP]
    > For installing Windows 10 developer tools, select **Windows 10 SDK feature**.

1. Select **Update** to install the selected custom components.
