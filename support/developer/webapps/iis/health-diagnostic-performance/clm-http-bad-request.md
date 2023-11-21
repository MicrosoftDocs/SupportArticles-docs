---
title: HTTP Bad Request error in the CLM portal
description: This article provides resolutions for HTTP 400 errors that occur when you perform operations in the CLM portal.
ms.date: 03/24/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: iis-health-diagnostic-performance
---
# HTTP Bad Request (Request header too long) in CLM

This article helps you resolve the problem where Hypertext Transfer Protocol (HTTP) bad request error occurs in the CLM portal.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 955585

## Symptoms

You can't perform all operations in the CLM portal, you may experience the following issue:

- With friendly HTTP error messages enabled in Internet Explorer, HTTP 400 errors will be returned in response to web requests being sent to the Internet Information Services (IIS) server.
- With friendly HTTP error messages disabled in Internet Explorer, the following error message is returned to the user:

    > Bad Request (Request header too long)

## Cause

The HTTP request that's sent to the IIS server have a request header that exceeds the allowable request header length configured on the IIS server. Specifically, the Authorization header contains a large Kerberos authentication ticket. The Kerberos ticket is so large because the user is a member of many groups in Active Directory.

For security purposes, the HTTP.sys component on the IIS server rejects the incoming HTTP request because it exceeds the configured size limits.

## Resolution

Configure the HTTP registry keys `MaxFieldLength` and `MaxRequestBytes` on the IIS server to allow for larger request header sizes.

> [!IMPORTANT]
> Changing these registry keys is considered extremely dangerous. Increasing these keys' values will cause HTTP.sys to use more memory and may increase vulnerability to malicious attacks. If changing these keys is your only option, don't set their values larger than they need to be. Information on determining how large the request headers are and therefore what value to set the registry keys is found later in this article.

- For more information on the HTTP.sys registry keys for IIS, see [Http.sys registry settings for IIS](https://support.microsoft.com/help/820129).

- For more information on HTTP.sys error logging, see [Error logging in HTTP APIs](https://support.microsoft.com/help/820729).

## Determine HTTP request size

To determine the actual HTTP request size, it can be helpful to use a network monitor trace. With this trace, we can calculate the size of the http request and compare it against the setting on the IIS server.

It's also useful to consult the HTTP.sys error log for information.

Location: `%windir%\system32\logfiles\HTTPERR\httperrX.log`

The key to resolving this particular problem, is to show that CLM is trying to send an HTTP request to the server that is greater than either the default value of 16k, or greater than the custom setting in their `MaxFieldLength` and `MaxRequestBytes`. To do this, use a combination of:

1. Network monitor trace
2. Looking through the http.sys error log located in `%windir%\system32\logfiles\HTTPERR\httperrX.log`.

Example entry from the *httperrX.log*:

> date time c-ip c-port s-ip s-port cs-version cs-method cs-uri sc-status s-siteid s-reason s-queuename
2007-04-12 07:37:51 10.201.25.27 1682 10.248.10.65 80 HTTP/1.1 GET /clm 400 - RequestLength

### WireShark

1. Locate the frame that submits the HTTP `Get` statement
2. View the tab at the bottom right of the WireShark screen titled **Reassembled TCP** and the number beside this will be the size of the reassembled HTTP request.
