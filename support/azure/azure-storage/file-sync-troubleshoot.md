---
title: Troubleshoot Azure File Sync
description: Troubleshoot common issues that you might encounter with Azure File Sync, which you can use to transform Windows Server into a quick cache of your Azure file share.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 08/25/2023
ms.author: kendownie
---
# Troubleshoot Azure File Sync

You can use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. This article is designed to help you troubleshoot and resolve issues that you might encounter with your Azure File Sync deployment. We also describe how to collect important logs from the system if a deeper investigation of the issue is required. If you don't see the answer to your question, you can contact us through the following channels (in escalating order):

- [Microsoft Q&A question page for Azure Files](/answers/products/azure?product=storage).
- [Azure Community Feedback](https://feedback.azure.com/d365community/forum/a8bb4a47-3525-ec11-b6e6-000d3a4f0f84?c=c860fa6b-3525-ec11-b6e6-000d3a4f0f84).
- Microsoft Support. To create a new support request, in the Azure portal, on the **Help** tab, select the **Help + support** button, and then select **New support request**.

## Common troubleshooting subject areas

Based on the issue you're exeriencing, review the appropriate Troubleshooting document:

- Agent installation or server registration issues, see [Troubleshoot Azure File Sync agent installation and server registration](file-sync-troubleshoot-installation.md)
- Cloud endpoint or server endpoint creation issues or registered server offline, see [Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)
- Server endpoint has an error status or files are failing to sync, see [Troubleshoot Azure File Sync sync health and errors](file-sync-troubleshoot-sync-errors.md)
- Files are failing to tier or recall, see [Troubleshoot Azure File Sync cloud tiering](file-sync-troubleshoot-cloud-tiering.md)

If you are unsure where to start, see [General troubleshooting first steps](#general-troubleshooting-first-steps).

## General troubleshooting first steps

If you are experiencing issues with Azure File Sync, start by completing the following steps:

1. Use the Azure portal or event logs on the server to check for any errors. The [Monitor Azure File Sync](https://learn.microsoft.com/azure/storage/file-sync/file-sync-monitoring) documentation covers how to view the health of your Azure File Sync environment using the portal and event logs.
2. Verify the Azure File Sync service is running on the server:
    - Open the Services MMC snap-in and verify the Storage Sync Agent service (FileSyncSvc) is running.
3. Verify the Azure File Sync filter drivers (*StorageSync.sys* and *StorageSyncGuard.sys*) are running on the server:
    - At an elevated command prompt, run `fltmc`. Verify the *StorageSync.sys* and *StorageSyncGuard.sys* file system filter drivers are listed.
4. Use the [debug-storagesyncserver cmdlet](#debug-storagesyncserver-cmdlet) on the server to check for common issues.

## Debug-StorageSyncServer cmdlet

The Debug-StorageSyncServer cmdlet will diagnose common issues on the Azure File Sync server like certificate misconfiguration and incorrect server time. We have also simplified Azure File Sync troubleshooting by merging the functionality of some of existing scripts and cmdlets (AFSDiag.ps1, FileSyncErrorsReport.ps1, Test-StorageSyncNetworkConnectivity) into the Debug-StorageSyncServer cmdlet.
 
To run diagnostics on the server, run the following PowerShell commands:
```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -Diagnose
```
To test network connectivity on the server, run the following PowerShell commands:
```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -TestNetworkConnectivity
```
To identify files that are failing to sync on the server, run the following PowerShell commands:
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

If your issue isn't resolved after following the steps in the Troubleshooting documentation, run the AFSDiag tool and send its .zip file output to the support engineer assigned to your case for further diagnosis.

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
- [Troubleshoot Azure Files](files-troubleshoot.md)
- [Troubleshoot Azure Files performance issues](files-troubleshoot-performance.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
