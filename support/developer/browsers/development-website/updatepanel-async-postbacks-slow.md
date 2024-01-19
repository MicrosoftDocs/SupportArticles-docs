---
title: UpdatePanel async postbacks slow in Internet Explorer
description: Provides the method to solve the delay that occurs when you click a page element in Internet Explorer.
ms.date: 03/16/2020
ms.reviewer: jamesche
---
# UpdatePanel async postbacks slow in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces a workaround to solve the issue that you experience a delay when you visit a page and select a page element.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2000262

## Symptoms

When you use Internet Explorer to browse a page that contains an UpdatePanel, there is a delay (often anywhere between 10 seconds and 45 seconds or more) after clicking a page element that initiates an async postback. The delay is not experienced when using browsers other than Internet Explorer.

## Cause

The `PageRequestManager's _destroyTree` method iterates through the DOM elements inside of the UpdatePanel prior to initiating an async postback in order to dispose of DOM elements. The `_destroyTree` method's specific implementation is slow in Internet Explorer when working with a large DOM tree under some conditions due to the way that Internet Explorer's HTML viewer (mshtml.dll) stores DOM elements in memory.

## Workaround

You can add the JavaScript below immediately before the closing `</body>` element of the page experiencing the delay.

```javascript
<script language="javascript" type="text/javascript">

    function disposeTree(sender, args)
    {
        var elements = args.get_panelsUpdating();
        for (var i = elements.length - 1; i >= 0; i--)
        {
            var element = elements[i];
            var allnodes = element.getElementsByTagName('*'),
                length = allnodes.length;
            var nodes = new Array(length)
            for (var k = 0; k < length;
                {
                    nodes[k] = allnodes[k];
                }
            for (var j = 0, l = nodes.length; j < l;
            {
                var node = nodes[j];
                if (node.nodeType === 1)
                {
                    if (node.dispose && typeof (node.dispose) === "function")
                    {
                        node.dispose();
                    }
                    else if (node.control && typeof (node.control.dispose) === "function")
                    {
                        node.control.dispose();
                    }
                    var behaviors = node._behaviors;
                    if (behaviors)
                    {
                        behaviors = Array.apply(null, behaviors);
                        for (var k = behaviors.length - 1; k >= 0; k--)
                        {
                            behaviors[k].dispose();
                        }
                    }
                }
            }
            element.innerHTML = "";
        }
    }
Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(disposeTree);
</script>
```

## More information

This script uses the `getElementsByTagName` method, which is much faster in Internet Explorer than the original implementation.

This article only applies to older versions of asp.net and Internet Explorer 8 or earlier.
