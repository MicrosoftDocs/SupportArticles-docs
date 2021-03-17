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
# Windows Server support and installation instructions for the AMD EPYC 7000 Series server processors

This article introduces the Windows Server operating system (OS) installation instructions and support statements for AMD EPYC series server processors. Additionally, this article describes several known limitations to the support for these processors.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4514607

## Windows Server support

This section provides Windows Server support with respect to total number of logical processors.

- Windows Server 2019 and Windows Server 2016  

  Windows Server 2019 and Windows Server 2016 support AMD EPYC 7*xx*2-series CPUs. The following list identifies the minimum build versions that this support requires:

  - Windows Server 2019 servers that have X2APIC enabled: October 2019 Full Media Refresh (FMR) image build version 17763.737.
  - Windows Server 2019 servers that have X2APIC disabled: November 2018 image build version 17763.107.
  - Windows Server 2016: February 2018 FMR image build version 14393.1884.  
  
  Windows FMR images that meet the minimum build version requirements are available through the system hardware vendor or appropriate licensing channels.

- Windows Server 2012 R2

    Windows Server 2012 R2 supports all AMD EPYC processors. The support is limited to a maximum of 255 logical processors. Windows Server 2012 R2 doesn’t support the x2APIC mode. For AMD EPYC 7002 and 7003 Series processors, disable the x2APIC mode and IOMMU in the BIOS. For dual processor servers using 64 core, make sure SMT is also disabled in the BIOS.

    > [!NOTE]
    > Windows Server 20012 R2 is in [extended support cycle](/lifecycle/products/?alpha=Windows%20Server%202012%20R2). We recommend that you upgrade to the latest modern Windows Server 2019 operating system.

## AMD EPYC Processor SKU support

AMD offers a wide range of EPYC 7000 Series Processors, including the EPYC 7002 and EPYC 7003 Series Processors. You can determine the specific processor model SKUs and the corresponding maximum threads in the following articles:

- [AMD EPYC™ 7002 Series Processors](https://www.amd.com/en/processors/epyc-7002-series)
- [AMD EPYC™ 7003 Series Processors](https://www.amd.com/en/processors/epyc-7003-series)

For Windows Server OS releases prior to Windows Server 2019 and on server configurations where both processor sockets are populated, the total number of processor threads enabled should be set to less than 256 and remain so during the OS installation and restart process.  

## Install Windows Server on a computer that uses AMD EPYC 7002 and 7003 Series processors

> [!NOTE]
> When installing any version of Windows Server, use the latest installation media image from an appropriate licensing channel.  After the initial Windows installation is completed, update the system to the most recent Windows Update release.

For servers configured to enable 256 processor threads and that are running either Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 (prior to October 2019), follow these steps:

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

For example, for a single-CPU one-socket system, Task Manager displays two sockets. For a two-socket system, Task Manager displays four sockets.

### Task Manager displays an incorrect number of NUMA nodes with more than 64 logical processors enabled

For example, for a one-socket system, Task Manager displays two NUMA nodes. For a two-socket system, Task Manager displays four NUMA nodes.
