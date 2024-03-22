---
title: Guidance for troubleshooting SMB
description: Introduces general guidance for troubleshooting scenarios that are related to SMB.
ms.date: 03/13/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:smb, csstroubleshoot
---
# SMB troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806211" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common SMB issues.

This article is designed to help you troubleshoot Server Message Block (SMB) issues. Most users are able to resolve their issue by using the solutions that are provided here.

## SMB terminology

Communicating correct terminology is a key aspect of quality SMB troubleshooting. Therefore, you should learn basic SMB terminology to ensure the accuracy of data collection and analysis.

- SMB Server (SRV) (also known as the file server) is always the system that hosts the file system.
- SMB Client (CLI) is always the system that tries to access the file system.

These terms are consistent regardless of the operating system version or edition. For example, if a Windows Server 2016-based computer tries to reach the SMB share *\\\\MyWorkstation\\Data* on a Windows 10-based computer, Windows Server 2016 is the SMB Client and Windows 10 is the SMB Server.

## Troubleshooting checklist

- Check that the correct SMB network protocol is installed. The SMBv1 network protocol is no longer installed by default.
- [Disable SMBv1](/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3#how-to-remove-smbv1).
- If SMBv1 is disabled on a device that supports only SMBv1, you can't access that device. In this situation, upgrade your system.
- You can't disable SMBv2 or SMBv3 separately because these versions are part of the same driver.
- Analyze the traffic: SMB is an application-level protocol that uses TCP/IP as the network transport protocol. Therefore, an SMB-related issue might indicate that there are underlying TCP/IP-related issues.
- Analyze the protocol: To understand the exact commands and options that are used, look at the actual SMB protocol details in the network trace.
- Update SMB-related system files: Keep the system files updated. Make sure that the latest [update rollup](https://support.microsoft.com/help/4498140/windows-10-update-history) is installed.

## SMB file information

SMB Client binaries that are listed under *%windir%\\system32\\Drivers*:

- RDBSS.sys
- MRXSMB.sys
- MRXSMB10.sys
- MRXSMB20.sys
- MUP.sys
- SMBdirect.sys

SMB Server binaries that are listed under *%windir%\\system32*:

- Srvsvc.dll

SMB Server binaries that are listed under *%windir%\\system32\\Drivers*:

- SRVNET.sys
- SRV.sys
- SRV2.sys
- SMBdirect.sys

We recommend that you update the following components before you troubleshoot SMB issues:

- iSCSI: A file server requires file storage. If your storage has iSCSI components, update those components.
- Network: Update the network components.
- Windows Core: For better performance and stability, update Windows Core.

## Disconnecting all shared resources from local computer

You can use the `Net Use * /delete` command to disconnect active or remembered shared resources on a local computer.

> [!NOTE]
> You can use this command on remote computers, also. Run `Net help use` for more options.

> [!IMPORTANT]  
> This section of this article is based on community content.
>  
> [!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]

## Common issues and solutions

### When you access a Scale-Out File Server, performance is limited

The client access network uses high-speed remote direct memory access (RDMA), but the cluster network doesn't. Because of this behavior, redirection occurs only on the cluster network. The cluster network typically connects to 1-GbE network adapters.

To troubleshoot this issue, you can configure the option to use the client access network for Cluster Shared Volumes (CSV). Or, upgrade to Windows Server 2012 R2 or a later version. That system automatically redirects clients to the cluster node that has the best access to the volume of the file share. For more information, see the following Blog Archive article: [Automatic SMB Scale-Out Rebalancing in Windows Server 2012 R2](/archive/blogs/josebda/automatic-smb-scale-out-rebalancing-in-windows-server-2012-r2).

### SMB prefers the slower physical network adapter to the virtual network adapter

The virtual network adapter on the host isn't RSS-capable. The physical network adapter is RSS-capable. SMB always uses the RSS-capable network adapter instead of the non-RSS network adapter even if the RSS network adapter is slower.

To troubleshoot this issue, disable the RSS capability on the physical network adapter, or use SMB Multichannel constraints to restrict SMB communication to one or more defined network interfaces. For more information, see the [New-SmbMultichannelConstraint](/powershell/module/smbshare/new-smbmultichannelconstraint) SMB Share cmdlet in Windows PowerShell.

### SMB reports the network adapter isn't RDMA-capable even though you believe that it is

This issue occurs because RDMA-capable network adapters that have older drivers or firmware might not correctly identify themselves as being RDMA-capable.

To troubleshoot this issue, update the network adapter firmware and driver from the manufacturer's website.

### The required amount of network traffic before SMB Multichannel starts varies

The SMB Multichannel feature is used to discover the RSS and RDMA capabilities of network adapters. On server operating systems, SMB Multichannel starts when the initial read or write operation occurs. On client operating systems, SMB Multichannel doesn't start until a certain amount of network traffic occurs.

On server operating systems, SMB Multichannel starts quickly only one time per session. On client operating systems, you can configure a registry entry to start SMB Multichannel more quickly. For more information, see the following Blog Archive blog article: [How much traffic needs to pass between the SMB Client and Server before Multichannel actually starts?](/archive/blogs/josebda/how-much-traffic-needs-to-pass-between-the-smb-client-and-server-before-multichannel-actually-starts).

### SMB Multichannel doesn't aggregate multiple 10-GbE network adapters

An RSS-capable 10-GbE network adapter is sometimes identified as non-RSS-capable. When this issue occurs, SMB uses only one TCP connection. When SMB Multichannel uses both RSS-capable and non-RSS network adapters, it should use only the RSS-capable network adapters.

Server-class network adapters should appear as RSS-capable. If they don't, update the network adapter driver from the manufacturer's website, and then recheck the RSS settings.  

You might have to disable RSS on both network adapters to aggregate throughput. For more information, see the following Blog Archive blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](/archive/blogs/josebda/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable).

### The virtual network adapter on the host doesn't perform well

The virtual network adapter on the host isn't RSS-capable. Without an RSS-capable network adapter, SMB uses only one TCP connection. This behavior occurs when you use 10-GbE network adapters, RSS-capable network adapters, and NIC Teaming.

To troubleshoot this issue, use multiple virtual network adapters to make sure that you have multiple TCP connections. For more information, see the following Blog Archive blog article: [Windows Server 2012 File Server Tip: Make sure your network interfaces are RSS-capable](/archive/blogs/josebda/windows-server-2012-file-server-tip-make-sure-your-network-interfaces-are-rss-capable).

### Windows Server 2012 R2 periodically logs SMBClient event ID 30818

Assume that a Windows Server 2012 R2-based computer uses an InfiniBand network adapter. This adapter uses the SMB Direct feature to support Remote Direct Memory Access (RDMA) communication between cluster nodes and Hyper-V hosts. After you restart a Hyper-V host, Windows might log event ID 30818 under the **Applications and Services Logs/Microsoft/Windows/SmbClient** path in Event Viewer. When this occurs, you might also experience performance issues.

On Windows Server 2012 R2, the LanmanServer service automatically starts the SmbDirect service. However, if the LanmanWorkstation service happens to start first and tries to open an RDMA connection before the SmbDirect service loads, Windows logs event ID 30818. When the client initially communicates with the server over TCP/IP, it uses the RDMA interface. Therefore, no user action is needed to recover.

Microsoft is considering providing a resolution for this issue in a future version of Windows Server.

#### Workaround

[!INCLUDE [Registry alert](../../includes/registry-important-alert.md)]

To work around this issue on Windows Server 2012 R2, configure the SmbDirect service to start automatically. To do this, follow these steps:

1. Open Registry Editor, and then navigate to the following registry subkey:  

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\smbdirect`

2. Right-click the **Start** registry entry, and then select **Modify**.
3. In the **Value data** box, change the value (the default value is **3**, which means on-demand) to **2** (automatic).

After you make this change, you should be able to restart the computer without Windows logging event ID 30818 messages. If Windows continues to log these events, some other issue might be preventing the RDMA interface from initializing.

### When you install Windows Server, Windows logs Event ID 1

When you install Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2, Windows logs Event ID 1. The event information resembles the following:

> Log Name: Microsoft-Windows-SMBWitnessClient/Admin  
Source: Microsoft-Windows-SMBWitnessClient  
Event ID:1  
Level: Error  
Description: Witness Client initialization failed with error (The system cannot find the file specified.)

If this is a fresh deployment of Windows Server that has no roles or features enabled, you can safely ignore this event.

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

Before you contact Microsoft Support, you can gather information about your issue.

### Prerequisites

- Run TSS in the security context of an account that has administrator privileges on the local system. The first time that you run it, accept the EULA. (After you accept the EULA, TSS won't prompt you again.)
- We recommend that you use the `RemoteSigned` PowerShell execution policy at the `LocalMachine` scope.

> [!NOTE]  
> If the current PowerShell execution policy doesn't allow you to run TSS, take the following actions:
>
> 1. Set the `RemoteSigned` execution policy for the process level by running the `Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned` cmdlet.
> 2. To verify that the change takes effect, run the `Get-ExecutionPolicy -List` cmdlet.  
>
> These process-level permissions apply to only the current PowerShell session. After you close the PowerShell window in which TSS runs, the assigned permission for the process level reverts to the previously-configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes, and expand the file into the *C:\\tss* folder.
2. Open the *C:\\tss* folder in an elevated PowerShell Command Prompt window.
3. Start the traces on the client and the server by running the following cmdlets:

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

   > [!NOTE]  
   > If you collect logs on both the client and the server, wait for this message to appear on both nodes before you reproduce the issue.

6. Reproduce the issue.

7. After you reproduce the issue, enter *Y* to finish logging data.

TSS stores the traces in a compressed file in the *C:\\MS_DATA* folder. You can upload the file to the workspace for analysis.

## References

- [Advanced Troubleshooting Server Message Block (SMB)](/windows-server/storage/file-server/troubleshoot/troubleshooting-smb)
- [Enable or disable SMB versions](/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3)
- [File sharing using the SMBv3](/windows-server/storage/file-server/file-server-smb-overview)
- [SMB compression](/windows-server/storage/file-server/smb-compression)
