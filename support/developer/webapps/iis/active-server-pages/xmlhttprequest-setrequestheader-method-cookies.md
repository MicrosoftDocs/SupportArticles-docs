---
title: XMLHttpRequest setRequestHeader method and Cookies
description: This article provides resolutions for the problem when you use XMLHttpRequest setRequestHeader method and Cookies.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
---
# XMLHttpRequest setRequestHeader method and Cookies

This article helps you resolve the problem when you use `XMLHttpRequest` `setRequestHeader` method and Cookies.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 234486

## Symptoms

When using the XML Document Object Model (DOM), the `setRequestHeader` method on the `XMLHttpRequest` object does not seem to set cookie headers as expected. The first call to `setRequestHeader` using the Cookie HTTP header seems to have no effect.

## Resolution

To add cookies to the request, the call to `setRequestHeader` for the Cookie header must be repeated because the first call is ignored:

```vbscript
'this value is ignored, but the step is necessary
xmlRequest.setRequestHeader "Cookie", "any non-empty string here"
'set all cookies here
xmlRequest.setRequestHeader "Cookie", "cookie1=value1; cookie2=value2"
```

> [!NOTE]
> Setting cookies in this manner is atypical. Cookies are best set by the server using the `Set-Cookie` header.
