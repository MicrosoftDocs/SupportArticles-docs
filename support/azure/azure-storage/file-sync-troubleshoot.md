---
title: Troubleshoot Azure File Sync
description: Troubleshoot common issues that you might encounter with Azure File Sync, which you can use to transform Windows Server into a quick cache of your Azure file share.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 10/13/2023
ms.author: kendownie
---
# Troubleshoot Azure File Sync

You can use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. This article is designed to help you troubleshoot and resolve issues that you might encounter with your Azure File Sync deployment. We also describe how to collect important logs from the system if a deeper investigation of the issue is required. 

## Common troubleshooting documentation

Based on the issue you're experiencing, review the appropriate troubleshooting documentation:

|Issues|Troubleshooting documentation|
|---|---|
|Agent installation or server registration issues|[Troubleshoot Azure File Sync agent installation and server registration](file-sync-troubleshoot-installation.md)|
|Cloud endpoint or server endpoint creation issues, or the registered server is offline|[Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)|
|Server endpoint has an error status, or files fail to sync|[Troubleshoot Azure File Sync sync health and errors](file-sync-troubleshoot-sync-errors.md)|
|Files fail to tier or recall|[Troubleshoot Azure File Sync cloud tiering](file-sync-troubleshoot-cloud-tiering.md)|

If you're unsure where to start, see [General troubleshooting first steps](#general-troubleshooting-first-steps).

## General troubleshooting first steps

If you're experiencing issues with Azure File Sync, start by completing the following steps:

1. Check for any errors using the Azure portal or event logs on the server. For information about how to view the health of your Azure File Sync environment by using the Azure portal or event logs, see [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring#storage-sync-service).
2. Verify the Azure File Sync service is running on the server:
    - Open the Services MMC snap-in and verify the Storage Sync Agent service (FileSyncSvc) is running.
3. Verify the Azure File Sync filter drivers (*StorageSync.sys* and *StorageSyncGuard.sys*) are running on the server:
    - At an elevated command prompt, run `fltmc`. Verify the *StorageSync.sys* and *StorageSyncGuard.sys* file system filter drivers are listed.
4. Use the [Debug-StorageSyncServer cmdlet](#debug-storagesyncserver-cmdlet) on the server to check for common issues.

### Debug-StorageSyncServer cmdlet

The `Debug-StorageSyncServer` cmdlet will diagnose common issues on the Azure File Sync server, such as certificate misconfiguration and incorrect server time. We've also simplified Azure File Sync troubleshooting by merging the functionality of some existing scripts and cmdlets (*AFSDiag.ps1*, *FileSyncErrorsReport.ps1*, and `Test-StorageSyncNetworkConnectivity`) into the `Debug-StorageSyncServer` cmdlet.
 
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

## How to collect logs and traces on the Azure File Sync server

If your issue isn't resolved after following the steps in the troubleshooting documentation, run the AFSDiag tool and send its .zip file output to the support engineer assigned to your case for further diagnosis.

To run AFSDiag, perform the steps below:

1. Open an elevated PowerShell window, and then run the following commands (press <kbd>Enter</kbd> after each command):

    > [!NOTE]
    > AFSDiag will create the output directory and a temp folder within it prior to collecting logs and will delete the temp folder after execution. Specify an output location which does not contain data.

    ```powershell
    Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
    Debug-StorageSyncServer -AFSDiag -OutputDirectory C:\output -KernelModeTraceLevel Verbose -UserModeTraceLevel Verbose
    ```

2. Reproduce the issue. When you finish, enter *D*.
3. A .zip file that contains logs and trace files is saved to the output directory that you specified.

## See also

- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files](files/files-troubleshoot.md)
- [Troubleshoot Azure Files performance issues](files/files-troubleshoot-performance.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
