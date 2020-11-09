---
title: HTTP Error 500.19 on IIS webpages
description: Resolves the HTTP 500.19 error that occurs when you visit a website that is hosted on IIS 7.0 and later versions.
ms.date: 04/16/2020
ms.prod-support-area-path: Health, diagnostic, and performance features
ms.reviewer: mlaing
---
# HTTP Error 500.19 when you open an IIS Webpage

This article resolves a problem in which you receive an "HTTP 500.19" error message on a web application in Internet Information Services (IIS) 7.0 and later versions.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions
_Original KB number:_ &nbsp; 942055

To resolve this error, check the following sections for the appropriate error code information.

## HResult code 0x8007000d

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007000d  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs because the ApplicationHost.config or Web.config file contains a malformed XML element.

Resolution

Delete the malformed XML element from the ApplicationHost.config or Web.config file.

## HResult code 0x80070021

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070021  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem can occur if the specified portion of the IIS configuration file is locked at a higher configuration level.

Resolution

Unlock the specified section, or do not use it at the higher level. For more information about configuration locking, see [How to Use Locking in IIS 7.0 Configuration](/iis/get-started/planning-for-security/how-to-use-locking-in-iis-configuration).

## HResult code 0x80070005

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070005  
> Description of HRESULT  
The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs for one of the following reasons:

- You're using IIS on a computer that is running Windows. Additionally, you configure the website to use UNC pass-through authentication to access a remote Universal Naming Convention (UNC) share.
- The IIS_IUSRS group doesn't have the appropriate permissions for the ApplicationHost.config file, the Web.config file, or the virtual or application directories of IIS.

Resolution

Use one of the following methods:

- Do not configure the website to use UNC pass-through authentication to access the remote UNC share. Instead, specify a user account that has the appropriate permissions to access the remote UNC share.

- Grant the Read permission to the IIS_IUSRS group for the ApplicationHost.config or Web.config file. To do this, follow these steps:

    1. In Windows Explorer, locate the folder that contains the ApplicationHost.config file that is associated with the website, or locate the virtual directories or the application directories that contain the Web.config file that is associated with the website.

        > [!NOTE]
        > The Web.config file may not be in the virtual directories or the application directories in IIS. Even in this situation, you have to follow these steps.

    1. Right-click the folder that contains the ApplicationHost.config file, or right-click the virtual or application directories that may contain the Web.config file.

    1. Select **Properties**.

    1. Select the **Security** tab, and then Select **Edit**.

    1. Select **Add**.

    1. In the **Enter the object names to select** box, type **<*computername*>\IIS_IUSRS**, select **Check Names**, and then select **OK**.

        > [!NOTE]
        > <*Computername*> is a placeholder for the computer name.

    1. Select the **Read** check box, and then select **OK**.

    1. In the **Properties** dialog box for the folder, select **OK**.

        > [!NOTE]
        > Make sure that the folder properties are inherited by the ApplicationHost.config and Web.config files so that IIS_IUSRS has the Read permission for those files.

## HResult code 0x800700b7

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700b7  
> Description of HResult  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem may occur if there's a duplicate entry for the specified configuration section setting at a higher level in the configuration hierarchy (for example, in a parent site or folder ApplicationHost.config or Web.config file). The error message itself points out the location of the duplicate entries.

Resolution

Examine the specified configuration file, and compare it with its parent ApplicationHost.config or Web.config file to check for duplicate entries, as suggested by the error message. Either remove the duplicate entry, or make the entry unique. For example, this problem may occur because the ApplicationHost.config file has a duplicate entry for the following code:

```xml
<add accessType="Allow" users="*" />
```

To resolve this problem, delete the duplicate entry in the ApplicationHost.config file for the authorization rule. To do this, follow these steps:

1. Select **Start**, type **Notepad** in the **Start Search** box, right-click **Notepad**, and then select **Run as administrator**.

    > [!NOTE]
    > If you are prompted for an administrator password or for a confirmation, type the password, or select **Continue**.

2. On the **File** menu, select **Open**, type **%windir%\System32\inetsrv\config\applicationHost.config** in the **File name** box, and then select **Open**.

3. In the ApplicationHost.config file, delete the duplicate entry that resembles the following code:

    ```xml
    <add accessType="Allow" users="*" />
    ```

## HResult code 0x8007007e

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007007e  
> Description of HResult  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs because the ApplicationHost.config or Web.config file references a module or a DLL that is invalid or does not exist.

Resolution

In the ApplicationHost.config or Web.config file, locate the module reference or the DLL reference that is invalid, and then fix the reference. To determine which module reference is incorrect, enable Failed Request Tracing, and then reproduce the problem.

## HResult code 0x800700c1

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700c1  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem can occur if the bitness of the specified module is different than that of the application pool hosting the application. For example, you are trying to load a 32-bit component into a 64-bit application pool. This problem may also occur if the specified module is corrupted.

Resolution

Make sure that the specified module's bitness is the same as that of the hosting application pool. Also,  make sure that the module is not corrupted.

## HResult code 0x8007010b

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007010b  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem can occur if the specified content directory cannot be accessed.

Resolution

Verify that the file path exists, is correctly named, has the correct file-level permissions set, and is pointing to a valid file system type. If you are not sure what the file path is, use the Process Monitor or Failed Request Tracing tool to identify it.

## HResult code 0x8007052e

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007052e  
> Description of HRESULT  
The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

The default process identity in IIS does not have sufficient permissions to open the Web.config file on a remote share.
