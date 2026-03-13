---
title: Troubleshoot ClientOtherErrors in Azure Files
description: Troubleshoots ClientOtherErrors in SMB Azure file shares. ClientOtherErrors are requests that fail, but the system still behaves as expected.
ms.service: azure-file-storage
ms.date: 12/12/2025
ms.reviewer: kendownie, v-weizhu
ms.custom: sap:Security
---

# Troubleshoot ClientOtherErrors in Azure Files

**Applies to:** :heavy_check_mark: SMB Azure file shares

This article lists the ClientOtherErrors you might encounter when using SMB Azure file shares. In general, ClientOtherErrors are mostly harmless and expected errors. Requests fail, but the system continues to behave as expected. It's normal to see a significant amount of these errors logged.

## What are ClientOtherErrors?

ClientOtherError usually means expected client-side errors, such as "not found" and "resource already exists." In the server-side storage log files, these operations are recorded with a transaction status of ClientOtherErrors.

For example, the Windows SMB client that interacts with remote file systems doesn't always know the capabilities of the remote file system. It could be Windows Server, Azure Files, or some other SMB server implementation. Therefore, the SMB client will make calls to the remote file server with certain APIs. If these APIs fail, it will fall back to using a different API or even just ignore these errors. Depending on the request/response protocol of SMB, a large number of requests are expected to fail even though the system has behaved correctly. This can be due to authorization failures, attempts to create a file with a name that already exists, or attempts to open a file that doesn't exist.

## Logging and reporting

