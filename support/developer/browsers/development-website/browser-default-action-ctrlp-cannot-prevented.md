---
title: Browser default action for CTRL+P cannot be prevented
description: This article describes that browser default action for CTRL+P cannot be prevented.
ms.date: 01/04/2021
ms.reviewer: 
ms.topic: article
---
# Browser default action for CTRL+P cannot be prevented

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes that browser default action for **CTRL**+**P** cannot be prevented.

_Applies to:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 3167077

## Summary

Beginning in Internet Explorer 9, you cannot use the `preventDefault()` or `stopPropagation()` method to prevent the browser default action for the **Ctrl**+**P** key combination. The default action is to open the **Print** dialog box.

> [!NOTE]
> This action applies only if the page is rendered in standards mode.

If you try to attach a different action to this key combination, the attempt fails and the default action persists.

## More information

The following example demonstrates this behavior.

If Internet Explorer is running in standards mode, the following code does not prevent the default action:

```javascript
function handleKeyDown (oEvent) {
    if (oEvent.keyCode == 80 && oEvent.ctrlKey )
    {
        if (oEvent.preventDefault) oEvent.preventDefault();
        if (oEvent.stopPropagation) oEvent.stopPropagation();
    }
}
```

However, if Internet Explorer is running in IE5.5 quirks mode, you can use the following code, instead:

```javascript
function handleKeyDown (oEvent) 
{
    if (oEvent.keyCode == 80 && oEvent.ctrlKey )
    {
        // IE Quirks
        oEvent.returnValue = false;
        oEvent.keyCode = 0;
    }
}
```

> [!CAUTION]
> If you change the browser document mode, the page layout may be adversely affected.

## Status

This behavior is by design.
