---
title: Text rendering problem on a TextBlock that's a child of a Viewbox
description: This article helps you troubleshoot a problem in which the text that's displayed on a custom text block doesn't render correctly.
ms.date: 04/17/2023
ms.custom: sap:Tools and utilities
ms.topic: troubleshooting
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: mihayash
---

# Old text persists in a TextBlock that's a child of a Viewbox

_Applies to:_ &nbsp;&nbsp;.NET Framework 4.0 or later

This article discusses a text rendering problem that occurs when the text that's displayed in a TextBlock control that's a child of a Viewbox control is modified.

## Symptoms

When you change the text in a TextBlock control (including derived classes) that's a child of a Viewbox, some of the original characters remain on the screen.

## Cause

The transform process that the Viewbox applies to the TextBlock can cause rounding errors as the Viewbox calculates the _dirty rectangle_ area whenever the text changes. Portions of the previous text might be left on the screen if the dirty rectangle isn't large enough to completely erase the previous text.

## Resolution

To fix this problem, use one of the following methods:

- Set the **Background** property to **Transparent**.
- Set the **UseLayoutRounding** property to **True**.
- Don't host a TextBlock in a Viewbox.
