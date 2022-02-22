---
title: Guidance of troubleshooting SMB
description: Introduces general guidance of troubleshooting scenarios related to SMB.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:smb, csstroubleshoot
ms.technology: networking
---
# SMB troubleshooting guidance

This article is designed to help you troubleshooting Server Message Block (SMB) issues. Most users are able to resolve their issue by using the solutions that are provided here.

## Introduction of SMB

Communicating correct terminology is a key aspect of quality SMB troubleshooting. Therefore, you should learn basic SMB terminology to ensure accuracy of data collection and analysis.

- SMB Server (SRV) is always the system that hosts the file system, also called the file server.
- SMB Client (CLI) is always the system that tries to access the file system.
- These terms are consistent regardless of the OS version or edition. For example, if a Windows Server 2016-based computer tries to reach the SMB share *\\\\MyWorkstation\\Data* on a Windows 10-based computer, Windows Server 2016 is the SMB Client and Windows 10 is the SMB Server.

## Troubleshooting checklist

- The SMBv1 network protocol is no longer installed by default.
- [Disable SMBv1](/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3#how-to-remove-smbv1).
- If SMBv1 is disabled on a device that supports only SMBv1, you cannot access that device. In this situation, upgrade your system.
- You cannot disable SMBv2 or SMBv3 separately because these versions are part of the same driver.
- Analyze the traffic: SMB is an application-level protocol that uses TCP/IP as the network transport protocol. Therefore, an SMB issue can actually be caused by TCP/IP issues.
- Analyze the protocol: Look at the actual SMB protocol details in the network trace to understand the exact commands and options that are used.
- Update SMB-related system files: Keep the system files updated. Make sure that the latest [update rollup](https://support.microsoft.com/help/4498140/windows-10-update-history) is installed.

## SMB file information

SMB Client binaries that are listed under *%windir%\\system32\\Drivers*:

- RDBSS.sys
- MRXSMB.sys
- MRXSMB10.sys
- MRXSMB20.sys
- MUP.sys
- SMBdirect.sys

SMB Server binaries that are listed under *%windir%\\system32\\Drivers*:

- SRVNET.sys
- SRV.sys
- SRV2.sys
- SMBdirect.sys
- Under *%windir%\\system32*
- srvsvc.dll

We recommend that you update the following components before you troubleshoot SMB issues:

- iSCSI: A file server requires file storage. If your storage has iSCSI components, update those components.
- Network: Update the network components.
- WIndows Core: For better performance and stability, update Windows Core.

## Common issues and solutions

### Issue 1

When you access a Scale-Out File Server, performance is limited.

Cause: The client access network uses high speed RDMA, but the cluster network does not. This causes redirection to occur only over the cluster network (which is usually a 1 GbE network adapter).

Troubleshooting: You can configure the option to use the client access network for Cluster Shared Volumes (CSV). Or, upgrade to Windows Server 2012 R2. That system automatically redirects clients to the cluster node that has the best access to the volume that's used by the file share. For more information, see the following blog article: [Automatic SMB Scale-Out Rebalancing in Windows Server 2012 R2](https://blogs.technet.com/b/josebda/archive/2013/10/30/automatic-smb-scale-out-rebalancing-in-windows-server-2012-r2.aspx).

### Issue 2

SMB prefers to use the slower physical network adapter over the virtual network adapter.

Cause: The virtual network adapter on the host is not RSS-capable. The physical network adapter is RSS-capable. SMB always uses the RSS-capable network adapter over the non-RSS network adapter even when the RSS network adapter is slower.

Troubleshooting: You should disable the RSS capability on the physical network adapter, or use SMB Multichannel constraints to restrict SMB communication to one or more defined network interfaces. For more information, see the [New-SmbMultichannelConstraint](/powershell/module/smbshare/new-smbmultichannelconstraint?view=windowsserver2019-ps) SMB Share cmdlet in Windows PowerShell.

### Issue 3

SMB reports that the network adapter is not RDMA-capable, even though I'm using an RDMA-capable network adapter.

Cause: RDMA-capable network adapters that have older drivers or firmware may not correctly identify themselves as being RDMA-capable.

Troubleshooting: Update the network adapter firmware and driver from the manufacturer’s website.

### Issue 4

What is the required amount of network traffic before SMB Multichannel starts?

Cause: SMB Multichannel is used to discover the RSS and RDMA capabilities of network adapters. On server operating systems, SMB Multichannel starts when the initial read/write operation occurs. On client operating systems, SMB Multichannel does not start until a certain amount of network traffic occurs.

Troubleshooting: On server operating systems, SMB Multichannel starts quickly only one time per session. On client operating systems, you can configure a registry entry to start SMB Multichannel more quickly. For more information, see the following blog article: [How much traffic needs to pass between the SMB Client and Server before Multichannel actually starts?](https://blogs.technet.com/b/josebda/archive/2013/01/18/how-much-traffic-needs-to-pass-between-the-smb-client-and-server-before-multichannel-actually-starts.aspx).

### Issue 5

SMB Multichannel does not aggregate multiple 10 GbE network adapters.

Cause: An RSS-capable 10 GbE network adapter is sometimes identified as non-RSS-capable. When this occurs, SMB uses only one TCP connection. When using both RSS-capable and non-RSS network adapters, SMB Multichannel should use only the RSS-capable network adapters.

Troubleshooting: Server-class network adapters should appear as RSS-capable. If they don’t, you should update the network adapter driver from the manufacturer’s website, and then recheck the RSS settings.  
  You may have to disable RSS on both network adapters to aggregate throughput. For more information, see the following blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](https://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).

### Issue 6

The virtual network adapter on the host does not perform well.

Cause: The virtual network adapter on the host is not RSS-capable. Without an RSS-capable network adapter, SMB uses only one TCP connection. This occurs when using 10 GbE network adapters, RSS-capable network adapters, and NIC Teaming.

Troubleshooting: Use multiple virtual network adapters to make sure that you have multiple TCP connections. For more information, see the following blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](https://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).

## SMB known issues

- [TCP three-way handshake failure](/windows-server/storage/file-server/troubleshoot/tcp-three-way-handshake-fails)
- [Slow files transfer speed](/windows-server/storage/file-server/troubleshoot/slow-file-transfer)
- [Negotiate, Session Setup, and Tree Connect Failures](/windows-server/storage/file-server/troubleshoot/negotiate-session-setup-tree-connect-fails)
- [TCP connection is aborted during Validate Negotiate](/windows-server/storage/file-server/troubleshoot/abort-during-validate-negotiate)
- [SMB Multichannel troubleshooting](/windows-server/storage/file-server/troubleshoot/smb-multichannel-troubleshooting)
- [High CPU usage issue on the SMB server](/windows-server/storage/file-server/troubleshoot/high-cpu-usage-issue-on-smb-server)
- [Troubleshoot the Event ID 50 Error Message](/windows-server/storage/file-server/troubleshoot/troubleshoot-event-id-50-error)
- [SMBv1 is not installed by default](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)
- [Access Denied when you access an SMB file share](../../windows-client/networking/access-denied-access-smb-file-share.md)

## Reference

- [Advanced Troubleshooting Server Message Block (SMB)](/windows-server/storage/file-server/troubleshoot/troubleshooting-smb)
- [Enable or disable SMB versions](/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3)
- [File sharing using the SMBv3](/windows-server/storage/file-server/file-server-smb-overview)
- [SMB Compression](/windows-server/storage/file-server/smb-compression)
