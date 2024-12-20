---
title: Python Development Workload Fails to Install in Visual Studio 2022
description: Helps resolve an issue where the Python development workload fails to install in Visual Studio 2022.
ms.date: 12/09/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The Python development workload fails to install in Visual Studio 2022

## Symptoms

The Python development workload fails to install in Visual Studio 2022. In addition, you see the following error message:

```output
Package 'CPython39.Exe.x64,version=3.9.13, chip=x64' failed to download from 'https://go.microsoft.com/fwlink/?linkid=2222466'.
Search URL
https://aka.ms/VSSetupErrorReports?q=PackageId=CPython39.Exe.x64; PackageAction=DownloadPackage; ReturnCode=0x80096004
Details
WebClient download failed: Authenticode verification returned 0x800b0003 for path: python-3.9.13-amd64.exe.
Bits download failed: Timeout reached for job VsBitsDownloadJob - -2114796084 whilst in state BG_JOB_STATE_CONNECTING WinInet download failed: Authenticode verification returned 0x800b0003 for path: python-3.9.13-amd64.exe.
Impacted workloads
Python development (Microsoft.VisualStudio.Workload.Python,version=17.5.33306.270)
Impacted components
Python 3 64-bit (3.9.13) (Component.CPython39.x64,version=3.9.13)
```

## Cause

The Visual Studio Installer can't download the **python-3.9.13-amd64.exe** file from the URL `https://go.microsoft.com/fwlink/?linkid=2222466`.

## Resolution

To resolve the issue, ensure that the necessary domains and servers from which files are downloaded are added to the allowlist.

By adding the necessary domain URLs to the allowlist, you enable the Visual Studio Installer to download the required files and successfully install the Python development workload. For more information and guidance on installing Visual Studio behind a firewall or proxy server, see [Install and use Visual Studio and Azure Services behind a firewall or proxy server](/visualstudio/install/install-and-use-visual-studio-behind-a-firewall-or-proxy-server).

Once you complete the allowlisting process, you can [install the Python development workload](/visualstudio/python/installing-python-support-in-visual-studio?view=vs-2022#download-and-install-the-python-workload) in Visual Studio 2022 without encountering any download failures.
