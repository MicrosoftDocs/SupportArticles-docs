---
title: Error when you use Server.Transfer
description: This article provides the resolution to solve the 'Error Executing Child Request' error.
ms.date: 04/15/2020
ms.custom: sap:Performance
ms.reviewer: radomirz
---
# Error when you use Server.Transfer or Server.Execute in ASP.NET pages: Executing Child Request

This article helps you resolve the problem that an error (executing child request) occurs when you transfer control from an ASP.NET page to an Active Server Pages (ASP) page in Internet Information Services (IIS).

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 320439

## Symptoms

When you try to use the `Server.Transfer` or the `Server.Execute` method in your ASP.NET page to transfer control from an ASP.NET page to an ASP page, you might receive the following error message:

> Error executing child request for PageName.asp.

The *PageName.asp* in the error message is the name of your ASP page.

## Cause

IIS dispatches the `Server.Transfer` or the `Server.Execute` request to the appropriate Internet Server Application Programming Interface (ISAPI) extension based on the extension of the requesting file. For example, a request for an .aspx page is dispatched to the *Aspnet_isapi.dll* ISAPI extension.

After the request is dispatched to appropriate ISAPI extension, the ISAPI extension cannot call another ISAPI extension. You receive the error message that is listed in the **Symptoms** section because the *Aspnet_isapi.dll* file, which handles requests to ASP.NET pages, cannot forward the request to the *Asp.dll* file, which handles requests to ASP pages.

## Resolution

To resolve this problem, use the `Response.Redirect` method to redirect the request from an ASP.NET page to an ASP page.

## Status

This behavior is by design.
