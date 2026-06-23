---
title: Troubleshoot Server Cloning and Identity Issues in Azure File Sync
description: Troubleshoot server cloning and duplicate identity issues in Azure File Sync.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 06/22/2026
ms.author: vritikanaik
ms.reviewer: vritikanaik, v-weizhu, kendownie
---

# Troubleshoot server cloning and duplicate identity issues in Azure File Sync

Azure File Sync relies on a unique server identity to correctly synchronize data between on-premises servers and Azure file shares. Server cloning operations such as restoring OS-level backups or reverting virtual machines to snapshots can result in multiple servers sharing the same identity. This unsupported configuration can cause sync and registration failures.

## Unsupported scenarios

Azure File Sync doesn't support server cloning scenarios. Any attempt to clone or restore a server after the Azure File Sync agent is installed can lead to sync problems, data inconsistency, and service disruptions. For disaster recovery, use Azure Backup. For more information, see [Azure File Sync disaster recovery best practices](/azure/storage/file-sync/file-sync-disaster-recovery-best-practices).

The following actions aren't supported when using Azure File Sync. These actions can result in multiple servers sharing the same identity, which Azure File Sync can't handle:

- Cloning a virtual machine (VM) after Azure File Sync agent installation
- Restoring OS-level backups that result in duplicate servers
- Copying or moving OS disks from a registered Azure File Sync server
- Any imaging or templating of a server after agent installation

## Symptoms

If you clone or duplicate a server after installing the Azure File Sync agent, you might observe one or more of the following symptoms:

- Sync failures or complete sync stalls
- Sync database corruption, such as ESENT replay log errors
- Tiered files become inaccessible
- Failure to register or re-register the server
- Duplicate server identities or conflicting server activity
- New or updated files don't sync to Azure
- Errors such as:
  - `ECS_E_SYNC_REPLICA_BACK_IN_TIME`
  - `ECS_E_ACTIVE_SESSION_CHANGED`
  - `ECS_E_AUTH_IDENTITY_NOT_FOUND`

## Cause

Azure File Sync uses a unique authentication identity (certificate) to represent each registered server. When you clone a server, you duplicate this identity across multiple machines. As a result:

- Multiple servers appear as the same registered server in Azure File Sync.
- Authentication conflicts occur between instances.
- Sync state becomes inconsistent or corrupted.

These problems lead to failures in sync, registration, and data access.

## Resolution

To recover from a server cloning or duplicate identity scenario, follow these steps:

### 1. Stop duplicate server activity

Immediately shut down any cloned or duplicated servers to prevent further identity conflicts and data corruption.

### 2. Protect tiered data

If both servers are running, check for tiered files. Before making changes, ensure all tiered files are recalled locally. If you don't recall tiered files, you might make data inaccessible after cleanup operations.

### 3. Reset original server

Modify the registry to disable orphaned files cleanup, in case of any corruption. Run the following PowerShell cmdlet on the affected server:

```powershell
Reset-StorageSyncServer
```

### 4. Choose a recovery approach

After resetting the server identity, choose one of the following recovery approaches based on data size and recovery requirements.

- **Fast recovery** (new endpoint with empty namespace): Use this option when you need to restore sync quickly and can tolerate rehydration from Azure. This option creates a new server endpoint and rebuilds the namespace from Azure. It's the fastest option for recovery and is recommended for most scenarios. This approach prioritizes speed over local database reconstruction.
- **Thorough recovery** (rebuild sync database): Use this option when local cache consistency or full state reconstruction is required. This option rebuilds the Azure File Sync database on the server and performs full re-enumeration of files. It has a slower initial sync process. Use it for complex corruption or inconsistent sync states. This approach prioritizes data consistency over recovery speed.

### 5. Re-register the server by using PowerShell

Re-register the server with Azure File Sync by using PowerShell. Use PowerShell to avoid problems that might occur with the Azure File Sync installer UI.

```powershell
Register-AzStorageSyncServer
```

### 6. Recreate server endpoints

After successful registration, follow these steps:

1. Recreate the server endpoint in the Storage Sync Service.
1. Ensure correct path mapping to the local file system.
1. Allow initial synchronization to complete.

## See also

- [Azure File Sync disaster recovery best practices](/azure/storage/file-sync/file-sync-disaster-recovery-best-practices)
- [Troubleshoot Azure File Sync agent installation and server registration](file-sync-troubleshoot-installation.md)
- [Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)
- [Troubleshoot Azure File Sync sync errors](file-sync-troubleshoot-sync-errors.md)
- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
