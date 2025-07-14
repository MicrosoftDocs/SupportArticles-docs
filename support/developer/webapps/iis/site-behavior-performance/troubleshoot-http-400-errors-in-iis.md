---
title: Troubleshoot HTTP 400 Errors in IIS
description: Describes the troubleshooting steps to identify the cause of various HTTP 400 errors when using IIS.
ms.date: 12/06/2024
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande, mlaing, zixie
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
---
# Troubleshooting HTTP 400 errors in IIS

_Applies to:_ &nbsp; Internet Information Services  

This article describes the troubleshooting steps to identify the cause of various HTTP 400 errors when using IIS.

## Overview

After an HTTP client (such as Microsoft Edge) sends an HTTP request to an IIS server, it might display the following type of error message:

> HTTP 400 - Bad Request

In this scenario, IIS rejects the client's HTTP request because the request doesn't meet the server's HTTP parsing rules, exceeds time limits, or fails some other rules that IIS or HTTP.sys requires incoming requests to adhere to. IIS sends the `HTTP 400 - Bad Request` status back to the client, and then terminates the TCP connection.

## Tools

- [Network Monitor](../../../../windows-server/networking/network-monitor-3.md)
- HTTP Error logging

## Troubleshooting methods

When troubleshooting an HTTP 400 condition, it's important to remember that the underlying problem is that the client has sent a request to IIS that breaks one or more rules that HTTP.sys is enforcing. With that in mind, you'll want to see what exactly the client is sending to IIS. To do it, capture a network trace of the client sending the bad request. You can analyze the trace to see the raw data that the client sends to IIS, and to see the raw response data that IIS sends back to the client. You can also use an HTTP sniffer tool called [Fiddler](https://www.telerik.com/fiddler), a great tool as it allows you to see the HTTP headers even if the client and server are communicating over SSL.

The next data item you use is the **C:\Windows\System32\LogFiles\HTTPERR\httperr.log** file. In IIS, the HTTP.sys component handles incoming HTTP requests before they're passed along to IIS and is responsible for blocking requests that don't meet the IIS requirements. When HTTP.sys blocks the request, it logs information to its **httperr.log** file concerning the bad request and why it was blocked.

> [!NOTE]
> For more information on the HTTP API error logging that HTTP.sys provides, see [Error logging in HTTP API](../../aspnet/site-behavior-performance/error-logging-http-apis.md).

It's technically possible, although not very likely, that a client might receive an HTTP 400 response, which doesn't have an associated log entry in the **httperr.log** file. It could happen if an ISAPI filter or extension, or an HTTP module in IIS, sets the 400 status, in which case you could look at the IIS log for more information. It could also happen if an entity between the client and the server, such as a proxy server or other network device, intercepts a response from IIS and overrides it with its own 400 status and/or "Bad Request" error.

> [!NOTE]
> This article mainly discusses the common HTTP 400 errors before reaching your website. In some scenarios, your website might also return HTTP 400 errors to clients due to custom code logic or runtime (such as ASP.NET) configuration. If you still can't resolve the HTTP 400 errors after performing the steps in the following sections, try to troubleshoot using the [Failed Requests Tracing feature](../health-diagnostic-performance/troubleshoot-failed-requests-using-tracing-in-iis-85.md) in IIS. If you find the HTTP 400 errors are actually set by your website's corresponding runtime handler, such as ASP.NET, you might need to inspect the details of the requests and responses, along with your website's related code logic and runtime configuration, to understand the cause of the HTTP 400 errors.

## Sample scenario

Following is an example of an HTTP 400 scenario, where a client sends a bad request to IIS and the server sends back an "HTTP 400 - Bad Request" message.

When the client sends its request, the browser error it gets back looks like:

> Bad Request (Header Field Too Long)

Capturing a network trace of the request and response, you see the following outputs:

REQUEST:

```output
HTTP: GET Request from Client
HTTP: Request Method =GET
HTTP: Uniform Resource Identifier =/1234567890123456789012345678901234567890/time.asp
HTTP: Protocol Version =HTTP/1.1
HTTP: Accept-Language =en-us
HTTP: UA-cpu =x86
HTTP: Accept-Encoding =gzip, deflate
HTTP: Host =iisserver
HTTP: Connection =Keep-Alive
HTTP: Data: Number of data bytes remaining = 14 (0x000E)
```

RESPONSE:

```output
HTTP: Response to Client; HTTP/1.1; Status Code = 400 - Bad Request
HTTP: Protocol Version =HTTP/1.1
HTTP: Status Code = Bad Request
HTTP: Reason =Bad Request
HTTP: Content-Type =text/html
HTTP: Date =Wed, 14 Nov 2012 20:36:36 GMT
HTTP: Connection =close
HTTP: Content-Length =44
HTTP: Data: Number of data bytes remaining = 63 (0x003F)
```

You notice that the response headers don't tell as much as the error message in the browser. However, if you look at the raw data in the response body, you see more:

```output
00000030                                           48 54               HT
00000040 54 50 2F 31 2E 31 20 34 30 30 20 42 61 64 20 52 TP/1.1.400.Bad.R
00000050 65 71 75 65 73 74 0D 0A 43 6F 6E 74 65 6E 74 2D equest..Content-
00000060 54 79 70 65 3A 20 74 65 78 74 2F 68 74 6D 6C 0D Type:.text/html.
00000070 0A 44 61 74 65 3A 20 57 65 64 2C 20 32 38 20 4A .Date:.Wed,.28.J
00000080 61 6E 20 32 30 30 39 20 32 30 3A 33 36 3A 33 36 an.2009.20:36:36
00000090 20 47 4D 54 0D 0A 43 6F 6E 6E 65 63 74 69 6F 6E .GMT..Connection
000000A0 3A 20 63 6C 6F 73 65 0D 0A 43 6F 6E 74 65 6E 74 :.close..Content
000000B0 2D 4C 65 6E 67 74 68 3A 20 34 34 0D 0A 0D 0A 3C -Length:.44....<
000000C0 68 31 3E 42 61 64 20 52 65 71 75 65 73 74 20 28 h1>Bad.Request.(
000000D0 48 65 61 64 65 72 20 46 69 65 6C 64 20 54 6F 6F Header.Field.Too
000000E0 20 4C 6F 6E 67 29 3C 2F 68 31 3E 01 02 03 04 05 .Long).....
000000F0 05 06 0E 94 63 D6 68 37 1B 8C 16 FE 3F D5       ....c.h7....?.
```

You can see that the error message text displayed in the browser is also viewable in the raw response data in the network trace.

The next step is to look at the _httperr.log_ file in the _C:\Windows\System32\LogFiles\HTTPERR_ directory for the entry that corresponds to the bad request:

```output
#Software: Microsoft HTTP API 1.0
#Version: 1.0
#Date: 2012-11-14 20:35:02
#Fields: date time cs-version cs-method cs-uri sc-status s-reason 
2012-11-14 20:36:36 HTTP/1.1 GET /1234567890/time.asp 400 FieldLength
```

In this scenario, the `Reason` field in the _httperr.log_ file provides the exact information you need to diagnose the problem. You see that HTTP.sys logged `FieldLength` as the reason phrase for this request's failure. Once you know the reason phrase, check the table in [Kinds of errors that the HTTP API logs](../../aspnet/site-behavior-performance/error-logging-http-apis.md#kinds-of-errors-that-the-http-api-logs) section to get its description:

> FieldLength: A field length limit was exceeded.

So at this point you know from the browser error message and the HTTP API error logging that the request contained data in one of its HTTP headers that exceeded the allowable length limits. For this example, the `HTTP: Uniform Resource Identifier header` is purposefully long: _/1234567890123456789012345678901234567890/time.asp_.

The final stage of troubleshooting this example is to check [the HTTP.sys registry keys and default settings for IIS](../iisadmin-service-inetinfo/httpsys-registry-windows.md)

Since you know the reason phrase and error are suggesting a header field length exceeding limits, you can narrow our search in the [Registry Keys](../iisadmin-service-inetinfo/httpsys-registry-windows.md#registry-keys) table as such. The prime candidate here is:

|Registry key|Default value|Valid value range|Registry key function|WARNING code|
|---|---|---|---|---|
|`MaxFieldLength`|16384|64 - 65534 (64k - 2) bytes|Sets an upper limit for each header. See `MaxRequestBytes`. This limit translates to approximately 32k characters for a URL.|1|

To reproduce this error for this example, the `MaxFieldLength` registry key was set with a value of _2_. Since the requested URL had a `HTTP: Uniform Resource Identifier header` field with more than two characters, the request was blocked with the `FieldLength` reason phrase.

Another common HTTP 400 scenario is one where the user making the HTTP request is a member of a large number of Active Directory groups, and the website is configured to user Kerberos authentication. When this scenario occurs, an error message similar to the following one will be displayed to the user:

> Bad Request (Request Header Too Long)

In this scenario, the authentication token that is included as part of the client's HTTP request is too large and exceeds size limits that http.sys is enforcing. This problem is discussed in detail, along with the solution, in [HTTP 400 - Bad Request (Request Header too long) responses to HTTP requests](../www-administration-management/http-bad-request-response-kerberos.md).

## References

- [Error logging in HTTP API](../../aspnet/site-behavior-performance/error-logging-http-apis.md)
