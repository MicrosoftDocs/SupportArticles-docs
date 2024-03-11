---
title: Guidance for troubleshooting SMB
description: Introduces general guidance for troubleshooting scenarios related to SMB.
ms.date: 3/15/2024
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

### Periodic SMBClient event ID 30818 is logged on Windows Server 2012 R2

Assume that a Windows Server 2012 R2-based computer uses an InfiniBand network adapter. This adapter uses the SMB Direct feature to support Remote Direct Memory Access (RDMA) communication between cluster nodes and Hyper-V hosts. After you restart a Hyper-V host, event ID 30818 may be logged under the Applications and Services Logs/Microsoft/Windows/SmbClient path in Event Viewer. When this issue occurs, it may cause performance issues.

On Windows Server 2012 R2, the SmbDirect interface is started automatically by the LanmanServer service. However, if the LanmanWorkstation service happens to start first and tries to open an RDMA connection before the SmbDirect is loaded, event ID 30818 will be logged. When the client initially communicates to the server over TCP/IP, new client connections will start to use the RDMA interface. Therefore, no user action is needed to recover.

A change is being considered to resolve this problem in a future version of Windows Server.

To work around this problem on Windows Server 2012 R2, the SmbDirect service should be configured to start automatically. To do this, follow these steps:

1. Open Registry Editor, and then locate to the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\smbdirect`

2. Right-click the **Start** registry entry, and then click **Modify**.
3. In the **Value data** box, change the value (by default, it's **3** as on-demand) to **2** (automatic). Then, the event 30818 error should no longer be logged immediately after a restart of the server, unless there's some other problem that prevents the RDMA interface from initializing.

### Troubleshoot event ID 1020 warnings on a file server

On a Windows Server-based file server, you observe Event ID 1020 warnings from **SMB-Server** in the **Microsoft-Windows-SMBServer/Operational** event log:  

> File system operation has taken longer than expected.  
Client Name: \<Client-IP/Name>  
Client Address: \<Client-IP>:\<Client-Port>  
User Name: \<Username>  
Session ID: \<SMB-Session-ID>  
Share Name: \<SMB-Share-Name>  
File Name: \<File-Name>  
Command: \<SMB-Command-Code>  
Duration (in milliseconds): \<Duration>  
Warning Threshold (in milliseconds): 15000  
Guidance:  
The underlying file system has taken too long to respond to an operation. This typically indicates a problem with the storage and not SMB.

You may also observe:

- Performance issues on clients working with this file server.
- Connectivity issues for clients working with this file server.
- Performance issues for applications or other components that run locally on this file server.
- The file server appears to stop responding.

This issue occurs because filesystem takes more than 15 seconds (default warning threshold) to complete an I/O from the file server.  

The SMB Server has encountered a stalled I/O. This indicates severe issues with the underlaying file system instead of the SMB itself.  

For a good performing file server, we expect single-digit millisecond response times from its filesystem.  

The exact duration of the delay as well as the SMB Command Code that encountered the delay can be retrieved from the Event. A list of SMB2 Command Codes can be found at [2.2.1.2 SMB2 Packet Header - SYNC](/openspecs/windows_protocols/ms-smb2/fb188936-5050-48d3-b350-dc43059638a4).  

File system delays in the magnitude of several seconds can be caused by mal-functioning filesystem filter drivers.  

Other possible causes include severe performance problems towards the physical storage including:

- overload of the physical disks
- prolonged disk freeze operations such as the ones performed by VSS or other backup solutions
- the network/storage stack of an underlaying hypervisor
- the network connections to the storage
- the SAN/NAS/Storage-Appliance itself  

File system delays below the 15-second threshold do not produce a warning event but are still detrimental to the File server Performance.

#### Collect trace logs

In order to further diagnose whether the problem originates from inside the Windows operating system (for example, filter drivers) or from outside (for example, hardware, hypervisor, network, storage), take a Storport Trace and check the disk response times by using tools such as StorPortPacman. StorPort traces at the lower end of the Windows Storage Stack, and the file server or any other application encounters the delays at the upper end of the stack. For more information on the StorPortPacman tool, see [Deciphering Storport Traces 101](/archive/blogs/askcore/deciphering-storport-traces-101) and [StorPortPacman](https://github.com/CSS-Windows/WindowsDiag/tree/master/SHA/StorPortPacman).  

If you observe high maximum response time at StorPort level, it indicates the cause for the performance issues resides the outside the operating system. To find what latencies the system encounters from its logical disks at application (file server) level, you can enable Perfmon or WPR tracing. This also shows latencies below the 15 second warning Threshold. For more information, see [Measuring Disk Latency with Windows Performance Monitor (Perfmon)](/archive/blogs/askcore/measuring-disk-latency-with-windows-performance-monitor-perfmon).

#### Collect kernel dump

For extreme delays (10 or more minutes) and under some other conditions, the file server will try to create a live kernel dump to aid with the troubleshooting.  

The dump creation is logged by two events in the Microsoft-Windows-SMBServer/Operational Eventlog:

- Event 1031: The server detected a problem and has captured a live kernel dump to collect debug information.
- Event 1032: The server detected a problem but was unable to capture a live kernel dump to collect debug information.

If a dump was successfully created, it can be found under %SystemRoot%\LiveKernelReports and is immensely valuable for troubleshooting.

#### More information

As the Server Message Block (SMB) server is accessing the local filesystem on behalf of its SMB clients, performance issues on the SMB server directly affect the clients.  

Delays on individual operations can accumulate to huge wait times for client applications due to several operations being executed sequentially.  

Furthermore, long I/O response times can lead to problems accessing shares and make the file server appear to stop responding.  

Other applications and components that are running on this server and access the same file system may also be negatively affected by the long response times. Those applications and components may not possess their own logging or monitoring for high I/O response times.  

> [!Note]
>
> - Not all disks are affected.  
> - Not all disks might be affected at the same time.
> - Not all disks might be affected to the same degree.  

Check the SMB-Server 1020 Events for details and patterns.

### Troubleshoot the Event ID 50 error message

When information is being written to the physical disk, the following two event messages may be logged in the system event log:

```output
Event ID: 50 
Event Type: Warning 
Event Source: Ftdisk 
Description: {Lost Delayed-Write Data} The system was attempting to transfer file data from buffers to \Device\HarddiskVolume4. The write operation failed, and only some of the data may have been written to the file.
Data: 
0000: 00 00 04 00 02 00 56 00 
0008: 00 00 00 00 32 00 04 80 
0010: 00 00 00 00 00 00 00 00 
0018: 00 00 00 00 00 00 00 00 
0020: 00 00 00 00 00 00 00 00 
0028: 11 00 00 80 
```

```output
Event ID: 26 
Event Type: Information
Event Source: Application Popup
Description: Windows - Delayed Write Failed : Windows was unable to save all the data for the file \Device\HarddiskVolume4\Program Files\Microsoft SQL Server\MSSQL$INSTANCETWO\LOG\ERRORLOG. The data has been lost. This error may be caused by a failure of your computer hardware or network connection.

