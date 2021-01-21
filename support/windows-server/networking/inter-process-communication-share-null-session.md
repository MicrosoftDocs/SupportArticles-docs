---
title: IPC$ share and null session behavior
description: Describes the IPC$ share in Windows 7.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Access to remote file shares (SMB or DFS Namespace)
ms.technology: networking
---
# IPC$ share and null session behavior in Windows

This article describes the inter-process communication share (IPC$) and null session behavior in Windows.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3034016

## About IPC$ share

The IPC$ share is also known as a null session connection. By using this session, Windows lets anonymous users perform certain activities, such as enumerating the names of domain accounts and network shares.

The IPC$ share is created by the Windows Server service. This special share exists to allow for subsequent named pipe connections to the server. The server's named pipes are created by built-in operating system components and by any applications or services that are installed on the system. When the named pipe is being created, the process specifies the security that is associated with the pipe, and then makes sure that access is only granted to the specified users or groups.

## Configure anonymous access by using network access policy settings

In Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2, the IPC$ share cannot be managed or restricted. However, an administrator has controls over any named pipes that were enabled so that they can be accessed anonymously by using the [Network access: Named Pipes that can be accessed anonymously](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/jj852278(v=ws.10)) security policy setting. If the policy setting is configured to have no entries (such as a Null value), no named pipes can be accessed anonymously, and you have to make sure that no applications or services in the environment rely on anonymous access to any named pipes on the server.

Although Windows Server 2003 no longer prevents anonymous access to IPC$ share, there is a [Network access: Let Everyone permissions apply to anonymous users](/previous-versions/windows/it-pro/windows-server-2003/cc778182(v=ws.10)) security policy setting that defines whether the Everyone group is added to an anonymous session. If this setting is disabled, the only resources that can be accessed by an anonymous user are those that are granted to the Anonymous Logon group.

Additionally, in Windows Server 2012 or a later Windows Server-based operating system, there is a feature to determine whether anonymous sessions should be enabled on file servers. It is determined by checking if any pipes or shares are marked for remote access.
