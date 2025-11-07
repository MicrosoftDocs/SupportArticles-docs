---
title: Workarounds for Visual Studio 2026 on unsupported operating systems
description: This article describes known issues and workarounds for Visual Studio 2026 when installed on unsupported operating systems.
ms.date: 11/11/2025
ms.reviewer: pchapman, jagbal, v-shaywood
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---
# Workarounds and operating system requirements for Visual Studio 2026

_Applies to:_ &nbsp; Visual Studio 2026  

## Summary

Visual Studio 2026 is only supported on only 64-bit editions of [Windows 11](/lifecycle/products/?terms=windows%2011), [Windows 10](/lifecycle/products/?terms=windows%2010), and Windows Server 2019 and higher that are still within their support lifecycle. We don't recommend using Visual Studio on earlier or unsupported versions of Windows and Windows Server. For more information, see [full system requirements](/visualstudio/releases/2026/vs-system-requirements). To enable organizations to schedule their operating system upgrades, this article provides known issues and potential workarounds when using Visual Studio on an unsupported operating system.

> [!NOTE]
> Microsoft can't provide support or fixes for issues that arise from using Visual Studio on an unsupported operating system. For feedback on supported configurations, see [Developer Community](https://developercommunity.visualstudio.com/).

## Arm-based operating systems

Arm64 Visual Studio is supported only on Windows 11 on Arm. X64 Visual Studio isn't supported on ARM operating systems, so performance might not meet your expectations.

The following workloads and components aren't supported by Visual Studio ARM64 running on ARM64 operating systems:

- Azure development (with the exception of the Container development tools, which are supported).
- Data storage and processing (with the exception of the SQL Server Data Tools, which are supported).
- Data science and analytical applications.
- Python development.
- Mobile development with C++.
- Office/SharePoint development.
- Microsoft Blend.
- The XAML designer runs in an x86 process on ARM64.

## Windows LTSC

The Windows Long-term Servicing channel (LTSC) isn't intended for deployment on most devices in an organization. Use it only for special-purpose devices. Visual Studio isn't intended to run on [Windows Long-term Servicing channel](/windows/deployment/update/waas-overview#long-term-servicing-channel). Building apps that run on Windows LTSC is supported.

## Application Virtualization

Visual Studio doesn't support Application Virtualization (App-V) solutions. For example, Microsoft App-V for Windows or third-party app virtualization technologies.

## Azure Virtual Desktops

Running Visual Studio in a virtual machine environment requires a full Windows operating system. Visual Studio doesn't support multiple simultaneous users using the software on the same machine, including shared virtual desktop infrastructure machines or a pooled Windows Virtual Desktop host pool.

## Windows containers

Running Visual Studio Community, Professional, Enterprise, or Team Explorer editions in Windows containers isn't supported. The Build Tools edition is supported.

## 32-bit operating systems

Visual Studio doesn't install on 32-bit operating systems.

## Windows 7 and Windows Server 2008 R2

Visual Studio doesn't install on Windows 7 and Windows Server 2008 R2.

## Windows 8 and Windows Server 2012

Visual Studio doesn't install on Windows 8 and Windows Server 2012.

## Windows 8.1 and Windows Server 2012 R2

Visual Studio doesn't install on Windows 8.1 and Windows Server 2012 R2.

## Windows 10 versions 1507 and 1511

Visual Studio doesn't install on Windows 10 versions 1507 or 1511.

## Windows 10 versions 1607 through 1903

.NET 4.8.1 isn't supported on Windows 10 versions 1607 through 1903 and doesn't install.

## Windows 10 versions 1909 through 2004

.NET 4.8.1 isn't supported on Windows 10 versions 1909 through 2004 and doesn't install.
