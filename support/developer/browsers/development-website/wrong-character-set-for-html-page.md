---
title: Internet Explorer uses wrong character set for an HTML page
description: Describes an issue where Internet Explorer may render an HTML page using the wrong character set even though the correct charset is specified in the HTML page by using a META tag.
ms.date: 03/08/2020
ms.reviewer: Adamki, pfazekas
---
# Internet Explorer uses wrong character set when it renders an HTML page

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the methods for you to solve the issue that Internet Explorer renders an HTML page by using the incorrect character set.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 928847

## Symptoms

When Microsoft Internet Explorer renders an HTML page, it uses the wrong character set. Internet Explorer does this even though the correct character set is specified by a `META` tag in the HTML page.

For example, Internet Explorer may render a Japanese HTML page by using the Shift-JIS character set even when UTF-8 is specified by the following `META` tag in the HTML page:

```aspx
<META http-equiv=Content-Type content="text/html; charset=utf-8">
```

## Cause

This issue may occur if one or more or the following conditions are true:

- The **Auto-Select** setting is enabled in Internet Explorer. This setting helps Internet Explorer determine the code page that is used for the HTML page.
- The **System Locale** setting differs from the character set that is specified in the `META` tag.
- The `META` tag that specifies the character set is not in the first chunk of HTML data that is parsed by MSHTML. Typically, this means that the tag is located somewhere after the first 256 bytes of data on through the remainder of the first 4 KB of data.
- The server is a slow system, or the server breaks the first part of the HTTP response so that the response does not contain the `META` tag. This issue may occur if you enable chunked encoding.
- When Internet Explorer passes the initial chunk to be parsed to the `IMultiLanguage::ConvertStringToUnicode` method, Internet Explorer cannot perform the conversion.

> [!NOTE]
> There are additional conditions that may contribute to this issue. These additional conditions are very code-specific and are not listed here.

## Resolution

To resolve this issue, use one of the following methods:

- Disable the **Auto-Select** setting in Internet Explorer.
- Provide the character set in the HTTP headers.
- Move the `META` tag to within the first kilobyte of data that is parsed by MSHTML. Although we do not know how much data the parser reads at a time, this location will resolve the issue.
- Increase the size of the server's initial HTTP response. The initial size should be at least 1 KB.
- Make sure that the **System Locale** setting matches the character set of the `META` tag that is specified in the HTML page.
