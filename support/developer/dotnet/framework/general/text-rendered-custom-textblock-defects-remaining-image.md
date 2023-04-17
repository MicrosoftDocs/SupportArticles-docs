---
title: Text rendering issues on a TextBlock that's a child of a Viewbox
description: This article helps to troubleshoot a problem where the text displayed on a custom text block may not render correctly.
ms.date: 04/17/2023
ms.custom: sap:Tools and utilities
ms.topic: troubleshooting
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: mihayash
---

# Text rendering issues on a TextBlock that's a child of a Viewbox

_Applies to:_ &nbsp;&nbsp;.NET Framework 4.0 or later

This article discusses text rendering issues that may occur when the text displayed in a TextBlock (that's a child of a viewBox) is modified.

## Symptoms

Consider a scenario when you change the text, a `TextBlock` control (including derived classes) that's a child of a viewBox might leave remaining text on the screen.

## Cause

The transform that the viewBox applies to the TextBlock can cause rounding errors when calculating the dirty rectangle whenever the text changes. Portions of the previous text may be left on screen if the dirty rectangle isn't large enough to completely erase the previous text.

## Resolution

You can fix the problem by using one of the following methods:

- Set the Background property to Transparent.
- Set the UseLayoutRounding property to True.
- Don't host a TextBlock in a Viewbox.
