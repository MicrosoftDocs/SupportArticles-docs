---
title: Call window open() function
description: Describes an issue in which a window that is opened by the window.open() function don't reflect the specified size and position in Microsoft Edge.
ms.date: 06/08/2020
ms.reviewer: 
---
# Windows opened by window.open() do not reflect the specified size and position in Microsoft Edge

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about the value set by calling `window.open()` function will not be reflected in the new window of Microsoft Edge.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 3146494

## Symptoms

Consider the following scenario:

- You open a webpage in Microsoft Edge.
- The webpage calls the `window.open()` function and sets values to specify the size and position of the window.
- The window that calls the `window.open()` function is not maximized. In this scenario, the specified size, and position are not reflected in the new window.

## More information

You can follow these steps to reproduce this issue:

1. Save the following HTML code as *original.html*.

    ```javascript
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
            <title>window.open - TEST</title>
            <script type="text/javascript">
                function win_open1() {
    window.open('about:blank','','titlebar=yes,toolbar=yes,location=yes,status=no,menubar=yes,scrollbars=yes,resizable=yes,width=700,Height=300,left=0,top=0');
                }
            </script>
        </head>
        <body>
            <input type="button" name="btn1" value="btn1" onclick="win_open1();" />width=700,Height=300,left=0,top=0<br>
        </body>
    </html>
    ```

2. Open **original.html** in Microsoft Edge.
3. If the Edge window size is maximized, restore it to normal size.
4. Click **button** to call the `window.open` function with width **700 px** and height **300-px** parameters. In this scenario, the size of the opened window is not **700x300** as expected.
