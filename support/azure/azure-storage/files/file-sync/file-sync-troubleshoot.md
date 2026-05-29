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

## Common troubleshooting documentation

Based on the problem you're experiencing, review the appropriate troubleshooting documentation:

|Problems|Troubleshooting documentation|
|---|---|
|Agent installation or server registration problems|[Troubleshoot Azure File Sync agent installation and server registration](file-sync-troubleshoot-installation.md)|
|Cloud endpoint or server endpoint creation problems, or the registered server is offline|[Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)|
|Server endpoint has an error status, or files fail to sync|[Troubleshoot Azure File Sync sync health and errors](file-sync-troubleshoot-sync-errors.md)|
|Files fail to tier or recall|[Troubleshoot Azure File Sync cloud tiering](file-sync-troubleshoot-cloud-tiering.md)|
|Storage Sync Agent service (FileSyncSvc) fails to start|[Storage Sync Agent service (FileSyncSvc) fails to start](file-sync-troubleshoot-service-fails-start.md)|
|High memory usage on the server|[Troubleshoot high memory usage](file-sync-troubleshoot-high-memory-usage.md)|

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
1. Use the [Debug-StorageSyncServer cmdlet](file-sync-use-debug-cmdlet.md) on the server to check for common problems.

## Troubleshooting resources

- [Use Debug-StorageSyncServer cmdlet](file-sync-use-debug-cmdlet.md)
- [Collect logs and traces on the Azure File Sync server](file-sync-collect-logs-traces.md)
- [Troubleshoot Auto Update for expired Azure File Sync agents](file-sync-troubleshoot-auto-update-expired-agent.md)

 
