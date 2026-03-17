---
title: Resolve IIS HTTP 404 Errors for Hidden Static Files
description: Discover how to resolve HTTP 404 or Access Denied errors in IIS caused by hidden static files. Follow our guide for quick and easy fixes.
ms.date: 03/17/2026
ms.reviewer: robmcm; martinsm, sainathreddy.gnv, v-shaywood
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
---
# HTTP 404 or Access Denied errors when requesting hidden static files

_Original product version:_ &nbsp; Internet Information Services 10.0 and later versions  
_Original KB number:_ &nbsp; 216803

## Summary

This article helps you resolve `HTTP 404` or Access Denied errors that occur when Internet Information Services (IIS) attempts to serve static files that have the Windows `hidden` attribute set. It covers the cause of this behavior and provides two methods to fix the issue.

## Symptoms

Static files that have the `hidden` attribute set return an `HTTP 404` or Access Denied error when requested, but dynamic files are still served successfully.

## Cause

This behavior is by design. IIS doesn't serve static files (such as `.html`, `.css`, `.js`, or image files) that have the Windows `hidden` attribute set. When a client requests a hidden static file, IIS returns an "HTTP 404 - File Not Found" or "Access Denied" error message.

Dynamic content isn't affected by this behavior because IIS modules or handler mappings process it rather than serving it directly. For example:

- ASP.NET pages (`.aspx`) are handled by the ASP.NET ISAPI extension or the managed handler in the integrated pipeline.
- Classic ASP pages (`.asp`) are handled by the `Asp.dll` ISAPI extension.
- Server-Side Includes (`.stm`, `.shtm`, `.shtml`) are handled by the `Ssiinc.dll` ISAPI extension.

These handlers read and process the file content on the server before sending the response to the client, which bypasses the hidden-file check that applies to static file requests.

## Solution

To resolve this issue, use one of the following methods.

### Remove the hidden attribute from the file

If you don't need to hide the file, remove the `hidden` attribute so IIS can serve the file normally:

1. In File Explorer, right-click the file and select **Properties**.
2. On the **General** tab, clear the **Hidden** checkbox.
3. Select **OK**.

Alternatively, run the following command from an elevated command prompt:

```console
attrib -h <PathToFile>
```

### Use NTFS permissions instead of the hidden attribute

If you want to restrict access to certain files, use NTFS permissions instead of the `hidden` attribute. NTFS permissions give you detailed access control and don't stop IIS from serving the file to users who are authorized.

1. In File Explorer, right-click the file or folder and select **Properties**.
2. Select the **Security** tab.
3. Select **Edit** to change permissions, and then add or remove users or groups to control access.
4. Select **OK** to apply the changes.

> [!IMPORTANT]
> Make sure the IIS application pool identity (for example, `IIS AppPool\<AppPoolName>`) has **Read** permission on any files that IIS needs to serve.
