---
title: Troubleshoot event ID 1020 warnings on a file server
description: Explains how to troubleshoot event ID 1020 warnings on a file server
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Troubleshoot event ID 1020 warnings on a file server

This article explains how to troubleshoot event ID 1020 warnings on a file server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4562940

## Symptoms

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

## Cause

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

## Collect trace logs

In order to further diagnose whether the problem originates from inside the Windows operating system (for example, filter drivers) or from outside (for example, hardware, hypervisor, network, storage), take a Storport Trace and check the disk response times by using tools such as StorPortPacman. StorPort traces at the lower end of the Windows Storage Stack, and the file server or any other application encounters the delays at the upper end of the stack. For more information on the StorPortPacman tool, see [Deciphering Storport Traces 101](/archive/blogs/askcore/deciphering-storport-traces-101) and [StorPortPacman](https://github.com/CSS-Windows/WindowsDiag/tree/master/SHA/StorPortPacman).  

If you observe high maximum response time at StorPort level, it indicates the cause for the performance issues resides the outside the operating system. To find what latencies the system encounters from its logical disks at application (file server) level, you can enable Perfmon or WPR tracing. This also shows latencies below the 15 second warning Threshold. For more information, see [Measuring Disk Latency with Windows Performance Monitor (Perfmon)](/archive/blogs/askcore/measuring-disk-latency-with-windows-performance-monitor-perfmon).

## Collect kernel dump

For extreme delays (10 or more minutes) and under some other conditions, the file server will try to create a live kernel dump to aid with the troubleshooting.  

The dump creation is logged by two events in the Microsoft-Windows-SMBServer/Operational Eventlog:

- Event 1031: The server detected a problem and has captured a live kernel dump to collect debug information.
- Event 1032: The server detected a problem but was unable to capture a live kernel dump to collect debug information.

If a dump was successfully created, it can be found under %SystemRoot%\LiveKernelReports and is immensely valuable for troubleshooting.

## More information

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
