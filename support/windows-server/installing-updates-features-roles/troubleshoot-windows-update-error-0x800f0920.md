---
title: Troubleshoot Windows Update Error 0x800f0920
description: Learn how to resolve Windows Update error 0x800f0920, caused by a hang in the Trusted Installer service.
manager: dcscontentpm
audience: itpro
ms.date: 11/11/2025
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x800F (CBS E)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x800f0920

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Error code 0x800f0920 indicates a hang was detected during the Windows Update installation process. This issue arises when the Trusted Installer service doesn't complete the installation within the default timeout period of 15 minutes.

## Prerequisites

For virtual machines (VMs) running Windows in Azure, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check the `CBS.log` for entries similar to the following ones:

```output
2023-09-17 22:48:16, Info                  CBS    Startup: SC autostart event signaled
2023-09-17 22:48:16, Info                  CBS    Clearing HangDetect value
2023-09-17 22:48:16, Error                 CBS    Startup: A possible hang was detected on the last boot. [HRESULT = 0x800f0920 - CBS_E_HANG_DETECTED]
2023-09-17 22:48:16, Info                  CBS    Current global progress. Current: 58, Limit: 105, ExecuteState: CbsExecuteStateResolvePending
2023-09-17 22:48:16, Info                  CBS    Previous global progress. Current: 58, Limit: 105, ExecuteState: CbsExecuteStateResolvePending
2023-09-17 22:48:16, Error                 CBS    Startup: No progress detected while needing to process the advanced operation queue, rolling back and cancelling the transaction. [HRESULT = 0x80004005 - E_FAIL]
2023-09-17 22:48:16, Info                  CBS    Setting ExecuteState key to: CbsExecuteStateInitiateRollback | CbsExecuteStateFlagAdvancedInstallersFailed
2023-09-17 22:48:16, Info                  CBS    SetProgressMessage: progressMessageStage: -1, ExecuteState: CbsExecuteStateInitiateRollback | CbsExecuteStateFlagAdvancedInstallersFailed, SubStage: 0
2023-09-17 22:48:16, Info                  CBS    Progress: UI message updated. Operation type: Update. Stage: 1 out of 1. Rollback.
2023-09-17 22:48:16, Info                  CBS    Setting original failure status: 0x800f0920, last forward execute state: CbsExecuteStateResolvePending
```

## Root cause

The error occurs because the Trusted Installer service doesn't finish the installation process within the default timeout period of 15 minutes. This can lead to a rollback and cancellation of the transaction.

## Resolution

For Windows-based computers, perform an [in-place upgrade](/windows-server/get-started/perform-in-place-upgrade#perform-the-in-place-upgrade). 

For VMs running Windows in Azure, see [in-place upgrade on the Windows virtual machine](/azure/virtual-machines/windows-in-place-upgrade).

