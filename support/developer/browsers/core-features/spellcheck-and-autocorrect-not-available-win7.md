---
title: Spell Check and Auto Correct features issue
description: This article describes other applications that host web browser controls on Windows 7 that don't support Internet Explorer's Spell Check and Auto Correct features.
ms.date: 06/09/2020
ms.reviewer: sansom
---
# Spell Check and Auto Correct features are not available for applications hosting WebBrowserControl on Windows 7

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about Spell Check and Automatic Correct introduced in Internet Explorer 10, but this feature is applicable to other applications that host Web browser controls on Windows 8.1 and later versions. Not for Windows 7.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10  
_Original KB number:_ &nbsp; 2870339

## Summary

**Spell Check and Auto Correct** features, introduced in Internet Explorer 10 is not available for other applications hosting the Web Browser Control on Windows 7. However, it is available for applications hosting Web Browser Controls on Windows 8.1

## More information

As of Internet Explorer 10, automatic spellcheck and autocorrection are enabled for certain elements in a webpage, including:

- `textArea` elements.
- elements with a `contentEditable` attribute set to `true`.
- elements with a `spellcheck` attribute set to `true`.

The **FEATURE_SPELLCHECKING** feature controls this behavior for Internet Explorer and for applications hosting the web browser control. When fully enabled, this feature automatically corrects grammar issues and identifies misspelled words for the conditions described earlier.

Spell Check and autocorrect works on Internet Explorer 10 on Windows 7, but this feature can't be extended to applications hosting the web browser control on Windows 7.

However, As a platform feature, it is available for Web Browser Control based applications on Windows 8.1.
