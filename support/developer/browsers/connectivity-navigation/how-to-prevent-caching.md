---
title: How to prevent caching in Internet Explorer
description: This article describes how to use HTTP headers to control the caching of Web pages in Internet Explorer.
ms.date: 02/27/2020
---
# How to prevent caching in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes the use of HTTP headers to control the caching of Web pages in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 234067

## Summary

You can use Microsoft Internet Information Server (IIS) to easily mark highly volatile or sensitive pages using the following script at the extreme beginning of the specific Active Server Pages (ASP) pages:

```aspx-csharp
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %>
<% Response.Expires = -1 %>
```

## Expiration and the Expires header

It's highly recommended that all Web servers use a scheme for the expiration of all Web pages. It's a bad practice for a Web server not to supply expiration information via the HTTP Expires response header for every resource returned to requesting clients. Most browsers and intermediate proxies today respect this expiration information and use it to increase the efficiency of communications over the network.

Always use the Expires header to specify the most reasonable time when a particular file on the server needs to be updated by the client. When pages are updated regularly, the next period for update is the most efficient response. Take, for example, a daily news page on the Internet that is updated every day at 5 A.M. The Web server for this news page should return an Expires header with a value for 5 A.M. the next day. When it's done, the browser doesn't need to contact the Web server again until the page has changed.

Pages that aren't expected to change should be marked with an expiration date of approximately one year.

In many cases, Web servers have one or more volatile pages on a server that contain information that's subject to change immediately. These pages should be marked by the server with a value of "-1" for the Expires header. On future requests by the user, Internet Explorer usually contacts the Web server for updates to that page via a conditional If-Modified-Since request. However, the page remains in the disk cache (Temporary Internet Files). And the page is used in appropriate situations without contacting the remote Web server, such as:

- when the BACK and FORWARD buttons are used to access the navigation history.
- when the browser is in offline mode.

## The Cache-Control header

Certain pages, however, are so volatile or sensitive that they require no disk caching. To this end, Internet Explorer supports the HTTP 1.1 Cache-Control header. This header prevents all caching of a particular Web resource when the no-cache value is specified by an HTTP 1.1 server.

Pages that are kept out of the cache aren't accessible until the browser can recontact the Web server. So, servers should use the Cache-Control header sparingly. In most cases, the use of Expires: -1 is preferred.

## The Pragma: No-Cache header

Unfortunately, legacy HTTP 1.0 servers can't use the Cache-Control header. For purposes of backward compatibility with HTTP 1.0 servers, Internet Explorer supports a special usage of the HTTP Pragma: no-cache header. If the client communicates with the server over a secure connection (`https://`) and the server returns a Pragma: no-cache header with the response, Internet Explorer doesn't cache the response.

However, the Pragma: no-cache header wasn't for this purpose. According to the HTTP 1.0 and 1.1 specifications, this header is defined in the context of a request only, not a response. It's intended for proxy servers that may prevent certain important requests from reaching the destination Web server. For future applications, the Cache-Control header is the proper means for controlling caching.

## HTTP-EQUIV META tags

HTML pages allow for a special HTTP-EQUIV form of the META tag that specifies particular HTTP headers from within the HTML document. Here's a short example HTML page that uses both Pragma: no-cache and Expires: -1:

```html
<HTML>
    <HEAD>
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="-1">
    </HEAD>
<BODY>
</BODY>
</HTML>
```

Pragma: no-cache prevents caching only when used over a secure connection. A Pragma: no-cache META tag is treated identically to Expires: -1 if used in a non-secure page. The page will be cached but marked as immediately expired.

Cache-Control META HTTP-EQUIV tags are ignored and have no effect in Internet Explorer versions 4 or 5. To use Cache-Control, this header must be specified using HTTP headers as described in the Cache-Control section above.

> [!NOTE]
> The use of standard HTTP headers are much preferred over META tags. META tags typically must appear at the top of the HTML HEAD section. And there's at least one known problem with the Pragma HTTP-EQUIV META tag.

### Server options for caching

When the Cache-Control header needs to be used on non-ASP pages, it may be necessary to use options in the server configuration to add this header automatically. For the process of adding HTTP headers to server responses for a particular directory, refer to your server document. For example, in IIS 4, follow these steps:

1. Start the IIS Manager.
1. In the computer and services tree, open the Default Web Server, or the web server in question. Find the directory containing the content that needs the Cache-Control header.
1. Open the **Properties** dialog for that directory.
1. Select the **HTTP Headers** tab.
1. Select the **Add** button in the Custom HTTP Headers group, and add Cache-Control for the header name and no-cache for the header value.

It's not a good idea to use this header globally across the entire Web server. Restrict its use purely to content that absolutely mustn't be cached on the client.

## Problem checklist

If you've applied the techniques in this article and you're still having problems with caching and Internet Explorer, review this handy checklist step by step before contacting Microsoft for technical support assistance:

- Are you using the Cache-Control header with the ASP `Response.CacheControl` property or through a returned HTTP header? It's the only way to truly prevent caching in Internet Explorer.
- Are you using Internet Explorer 4.01 Service Pack 2 or higher? There's no way to completely prevent caching in earlier versions of the browser.
- Have you double-checked that your web server has HTTP 1.1 turned on and is returning HTTP 1.1 responses to Internet Explorer? Cache-Control headers are invalid in HTTP 1.0 responses.
- If you're using CGI/ISAPI/Servlets on the server side, are you following the HTTP 1.1 specification exactly, particularly about CRLF termination of HTTP headers? In the interest of performance, Internet Explorer is typically unforgiving of responses that violate the HTTP 1.1 specification. It usually results in ignored headers or reports of unexpected server errors.
- Are the HTTP headers spelled correctly?

## See also

- For more information about HTTP 1.1 protocol, see this external link: [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616.html).
- [Client Cache in IIS](/iis/configuration/system.webserver/staticcontent/clientcache)
