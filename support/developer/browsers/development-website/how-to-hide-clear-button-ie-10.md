---
title: Hide the Clear button in Internet Explorer
description: This article describes that when the Internet Explorer text input control has the focus and isn't empty, the clear button will be displayed in all rendering modes. After you press, the input field will be cleared.
ms.date: 06/09/2020
ms.reviewer: jeanr
---
# How to hide the Clear button in Internet Explorer 10

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a solution for hiding clear buttons in Internet Explorer 10.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2813492

## Summary

Windows Internet Explorer 10 introduces a new Clear button for text input fields. This button will be displayed in all rendering modes, but only if the text input control has focus and is not empty. Once pressed, the input field gets cleared.

There is also a new associated pseudo-element called `::-ms-clear` . This pseudo-element applies one or more styles to the **Clear** button. The following code example demonstrates how you can use this pseudo-element to hide the **Clear** button:

```html
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <title></title>
        <style type="text/css">
            ::-ms-clear {
            ;
            }
        </style>
    </head>
    <body>
        <input type="text" />
    </body>
</html>
```

The above code works as expected in Internet Explorer 10 Document Mode.

## More information

The current design is that the **Clear** button will be displayed in all Internet Explorer 10 Document Modes, but styles can only be applied in Internet Explorer 10 Standard Document Mode.
