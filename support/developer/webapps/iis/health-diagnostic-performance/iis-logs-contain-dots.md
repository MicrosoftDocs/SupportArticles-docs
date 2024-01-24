---
title: IIS logs contain dots instead of logging field value
description: This article provides resolutions for the problem where IIS logs contain ... instead of expected logging field value.
ms.date: 12/11/2020
ms.custom: sap:Health, Diagnostic, and Performance Features
ms.reviewer: mlaing, bretb
ms.subservice: health-diagnostic-performance
---
# IIS logs contain <...> instead of expected logging field value

This article helps you resolve the problem where Internet Information Services (IIS) logs contain `...` instead of expected logging field value.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 2809913

## Symptoms

Assume you have IIS Logging configured to log site traffic using the W3C logging format. When you inspect the IIS logs, you notice that one or more of the logging field values contain three dots (`...`) instead of the expected value. For example, you may see an IIS log entry similar to the following:

> #Software: Microsoft Internet Information Services 7.5  
#Version: 1.0  
#Date: \<DateTime>  
#Fields: date time cs-method cs-uri-stem s-port cs-username cs(Cookie) sc-status sc-substatus  
\<DateTime>  GET /time.asp 80 - ... 200 0

In the above example, the cs(Cookie) value is `...` instead of the actual cookie value.

## Cause

This behavior is by design. The length of each IIS log field value is limited to 4096 bytes (4k). If one of the field values is greater than 4096 bytes, that value will be replaced with the three dots. In the above example, the client's Cookie was larger than 4096 bytes and was therefore replaced with (`...`).

## Workaround

To work around this issue, use one of the following options:

- Write your own custom logging module that does not have the 4096-byte field limitation.

- Reduce the size of the request or response header values to be logged so that they are less than 4096 bytes and will therefore not be replaced by the three dots.

## More information

- [Custom Logging Modules](/previous-versions/windows/it-pro/windows-server-2003/cc778794(v=ws.10))

- [Develop a Native C\C++ Module for IIS 7.0](/iis/develop/runtime-extensibility/develop-a-native-cc-module-for-iis)