To troubleshoot ClientOtherErrors, you can create a diagnostic setting and use [Azure Monitor](/azure/storage/files/storage-files-monitoring) for reporting. You can also [analyze logs](/azure/storage/files/analyze-files-metrics?tabs=azure-portal#analyze-logs) to view failed requests, including ClientOtherErrors, or [use Kusto queries](/azure/storage/files/analyze-files-metrics?tabs=azure-portal#sample-kusto-queries).

You can also collect a [ProcMon trace](/sysinternals/downloads/procmon) from a client that matches the IP address shown in the logs. Add a filter to see only traffic to Azure Files.

## Query ClientOtherErrors in Log Analytics

Once you've enabled diagnostic logging for your storage account, you can query for specific ClientOtherErrors using Log Analytics. ClientOtherErrors are logged with a `StatusText` that starts with "ClientOtherError" and includes the specific error code.

### Query to view ClientOtherErrors

```kusto
StorageFileLogs
| where StatusText startswith "ClientOtherError"
| project TimeGenerated, StatusText, StatusCode, OperationName, Uri, CallerIpAddress
| order by TimeGenerated desc
```

### Query to count errors by type

```kusto
StorageFileLogs
| where StatusText startswith "ClientOtherError"
| summarize Count = count() by StatusText, OperationName
| order by Count desc
```

## Common ClientOtherError codes and explanations

The following table maps specific error codes to their explanations. These errors appear in the `StatusText` field as "ClientOtherError;[ErrorCode];[ErrorName]" (for example, "ClientOtherError;492;STATUS_ACCESS_DENIED").

| **Operation** | **Status Code** | **Status Name** | **Explanation of error** |
|-----------|--------|--------|----------------------|
| QueryFullEaInformation | 0xC00000BB | STATUS_NOT_IMPLEMENTED | This failure is returned because Azure Files doesn't implement this API. Azure Files [doesn't support](/rest/api/storageservices/features-not-supported-by-the-azure-file-service) extended attributes currently. |
| UnknownFileClass=48 | 0xC00000BB | STATUS_NOT_SUPPORTED | This is the `FileNormalizedNameInformation` API call. This is new support for Windows Server, and currently Azure Files doesn't support this API. |
| FileOpen | 0xC0000022 (492) | STATUS_ACCESS_DENIED | The caller doesn't have the required permissions to open the file. In the case of Kerberos access, the ACL denies the caller access. |
| FileOpen | 0xC0000033 (257) | STATUS_OBJECT_NAME_INVALID | The path for the open request is invalid (for example, the path is too long or too deep). |
| FileOpen | 0xC00000BA (12) | STATUS_FILE_IS_ADIRECTORY | The caller is opening a directory without using the correct `CreateFile` parameters (for example, Backup intent). |
| FileOpen | 0xC0000043 (8) | STATUS_SHARING_VIOLATION | The caller is opening a file that's already opened with restrictions (for example, exclusive or others can only read). |
| FileOpen | 0xC0000034 (6) | STATUS_OBJECT_NAME_NOT_FOUND | The caller is opening a file that doesn't exist. |
| FSCTL_QUERY_NETWORK_INTERFACE_INFO (IOCTL) | 0xC0000010 | STATUS_INVALID_DEVICE_REQUEST | This is used only for Azure Files when customers have enabled the *multichannel* feature. In other cases, it's not needed, and we return an invalid device request when queried from the client. |
| QueryStreamInformation | 0xC00000BB | STATUS_NOT_IMPLEMENTED | Some file systems have the concept of [alternate data streams](/windows/win32/fileio/file-streams?redirectedfrom=MSDN#stream-types) or other streams like reparse point stream. Azure Files doesn't have this concept, so we don't support the API. |
| Unexpected (IOCTL) | 0xC0000010 | STATUS_INVALID_DEVICE_REQUEST | This is `FSCTL_QUERY_FILE_REGIONS`, a [region concept](/openspecs/windows_protocols/ms-fscc/4630b33f-a955-4ce0-91b6-fd4ba4aac1ce) that's specific to NTFS/refs and doesn't make sense in relation to Azure Files. For this reason, we don't implement this FSCTL code. |
| ChangeNotify | 0xC0000120 | STATUS_CANCELLED | Applications like Windows Shell Explorer subscribe to change notifications for files. This way, when properties change on a file, Windows Shell Explorer automatically updates in the view. The client can choose to cancel this subscription (for example, if the user has changed views in Explorer and no longer needs it). In that case, we send `STATUS_CANCELLED` back to the client to acknowledge that the subscription has been canceled. |
| FSCTL_DFS_GET_REFERRALS (IOCTL) | 0xC000019C | STATUS_FS_DRIVER_REQUIRED | This is a DFS referral request. Azure Files doesn't support DFS, and this is the correct status to return when the system doesn't support DFS. |
| FileSupersede | 0xC0000022 | STATUS_ACCESS_DENIED | File supersede is an operation where an existing file is deleted and a new file is put in its place. If the caller doesn't have permission to delete the existing file, the call will fail. |
| FileCreate | 0xC0000033 (7) | STATUS_OBJECT_NAME_INVALID | This happens when a request to create a new file has an invalid requested name (for example, using unsupported characters). |
| FileCreate | 0xC0000035 (3) | STATUS_OBJECT_NAME_COLLISION | This happens when a request to create a new file has a requested name that matches an existing file. |
| Read | 0xC0000022 | STATUS_ACCESS_DENIED | This happens when a read request is done on a file with a handle that doesn't have the granted access of **read** (for example, the file was opened with the desired write access). |
| TreeConnect | 0xC0000022 | STATUS_ACCESS_DENIED | In the context of Kerberos authentication, the caller doesn't have share-level permissions assigned via RBAC or a default share-level permission. Computer identities will consistently get this access failure on the share if a share-level permission isn't set. |

## Query examples for common scenarios

The following are some examples of common Kusto queries that might be useful.

### Authentication and permission failures

```kusto
StorageFileLogs
| where StatusText has "STATUS_ACCESS_DENIED"
| where OperationName in ("FileOpen", "TreeConnect", "Read", "FileSupersede")
| project TimeGenerated, OperationName, Uri, CallerIpAddress, AuthenticationType, RequesterUpn
| order by TimeGenerated desc
```

### File not found errors

```kusto
StorageFileLogs
| where StatusText has "STATUS_OBJECT_NAME_NOT_FOUND"
| project TimeGenerated, Uri, CallerIpAddress, OperationName
| order by TimeGenerated desc
```

### Invalid file operations such as naming, paths, and sharing violations

```kusto
StorageFileLogs
| where StatusText has_any ("STATUS_OBJECT_NAME_INVALID", "STATUS_SHARING_VIOLATION", "STATUS_OBJECT_NAME_COLLISION")
| project TimeGenerated, StatusText, OperationName, Uri, CallerIpAddress
| order by TimeGenerated desc
```

### Top clients generating ClientOtherErrors

```kusto
StorageFileLogs
| where StatusText startswith "ClientOtherError"
| summarize ErrorCount = count() by CallerIpAddress, bin(TimeGenerated, 1h)
| order by ErrorCount desc
```

## See also

- [SMB Error Classes and Codes](/openspecs/windows_protocols/ms-smb/6ab6ca20-b404-41fd-b91a-2ed39e3762ea)
- [Troubleshoot Azure Files](../connectivity/files-troubleshoot.md)
- [Monitor Azure Files](/azure/storage/files/storage-files-monitoring)

 
