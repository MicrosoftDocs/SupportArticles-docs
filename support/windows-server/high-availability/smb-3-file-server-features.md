---
title: New SMB file server 3.0 features
description: Describes new features in the next version of the Server Message Block (SMB) protocol, SMB 3.0. Windows Server introduced SMB 3.0.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Clustering and High Availability\Cannot failover a group, csstroubleshoot
---
# New SMB 3.0 features in the Windows Server file server

This article describes new features of the Server Message Block (SMB) 3.0 protocol.

_Applies to:_ &nbsp; Windows 8.1 - all editions, Windows Server 2012 R2 and later versions of Windows  
_Original KB number:_ &nbsp; 2709568

## Summary

Windows Server introduces new server message block (SMB) file server features. To take advantage of these new features, the SMB client and SMB server must support SMB 3.0.

The SMB 2.x protocol was introduced in Windows Server 2008 and in Windows Vista.

The SMB 3.0 protocol was introduced in Windows Server 2012 and in Windows 8.

## New SMB features introduced in the Windows file server

- SMB Transparent Failover
- SMB Scale Out
- SMB Multichannel
- SMB Direct
- SMB Encryption
- VSS for SMB file shares
- SMB Directory Leasing
- SMB PowerShell

### SMB Transparent Failover

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the SMB Transparent Failover functionality.

SMB 1.0- and SMB 2.x-capable clients will be able to connect to, and access, shares that are configured to use the Continuously Available property. However, SMB 1.0 and SMB 2.x clients won't benefit from the SMB Transparent Failover feature. If the currently accessed cluster node becomes unavailable, or if the administrator makes administrative changes to the clustered file server, the SMB 1.0 or SMB 2.x client will lose the active SMB session and any open handles to the clustered file server. The user or application on the SMB client computer must take corrective action to reestablish connectivity to the clustered file share.

> [!NOTE]
> SMB Transparent Failover is incompatible with volumes enabled for short file name (8.3 file name) support or with compressed files (such as NTFS-compressed files).

### SMB Scale Out

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the SMB Scale Out feature.

SMB 1.0 clients don't contain the required client functionality to access SMB scale-out file shares and will receive an **Access Denied** error message when they try to connect to a scale-out file share.

SMB scale-out file shares are always configured so that the Continuously Available property is set. SMB 2.x clients will be able to connect to SMB scale-out file shares but won't benefit from the SMB Transparent Failover functionality.

### SMB Multichannel

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the SMB Multichannel functionality. SMB 1.0 and SMB 2.x clients will use a single SMB connection.

### SMB Direct (SMB over Remote Direct Memory Access [RDMA])

SMB Direct is available in Windows Server 2012, Windows 10 (Enterprise, Education, and Pro for Workstations editions), and later versions. SMB Direct Functionality requires that the SMB client and SMB server support SMB 3.0.

### SMB Encryption

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the SMB Encryption functionality.

### VSS for SMB file shares

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the Volume Shadow Copy Service (VSS) for SMB file shares functionality.

### SMB Directory Leasing

Both the SMB client and SMB server must support SMB 3.0 to take advantage of the SMB Directory Leasing functionality.

### SMB PowerShell

SMB PowerShell management cmdlets were introduced in Windows Server 2012 and in Windows 8. Older SMB clients and SMB servers will have to continue using down-level tools for management (for example, *net.exe*) and APIs (for example, Win32 APIs).

## References

For more information about the common errors you may experience with SMB 3.0, see [/troubleshoot/windows-server/networking/error-messages-smb-connections](https://support.microsoft.com/help/2686098).
