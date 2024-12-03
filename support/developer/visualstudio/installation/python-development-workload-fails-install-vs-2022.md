---
title: Python Development Workload Fails to Install in Visual Studio 2022
description: Helps resolve an error where the Python development workload fails to install in Visual Studio 2022.
ms.date: 11/22/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The Python development workload fails to install in Visual Studio 2022

## Symptoms

The Python development workload fails to install in Visual Studio 2022. In addition, you see the following error message:

## Cause

The Visual Studio Installer can't download the **python-3.9.13-amd64.exe** file from the URL `https://go.microsoft.com/fwlink/?linkid=2222466`.

## Resolution

To resolve the issue, you need to ensure that the necessary domains and servers from which files are downloaded are whitelisted or added to the allowlist.

By whitelisting the necessary domain URLs, you enable the Visual Studio Installer to download the required files and successfully install the Python development workload. For more information and guidance on installing Visual Studio behind a firewall or proxy server, see [Install and use Visual Studio and Azure Services behind a firewall or proxy server](/visualstudio/install/install-and-use-visual-studio-behind-a-firewall-or-proxy-server).

Once you complete the allowlisting process, you can install the Python development workload in Visual Studio 2022 without encountering any download failures.
