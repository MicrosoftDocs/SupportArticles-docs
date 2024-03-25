---
title: Memory optimization for HTTP POST or PUT
description: This article provides a resolution for the problem that occurs when you use the HttpWebRequest class to send lots of data for an HTTP POST or PUT request.
ms.date: 10/26/2020
ms.custom: sap:General
ms.reviewer: huizhu, pphadke
---
# Memory optimization for a large HttpWebRequest POST or PUT based on .NET framework 4.5

This article helps you resolve the problem that occurs when you use the `HttpWebRequest` class to send lots of data for an HTTP POST or PUT request.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2855735

## Symptoms

When you use the `HttpWebRequest` class to send lots of data for an HTTP POST or PUT request, the request may fail on a computer that is running the Microsoft .NET Framework. Additionally, you may receive an out-of-memory exception.

You may notice that the application that uses the `HttpWebRequest` class consumes lots of memories. When you use Performance Monitor to monitor the application that uses the `HttpWebRequest` class, the Private Bytes count will continue to increase as data is sent.

## Cause

This issue occurs because the .NET Framework buffers the outgoing data by default when you use the `HttpWebRequest` class. [A POST or PUT request fails when you use the HttpWebRequest class to send lots of data](post-put-request-fail-httpwebrequest.md) documents the original issue.

## Resolution

To work around this issue, set the `HttpWebRequest.AllowWriteStreamBuffering` property to false. By doing this, outgoing data (entity body) for the POST or the PUT request will not be buffered in memory.

In versions of .NET Framework earlier than 4.5, setting `HttpWebRequest.AllowWriteStreamBuffering` property to false would sometimes result in errors when uploading data to authenticated endpoints. For example, you might encounter a `System.Net.WebException` with the message **This request requires buffering data to succeed**. However, on deeper investigation the response associated with the exception actually indicates a status code of `System.Net.HttpStatusCode.Unauthorized` (401). [A POST or PUT request fails when you use the HttpWebRequest class to send lots of data](post-put-request-fail-httpwebrequest.md) documents a workaround of pre-authentication and KeepAlive connection to handle 401 response.

Unlike .NET Framework 1.1, 2.0, 3.0, 3.5 and 4.0, .NET Framework 4.5 adds new design functionality for the `HttpWebRequest.AllowWriteStreamBuffering` property. The new functionality can handle the authentication scenario directly as long as the `Expect100Continue` feature is enabled. The default `ServicePointManager.Expect100Continue` value is **true**.

## More information

- [A POST or PUT request fails when you use the HttpWebRequest class to send lots of data](post-put-request-fail-httpwebrequest.md)

- [HttpWebRequest.AllowWriteStreamBuffering Property](/dotnet/api/system.net.httpwebrequest.allowwritestreambuffering)

- [ServicePointManager.Expect100Continue Property](/dotnet/api/system.net.servicepointmanager.expect100continue)
