---
title: Troubleshoot ClientOtherErrors in Azure Files
description: Troubleshoot ClientOtherErrors in SMB Azure file shares. ClientOtherErrors are requests that fail, but the system still behaves as expected.
author: khdownie
ms.service: azure-file-storage
ms.date: 09/11/2023
ms.author: kendownie
---

# Troubleshoot ClientOtherErrors in Azure Files

This article lists the ClientOtherErrors you might encounter when using SMB Azure file shares. In general, ClientOtherErrors are mostly harmless and expected errors. Requests fail, but the system continues to behave as expected. It's normal to see a significant amount of these errors logged.

## Applies to

| File share type | SMB | NFS |
|-|:-:|:-:|
| Standard file shares (GPv2), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |
| Standard file shares (GPv2), GRS/GZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |
| Premium file shares (FileStorage), LRS/ZRS | :::image type="icon" source="media/files-troubleshoot-smb-authentication/yes-icon.png" border="false":::  | :::image type="icon" source="media/files-troubleshoot-smb-authentication/no-icon.png" border="false"::: |

## What are ClientOtherErrors?

ClientOtherError usually means expected client-side errors, such as **not found** and **resource already exists**. In the server-side storage log files, these operations are recorded with a transaction status of ClientOtherErrors.

For example, the Windows SMB client that interacts with remote file systems doesn't always know the capabilities of the remote file system. It could be a Windows Server, Azure Files, or some other SMB server implementation. Because of this, the SMB client will make calls to the remote file server with certain APIs. If these APIs fail, it will fall back to using a different API or even just ignore these errors. Depending on the request/response protocol of SMB, it's expected that a large amount of requests will fail even though the system has behaved correctly. This can be due to authorization failure, trying to create a file with a name that already exists, or trying to open a file that doesn't exist.

## Logging and reporting

To troubleshoot ClientOtherErrors, you can create a diagnostic setting and use [Azure Monitor](/azure/storage/files/storage-files-monitoring) for reporting. You can also [analyze logs](/azure/storage/files/analyze-files-metrics?tabs=azure-portal#analyze-logs) to view failed requests, including ClientOtherErrors, or [use Kusto queries](/azure/storage/files/analyze-files-metrics?tabs=azure-portal#sample-kusto-queries).

You can also collect a [ProcMon trace](/sysinternals/downloads/procmon) from a client that matches the IP address shown in logs. Add a filter to only see traffic to Azure Files.

## Common ClientOtherErrors

The following table lists common ClientOtherErrors, along with an explanation of each.

| **Operation** | **Status** | **Explanation of error** |
|-----------|--------|----------------------|
| QueryFullEaInformation | STATUS_NOT_IMPLEMENTED | This failure is returned because Azure Files doesn't implement this API. Azure Files [doesn't support](https://docs.microsoft.com/rest/api/storageservices/features-not-supported-by-the-azure-file-service) extended attributes currently. |
| UnknownFileClass=48 | STATUS_NOT_SUPPORTED | This is the `FileNormalizedNameInformation` API call. This is new support for Windows Server, and currently Azure Files doesn't support this API. |
| FileOpen | 492 STATUS_ACCESS_DENIED | The caller doesn't have permission needed to open the file. In the case of Kerberos access, the ACL denies the caller access. |
| FileOpen | 257 STATUS_OBJECT_NAME_INVALID | The path for the open request is invalid, for example too long or too deep. |
| FileOpen | 12 STATUS_FILE_IS_ADIRECTORY | The caller is opening a directory without using correct CreateFile parameters (for example, Backup intent). |
| FileOpen | 8 STATUS_SHARING_VIOLATION | The caller is opening a file that is already open with restrictions (for example exclusive, others can only read, etc.) |
| FileOpen | 6 STATUS_OBJECT_NAME_NOT_FOUND | The caller is opening a file that doesn't exist. |
| FSCTL_QUERY_NETWORK_INTERFACE_INFO (IOCTL) | STATUS_INVALID_DEVICE_REQUEST | This is used for Azure Files only when customer has enabled the **multichannel** feature. In other cases, it's not needed, and we return an invalid device request when queried from client. |
| QueryStreamInformation | STATUS_NOT_IMPLEMENTED | Some file systems have the concept of [alternate data streams](/windows/win32/fileio/file-streams?redirectedfrom=MSDN#stream-types) or other streams like reparse point stream. Azure Files doesn't have this concept, so we don't support the API. |
| Unexpected (IOCTL) | STATUS_INVALID_DEVICE_REQUEST | This is `FSCTL_QUERY_FILE_REGIONS`, a [region concept](/openspecs/windows_protocols/ms-fscc/4630b33f-a955-4ce0-91b6-fd4ba4aac1ce) that's specific to NTFS/refs and doesn't make sense in relation to Azure Files. So we don't implement this FSCTL code. |
| ChangeNotify | STATUS_CANCELLED | Applications like Windows shell explorer subscribe to change notifications for files. This way when properties change on a file, Windows Explorer automatically updates in the view. The client can choose to cancel this subscription (for example if the user has changed views in Explorer and no longer needs it). In that case, we send back to client `STATUS_CANCELLED` to acknowledge that the subscription has been cancelled. |
| FSCTL_DFS_GET_REFERRALS (IOCTL) | STATUS_FS_DRIVER_REQUIRED | This is a DFS referral request. Azure Files doesn't support DFS, and this is the correct status to return when the system doesn't support DFS. |
| FileSupersede | STATUS_ACCESS_DENIED | File supersede is an operation where an existing file is deleted and a new file is put in its place. If the caller doesn't have permission to delete the existing file, the call will fail. |
| FileCreate | 7 STATUS_OBJECT_NAME_INVALID | This happens when a request to create a new file has a requested name that is invalid (unsupported characters, etc.). |
| FileCreate | 3 STATUS_OBJECT_NAME_COLLISION | This happens when a request to create a new file has a requested name that matches an existing file. |
| Read | STATUS_ACCESS_DENIED | This happens when a read request is done on a file with a handle that doesn't have the granted access of **read** (it was open with write desired access, etc.) |
| TreeConnect | STATUS_ACCESS_DENIED | In the context of Kerberos authentication, the caller doesn't have share-level permissions assigned via RBAC or the **Default Share Permissions** feature. If DefaultSharePermissions feature isn't set, callers who are computer identities will consistently get this access failure on the share. |

## Need help?

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your problem resolved quickly.

## See also

- [Troubleshoot Azure Files](files-troubleshoot.md)
- [Monitor Azure Files](/azure/storage/files/storage-files-monitoring)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)
