---
title: Resolve HTTP 405.0 errors in IIS 7.0 and later
description: Troubleshoot HTTP 405.0 errors on IIS websites. Discover solutions for invalid HTTP methods, WebDAV interference, and POST requests to static file handlers.
ms.date: 03/17/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: mlaing, hugo.durana, v-shaywood
---
# "HTTP 405.0 - Method not allowed" error

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942051

## Summary

This article helps you resolve the `HTTP 405.0` error that occurs when you visit a website that's hosted on a server that runs Internet Information Services (IIS) 7.0 or a later version. This error can be caused by invalid HTTP methods, POST requests to static file handlers, WebDAV Publishing conflicts, or application code that returns an `HTTP 405.0` response.

## Symptoms

When you visit a website, you receive an error message that resembles the following example:

> Server Error in Application "**application name**"  
> HTTP Error 405.0 - Method not allowed  
> HRESULT: 0x80070001  
> Description of HRESULT  
> The page you are looking for cannot be displayed because an invalid method (HTTP verb) is being used.

## Cause: Invalid HTTP method

A client makes an HTTP request by using an HTTP method that doesn't comply with the HTTP specifications.

### Solution

Make sure that the client sends a request that contains a valid HTTP method:

1. Open **Notepad** as an administrator.
1. On the **File** menu, select **Open**.
1. In the **File name** field, type `%windir%\system32\inetsrv\config\applicationhost.config`, and then select **Open**.
1. In the `applicationhost.config` file, locate the [`<handlers>`](/iis/configuration/system.webserver/handlers/) tag.
1. Make sure that all the handlers use valid HTTP methods.
1. Save the `applicationhost.config` file.

## Cause 2: POST request sent to a static file handler

A client sends an HTTP request specifying the `POST` method to a page that's configured to be handled by the `StaticFile` handler. For example, a client sends the `POST` method to a static HTML page. Pages that are configured to use the `StaticFile` handler don't support the `POST` method.

### Solution

Send the `POST` request to a page that's configured to be handled by a handler other than the `StaticFile` handler (for example, the `ASPClassic` handler). Or, change the request so that it uses the `GET` method instead of `POST`.

## Cause 3: WebDAV Publishing interferes with HTTP PUT

[WebDAV Publishing](/iis/install/installing-publishing-technologies/installing-and-configuring-webdav-on-iis) might interfere with HTTP `PUT` requests and cause `HTTP 405.0` errors.

### Solution

Remove WebDAV modules and handlers from the `web.config` file. If you don't use WebDAV Publishing, remove the feature from the IIS server:

1. Select **Start**, enter `Turn Windows features on or off` in the search box, and then select **Turn Windows features on or off**.
1. In the **Windows Features** window, expand **Internet Information Services** > **World Wide Web Services** > **Common HTTP Features**.
1. Clear the **WebDAV Publishing** checkbox.

## Cause 4: Application code returns an HTTP 405.0 response

Application code returns an `HTTP 405.0` response to indicate an error.

### Solution: Use a different HTTP status code

Use a custom status code instead of the predefined `HTTP 405.0`. For client errors, use the [`HTTP 400`](../health-diagnostic-performance/http-status-code.md#400---bad-request) status code together with a custom description that outlines the specific error.

## Related content

- [Troubleshoot Web API2 apps that work in Visual Studio and fail on a production IIS server](/aspnet/web-api/overview/testing-and-debugging/troubleshooting-http-405-errors-after-publishing-web-api-applications)
- [Troubleshoot 4xx and 5xx HTTP errors](troubleshoot-http-error-code.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
