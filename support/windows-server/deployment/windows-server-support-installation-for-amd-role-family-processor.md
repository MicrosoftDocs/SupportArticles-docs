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

- Windows Server 2019

    Windows Server 2019 supports all AMD EPYC 7000 Series processors. For AMD EPYC 7002 and EPYC 7003 Series processors, use at least the refreshed media image released early October 2019.

- Windows Server 2016

    Windows Server 2016 supports all AMD EPYC processors. The support is limited to no more than 255 logical processors. As Windows Server 2016 does not support x2APIC mode, you should disable x2APIC mode and IOMMU for AMD EPYC 7002 and 7003 series processors in the computer's basic input/output system (BIOS).  Furthermore, for dual processor servers using AMD EPYC 7002 or 7003 Series Processors SKUs that provide 64 cores each, ensure SMT is also disabled in BIOS.

- Windows Server 2012 R2

    Windows Server 2012 R2 supports all AMD EPYC Family processors. The support is limited to no more than 255 logical processors. Windows Server 2012 R2 does not support x2APIC mode, for AMD EPYC 7002 and 7003 Series processors, disable x2APIC mode and IOMMU in BIOS. Furthermore, in dual processor servers using 64 core parts, also disable SMT in BIOS.

    > [!NOTE]
    > Windows Server 20012 R2 is in [extended support cycle](/lifecycle/products/?alpha=Windows%20Server%202012%20R2). We recommend that you upgrade to the latest modern Windows Server 2019 operating system.

## AMD EPYC Processor SKU support

AMD offers a wide range of EPYC 7000 Series Processors, including the EPYC 7002 and EPYC 7003 Series Processors. You can determine specific processor model SKUs and the corresponding maximum threads in the following article:

[AMD EPYC™ 7002 Series Processors](https://www.amd.com/en/processors/epyc-7002-series)

For Windows Server OS releases prior to Windows Server 2019 and on server configurations where both processor sockets are populated, the total number of processor threads enabled should be set to less than 256 and remain as such during the OS installation and restarting process afterwards.  

## Install Windows Server on a computer that uses AMD EPYC 7002 and 7003 Series processors

> [!NOTE]
> When installing any version of Windows Server, get and use the latest installation media image from an appropriate licensing channel.  After the initial Windows installation completes, update the system to the most recent Windows Update release.

For the servers that are configured to enable 256 processor threads and are running either Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 (prior to October 2019), follow these steps:

1. Disable the SMT settings (such as the logical processors setting) in the BIOS.
2. Disable the x2APIC settings (i.e. enable the xAPIC setting) and IOMMU in the BIOS.
3. Use the OS media to install Windows Server.
4. Install the latest Windows Server updates for the respective Windows Server that you installed.
5. Restart the system and enable the SMT and the x2APIC settings in the BIOS for Windows Server 2019.

## Known UI limitations for Windows Server 2012R2/ 2016 Task Manager, WMI, or PowerShell queries to pull CPU information

### Task Manager does not display L2 and L3 cache sizes, or displays incorrect L2 and L3 cache sizes

For example, see the following figure.

:::image type="content" source="./media/windows-server-support-installation-for-amd-role-family-processor/screenshot-of-l2-l3-cache-size.jpg" alt-text="L2 and L3 cache display issue.":::

### Task Manager displays an incorrect number of sockets with more than 64 logical processors enabled

For example, for a single-CPU one-socket system, Task Manager displays two sockets. For a two-socket system, Task Manager displays four sockets.

### Task Manager displays an incorrect number of NUMA nodes

For example, for a one-socket system, Task Manager displays two NUMA nodes. For a two-socket system, Task Manager displays four NUMA nodes.
