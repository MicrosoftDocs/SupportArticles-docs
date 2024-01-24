---
title: HTTP error 404 file not found on a server
description: This article provides resolutions for the problem where HTTP error 404 file not found on a server that is running IIS.
ms.date: 12/29/2020
ms.custom: sap:Health, Diagnostic, and Performance Features
ms.subservice: health-diagnostic-performance
---
# How system administrators can troubleshoot an HTTP error 404 - File not found error message on a server that is running IIS

This article helps you resolve the problem where HTTP error 404 file not found on a server that is running Internet Information Services (IIS).

> [!NOTE]
> This article is intended for Web site administrators. End users that experience these errors should notify the Web site administrator of the problem.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 248033

## Symptoms

When a Web page is requested, you receive the following error message at the top of the Web browser:

> The page cannot be found  
The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.

You receive the following error message further down on the Web page:

> HTTP 404 - File not found  
Internet Information Services

## Cause

The Web server returns the **HTTP 404 - File not found** error message when it cannot retrieve the page that was requested.

The following are some common causes of this error message:

- The requested file has been renamed.
- The requested file has been moved to another location and/or deleted.
- The requested file is temporarily unavailable due to maintenance, upgrades, or other unknown causes.
- The requested file does not exist.
- IIS 6.0: The appropriate Web service extension or MIME type is not enabled.
- A virtual directory is mapped to the root of a drive on another server.

## Resolution

To resolve this problem, verify that the file requested in the browser's URL exists on the IIS computer and that it is in the correct location.

Use the IIS Microsoft Management Console (MMC) snap-in to determine where the file requested must exist in the IIS computer's file system.

This is important if the Web site uses a virtual directory (VDIR). A VDIR is a directory that is not contained in the home directory of the Web site, but appears to client browser as though it does. This virtual directory must be mapped to a subfolder on a drive or reference the files by name.

For example, assume that the URL that caused the 404 error is `http://Microsoft.Com/Test/File1.htm`, and the IIS snap-in shows that for Microsoft.Com Web site, the /Test/ directory is actually a virtual directory that maps to the location of c:\Information on the IIS computer. This means that you must verify that the File1.htm file is located in the c:\Information directory (and that the file name is spelled correctly).

IIS Dynamic Content: A 404.2 entry in the W3C Extended Log file is recorded when a Web Extension is not enabled. Use the IIS Microsoft Management Console (MMC) snap-in to enable the appropriate Web extension. Default Web Extensions include: ASP, ASP.NET, Server-Side Includes, WebDAV publishing, FrontPage Server Extensions, Common Gateway Interface (CGI). Custom extensions must be added and explicitly enabled. See the IIS Help File for more information.

IIS Static Content: A 404.3 entry in the W3C Extended Log file is recorded when an extension is not mapped to a known extension in the MIME Map property. Use the IIS Microsoft Management Console (MMC) snap-in to configure the appropriate extension in the MIME Map. See the IIS Help file for more information.

For more information about other, less common causes of this error message, see [IIS hidden static files return HTTP 404 or Access Denied errors](/troubleshoot/iis/hidden-static-files-http-404-access-denied).

## More information

- For more information about virtual directories, see [Virtual Directory \<virtualDirectory>](/iis/configuration/system.applicationhost/sites/site/application/virtualdirectory).

- For more information about IIS, see [IIS](https://www.iis.net/).
