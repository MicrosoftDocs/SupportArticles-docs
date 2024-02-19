---
title: Windows Server support and installation instructions for AMD EPYC 7000 Series server processors
description: Lists the AMD EPYC 7000 Series server processors that are supported by Windows Server 2019, Windows Server 2016, and Windows Server 2012 R2. Additionally lists support caveats and installation instructions.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, yuvraja
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Windows Server support and installation instructions for the AMD EPYC 7000 Series server processors

This article introduces the Windows Server operating system (OS) installation instructions and support statements for AMD EPYC series server processors. Additionally, this article describes several known limitations to the support for these processors.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4514607

## Windows Server support

This section provides Windows Server support with respect to total number of logical processors.

- Windows Server 2019

    Windows Server 2019 supports all AMD EPYC 7000 Series processors. For AMD EPYC 7002 and EPYC 7003 Series processors, use at least the refreshed media image released early October 2019.

- Windows Server 2016  

    Windows Server 2016 supports all AMD EPYC processors. The support is limited to a maximum of 255 logical processors. Windows Server 2016 doesn't support the x2APIC mode. For AMD EPYC 7002 and 7003 series processors, disable the x2APIC mode and IOMMU in the computer's basic input/output system (BIOS). For dual processor servers using 64 core AMD EPYC 7002 or 64 core 7003 Series Processors SKUs, make sure SMT is also disabled in the BIOS.

- Windows Server 2012 R2

    Windows Server 2012 R2 supports all AMD EPYC processors. The support is limited to a maximum of 255 logical processors. Windows Server 2012 R2 doesn't support the x2APIC mode. For AMD EPYC 7002 and 7003 Series processors, disable the x2APIC mode and IOMMU in the BIOS. For dual processor servers using 64 core, make sure SMT is also disabled in the BIOS.

    > [!NOTE]
    > Windows Server 2012 R2 is in [extended support cycle](/lifecycle/products/?alpha=Windows%20Server%202012%20R2). We recommend that you upgrade to the latest modern Windows Server 2019 operating system.

## AMD EPYC Processor SKU support

AMD offers a wide range of EPYC 7000 Series Processors, including the EPYC 7002 and EPYC 7003 Series Processors. You can determine the specific processor model SKUs and the corresponding maximum threads in the following articles:

- [AMD EPYC&trade; 7002 Series Processors](https://www.amd.com/en/processors/epyc-7002-series)
- [AMD EPYC&trade; 7003 Series Processors](https://www.amd.com/en/processors/epyc-7003-series)

For Windows Server OS releases prior to Windows Server 2019 and on server configurations where both processor sockets are populated, the total number of processor threads enabled should be set to less than 256 and remain so during the OS installation and restart process.

## Install Windows Server on a computer that uses AMD EPYC 7002 and 7003 Series processors

> [!NOTE]
> When installing any version of Windows Server, use the latest installation media image from an appropriate licensing channel. After the initial Windows installation is completed, update the system to the most recent Windows Update release.

For servers configured to enable 256 processor threads and that are running either Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 (prior to October 2019), follow these steps:

1. Disable the SMT settings (such as the logical processors setting) in the BIOS.
2. Disable the x2APIC settings and IOMMU in the BIOS.
3. Use the OS media to install Windows Server.
4. Install the latest Windows Server updates.
5. Restart the system and enable the SMT, x2APIC and IOMMU settings for Windows Server 2019 in the BIOS.

## Known issue with Windows Recovery Environment (WinRE) for Windows Server 2019

Attempting to boot into WinRE for Windows Server 2019 may result in a blue screen error 0x5C HAL_INITIALIZATION_FAILED. The WinRE image must be updated to support configurations with 256 or more processors and the x2APIC mode enabled. To enable this support, apply the latest cumulative update for Windows Server 2019 to the WinRE image. For more information, see [Add an update package to Windows RE](/windows-hardware/manufacture/desktop/add-update-to-winre).

## Known UI limitations for Windows Server 2012 R2/2016/2019 Task Manager, WMI, or PowerShell queries to pull CPU information

> [!NOTE]
> The following UI limitations are not limited to the AMD EPYC 7000 series and may occur on all AMD EPYC platforms.

### Task Manager does not display L2 and L3 cache sizes, or displays incorrect L2 and L3 cache sizes

For example, see the following figure.

:::image type="content" source="media/windows-server-support-installation-for-amd-role-family-processor/screenshot-of-l2-l3-cache-size.png" alt-text="L2 and L3 cache sizes display incorrect values.":::

### Task Manager displays an incorrect number of sockets with more than 64 logical processors enabled

For example, for a single-CPU one-socket system, **Task Manager** displays two sockets. For a two-socket system, **Task Manager** displays four sockets.

### Task Manager displays an incorrect number of NUMA nodes with more than 64 logical processors enabled

For example, for a one-socket system, **Task Manager** displays two NUMA nodes. For a two-socket system, **Task Manager** displays four NUMA nodes.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
