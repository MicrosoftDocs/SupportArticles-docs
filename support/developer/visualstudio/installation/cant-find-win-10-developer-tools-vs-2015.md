---
title: Can't find Windows 10 developer tools in Visual Studio 2015
description: This article discusses the problem where you can’t find Windows 10 developer tools when they aren't turned on by default in Visual Studio 2015.
ms.date: 05/18/2022
author: jasonchlus
ms.author: jasonchlus
ms.custom: sap:Installation
ms.reviewer: terry.g.lee
---

# Can't find Windows 10 developer tools in Visual Studio 2015

This article discusses the problem where you can’t find Windows 10 developer tools when they aren't turned on by default in Visual Studio 2015.

## Symptoms

You've installed Visual Studio 2015 on your Windows 10 but you're unable to find Windows 10 developer tools on your system.

## Cause

During setting up Visual Studio 2015, if you've selected the Default option in the type of installation on Windows 10, custom components such as Windows 10 developer tools might not be installed because these features remain turned off by default.

## Resolution

To install custom components such as developer tools in Visual Studio 2015, follow these steps:

1. Go to **Start**>**Run**, type *appwiz.cpl*, and then select **OK**.

1. On the Programs and features window, right-click **Microsoft Visual Studio \<Edition\> 2015** or **Microsoft Visual Studio \<Edition\> 2015 Updates**, and then select **Change**.

1. In the **Visual Studio 2015 Setup wizard**, select **Modify**.

1. In the **Select features** list, select the items that you want to install, and then select **Next**.

> [!TIP]
> For Windows 10 developer tools, select **Windows 10 SDK feature**.

1. Select **Update** to install the selected custom components.
