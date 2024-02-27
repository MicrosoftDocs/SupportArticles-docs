---
title: Fail to access shared folder from applications
description: When a shared folder on a Windows Server 2008 R2-based server is accessed from an application in Windows Server 2012, errors other than ERROR_ACCESS_DENIED are returned.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Unexpected errors are returned when a shared folder is accessed from an application

This article provides a solution to unexpected errors that occur when you access a shared folder from an application.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2990989

## Symptoms

Consider the following scenario:

- You create a shared folder in Windows Server 2008 R2 and then grant User A Read permission for the folder.
- You create a subfolder on the shared folder, disable inheritable permissions from the subfolder's parent folder, and do not grant User A Read permission for the subfolder.
- You log on to a Windows Server 2012-based server as User A and then run an application that calls FindFirstFile for the shared folder.

In this scenario, the application fails. Additionally, error ERROR_ACCESS_DENIED is not returned as expected. Instead, one of the following error codes is returned:

An unexpected network error occurred. (ERROR_UNEXP_NET_ERR)

The parameter is incorrect. (ERROR_INVALID_PARAMETER)

If the application that you are running assumes that ERROR_ACCESS_DENIED is returned in this situation to signal that it does not have the appropriate access right, it is possible that this assumption is incorrect.

## Cause

This issue occurs because a kernel-mode SMB component returns STATUS_UNEXPECTED_NETWORK_ERROR in a situation in which an I/O should fail with STATUS_ERROR_ACCESS_DENIED. Simultaneously, the SMB component requests I/O in another thread. This thread can return STATUS_INVALID_PARAMETER.

These NT statuses that the SMB component returns are translated to one of the following Win32 errors when the NT statuses are handed to the file or folder APIs:

- ERROR_UNEXP_NET_ERR
- ERROR_INVALID_PARAMETER 

## Resolution

If an application assumes that ERROR_ACCESS_DENIED is returned in this situation to determine whether it has the appropriate access right and receives ERROR_UNEXP_NET_ERR or ERROR_INVALID_PARAMETER when it accesses the subfolder of the shared folder without any access right, it can avoid this issue by doing the same processing as when it receives ERROR_ACCESS_DENIED.

## More information

When the subfolder is being opened, the client redirector in Windows Server 2012 sends two SMB packets. One packet is a "create" packet and the other is a "query directory" packet. The create packet opens the directory, and the query directory packet enables the redirector to determine information about the subfolder so that it can handle the subfolder correctly. The create packet fails with STATUS_ACCESS_DENIED. But after that, the query directory packet also fails with STATUS_UNEXPECTED_NETWORK_ERROR. Therefore, there are two error codes. Because the query directory action occurred after the create, the query directory error code is returned.

Even if the design of Windows was changed so that ERROR_ACCESS_DENIED could be returned, the application that accesses a network share could still receive ERROR_UNEXP_NET_ERR because an actual network error might occur, such as a server crash, a loss of network power, and so on.

Also be aware that there is a difference between I/O to local drives and I/O to network file shares. Although the APIs (CreateFile, ReadFile, FindFirstFile, and so on) that the application uses are all the same, the storage system that does the work is different. When an application accesses a local file, the API creates an IRP and sends this to the file system driver (NTFS.SYS), and the I/O request eventually is sent to the disk drivers. When an application accesses a network share, the API invokes a client/server network protocol. The API sends the request to the client redirector, and then the client redirector makes an SMB packet and sends the SMB packet to the server. The server's service receives the packet and then performs the I/O operation. After the I/O operation is complete, the server's service sends a response SMB packet back to the client redirector, and the client redirector returns to the application.

Because of these differences, the API can return different kinds of errors. For local files, the API will not return networking errors. For networked files, the API can return file access errors like ERROR_ACCESS_DENIED and network errors like ERROR_UNEXP_NET_ERR because either kind of error can occur on a network. This behavior is by design and is documented in the Microsoft Developer Network (MSDN) Library in the following two locations:

[Differences in Local and Network I/O](https://msdn.microsoft.com/library/windows/desktop/aa363942%28v=vs.85%29.aspx)

[Description of a Network I/O Operation](https://msdn.microsoft.com/library/windows/desktop/aa363936%28v=vs.85%29.aspx)
