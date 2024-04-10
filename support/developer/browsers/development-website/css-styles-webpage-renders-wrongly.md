---
title: CSS styles webpage renders wrongly in Internet Explorer
description: Describes a problem in Internet Explorer in which a webpage that uses CSS styles does not render correctly. Provides steps to reproduce the problem.
ms.date: 03/03/2020
---
# A webpage that uses CSS styles does not render correctly in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides steps to help describing the issue that a CSS styles webpage does not render correctly in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 262161

## Symptoms

Styles on a webpage are missing or look incorrect when the page loads in Internet Explorer.

> [!NOTE]
> This problem can occur whether the webpage uses an inline style sheet or points to a cascading style sheet.

You may also receive the following error message:

> The page you are looking for might have been moved or had its name changed.

## Cause

This problem occurs because the following conditions are true in Internet Explorer:

- All style tags after the first 31 style tags are not applied.
- All style rules after the first 4,095 rules are not applied.
- On pages that use the @import rule to continuously import external style sheets that import other style sheets, style sheets that are more than three levels deep are ignored.

## More information

A network monitor tool may indicate that a TCP reset occurs when Internet Explorer is receiving the page that is experiencing the problem. Internet Explorer then generates another POST request if the original request was a POST request. Or, Internet Explorer may send a GET request instead.

This style tag limitation may also affect the viewing of .xml files by using .xsl files. When the .xsl file has style tags embedded inside the document, you receive the following error message when you try to view the .xml file:

> Internet Explorer could not open the Internet Site:  
> **file://c:\aaa.xml**

When you click **OK**, you receive the following error message:

> The page cannot be displayed

The code sample that is provided in the Steps to reproduce the problem section dynamically creates style sheets and generates the following error message:

> A Runtime Error has occurred.  
> Do you wish to Debug?
>
> Line: 8  
> Error: Invalid argument.

If the style sheets are not applied dynamically but are, instead, applied through \<Style> tags or through .css files, the **Invalid argument** error message is not generated. In this case, all style sheets after the thirty-first style sheet are ignored.

### Steps to reproduce the problem

Paste the following code sample in an HTML page. Run the code sample. An error is generated after the thirty-first style tag is applied.

```html
<html>
    <head>
        <script>
            function fnCreateStyleSheets() {
                for (i = 1; i <= 32; i++) {
                    document.createStyleSheet()
                    StyleSheetCount.innerText = "Total Style Sheets = " + i
                }
            }
        </script>
    </head>
    <body onLoad="fnCreateStyleSheets()">
        <div id="StyleSheetCount"></div>
    </body>
</html>
```

## References

For more information, see the following Microsoft Developer Network (MSDN) websites:

- [STYLE element | style Object](https://developer.mozilla.org/docs/Web/HTML/Element/style)
- [addRule Method](https://developer.mozilla.org/docs/Web/API/CSSStyleSheet#)
- [@import Rule](https://developer.mozilla.org/docs/Web/CSS/@import)
