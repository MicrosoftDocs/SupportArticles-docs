---
title: TableLayoutPanel displays with large spaces
description: This article describes a layout problem when you use TableLayoutPanel controls in a Windows Forms application on high-DPI monitors.
ms.date: 05/08/2020
ms.reviewer: amymcel, davean, danru, valerieg
---
# Nested TableLayoutPanel is displayed with large empty spaces in a Windows Forms application on high-DPI monitors

This article resolves the problem where nested TableLayoutPanel is displayed with large empty spaces in a Windows Forms application on high-DPI monitors.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 3044516

## Symptoms

When you run a Windows Forms application that contains nested TableLayoutPanel controls and these layouts in turn contain controls with nonzero **Margins** or **Padding** properties on an operating system with high display resolution enabled, the **Margins** and **Padding** of such controls will be scaled up exponentially for how many times the TableLayoutPanel controls are nested. This results in the application displaying controls with disproportionately large empty spaces.

## Cause

The current implementation of TableLayoutPanel does a separate scaling pass for each level of nesting. When the resolution of the display is set to 100% that isn't a problem but with larger resolutions the scaling is cumulative and results in unexpectedly large numbers. The problem affects only the **Margins** or **Padding** properties of the controls inside TableLayoutPanel.

## Resolution

To resolve this issue, set **Margins** or **Padding** to zero and use alternative ways of achieving space between controls or avoid nesting TableLayoutPanel controls.

## More information

The TableLayoutPanel control simplifies the positioning and sizing of any windows forms by arranging them in arbitrary table-like layouts. When TableLayoutPanel control calculates the appropriate sizes for each control in the layout, TableLayoutPanel will scale the margins and any surrounding padding of the control according to the current DPI settings so that the overall look of the layout stays the same regardless of resolution. When one of these controls is another nested TableLayoutPanel, the scaling will be applied over what these controls have already calculated its margins and padding to be. This results in the unexpected large margins and padding.

For more information about how to design the layout of Windows Forms, see
 [Designing the layout of Windows Forms by using a TableLayoutPanel](http://www.codeproject.com/tips/842418/designing-the-layout-of-windows-forms-using-a).
