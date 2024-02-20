---
title: Guidance for troubleshooting SMB
description: Introduces general guidance for troubleshooting scenarios related to SMB.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:smb, csstroubleshoot
---
# SMB troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806211" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common SMB issues.

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

### When you access a Scale-Out File Server, performance is limited

The client access network uses high speed RDMA, but the cluster network does not. This causes redirection to occur only over the cluster network (which is usually a 1 GbE network adapter).

To troubleshoot this issue, you can configure the option to use the client access network for Cluster Shared Volumes (CSV). Or, upgrade to Windows Server 2012 R2. That system automatically redirects clients to the cluster node that has the best access to the volume that's used by the file share. For more information, see the following blog article: [Automatic SMB Scale-Out Rebalancing in Windows Server 2012 R2](https://blogs.technet.com/b/josebda/archive/2013/10/30/automatic-smb-scale-out-rebalancing-in-windows-server-2012-r2.aspx).

### SMB prefers to use the slower physical network adapter over the virtual network adapter

The virtual network adapter on the host is not RSS-capable. The physical network adapter is RSS-capable. SMB always uses the RSS-capable network adapter over the non-RSS network adapter even when the RSS network adapter is slower.

To troubleshoot this issue, you should disable the RSS capability on the physical network adapter, or use SMB Multichannel constraints to restrict SMB communication to one or more defined network interfaces. For more information, see the [New-SmbMultichannelConstraint](/powershell/module/smbshare/new-smbmultichannelconstraint) SMB Share cmdlet in Windows PowerShell.

### SMB reports that the network adapter is not RDMA-capable, even though I'm using an RDMA-capable network adapter

This issue occurs because RDMA-capable network adapters that have older drivers or firmware may not correctly identify themselves as being RDMA-capable.

To troubleshoot this issue, update the network adapter firmware and driver from the manufacturer's website.

### The required amount of network traffic before SMB Multichannel starts

SMB Multichannel is used to discover the RSS and RDMA capabilities of network adapters. On server operating systems, SMB Multichannel starts when the initial read or write operation occurs. On client operating systems, SMB Multichannel does not start until a certain amount of network traffic occurs.

On server operating systems, SMB Multichannel starts quickly only one time per session. On client operating systems, you can configure a registry entry to start SMB Multichannel more quickly. For more information, see the following blog article: [How much traffic needs to pass between the SMB Client and Server before Multichannel actually starts?](https://blogs.technet.com/b/josebda/archive/2013/01/18/how-much-traffic-needs-to-pass-between-the-smb-client-and-server-before-multichannel-actually-starts.aspx).

### SMB Multichannel does not aggregate multiple 10 GbE network adapters

An RSS-capable 10 GbE network adapter is sometimes identified as non-RSS-capable. When this occurs, SMB uses only one TCP connection. When using both RSS-capable and non-RSS network adapters, SMB Multichannel should use only the RSS-capable network adapters.

Server-class network adapters should appear as RSS-capable. If they don't, you should update the network adapter driver from the manufacturer's website, and then recheck the RSS settings.  

You may have to disable RSS on both network adapters to aggregate throughput. For more information, see the following blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](https://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).

### The virtual network adapter on the host does not perform well

The virtual network adapter on the host is not RSS-capable. Without an RSS-capable network adapter, SMB uses only one TCP connection. This occurs when using 10 GbE network adapters, RSS-capable network adapters, and NIC Teaming.

To troubleshoot this issue, use multiple virtual network adapters to make sure that you have multiple TCP connections. For more information, see the following blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](https://blogs.technet.com/b/josebda/archive/2012/11/10/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable.aspx).

## SMB known issues

- [TCP three-way handshake failure](/windows-server/storage/file-server/troubleshoot/tcp-three-way-handshake-fails)
- [Slow files transfer speed](slow-smb-file-transfer.md)
- [Negotiate, Session Setup, and Tree Connect Failures](/windows-server/storage/file-server/troubleshoot/negotiate-session-setup-tree-connect-fails)
- [TCP connection is aborted during Validate Negotiate](tcp-connection-abort-validate-negotiate.md)
- [SMB Multichannel troubleshooting](/windows-server/storage/file-server/troubleshoot/smb-multichannel-troubleshooting)
- [High CPU usage issue on the SMB server](high-cpu-usage-issue-smb-server.md)
- [Troubleshoot the Event ID 50 Error Message](/windows-server/storage/file-server/troubleshoot/troubleshoot-event-id-50-error)
- [SMBv1 is not installed by default](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)
- [Access Denied when you access an SMB file share](../../windows-client/networking/access-denied-access-smb-file-share.md)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:

    - Client:  

        ```powershell
        TSS.ps1 -Scenario NET_SMBcli
        ```

    - Server:  

        ```powershell
        TSS.ps1 -Scenario NET_SMBsrv
        ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Advanced Troubleshooting Server Message Block (SMB)](/windows-server/storage/file-server/troubleshoot/troubleshooting-smb)
- [Enable or disable SMB versions](/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3)
- [File sharing using the SMBv3](/windows-server/storage/file-server/file-server-smb-overview)
- [SMB Compression](/windows-server/storage/file-server/smb-compression)
