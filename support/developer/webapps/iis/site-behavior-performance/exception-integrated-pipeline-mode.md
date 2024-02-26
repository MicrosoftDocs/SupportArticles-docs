---
title: Application can't run in Integrated Pipeline mode
description: This article provides resolutions for the System.Web.HttpException that occurs when an application runs in Integrated Pipeline mode.
ms.date: 03/23/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: rakkim, mlaing
ms.subservice: site-behavior-performance
---
# System.Web.HttpException in Internet Information Services

This article helps you resolve the `System.Web.HttpException` that occurs when an application runs in Integrated Pipeline mode, and provides a resolution.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 2605401

## Symptoms

Consider the following scenario:

- You run a web application configured to use the Integrated Pipeline on a Microsoft Internet Information Services (IIS) 7.0 or later versions web server.
- The application uses an ISAPI filter registered for the `SF_NOTIFY_AUTHENTICATION` event.
- The application's *global.asax* implements the `Application_BeginRequest` event.

Under these conditions, this exception may occur:

> System.Web.HttpException: This server variable cannot be modified during request execution.

## Cause

This behavior is by design.

When IIS calls the ISAPI filter for the `SF_NOTIFY_AUTHENTICATION` event, it updates the `AUTH_USER` server variable. Since the application is configured to use the Integrated Pipeline, ASP.NET looks for changes in server variables. `AUTH_USER` is one of the variables that is not expected to change, and therefore ASP.NET throws the above exception.

This exception will not get thrown if the application pool is running in Classic mode instead of Integrated Pipeline mode.

## Resolution

Either of the methods below prevents this exception:

1. Configure the application pool to run in Classic mode instead of Integrated Pipeline mode.
2. Use native or managed Http Modules to handle authentication notifications.

### More information

For more information, see [Develop a Native C\C++ Module for IIS 7.0](/iis/develop/runtime-extensibility/develop-a-native-cc-module-for-iis).
