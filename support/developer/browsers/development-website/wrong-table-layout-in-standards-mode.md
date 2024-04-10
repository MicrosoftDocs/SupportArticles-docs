---
title: Unexpected table height calculation in Internet Explorer standards mode
description: Different table layout behaviors for standard and quirks mode in Internet Explorer.
ms.date: 03/23/2020
ms.reviewer: jeanr
---
# Unexpected table height calculation in Internet Explorer standards mode

[!INCLUDE [](../../../includes/browsers-important.md)]

This article discusses a by design behavior that a table is resized if you use relative height for a `<div>` tag within a table cell in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2778473

## Summary

If you are using relative height for a `<div>` tag within a table cell, you may experience different layout behaviors for standard and quirks mode in Internet Explorer. For example:

```html
<!DOCTYPE HTML>
<html>
    <body>
        <div style='height: 75px'>
            <table style='height:100%'>
                <tr>
                    <td>Row 1</td>
                </tr>
                <tr>
                    <td style='height:100%'>
                        <div style='height:100%'>Row 2</div>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
```

If you toggle the document mode using the developer tools, you will see different behavior when you check the layout.

In the above example, in quirks mode the table gets the height of the surrounding `<div>` element, which is 75 pixels. The second row takes all of the remaining height and the table itself does not get resized.

In standards mode, the table gets resized because the inner `<div>` tag of table row 2 (Row 2) takes its calculated height from the first parent with an absolute height, which is 75 pixels. This causes a resize of the whole table since both rows cannot fit into the initial given height.

## More information

This behavior is by design and has been introduced with Internet Explorer 7 in 2006. You may also see different behaviors in non-Microsoft web browsers. There is currently no way to change this behavior using just CSS and tables. The behavior is considered to be a limitation of the table model in standards mode. The CSS table model actually prevents this scenario from working as expected.

Only quirks mode and quirks mode emulation (QME) do support this for compatibility reasons.
