---
title: Tilde notation maps to original URL
description: This article provides resolutions for the problem that tilde notation embedded in HTML elements in Web Pages Razor V3 maps to the original URLs by using the IIS URL rewrite. This behavior differs from the behavior of Web Pages Razor V2.
ms.date: 04/07/2020
ms.custom: sap:General Development
ms.reviewer: kanchanm
---
# Tilde notation maps to the original URLs by using IIS URL rewrite in ASP.NET Web Pages Razor V3

This article helps you resolve the problem where tilde (~) notation embedded in Hypertext Transfer Protocol (HTTP) elements in Web Pages Razor V3 maps to the original URLs by using the Internet Information Services (IIS) URL rewrite.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 2905164

## Symptoms

In Microsoft ASP.NET Web Pages Razor V3, the tilde (~) notation embedded in the HTML elements such as `<A/>`, `<SCRIPT/>`, or `<LINK/>` map to the original URLs by using the IIS URL rewrite. For example, when the requests under `asp.net/content` are rewritten to the URL under `asp.net`, the `href` attribute in `<A href='~/content/'/>` is resolved to `/content/content/` instead of to `/`. Therefore, the pages in Web Pages Razor V2 may not work correctly after you upgrade to Web Pages Razor V3 or ASP.NET Model-View-Controller (MVC) 5.

## Cause

This issue occurs because the behavior of tilde notation in URLs is changed in Web Pages Razor V3 for consistency with ASP.NET MVC. In ASP.NET MVC, the tilde notation in the `Url.Content` method or the `Html.ActionLink` method produces the original URLs regardless of the IIS URL rewrite rules.

However, in Web Pages Razor V2, the tilde notation in URLs maps to the rewritten URLs when the IIS URL rewriting module is enabled. For example, when the requests under `content.asp.net` are rewritten to the URL under `asp.net/content/`, the `href` attribute in `<A href='~/book/'/>` is resolved to `/content/book/` . In Web Pages Razor V3, the same `href` attribute is translated into `/book/`, which is the original URL in the browser.

## Resolution

To resolve the tilde notation to the rewritten URLs by using the same behavior as in Web Pages Razor V2, set the `IIS_WasUrlRewritten` context to **false** in each Web page or in `Application_BeginRequest` in *Global.asax* for the global setting as follows:

```aspx-csharp
protected void Application_BeginRequest(object sender, EventArgs e)
{
    Context.Items["IIS_WasUrlRewritten"] = false;
}
```

> [!NOTE]
> The change of the `IIS_WasUrlRewritten` context affects the tilde notation not only in the HTML elements, but also in the `MVC helper` methods. For example, if it is set to false, the tilde notation in `Url.Content` and `Html.ActionLink` returns the rewritten URLs.

## More information

For more information about the Razor syntax and about some related MVC methods, go to the following websites:

- [Introduction to ASP.NET Web Programming Using the Razor Syntax (C#)](/aspnet/web-pages/overview/getting-started/introducing-razor-syntax-c)
- [Introduction to the LinkExtensions.ActionLink method](/previous-versions/aspnet/dd505040(v=vs.108))
- [UrlHelper.Content(String) Method](/dotnet/api/system.web.mvc.urlhelper.content?view=aspnet-mvc-5.2&preserve-view=true)
- [URL Rewrite](https://www.iis.net/downloads/microsoft/url-rewrite)
