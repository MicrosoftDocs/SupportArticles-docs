---
title: HTTP error 503 and event 5189 from web applications
description: This article provides resolutions for the HTTP 503 error and 5189 event where after you upgrade to Version 1709 (Fall Creators Update) on Windows 10 or Windows Server 2016, web applications fail to start, and return an HTTP 503 error and WAS event 5189.
ms.date: 01/29/2021
ms.prod-support-area-path: IISAdmin Service and Inetinfo Process Operation
---
# Web applications return HTTP Error 503 and WAS event 5189 on Windows 10 Version 1709

This article helps you resole the HTTP 503 error and 5189 event where after you upgrade to Version 1709 (Fall Creators Update) on Windows 10 or Windows Server 2016, web applications fail to start, and return an HTTP 503 error and  Windows Activation Service (WAS) event 5189.

_Original product version:_ &nbsp; Windows 10 Enterprise, Windows 10 Pro, Windows Server 2016 Standard, Windows Server 2016 Datacenter  
_Original KB number:_ &nbsp; 4050891

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows 10 or Windows Server 2016 that has Internet Information Services (IIS) enabled.
- You upgrade to Windows 10 Version 1709 (Fall Creators Update) or Windows Server 2016 Version 1709.

After the upgrade, some web applications do not start, and they return the following HTTP 503 error message:

> Service Unavailable  
HTTP Error 503. The service is unavailable.

Also, WAS event 5189 is logged in the event log:

> The Windows Process Activation Service failed to generate an application pool config file for application pool '\<DefaultAppPool>'. The error type is '5'. To resolve this issue, please ensure that the applicationhost.config file is correct and recommit the last configuration changes made. The data field contains the error number.

## Resolution

To resolve this problem, manually delete the symbolic links that are created by Windows Update. To do this, follow these steps.

> [!NOTE]
> Symbolic links can be deleted the same as regular files.

1. Open a Command Prompt window by using the **Run as administrator** option.
2. Run the following commands:

    ```console
    net stop WAS /y
    rmdir /s /q C:\inetpub\temp\appPools
    net start W3SVC
    ```

## Cause

The WAS creates a temporary configuration file for each IIS application pool in the `C:\inetpub\temp\appPools` folder during typical operation.

During an initial upgrade phase, Windows Update scans the existing folders and files (outside the Windows folder), and records their paths to be restored after upgrade. However, because the configuration files are temporary, they are deleted when WAS is stopped.

In the next phase of Windows Update, these previously scanned files and folders are copied to a temporary upgrade location. After Windows is upgraded, Windows Update creates a symbolic link to each folder that was copied to a temporary upgrade location before it tries to restore these files and folders to their original location.

However, because these temporary configuration files no longer exist, Windows Update does not remove the symbolic links.

When WAS tries to start as an IIS worker process, it does not create a temporary folder to write the configuration because of the symbolic links. Therefore, Http.Sys returns an HTTP 503 error.
