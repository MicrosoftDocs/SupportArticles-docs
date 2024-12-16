---
title: Troubleshoot sync health and errors in Azure File Sync
description: Troubleshoot common issues with monitoring sync health and resolving sync errors in an Azure File Sync deployment.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 12/16/2024
ms.author: kendownie
ms.custom: sap:File Sync, devx-track-azurepowershell
ms.reviewer: v-weizhu
---
# Troubleshoot Azure File Sync sync health and errors

This article is designed to help you troubleshoot and resolve common sync issues that you might encounter with your Azure File Sync deployment.

## Sync health

<a id="afs-change-detection"></a>**If I created a file directly in my Azure file share over SMB or through the portal, how long does it take for the file to sync to servers in the sync group?**

Changes made to the Azure file share by using the Azure portal or SMB aren't immediately detected and replicated like changes to the server endpoint. Azure Files doesn't yet have change notifications or journaling, so there's no way to automatically initiate a sync session when files are changed. On Windows Server, Azure File Sync uses [Windows USN journaling](/windows/win32/fileio/change-journals) to automatically initiate a sync session when files change.

To detect changes to the Azure file share, Azure File Sync has a scheduled job called *a change detection job*. A change detection job enumerates every file in the file share, and then compares it to the sync version for that file. When the change detection job determines that files have changed, Azure File Sync initiates a sync session. The change detection job is initiated every 24 hours. Because the change detection job works by enumerating every file in the Azure file share, change detection takes longer in larger namespaces than in smaller namespaces. For large namespaces, it might take longer than once every 24 hours to determine which files have changed.

To immediately sync files that are changed in the Azure file share, the `Invoke-AzStorageSyncChangeDetection` PowerShell cmdlet can be used to manually initiate the detection of changes in the Azure file share. This cmdlet is intended for scenarios where some type of automated process is making changes in the Azure file share or the changes are done by an administrator (like moving files and directories into the share). For end user changes, the recommendation is to install the Azure File Sync agent in an IaaS VM and have end users access the file share through the IaaS VM. This way all changes will quickly sync to other agents without the need to use the `Invoke-AzStorageSyncChangeDetection` cmdlet. To learn more, see the [Invoke-AzStorageSyncChangeDetection](/powershell/module/az.storagesync/invoke-azstoragesyncchangedetection) documentation.

