---
title: Troubleshoot HTTP 404 File Not Found in IIS
description: Resolve "HTTP 404 - File not found" errors on IIS servers. Identify and fix causes such as missing files, disabled extensions, and MIME type issues.
ms.date: 03/17/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: v-shaywood
---
# "HTTP 404 - File not found" error

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 248033

> [!NOTE]
> This article is intended for website administrators. If you're a customer, contact your website administrator to report this error.

## Summary

This article helps you troubleshoot and resolve the "HTTP 404 - File not found" error that you encounter on a server that runs Internet Information Services (IIS). Common causes include renamed, moved, or deleted files; disabled web service extensions; and unmapped MIME types. Resolution steps cover dynamic and static content scenarios, including virtual directory configuration and request filtering.

## Symptoms

When you request a webpage, you receive the following error message at the top of the browser window:

> The page cannot be found  
> The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.

The following error message also appears further down the browser window:

> HTTP 404 - File not found  
> Internet Information Services

## Cause

The web server returns the "HTTP 404 - File not found" error message when it can't retrieve the requested page.

Common causes include:

- The requested file was renamed.
- The requested file was moved or deleted.
- The requested file is temporarily unavailable because of maintenance, upgrades, or other unknown causes.
- The requested file doesn't exist.
- IIS 6.0: The appropriate web service extension or MIME type isn't enabled.
- A virtual directory is mapped to the root of a drive on another server.

## Solution

Check that the file in the browser's URL exists on the IIS server and is in the correct location. Use the IIS Microsoft Management Console (MMC) snap-in to determine where the requested file should exist in the IIS server's file system.

If the website uses a [virtual directory](/iis/configuration/system.applicationhost/sites/site/application/virtualdirectory) (VDIR), check whether the virtual directory is mapped to a subfolder on a drive or references the files by name. A *virtual directory* is a directory that's not in the home directory of the website but appears to client browsers as though it is.

For example, assume that the URL that caused the "404" error is `http://Microsoft.com/Test/File1.htm`, and the IIS snap-in shows that, for the Microsoft.com website, the `/Test/` directory is a virtual directory that maps to `C:\Information` on the IIS server. Check whether the `File1.htm` file is in the `C:\Information` directory and whether the file name is spelled correctly.

### IIS dynamic content

If a web extension isn't enabled, the server records a "404.2" entry in the W3C Extended Log file. Use the IIS MMC snap-in to enable the appropriate web extension. Default web extensions include:

- ASP
- ASP.NET
- Server-Side Includes
- WebDAV publishing
- FrontPage Server Extensions
- Common Gateway Interface (CGI)

You must add and explicitly enable custom extensions.

### IIS static content

If a file extension isn't mapped to a known extension in the [MIME Map](/iis/configuration/system.webserver/staticcontent/mimemap) property, the server records a "404.3" entry in the W3C Extended Log file. Use the IIS MMC snap-in to configure the appropriate extension in the MIME Map.

### Request filtering

A "404" response might be related to the Request Filtering module. For more information, see [Request Filtering](/iis/configuration/system.webserver/security/requestfiltering).

### Hidden static files

A "404" response might also be caused by hidden static files. For more information, see [HTTP 404 or Access Denied errors when requesting hidden static files](hidden-static-files-http-404-access-denied.md).

## Related content

- [HTTP status codes in IIS](../health-diagnostic-performance/http-status-code.md)
- [Troubleshoot 4xx and 5xx HTTP errors](troubleshoot-http-error-code.md)
