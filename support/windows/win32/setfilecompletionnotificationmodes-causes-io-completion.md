---
title: An API causes an I/O not work correctly
description: This article provides resolutions for the problem that a non-IFS LSP does not correctly support an I/O completion port when the user changes notification modes by using SetFileCompletionNotificationModes.
ms.date: 09/24/2020
ms.custom: sap:Networking Development
ms.reviewer: khorton, osmaner
ms.technology: windows-dev-apps-networking-dev
---
# SetFileCompletionNotificationModes API causes an I/O completion port not to work correctly if a non-IFS LSP is installed

This article helps you resolve the problem that a non-IFS LSP does not correctly support an I/O completion port when the user changes notification modes by using `SetFileCompletionNotificationModes`.

_Original product version:_ &nbsp; Windows 7 Enterprise, Windows 7 Home Basic, Windows 7 Home Premium, Windows 7 Ultimate  
_Original KB number:_ &nbsp; 2568167

## Symptoms

Some applications may conflict with non-IFS Winsock Base Service Providers (BSPs) or Layered Service Providers (LSPs). An application creates an I/O completion port and associates it with a socket, and calls SetFileCompletionNotificationModes  with the `FILE_SKIP_COMPLETION_PORT_ON_SUCCESS` flag on the socket handle. For any subsequent asynchronous Winsock calls on that socket that have an `OVERLAPPED` structure passed, the application will not experience completions for this Winsock function calls over the associated I/O completion port.

> [!NOTE]
> This issue affects only applications that run in Windows Vista and higher version because this new IOCP flag (`FILE_SKIP_COMPLETION_PORT_ON_SUCCESS`) was added in Vista.

## Cause

Non-IFS Winsock BSPs or LSPs are not compatible with the `FILE_SKIP_COMPLETION_PORT_ON_SUCCESS`  flag. The incompatibility results in any asynchronous Winsock calls that are used by the socket and have `OVERLAPPED` passed not to work correctly when non-IFS Winsock BSPs or LSPs have been installed. All Winsock BSPs supplied by Microsoft use IFS handles and third-party BSPs are uncommon. So this problem is caused primarily by having non-IFS LSPs installed.

## Resolution

To resolve this problem, use one of the following methods:

- Do not specify the `FILE_SKIP_COMPLETION_PORT_ON_SUCCESS` flag.
- Remove any installed non-IFS Winsock LSPs.
- Move from a non-IFS LSP to Windows Filter Platform (WFP).

## More information

To determine whether a non-IFS BSP or LSP is installed, use the `netsh WinSock Show Catalog` command, and examine every Winsock Catalog Provider Entry item that is returned. If the Service Flags value has the 0x20000  bit set, the provider uses IFS handles and will work correctly. If the 0x20000 bit is clear (not set), it is a non-IFS BSP or LSP. To programmatically determine whether a non-IFS BSP or LSP is installed, enumerate the available protocols by using the WSCEnumerateProtocols  function. Then, in each returned `WSAPROTOCOL_INFO` structure, check the `dwServiceFlag1` member to see whether the `XP1_IFS_HANDLES` flag (0x20000) is set. The Windows SDK documentation for the `WSCEnumProtocols` function includes source code for an example program that shows how to do this.

> [!NOTE]
> - The Service Flags value was introduced in the netsh command in Windows 7 and Windows Server 2008 R2. Therefore, using the netsh command to check this value doesn't work in Windows Vista or Windows Server 2008.
> - The `WSCEnumerateProtocols` function can be used to retrieve `WSAPROTOCOL_INFOW` structures and the `dwServiceFlag1` member to discover whether IFS/non-IFS BSPs or LSPs are installed. The `WSCEnumerateProtocols` function is supported in Windows 2000 and higher versions.
