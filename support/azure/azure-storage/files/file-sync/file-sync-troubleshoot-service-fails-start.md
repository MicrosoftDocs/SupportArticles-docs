---
title: Troubleshoot Storage Sync Agent service (FileSyncSvc) when it fails to start
description: Fix Storage Sync Agent service (FileSyncSvc) startup failures after Azure File Sync agent install or upgrade. Follow these steps now.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---
# Storage Sync Agent service (FileSyncSvc) fails to start

## Summary

This article describes the symptoms and resolution steps for when the Storage Sync Agent service (FileSyncSvc) fails to start after installing or upgrading the Azure File Sync agent (v18 or later). The failure is typically caused by missing Windows updates that are required for the security features the agent depends on.

## Symptoms

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

These problems occur because the Azure File Sync agent depends on a Windows security feature and updates for this security feature aren't installed.

## Solution

To resolve this problem, verify your Windows Server has the following updates installed:

- Windows Server 2016 [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=cumulative%20windows%20server%202016) (latest cumulative update)
- Windows Server 2019 [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=cumulative%20windows%20server%202019) (latest cumulative update)
  
Cumulative updates are released monthly. To deploy the latest update, you can use Windows Update or download it from the [Microsoft Update Catalog](https://catalog.update.microsoft.com). Before manual installation, review the associated Knowledge Base (KB) article to ensure all prerequisites are met.​ ​​If Windows updates aren't installed before installing the Azure File Sync agent, the Storage Sync Agent service (FileSyncSvc) fails to start.

