---
title: Support and installation instructions for AMD EPYC 9004 Series server processors
description: Introduce the Windows Server operating system support statements and installation instructions for AMD EPYC 9004 series server processors.
ms.topic: troubleshooting
ms.date: 12/26/2023
ms.custom: sap:Virtualization and Hyper-V\Installation and configuration of Hyper-V, csstroubleshoot
---
# Windows Server support and installation instructions for the AMD EPYC 9004 Series server processors

This article introduces the Windows Server operating system support statements and installation instructions for AMD EPYC 9004 series server processors.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019

## Windows Server support

The following Windows Server releases are supported for AMD EPYC 9004 Series processors.

* Windows Server 2019
* Windows Server 2022

## AMD EPYC Processor SKU support

AMD offers a wide range of AMD EPYC 9004 Series Processors. You can determine the specific processor model SKUs in [AMD EPYC 9004 Series Processors](https://www.amd.com/en/processors/epyc-9004-series).

## Install Windows Server on a computer that uses AMD EPYC 9004 Series processors

When installing Windows Server operating system (OS), use the latest installation media image from an appropriate licensing channel. After the initial installation is completed, update the system to the latest Windows Update release.

To install Windows Server on systems that use AMD EPYC 96x4 SKUs that have more than 64 cores, the following OS media images are required:

* Windows Server 2019: Build 17763.3532 (2022 October) or later
* Windows Server 2022: Build 20348.859 (2022 July) or later

To use earlier OS media releases prior to aforementioned releases, use one of the following options:

* Option 1: Change the number of enabled CCD setting in BIOS
  
  1. Configure the number of CCD enabled per processor setting to a maximum of 8 in BIOS.
  2. Perform OS installation.
  3. After initial OS installation is completed, run Windows Update to update the system to the latest Cumulative Update release.
  4. Set the CCD setting to back to the original value in BIOS

  > [!NOTE]
  > Availability of this BIOS setting depends on your system. Consult BIOS documentation provided by OEM for your system.

* Option 2: Update OS Installation Media Images

  1. Download Windows Server Latest Cumulative Update packages and prerequisite packages. For details, see [Microsoft Windows Server 2019 Update Site](https://support.microsoft.com/topic/windows-10-and-windows-server-2019-update-history-725fc2e1-4443-6831-a5ca-51ff5cbcb059) and [Microsoft Windows Server 2022 Update Site](https://support.microsoft.com/topic/windows-server-2022-update-history-e1caa597-00c5-4ab9-9f3e-8212fe80b2ee).
  2. Add prerequisite packages followed by the Latest Cumulative Update package to the boot.wim and install.wim image files in the OS installation media. For details, see [Add Packages Offline using DISM](/windows-hardware/manufacture/desktop/add-or-remove-packages-offline-using-dism).

## Known Issues and Limitations

In systems running Windows Server 2019 with the Hyper-V virtualization feature enabled, when number of logical processors is greater than 320, the operating system runs Hyper-V Minroot configuration. In such systems, the followings are issues and limitations that may be observed in AMD EPYC 9004 system-based systems have more than total of 320 logical processors.

* Task Manager in the root partition does not show CPU utilization accounting for virtual machines' workloads.
* The operating system does not use Collaborative Processor Performance Control (CPPC) for processor power management despite CPPC being set to enable in BIOS.
* The root partition may not utilize all maximum 320 logical processors available when running Minroot configuration.

For more information, see [Windows Server 2019 Hyper-V host behavior running in the Minroot configuration](windows-server-hyper-v-host-minroot-behaviors.md).

Attempting to boot to the Windows Server 2019 Recovery Environment (WinRE) may result in a blue screen error 0x5C HAL_INITIALIZATION_FAILED. The WinRE image must be updated to support configurations with greater than 64 cores per socket. To enable this support, apply the latest cumulative update for Server 2019 to the WinRE image. See [Add an update package to Windows RE](/windows-hardware/manufacture/desktop/add-update-to-winre?view=windows-11&preserve-view=true) for instructions.
