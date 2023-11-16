---
title: Text rendering problem on a TextBlock that's a child of a Viewbox
description: This article helps you troubleshoot a problem in which the text that's displayed on a custom text block doesn't render correctly.
ms.date: 04/17/2023
ms.custom: sap:Tools and utilities
ms.topic: troubleshooting
ms.reviewer: mihayash, davean, v-jayaramanp
---

# Old text persists in a TextBlock that's a child of a Viewbox

_Applies to:_ &nbsp;&nbsp;.NET Framework 4.0 or later

This article discusses a text rendering problem that occurs when the text that's displayed in a TextBlock control that's a child of a [Viewbox](/dotnet/desktop/wpf/controls/viewbox?view=netframeworkdesktop-4.8&preserve-view=true) control is modified.

## Symptoms

A TextBlock control (including derived classes) that's a child of a Viewbox control might leave artifacts on screen when the text is modified.

## Cause

The transform process that the Viewbox applies to the [TextBlock](/dotnet/api/system.windows.controls.textblock?view=windowsdesktop-8.0&preserve-view=true) can cause rounding errors as the Viewbox calculates the _dirty rectangle_ area whenever the text changes. Portions of the previous text might be left on the screen if the dirty rectangle isn't large enough to completely erase the previous text.

## Resolution

To fix this problem, use one of the following methods:

- Set the **[Background](/dotnet/api/system.windows.controls.textblock.backgroundproperty?view=windowsdesktop-8.0&preserve-view=true)** property to **Transparent**.
- Set the **[UseLayoutRounding](/dotnet/api/system.windows.frameworkelement.uselayoutrounding?view=windowsdesktop-8.0&preserve-view=true)** property to **True**.
- Don't host a TextBlock in a Viewbox.
