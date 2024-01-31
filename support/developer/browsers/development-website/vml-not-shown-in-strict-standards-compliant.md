---
title: VML element not shown in strict standards-compliant
description: A VML element isn't shown in strict standards-compliant mode when the HTML page uses !DOCTYPE element in Internet Explorer 9.
ms.date: 03/26/2020
ms.reviewer: emmanubo
---
# VML element isn't displayed in strict standards-compliant mode in Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

A Vector Markup Language (VML) element isn't displayed in strict standards-compliant mode when an HTML page uses the `!DOCTYPE` element in Internet Explorer 9.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 932175

## Resolution

To solve this problem, set the VML style to `display:inline-block` by using the following code:

```xml
vml\:* {
behavior: url(#default#VML);display:inline-block
}
```

## More Information

The VML element is displayed correctly if you make sure the following things:

- Don't use strict standards-compliant mode.
- Remove the `!DOCTYPE` element.

For more information about strict standards-compliant mode, see [Doctype](https://developer.mozilla.org/docs/Glossary/Doctype).

To reproduce this problem, use the following page:

```xml
<?xml version="1.1" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xml:lang="en"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:vml="urn:schemas-microsoft-com:vml">
    <head>
        <title>VML Oval</title>
        <style type="text/css">
vml\:*
{
behavior: url(#default#VML);
}
</style>
    </head>
    <body>
        <h1>VML Oval</h1>
        <div>
            <vml:oval style="width:100pt;height:50pt" fillcolor="red"></vml:oval>
        </div>
    </body>
</html>
```
