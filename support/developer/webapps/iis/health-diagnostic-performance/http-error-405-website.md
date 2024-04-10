---
title: HTTP Error 405.0 when you visit Internet Information Services (IIS) websites
description: Describes a problem that occurs because a client request uses an HTTP verb that doesn't comply with the HTTP specifications, or because a client uses the POST methods to send a request to a static HTML page.
ms.date: 04/16/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.reviewer: mlaing
ms.subservice: health-diagnostic-performance
---
# HTTP Error 405.0 when you visit a website that is hosted on a server that is running IIS

This article helps you resolve **HTTP Error 405.0**. This error occurs when you visit a website that's hosted on a server running Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942051

## Symptoms

Consider the following scenario. You have a website that is hosted on a server that is running Internet Information Services (IIS) 7.0 or a later version. When a user goes to this website, the user receives an error message that resembles the following example:

> Server Error in Application "**application name**"  
> HTTP Error 405.0 - Method not allowed  
> HRESULT: 0x80070001  
> Description of HRESULT  
> The page you are looking for cannot be displayed because an invalid method (HTTP verb) is being used.

## Cause 1

This problem occurs because the client makes a Hypertext Transfer Protocol (HTTP) request by using an HTTP method that doesn't comply with the HTTP specifications.

## Cause 2

This problem occurs because a client makes an HTTP request by sending the `POST` method to a page that is configured to be handled by the `StaticFile` handler. For example, a client sends the `POST` method to a static HTML page. However, pages that are configured for the `StaticFile` handler don't support the `POST` method.

## Cause 3
WebDAV Publishing interferes with HTTP PUT.


## Resolution for cause 1

Make sure that the client sends a request that contains a valid HTTP method. To do so, follow these steps:

1. Select **Start**, type *Notepad* in the **Start Search** box, right-click **Notepad**, and then select **Run as administrator**.

    > [!NOTE]
    >  If you are prompted for an administrator password or for a confirmation, type the password, or provide confirmation.
2. On the **File** menu, select **Open**. In the **File name** box, type `%windir%\system32\inetsrv\config\applicationhost.config`, and then select **Open**.
3. In the *ApplicationHost.config* file, locate the `<handlers>` tag.
4. Make sure that all the handlers use valid HTTP methods.
5. Save the *ApplicationHost.config* file.

## Resolution for cause 2

Send the POST request to a page that's configured to be handled by a handler other than the `StaticFile` handler. For example, the `ASPClassic` handler. Or, change the request that is being handled by the `StaticFile` handler so that it's a GET request instead of a POST request.

## Resolution for cause 3

Remove WebDAV modules and handlers from the *Web.config* file. Also remove the WebDAV Publishing feature from your computer if it's not being used. To do so, follow these steps:

1. Select **Start**, type *Turn Windows features on or off* in the **Start Search** box, and then select **Turn Windows features on or off**.
1. In the Windows Features window, expand **Internet Information Services** -> **World Wide Web Services** -> **Common HTTP Features**.
1. Uncheck the **WebDAV Publishing** feature.
