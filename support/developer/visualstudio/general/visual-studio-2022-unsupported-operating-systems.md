---
title: Workarounds for Visual Studio 2022 on unsupported operating systems
description: This article describes known issues and workarounds for Visual Studio 2022 when installed on unsupported operating systems.
ms.date: 08/20/2021
ms.reviewer: pchapman
---
# Workarounds and operating system requirements for Visual Studio 2022

_Applies to:_ &nbsp; Visual Studio 2022  

## Summary

Visual Studio 2022 is supported only on 64-bit editions of Windows 10 version 1909 and higher and Windows Server 2016 and higher. We do not recommend using Visual Studio on earlier versions of Windows and Windows Server. See the [full system requirements](/visualstudio/releases/2022/system-requirements) for more details. To enable organizations to schedule their operating system upgrades, this page provides known issues and potential workarounds when using Visual Studio 2022 on an unsupported operating system.

> [!NOTE]
> Microsoft is unable to provide support or fixes for issues arising from using Visual Studio 2022 on an unsupported operating system. For feedback on supported configurations, see [Developer Community](https://developercommunity.visualstudio.com/).

## 32-bit operating systems

Visual Studio 2022 does not install on 32-bit operating systems.

## ARM-based operating systems

Performance of Visual Studio 2022 on an 64-bit ARM operating system may not meet expectations.

## Application Virtualization

Visual Studio doesn't support Application Virtualization (App-V) solutions. For example, Microsoft App-V for Windows or third-party app virtualization technologies.

## Azure Virtual Desktops

Running Visual Studio in a virtual machine environment requires a full Windows operating system. Visual Studio does not support multiple simultaneous users using the software on the same machine, including shared virtual desktop infrastructure machines or a pooled Windows Virtual Desktop host pool.

## Windows containers

Running Visual Studio 2022 Community, Professional, or Enterprise editions in Windows containers is not supported. The Build Tools edition is supported.

## Windows 7 and Windows Server 2008 R2

When installing Visual Studio 2022 on Windows 7 or Windows Server 2008 R2, you may experience the following issues.

- SQL development against a LocalDB, web development tools, and code maps are not available. To work around this issue, install SQL Server Express 2016. For more information on installation, see [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb).
- The Diagnostic Hub requires Edge and the Chromium browser engine. [Chromium](https://cloud.google.com/blog/products/chrome-enterprise/extending-chrome-on-windows-7-to-support-enterprise-customers) and [Edge](/deployedge/microsoft-edge-supported-operating-systems) support on Windows 7 ends January 15, 2022. After this date, the browser components will no longer receive security updates. Microsoft recommends upgrading to a supported operating system.
- Visual Studio Terminal does not work and is not supported on Windows 7 and Windows Server 2008 R2.

## Windows 8

Visual Studio 2022 does not install on Windows 8.

## Windows 8.1, Windows Server 2012, and Windows Server 2012 R2

When installing Visual Studio 2022 on Windows 8.1, Windows Server 2012, or Windows Server 2012 R2, you may experience the following issues.

- SQL development against a LocalDB, web development tools, and code maps are not available. To work around this issue, install SQL Server Express 2016. For more information on installation, see [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb).

## Windows 10, version 1507 and 1511

Visual Studio 2022 does not install on Windows 10, versions 1507 or 1511.

## Windows 10, versions 1607 through 1903

There are no known issues or workarounds on these versions of Windows 10.
