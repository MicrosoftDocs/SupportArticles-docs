---
title: Use Debug-StorageSyncServer cmdlet
description: Use the Debug-StorageSyncServer cmdlet to diagnose and fix Azure File Sync server issues, including connectivity and sync errors. Run checks now.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---
# Use Debug-StorageSyncServer cmdlet 

## Summary

The `Debug-StorageSyncServer` cmdlet diagnoses common problems on the Azure File Sync server, like certificate misconfiguration and incorrect server time. To simplify Azure File Sync troubleshooting, it merges the functionality of some existing scripts and cmdlets (*AFSDiag.ps1*, *FileSyncErrorsReport.ps1*, and `Test-StorageSyncNetworkConnectivity`).

## Perform diagnostics on the server

To perform diagnostics on the server, run the following PowerShell commands:

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

