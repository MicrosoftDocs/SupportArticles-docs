---
title: Troubleshoot Azure File Sync
description: Troubleshoot common issues that you might encounter with Azure File Sync, which you can use to transform Windows Server into a quick cache of your Azure file share.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/16/2025
ms.author: kendownie
ms.custom: sap:File Sync
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
|Storage Sync Agent service (FileSyncSvc) fails to start|[Troubleshoot Azure File Sync](#storage-sync-agent-service-filesyncsvc-fails-to-start)|
|High memory usage on the server|[Troubleshoot Azure File Sync](#high-memory-usage-on-the-server)|

If you're unsure where to start, see [General troubleshooting first steps](#general-troubleshooting-first-steps).

## General troubleshooting first steps

If you're experiencing issues with Azure File Sync, start by completing the following steps:

1. Check for any errors using the Azure portal or event logs on the server. For information about how to view the health of your Azure File Sync environment by using the Azure portal or event logs, see [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring#storage-sync-service).
2. Verify the Azure File Sync service is running on the server:
    - Open the Services MMC snap-in and verify the Storage Sync Agent service (FileSyncSvc) is running. If the service is not running and fails to start, see [Storage Sync Agent service (FileSyncSvc) fails to start](#storage-sync-agent-service-filesyncsvc-fails-to-start).
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

## Storage Sync Agent service (FileSyncSvc) fails to start

After installing or upgrading the Azure File Sync agent (v18 or later), you might experience one of the following symptoms:

- The Storage Sync Agent service (FileSyncSvc) fails to start with the following error: 

  ```
  Error 0x80070057: The parameter is incorrect. 
  ```

- Registering a server using the `Register-AzStorageSyncServer` cmdlet fails with the following error: 

  ```
  Register-AzStorageSyncServer: Exception of type 'Commands.StorageSync.Interop.Exceptions.ServerRegistrationException' was thrown.
  ```

- ServerRegistration.exe or AfsUpdater.exe fails to open
- Agent installation fails. The installation log shows the error code 0x80c84111 with the following message:

  ```output
  Exception occurred while configuring MitigationRedirection policy. This could indicate that required windows updates not installed on the computer.
  ```

These issues occur because the Azure File Sync agent has a dependency on a Windows security feature and updates for this security feature are not installed.

To resolve this issue, verify your Windows Server has the following updates installed:
- Windows Server 2016 [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=cumulative%20windows%20server%202016) (latest cumulative update)
- Windows Server 2019 [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=cumulative%20windows%20server%202019) (latest cumulative update)
  - Cumulative updates are released monthly. To deploy the latest update, users can either use Windows Update or manually download it from the [Microsoft Update Catalog](https://catalog.update.microsoft.com). If installing manually, users should review the associated KB article to ensure all prerequisites are met.​ ​​If the Windows Updates aren't installed prior to installing the Azure File Sync agent, the Storage Sync Agent service (FileSyncSvc) will fail to start.
    
## Auto Update Not Upgrading ‘To Be Expired’ or Expired Azure File Sync Agent

If Auto Update is not upgrading your ‘to be expired’ or expired Azure File Sync agent, check if the agent expiration information is properly applied to the server. The expiration metadata is required for Auto Update to function as expected.

To verify whether the `AgentExpirationDate` is set, run the following command from an elevated PowerShell session:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Get-StorageSyncServer
```
If the AgentExpirationDate value is not set or is empty, there may be a networking issue preventing the server from receiving expiration data. To test network connectivity, run the following command:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Test-StorageSyncNetworkConnectivity
```
If network connectivity issues are reported, you can manually update the agent by downloading it from the [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=azure%20file%20sync).
After downloading the appropriate agent version, refer to the specific **Knowledge Base** article listed in the catalog for step-by-step installation instructions.

If connectivity issues are not found and the `AgentExpirationDate` is still not set, contact Azure File Sync support for further assistance.

## High memory usage on the server

Azure File Sync uses Extensible Storage Engine (ESE) databases for sync and cloud tiering. The ESE databases can consume up to 80% of system memory to improve performance. To limit the amount of memory used by the ESE databases, you can configure the `MaxESEDbCachePercent` registry setting on the server.

To reduce the ESE memory usage limit to 60%, which is a good balance between memory utilization and enough cache to maintain decent performance of the databases, run the following command from an elevated command prompt:

```console
REG ADD HKLM\Software\Microsoft\Azure\StorageSync /v MaxESEDbCachePercent /t REG_DWORD /d 60
```

Once the `MaxESEDbCachePercent` registry setting is created, restart the Storage Sync Agent (FileSyncSvc) service. 

## See also

- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Troubleshoot Azure Files performance issues](../performance/files-troubleshoot-performance.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
