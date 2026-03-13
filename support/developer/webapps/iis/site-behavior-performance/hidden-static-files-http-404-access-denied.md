---
title: Hidden static files return HTTP 404
description: This article provides resolutions for the problem where HTTP 404 File not Found or Access Denied error message from IIS hidden static files.
ms.date: 04/15/2020
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: robmcm; martinsm
---
# IIS hidden static files return HTTP 404.9 or Access Denied errors

This article helps you resolve the error (HTTP 404 or Access Denied) that occurs from the IIS hidden static file.

_Original product version:_ &nbsp; Internet Information Services 10.0 and later versions  
_Original KB number:_ &nbsp; 216803

## Symptoms

Static files that have the `hidden` attribute set may return an **HTTP 404** or an **Access Denied** error when browsed, while dynamic files can still be browsed.

## Cause

This behavior is by design.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Remove the hidden attribute from the file

If the file doesn't need to be hidden, remove the `hidden` attribute so that IIS can serve it normally:

1. In Windows Explorer, right-click the file and select **Properties**.
2. On the **General** tab, clear the **Hidden** checkbox.
3. Select **OK**.

Alternatively, run the following command from an elevated command prompt:

```console
attrib -h <path_to_file>
```

### Method 2: Use NTFS permissions instead of the hidden attribute

If your goal is to restrict access to certain files, use NTFS permissions rather than the `hidden` attribute. NTFS permissions provide granular access control without preventing IIS from serving the file to authorized users.

1. In Windows Explorer, right-click the file or folder and select **Properties**.
2. Select the **Security** tab.
3. Select **Edit** to modify permissions, and then add or remove the appropriate users or groups to control access.
4. Select **OK** to apply the changes.

> [!NOTE]
> Ensure the IIS application pool identity (for example, `IIS AppPool\<AppPoolName>`) has **Read** permission on any files that IIS needs to serve.

## More information

IIS doesn't serve static files (such as *.html*, *.css*, *.js*, or image files) that have the Windows `hidden` attribute set. When a client requests a hidden static file, IIS returns an **HTTP 404 - File Not Found** or an **Access Denied** error.

Dynamic content is not affected by this behavior because it's processed by IIS modules or handler mappings rather than being served directly. For example:

- **ASP.NET** pages (*.aspx*) are handled by the ASP.NET ISAPI extension or the managed handler in the integrated pipeline.
- **Classic ASP** pages (*.asp*) are handled by the *Asp.dll* ISAPI extension.
- **Server-Side Includes** (*.stm*, *.shtm*, *.shtml*) are handled by the *Ssiinc.dll* ISAPI extension.

These handlers read and process the file content on the server before sending the response to the client, which bypasses the hidden-file check that applies to static file requests.
