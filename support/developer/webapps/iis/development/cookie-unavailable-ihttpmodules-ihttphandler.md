---
title: Cookies added by HttpModule are unusable
description: This article provides resolutions for the problem where cookie doesn't display in the native IHttpRequest object When you use the Cookies collection from either the managed HttpRequest or HttpResponse objects to add a cookie.
ms.date: 03/26/2020
ms.custom: sap:Development
ms.subservice: development
---
# Cookies added by a managed HttpModule aren't available to native IHttpModules or IHttpHandlers

This article helps you resolve the problem where cookies that are added by a managed isn't available to native `IHttpModules` or `IHttpHandlers`.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2666571

## Symptoms

When using the `Cookies` collection from either the managed `HttpRequest` or `HttpResponse` objects to add a cookie, the cookie doesn't show up in the native `IHttpRequest` object.

## Cause

The `Cookies` collection in the managed `HttpRequest` and `HttpResponse` objects don't have a corresponding collection in the `IHttpRequest` or `IHttpResponse` object in Internet Information Services (IIS). So adding or modifying either of these collections doesn't modify the `Cookie` header in the `IHttpRequest` object.

## Resolution

To modify a specific cookie in the `Cookie` header of the native `IHttpRequest` object from managed code, modify the `Cookie` header directly in the managed `HttpRequest` object's `Header` collection, instead of via the `Cookies` collection.

## More information

The following sample means managed `HttpModule` code would add the cookie to the headers in the `IHttpRequest` object in the IIS pipeline.

```csharp
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace AddCookieModule
{
    public class AddCookieClass : IHttpModule
    {
        private void Application_BeginRequest(Object source EventArgs e)
        {
            HttpApplication application = (HttpApplication)source;
            HttpContext context = application.Context;
            HttpCookie testCookie = new HttpCookie("testCookie",
            DateTime.Now.ToString());
            testCookie.Expires = DateTime.Now.AddYears(5);
            context.Request.Headers.Add("Cookie",
                                        "testCookie=" + testCookie.Value);
            context.Response.Cookies.Add(testCookie);
        }

        public void Dispose()
        {
            // nothing to do.
        }

        public void Init(HttpApplication context)
        {
            context.BeginRequest +=
                (new EventHandler(this.Application_BeginRequest));
        }
    }
}
```
