---
title: Reset zoom level not respected if using script
description: Provides resolution to solve the issue that new windows that are created by using script do not honor the zoom level that is set by the Reset zoom level for new windows and tabs option in Internet Explorer 9 and later versions.
ms.date: 04/21/2020
---
# New Internet Explorer windows do not respect reset zoom level when using script

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about solving the issue that new windows that are created by using script do not honor the **Reset zoom level for new windows and tabs** setting in Internet Explorer 9 and later versions.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2741211

## Symptoms

Consider the following scenario. You use Internet Explorer 9 or a later version to browse to a page that has a zoom level other than 100%. This page contains a button that opens a new window with specific dimensions using script. You have the **Reset zoom level for new windows and tabs** option set under the **Advanced** tab of Internet Explorer **Internet Options**. When you click the button, the new window opens with the same zoom level as the parent window. This can cause some unexpected behavior on the child window where portions of the child window are not visible.

## Cause

In Internet Explorer 9 and later versions, windows created using the `window.open` API (as well as `showMod[al:eless]Dialog` and `createPopup`) have been designed to not honor the **Reset zoom level for new windows and tabs** setting and always inherit the zoom factor from their parent page.

## Resolution

The new window dimensions and the dimensions of the objects it contains can be scaled according to the zoom level that it inherits. The pertinent formulas are:

1. The actual zoom level can be calculated as:

    ```console
    var zoomLevel = window.screen.deviceXDPI / window.screen.logicalXDPI;
    ```

2. To counterscale an element, the formula is:

    ```console
    var objectWidth = desiredUnscaledWidth / zoomLevel;var objectWidth = desiredUnscaledWidth / zoomLevel;
    ```
