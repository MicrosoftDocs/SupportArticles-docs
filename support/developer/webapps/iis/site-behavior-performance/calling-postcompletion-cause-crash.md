---
title: Calling PostCompletion twice may cause crash
description: "This article provides workaround for the problem where Calling HttpContext::PostCompletion method twice may cause crash."
ms.date: 12/11/2020
ms.custom: sap:Site Behavior and Performance
ms.reviewer: ahmetmb
ms.technology: site-behavior-performance
---
# Calling HttpContext::PostCompletion method twice may cause crash

This article helps you work around the problem where Calling `HttpContext::PostCompletion` method twice may cause crash.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 2824214

## Summary

If you develop an IIS module, which calls PostCompletion twice. In this scenario, on the second call to `PostCompletion`, your web application crashes with an Access Violation.

## Cause

`PostCompletion` indicates that an HTTPRequest has completed. Thus the HttpContext object is no longer available so the second call to the HttpContext object's `PostCompletion` method causes an Access Violation.

## Workaround

If you are calling `PostCompletion`, then put a guard (for example: check if HttpContext is not null) around it to avoid crash if it is invoked automatically.

For more information about the PostCompletion method, see [IHttpContext::PostCompletion Method](/iis/web-development-reference/native-code-api-reference/ihttpcontext-postcompletion-method).
