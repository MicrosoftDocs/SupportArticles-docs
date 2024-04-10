---
title: DIV tags with 100% relative height not resized
description: Discusses a by design behavior that DIV tags with 100% relative height can't be resized in Internet Explorer 9 and later versions.
ms.date: 04/21/2020
ms.reviewer: jeanr
---
# DIV tags with 100% relative height are not resized in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces a by design behavior that a DIV tag with a relative height of 100% is not resized in Internet Explorer 9 or a later version.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2674902

## Symptoms

In Internet Explorer 9 or a later version, you are using a table with an absolute height and at least two cells in one row. One cell contains some text and the other cell contains a DIV tag with a relative height of 100%. The text does not fit into the given height and therefore the table gets resized. The DIV tag stays at the initial absolute height of the table and will not be resized automatically.

## More information

This behavior is by design, and applies to Standard Mode for all supported versions of Internet Explorer 9 and later versions.

> [!NOTE]
> The behavior may be different in Quirks Mode and in Quirks Mode Emulation (QME) when using Internet Explorer 9 or a later version.

Following is an example of the behavior outlined above:

```aspx-csharp
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <body>
        <table style="height:50px;" border="1px">
            <tr>
                <td style="height:100%">
                    <p>
                        this text does not fit and will resize the table<br />this text does not fit and will resize the
                        table<br />
                        this text does not fit and will resize the table<br />this text does not fit and will resize the
                        table<br />
                    </p>
                </td>
                <td style="height:100%; width:50px;">
                    <div style="height:100%; border:1px solid red;"></div>
                </td>
            </tr>
        </table>
    </body>
</html>
```

According to the W3 specification, a cell's content box height will not be impacted by the row's height, and any extra height should go towards the cell's padding. Then, the cell's child should resolve its percentage height against the cell's content box, which is unchanged by the row's height.

According to [CSS 2.1](http://www.w3.org/tr/css21/tables.html#height-layout), the height of a cell box is the minimum height required by the content. The table cell's `height` property can influence the height of the row (see above), but it does not increase the height of the cell box. Cell boxes that are smaller than the height of the row receive extra top or bottom padding.

For more information, see [Defining Document Compatibility](/previous-versions/windows/internet-explorer/ie-developer/compatibility/cc288325(v=vs.85)).
