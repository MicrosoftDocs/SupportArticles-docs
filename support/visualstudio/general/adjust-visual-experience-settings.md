---
title: Adjust visual experience settings
description: This article describes how to make visual experience settings  adjustments in Visual Studio 2010.
ms.date: 04/24/2020
ms.prod-support-area-path: Integrated development environment (IDE)
ms.reviewer: jbartlet
ms.topic: how-to
---
# Adjust Visual Studio 2010 visual experience settings

This article introduces how to adjust Microsoft Visual Studio 2010 visual experience settings.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2023207

## Symptoms

By default, Visual Studio 2010 automatically adjusts the Visual Studio visual experience to maximize performance and responsiveness across client configurations. For example, the use of gradients and animations in the Visual Studio integrated development environment (IDE) is reduced when running Visual Studio over Remote Desktop or in a virtual machine environment. By default Visual Studio 2010 also makes use of hardware graphics acceleration when it's available on the client. For most customers, these Visual Studio default settings will provide the best user experience, however there can be situations, for example because of bugs in a graphics hardware driver, where manual adjustments will result in an improved experience.

Examples of symptoms that may be resolved through manual adjustments include:

- The Visual Studio main window does render correctly or completely.
- A Visual Studio window contains blurry or distorted text and icons.

## Override Visual Studio visual experience

The Visual Studio visual experience settings are available from **Tools** > **Options**, on the **Environment** > **General** page:

:::image type="content" source="./media/adjust-visual-experience-settings/visual-experience-settings.png" alt-text="show the Visual Studio visual experience option":::

The status text beneath the settings checkboxes describes the current visual experience configuration; this text is only updated after changes have been applied.

To override Visual Studio automatic settings:

- Unselect the **Automatically adjust visual experience based on client performance** checkbox.
- Check or unselect the **Enable rich client visual experience** checkbox to ensure rich visuals are always on or off respectively. When checked, rich visuals will be used independent of machine environment, for example when running locally on a rich client and over remote desktop.
- Check or unselect the **Use hardware graphics acceleration if available** checkbox to force or block use of hardware graphics acceleration when it's available.

    Forcing hardware graphics acceleration off can resolve Windows Presentation Foundation (WPF) rendering issues that are because of driver issues, but before doing so, customers should ensure that they have the latest graphics drivers installed.

    By default Visual Studio won't use hardware graphics acceleration and not provide a rich client visual experience when running in Virtual Machine environments and on servers with Hyper-V enabled. Customer that chooses to override these settings should consider reverting back to the default settings (check the **Automatically adjust visual experience based on client performance** checkbox) if they experience rendering or performance issues.
