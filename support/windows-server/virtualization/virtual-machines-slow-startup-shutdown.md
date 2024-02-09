---
title: Virtual Machines exhibits slow startup and shutdown
description: Fixes slow virtual machines (VMs) startup or shutdown performance issues.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Hyper-V virtual machines exhibit slow startup and shutdown

This article provides help to fix slow virtual machines (VMs) startup or shutdown performance issues.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2532917

## Symptoms

On Windows Server 2008 R2, when starting or shutting down guest VMs that use large amounts of memory (for example, 32 GB per VM) and running on a virtualization host with a large number of logical processors (for example, 64LPs), you may observe slow VM startup or shutdown performance.

## Cause

This is caused by the time required for the hypervisor to send IPIs to a large number of processors, and the fact that the processors have entered a deep processor idle power state (ACPI C-state). Waking the processor to deliver the IPI takes longer than delivering an IPI to a processor that does not have to exit the deep idle sleep state. The number of IPIs that must be sent during startup and shutdown increases with the amount of memory a VM is configured to use, and an IPI must be sent to each processor in the system. Thus, using deep ACPI C-states on systems with a large number of CPUs and using VMs with large amounts of memory will compound the causes and result in noticeable VM startup and shutdown delays.

## Resolution

You can disable the Advance Configuration and Power Interface (ACPI) C-states by using a BIOS firmware option on the computer. If the firmware does not include this option, a software workaround is available. You can disable the ACPI C2-state and C3-state by setting a registry key. To do this, follow these steps:

1. At a command prompt, run the following command:

    ```console
    reg add HKLM\System\CurrentControlSet\Control\Processor /v Capabilities /t REG_DWORD /d 0x0007e066
    ```

2. Restart the system.

> [!NOTE]
> The computer idle power consumption will increase significantly if the deeper ACPI C-states (processor idle sleep states) are disabled. Windows Server 2008 R2 uses these deeper C-states as a key energy-saving feature.
