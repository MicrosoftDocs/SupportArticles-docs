---
title: Performance issues in Visual Studio
description: This article discusses intermittent performance issue, product crashes, or rendering issues in Visual Studio 2013 if you use hardware acceleration or the default.
ms.date: 04/13/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: Ashok Kamath, meyoun
---
# Performance issues, product crashes, or rendering issues in Visual Studio 2013 and later

This article provides workarounds for intermittent performance issue, product crashes, or rendering issues in Microsoft Visual Studio 2013.

_Original product version:_ &nbsp; Visual Studio 2013, 2015, 2017  
_Original KB number:_ &nbsp; 2894215

## Symptoms

If you have hardware acceleration enabled, or if you use the default visual experience settings in Visual Studio 2017, Visual Studio 2015 and Visual Studio 2013, you may experience intermittent performance issues, product crashes, or rendering issues.

## Cause

These issues may occur because of bugs in the installed graphics driver.

> [!NOTE]
> The Visual Studio team has continued to notice a small but important series of performance and reliability issues that are caused by bugs in the installed graphics drivers. By default, Visual Studio automatically adjusts the visual experience in order to maximize performance and responsiveness across client configurations. Visual Studio also uses hardware graphics acceleration when it is available on the client. For most customers, these Visual Studio default settings provide the best user experience. However, some users have reported that manual adjustments to these settings can result in improved experience. This article describes how to make these adjustments in Visual Studio.

## Workarounds

To work around these issues, use one of the following methods:

- Install the latest graphics drivers.

    > [!NOTE]
    > Outdated drivers are a common source of Windows Presentation Foundation (WPF) rendering issues.

- Turn off hardware graphics acceleration to switch to software rendering. To do this, follow these steps:
    1. In Visual Studio, click **Tools** > **Options**.
    2. In the **Options** dialog box, clear the **Automatically adjust visual experience based on client performance** check box. (Refer to the following screenshot for this step.)

        :::image type="content" source="media/performance-crash-issue/automatically-adjust-visual-experience-based-on-client-performance.png" alt-text="Screenshot of the Options window showing the Automatically adjust visual experience based on client performance checkbox is cleared.":::

    3. Clear the **Use hardware graphics acceleration if available** check box to prevent the use of hardware graphics acceleration.

    4. Select or clear the **Enable rich client visual experience** check box to make sure that rich visuals are always on or off, respectively. When this check box is selected, rich visuals are used independent of the computer environment. For example, rich visuals are used when you run Visual Studio locally on a rich client and over remote desktop.
