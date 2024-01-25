---
title: Table text overlaps borders in Internet Explorer
description: Discusses an issue in which table text overlaps table borders or is missing in Internet Explorer. Provides a resolution.
ms.date: 06/09/2020
ms.reviewer: jeanr
---
# Table text overlaps table borders or is missing in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides solutions to solve the situation where the table text overlaps the border or is lost on the webpage because of the table height in Internet Explorer can't adjust the block-level elements that have been set.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 3121136

## Symptoms

When you use tables that contain block elements in Internet Explorer, you experience the following symptoms:

- The inner text overlaps the table border.
- Parts of the inner text are missing.

The following Internet Explorer versions are affected by this issue:

- Internet Explorer 9 and Internet Explorer 10 in all document modes except Quirks.
- Internet Explorer 11 in all document modes except Edge and Quirks.

## Cause

This issue occurs because the table height does not adjust to accommodate a block-level element that exceeds this setting.

## Resolution

To resolve this issue, we recommend that you do either of the following:

- On Windows 10, use Microsoft Edge.
- On other Windows versions, upgrade to Internet Explorer 11, and then render the page in Edge document mode.
- Alternatively, you can change the HTML of the page. To do this, replace the DIV-tagged text by using an HTML table, as shown in the following example.

    **Original code**

    ```html
    <!DOCTYPE HTML>
    <html>
    <body>
        <table style="border: 1px solid blue; height: 50px">
            <tr>
                <td style="height: 100%">
                    <div style="height: 100%">
                        This text overlaps<br />
                        the<br />
                        blue<br />
                        border<br />
                    </div>
                </td>
            </tr>
        </table>
    </body>
    </html>
    ```

    **Replacement code**

    ```html
    <!DOCTYPE HTML>
    <html>
    <body>
        <table style="border: 1px solid blue; height: 50px">
            <tr>
                <td style="height: 100%">
                        <table>
                        <tr>
                            <td>
                                This text fits within<br />
                                the<br />
                                blue<br />
                                border<br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
    </html>
    ```
