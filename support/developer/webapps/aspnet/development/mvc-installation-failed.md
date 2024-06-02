---
title: MVC 3 installation fails
description: This article describes the problem that a fatal error occurs when you install ASP.NET MVC 3 or ASP.NET Web pages.
ms.date: 04/07/2020
ms.custom: sap:General Development
---
# Installation of ASP.NET MVC 3 or ASP.NET Web pages fails with a fatal error

This article helps you resolve the problem that a fatal error occurs when you install Microsoft ASP.NET MVC 3 or ASP.NET Web pages.

_Original product version:_ &nbsp; ASP.NET MVC 3.0  
_Original KB number:_ &nbsp; 2531566

## Symptoms

When you try to install ASP.NET MVC 3 or ASP.NET web page, a fatal error message similar to the following error appears:

> Installation failed with error code (0x80070643)

To determine the exact failure that occurred, click the log file link on the last screen of the installation process for ASP.NET Web Pages or ASP.NET MVC 3. Locate the error code that made the installation fail. This error in turn points to the MSI log, which is located in the same folder. The MSI log will report an error as following error:

> Error 1721. There is a problem with this Windows Installer package. A program required for this install to complete could not be run. Contact your support personnel or package vendor. Action: WebConfigCA_Remove, location: C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET Web Pages\v1.0\WebConfig\WebConfigCA.exe, command: -u

## Cause

This error condition can be caused by the following circumstances:

- You have a pre-release version of ASP.NET Web Pages or ASP.NET MVC 3 installed and you installed Visual Studio 2010 SP1. When you install the released version of ASP.NET Web Pages or ASP.NET MVC 3, you receive the error listed above when the installation fails.
- You have sections in the root *web.config* file marked with `allowOverride="false"`. (The root configuration file is in the `%system%\Microsoft.NET\Framework\<version>\Config` folder).
- Another process has locked the root *web.config* file. This prevents the installer from writing to it.
- The root *web.config* is read-only.

## Resolution

The solution depends on which of the possible error conditions occurred. If you have a pre-release version of ASP.NET Web Pages or ASP.NET MVC installed, try the following steps:

1. Remove the `trailing backslash` from the following registry keys:  

    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ASP.NET\4.0.30319.0\Path`  
    - `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\ASP.NET\4.0.30319.0\Path`

2. Uninstall the old version of ASP.NET Web Pages.
3. Add the trailing backslash back to the registry keys.
4. Install ASP.NET Web Pages or ASP.NET MVC 3 again.

Otherwise, try these steps:

1. Change any sections in the root *web.config* file that have `allowOverride="false"` to `allowOverride="true"`.
2. Determine what process is locking the root *web.config* file and end that process, or restart the computer you are trying to install to.
3. Make sure that the root *web.config* file is not set to read-only.
4. After making these changes, install ASP.NET Web Pages or ASP.NET MVC 3 again.
