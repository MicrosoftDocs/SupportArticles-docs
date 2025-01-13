---
title: Support and installation instructions for AMD EPYC 9004 and 9005 series server processors
description: Introduces the Windows Server operating system support statements and installation instructions for AMD EPYC 9004 and AMD EPYC 9005 series server processors.
ms.topic: troubleshooting
ms.date: 01/13/2025
ms.reviewer: kaushika, jaysenb, scottmca
ms.custom: sap:Virtualization and Hyper-V\Installation and configuration of Hyper-V, csstroubleshoot
---
# Windows Server support and installation instructions for the AMD EPYC 9004 and AMD EPYC 9005 series server processors

This article introduces the Windows Server operating system support statements and installation instructions for systems with greater than 64 cores per CPU socket.

_Applies to:_ &nbsp; Windows Server 2025, Windows Server 2022, Windows Server 2019

## Windows Server support

The following Windows Server releases are supported on AMD EPYC 9004 and AMD EPYC 9005 series processors.

* Windows Server 2019
* Windows Server 2022
* Windows Server 2025

## AMD EPYC processor Ordering Part Number (OPN) support

AMD offers a wide range of AMD EPYC 9004 series processors. You can determine the specific processor model in [AMD EPYC 9004 series processors](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series.html).

AMD offers a wide range of AMD EPYC 9005 series processors. You can determine the specific processor model in [AMD EPYC 9005 series processors](https://www.amd.com/en/products/processors/server/epyc/9005-series.html).

## Install Windows Server on a computer that uses AMD EPYC 9004 or AMD EPYC 9005 series processors

When installing Windows Server operating system (OS), use the latest installation media image from an appropriate licensing channel. After the initial installation is completed, update the system to the latest Windows Update release.

To install Windows Server on systems that use AMD EPYC 9004 or 9005 parts that have more than 64 cores, the following OS media images are required:

* Windows Server 2019: Build 17763.3532 (2022 October) or later
* Windows Server 2022: Build 20348.859 (2022 July) or later

To use earlier OS media releases prior to the preceding releases, use one of the following options:

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

## Known issues and limitations

On systems running Windows Server 2019 with many logical processors and the Hyper-V virtualization feature enabled, the operating system runs a Hyper-V Minroot configuration. The following issues and limitations may be observed on AMD EPYC 9004 or 9005 series-based systems with more than 320 logical processors:

* Task Manager in the root partition doesn't show CPU utilization accounting for virtual machines' workloads.
* The operating system doesn't use Collaborative Processor Performance Control (CPPC) for processor power management despite CPPC being set to enable in BIOS.
* The root partition may not utilize all maximum 320 logical processors available when running a Minroot configuration.

In addition to the preceding observations, the following limitation applies to AMD EPYC 9005 series-based systems with a total number of logical processors greater than 512:

The root partition will use a maximum of 512 logical processors.

For more information, see [Windows Server 2019 Hyper-V host behavior running in the Minroot configuration](windows-server-hyper-v-host-minroot-behaviors.md) and [Plan for Hyper-V scalability in Windows Server](/windows-server/virtualization/hyper-v/plan/plan-hyper-v-scalability-in-windows-server?pivots=windows-server-2019).

On systems running Windows Server 2022 with the Hyper-V virtualization feature enabled, the following limitation may be observed on AMD EPYC 9005 series-based systems with greater than 256 logical processors per NUMA node:

The root partition will only enumerate the first 256 logical processors. This limitation is addressed in [KB5044281 (OS Build 20348.2762)](https://support.microsoft.com/topic/october-8-2024-kb5044281-os-build-20348-2762-e063059c-9122-4324-86e8-4f6f3383a20a).

Attempting to boot to the Windows Server 2019 Recovery Environment (WinRE) may result in a blue screen error 0x5C HAL_INITIALIZATION_FAILED. The WinRE image must be updated to support configurations with greater than 64 cores per socket. To enable this support, apply the latest cumulative update for Server 2019 to the WinRE image. See [Add an update package to Windows RE](/windows-hardware/manufacture/desktop/add-update-to-winre?view=windows-11&preserve-view=true) for instructions.

On systems running Windows Server 2025 with the Hyper-V hypervisor present, the memory dump creation process may fail. This problem may occur on all AMD EPYC series server processors. Download and install the Windows Server 2025 Latest Cumulative Update package to resolve this problem. For more information, see [Windows Server 2025 update history](https://support.microsoft.com/topic/windows-server-2025-update-history-10f58da7-e57b-4a9d-9c16-9f1dcd72d7d7). This was first addressed in [KB5044284 (OS Build 26100.2033)](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-db79fdac-94b8-4f2c-9273-bf40c6f8273d).
