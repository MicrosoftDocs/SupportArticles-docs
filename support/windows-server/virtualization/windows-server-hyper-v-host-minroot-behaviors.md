---
title: Windows Server 2019 Hyper-V host minroot behaviors
description: Describes behaviors that are specific to the Windows Server 2019 Hyper-V host minroot configuration, and provides links to more information about these behaviors.
ms.date: 11/10/2022
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
ms.technology: hyper-v
keywords: Hyper-V, minroot, minimum root, CPPC, P-state
---

# Windows Server 2019 Hyper-V host behaviors when running in the Minimum Root (minroot) configuration

This article describes behaviors that are specific to the Windows Server 2019 Hyper-V host minroot configuration, and provides links to more information about these behaviors.

_Applies to:_ &nbsp; Windows Server 2019

## More information

On a Windows Server Hyper-V host, the root partition (also known as the management partition) provides the management services that control all guest virtual machines, provides virtual device support for guests, and manages all device I/O for guest virtual machines. On systems that have a very high number of processors, Windows Server Hyper-V hosts run in a Minimum Root (minroot) configuration. In this configuration, the root partition is limited to a maximum of 320 processors, even if the host has more than 320 processors.

For more information about the minroot configuration, see [Hyper-V Host CPU Resource Management: Minroot](/windows-server/virtualization/hyper-v/manage/manage-hyper-v-minroot-2016#the-minimum-root-or-minroot-configuration).

When you run a Windows Server 2019 Hyper-V host in minroot configuration, you may observe the following behaviors:

- **Processor performance management**. ACPI Collaborative Processor Performance Control (CPPC) is disabled on supported systems. Instead, the system relies on ACPI Performance (P) states for performance communication between the operating system and the hardware. To check your system's configuration, see the Kernel-Processor-Power (Microsoft-Windows-Kernel-Processor-Power) Event Log. For more information about CPPC, see [Power and performance tuning: Processor performance boost mode](/windows-server/administration/performance-tuning/hardware/power/power-performance-tuning#processor-performance-boost-mode).

- **Monitoring virtual machine CPU workloads**. Task Manager on the Hyper-V host doesn't reflect the CPU usage of workloads that run within virtual machines. Instead, you can use the following counters in Performance Monitor on the Hyper-V host:

  - Logical Processor Utilization - \Hyper-V Hypervisor Logical Processor(*)\% Total Run Time
  - Virtual Processor Utilization - \Hyper-V Hypervisor Virtual Processor(*)\% Total Run Time

  For a general description of these performance counters, see [Detecting bottlenecks in a virtualized environment](/windows-server/administration/performance-tuning/role/hyper-v-server/detecting-virtualized-environment-bottlenecks). For a more detailed discussion of how to measure processor performance, see [Checklist: Measuring Performance on Hyper-V](/biztalk/technical-guides/checklist-measuring-performance-on-hyper-v). The method that the article describes applies to common workloads in virtual machines.
