---
title: Invalid HTML in Internet Explorer design mode
description: Internet Explorer 9 or a later version creates invalid HTML in design mode. A workaround is provided.
ms.date: 04/21/2020
ms.reviewer: apinho
---
# Internet Explorer 9 or a later version may generate invalid HTML in design mode

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a workaround to solve the invalid HTML that's created by Internet Explorer 9 or a later version in design mode.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2667114

## Symptoms

A user loads the following code in Internet Explorer 9 or a later version and renders it in Internet Explorer 9 Standards mode:

```aspx-csharp
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <title>HR</title>
    </head>
    <body contentEditable="true" onload="document.body.focus()">
        <hr>
    </body>
</html>
```

In this scenario, it is possible that the typed text in the editable element is included in the `<hr>` element, which is invalid. The problem can occur under the following circumstances:

- No mouse click is performed in the editable element that receives the focus.
- If the text is typed after the `<hr>` element, it is possible to type text inside the `<hr>` element, being positioned there by using the arrow keys.

## Workaround

To work around this problem, use one of the following options:

1. Insert a mouse-click inside of the element before typing.
2. Place another element, such as a `<div>` or a `<span>`, directly before the `<hr>` element.
3. Render the page using any other document mode besides Internet Explorer 9 or a later version Standards mode.
