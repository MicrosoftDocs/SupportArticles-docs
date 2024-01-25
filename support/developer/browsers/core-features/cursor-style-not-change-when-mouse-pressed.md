---
title: Cursor style remains when mouse is pressed
description: Provides a resolution to a by design behavior that the cursor style not changing when the mouse button remains pressed in Internet Explorer 9 and later versions.
ms.date: 04/21/2020
ms.reviewer: jeanr
---
# Cursor style does not change when the mouse button gets pressed in Internet Explorer 9 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about solving the issue that the cursor style of a hovered DOM element does not change when the mouse button remains pressed in Internet Explorer 9 and later versions.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2743603

## Symptoms

In Internet Explorer 9 and later versions, the cursor style of a hovered DOM element is ignored if the mouse button remains pressed and then remains pressed outside of the particular DOM element. This may be observed if a web page has implemented a *DragAndDrop* functionality in which the cursor style is used to visualize whether a drop zone allows dropping or not.

This behavior only occurs when a `<div>` tag is implemented as follows:

```html
<div style="cursor: wait;"></div>
```

If you are outside of this div area and you press the mouse button and keep it pressed while moving into the area, the cursor will not change once entering this area.

## Cause

This behavior is by design beginning in Internet Explorer 9.

## Resolution

To modify this behavior, use the `onmouseover` and `onmouseout` events as follows:

```html
<div onmouseover="this.style.cursor='wait'" onmouseout="this.style.cursor='pointer'" ></div>
```
