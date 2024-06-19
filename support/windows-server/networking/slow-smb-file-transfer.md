---
title: Slow SMB files transfer speed
description: Learn how to resolve transfer performance issues with SMB files by using the provided troubleshooting steps.
ms.date: 06/17/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna, jakehr, nedpyle
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# Slow SMB files transfer speed

Server Message Block (SMB) is the default Windows network file system feature and protocol. Network file transfer speeds are affected by a number of system and network factors. This article provides steps to resolve common file transfer performance issues using SMB.

## Slow transfer

> [!NOTE]
> [SMB signing](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102) and [SMB encryption](/windows-server/storage/file-server/smb-security) are known to reduce SMB transfer speeds. The amount of performance loss depends greatly on the capabilities of the hardware involved. The primary factors are CPU core count and speed, and how much CPU time is being dedicated to other workloads. 
> 
> [SMB signing will be required by default](https://aka.ms/SmbSigningRequired) in Windows 11, version 24H2 and Windows Server 2025. We don't recommend turning off the SMB client and server signing requirement, as they provide significant protections against spoofing, tampering, and relay attacks.

The following steps can be used to analyze, troubleshoot, and resolve common issues with slow SMB transfers.

- Use [robocopy](/windows-server/administration/windows-commands/robocopy) from the command line (command prompt or PowerShell).

  - File Explorer (the Windows file manager) performs single-threaded copies and uses buffered input/output (I/O) transfers.
  - Robocopy is optimized for IT administrators to create high performance local and remote file copy tasks.
  - File Explorer is convenient for basic use, but lacks the performance optimizations of robocopy that certain tasks require.

- Try an unbuffered I/O copy for files larger than 1 GB by using the `robocopy /J` command from the command line.
- Enable and use [SMB compression](/windows-server/storage/file-server/smb-compression).

  - This greatly reduces transfer times and bandwidth utilization for large files containing significant whitespace, such as virtual machine disks, `.iso`, and `.dmp`.
  - Non-compressible data, like archive files (`.zip`, `.7z`, and `.rar`), `.mp4` video, and `.mp3` files won't see significant performance improvements with SMB compression.
  - SMB compression is available starting with Windows 11 and Windows Server 2022.

- SMB speeds can be limited by storage performance.

  - Ensure that the backing storage has the required and available performance characteristics needed to meet the desired network throughput.
  - The approximate real-world storage to network performance speeds, over SMB, is:
  
    - 110 MB/s of sustained storage throughput per 1 Gbps of network bandwidth.
    - 1.1 GB/s of sustained storage throughput per 10 Gbps of network bandwidth.
    - 11 GB/s of sustained storage throughput per 100 Gbps of network bandwidth.
    - These numbers assume that there are no other bottlenecks on the system, such as CPU or memory exhaustion, and there are no networking errors.
    - Note that peak storage performance is often much less than sustained storage performance, and that most advertised storage measurements are peak performance.

- [SMB Direct](/windows-server/storage/file-server/smb-direct) (SMB over Remote Direct Memory Access (RDMA)) may be needed to reach certain network transfer speeds, or reach high speeds without causing high CPU utilization.
- File copies start fast and then slow down.
 
  - A change in copy speed can occur when the initial copy is cached by storage or buffered in system memory, and then the cache reaches capacity.
  - Data is then committed directly to disk (write-through) once memory buffers and storage caches are depleted, limiting performance to the storage mediums sustained write-through limits.
  - Use [RAMMap](/sysinternals/downloads/rammap) from SysInternals to determine whether **Mapped File** usage in memory stops growing.
  
    - This indicates that the memory buffer is exhausted.
    - RAMMap doesn't automatically refresh. Use <kbd>F5</kbd> on your keyboard or **File** > **Refresh** to update memory usage.
  - Use storage performance monitor counters to determine whether storage performance degrades proportionally to network throughput. For more information, see [Performance tuning for SMB file servers](/windows-server/administration/performance-tuning/role/file-server/smb-file-server).
  - Adjust the [remote file dirty page threshold](/windows-server/administration/performance-tuning/subsystem/cache-memory-management/troubleshoot#remote-file-dirty-page-threshold-is-consistently-exceeded) if performance degrades every 5 GB, approximately, on newer versions of Windows.

- Transfers are slow only when using certain technologies or a [Scale-Out File Server (SOFS)](/windows-server/failover-clustering/sofs-overview)).

  - Some technologies, typically backup or database based, require the use of disk write-through to maintain data integrity.
  - Windows SOFS requires write-through, as does SQL backup.
  - Disk write-through requires that the storage operation bypass all storage caches and buffers, and must be committed directly to the storage medium before the operation can be completed.
  - A storage system that lacks high write-through performance can't provide performant SMB transfers in these cases.

- Look for signs of network errors. Common networking issues, like packet loss, will cause network level throttling by the Transmission Control Protocol (TCP) congestion algorithm.
- Determine the performance overhead of anti-malware software by temporarily testing SMB transfer performance with file scanning disabled and their file system and network filter drivers unloaded.
- For SMB3, verify that [SMB Multichannel](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn610980(v=ws.11)) is enabled and working.
- Ensure that the network offloading technologies are enabled.

  - SMB performance is closely tied to network performance.
  - Network offloading technologies, like Receive Side Scaling (RSS), Large Sum Offload (LSO), Receive Segment Coalescing (RSC), and TCP/UDP checksums are designed to improve network throughput while lowering CPU usage by the network stack.
  - Don't disable network offloads.

- On the SMB client, ensure that large maximum transmission unit (MTU) isn't disabled and bandwidth throttling isn't enabled in SMB by running the following PowerShell cmdlet:

  ```powershell
  Set-SmbClientConfiguration -EnableBandwidthThrottling 0 -EnableLargeMtu 1
  ```

- Follow the Windows Server [Performance tuning for SMB file servers](/windows-server/administration/performance-tuning/role/file-server/smb-file-server) guide to tune the SMB server subsystem.

## Slow transfer when using small files

Slow copy speeds, and low network throughput is expected behavior when transferring a large number of small files over the network using the File Explorer and other single-threaded copy tools. "A large number of small files" is defined as hundreds, thousands, and even millions of files that are less than 1 MB in size.

### Issue details

File creation is an "expensive operation" in terms of performance, both from a network protocol (SMB) and file system perspective. SMB must perform multiple protocol operations to create a file before any data can be transmitted. The file system itself has an additional performance penalty when creating files.

Small file copies hit this penalty repeatedly. The data size, per file, isn't sufficient for the network to put enough data in-flight to sustain high network speeds when using a single-threaded copy because more time is spent creating the files than transferring the file data.

This issue occurs because data transmission must be halted to perform file creation after only a handful of data payloads are transmitted. However, a single large file has a single file creation penalty and then transmits enough data to reach peak network speeds.

### Technical details

Network latency, SMB `create` commands, and antivirus programs contribute to a slower transfer of small files. The following are additional details about this problem:

- SMB issues `create` commands to request that the file is created.

  - Each `create` command generates activity on the file system.
  - After the data is written, the file is closed.

- The process suffers from network, protocol (SMB), and file system latency.
 
  - This latency occurs because the file system request is first translated to SMB commands, transmitted over the network, turned back into a file system command, and only then is the actual file system work performed.
  - The process is reversed after the storage operation completes and only then does the SMB client receive a response and can proceed with the next operation.

- Additionally, endpoint protection (antivirus) often scans network packets and file system operations.

  - This adds an additional, usually a small amount of latency to the process. 
  - In small file scenarios, the antivirus actions are repeated for each file transferred.

- The result is that network throughput speeds can be less than 1 MB/s when using a single-threaded file copy tool.

### Speeding up small file copies

- Use `robocopy` with the `/MT` parameter and redirect output using `/log`.
 
  - Robocopy is built into Windows and the `/MT` parameter enables multithreaded file copies.
  - Multithreaded copies help by running many data transfers in parallel.
    - While one or two files are being created, there can be multiple files transferring.
    - This increases the amount of in-flight network data and minimizes pauses in the network data stream.
  - Writing to console is another time expensive operation, which is why redirecting the output to a log file speeds up the transfer job.
  - By default, `/MT` copies eight files at a time. It supports up to 128 copies at a time.
  - Too many threads may harm performance. Two threads per CPU core is generally a safe number, but testing is highly advised to find the optimal performance number.
  - For more information about usage details, see [robocopy](/windows-server/administration/windows-commands/robocopy).

- Use `AzCopy` when moving data to/from Azure. 
  - [AzCopy](https://aka.ms/azcopy) has concurrency (multi-threading) capabilities and several [performance optimizations](/azure/storage/common/storage-use-azcopy-optimize).

- Use file compression.
   - Compress the small files into a single large archive file (`.zip`, `.7z`, `.rar`, `.tar`, and `.gz`).
   - Copy the archive file.
   - Extract the files on the destination system. Don't extract the files remotely.
   - This may or may not be faster depending on the speed of compression and decompression on the two systems.
   - Use fast compression or no compression archiving to reduce the compression and decompression times.

- Use a trusted third-party (non-Microsoft) file copy tool that supports multi-threaded file copying.

## Slow open of Office documents

Office documents can open slowly, which generally occurs on a WAN connection. The manner in which Office apps (Microsoft Excel, in particular) access and read data is typically what causes the documents to open slowly.

You should verify that the Office and SMB binaries are up-to-date, and then test by having leasing disabled on the SMB server. To verify both conditions have resolved, follow these steps:

1. Run the following PowerShell cmdlet in Windows 8 and Windows Server 2012 or later versions of Windows:

   ```powershell
   Set-SmbServerConfiguration -EnableLeasing $false
   ```

2. This works immediately on a new SMB client connection, and there is no need to restart the SMB server or client machines. 

To avoid this issue, you can also replicate the file to a local file server. For more information, see [saving Office documents to a network server is slow when using EFS](/office/troubleshoot/office/saving-file-to-network-server-slow).