We are exploring adding change detection for an Azure file share similar to USN for volumes on Windows Server. Help us prioritize this feature for future development by voting for it at [Azure Community Feedback](https://feedback.azure.com/d365community/idea/26f8aa9d-3725-ec11-b6e6-000d3a4f0f84).

<a id="serverendpoint-pending"></a>**Server endpoint health is in a pending state for several hours**
  
This issue is expected if you create a cloud endpoint and use an Azure file share that contains data. The cloud change enumeration job that scans for changes in the Azure file share must complete before files can sync between the cloud and server endpoints. The time to complete the job is dependent on the size of the namespace in the Azure file share. The server endpoint health should update once the change enumeration job completes.

To check the status of the cloud change enumeration job, go the **Cloud Endpoint** properties in the portal and the status is provided in the **Change Enumeration** section.

### <a id="broken-sync"></a>How do I monitor sync health?

### [Portal](#tab/portal1)

To view the health of a **server endpoint** in the portal, navigate to the **Sync groups** section of the **Storage Sync Service** and select a **sync group**.

:::image type="content" source="media/file-sync-troubleshoot-sync-errors/serverendpoint-health.png" alt-text="Screenshot that shows the server endpoint health in the Azure portal." lightbox="media/file-sync-troubleshoot-sync-errors/serverendpoint-health.png" border="false":::

A **Healthy** status and a **Persistent sync errors** count of 0 indicate that sync is working as expected. If **Persistent sync errors** has a count greater than 0, see [How do I see if there are specific files or folders that are not syncing](#how-do-i-see-if-there-are-specific-files-or-folders-that-are-not-syncing) to troubleshoot why files are failing to sync. If the server endpoint has a **Health status** other than **Healthy**, follow the guidance in the table below.  

| Health status | Description | Remediation |
|---------|-------------------|--------------|
| Healthy | Sync session completed successfully or the in-progress sync session is making progress (files are applied). | N/A |
| Pending | The Pending status is expected after creating a server endpoint. Once sync telemetry for the server endpoint is sent to the service, the Health status will update. | If the Health status doesn't change for several hours, see [Server endpoint health is in a pending state for several hours](#serverendpoint-pending). |
| Error | Sync session failed with an error. | To resolve this issue, select the **Error** status in the portal to get the error code and remediation steps. If the remediation steps aren't listed in the portal or don't resolve the issue, search for the error code in this document for more guidance. |
| No Activity | The Storage Sync Service has not received sync telemetry from this server endpoint in the past two hours. | To resolve this issue, follow the steps in [Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md#server-endpoint-noactivity). |
| Low disk mode | The volume where the server endpoint is located is low on disk space. | To resolve this issue, free disk space on the volume. To learn more about low disk space mode, see [Cloud tiering overview](/azure/storage/file-sync/file-sync-cloud-tiering-overview#low-disk-space-mode). |
| Provisioning canceled | The server endpoint creation failed. Sync isn't operational on this server endpoint.| To resolve this issue, see [Server endpoint creation and deletion errors](file-sync-troubleshoot-sync-group-management.md#server-endpoint-creation-and-deletion-errors). |

> [!Note]  
> The server endpoint status (health and activity) is refreshed every 15 minutes and is based on the Telemetry events that are sent from the server to the service.

### [Server](#tab/server)

Look at the most recent 9102 event in the telemetry log on the server (in the Event Viewer, go to *Applications and Services Logs\Microsoft\FileSync\Agent\Telemetry*). This event is logged once a sync session is completed. `SyncDirection` tells you if this session was an upload or download. If the `HResult` is 0, then the sync session was successful. A non-zero `HResult` means that there was an error during sync; see below for a list of common errors. If the `PerItemErrorCount` is greater than 0, then some files or folders didn't sync properly. It's possible to have an `HResult` of 0 but a `PerItemErrorCount` that is greater than 0.

Here's an example of a successful upload. For the sake of brevity, only some of the values contained in each 9102 event are listed.

```output
Replica Sync session completed.
SyncDirection: Upload,
HResult: 0, 
SyncFileCount: 2, SyncDirectoryCount: 0,
AppliedFileCount: 2, AppliedDirCount: 0, AppliedTombstoneCount 0, AppliedSizeBytes: 0.
PerItemErrorCount: 0,
TransferredFiles: 2, TransferredBytes: 0, FailedToTransferFiles: 0, FailedToTransferBytes: 0.
```

Conversely, an unsuccessful upload might look like this:

```output
Replica Sync session completed.
SyncDirection: Upload,
HResult: -2134364065,
SyncFileCount: 0, SyncDirectoryCount: 0, 
AppliedFileCount: 0, AppliedDirCount: 0, AppliedTombstoneCount 0, AppliedSizeBytes: 0.
PerItemErrorCount: 0, 
TransferredFiles: 0, TransferredBytes: 0, FailedToTransferFiles: 0, FailedToTransferBytes: 0.
```

Sometimes sync sessions fail overall or have a non-zero `PerItemErrorCount` but still make forward progress, with some files syncing successfully. Progress can be determined by looking into the Applied fields (`AppliedFileCount`, `AppliedDirCount`, `AppliedTombstoneCount`, and `AppliedSizeBytes`). These fields describe how much of the session is succeeding. If you see multiple sync sessions in a row that are failing but have an increasing *Applied* count, then you should give sync time to try again before opening a support ticket.

---

### How do I monitor the progress of a current sync session?

### [Portal](#tab/portal1)

Within your sync group, go to the server endpoint properties and look at the **Sync status** section to see the count of files uploaded or downloaded in the current sync session. This status will be delayed by about 15 minutes. If your sync session is small enough to be completed within this period, it might not be reported in the portal.

:::image type="content" source="media/file-sync-troubleshoot-sync-errors/serverendpoint-syncstatus.png" alt-text="Screenshot that shows the sync progress in the Azure portal." lightbox="media/file-sync-troubleshoot-sync-errors/serverendpoint-syncstatus.png" border="false":::

> [!Note]  
> If the **Estimated completion** is blank, this means sync has not finished counting the number of files in the sync session.

### [Server](#tab/server)

Look at the most recent 9302 event in the telemetry log on the server (in the Event Viewer, go to *Applications and Services Logs\Microsoft\FileSync\Agent\Telemetry*). This event indicates the state of the current sync session. `TotalItemCount` denotes how many files are to be synced, `AppliedItemCount` denotes the number of files that have been synced so far, and `PerItemErrorCount` denotes the number of files that are failing to sync (see the following for how to deal with this).

```output
Replica Sync Progress. 
ServerEndpointName: <CI>sename</CI>, SyncGroupName: <CI>sgname</CI>, ReplicaName: <CI>rname</CI>, 
SyncDirection: Upload, CorrelationId: {AB4BA07D-5B5C-461D-AAE6-4ED724762B65}. 
AppliedItemCount: 172473, TotalItemCount: 624196. AppliedBytes: 51473711577, 
TotalBytes: 293363829906. 
AreTotalCountsFinal: true. 
PerItemErrorCount: 1006.
```

---

### How do I know if my servers are in sync with each other?

### [Portal](#tab/portal1)

For each server in a given sync group, make sure:

- The timestamps for the **Upload to cloud** and **Download to server** are recent.
- The status is green for both upload and download.
- The **Sync status** section within the server endpoint properties shows very few or no files remaining to sync.
- The **Persistent sync errors** and **Transient sync errors** fields within the server endpoint properties have a count of 0.

### [Server](#tab/server)

Look at the completed sync sessions, which are marked by 9102 events in the telemetry event log for each server (in the Event Viewer, go to *Applications and Services Logs\Microsoft\FileSync\Agent\Telemetry*).

1. On any given server, you want to make sure the latest upload and download sessions completed successfully.

    To do this, check that the `HResult` and `PerItemErrorCount` are 0 for both upload and download (the `SyncDirection` field indicates if a given session is an upload or download session). Note that if you don't see a recently completed sync session, likely a sync session is currently in progress, which is to be expected if you just added or modified a large amount of data.

1. When a server is fully up to date with the cloud and has no changes to sync in either direction, you will see empty sync sessions. These are indicated by upload and download events in which all the Sync* fields (`SyncFileCount`, `SyncDirCount`, `SyncTombstoneCount`, and `SyncSizeBytes`) are zero, meaning there was nothing to sync. Note that these empty sync sessions might not occur on high-churn servers as there is always something new to sync. If there is no sync activity, they should occur every 30 minutes.

1. If all servers are up to date with the cloud, meaning their recent upload and download sessions are empty sync sessions, you can say with reasonable certainty that the system as a whole is in sync.

If you made changes directly in your Azure file share, Azure File Sync won't detect these changes until change enumeration runs, which happens once every 24 hours. It's possible that a server will say it is up to date with the cloud when it is in fact missing recent changes made directly in the Azure file share.

---

### How do I see if there are specific files or folders that are not syncing?

If the **Persistent sync errors** and **Transient sync errors** counts in the portal or `PerItemErrorCount` on the server is greater than 0 for any given sync session, that means some items are failing to sync. Files and folders can have characteristics that prevent them from syncing. These characteristics can be persistent and require explicit action to resume sync, for example removing unsupported characters from the file or folder name. They can also be transient, meaning the file or folder will automatically resume sync; for example, files with open handles will automatically resume sync when the file is closed. When the Azure File Sync engine detects such a problem, an error log is produced that can be parsed to list the items currently not syncing properly.

> [!Note]  
> Once a sync session is completed, the **Persistent sync errors** and **Transient sync errors** counts in the portal are updated. If a sync session is in progress, wait until the sync session is completed and the **Persistent sync errors** and **Transient sync errors** counts are updated before you investigate the remaining errors.

To see the names of files and directories that are failing to sync, run the *FileSyncErrorsReport.ps1* PowerShell script (located in the agent installation directory of the Azure File Sync agent) or use the `Debug-StorageSyncServer` cmdlet. The `ItemPath` field tells you the location of the file in relation to the root sync directory. See the list of [common per-item errors](#troubleshooting-per-filedirectory-sync-errors) for remediation steps.

To identify files that fail to sync on the server by using the `Debug-StorageSyncServer` cmdlet, run the following PowerShell commands:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Debug-StorageSyncServer -FileSyncErrorsReport
```

## Sync errors

### Troubleshooting per file/directory sync errors

If a file or directory fails to sync due to an error, an event is logged in the *Microsoft-FileSync-Agent/ItemResults* event log. This section covers common error codes and remediation steps for per-item errors.

> [!Note]  
> If a file or directory fails to sync, it can take up to 30 minutes before Azure File Sync retries syncing that item. If no changes are detected within the server endpoint location, Azure File Sync initiates a sync session every 30 minutes. To force a sync session, restart the Storage Sync Agent (*FileSyncSvc*) service or make a change to a file or directory within the server endpoint location.

**Common per-item sync errors that are logged in the ItemResults event log**

| HRESULT | HRESULT (decimal) | Error string | Issue | Remediation |
|---------|-------------------|--------------|-------|-------------|
| 0x80070043 | -2147942467 | ERROR_BAD_NET_NAME | The tiered file on the server isn't accessible. This issue occurs if the tiered file was not recalled prior to deleting a server endpoint. | To resolve this issue, see [Tiered files are not accessible on the server](file-sync-troubleshoot-cloud-tiering.md#tiered-files-are-not-accessible-on-the-server).|
| 0x80c80207 | -2134375929 | ECS_E_SYNC_CONSTRAINT_CONFLICT | The file or directory change can't be synced yet because a dependent folder isn't yet synced. This item will sync after the dependent changes are synced. | Transient error. If the error persists for several days, create a support request. |
| 0x80C8028A | -2134375798 | ECS_E_SYNC_CONSTRAINT_CONFLICT_ON_FAILED_DEPENDEE | The file or directory change can't be synced yet because a dependent folder isn't yet synced. This item will sync after the dependent changes are synced. | Transient error. If the error persists, use the *FileSyncErrorsReport.ps1* PowerShell script to determine why the dependent folder isn't yet synced. |
| 0x80c80284 | -2134375804 | ECS_E_SYNC_CONSTRAINT_CONFLICT_SESSION_FAILED | The file or directory change can't be synced yet because a dependent folder isn't yet synced and the sync session failed. This item will sync after the dependent changes are synced. | No action required. If the error persists, investigate the sync session failure. |
| 0x8007007b | -2147024773 | ERROR_INVALID_NAME | The file or directory name is invalid. | Rename the file or directory in question. See [Handling unsupported characters](?tabs=portal1%252cazure-portal#handling-unsupported-characters) for more information. |
| 0x80070459 | -2147023783 | ERROR_NO_UNICODE_TRANSLATION | The file or directory name has unsupported surrogate pair characters. | Rename the file or directory in question. See [Handling unsupported characters](?tabs=portal1%252cazure-portal#handling-unsupported-characters) for more information. |
| 0x80c80255 | -2134375851 | ECS_E_XSMB_REST_INCOMPATIBILITY | The file or directory name is invalid. | Rename the file or directory in question. See [Handling unsupported characters](?tabs=portal1%252cazure-portal#handling-unsupported-characters) for more information. |
| 0x80c80018 | -2134376424 | ECS_E_SYNC_FILE_IN_USE | The file can't be synced because it's in use. The file will be synced when it's no longer in use. | No action required. Azure File Sync creates a temporary VSS snapshot once a day on the server to sync files that have open handles. |
| 0x80c8031d | -2134375651 | ECS_E_CONCURRENCY_CHECK_FAILED | The file has changed, but the change hasn't yet been detected by sync. Sync will recover after this change is detected. | No action required. |
| 0x80070002 | -2147024894 | ERROR_FILE_NOT_FOUND | The file was deleted and sync isn't aware of the change. | No action required. Sync will stop logging this error once change detection detects the file was deleted. |
| 0x80070003 | -2147024893 | ERROR_PATH_NOT_FOUND | Deletion of a file or directory can't be synced because the item was already deleted in the destination and sync isn't aware of the change. | No action required. Sync will stop logging this error once change detection runs on the destination and sync detects the item was deleted. |
| 0x80c80205 | -2134375931 | ECS_E_SYNC_ITEM_SKIP | The file or directory was skipped but will be synced during the next sync session. If this error is reported when downloading the item, the file or directory name is more than likely invalid. | No action required if this error is reported when uploading the file. If the error is reported when downloading the file, rename the file or directory in question. See [Handling unsupported characters](?tabs=portal1%252cazure-portal#handling-unsupported-characters) for more information. |
| 0x800700B7 | -2147024713 | ERROR_ALREADY_EXISTS | Creation of a file or directory can't be synced because the item already exists in the destination and sync isn't aware of the change. | No action required. Sync will stop logging this error once change detection runs on the destination and sync is aware of this new item. |
| 0x80c8603e | -2134351810 | ECS_E_AZURE_STORAGE_SHARE_SIZE_LIMIT_REACHED | The file can't be synced because the Azure file share limit is reached. | To resolve this issue, see [You reached the Azure file share storage limit](?tabs=portal1%252cazure-portal#-2134351810) section in the troubleshooting guide. |
| 0x80c83008 | -2134364152 | ECS_E_CANNOT_CREATE_AZURE_STAGED_FILE | The file can't be synced because the Azure file share limit is reached.  | To resolve this issue, see [You reached the Azure file share storage limit](?tabs=portal1%252cazure-portal#-2134351810) section in the troubleshooting guide. |
| 0x80c8027C | -2134375812 | ECS_E_ACCESS_DENIED_EFS | The file is encrypted by an unsupported solution (like NTFS EFS). | Decrypt the file and use a supported encryption solution. For a list of support solutions, see the [Encryption](/azure/storage/file-sync/file-sync-planning#encryption) section of the planning guide. |
| 0x80c80283 | -2160591491 | ECS_E_ACCESS_DENIED_DFSRRO | The file is located on a DFS-R read-only replication folder. | File is located on a DFS-R read-only replication folder. Azure File Sync doesn't support server endpoints on DFS-R read-only replication folders. See [planning guide](/azure/storage/file-sync/file-sync-planning#distributed-file-system-dfs) for more information. |
| 0x80070005 | -2147024891 | ERROR_ACCESS_DENIED | The file has a delete pending state. | No action required. File will be deleted once all open file handles are closed. |
| 0x80c86044 | -2134351804 | ECS_E_AZURE_AUTHORIZATION_FAILED | The file can't be synced because the firewall and virtual network settings on the storage account are enabled, and the server doesn't have access to the storage account. | Add the Server IP address or virtual network by following the steps documented in the [Configure firewall and virtual network settings](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings) section in the deployment guide. |
| 0x8000ffff | -2147418113 | E_UNEXPECTED | The file can't be synced due to an unexpected error. | If the error persists for several days, please open a support case. |
| 0x80070020 | -2147024864 | ERROR_SHARING_VIOLATION | The file can't be synced because it's in use. The file will be synced when it's no longer in use. | No action required. |
| 0x80c80017 | -2134376425 | ECS_E_SYNC_OPLOCK_BROKEN | The file was changed during sync, so it needs to be synced again. | No action required. |
| 0x80070017 | -2147024873 | ERROR_CRC | The file can't be synced due to CRC error. This error can occur if a tiered file was not recalled prior to deleting a server endpoint or if the file is corrupt. | To resolve this issue, see [Tiered files are not accessible on the server](file-sync-troubleshoot-cloud-tiering.md#tiered-files-are-not-accessible-on-the-server) to remove tiered files that are orphaned. If the error continues to occur after removing orphaned tiered files, run [chkdsk](/windows-server/administration/windows-commands/chkdsk) on the volume. |
| 0x800703ee | -2147023890 | ERROR_FILE_INVALID |  The file can't be synced because it's no longer valid. This error typically occurs if the file is tiered and orphaned. | If the file is tiered, see [Tiered files are not accessible on the server](file-sync-troubleshoot-cloud-tiering.md#tiered-files-are-not-accessible-on-the-server) to remove tiered files that are orphaned. |
| 0x80070570 | -2147023504 | ERROR_FILE_CORRUPT |  The file or directory is corrupted and unreadable. | Run [chkdsk](/windows-server/administration/windows-commands/chkdsk) on the volume. |
| 0x80c80200 | -2134375936 | ECS_E_SYNC_CONFLICT_NAME_EXISTS | The file can't be synced because the maximum number of conflict files has been reached. Azure File Sync supports 100 conflict files per file. To learn more about file conflicts, see Azure File Sync [FAQ](/azure/storage/files/storage-files-faq?toc=/azure/storage/filesync/toc.json#afs-conflict-resolution). | To resolve this issue, reduce the number of conflict files. The file will sync once the number of conflict files is less than 100. |
| 0x80c8027d | -2134375811 | ECS_E_DIRECTORY_RENAME_FAILED | Rename of a directory can't be synced because files or folders within the directory have open handles. | No action required. The rename of the directory will be synced once all open file handles within the directory are closed. |
| 0x800700de | -2147024674 | ERROR_BAD_FILE_TYPE | The tiered file on the server isn't accessible because it's referencing a version of the file which no longer exists in the Azure file share. | This issue can occur if the tiered file was restored from a backup of the Windows Server. To resolve this issue, restore the file from a snapshot in the Azure file share. |
| 0x80C80065 | -2134376347 | ECS_E_DATA_TRANSFER_BLOCKED | The file has been identified to produce persistent errors during sync. Hence it is blocked from sync until the retry interval is reached.  The file will be retried later. | No action required. The file will be retried after 24 hours. If the error persists for several days, create a support request. |
| 0x80C80203 | -2134375933 | ECS_E_SYNC_INVALID_STAGED_FILE | File transfer error. Service will retry later. | No action required. This error should automatically resolve. If the error persists for several days, create a support request. |
| 0x80c8027f | -2134375809 | ECS_E_SYNC_CONSTRAINT_CONFLICT_CYCLIC_DEPENDENCY | Sync session timeout error. | No action required. This error should automatically resolve. If the error persists for several days, create a support request. |
| 0x80070035 | -2147024843 | ERROR_BAD_NETPATH | The network path was not found. | No action required. This error should automatically resolve. If the error persists for several days, create a support request. |
| 0x80071779 | -2147018887 | ERROR_FILE_READ_ONLY | The specified file is read only. | If the error persists for more than a day, create a support request. |
| 0x80070006 | -2147024890 | ERROR_INVALID_HANDLE | An internal error occurred. | If the error persists for more than a day, create a support request. |
| 0x8007012f | -2147024593 | ERROR_DELETE_PENDING | The file cannot be opened because it is in the process of being deleted. | No action required. This error should automatically resolve. If the error persists for several days, create a support request. |
| 0x80041007 | -2147217401 | SYNC_E_ITEM_MUST_EXIST | An internal error occurred. | If the error persists for more than a day, create a support request. |
| 0X80C80293 | -2134375789 | ECS_E_SYNC_INITIAL_SCAN_COMPLETED | The sync session failed because the initial enumeration was completed. The next session will cover the full namespace. | No action required. This error should automatically resolve. If the error persists for several days, create a support request. |
| 0X80C80342 | -2134375614 | ECS_E_SYNC_CUSTOM_METADATA_VERSION_NOT_SUPPORTED | The sync database has custom metadata with a version higher than the supported version. | Please upgrade the File Sync agent to the latest version. If the error persists after upgrading the agent, create a support request. |

### Handling unsupported characters

[Azure File Sync agent v17](https://support.microsoft.com/help/5023053) supports all characters that are supported by the [NTFS file system](/windows/win32/fileio/naming-a-file) except invalid surrogate pairs.

If the portal or *FileSyncErrorsReport.ps1* PowerShell script shows per-item sync errors (error code 0x8007007b, 0x80c80255, or 0x80070459) due to unsupported characters, check whether Azure File Sync agent v17 is installed on the server. If agent v17 is installed and files still fail to sync due to invalid characters, use the [ScanUnsupportedChars](https://github.com/Azure-Samples/azure-files-samples/tree/master/ScanUnsupportedChars) script to rename files that contain unsupported characters.

### Common sync errors

This section covers common error codes and remediation steps when a sync session fails with an error.

<a id="-2147023673"></a>**The sync session was canceled.**

| Error | Code |
|-|-|
| **HRESULT** | 0x800704c7 |
| **HRESULT (decimal)** | -2147023673 |
| **Error string** | ERROR_CANCELLED |
| **Remediation required** | No |

Sync sessions might fail for various reasons including the server being restarted or updated, VSS snapshots, etc. Although this error looks like it requires follow-up, it's safe to ignore this error unless it persists over a period of several hours.

<a id="-2134375780"></a>**The file sync session was cancelled by the volume snapshot sync session that runs once a day to sync files with open handles.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8029c |
| **HRESULT (decimal)** | -2134375780 |
| **Error string** | ECS_E_SYNC_CANCELLED_BY_VSS |
| **Remediation required** | No |

No action required. Azure File Sync has a scheduled task (VssSyncScheduledTask) that runs once a day on the server to sync files that are in use. When this scheduled task starts, it will cancel the current upload sync session (resulting in the 0x80c8029c error code), create a VSS snapshot, and start a new upload sync session utilizing the VSS snapshot.

<a id="-2147012889"></a>**A connection with the service could not be established.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80072ee7 |
| **HRESULT (decimal)** | -2147012889 |
| **Error string** | WININET_E_NAME_NOT_RESOLVED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83081 |
| **HRESULT (decimal)** | -2134364031 |
| **Error string** | ECS_E_HTTP_CLIENT_CONNECTION_ERROR |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8309a |
| **HRESULT (decimal)** | -2134364006 |
| **Error string** | ECS_E_AZURE_STORAGE_REMOTE_NAME_NOT_RESOLVED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0xc00000c4 |
| **HRESULT (decimal)** | -1073741628 |
| **Error string** | UNEXPECTED_NETWORK_ERROR |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80072ee2 |
| **HRESULT (decimal)** | -2147012894 |
| **Error string** | WININET_E_TIMEOUT |
| **Remediation required** | Yes |

This error can occur whenever the Azure File Sync service is inaccessible from the server. You can troubleshoot this error by working through the following steps:

1. Verify the Windows service *FileSyncSvc.exe* is not blocked by your firewall.

1. Verify that port 443 is open to outgoing connections to the Azure File Sync service. You can do this with the `Test-NetConnection` cmdlet. The URL for the `<azure-file-sync-endpoint>` placeholder below can be found in the [Azure File Sync proxy and firewall settings](/azure/storage/file-sync/file-sync-firewall-and-proxy#firewall) document.

    ```powershell
    Test-NetConnection -ComputerName <azure-file-sync-endpoint> -Port 443
    ```

1. Ensure that the proxy configuration is set as anticipated. This can be done with the `Get-StorageSyncProxyConfiguration` cmdlet. More information on configuring the proxy configuration for Azure File Sync can be found in the [Azure File Sync proxy and firewall settings](/azure/storage/file-sync/file-sync-firewall-and-proxy#firewall).

    ```powershell
    $agentPath = "C:\Program Files\Azure\StorageSyncAgent"
    Import-Module "$agentPath\StorageSync.Management.ServerCmdlets.dll"
    Get-StorageSyncProxyConfiguration
    ```

1. Use the `Test-StorageSyncNetworkConnectivity` cmdlet to check network connectivity to the service endpoints. To learn more, see [Test network connectivity to service endpoints](/azure/storage/file-sync/file-sync-firewall-and-proxy#test-network-connectivity-to-service-endpoints).

1. Contact your network administrator for additional assistance troubleshooting network connectivity.

> [!Note]  
> Once network connectivity to the Azure File Sync service is restored, sync might not resume immediately. By default, Azure File Sync will initiate a sync session every 30 minutes if no changes are detected within the server endpoint location. To force a sync session, restart the Storage Sync Agent (FileSyncSvc) service or make a change to a file or directory within the server endpoint location.

<a id="-2134376372"></a>**The user request was throttled by the service.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8004c |
| **HRESULT (decimal)** | -2134376372 |
| **Error string** | ECS_E_USER_REQUEST_THROTTLED |
| **Remediation required** | No |

No action is required; the server will try again. If this error persists for several hours, create a support request.

<a id="-2134364160"></a>**Sync failed because the operation was aborted**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83000 |
| **HRESULT (decimal)** | -2134364160 |
| **Error string** | ECS_E_OPERATION_ABORTED |
| **Remediation required** | No |

No action is required. If this error persists for several hours, create a support request.

<a id="-2134364019"></a>**The operation was cancelled.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8308d |
| **HRESULT (decimal)** | -2134364019 |
| **Error string** | ECS_E_REQUEST_CANCELLED_EXTERNALLY |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x8013153b |
| **HRESULT (decimal)** | -2146233029 |
| **Error string** | COR_E_OPERATIONCANCELED |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134364043"></a>**Sync is blocked until change detection completes post restore**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83075 |
| **HRESULT (decimal)** | -2134364043 |
| **Error string** | ECS_E_SYNC_BLOCKED_ON_CHANGE_DETECTION_POST_RESTORE |
| **Remediation required** | No |

No action is required. When a file or file share (cloud endpoint) is restored using Azure Backup, sync is blocked until change detection completes on the Azure file share. Change detection immediately runs once the restore is complete and the duration is based on the number of files in the file share.

<a id="-2134364072"></a>**Sync is blocked on the folder due to a pause initiated as part of restore on sync folder.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83058 |
| **HRESULT (decimal)** | -2134364072 |
| **Error string** |    ECS_E_SYNC_BLOCKED_ON_RESTORE |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2147216747"></a>**Sync failed because the sync database was unloaded.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80041295 |
| **HRESULT (decimal)** | -2147216747 |
| **Error string** | SYNC_E_METADATA_INVALID_OPERATION |
| **Remediation required** | No |

This error typically occurs when a backup application creates a VSS snapshot and the sync database is unloaded. If this error persists for several hours, create a support request.

<a id="-2134364065"></a>**Sync can't access the Azure file share specified in the cloud endpoint.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8305f |
| **HRESULT (decimal)** | -2134364065 |
| **Error string** | ECS_E_EXTERNAL_STORAGE_ACCOUNT_AUTHORIZATION_FAILED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86053 |
| **HRESULT (decimal)** | -2134351789 |
| **Error string** | ECS_E_AZURE_FILE_SHARE_NOT_ACCESSIBLE |
| **Remediation required** | Yes |

This error occurs because the Azure File Sync agent can't access the Azure file share, which might be because the Azure file share or the storage account hosting it no longer exists. You can troubleshoot this error by working through the following steps:

1. [Verify the storage account exists.](#troubleshoot-storage-account)
2. [Ensure the Azure file share exists.](#troubleshoot-azure-file-share)
3. [Ensure Azure File Sync has access to the storage account.](#troubleshoot-rbac)
4. Verify the **SMB security settings** on the storage account are allowing **SMB 3.1.1** protocol version, **NTLM v2** authentication and **AES-128-GCM** encryption. To check the SMB security settings on the storage account, see [SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings).
5. [Verify the firewall and virtual network settings on the storage account are configured properly (if enabled)](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings)

<a id="-2134351804"></a>**Sync failed because the request isn't authorized to perform this operation.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86044 |
| **HRESULT (decimal)** | -2134351804 |
| **Error string** | ECS_E_AZURE_AUTHORIZATION_FAILED |
| **Remediation required** | Yes |

This error occurs because the Azure File Sync agent isn't authorized to access the Azure file share. You can troubleshoot this error by working through the following steps:

1. [Verify the storage account exists.](#troubleshoot-storage-account)
2. [Ensure the Azure file share exists.](#troubleshoot-azure-file-share)
3. [Verify the firewall and virtual network settings on the storage account are configured properly (if enabled)](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings)
4. [Ensure Azure File Sync has access to the storage account.](#troubleshoot-rbac)

<a id="-2134364064"></a><a id="cannot-resolve-storage"></a>**The storage account name used could not be resolved.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80C83060 |
| **HRESULT (decimal)** | -2134364064 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_NAME_UNRESOLVED |
| **Remediation required** | Yes |

1. Check that you can resolve the storage DNS name from the server.

    ```powershell
    Test-NetConnection -ComputerName <storage-account-name>.file.core.windows.net -Port 443
    ```

2. [Verify the storage account exists.](#troubleshoot-storage-account)
3. [Verify the firewall and virtual network settings on the storage account are configured properly (if enabled)](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings)

> [!Note]  
> Once network connectivity to the Azure File Sync service is restored, sync might not resume immediately. By default, Azure File Sync will initiate a sync session every 30 minutes if no changes are detected within the server endpoint location. To force a sync session, restart the Storage Sync Agent (FileSyncSvc) service or make a change to a file or directory within the server endpoint location.

<a id="-2134364022"></a><a id="storage-unknown-error"></a>**An unknown error occurred while accessing the storage account.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8308a |
| **HRESULT (decimal)** | -2134364022 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_UNKNOWN_ERROR |
| **Remediation required** | Yes |

1. [Verify the storage account exists.](#troubleshoot-storage-account)
2. [Verify the firewall and virtual network settings on the storage account are configured properly (if enabled)](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings)

<a id="-2134364014"></a>**Sync failed due to storage account locked.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83092 |
| **HRESULT (decimal)** | -2134364014 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_LOCKED |
| **Remediation required** | Yes |

This error occurs because the storage account has a read-only [resource lock](/azure/azure-resource-manager/management/lock-resources). To resolve this issue, remove the read-only resource lock on the storage account.

<a id="-1906441138"></a>**Sync failed due to a problem with the sync database.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x8e5e044e |
| **HRESULT (decimal)** | -1906441138 |
| **Error string** | JET_errWriteConflict |
| **Remediation required** | Yes |

This error occurs when there is a problem with the internal database used by Azure File Sync. When this issue occurs, create a support request and we will contact you to help you resolve this issue.

<a id="-2134364053"></a>**The Azure File Sync agent version installed on the server isn't supported.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80C8306B |
| **HRESULT (decimal)** | -2134364053 |
| **Error string** | ECS_E_AGENT_VERSION_BLOCKED |
| **Remediation required** | Yes |

This error occurs if the Azure File Sync agent version installed on the server isn't supported. To resolve this issue, [upgrade](/azure/storage/file-sync/file-sync-release-notes#azure-file-sync-agent-update-policy) to a [supported agent version](/azure/storage/file-sync/file-sync-release-notes#azure-file-sync-agent-update-policy#supported-versions).

<a id="-2134351810"></a>**You reached the Azure file share storage limit.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8603e |
| **HRESULT (decimal)** | -2134351810 |
| **Error string** | ECS_E_AZURE_STORAGE_SHARE_SIZE_LIMIT_REACHED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80249 |
| **HRESULT (decimal)** | -2134375863 |
| **Error string** | ECS_E_NOT_ENOUGH_REMOTE_STORAGE |
| **Remediation required** | Yes |

Sync sessions fail with either of these errors when the Azure file share storage limit has been reached, which can happen if a quota is applied for an Azure file share or if the usage exceeds the limits for an Azure file share. For more information, see the [current limits for an Azure file share](/azure/storage/files/storage-files-scale-targets?toc=/azure/storage/filesync/toc.json).

1. Navigate to the sync group within the Storage Sync Service.
2. Select the cloud endpoint within the sync group.
3. Note the Azure file share name in the opened pane. Select the file share name to open the file share settings page in the storage account.

    :::image type="content" source="media/file-sync-troubleshoot-sync-errors/cloud-endpoint-detail.png" alt-text="Screenshot showing the cloud endpoint detail pane with a link to the file share.":::

4. Select the file share to get the details on the **Overview** page.
5. Select **Edit quota** to verify the file share quota. Unless an alternate quota has been specified, the quota will match the [maximum size of the Azure file share](/azure/storage/files/storage-files-scale-targets?toc=/azure/storage/filesync/toc.json).

    :::image type="content" source="media/file-sync-troubleshoot-sync-errors/edit-quota.png" alt-text="Screenshot that shows the Azure file share properties." lightbox="media/file-sync-troubleshoot-sync-errors/edit-quota.png":::

If the file share is full (the used capacity equals the quota), free up space on the file share. One possible way of fixing this issue is to make each subfolder of the current server endpoint into its own server endpoint in their own separate sync groups. This way each subfolder will sync to individual Azure file shares.

<a id="-2134351824"></a>**The Azure file share cannot be found.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86030 |
| **HRESULT (decimal)** | -2134351824 |
| **Error string** | ECS_E_AZURE_FILE_SHARE_NOT_FOUND |
| **Remediation required** | Yes |

This error occurs when the Azure file share isn't accessible. To troubleshoot:

1. [Verify the storage account exists.](#troubleshoot-storage-account)
2. [Ensure the Azure file share exists.](#troubleshoot-azure-file-share)
3. Verify the **SMB security settings** on the storage account are allowing **SMB 3.1.1** protocol version, **NTLM v2** authentication and **AES-128-GCM** encryption. To check the SMB security settings on the storage account, see [SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings).

If the Azure file share was deleted, you need to create a new file share and then recreate the sync group.

<a id="-2134364042"></a>**Sync is paused while this Azure subscription is suspended.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80C83076 |
| **HRESULT (decimal)** | -2134364042 |
| **Error string** | ECS_E_SYNC_BLOCKED_ON_SUSPENDED_SUBSCRIPTION |
| **Remediation required** | Yes |

This error occurs when the Azure subscription is suspended. Sync will be reenabled when the Azure subscription is restored. See [Why is my Azure subscription disabled and how do I reactivate it?](/azure/cost-management-billing/manage/subscription-disabled) for more information.

<a id="-2134375618"></a>**The storage account has a firewall or virtual networks configured.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8033e |
| **HRESULT (decimal)** | -2134375618 |
| **Error string** | ECS_E_SERVER_BLOCKED_BY_NETWORK_ACL |
| **Remediation required** | Yes |

This error occurs when the Azure file share is inaccessible because of a storage account firewall or because the storage account belongs to a virtual network. Verify the firewall and virtual network settings on the storage account are configured properly. For more information, see [Configure firewall and virtual network settings](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal%2Cproactive-portal#optional-configure-firewall-and-virtual-network-settings).

<a id="-2134375911"></a>**Sync failed due to a problem with the sync database.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80219 |
| **HRESULT (decimal)** | -2134375911 |
| **Error string** | ECS_E_SYNC_METADATA_WRITE_LOCK_TIMEOUT |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83044 |
| **HRESULT (decimal)** | -2134364092 |
| **Error string** | ECS_E_SYNC_METADATA_WRITE_LOCK_TIMEOUT_SERVICEUNAVAILABLE |
| **Remediation required** | No |

These errors usually resolve themselves and can occur if there are:

- A high number of file changes across the servers in the sync group.
- A large number of errors on individual files and directories.

If this error persists for longer than a few hours, create a support request and we will contact you to help you resolve this issue.

<a id="-2134375905"></a>**The sync database has encountered a storage busy IO error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8021f |
| **HRESULT (decimal)** | -2134375905 |
| **Error string** | ECS_E_SYNC_METADATA_IO_BUSY |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134375906"></a>**The sync database has encountered an IO timeout.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8021e |
| **HRESULT (decimal)** | -2134375906 |
| **Error string** | ECS_E_SYNC_METADATA_IO_TIMEOUT |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134375904"></a>**The sync database has encountered an IO error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80220 |
| **HRESULT (decimal)** | -2134375904 |
| **Error string** | ECS_E_SYNC_METADATA_IO_ERROR |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2147020504"></a>**Sync failed because the data is corrupted and unreadable.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80071128 |
| **HRESULT (decimal)** | -2147020504 |
| **Error string** | ERROR_INVALID_REPARSE_DATA |
| **Remediation required** | Yes |

This error can occur if there is a file system corruption on the NTFS volume where the server endpoint is located. To resolve this error, run [chkdsk](/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer) on the volume.

<a id="-2146762487"></a>**The server failed to establish a secure connection. The cloud service received an unexpected certificate.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x800b0109 |
| **HRESULT (decimal)** | -2146762487 |
| **Error string** | CERT_E_UNTRUSTEDROOT |
| **Remediation required** | Yes |

This error can happen if your organization is using a TLS terminating proxy or if a malicious entity is intercepting the traffic between your server and the Azure File Sync service. If you're certain that this is expected (because your organization is using a TLS terminating proxy), you skip certificate verification with a registry override.

1. Create the `SkipVerifyingPinnedRootCertificate` registry value.

    ```powershell
    New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Azure\StorageSync -Name SkipVerifyingPinnedRootCertificate -PropertyType DWORD -Value 1
    ```

2. Restart the sync service on the registered server.

    ```powershell
    Restart-Service -Name FileSyncSvc -Force
    ```

By setting this registry value, the Azure File Sync agent will accept any locally trusted TLS/SSL certificate when transferring data between the server and the cloud service.

<a id="-2147012721"></a>**Sync failed because the server was unable to decode the response from the Azure File Sync service.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80072f8f |
| **HRESULT (decimal)** | -2147012721 |
| **Error string** | WININET_E_DECODING_FAILED |
| **Remediation required** | Yes |

This error typically occurs if a firewall, proxy, or gateway blocks access to the PKI URL, or if the PKI server is down.

To resolve this issue, ensure that the server can access the following URLs:

- `https://www.microsoft.com/pki/mscorp/cps`
- `http://crl.microsoft.com/pki/mscorp/crl/`
- `http://mscrl.microsoft.com/pki/mscorp/crl/`
- `http://ocsp.msocsp.com`
- `http://ocsp.digicert.com/`
- `http://crl3.digicert.com/`

Once the Azure File Sync agent is installed, the PKI URL is used to download the intermediate certificates required to communicate with the Azure File Sync service and Azure file share. The OCSP URL is used to check the status of a certificate. If the error persists for several days, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

<a id="-2134375680"></a>**Sync failed due to a problem with authentication.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80300 |
| **HRESULT (decimal)** | -2134375680 |
| **Error string** | ECS_E_SERVER_CREDENTIAL_NEEDED |
| **Remediation required** | Yes |

This error typically occurs because the server time is incorrect. If the server is running in a virtual machine, verify the time on the host is correct.

<a id="-2134364040"></a>**Sync failed due to certificate expiration.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83078 |
| **HRESULT (decimal)** | -2134364040 |
| **Error string** | ECS_E_AUTH_SRV_CERT_EXPIRED |
| **Remediation required** | Yes |

This error occurs because the certificate used for authentication is expired.

To confirm the certificate is expired, perform the following steps:

1. Open the Certificates MMC snap-in, select **Computer Account** and navigate to **Certificates (Local Computer)\Personal\Certificates**.
2. Check if the client authentication certificate is expired.

If the client authentication certificate is expired, run the following PowerShell command on the server:

```powershell
Reset-AzStorageSyncServerCertificate -ResourceGroupName <string> -StorageSyncServiceName <string>
```

<a id="-2134375896"></a>**Sync failed due to authentication certificate not found.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80228 |
| **HRESULT (decimal)** | -2134375896 |
| **Error string** | ECS_E_AUTH_SRV_CERT_NOT_FOUND |
| **Remediation required** | Yes |

This error occurs because the certificate used for authentication isn't found.

To resolve this issue, run the following PowerShell command on the server:

```powershell
Reset-AzStorageSyncServerCertificate -ResourceGroupName <string> -StorageSyncServiceName <string>
```

<a id="-2134364039"></a>**Sync failed due to authentication identity not found.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83079 |
| **HRESULT (decimal)** | -2134364039 |
| **Error string** | ECS_E_AUTH_IDENTITY_NOT_FOUND |
| **Remediation required** | Yes |

This error might occur due to the following reasons:

- A new server certificate is generated on the Azure File Sync server, and the old certificate is still cached. This error will be resolved within a few hours once the server cache is refreshed.
- The server endpoint deletion failed, leaving the endpoint in a partially deleted state. To resolve this issue, retry deleting the server endpoint.


<a id="-1906441711"></a><a id="-2134375654"></a><a id="doesnt-have-enough-free-space"></a>**The volume where the server endpoint is located is low on disk space.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x8e5e0211 |
| **HRESULT (decimal)** | -1906441711 |
| **Error string** | JET_errLogDiskFull |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8031a |
| **HRESULT (decimal)** | -2134375654 |
| **Error string** | ECS_E_NOT_ENOUGH_LOCAL_STORAGE |
| **Remediation required** | Yes |

Sync sessions fail with one of these errors because either the volume has insufficient disk space or disk quota limit is reached. This error commonly occurs because files outside the server endpoint are using up space on the volume. Check the available disk space on the server. You can free up space on the volume by adding additional server endpoints, moving files to a different volume, or increasing the size of the volume the server endpoint is on. If a disk quota is configured on the volume using [File Server Resource Manager](/windows-server/storage/fsrm/fsrm-overview) or [NTFS quota](/windows-server/administration/windows-commands/fsutil-quota), increase the quota limit.

If cloud tiering is enabled for the server endpoint, verify the files are syncing to the Azure file share to avoid running out of disk space.

<a id="-2134364145"></a><a id="replica-not-ready"></a>**The service isn't yet ready to sync with this server endpoint.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8300f |
| **HRESULT (decimal)** | -2134364145 |
| **Error string** | ECS_E_REPLICA_NOT_READY |
| **Remediation required** | No |

This error occurs because the cloud endpoint was created with content already existing on the Azure file share. Azure File Sync must scan the Azure file share for all content before allowing the server endpoint to proceed with its initial synchronization. Once change detection completes on the Azure file share, sync will commence. Change detection can take longer than 24 hours to complete and is proportional to the number of files and directories on your Azure file share. If cloud tiering is configured, files will be tiered after sync completes.

<a id="-2134375877"></a><a id="-2134375908"></a><a id="-2134375853"></a>**Sync failed due to problems with many individual files.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8023b |
| **HRESULT (decimal)** | -2134375877 |
| **Error string** | ECS_E_SYNC_METADATA_KNOWLEDGE_SOFT_LIMIT_REACHED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8021c |
| **HRESULT (decimal)** | -2134375908 |
| **Error string** | ECS_E_SYNC_METADATA_KNOWLEDGE_LIMIT_REACHED |
| **Remediation required** | Yes |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80253 |
| **HRESULT (decimal)** | -2134375853 |
| **Error string** | ECS_E_TOO_MANY_PER_ITEM_ERRORS |
| **Remediation required** | Yes |

Sync sessions fail with one of these errors when there are many files that are failing to sync with per-item errors. Perform the steps documented in the [How do I see if there are specific files or folders that are not syncing?](?tabs=portal1%252cazure-portal#how-do-i-see-if-there-are-specific-files-or-folders-that-are-not-syncing) section to resolve the per-item errors. For sync error ECS_E_SYNC_METADATA_KNOWLEDGE_LIMIT_REACHED, please open a support case.

> [!NOTE]
> Azure File Sync creates a temporary VSS snapshot once a day on the server to sync files that have open handles.

<a id="-2134376423"></a>**Sync failed due to a problem with the server endpoint path.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80019 |
| **HRESULT (decimal)** | -2134376423 |
| **Error string** | ECS_E_SYNC_INVALID_PATH |
| **Remediation required** | Yes |

Ensure the path exists, is on a local NTFS volume, and isn't a reparse point or existing server endpoint.

<a id="-2134375817"></a>**Sync failed because the filter driver version isn't compatible with the agent version**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80C80277 |
| **HRESULT (decimal)** | -2134375817 |
| **Error string** | ECS_E_INCOMPATIBLE_FILTER_VERSION |
| **Remediation required** | Yes |

This error occurs because the Cloud Tiering filter driver (StorageSync.sys) version loaded isn't compatible with the Storage Sync Agent (FileSyncSvc) service. If the Azure File Sync agent was upgraded, restart the server to complete the installation. If the error continues to occur, uninstall the agent, restart the server and reinstall the Azure File Sync agent.

<a id="-2134376373"></a>**The service is currently unavailable.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8004b |
| **HRESULT (decimal)** | -2134376373 |
| **Error string** | ECS_E_SERVICE_UNAVAILABLE |
| **Remediation required** | No |

This error occurs because the Azure File Sync service is unavailable. This error will auto-resolve when the Azure File Sync service is available again.

> [!Note]  
> Once network connectivity to the Azure File Sync service is restored, sync might not resume immediately. By default, Azure File Sync will initiate a sync session every 30 minutes if no changes are detected within the server endpoint location. To force a sync session, restart the Storage Sync Agent (FileSyncSvc) service or make a change to a file or directory within the server endpoint location.

<a id="-2146233088"></a>**Sync failed due to an exception.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80131500 |
| **HRESULT (decimal)** | -2146233088 |
| **Error string** | COR_E_EXCEPTION |
| **Remediation required** | No |

This error occurs because sync failed due to an exception. If the error persists for several hours, please create a support request.

<a id="-2134364045"></a>**Sync failed because the storage account has failed over to another region.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83073 |
| **HRESULT (decimal)** | -2134364045 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_FAILED_OVER |
| **Remediation required** | Yes |

This error occurs because the storage account has failed over to another region. Azure File Sync doesn't support the storage account failover feature. Storage accounts containing Azure file shares being used as cloud endpoints in Azure File Sync should not be failed over. Doing so will cause sync to stop working and might also cause unexpected data loss in the case of newly tiered files. To resolve this issue, move the storage account to the primary region.

<a id="-2134375922"></a>**Sync failed due to a transient problem with the sync database.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8020e |
| **HRESULT (decimal)** | -2134375922 |
| **Error string** | ECS_E_SYNC_METADATA_WRITE_LEASE_LOST |
| **Remediation required** | No |

This error occurs because of an internal problem with the sync database. This error will auto-resolve when sync retries. If this error continues for an extend period of time, create a support request, and we will contact you to help you resolve this issue.

<a id="-2134364024"></a>**Sync failed due to change in Microsoft Entra tenant**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83088 |
| **HRESULT (decimal)** | -2134364024 |
| **Error string** | ECS_E_INVALID_AAD_TENANT |
| **Remediation required** | Yes |

Verify you have the latest Azure File Sync agent version installed and give the Microsoft.StorageSync application access to the storage account (see [Ensure Azure File Sync has access to the storage account](#troubleshoot-rbac)).

<a id="-2134364010"></a>**Sync failed due to firewall and virtual network exception not configured**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83096 |
| **HRESULT (decimal)** | -2134364010 |
| **Error string** | ECS_E_MGMT_STORAGEACLSBYPASSNOTSET |
| **Remediation required** | Yes |

This error occurs if the firewall and virtual network settings are enabled on the storage account and the "Allow trusted Microsoft services to access this storage account" exception isn't checked. To resolve this issue, follow the steps documented in the [Configure firewall and virtual network settings](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings) section in the deployment guide.

<a id="-2147024891"></a>**Sync failed with access denied due to security settings on the storage account or NTFS permissions on the server.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80070005 |
| **HRESULT (decimal)** | -2147024891 |
| **Error string** | ERROR_ACCESS_DENIED |
| **Remediation required** | Yes |

This error can occur if Azure File Sync cannot access the storage account due to security settings or if the NT AUTHORITY\SYSTEM account doesn't have permissions to the *System Volume Information* folder on the volume where the server endpoint is located. If individual files are failing to sync with ERROR_ACCESS_DENIED, perform the steps documented in the [Troubleshooting per file/directory sync errors](?tabs=portal1%252cazure-portal#troubleshooting-per-filedirectory-sync-errors) section.

1. Verify the **SMB security settings** on the storage account are allowing **SMB 3.1.1** protocol version, **NTLM v2** authentication and **AES-128-GCM** encryption. To check the SMB security settings on the storage account, see [SMB security settings](/azure/storage/files/files-smb-protocol#smb-security-settings).
2. [Verify the firewall and virtual network settings on the storage account are configured properly (if enabled)](/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal#optional-configure-firewall-and-virtual-network-settings)
3. Verify the **NT AUTHORITY\SYSTEM** account has permissions to the *System Volume Information* folder on the volume where the server endpoint is located by performing the following steps:

    1. Download [Psexec](/sysinternals/downloads/psexec) tool.  
    2. Run the following command from an elevated command prompt to launch a command prompt using the system account: `PsExec.exe -i -s -d cmd`.
    3. From the command prompt running under the system account, run the following command to confirm the NT AUTHORITY\SYSTEM account doesn't have access to the *System Volume Information* folder: `cacls "drive letter:\system volume information" /T /C`.
    4. If the NT AUTHORITY\SYSTEM account doesn't have access to the *System Volume Information* folder, run the following command: `cacls  "drive letter:\system volume information" /T /E /G "NT AUTHORITY\SYSTEM:F"`.

        If step d fails with access denied, run the following command to take ownership of the *System Volume Information* folder and then repeat step d:

        `takeown /A /R /F "drive letter:\System Volume Information"`

<a id="-2134375810"></a>**Sync failed because the Azure file share was deleted and recreated.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8027e |
| **HRESULT (decimal)** | -2134375810 |
| **Error string** | ECS_E_SYNC_REPLICA_ROOT_CHANGED |
| **Remediation required** | Yes |

This error occurs because Azure File Sync doesn't support deleting and recreating an Azure file share in the same sync group.

To resolve this issue, delete and recreate the sync group by performing the following steps:

1. Delete all server endpoints in the sync group.
2. Delete the cloud endpoint.
3. Delete the sync group.
4. If cloud tiering was enabled on a server endpoint, delete the orphaned tiered files on the server by performing the steps documented in the [Tiered files are not accessible on the server](file-sync-troubleshoot-cloud-tiering.md#tiered-files-are-not-accessible-on-the-server) section.
5. Recreate the sync group.

<a id="-2134375852"></a>**Sync detected the replica has been restored to an older state**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80254 |
| **HRESULT (decimal)** | -2134375852 |
| **Error string** | ECS_E_SYNC_REPLICA_BACK_IN_TIME |
| **Remediation required** | No |

No action is required. This error occurs because sync detected the replica has been restored to an older state. Sync will now enter a reconciliation mode, where it recreates the sync relationship by merging the contents of the Azure file share and the data on the server endpoint. When reconciliation mode is triggered, the process can be very time consuming, depending upon the namespace size. Regular synchronization doesn't happen until the reconciliation finishes, and files that are different (last modified time or size) between the Azure file share and server endpoint will result in file conflicts.

<a id="-2145844941"></a>**Sync failed because the HTTP request was redirected**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80190133 |
| **HRESULT (decimal)** | -2145844941 |
| **Error string** | HTTP_E_STATUS_REDIRECT_KEEP_VERB |
| **Remediation required** | Yes |

This error occurs because Azure File Sync doesn't support HTTP redirection (3xx status code). To resolve this issue, disable HTTP redirect on your proxy server or network device.

<a id="-2134364086"></a>**Sync session timeout error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8304a |
| **HRESULT (decimal)** | -2134364086 |
| **Error string** | ECS_E_WORK_FRAMEWORK_TIMEOUT |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83049 |
| **HRESULT (decimal)** | -2134364087 |
| **Error string** | ECS_E_WORK_FRAMEWORK_RESULT_NOT_FOUND |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83093 |
| **HRESULT (decimal)** | -2134364013 |
| **Error string** | ECS_E_WORK_RESULT_EXPIRED |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2146233083"></a>**Operation time out.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80131505 |
| **HRESULT (decimal)** | -2146233083 |
| **Error string** | COR_E_TIMEOUT |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134351859"></a>**Time out error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8600d |
| **HRESULT (decimal)** | -2134351859 |
| **Error string** | ECS_E_AZURE_OPERATION_TIME_OUT |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134375814"></a>**Sync failed because the server endpoint path cannot be found on the server.**  

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8027a |
| **HRESULT (decimal)** | -2134375814 |
| **Error string** | ECS_E_SYNC_ROOT_DIRECTORY_NOT_FOUND |
| **Remediation required** | Yes |

This error occurs if the directory used as the server endpoint path was renamed or deleted. If the directory was renamed, rename the directory back to the original name and restart the Storage Sync Agent service (FileSyncSvc).

If the directory was deleted, perform the following steps to remove the existing server endpoint and create a new server endpoint using a new path:

1. Remove the server endpoint in the sync group by following the steps documented in [Remove a server endpoint](/azure/storage/file-sync/file-sync-server-endpoint-delete).
1. Create a new server endpoint in the sync group by following the steps documented in [Add a server endpoint](/azure/storage/file-sync/file-sync-server-endpoint-create).

<a id="-2134375783"></a>**Server endpoint provisioning failed due to an empty server path.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80C80299 |
| **HRESULT (decimal)** | -2134375783 |
| **Error string** | ECS_E_SYNC_AUTHORITATIVE_UPLOAD_EMPTY_SET |
| **Remediation required** | Yes |

Server endpoint provisioning fails with this error code if these conditions are met:

- This server endpoint was provisioned with the initial sync mode: [server authoritative](/azure/storage/file-sync/file-sync-server-endpoint-create#initial-sync-section)
- Local server path is empty or contains no items recognized as able to sync.

This provisioning error protects you from deleting all content that might be available in an Azure file share. Server authoritative upload is a special mode to catch up a cloud location that was already seeded, with the updates from the server location. Review this [migration guide](/azure/storage/files/storage-files-migration-server-hybrid-databox) to understand the scenario for which this mode has been built.

1. Remove the server endpoint in the sync group by following the steps documented in [Remove a server endpoint](/azure/storage/file-sync/file-sync-server-endpoint-delete).
1. Create a new server endpoint in the sync group by following the steps documented in [Add a server endpoint](/azure/storage/file-sync/file-sync-server-endpoint-create).

<a id="-2134364025"></a>**The subscription owning the storage account is disabled.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83087 |
| **HRESULT (decimal)** | -2134364025 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_SUBSCRIPTION_DISABLED |
| **Remediation required** | Yes |

Please check and ensure the subscription where your storage account resides is enabled.

<a id="64"></a>**The specified network name is no longer available.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80070040 |
| **HRESULT (decimal)** | -2147024832 |
| **Error string** | ERROR_NETNAME_DELETED |
| **Remediation required** | Yes |

Use the `Test-StorageSyncNetworkConnectivity` cmdlet to check network connectivity to the service endpoints. For more information, see [Test network connectivity to service endpoints](/azure/storage/file-sync/file-sync-firewall-and-proxy#test-network-connectivity-to-service-endpoints).

<a id="-2134364147"></a>**Sync session error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8300d |
| **HRESULT (decimal)** | -2134364147 |
| **Error string** | ECS_E_CANNOT_CREATE_ACTIVE_SESSION_PLACEHOLDER_BLOB |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8300e |
| **HRESULT (decimal)** | -2134364146 |
| **Error string** | ECS_E_CANNOT_UPDATE_REPLICA_WATERMARK |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8024a |
| **HRESULT (decimal)** | -2134375862 |
| **Error string** | ECS_E_SYNC_DEFERRAL_QUEUE_RESTART_SESSION |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83098 |
| **HRESULT (decimal)** | -2134364008 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_MGMT_OPERATION_THROTTLED |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83082 |
| **HRESULT (decimal)** | -2134364030 |
| **Error string** | ECS_E_ASYNC_WORK_ACTION_UNABLE_TO_RETRY |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83006 |
| **HRESULT (decimal)** | -2134364154 |
| **Error string** | ECS_E_ECS_BATCH_ERROR |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134363999"></a>**Sync session error.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c830a1 |
| **HRESULT (decimal)** | -2134363999 |
| **Error string** | ECS_TOO_MANY_ETAGVERIFICATION_FAILURES |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8023c |
| **HRESULT (decimal)** | -2134375876 |
| **Error string** | ECS_E_SYNC_CLOUD_METADATA_CORRUPT |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** |  |
| **HRESULT (decimal)** |  |
| **Error string** |  |
| **Remediation required** | Maybe |

If the error persists for more than a day, create a support request.

<a id="-2147024809"></a>**An internal error occurred.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80070057 |
| **HRESULT (decimal)** | -2147024809 |
| **Error string** | ERROR_INVALID_PARAMETER |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80302 |
| **HRESULT (decimal)** | -2134375678 |
| **Error string** | ECS_E_UNKNOWN_HTTP_SERVER_ERROR |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x8004100c |
| **HRESULT (decimal)** | -2147217396 |
| **Error string** | SYNC_E_DESERIALIZATION |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8022d |
| **HRESULT (decimal)** | -2134375891 |
| **Error string** | ECS_E_SYNC_METADATA_UNCOMMITTED_TX_LIMIT_REACHED |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83097 |
| **HRESULT (decimal)** | -2134364009 |
| **Error string** | ECS_E_QUEUE_CLIENT_EXCEPTION |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80245 |
| **HRESULT (decimal)** | -2134375867 |
| **Error string** | ECS_E_EPOCH_CHANGE_DETECTED |
| **Remediation required** | No |

| Error | Code |
|-|-|
| **HRESULT** | 0x80072ef3 |
| **HRESULT (decimal)** | -2147012877 |
| **Error string** | WININET_E_INCORRECT_HANDLE_STATE |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2146233079"></a>**An internal error occurred.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80131509 |
| **HRESULT (decimal)** | -2146233079 |
| **Error string** | COR_E_INVALIDOPERATION |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80070718 |
| **HRESULT (decimal)** | -2147023080 |
| **Error string** | ERROR_NOT_ENOUGH_QUOTA |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80131622 |
| **HRESULT (decimal)** | -2146232798 |
| **Error string** | COR_E_OBJECTDISPOSED |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80004002 |
| **HRESULT (decimal)** | -2147467262 |
| **Error string** | E_NOINTERFACE |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x800700a1 |
| **HRESULT (decimal)** | -2147024735 |
| **Error string** | ERROR_BAD_PATHNAME |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x8007054f |
| **HRESULT (decimal)** | -2147023537 |
| **Error string** | ERROR_INTERNAL_ERROR |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80131501 |
| **HRESULT (decimal)** | -2146233087 |
| **Error string** | COR_E_SYSTEM |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80131620 |
| **HRESULT (decimal)** | -2146232800 |
| **Error string** | COR_E_IO |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80070026 |
| **HRESULT (decimal)** | -2147024858 |
| **Error string** | COR_E_ENDOFSTREAM |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80070554 |
| **HRESULT (decimal)** | -2147023532 |
| **Error string** | ERROR_NO_SUCH_PACKAGE |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x80131537 |
| **HRESULT (decimal)** | -2146233033 |
| **Error string** | COR_E_FORMAT |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x8007001f |
| **HRESULT (decimal)** | -2147024865 |
| **Error string** | ERROR_GEN_FAILURE |
| **Remediation required** | Maybe |

If the error persists for more than a day, create a support request.

<a id="-2147467261"></a>**An internal error occurred.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80004003 |
| **HRESULT (decimal)** | -2147467261 |
| **Error string** | E_POINTER |
| **Remediation required** | Yes |

Please upgrade to the latest file sync agent version. If the error persists after upgrading the agent, create a support request.

<a id="-2147023570"></a>**Operation failed due to an authentication failure.**

| Error | Code |
|-|-|
| **HRESULT** | 0x8007052e |
| **HRESULT (decimal)** | -2147023570 |
| **Error string** | ERROR_LOGON_FAILURE |
| **Remediation required** | Maybe |

| Error | Code |
|-|-|
| **HRESULT** | 0x8007051f |
| **HRESULT (decimal)** | -2147023585 |
| **Error string** | ERROR_NO_LOGON_SERVERS |
| **Remediation required** | Maybe |

If the error persists for more than a day, create a support request.

<a id="-2134351869"></a>**The specified Azure account is disabled.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c86003 |
| **HRESULT (decimal)** | -2134351869 |
| **Error string** | ECS_E_AZURE_ACCOUNT_IS_DISABLED |
| **Remediation required** | Yes |

Please check and ensure the subscription where your storage account resides is enabled.

<a id="-2134364036"></a>**Storage account key based authentication blocked.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8307c |
| **HRESULT (decimal)** | -2134364036 |
| **Error string** | ECS_E_STORAGE_ACCOUNT_KEY_BASED_AUTHENTICATION_BLOCKED |
| **Remediation required** | Yes |

Enable "Allow storage account key access" on the storage account. [Learn more](/azure/storage/file-sync/file-sync-deployment-guide#prerequisites).

<a id="-2134376385"></a>**Sync needs to update the database on the server.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c8003f |
| **HRESULT (decimal)** | -2134376385 |
| **Error string** | ECS_E_SYNC_EPOCH_MISMATCH |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="-2134347516"></a>**The volume is offline. Either it is removed, not ready or not connected.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c87104 |
| **HRESULT (decimal)** | -2134347516 |
| **Error string** | ECS_E_VOLUME_OFFLINE |
| **Remediation required** | Yes |

Please verify the volume where the server endpoint is located is attached to the server.

<a id="-2134364007"></a>**Private endpoint configuration access blocked.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c83099 |
| **HRESULT (decimal)** | -2134364007 |
| **Error string** | ECS_E_PRIVATE_ENDPOINT_ACCESS_BLOCKED |
| **Remediation required** | Yes |

Check the private endpoint configuration and allow access to the file sync service. [Learn more](/azure/storage/file-sync/file-sync-firewall-and-proxy#test-network-connectivity-to-service-endpoints).

<a id="-2134375864"></a>**Sync needs to reconcile the server and Azure file share data before files can be uploaded.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80248 |
| **HRESULT (decimal)** | -2134375864 |
| **Error string** | ECS_E_REPLICA_RECONCILIATION_NEEDED |
| **Remediation required** | No |

No action required. This error should automatically resolve. If the error persists for several days, create a support request.

<a id="0x4c3"></a>**Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed.**

| Error | Code |
|-|-|
| **HRESULT** | 0x800704c3 |
| **HRESULT (decimal)** | -2147023677 |
| **Error string** | ERROR_SESSION_CREDENTIAL_CONFLICT |
| **Remediation required** | Yes |

Disconnect all previous connections to the server or shared resource and try again.

<a id="-2134376368"></a>**The server's SSL certificate is invalid or expired.**

| Error | Code |
|-|-|
| **HRESULT** | 0x80c80050 |
| **HRESULT (decimal)** | -2134376368 |
| **Error string** | ECS_E_SERVER_INVALID_OR_EXPIRED_CERTIFICATE |
| **Remediation required** | Yes |

Run the following PowerShell command on the server to reset the certificate:

`Reset-AzStorageSyncServerCertificate -ResourceGroupName <string> -StorageSyncServiceName <string>`

## Common troubleshooting steps

<a id="troubleshoot-storage-account"></a>**Verify the storage account exists.**

## [Portal](#tab/azure-portal)

1. Navigate to the sync group within the Storage Sync Service.
2. Select the cloud endpoint within the sync group.
3. Note the Azure file share name in the opened pane.

   :::image type="content" source="media/file-sync-troubleshoot-sync-errors/cloud-endpoint-detail.png" alt-text="Screenshot showing the cloud endpoint detail pane with a link to the file share.":::

4. Select the file share name to open the file share settings page in the storage account. If this link fails to open, the referenced storage account has been removed.

## [PowerShell](#tab/azure-powershell)

```powershell
# Variables for you to populate based on your configuration
$region = "<Az_Region>"
$resourceGroup = "<RG_Name>"
$syncService = "<storage-sync-service>"
$syncGroup = "<sync-group>"

# Log into the Azure account
Connect-AzAccount

# Check to ensure Azure File Sync is available in the selected Azure
# region.
$regions = [System.String[]]@()
Get-AzLocation | ForEach-Object { 
    if ($_.Providers -contains "Microsoft.StorageSync") { 
        $regions += $_.Location 
    } 
}

if ($regions -notcontains $region) {
    throw [System.Exception]::new("Azure File Sync is either not available in the " + `
        " selected Azure Region or the region is mistyped.")
}

# Check to ensure resource group exists
$resourceGroups = [System.String[]]@()
Get-AzResourceGroup | ForEach-Object { 
    $resourceGroups += $_.ResourceGroupName 
}

if ($resourceGroups -notcontains $resourceGroup) {
    throw [System.Exception]::new("The provided resource group $resourceGroup does not exist.")
}

# Check to make sure the provided Storage Sync Service
# exists.
$syncServices = [System.String[]]@()

Get-AzStorageSyncService -ResourceGroupName $resourceGroup | ForEach-Object {
    $syncServices += $_.StorageSyncServiceName
}

if ($syncServices -notcontains $syncService) {
    throw [System.Exception]::new("The provided Storage Sync Service $syncService does not exist.")
}

# Check to make sure the provided Sync Group exists
$syncGroups = [System.String[]]@()

Get-AzStorageSyncGroup -ResourceGroupName $resourceGroup -StorageSyncServiceName $syncService | ForEach-Object {
    $syncGroups += $_.SyncGroupName
}

if ($syncGroups -notcontains $syncGroup) {
    throw [System.Exception]::new("The provided sync group $syncGroup does not exist.")
}

# Get reference to cloud endpoint
$cloudEndpoint = Get-AzStorageSyncCloudEndpoint `
    -ResourceGroupName $resourceGroup `
    -StorageSyncServiceName $syncService `
    -SyncGroupName $syncGroup

# Get reference to storage account
$storageAccount = Get-AzStorageAccount | Where-Object { 
    $_.Id -eq $cloudEndpoint.StorageAccountResourceId
}

if ($storageAccount -eq $null) {
    throw [System.Exception]::new("The storage account referenced in the cloud endpoint does not exist.")
}
```

---

<a id="troubleshoot-azure-file-share"></a>**Ensure the Azure file share exists.**

## [Portal](#tab/azure-portal)

1. Select **Overview** on the left-hand table of contents to return to the main storage account page.
2. Select **Files** to view the list of file shares.
3. Verify the file share referenced by the cloud endpoint appears in the list of file shares (you should have noted this in step 1 above).

## [PowerShell](#tab/azure-powershell)

```powershell
$fileShare = Get-AzStorageShare -Context $storageAccount.Context | Where-Object {
    $_.Name -eq $cloudEndpoint.AzureFileShareName -and
    $_.IsSnapshot -eq $false
}

if ($fileShare -eq $null) {
    throw [System.Exception]::new("The Azure file share referenced by the cloud endpoint does not exist")
}
```

---

<a id="troubleshoot-rbac"></a>**Ensure Azure File Sync has access to the storage account.**

## [Portal](#tab/azure-portal)

1. Select **Access control (IAM)** from the left-hand navigation.
1. Select the **Role assignments** tab to list the users and applications (*service principals*) that have access to your storage account.
1. Verify **Microsoft.StorageSync** or **Hybrid File Sync Service** (old application name) appears in the list with the **Reader and Data Access** role.

    :::image type="content" source="media/file-sync-troubleshoot-sync-errors/reader-and-data-access.png" alt-text="Screenshot that shows Hybrid File Sync Service service principal in the access control tab of the storage account.":::

    If **Microsoft.StorageSync** or **Hybrid File Sync Service** doesn't appear in the list, perform the following steps:

    - Select **Add**.
    - In the **Role** field, select **Reader and Data Access**.
    - In the **Select** field, type *Microsoft.StorageSync*, select the role, and then select **Save**.

## [PowerShell](#tab/azure-powershell)

```powershell
$role = Get-AzRoleAssignment -Scope $storageAccount.Id | Where-Object { $_.DisplayName -eq "Microsoft.StorageSync" }

if ($role -eq $null) {
    throw [System.Exception]::new("The storage account does not have the Azure File Sync " + `
                "service principal authorized to access the data within the " + ` 
                "referenced Azure file share.")
}
```

---

## See also

- [Troubleshoot Azure File Sync sync group management](file-sync-troubleshoot-sync-group-management.md)
- [Troubleshoot Azure File Sync agent installation and server registration](file-sync-troubleshoot-installation.md)
- [Troubleshoot Azure File Sync cloud tiering](file-sync-troubleshoot-cloud-tiering.md)
- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files problems](../connectivity/files-troubleshoot.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
