---
title: Internet Printing fails
description: This article provides resolutions for the problem where Internet Printing fails if the document to be printed is larger than 29 MB.
ms.date: 03/19/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: mlaing
ms.subservice: site-behavior-performance
---
# Internet Printing fails if the document to be printed is larger than 29 MB

This article helps you resolve the problem where the Internet Printing fails if the document to be printed is larger than 29 MB.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2533472

## Symptoms

You are attempting to print a document over the internet by using the Internet Printing Protocol (IPP) pointing to a Microsoft Internet Information Services (IIS) 7.0 or 7.5 server. Instead of the document successfully printing, an error status is displayed in the client's printer queue window. Additionally, an error message similar to the following ones appear in the event logs:

> The document <*document_name* >, owned by <*owner_name* >,  
> failed to print on printer <*url_of_internet_printer* >.  
> Try to print the document again, or restart the print spooler.  
>
> Win32 error code returned by the print processor:2147500037.  
> Unspecified error

## Cause

The size of the document to be printed exceeds the allowable request size limit enforced by the IIS web server hosting the Internet printer.

## Resolution

Increase the value of the `maxAllowedContentLength` configuration property on the IIS server hosting the Internet printer so it is slightly larger than the size of the document to be printed.

## More information

The default value of the `maxAllowedContentLength` value in IIS 7.0 and above is 30000000 bytes. So this problem can occur if that configuration value has not been changed and the document being printed is approximately 28.6 MB or greater in size. The IIS sign-in the IIS server will contain an entry similar to the following corresponding to the blocking of the POST request that is sent as part of the printing operation:

```console
date time cs-method cs-uri-stem s-port sc-status sc-substatus sc-win32-status
2011-01-01 10:00:01 POST /printers/.printer - 80 - 404 13 0
```

IIS enforces this request size rule as a security measure. So it isn't recommended to increase the `maxAllowedContentLength` value greater than needed.

For more information on how to modify the `maxAllowedContentLength` configuration property in IIS, visit [Error message when you visit a Web site that is hosted on a server that is running Internet Information Services 7.0: 'HTTP Error 404.13 - CONTENT_LENGTH_TOO_LARGE'](https://support.microsoft.com/help/942074).
