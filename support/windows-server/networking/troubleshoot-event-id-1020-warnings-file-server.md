---
title: Troubleshoot event ID 1020 on an SMB file server
description: Explains how to troubleshoot event ID 1020 on an SMB file server.
ms.date: 03/14/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# Troubleshoot event ID 1020 events on a file server

This article explains how to troubleshoot event ID 1020 events on a Server Message Block (SMB) file server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4562940

## Symptoms

On a Windows Server-based SMB file server, you observe Event ID 1020 events from **SMB-Server** in the **Microsoft-Windows-SMBServer/Operational** event log. The information in these events resembles the following message:  

> File system operation has taken longer than expected.  
Client Name: \<*Client-IP/Name*>  
Client Address: \<*Client-IP*>:\<*Client-Port*>  
User Name: \<*Username*>  
Session ID: \<*SMB-Session-ID*>  
Share Name: \<*SMB-Share-Name*>  
File Name: \<*File-Name*>  
Command: \<*SMB-Command-Code*>  
Duration (in milliseconds): \<*Duration*>  
Warning Threshold (in milliseconds): 15000  
Guidance:  
The underlying file system has taken too long to respond to an operation. This typically indicates a problem with the storage and not SMB.

When Windows logs these events, you might also observe the following symptoms:

- The SMB server's clients experience performance problems. Because the SMB server accesses the local filesystem on behalf of its SMB clients, performance issues on the SMB server directly affect the clients. Client applications can experience very long wait times if their interaction with the SMB server involves several consecutive operations and each operation experiences a delay.
- The SMB server's clients might have trouble accessing shares that the SMB server manages.
- The SMB server's local applications or other components experience performance issues. Those applications and components might not be able to log such performance issues.
- The SMB server appears to stop responding.

> [!NOTE]  
> The performance problems might not affect all the SMB server's disks at the same time or to the same degree.

## Cause

Event ID 1020 indicates that the SMB server's file system can't complete a read/write (I/O) operation within the time that's allowed. By default, the time allowed is 15 seconds. Typically, we expect such operations to finish within a single-digit millisecond time frame.

Malfunctioning file system filter drivers can cause delays of several seconds. Issues that involve the SMB server's physical disks can also cause severely reduce performance. Such issues include the following:

- The physical disks are overloaded.
- VSS or other backup solutions are causing prolonged disk freeze situations.
- The network/storage stack of an underlying hypervisor is performing poorly.
- The network connections to the physical disks are experiencing problems.
- The storage appliance itself (storage area network (SAN), network attached storage (NAS), or other type) is experiencing issues.

File system delays that are less than the 15-second threshold don't produce a warning event but do reduce the SMB server's performance.

## Resolution

Because the cause of these file system delays might depend on the specifics of your environment, you typically have to gather more data to isolate your specific issue.

Start by reviewing the SMB server event log. Event ID 1020 events include information that can help you identify details and patterns. The event data includes the exact duration of the delay and the SMB command code that encountered the delay. For a list of SMBv2 command codes, see [2.2.1.2 SMB2 Packet Header - SYNC](/openspecs/windows_protocols/ms-smb2/fb188936-5050-48d3-b350-dc43059638a4).

## Collect trace logs

To further diagnose whether the problem originates from inside the Windows operating system (for example, filter drivers) or from outside (for example, hardware, hypervisor, network, or storage), use an application such as Storport Trace to collect trace data. Use a tool such as StorPortPacman to check the disk response times. StorPort traces at the lower end of the Windows storage stack, and the SMB server (or any other application) encounters the delays at the upper end of the stack. For more information about StorPortPacman, see [Deciphering Storport Traces 101](/archive/blogs/askcore/deciphering-storport-traces-101).  

High maximum response times at the StorPort level indicate that the cause for the performance issues resides outside the operating system. To determine what latencies the system encounters from its logical disks at application (file server) level, enable Perfmon or WPR tracing. Such trace data also shows latencies that are less than the 15-second warning threshold. For more information, see [Measuring Disk Latency with Windows Performance Monitor (Perfmon)](/archive/blogs/askcore/measuring-disk-latency-with-windows-performance-monitor-perfmon).

## Collect kernel dump file data

For extreme delays (10 or more minutes) and under some other conditions, the SMB server creates a live kernel dump file. Such information is valuable for troubleshooting.

The following events in the Microsoft-Windows-SMBServer/Operational event log indicate whether a live kernel dump file is available:

- Event ID 1031: The server detected a problem and has captured a live kernel dump to collect debug information.
- Event ID 1032: The server detected a problem but was unable to capture a live kernel dump to collect debug information.

Windows puts dump files into the *%SystemRoot%\LiveKernelReports* folder.