Please try to save this file elsewhere.
```

These event ID messages mean exactly the same thing and are generated for the same reasons. For the purposes of this article, only the event ID 50 message is described.

> [!NOTE]
> The device and path in the description and the specific hexadecimal data will vary.

#### More information

An event ID 50 message is logged if a generic error occurs when Windows is trying to write information to the disk. This error occurs when Windows is trying to commit data from the file system Cache Manager (not hardware level cache) to the physical disk. This behavior is part of the memory management of Windows. For example, if a program sends a write request, the write request is cached by Cache Manager and the program is told the write is completed successfully. At a later point in time, Cache Manager tries to write the data to the physical disk. When Cache Manager tries to commit the data to disk, an error occurs writing the data, and the data is flushed from the cache and discarded. Write-back caching improves system performance, but data loss and volume integrity loss can occur as a result of lost delayed-write failures.

It's important to remember that not all I/O is buffered I/O by Cache Manager. Programs can set a `FILE_FLAG_NO_BUFFERING` flag that bypasses Cache Manager. When SQL performs critical writes to a database, this flag is set to guarantee that the transaction is completed directly to disk. For example, non-critical writes to log files perform buffered I/O to improve overall performance. An event ID 50 message never results from non-buffered I/O.

There are several different sources for an event ID 50 message. For example, an event ID 50 message logged from a MRxSmb source occurs if there's a network connectivity problem with the redirector. To avoid performing incorrect troubleshooting steps, make sure to review the event ID 50 message to confirm that it refers to a disk I/O issue and that this article applies.

An event ID 50 message is similar to an event ID 9 and an event ID 11 message. Although the error isn't as serious as the error indicated by the event ID 9 and an event ID 11 message, you can use the same troubleshooting techniques for an event ID 50 message as you do for an event ID 9 and an event ID 11 message. However, remember that anything in the stack can cause lost-delay writes, such as filter drivers and mini-port drivers.

You can use the binary data that is associated with any accompanying "DISK" error (indicated by an event ID 9, 11, 51 error message or other messages) to help you in identifying the problem.

#### How to decode the data section of an Event ID 50 event message

When you decode the data section in the example of an event ID 50 message that is included in the "Summary" section, you see that the attempt to perform a write operation failed because the device was busy and the data was lost. This section describes how to decode this event ID 50 message.

The following table describes what each offset of this message represents:

|OffsetLengthValues|Length|Values|
|-----------|------------|---------|
|0x00|2|Not Used|
|0x02|2|Dump Data Size = 0x0004|
|0x04|2|Number of Strings = 0x0002|
|0x06|2|Offset to the strings|
|0x08|2|Event Category|
|0x0c|4|NTSTATUS Error Code = 0x80040032 = IO_LOST_DELAYED_WRITE|
|0x10|8|Not Used|
|0x18|8|Not Used|
|0x20|8|Not Used|
|0x28|4|NT Status error code|

#### Key sections to decode

**The error code**

In the example in the "Summary" section, the error code is listed in the second line. This line starts with "0008:" and it includes the last 4 bytes in this line: 0008: 00 00 00 00 32 00 04 80. In this case, the error code is 0x80040032. The following code is the code for error 50, and it's the same for all event ID 50 messages: `IO_LOST_DELAYED_WRITE`.

> [!NOTE]
> When you are converting the hexadecimal data in the event ID message to the status code, remember that the values are represented in the little-endian format.

**The target disk**

You can identify the disk that the write was being tried to by using the symbolic link that is listed to the drive in the "Description" section of the event ID message, for example: *\\Device\\HarddiskVolume4*.

**The final status code**

The final status code is the most important piece of information in an event ID 50 message. This is the error code that is return when the I/O request was made, and it's the key source of information. In the example in the "Summary" section, the final status code is listed at 0x28, the sixth line that starts with "0028:" and includes the only four octets in this line:

```output
0028: 11 00 00 80 
```

In this case, the final status equals 0x80000011.This status code maps to `STATUS_DEVICE_BUSY` and implies that the device is currently busy.

> [!NOTE]
> When you are converting the hexadecimal data in the event ID 50 message to the status code, remember that the values are represented in the little-endian format. Because the status code is the only piece of information that you are interested in, it may be easier to view the data in WORDS format instead of BYTES. If you do so, the bytes will be in the correct format and the data may be easier to interpret quickly.

To do so, select **Words** in the **Event Properties** window. In the **Data Words** view, the example in the "Symptoms" section would read as follows:

Data:

```output
() Bytes (.) 
Words 0000: 00040000 00560002 00000000 80040032 0010: 00000000 00000000 00000000 00000000 0020: 00000000 00000000 80000011
```

To obtain a list of Windows NT status codes, see NTSTATUS.H in the Windows Software Developers Kit (SDK).

### Event 1 about SMB witness client initialization when you install Windows Server

During the deployment of Windows Server 2019, Windows Server 2016, and Windows Server 2012 R2, the following error message is logged in Event Viewer indicating that Server Message Block (SMB) witness client initialization failed and returned Event 1:

> Log Name: Microsoft-Windows-SMBWitnessClient/Admin  
Source: Microsoft-Windows-SMBWitnessClient  
Event ID:1  
Level: Error  
Description: Witness Client initialization failed with error (The system cannot find the file specified.)

You can safely ignore this event if this is a fresh deployment of Windows Server that has no role and no feature is enabled.

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
