---
title: Workarounds for Visual Studio 2022 on unsupported operating systems
description: This article describes known issues and workarounds for Visual Studio 2022 when installed on unsupported operating systems.
ms.date: 05/16/2023
ms.reviewer: pchapman
---
# Workarounds and operating system requirements for Visual Studio 2022

_Applies to:_ &nbsp; Visual Studio 2022  

## Summary

Visual Studio 2022 is supported only on 64-bit editions of Windows 10 version 1909 and higher and Windows Server 2016 and higher. We don't recommend using Visual Studio on earlier versions of Windows and Windows Server. For more information, see [full system requirements](/visualstudio/releases/2022/system-requirements). To enable organizations to schedule their operating system upgrades, this page provides known issues and potential workarounds when using Visual Studio 2022 on an unsupported operating system.

> [!NOTE]
> Microsoft is unable to provide support or fixes for issues arising from using Visual Studio 2022 on an unsupported operating system. For feedback on supported configurations, see [Developer Community](https://developercommunity.visualstudio.com/).

## 32-bit operating systems

Visual Studio 2022 doesn't install on 32-bit operating systems.

## Arm-based operating systems

X64 Visual Studio 2022 isn't supported on ARM operating systems, so performance may not meet expectations. Arm64 Visual Studio 2022 version 17.4 and later versions are supported only on Windows 11 on Arm.

## Application Virtualization

Visual Studio doesn't support Application Virtualization (App-V) solutions. For example, Microsoft App-V for Windows or third-party app virtualization technologies.

## Azure Virtual Desktops

Running Visual Studio in a virtual machine environment requires a full Windows operating system. Visual Studio doesn't support multiple simultaneous users using the software on the same machine, including shared virtual desktop infrastructure machines or a pooled Windows Virtual Desktop host pool.

## Windows containers

Running Visual Studio 2022 Community, Professional, or Enterprise editions in Windows containers isn't supported. The Build Tools edition is supported.

## Windows 7 and Windows Server 2008 R2

Visual Studio 2022 version 17.7 and higher doesn't install on Windows 7 and Windows Server 2008 R2. To continue using 17.6 LTSC in this unsupported configuration, see [Long-Term Servicing Channel Support](/visualstudio/productinfo/vs-servicing#long-term-servicing-channel-ltsc-support).

When installing or using Visual Studio 2022 version 17.6 or earlier on Windows 7 or Windows Server 2008 R2, you may experience the following issues.

- SQL development against a LocalDB, web development tools, and code maps aren't available. To work around this issue, install SQL Server Express 2016. For more information on installation, see [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb).
- The Diagnostic Hub requires Microsoft Edge and the Chromium browser engine. [Chromium](https://cloud.google.com/blog/products/chrome-enterprise/extending-chrome-on-windows-7-to-support-enterprise-customers) and [Microsoft Edge](/deployedge/microsoft-edge-supported-operating-systems) support on Windows 7 ends January 15, 2022. After this date, the browser components will no longer receive security updates. Microsoft recommends upgrading to a supported operating system.
- Visual Studio Terminal doesn't work and isn't supported on Windows 7 and Windows Server 2008 R2.
- .NET 4.8.1 isn't supported and doesn't install.

## Windows 8 and Windows Server 2012

Visual Studio 2022 doesn't install on Windows 8 and Windows Server 2012.

## Windows 8.1 and Windows Server 2012 R2

Visual Studio 2022 version 17.7 and higher doesn't install on Windows 8.1 and Windows Server 2012 R2. To continue using 17.6 LTSC in this unsupported configuration, see [Long-Term Servicing Channel Support](/visualstudio/productinfo/vs-servicing#long-term-servicing-channel-ltsc-support).

When installing or using Visual Studio 2022 version 17.6 or earlier on Windows 8.1 and Windows Server 2012 R2, you may experience the following issues.

- SQL development against a LocalDB, web development tools, and code maps aren't available. To work around this issue, install SQL Server Express 2016. For more information on installation, see [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb).
- .NET 4.8.1 isn't supported and doesn't install.

## Windows 10, version 1507 and 1511

Visual Studio 2022 doesn't install on Windows 10 versions 1507 or 1511.

## Windows 10, versions 1607 through 1903

- .NET 4.8.1 isn't supported and doesn't install.

## Windows 10, versions 1909 through 2004

- .NET 4.8.1 isn't supported and doesn't install.
