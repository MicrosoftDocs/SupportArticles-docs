---
title: Invisible Solution Platform drop-down list
description: Works around a problem that you can't see the default Solution Platform drop-down list in Visual Studio 2013.
ms.date: 04/24/2020
ms.custom: sap:Team Explorer - Version Control\Other
ms.reviewer: lavonnec, cbrochu
---
# Solution Platform drop-down list isn't visible after you install Visual Studio 2013 Update 2

This article helps you resolve a problem where you can't see the default Solution Platform drop-down list in Microsoft Visual Studio 2013.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2954109

## Symptoms  

Consider the following scenario:

- You have Visual Studio 2013 installed on the computer.
- You select a profile in Visual Studio, and then you install Visual Studio 2013 Update 2. Or, you don't install Visual Studio 2013 Update 2.

In this scenario, by default, the Solution Platform drop-down list in Visual Studio isn't visible.

By default, the Solution Platform drop-down list is visible as a feature improvement in [Description of Visual Studio 2013 Update 2](https://support.microsoft.com/help/2927432) (refer to the following screenshot).

:::image type="content" source="./media/invisible-solution-platform-drop-down-list/solution-platform-drop-down-compare.png" alt-text="Screenshot shows the difference before and after VS 2013 update.":::

## Workaround 1: Install Visual Studio 2013 Update 2 if you don't

If you didn't select a profile, nor have you installed Visual Studio 2013 Update 2, you should install [Description of Visual Studio 2013 Update 2](https://support.microsoft.com/help/2927432) to resolve this issue.

Otherwise, you can try one of the following methods:

## Workaround 2: Customize the profile to add the Solution Platform

1. Open Visual Studio 2013.
2. Click **Standard Toolbar Options**.
3. Click **Add or Remove Buttons**.
4. Select **Solution Platforms**.

:::image type="content" source="./media/invisible-solution-platform-drop-down-list/add-remove-solution-platforms.png" alt-text="Screenshot shows steps to add or remove solution platforms.":::

## Workaround 3: Reset the profile

> [!NOTE]
> This method will discard any other customization to your IDE.

1. Open Visual Studio 2013.
2. Click **Tools**, and then select **Import and Export Settings**.
3. Select**Reset all settings**.
4. Select a location to back up your settings.
5. Select a profile.
6. Click **OK**.
