---
title: Time-taken fields in IIS HTTP logging
description: This article describes the functionality of the time-taken field in Internet Information Services (IIS) 6.0 and IIS 7.0 HTTP logging, and also describes the values that are stored in the time-taken field.
ms.date: 08/13/2024
ms.custom: sap:Health, Diagnostic, and Performance Features\IIS logging
ms.reviewer: mlaing
ms.topic: concept-article
---
# Description of the time-taken field in IIS 7 HTTP logging

This article describes the functionality of the time-taken field in Microsoft Internet Information Services (IIS) Hypertext Transfer Protocol (HTTP) logging.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 944884

## Time-taken field

By default, IIS logs HTTP site activity by using the W3C Extended log file format. You can use IIS Manager to select the fields to include in the log file. One of these fields is the time-taken field.

The time-taken field measures the length of time that it takes for a request to be processed, in milliseconds. The client-request time stamp is initialized when HTTP.sys receives the first byte of the request. HTTP.sys is the kernel-mode component that is responsible for HTTP logging for IIS activity. The client-request time stamp is initialized before HTTP.sys begins parsing the request. The client-request time stamp is stopped when the last IIS response send completion occurs.

Beginning in IIS 7.0, the time-taken field includes network time. Before HTTP.sys logs the value in the time-taken field, HTTP.sys usually waits for the client to acknowledge the last response packet send operation or HTTP.sys waits for the client to reset the underlying TCP connection. Therefore, when a large response or large responses are sent to a client over a slow network connection, the value of the time-taken field may be more than expected.

> [!NOTE]
> The value in the time-taken field doesn't include network time if one of the following conditions is true:
>
> - The response size is less than or equal to 2 KB, and the response size is from memory.
> - TCP buffering is used. Applications that use *HTTPAPI.dll* can set the `HTTP_SEND_RESPONSE_FLAG_BUFFER_DATA` flag to enable TCP buffering on Windows. This allows the server to send all of the response data to the client without having to wait for the client's corresponding acknowledgements.

## More information

[Configure Logging in IIS](/iis/manage/provisioning-and-managing-iis/configure-logging-in-iis)