---
title: Fix HTTP Error 500.19 on IIS webpages
description: Learn how to resolve the HTTP Error 500.19 on IIS 7.0 and later versions. Fix configuration issues that cause internal server errors.
ms.date: 03/17/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: mlaing, v-shaywood
---
# "HTTP 500.19 - Internal Server Error" error

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942055

## Summary

This article helps you resolve the "HTTP 500.19 - Internal Server Error" that occurs on a web application in Internet Information Services (IIS) 7.0 and later versions. This error indicates that the related configuration data for the requested page is invalid. Common causes include malformed XML in configuration files, locked configuration sections, insufficient file permissions, duplicate configuration entries, and missing modules.

To resolve this error, find the HRESULT code in the error message, and check the matching section. For ASP.NET Core applications, see [Missing hosting bundle for ASP.NET Core](#missing-hosting-bundle-for-aspnet-core).

## HRESULT code 0x8007000d

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007000d  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The `ApplicationHost.config` or `Web.config` file contains a malformed or unrecognized XML element. IIS can't identify XML elements for modules that aren't installed (for example, the [IIS URL Rewrite module](/iis/extensions/url-rewrite-module/using-the-url-rewrite-module)).

### Solution

Use one of the following methods:

- Delete the malformed XML element from the `ApplicationHost.config` or `Web.config` file.
- Check the unrecognized XML elements, and then install the relevant IIS modules.

## HRESULT code 0x80070021

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070021  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The specified portion of the IIS configuration file is locked at a higher configuration level.

### Solution

Unlock the specified section, or don't use it at the higher level. For more information about configuration locking, see [How to Use Locking in IIS 7.0 Configuration](/iis/get-started/planning-for-security/how-to-use-locking-in-iis-configuration).

## HRESULT code 0x80070005

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070005  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

This problem occurs for one of the following reasons:

- The website uses Universal Naming Convention (UNC) pass-through authentication to access a remote UNC share.
- The IIS_IUSRS group doesn't have the appropriate permissions for the `ApplicationHost.config` file, the `Web.config` file, or the virtual or application directories of IIS.

### Solution

Use one of the following methods:

- Don't configure the website to use UNC pass-through authentication to access the remote UNC share. Instead, specify a user account that has the appropriate permissions to access the remote UNC share.

- Grant the Read permission to the IIS_IUSRS group for the `ApplicationHost.config` or `Web.config` file:

    1. In Windows Explorer, locate the folder that contains the `ApplicationHost.config` file that's associated with the website, or locate the virtual directories or application directories that contain the `Web.config` file that's associated with the website.

       > [!NOTE]
       > The `Web.config` file might not be in the virtual directories or application directories in IIS. Even in this situation, follow these steps:

    1. Right-click the folder that contains the `ApplicationHost.config` file, or right-click the virtual or application directories that might contain the `Web.config` file.

    1. Select **Properties**.

    1. Select the **Security** tab, and then select **Edit**.

    1. Select **Add**.

    1. In the **Enter the object names to select** box, type `<ComputerName>\IIS_IUSRS`, select **Check Names**, and then select **OK**.

    1. Select the **Read** checkbox, and then select **OK**.

    1. In the **Properties** dialog for the folder, select **OK**.

        > [!NOTE]
        > Make sure that the folder properties are inherited by the `ApplicationHost.config` and `Web.config` files so that IIS_IUSRS has the _Read_ permission for those files.

## HRESULT code 0x800700b7

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700b7  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

A duplicate entry exists for the specified configuration section setting at a higher level in the configuration hierarchy (for example, the `ApplicationHost.config` or `Web.config` file in a parent site or folder). The error message points out the location of the duplicate entries.

### Solution

Examine the specified configuration file, and compare it with its parent `ApplicationHost.config` or `Web.config` file to check for duplicate entries. Either remove the duplicate entry or make the entry unique. For example, this problem might occur because the `ApplicationHost.config` file has a duplicate entry for the following code:

```xml
<add accessType="Allow" users="*" />
```

To resolve this problem, delete the duplicate entry in the `ApplicationHost.config` file for the authorization rule:

1. Open **Notepad** as an administrator.

1. On the **File** menu, select **Open**, enter `%windir%\System32\inetsrv\config\ApplicationHost.config` in the **File name** field, and then select **Open**.

1. In the `ApplicationHost.config` file, delete the duplicate entry that resembles the following code:

    ```xml
    <add accessType="Allow" users="*" />
    ```

## HRESULT code 0x8007007e

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007007e  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The `ApplicationHost.config` or `Web.config` file references a module or a DLL that's invalid or doesn't exist.

### Solution

In the `ApplicationHost.config` or `Web.config` file, locate the invalid module reference or DLL reference, and then remove the reference. To determine which module reference is incorrect, enable [Failed Request Tracing](../health-diagnostic-performance/troubleshoot-failed-requests-using-tracing-in-iis-85.md), and then reproduce the problem.

## HRESULT code 0x800700c1

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700c1  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The bitness of the specified module differs from the application pool that hosts the application. For example, you try to load a 32-bit component into a 64-bit application pool. This problem might also occur if the specified module is corrupted.

### Solution: Match module and application pool bitness

Make sure that the specified module's bitness matches the hosting application pool. Also, make sure that the module isn't corrupted.

## HRESULT code 0x8007010b

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007010b  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The specified content directory can't be accessed.

### Solution

- Check that the file path exists.
- Check that the file path is correctly named.
- Check that the file path has the correct file-level permissions set.
- Check that the file path points to a valid file system type.

If you're not sure what the file path is, use [Process Monitor](/sysinternals/downloads/procmon) or [Failed Request Tracing](../health-diagnostic-performance/troubleshoot-failed-requests-using-tracing-in-iis-85.md) to identify it.

## HRESULT code 0x8007052e

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007052e  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The default process identity in IIS doesn't have sufficient permissions to open the `Web.config` file on a remote share.

### Solution

Check that the application pool identity account of this web application has sufficient permissions to open the `Web.config` file.

## HRESULT code 0x80070003

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070003  
> Description of HRESULT  
> Cannot read configuration file.

### Cause

This error is caused by insufficient permissions or by a physical path that doesn't match the path for the virtual directory. For example, no `Web.config` file exists under the web app's physical root path.

### Solution

- Check that the `Web.config` path exists and has correct permissions set.
- Collect [Process Monitor](/sysinternals/downloads/procmon) logs to get more information about the error.

## Missing hosting bundle for ASP.NET Core

If this error occurs for an ASP.NET Core application, the ASP.NET Core Hosting Bundle for the .NET version that your application targets likely isn't installed. Download and install the correct version of the [.NET Hosting Bundle](/aspnet/core/host-and-deploy/iis/hosting-bundle).

## Prevent configuration file issues during Windows updates

As a general safety measure, back up all configuration files (not only IIS) before you install any update. If you use virtual machines, take a snapshot before you update. This guidance applies to all updates, not only Windows updates.

## Related content

- [HTTP status codes in IIS](../health-diagnostic-performance/http-status-code.md)
- [Introduction to ApplicationHost.config](/iis/get-started/planning-your-iis-architecture/introduction-to-applicationhostconfig)
- [Getting Started with Configuration in IIS](/iis/get-started/planning-your-iis-architecture/getting-started-with-configuration-in-iis-7-and-above)
