---
title: XSS Filter in IE improperly blocks HTTP response
description: Introduces the workaround to solve the issue that Internet Explorer XSS Filter may block the HTTP response after you send an HTTP request.
ms.date: 03/17/2020
ms.prod-support-area-path: Internet Explorer
---
# XSS Filter in Internet Explorer 8 improperly blocks HTTP response rendered as XML

This article provides a workaround for you to solve the problem that HTTP response is blocked after you send an HTTP request in Internet Explorer 8.

_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 2524198

## Symptoms

When you submit an HTTP request using Internet Explorer 8 to a target page hosted in a web application, the IE XSS Filter may block the response. This occurs even if the request and response are from the same domain. It also occurs even if you attempt to disable the XSS Filter feature by setting the following HTTP response header on the server:

```html
X-XSS-Protection: 0
```

## Resolution

To work around the issue, submit the HTTP request to a page that then performs an HTTP 307 redirect to the target page.

> [!NOTE]
> This problem is resolved in Internet Explorer 9.
