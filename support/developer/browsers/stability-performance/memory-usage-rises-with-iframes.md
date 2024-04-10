---
title: Memory usage in Internet Explorer 8 rises due to iframes
description: Memory isn't released when leaving iframe pages in Internet Explorer 8 (and likely earlier versions as well) that dynamically create an element with a circular reference. The memory gets released only if you navigate the top page.
ms.date: 03/23/2020
ms.reviewer: adamki
---
# Memory usage rises due to iframes with orphaned elements with circular references in Internet Explorer 8

[!INCLUDE [](../../../includes/browsers-important.md)]

This article discusses the issue that memory usage rises when you navigate away from an HTML page that contains an iframe in Internet Explorer 8.

_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 2714930

## Symptoms

Consider the following scenario. You are using Internet Explorer 8 to view an HTML page that contains an iframe. In Internet Explorer, you navigate away from the iframe. As a result, memory levels of the corresponding iexplorer.exe process aren't returned, causing an accumulation of memory if the iframe page is visited multiple times. This problem will appear as a memory leak in Internet Explorer to the user. The memory is returned only if you navigate away from the top page.

## Cause

This can occur if the iframe dynamically creates and orphans a DOM element, sets its `innerHTML` property, and creates a circular reference (commonly through an event handler).

## Resolution

To resolve this problem, clear the event handler to break the circular reference.

## More Information

This issue can be reproduced using the sample code below. The comments indicate how you can fix the issue.

top.htm

```html
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=8"/>
    </head>
        <body>
            <a href="about:blank">about:blank</a><br/>
            <iframe src="iframe.htm"></iframe>
        </body>
</html>
```

iframe.htm

```html
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=8"/>
        <script src="test.js" type="text/javascript"></script>
    </head>
    <body>
        <div style="font-size: 9pt">In Internet Explorer 8, click the link 10x and you'll see private bytes increase.<br/>
        Note: Leaving the main page won't clear the memory right away. However, if the top page includes the same test.js file, it will clear the memory right away.<br/>
        </div>
        </br>
        <a href="iframe.htm">iframe</a><br/>
    </body>
</html>
```

test.js

```javascript
(function ()
{
    var div2 = document.createElement("div");
    div2.innerHTML = "<div></div>"; // commenting this out will prevent the memory from accumulating
    var tmpFnc = null;
    div2.attachEvent("onclick", tmpFnc =
        function ()
        {
        }
    );
    //div2.detachEvent( "onclick", tmpFnc); // calling this will prevent the memory from accumulating
})();
// this is a long comment, Copy and paste the 100 character line below to make the leak more prominent.
// 1000 lines will leak about 1.1-1.2 MB per iteration.
// 34567890123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678
```

This problem can be seen if you include jQuery.js v1.7.2 in place of test.js. Earlier versions of jQuery may also show this issue. Also, the problem may be seen in other JavaScript libraries that do the same thing.
