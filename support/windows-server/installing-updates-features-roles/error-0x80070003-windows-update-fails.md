---
title: Error 0x80070003 at Startup after You Install a Windows Update
description: Discusses how to fix Windows Update error 0x80070003. When this issue occurs, the update can't install correctly. After the computer restarts, the installation rolls back.
manager: dcscontentpm
audience: itpro
ms.date: 02/12/2026
ai.usage: ai-assisted
ms.topic: troubleshooting
ms.reviewer: kaushika, dougking, v-appelgatet
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/windows-365target=_blank>Supported versions of Windows 365</a>
- <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---
# Error 0x80070003 at startup after you install a Windows update

This article discusses how to fix Windows Update error 0x80070003. When this issue occurs, the update can't install correctly. After the computer restarts, the installation rolls back.  

## Symptoms

When you try to install a Windows update, the installation fails, and you receive the following error message:

> Some update files are missing or have problems. We'll try to download the update again later. Error code: (0x80070003).

## Cause

This error typically means that driver files are missing or inaccessible.

## Resolution

> [!IMPORTANT]  
>
> - If the affected computer is a Windows virtual machine (VM) that can't restart correctly or that you can't access by using SSH, make sure that you can use the Azure Serial Console to access the VM.
> - Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

The most reliable way to fix this issue is to perform an in-place upgrade on the affected computer.

> [!NOTE]  
> For more information about how to upgrade VMs, see one of the following articles:
>
> - [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
> - [In-place upgrade for supported VMs running Windows in Azure (Windows client)](../../azure/virtual-machines/windows/in-place-system-upgrade.md)

If you experience error 0x80070003 during the in-place upgrade, see ["0x80070003" error and Windows upgrade fails during "Process Drivers for Migration"](../setup-upgrade-and-drivers/error-0x80070003-during-process-drivers-for-migration.md).

If the issue persists, contact Microsoft Support. In the support request, share the path or file that isn't found. For information about how to identify this information, see the next section.

## More information

To identify the path that Windows Update can't find, follow these steps:

1. On the affected computer, go to the %Windir%\logs\CBS folder (%Windir% represents the Windows directory on the computer's system drive).
1. Use a text editor to open the most recent CBS.log file, and search for a ", error" string.
1. Check the log entries that share the same timestamp as the error, and locate the path that's related to the error.

   For example, the following excerpt shows that the issue occurred during the installation of Ntprint.inf (the Windows printer driver):

   ```output
   2017-12-06 15:30:46, Info    CBS         INSTALL index: 69, phase: 1, result 3, inf: ntprint4.inf
   2017-12-06 15:30:46, Info    CBS   Doqe: Recording result: 0x80070003, for Inf: ntprint4.inf
   2017-12-06 15:30:46, Info    CBS   DriverUpdateInstallUpdates failed [HRESULT = 0x80070003 - ERROR_PATH_NOT_FOUND]
   2017-12-06 15:30:46, Info    CBS   Doqe: Failed installing driver updates [HRESULT = 0x80070003 - ERROR_PATH_NOT_FOUND]
   2017-12-06 15:30:46, Info    CBS   Perf: Doqe: Install ended.
   2017-12-06 15:30:46, Info    CBS   Failed installing driver updates [HRESULT = 0x80070003 - ERROR_PATH_NOT_FOUND]
   2017-12-06 15:30:46, Error   CBS   Startup: Failed while processing non-critical driver operations queue. [HRESULT = 0x80070003 - ERROR_PATH_NOT_FOUND]
   2017-12-06 15:30:46, Info    CBS   Startup: Rolling back KTM, because drivers failed.
   2017-12-06 15:30:46, Info    CBS   Setting ExecuteState key to: CbsExecuteStateStageDrivers | CbsExecuteStateFlagRollback | CbsExecuteStateFlagDriversFailed
   2017-12-06 15:30:46, Info    CBS   SetProgressMessage: progressMessageStage: -1, ExecuteState: CbsExecuteStateStageDrivers | CbsExecuteStateFlagRollback | CbsExecuteStateFlagDriversFailed, SubStage: 0
   2017-12-06 15:30:46, Info    CBS   Progress: UI message updated. Operation type: Update. Stage: 1 out of 1. Rollback.
   2017-12-06 15:30:46, Info    CBS   Setting original failure status: 0x80070003, last forward execute state: CbsExecuteStatePrimitives
   2017-12-06 15:30:46, Info    CBS   SetProgressMessage: progressMessageStage: -1, ExecuteState: CbsExecuteStateStageDrivers | CbsExecuteStateFlagRollback | CbsExecuteStateFlagDriversFailed, SubStage: 1
   ```
