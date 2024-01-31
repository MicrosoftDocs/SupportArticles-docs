---
title: Hyper-V can't start VM after upgrade
description: Address an issue in which Windows 10 Hyper-V cannot start virtual machines after a Windows 10 upgrade.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-machine-performance, csstroubleshoot
ms.subservice: hyper-v
---
# Hyper-V virtual machines don't start after you upgrade to Windows 10

This article helps fix an issue where Windows 10 Hyper-V can't start virtual machines after a Windows 10 upgrade.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4052082

## Symptoms

Consider the following scenario:

- You have a Windows 10-based computer that has the Hyper-V role installed.
- You upgrade the computer to Windows 10, version 1709, Windows 10, version 1803, Windows 10, version 1809, Windows 10, version 1903 or Windows 10, version 1909.

In this scenario, you cannot start virtual machines. Also, you receive the following error message:

> Start-VM: 'VM_NAME' failed to start. (Virtual machine IDMachineID)  
> 'VM_NAME' failed to start worker process: %%3228369022 (0xC06D007E). (Virtual machine IDMachineID)  
> At line:1 char:1  
> \+ Start-VM VM_NAME  
> \+ ~~~~~~~~~~~~~  
> \+ CategoryInfo : NotSpecified: (:) [Start-VM], VirtualizationException  
> \+ FullyQualifiedErrorId: OperationFailed,Microsoft.HyperV.PowerShell.Commands.StartVM

Additionally, you see the following entry in the System log:

> The Hyper-V Host Compute Service service terminated unexpectedly. It has done this 11 time(s).

And you see the following entry in the Application log:

> Faulting application name: vmcompute.exe, version: 10.0.16299.15, time stamp: 0x1a906fe6  
Faulting module name: vmcompute.exe, version: 10.0.16299.15, time stamp: 0x1a906fe6  
Exception code: 0xc0000005  
Fault offset: 0x000000000000474b  
Faulting process id: 0x3d78  
Faulting application start time: 0x01d34d80559647e6  
Faulting application path: C:\WINDOWS\system32\vmcompute.exe  
Faulting module path: C:\WINDOWS\system32\vmcompute.exe  
Report Id: ReportID  
Faulting package full name:  
Faulting package-relative application ID:  
Response: Not available  
Cab Id: 0  
Problem signature:  
P1: vmcompute.exe  
P2: 10.0.16299.15  
P3: 1a906fe6  
P4: vmcompute.exe  
P5: 10.0.16299.15  
P6: 1a906fe6  
P7: c0000005  
P8: 000000000000474b  
P9:  
P10:  
Attached files:  
\\?\C:\ProgramData\Microsoft\Windows\WER\Temp\WER98A7.tmp.mdmp  
\\?\C:\ProgramData\Microsoft\Windows\WER\Temp\WER9974.tmp.WERInternalMetadata.xml  
\\?\C:\ProgramData\Microsoft\Windows\WER\Temp\WER9981.tmp.csv  
\\?\C:\ProgramData\Microsoft\Windows\WER\Temp\WER99C1.tmp.txt  
\\?\C:\Windows\Temp\WER99C3.tmp.appcompat.txt  
C:\ProgramData\Microsoft\Windows\WER\ReportQueue\AppCrash_vmcompute.  exe_101d36662442e0c1debf6dea58c1dd187cc5_51a43a19_cab_332099df\memory.hdmp \  
These files may be available here:  
C:\ProgramData\Microsoft\Windows\WER\ReportQueue\AppCrash_vmcompute.  exe_101d36662442e0c1debf6dea58c1dd187cc5_51a43a19_cab_332099df  
Analysis symbol:  
Rechecking for solution: 0  
Report Id:ReportID  
Report Status: 4  
Hashed bucket: \

## Cause

This issue occurs because Windows 10 enforces a policy that configures Vmcompute.exe not to allow any non-Microsoft DLL files to be loaded.

## Resolution

Vmcompute.exe process. One possible cause of this issue is your antivirus software.

To do this, you may use some tools such as process explorer. Follow these steps:

1. Download [Process Explorer](/sysinternals/downloads/process-explorer).
2. Extract the tool, and run ProcessExp64.exe, which is for 64-bit operating system.
3. Under **View** menu, select **Show Lower Pane**, click **Lower Pane View**, and then select **DLLs**.

    :::image type="content" source="media/hyper-v-not-start-vm-after-upgrade/lower-pane-view-option.png" alt-text="Screenshot of Lower Pane View option of the View menu in Process Explorer.":::

4. Select the Vmcompute.exe process, and check for non-Microsoft DLLs in the lower pane. It is fine for some entries to be blank.

    :::image type="content" source="media/hyper-v-not-start-vm-after-upgrade/vmcompute-running-result.png" alt-text="Screenshot of Process monitor results of Vmcompute.exe process and the DLL list in the lower pane.":::
