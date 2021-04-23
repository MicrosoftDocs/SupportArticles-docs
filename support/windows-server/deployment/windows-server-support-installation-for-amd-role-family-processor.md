---
title: Windows Server support and installation instructions for AMD EPYC 7000 Series server processors
description: Lists the AMD EPYC 7000 Series server processors that are supported by Windows Server 2019, Windows Server 2016, and Windows Server 2012 R2. Additionally lists support caveats and installation instructions.
ms.date: 03/08/2021
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Setup
ms.technology: windows-server-deployment
---
# Windows Server support and installation instructions for AMD Rome processors

This article introduces the Windows Server operating system (OS) installation instructions and support statements for the AMD EPYC 7*xx*2 (AMD Rome) family of processors. Additionally, this article describes several known limitations to the support for these processors.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4514607

## Windows Server support

This section provides information about Windows Server support with respect to total number of logical processors.

- Windows Server 2019

    Windows Server 2019 supports AMD EPYC 7*xx*2-series CPUs. Use the Windows Server 2019 refreshed media image that was released in early October 2019. You can obtain this image from the appropriate licensing channel, as applicable.

- Windows Server 2016  

    Windows Server 2016 supports AMD EPYC 7*xx*2-series CPUs. The support is limited to no more than 255 logical processors. Windows Server 2016 does not support X2APIC mode. You should disable this mode in the computer BIOS. Use the latest refreshed media image (minimum version: FMR February 2018). You can obtain this image from the appropriate licensing channel, as applicable."

- Windows Server 2012 R2

    > [!NOTE]
    > Windows Server 20012 R2 is in [extended support](/lifecycle/products/?alpha=Windows%20Server%202012%20R2). We recommend that you upgrade to the latest modern Windows Server 2019 operating system.

## AMD processor SKU support

The following table lists support for each AMD processor SKU and Windows Server OS version.

|AMD EPYC 7*xx*2 (AMD Rome)|Windows Server 2019|Windows Server 2016|Windows Server 2012 R2|
|---|---|---|---|
|AMD EPYC 7742 64C|Supported|Supported: Requires that you disable AMD simultaneous multithreading (SMT).|Supported: Requires that you disable AMD SMT.|
|AMD EPYC 7702 64C|Supported|Supported: Requires that you disable AMD SMT.|Supported: Requires that you disable AMD SMT.|
|AMD EPYC 7702P 64C|Supported|Supported: Requires that you disable AMD SMT.|Supported: Requires that you disable AMD SMT.|
|AMD EPYC 7552 48C|Supported|Supported|Supported|
|AMD EPYC 7502 32C|Supported|Supported|Supported|
|AMD EPYC 7502P 32C|Supported|Supported|Supported|
|AMD EPYC 7402 24C|Supported|Supported|Supported|
|AMD EPYC 7402P 24C|Supported|Supported|Supported|
|AMD EPYC 7352 24C|Supported|Supported|Supported|
|AMD EPYC 7302 16C|Supported|Supported|Supported|
|AMD EPYC 7302P 16C|Supported|Supported|Supported|
|AMD EPYC 7262 8C|Supported|Supported|Supported|
|||||

## Install Windows Server on a computer that uses AMD Rome

To install Windows Server on a computer that uses AMD EPYC 7*xx*2 (AMD Rome) processors, follow these steps:

1. In the computer BIOS, disable the SMT settings (such as the logical processors setting).
2. In the computer BIOS, disable the X2APIC setting.
3. Use the OS media to install Windows Server.
4. Install the latest Windows Server updates for the respective Windows Server OS that you installed.

Windows Server 2019 and Windows Server 2016 support AMD EPYC 7*xx*2-series CPUs. The following list identifies the minimum build versions that this support requires:

- Windows Server 2019 servers that have X2APIC enabled: October 2019 Full Media Refresh (FMR) image build version 17763.737.
- Windows Server 2019 servers that have X2APIC disabled: November 2018 image build version 17763.107.

> [!NOTE]
> When you install any version of Windows Server, use the latest installation media image from an appropriate licensing channel. After the initial Windows installation is completed, update the system to the most recent Windows Update release.

For servers that are configured to enable 256 processor threads and that are running either Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 (prior to October 2019), follow these steps:

1. Disable the SMT settings (such as the logical processors setting) in the BIOS.
2. Disable the x2APIC settings and IOMMU in the BIOS.
3. Use the OS media to install Windows Server.
4. Install the latest Windows Server updates.
5. Restart the system and enable the SMT, x2APIC and IOMMU settings for Windows Server 2019 in the BIOS.

## Known UI limitations for Windows Server 2012R2/2016 Task Manager, WMI, or PowerShell queries to pull CPU information

### Task Manager does not display L2 and L3 cache sizes, or displays incorrect L2 and L3 cache sizes

For example, see the following figure.

:::image type="content" source="./media/windows-server-support-installation-for-amd-role-family-processor/screenshot-of-l2-l3-cache-size.jpg" alt-text="L2 and L3 cache display issue.":::

### Task Manager displays an incorrect number of sockets with more than 64 logical processors enabled

- Task Manager displays an incorrect number of Numa nodes.

### Task Manager displays an incorrect number of NUMA nodes with more than 64 logical processors enabled

For example, for a one-socket system, Task Manager displays two NUMA nodes. For a two-socket system, Task Manager displays four NUMA nodes.
