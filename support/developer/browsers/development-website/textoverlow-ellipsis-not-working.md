---
title: Text-overlow ellipsis not working in Internet Explorer 11
description: Describes a display problem in Internet Explorer 11. This issue occurs when you use the text-overlow ellipsis attribute.
ms.date: 04/26/2020
---
# Internet Explorer doesn't handle the text-overlow ellipsis attribute correctly

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the information to solve the issue that the `text-overlow: ellipsis` attribute only applies to the first line of an HTML document in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3056585

## Symptoms

When you apply the `text-overlow: ellipsis` CSS attribute to multiple lines in an HTML document, and then you view the webpage in Internet Explorer, you discover that the attribute has been applied only to the first line.

## Cause

This is a known issue in Internet Explorer 10 and Internet Explorer 11.

## Resolution

The ellipsis is displayed for both lines when the page is used with document modes Internet Explorer 5 and Internet Explorer 7.

## More information

The following sample webpage demonstrates the issue:

```html
<!DOCTYPE html>
<html>
    <head>
        <style>
            div
            {
                width: 100px;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
    </head>
    <body>
        <div>
            1111111111111111111111111111111111111111111111111111111111111111
            1111111111111111111111111111111111111111111111111111111111111111
        </div>
    </body>
</html>
```

In this situation, you see output that resembles the following:

```console
1111111111111...
111111111111111
```

You expect to see output that resembles the following:

```console
1111111111111...
1111111111111...
```
