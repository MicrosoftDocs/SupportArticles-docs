---
title: MSI packages with WMI queries may fail to run
description: MSI packages that use Windows Management Instrumentation (WMI) queries might fail to run on Windows Server 2008 R2 Core. Provides a resolution.
ms.date: 05/14/2020
ms.custom: sap:Windows administration and management development
ms.reviewer: sansom, bachoang, axelr
ms.technology: windows-dev-apps-admin-management-dev
---
# MSI packages that use WMI queries may fail on Windows Server 2008 R2 Core

This article helps you resolve the problem where MSI packages that use Windows Management Instrumentation (WMI) queries might fail to run on Windows Server 2008 R2 Core.

_Original product version:_ &nbsp; Microsoft Hyper-V Server 2008 R2  
_Original KB number:_ &nbsp; 2490272

## Symptoms

On a Windows Server 2008 R2 Core server, you attempt to run scripts or an MSI package that uses WMI queries that require the `IServiceProvider` interface. The script or MSI will fail with an error message similar to the following:

> Error 1720.There is a problem with this Windows Installer package. A script required for this install to complete could not be run. Contact your support personnel or package vendor. Custom action WMIQuery script error -2147221163.

## Cause

The script or MSI package requires the `IServiceProvider` interface to run successfully, and attempts to call the interface through a proxy. However, the proxy for the `IServiceProvider` interface isn't available on Windows Server 2008 R2 Core.

## Resolution

Microsoft has confirmed that this is a problem.

You may consider converting your WMI scripts to native language code to achieve the same functionality. Using scripts in the custom action isn't recommended as most antivirus programs by default block the scripts.

## References

[Windows Installer on 64-bit Platforms](https://devblogs.microsoft.com/setup/windows-installer-on-64-bit-platforms/)
