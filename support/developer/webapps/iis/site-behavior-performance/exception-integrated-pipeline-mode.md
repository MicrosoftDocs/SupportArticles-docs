---
title: Application can't run in Integrated Pipeline mode
description: This article provides resolutions for the System.Web.HttpException that occurs when an application runs in Integrated Pipeline mode.
ms.date: 12/16/2024
ms.custom: sap:Development\Native HTTP modules
ms.reviewer: rakkim, mlaing
---
# System.Web.HttpException in Internet Information Services

This article helps you resolve the `System.Web.HttpException` that occurs when an application runs in Integrated Pipeline mode, and provides a resolution.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2605401

## Symptoms

Consider the following scenario:

- You run a web application configured to use the Integrated Pipeline on a Microsoft Internet Information Services (IIS) web server.
- The application uses an ISAPI filter registered for the `SF_NOTIFY_AUTHENTICATION` event.
- The application's *global.asax* implements the `Application_BeginRequest` event.

Under these conditions, this exception might occur:

> System.Web.HttpException: This server variable cannot be modified during request execution.

## Cause

This behavior is by design.

When IIS calls the ISAPI filter for the `SF_NOTIFY_AUTHENTICATION` event, it updates the `AUTH_USER` server variable. Since the application is configured to use the Integrated Pipeline, ASP.NET looks for changes in server variables. `AUTH_USER` is one of the variables that isn't expected to change, and therefore ASP.NET throws the exception.

This exception isn't thrown if the application pool is running in Classic mode instead of Integrated Pipeline mode.

## Resolution

To prevent this exception, use one of the following methods:

- Configure the application pool to run in Classic mode instead of Integrated Pipeline mode.
- Use native or managed Http Modules to handle authentication notifications.

### More information

For more information, see [Develop a Native C\C++ Module for IIS](/iis/develop/runtime-extensibility/develop-a-native-cc-module-for-iis).
