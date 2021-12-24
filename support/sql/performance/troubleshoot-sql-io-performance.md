---
title: Troubleshooting SQL Server Slow IO issues
description: Provides a methodology to isolate and troubleshoot SQL performance problems caused by slow disk I/O 
ms.date: 12/22/2021
ms.prod-support-area-path: Performance
ms.topic: troubleshooting
ms.prod: sql
author: pijocoder 
ms.author: v-yunhya
---

# Troubleshooting SQL Server Slow Performance Caused by IO issues

## Define slow I/O performance

The metric commonly used to measure slow I/O performance is the one that measures how fast the I/O subsystem is servicing each I/O request on an average in terms of clock time. The specific [Performance monitor](/windows-server/administration/windows-commands/perfmon) counters that measure I/O latency in Windows are `Avg Disk sec/ Read`, `Avg. Disk sec/Write` and `Avg. Disk sec/Transfer` (cumulative of both reads and writes).

In SQL Server, things work in the same way. Commonly, you look at whether SQL Server reports any I/O bottlenecks measured in clock time (milliseconds). SQL Server makes I/O requests to the OS by calling the Win32 functions - `WriteFile()`, `ReadFile()`, `WriteFileGather()` and `ReadFileScatter()`. When it posts an I/O request, SQL Server times the request and reports how long that request took using [Wait types](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql). SQL Server uses Wait Types to indicate I/O waits at different places in the product. The I/O related waits are:

- [PAGEIOLATCH_SH](#pageiolatch_sh) / [PAGEIOLATCH_EX](#pageiolatch_ex)
- [WRITELOG](#writelog)
- [IO_COMPLETION](#io_completion)
- [ASYNC_IO_COMPLETION](#async_io_completion)
- [BACKUPIO](#backupio)

If these waits exceed 10-15 milliseconds on a consistent basis, then I/O is considered a bottleneck.

> [!NOTE]
> To provide context and perspective, in the world of t-shooting SQL Server, CSS has observed cases where an I/O request took over 1 second and as high as 15 seconds per transfer! Obviously such I/O systems need optimization. Conversely, CSS has seen systems where the throughput is below 1 millisecond /transfer. With today's SSD/NVMe technology, advertised throughput rates range in tens of microseconds per transfer. Therefore, the 10-15 ms/transfer figure is a very approximate threshold we selected based on collective experience between Windows and SQL Server engineers over the years. Usually, once numbers go beyond this approximate threshold, SQL Server users start seeing latency in their workloads and report them. Ultimately, the expected throughput of an I/O subsystem is defined by the manufacturer, model, configuration, workload, and potentially multiple other factors.

## Methodology

The following is a description of the methodology Microsoft CSS uses to approach slow I/O issues with SQL Server. It is not an exhaustive or exclusive approach, but has proven useful in isolating the issue and resolving it.

A [flow chart](#graphical-representation-of-the-methodology) at the end of this article provides a visual representation of this methodology.

### Is SQL Server reporting slow I/O?

Determine if there is I/O latency reported by SQL Server wait types. The values `PAGEIOLATCH_*`, `WRITELOG`, and `ASYNC_IO_COMPLETION` and the values of several other less common wait types, should generally stay below 10-15 milliseconds per I/O request. If these values are greater on a consistent basis, then an I/O performance problem exists and warrants further investigation. The following query may help you gather this diagnostic information on your system:

   ```Powershell
   
   #replace with server\instance or server for default instance
   $sqlserver_instance = "server\instance" 

   for ([int]$i = 0; $i -lt 100; $i++)
    {
    
       sqlcmd -E -S $sqlserver_instance -Q "select r.session_id, r.wait_type, r.wait_time as wait_time_ms`
                                           from sys.dm_exec_requests r join sys.dm_exec_sessions s `
                                            on r.session_id = s.session_id `
                                            where wait_type in ('PAGEIOLATCH_SH', 'PAGEIOLATCH_EX', 'WRITELOG', 'IO_COMPLETION', 'ASYNC_IO_COMPLETION', 'BACKUPIO')`
                                            and is_user_process = 1"

       Start-Sleep -s 2
   }
   ```

In some cases, you may observe error 833 `SQL Server has encountered %d occurrence(s) of I/O requests taking longer than %d seconds to complete on file [%ls] in database [%ls] (%d)` in the Errorlog. You can check SQL Server error logs on your system by running the following PowerShell command:

  ```Powershell
  Get-ChildItem -Path "c:\program files\microsoft sql server\mssql*" -Recurse -Include Errorlog | Select-String "occurrence(s) of I/O requests taking longer than"
Longer than 15 secs
  ```

Also, refer to the [MSSQLSERVER_833](/sql/relational-databases/errors-events/mssqlserver-833-database-engine-error) section for more details on this error.

### Do Perfmon counters indicate I/O latency?

If SQL Server reports I/O latency, then refer to OS counters. You can determine if there is an I/O problem, by examining the latency counter `Avg Disk Sec/Transfer`. The following code snippet indicates one way to collect this information through PowerShell. It gathers counters on all disk volumes: "_total". Please change to a specific drive volume (for example "D:"). To find which volumes host your database files, run the following query in your SQL Server:

   ```SQL
   SELECT distinct volume_mount_point 
   FROM sys.master_files f
   CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id) vs;
  ```

Gather `Avg Disk Sec/Transfer` metrics on your volume of choice:

   ```Powershell
   clear
   $cntr = 0 


   # replace with your server
   $serverName = "rabotenlaptop" 
   
   # replace with your volume name - C: , D:, etc
   $volumeName = "_total"

$Counters = @(("\\$serverName" +"\LogicalDisk($volumeName)\Avg. disk sec/transfer"))

   $disksectransfer = Get-Counter -Counter $Counters -MaxSamples 1 
   $avg = $($disksectransfer.CounterSamples | Select-Object CookedValue).CookedValue
 
   Get-Counter -Counter $Counters -SampleInterval 2 -MaxSamples 30 | ForEach {
	 $_.CounterSamples | ForEach {
		  [pscustomobject]@{
			  TimeStamp = $_.TimeStamp
			  Path = $_.Path
			  Value = ([Math]::Round($_.CookedValue, 5))
              turn = $cntr = $cntr +1
              running_avg = [Math]::Round(($avg = (($_.CookedValue + $avg) / 2)), 5)  
              
       } | Format-Table
     }
   }

   write-host "Final_Running_Average: $([Math]::Round( $avg, 5)) sec/transfer`n"
  
   if ($avg -gt 0.01)
   {
     Write-Host "There ARE indications of slow I/O performance on your system"
   }
   else
   {
     Write-Host "There is NO indication of slow I/O performance on your system"
   }
   ```

If the values of this counter are consistently above 10-15 milliseconds, then you need to take a look at the issue further. Occasional spikes don't count in most cases but be sure to double-check the duration of a spike - if it lasted 1 minute or more, then it is more of a plateau than a spike.

If `Performance monitor` counters do not report latency, but SQL Server does, then the problem is between SQL Server and the Partition Manager, i.e. filter drivers. The Partition Manager is an I/O layer where the OS collects [Perfmon](/windows-server/administration/windows-commands/perfmon) counters. To address the latency, ensure proper exclusions of filter drivers and resolve filter driver issues. Filter drivers are used by programs like [Anti-virus software](/windows-hardware/drivers/ifs/allocated-altitudes#320000---329998-fsfilter-anti-virus), [Backup solutions](/windows-hardware/drivers/ifs/allocated-altitudes#280000---289998-fsfilter-continuous-backup), [Encryption](/windows-hardware/drivers/ifs/allocated-altitudes#140000---149999-fsfilter-encryption), [Compression](/windows-hardware/drivers/ifs/allocated-altitudes#160000---169999-fsfilter-compression), and so on. You can use this command to list filter drivers on the systems and the volumes they attach to. Then you can look up the driver names and software vendor in the [Allocated filter altitudes](/windows-hardware/drivers/ifs/allocated-altitudes) article.

   ```Powershell
   fltmc instances
   ```

For more information, see the [How to choose antivirus software to run on computers that are running SQL Server](https://support.microsoft.com/en-us/topic/how-to-choose-antivirus-software-to-run-on-computers-that-are-running-sql-server-feda079b-3e24-186b-945a-3051f6f3a95b) article.

Avoid using Encrypting File System (EFS) and file-system compression because they cause asynchronous I/O to become synchronous and therefore slower. For more information, see the [Asynchronous disk I/O appears as synchronous on Windows](/troubleshoot/windows/win32/asynchronous-disk-io-synchronous#compression) article.

### Is the I/O subsystem overwhelmed beyond capacity?

If SQL Server and the OS indicate I/O subsystem is slow, then find out if that is caused by the system being overwhelmed beyond capacity. You can do this by looking at I/O counters `Disk Bytes/Sec`, `Disk Read Bytes/Sec`, or `Disk Write Bytes/Sec`. Be sure to check with your System Administrator or hardware vendor on what the expected throughput specifications are for your SAN (or other I/O subsystem). For example, you can push no more than 200 MB/sec of I/O through a 2 GB/sec HBA card or 2 GB/sec dedicated port on a SAN switch. The expected throughput capacity defined by a hardware manufacturer defines how you proceed from here.

```powershell
clear
$serverName = "severname"
$Counters = @(
        ("\\$serverName" +"\PhysicalDisk(*)\Disk Bytes/sec"),
        ("\\$serverName" +"\PhysicalDisk(*)\Disk Read Bytes/sec"),
        ("\\$serverName" +"\PhysicalDisk(*)\Disk Write Bytes/sec")
   )
Get-Counter -Counter $Counters -SampleInterval 2 -MaxSamples 20 | ForEach  {
 	  $_.CounterSamples | ForEach 	  {
 		  [pscustomobject]@{
 			  TimeStamp = $_.TimeStamp
 			  Path = $_.Path
 			  Value = ([Math]::Round($_.CookedValue, 3))
	  }
     }
 }
```

### Is SQL Server driving the heavy I/O activity?

If I/O subsystem is overwhelmed beyond capacity, then find out if SQL Server is the culprit by looking at `Buffer Manager: Page Reads/Sec` (most common culprit) and `Page Writes/Sec` (a lot less common) for the specific instance. If SQL Server is the main I/O driver and I/O volume is beyond what the system can handle, then you need to work with the Application Development teams (or application vendor) to:

- Tune queries - better indexes, update statistics, rewrite queries, redesign the database, etc.
- Increase [max server memory](/sql/database-engine/configure-windows/server-memory-server-configuration-options), or add more RAM on the system. This will allow more data/index pages to be cached and not re-read from disk frequently, thus reduce I/O activity.

## Causes

In general, there exist three high-level reasons why SQL Server queries suffer from I/O latency and they are:

 - **Hardware issues:** There is a SAN misconfiguration (switch, cables, HBA, storage), exceeded I/O capacity (throughout entire SAN network, not just back-end storage), drivers/firmware bug, and so on. This stage is where a hardware vendor needs to be engaged.

 - **Query Issues:** SQL Server (or some other process in some cases) on the system is saturating the disks with I/O requests and that is why transfer rates are high. In this case, you will need to find queries that are causing a large number of logical reads (or writes) and tune the queries them to minimize the disk I/O. Using appropriate indexes helps in providing the optimizer sufficient information to choose the best plan, that is, to keep statistics updated. Also incorrect database design and query design lead to increase in I/O.

 - **Filter Drivers:** SQL Server I/O response can be severely impacted if file-system filter drivers process the heavy I/O traffic. Proper file exclusions from anti-virus scanning and correct filter driver design by software vendor is recommended to prevent this from happening.

## Graphical representation of the methodology

:::image type="content" source="media/troubleshoot-slow-io-sql/Slow_Disk_IO_Issues.png" alt-text="SlowIO Flow Chart":::

## I/O related Wait types

Following are descriptions of the common wait types observed in SQL Server when disk I/O issues are reported.

### PAGEIOLATCH_EX

Occurs when a task is waiting on a latch for a data or index page (buffer) in an I/O request. The latch request is in Exclusive mode - a mode used when the buffer is being written to disk. Long waits may indicate problems with the disk subsystem.

### PAGEIOLATCH_SH

Occurs when a task is waiting on a latch for a data or index page (buffer) in an I/O request. The latch request is in Shared mode - a mode used when the buffer is being read from disk. Long waits may indicate problems with the disk subsystem.

### PAGEIOLATCH_UP

Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Update mode. Long waits may indicate problems with the disk subsystem.

### WRITELOG

Occurs while waiting for a transaction log flush to complete. A flush occurs when the Log Manager writes its temporary contents to disk. Common operations that cause log flushes are transaction commits and checkpoints.

Common reasons for long waits on `WRITELOG` are:

 - **Transaction log disk latency**: This is the most common cause of `WRITELOG` waits. Generally, the recommendation is to keep the data and log files on separate volumes. Transaction log writes are sequential writes while read/writing data from data file is random. Mixing these two on one drive volume (especially conventional spinning disk drives) will cause contention in terms of disk movement.

 - **Too many VLFs**: Too many virtual log files (VLFs) can cause `WRITELOG` waits. Too many VLFs can cause other type of issues such as long recovery as well.

 - **Too many small Transactions**: While large transactions can lead to blocking, too many small transactions can lead to another set of issues. If you don't explicitly begin a transaction, any insert, delete, update will result into a transaction (we call this auto transaction). If you do 1000 inserts in a loop, there will be 1000 transactions generated. Each transaction in this example needs to commit which results in a transaction log flush. This will result in 1000 transaction flushes. When possible, group individual update/delete/insert into a bigger transaction to reduce transaction log flushes and [increase performance](/troubleshoot/sql/admin/logging-data-storage-algorithms#increasing-performance). This can lead to fewer `WRITELOG` waits.

 - **Scheduling issues causing Log Writer threads to not get scheduled fast enough**: Prior to SQL Server 2016, a single Log writer thread performed all log writes. If there were issues with thread scheduling (for example, very high CPU) the Log writer thread could get delayed and so too would be log flushes. In SQL Server 2016, up to 4 log writer threads were added to increase the log-writing throughput. See [SQL 2016 - It Just Runs Faster: Multiple Log Writer Workers](https://techcommunity.microsoft.com/t5/sql-server-support/sql-2016-it-just-runs-faster-multiple-log-writer-workers/ba-p/318732). In SQL Server 2019, up to 8 Log writer threads were added which improves throughput even more. Also, in SQL Server 2019, each regular worker thread can do log writes directly instead of posting to Log Writer thread. With these improvements, `WRITELOG` waits would rarely be triggered by scheduling issues.

### ASYNC_IO_COMPLETION

Occurs when some of the following I/O activities happen:

- Bulk Insert Provider ("Insert Bulk") uses when performing I/O
- Reading Undo file in LogShipping and direct Async I/O for Log Shipping
- Reading the actual data from the data files during a data backup

### IO_COMPLETION

Occurs while waiting for I/O operations to complete. This wait type generally involves I/Os not related to data pages (buffers). Examples include:

- Reads and writes of sort/ hash results from/to disk during a spill (check performance of *tempdb* storage)
- Reading and writing eager spools to disk (check *tempdb* storage)
- Reading log blocks from the transaction log (during any operation that causes the log to be read from disk – for example, recovery)
- Reading a page from disk when database is not set up yet
- Copying pages to a database snapshot (Copy-on-Write)
- Closing database file, file uncompression

### BACKUPIO

Occurs when a backup task is waiting for data, or is waiting for a buffer to store data. This type is not typical, except when a task is waiting for a tape mount.