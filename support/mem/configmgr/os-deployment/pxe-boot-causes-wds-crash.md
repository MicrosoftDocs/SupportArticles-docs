---
title: PXE boot causes WDS to crash
description: Describes an issue that Windows Deployment Services (WDS) crashes during PXE boot and provides a workaround.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Configuration Manager PXE boot causes Windows Deployment Services to crash

This article provides workarounds to solve the Windows Deployment Services (WDS) crash that is caused by Pre-Boot Execution Environment (PXE) boot in a Configuration Manager environment.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3046055

## Symptoms

You use a Pre-Boot Execution Environment (PXE) distribution point to perform PXE boots. In this situation, the operation first appears to work successfully, but then the process stops running. When you examine the server on which the PXE distribution point and WDS are installed, you discover that WDS has crashed.

Restarting WDS on the server doesn't resolve the issue. When you restart both the Windows Management Instrumentation and WDS, or when you restart the server itself, it may temporarily resolve the problem. However, the issue eventually recurs, and WDS crashes again.

If you try to reproduce the issue by continuing to perform PXE boots, you discover that although the issue may occur frequently, it cannot be reproduced on a consistent basis. The crash behavior occurs randomly.

## Cause

This issue may occur in environments where there are redundant backup routers. If IP Helpers for PXE (DHCP relays) are positioned on both the primary and backup routers, it may cause a situation where two duplicate PXE request packets are sent to WDS: the original PXE request by the primary router and a duplicate PXE request by the backup, redundant router.

If the timing is just right, the duplicate PXE request may overwrite some of the information in WDS from the original PXE request. This issue causes information in WDS for the PXE request to become corrupted, and then WDS crashes.

## Workaround

To work around the issue, use one of these methods:

- Disable the PXE IP Helpers in the backup, redundant router so that duplicate PXE requests are not sent. For more information about PXE IP Helpers, see [Configuring your router to forward broadcasts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732351(v=ws.10)).
- Configure the Configuration Manager WDS provider to be single-threaded instead of multithreaded. This configuration will limit WDS processing of PXE requests to one at a time and will prevent the second, duplicate PXE request from conflicting with the original request. To configure the Configuration Manager WDS provider for single-threading, create the `NumberOfThreads` registry key with a DWORD value of **1** in the following location:

    Configuration Manager 2012 DP/WDS server: `HKEY_LOCAL_MACHINE\Software\Microsoft\SMS\DP`

    Doing this configuration does not typically affect server performance for PXE requests except in environments where a large number of PXE requests are performed on a consistent basis. In these environments, we recommend that you use the first workaround.
