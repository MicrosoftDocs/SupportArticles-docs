---
title: Troubleshoot Windows Update Error 0x8024001E
description: Learn how to fix Windows Update error 0x8024001E on Windows Client computers or Azure Windows VMs.
ms.date: 02/12/2026
manager: dcscontentpm
ai-usage: ai-generated
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, dougking, v-appelgatet
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - install errors starting with 0x8024 (wu e setup)
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---

# Troubleshoot Windows Update error 0x8024001E

This article describes how to troubleshoot Windows Update error code 0x8024001E. Because several different issues can cause this error, this article discusses how to identify some of the specific causes.

## Symptoms

You install a Windows update, but the installation fails, and you see error code 0x8024001E reported. You might also experience other symptoms. Review the following list of symptoms to learn whether they apply to your issue. Any symptoms that do apply might provide insight into the cause of your specific issue.

- [Symptom 1: Security update doesn't install](#symptom-1-security-update-doesnt-install)
- [Symptom 2: An unexpected system restart disrupts installation](#symptom-2-an-unexpected-system-restart-disrupts-installation)
- [Symptom 3: A scheduled task disrupts installation](#symptom-3-a-scheduled-task-disrupts-installation)
- [Symptom 4: Windows Server Update Service (WSUS) issue, and secondary error code 0x800f0821](#symptom-4-windows-server-update-service-wsus-issue-and-secondary-error-code-0x800f0821)

### Symptom 1: Security update doesn't install

If the update that you try to install is a security update, check the UpdateSessionOrchestrator logs that are located in C:\ProgramData\USOShared\Logs\System. Look for entries that resemble the following example:

```output
*Error Originate:DownloadHandler::UpdateDownloadResult:1893* -> [hr] : -2145124322 (0x8024001E);
*Download finished* -> [Results] : {85604fae-a5c5-4f6d-9012-3d86be1bccce}:2021-01 Update for Windows Server 2016 for x64-based Systems (KB4589210):hr=0x8024001e;
*Error Originate:DownloadHandler::UpdateDownloadResult:1893* -> [hr] : -2145124322 (0x8024001E);
*Download finished* -> [Results] : {abd74871-ea87-49aa-b3fe-866aca9b23f2}:2021-03 Cumulative Update for Windows Server 2016 for x64-based Systems (KB5000803):hr=0x8024001e;
```

### Symptom 2: An unexpected system restart disrupts installation

If the computer or virtual machine (VM) restarts before the update finishes installing, the update might not install correctly. To learn whether this issue occurred, check the CBS logs. Look for entries that resemble the following example:

```output
Info CBS Trusted Installer is shutting down because: SHUTDOWN_REASON_AUTOSTOP
Info CBS TiWorker signaled for shutdown, going to exit.
Info CBS CbsCoreFinalize: ExecutionEngineFinalize
Info CBS Execution Engine Finalize
```

### Symptom 3: A scheduled task disrupts installation

To learn whether this issue occurred, use Event Viewer to review the Microsoft-Windows-TaskScheduler/Operational event log. Look for sequences of events that resemble the following example:

```output
Information 104 Microsoft-Windows-TaskSchedu1er Task registration NT AUTHORITY\SYSTEM User "NT AUTHORITY\SYSTEM" updated Task Scheduler task "\Microsoft\Windows\WindowsUpdate\Schedu1ed start"
Information 201 Microsoft-Windows-TaskSchedu1er Action completed NT AUTHORITY\SYSTEM Task Scheduler successfully completed task "\Check WSUS Reg" instance "{EE5B1773-676A-4E12-9ee6-12727FA2CAD9}" action "C:\windows\system32\cmd.exe" with return code 0.
Information 102 Microsoft-Windows-TaskSchedu1er Task completed NT AUTHORITY\SYSTEM Task Scheduler successfully finished "{EE5B1773-676A-4E12-90Ø6-12727FA2CAD9}" instance of the "\Check WSUS Reg" task for user "NT AUTHORITY\SYSTEM".
```

Use this event information to identify which scheduled task interfered with the update installation.

### Symptom 4: Windows Server Update Service (WSUS) issue, and secondary error code 0x800f0821

In WSUS environments, a WSUS issue might prevent an update from installing. It might also generate error code 0x8024001E plus secondary error code 0x800f0821. To learn whether this issue occurred, use Event Viewer to review the System event logs. Look for sequences of events that resemble the following example:

```output
Error Installation Failure: Windows failed to install the following update with error 0x8024001E: 2023-11 Cumulative Update for Windows
Information The Windows Update service entered the stopped state.
Information The Windows Update service entered the running state.
```

## Cause

The following conditions can cause error code 0x8024001E to occur:

- The update source files on the computer are corrupted or incomplete.
- The computer doesn't have enough available disk space to install the update.
- Intermittent connectivity disrupts the update process.
- Server maintenance, scheduled tasks, or other server outages disrupt the update process.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

Follow these steps:

1. If you identify a scheduled task that disrupts the update, disable that scheduled task.
1. If you're using WSUS, make sure that WSUS is working correctly. For more information about how to manage WSUS, see [Windows Server Update Services best practices](../../mem/configmgr/update-management/windows-server-update-services-best-practices.md).
1. Make sure that drive C has at least 10 GB of free space.
1. Rename the software distribution folder. Open a Windows Command Prompt window, and then run the following set of commands (in sequence):

   ```console
   net stop wuauserv
   rename c:\windows\SoftwareDistribution softwaredistribution.old
   net start wuauserv
   ```

1. Restart the following services:

   - Windows Update service (WUAServ) (if you didn't already restart it)
   - Update Orchestrator Service for Windows Update service (UsoSvc)
   - Background Intelligent Transfer Service (BITS)

1. Try again to install the update. Use one of the following methods:

   - Open **Windows Settings**, and select **Windows Update**. Follow the prompts to check for and install updates.
   - Manually download updates from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/). At the command prompt, run the following set of commands (in sequence):

     ```console
     expand -f:*x64.cab c:\temp\filename.msu c:\temp
     dism /online /add-package /packagepath:c:\temp\Windows10-KB***-x64.cab
     ```

   > [!IMPORTANT]  
   > Make sure that the computer or VM doesn't restart during the update process unless the update process requires a restart.

If the issue persists, see [Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios](../windows-tss/collect-data-analyze-troubleshoot-windows-servicing-scenarios.md), and then contact Microsoft Support.
