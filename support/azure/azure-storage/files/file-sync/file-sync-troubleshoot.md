---
title: Troubleshoot Azure File Sync
description: Troubleshoot common Azure File Sync issues, including sync errors, agent installation failures, and cloud tiering problems. Learn how to resolve them quickly.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---
# Troubleshoot Azure File Sync

## Summary

Use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. This article helps you troubleshoot and resolve problems that you might encounter with your Azure File Sync deployment. It also describes how to collect important logs from the system if a deeper investigation of the problem is required. 

If you're unsure where to start, see [General troubleshooting steps](#general-troubleshooting-steps).

> [!TIP]
> Use Azure Copilot to help diagnose and fix your Azure File Sync environment. For more information, see [Manage and troubleshoot storage accounts using Azure Copilot](/azure/copilot/improve-storage-accounts#troubleshoot-and-resolve-azure-file-sync-issues).

## General troubleshooting steps

If you're experiencing problems with Azure File Sync, start by completing the following steps:

1. Check for any errors by using the Azure portal or event logs on the server. For information about how to view the health of your Azure File Sync environment by using the Azure portal or event logs, see [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring#storage-sync-service).
1. Verify the Azure File Sync service is running on the server:
    - Open the Services MMC snap-in and verify the Storage Sync Agent service (FileSyncSvc) is running. If the service isn't running and fails to start, see [Storage Sync Agent service (FileSyncSvc) fails to start](file-sync-troubleshoot-service-fails-start.md).
1. Verify the Azure File Sync filter drivers (*StorageSync.sys* and *StorageSyncGuard.sys*) are running on the server:
    - At an elevated command prompt, run `fltmc`. Verify the *StorageSync.sys* and *StorageSyncGuard.sys* file system filter drivers are listed.
1. Use the [Debug-StorageSyncServer cmdlet](#debug-storagesyncserver-cmdlet) on the server to check for common problems.

### Debug-StorageSyncServer cmdlet

The `Debug-StorageSyncServer` cmdlet diagnoses common problems on the Azure File Sync server, such as certificate misconfiguration and incorrect server time. To simplify Azure File Sync troubleshooting, it merges the functionality of some existing scripts and cmdlets (*AFSDiag.ps1*, *FileSyncErrorsReport.ps1*, and `Test-StorageSyncNetworkConnectivity`).
 
To run diagnostics on the server, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -Diagnose
```
To test the network connectivity on the server, run the following PowerShell commands:
```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -TestNetworkConnectivity
```

To identify files that fail to sync on the server, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -FileSyncErrorsReport
```

To collect logs and traces on the server, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -AFSDiag -OutputDirectory C:\output -KernelModeTraceLevel Verbose -UserModeTraceLevel Verbose
```

## Collect logs and traces on the Azure File Sync server

If your issue isn't resolved after following the steps in the troubleshooting documentation, run the AFSDiag tool and send its .zip file output to the support engineer assigned to your case for further diagnosis.

To run AFSDiag, perform the steps in the following section:

1. Open an elevated PowerShell window, and then run the following commands (press <kbd>Enter</kbd> after each command):

    > [!NOTE]
    > AFSDiag creates the output directory and a temp folder within it before collecting logs. It deletes the temp folder after execution. Specify an output location that doesn't contain data.

    ```powershell
    Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
    Debug-StorageSyncServer -AFSDiag -OutputDirectory C:\output -KernelModeTraceLevel Verbose -UserModeTraceLevel Verbose
    ```

1. Reproduce the issue. When you finish, enter *D*.
1. A .zip file that contains logs and trace files is saved to the output directory that you specified.

## See also

- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Troubleshoot Azure Files performance issues](../performance/files-troubleshoot-performance.md)

 
