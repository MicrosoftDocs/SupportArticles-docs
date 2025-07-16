---
title: Text Rendering Issue if a TextBlock is the Child of a Viewbox
description: This article helps you troubleshoot a TextBlock that displays artifacts of old text if the TextBlock is the child of a Viewbox.
ms.date: 07/08/2025
ms.custom: sap:Class Library Namespaces
ms.reviewer: mihayash, davean, v-jayaramanp
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer, I want to fix old text that persists in a TextBlock so that my application renders the updated text correctly.
---

# Old text persists if a TextBlock is the child of a Viewbox

_Applies to:_ .NET Framework 4.0 or later

This article discusses a text rendering issue that can occur if a TextBlock is the child of a [Viewbox](/dotnet/desktop/wpf/controls/viewbox?view=netframeworkdesktop-4.8&preserve-view=true) and the TextBlock's content is modified.

## Symptoms

When you update the content of a TextBlock (including derived classes) that's inside a Viewbox, remnants of the previous text remain visible on the screen.

## Cause

The transform process that the Viewbox applies to the [TextBlock](/dotnet/api/system.windows.controls.textblock?view=windowsdesktop-8.0&preserve-view=true) can cause rounding errors when the Viewbox calculates the _dirty rectangle_ area after the TextBlock's content changes. Portions of the previous text might be left on the screen if the _dirty rectangle_ isn't large enough to completely erase the previous text.

## Solution

To fix this problem, use one of the following methods:

- Set the **[Background](/dotnet/api/system.windows.controls.textblock.backgroundproperty?view=windowsdesktop-8.0&preserve-view=true)** property to **Transparent**.
- Set the **[UseLayoutRounding](/dotnet/api/system.windows.frameworkelement.uselayoutrounding?view=windowsdesktop-8.0&preserve-view=true)** property to **True**.
- Don't host a TextBlock in a Viewbox.
