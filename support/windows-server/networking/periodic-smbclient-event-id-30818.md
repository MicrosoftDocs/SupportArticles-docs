---
title: Periodic SMBClient event ID 30818 is logged on Windows Server 2012 R2
description: Resolves an issue in which event ID 30818 is logged when the RDMA connections fail back to TCP. This issue occurs in Windows Server 2012 R2.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: steved, delhan, christys, kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.subservice: networking
---
# Periodic SMBClient event ID 30818 is logged on Windows Server 2012 R2

This article helps resolve an issue in which event ID 30818 is logged when the RDMA connections fail back to TCP. This issue occurs in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3052127

## Symptoms

Assume that a Windows Server 2012 R2-based computer uses an InfiniBand network adapter. This adapter uses the SMB Direct feature to support Remote Direct Memory Access (RDMA) communication between cluster nodes and Hyper-V hosts. After you restart a Hyper-V host, event ID 30818 may be logged under the Applications and Services Logs/Microsoft/Windows/SmbClient path in Event Viewer. When this issue occurs, it may cause performance issues.

## Cause

On Windows Server 2012 R2, the SmbDirect interface is started automatically by the LanmanServer service. However, if the LanmanWorkstation service happens to start first and tries to open an RDMA connection before the SmbDirect is loaded, event ID 30818 will be logged. When the client initially communicates to the server over TCP/IP, new client connections will start to use the RDMA interface. Therefore, no user action is needed to recover.

## Resolution

To work around this problem on Windows Server 2012 R2, the SmbDirect service should be configured to start automatically. To do this, follow these steps:

1. Open Registry Editor, and then locate to the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\smbdirect`

2. Right-click the **Start** registry entry, and then click **Modify**.
3. In the **Value data** box, change the value (by default, it's **3** as on-demand) to **2** (automatic). Then, the event 30818 error should no longer be logged immediately after a restart of the server, unless there's some other problem that prevents the RDMA interface from initializing.

## Status

A change is being considered to resolve this problem in a future version of Windows Server.
