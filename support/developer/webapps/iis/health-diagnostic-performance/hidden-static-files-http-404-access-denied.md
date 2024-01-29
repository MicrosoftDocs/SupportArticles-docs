---
title: Hidden static files return HTTP 404
description: This article provides resolutions for the problem where HTTP 404 File not Found or Access Denied error message from IIS hidden static files.
ms.date: 04/15/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.subservice: health-diagnostic-performance
ms.reviewer: robmcm; martinsm
---
# IIS hidden static files return HTTP 404 or Access Denied errors

This article helps you resolve the error (HTTP 404 or Access Denied) that occurs from the IIS hidden static file.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 216803

> [!IMPORTANT]
> We strongly recommend that all users upgrade to Microsoft Internet Information Services (IIS) version 7.0 running on Windows Server 2008. IIS 7.0 significantly increases Web infrastructure security. For more information about IIS 7.0, see [Home: The Official Microsoft IIS Site](https://www.iis.net/).

## Symptoms

Static files that have the `hidden` attribute set may return an **HTTP 404** or an **Access Denied** error when browsed, while dynamic files can still be browsed.

## Cause

This behavior is by design.

## Resolution

Configuring access control for all Web files should always be implemented through NT File System (NTFS) permissions.

## More information

Dynamic files such as Active Server Pages (ASP) or Server-Side Includes (SSI) are implemented through script-mapped Internet Server Application Programming Interface (ISAPI) extensions, in this case the *Asp.dll* and *Ssiinc.dll* files respectively. These extensions preprocess the executable code in the files being requested and can therefore read hidden files and return the expected HTML output to a client. Direct Web browsing of hidden static files results in a **File not Found** or an **Access Denied** error message.
