---
title: Troubleshoot performance issues and isolate bottlenecks in Linux
description: Troubleshoot CPU, memory, and disk input and output performance issues and isolate bottlenecks on Linux virtual machines in Azure.
ms.date: 02/15/2024
ms.reviewer: azurevmlnxcic, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-performance
author: msLinuxNinja
ms.author: esflores
---
# Troubleshoot performance issues and isolate bottlenecks in Linux

## Performance issues and bottlenecks

When performance issues occur in different operating systems and applications, each case requires a unique approach to troubleshoot. CPU, memory, networking, and input/output (I/O) are key areas where issues can occur. Each of these areas displays different symptoms (sometimes simultaneously) and requires different diagnoses and solutions.

Performance issues could be caused by a misconfiguration of the application or setup. An example would be a web application that has a caching layer that isn't correctly configured. This situation triggers more requests flowing back to the origin server instead of being served from a cache.

In another example, the redo log of a MySQL or MariaDB database is located on the operating system (OS) disk or on a disk that doesn't meet the database requirements. In this scenario, you might see fewer transactions per second (TPS) because of competition for resources and higher response times (latency).

If you fully understand the issue, you can better identify where to look on the stack (CPU, memory, networking, I/O). To troubleshoot performance issues, you have to establish a *baseline* that enables you to compare metrics after you make changes and to evaluate whether the overall performance has improved.

Troubleshooting a virtual machine (VM) performance issue is no different than resolving a performance issue on a physical system. It's about determining which resource or component is causing a *bottleneck* in the system.

It's important to understand that bottlenecks always exist. Performance troubleshooting is all about understanding where a bottleneck occurs and how to move it to a less-offending resource.

This guide helps you discover and resolve performance issues in Azure Virtual Machines in the Linux environment.

### Obtain performance pointers

You can obtain performance pointers that either confirm or deny whether the resource constraint exists.

Depending on the resource that's investigated, many tools can help you obtain data that pertain to that resource. The following table includes examples for the main resources.

|Resource|Tool|
|---|---|
|CPU|`top`, `htop`, `mpstat`, `pidstat`, `vmstat`|
|Disk|`iostat`, `iotop`, `vmstat`|
|Network|`ip`, `vnstat`, `iperf3`|
|Memory|`free`, `top`, `vmstat`|

The followng sections discuss pointers and tools that you can use to look for the main resources.

## CPU resource

A certain percentage of CPU is either used or not. Similarly, processes either spend time in CPU (such as 80 percent `usr` usage) or do not (such as 80 percent idle). The main tool to confirm CPU usage is `top`.

The `top` tool runs in interactive mode by default. It refreshes every second and shows processes as sorted by CPU usage:

```output
[root@rhel78 ~]$ top
top - 19:02:00 up  2:07,  2 users,  load average: 1.04, 0.97, 0.96
Tasks: 191 total,   3 running, 188 sleeping,   0 stopped,   0 zombie
%Cpu(s): 29.2 us, 22.0 sy,  0.0 ni, 48.5 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
KiB Mem :  7990204 total,  6550032 free,   434112 used,  1006060 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  7243640 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 22804 root      20   0  108096    616    516 R  99.7  0.0   1:05.71 dd
  1680 root      20   0  410268  38596   5644 S   3.0  0.5   2:15.10 python
   772 root      20   0   90568   3240   2316 R   0.3  0.0   0:08.11 rngd
  1472 root      20   0  222764   6920   4112 S   0.3  0.1   0:00.55 rsyslogd
 10395 theuser   20   0  162124   2300   1548 R   0.3  0.0   0:11.93 top
     1 root      20   0  128404   6960   4148 S   0.0  0.1   0:04.97 systemd
     2 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd
     4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
     6 root      20   0       0      0      0 S   0.0  0.0   0:00.56 ksoftirqd/0
     7 root      rt   0       0      0      0 S   0.0  0.0   0:00.07 migration/0
     8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh
     9 root      20   0       0      0      0 S   0.0  0.0   0:06.00 rcu_sched
    10 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain
    11 root      rt   0       0      0      0 S   0.0  0.0   0:00.05 watchdog/0
    12 root      rt   0       0      0      0 S   0.0  0.0   0:00.04 watchdog/1
    13 root      rt   0       0      0      0 S   0.0  0.0   0:00.03 migration/1
    14 root      20   0       0      0      0 S   0.0  0.0   0:00.21 ksoftirqd/1
    16 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H
    18 root      20   0       0      0      0 S   0.0  0.0   0:00.01 kdevtmpfs
    19 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 netns
    20 root      20   0       0      0      0 S   0.0  0.0   0:00.00 khungtaskd
    21 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 writeback
    22 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kintegrityd
```

Now, look at the `dd` process line from that output:

```output
   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 22804 root      20   0  108096    616    516 R  99.7  0.0   1:05.71 dd
```

You can see that the `dd` process is consuming 99.7 percent of the CPU.

> [!NOTE]
> - You can display per-CPU usage in the `top` tool by selecting <kbd>1</kbd>.
>
> - The `top` tool displays a total usage of more than 100 percent if the process is multithreaded and spans more than one CPU.

Another useful reference is load average. The load average shows an average system load in 1-minute, 5-minute, and 15-minute intervals. The value indicates the level of load of the system. Interpreting this value depends on the number of CPUs that are available. For example, if the load average is 2 on a one-CPU system, then the system is so loaded that the processes start to queue up. If there's a load average of 2 on a four-CPU system, there's about 50 percent overall CPU usage.

> [!NOTE]
> You can quickly obtain the CPU count by running the `nproc` command.

In the previous example, the load average is at 1.04. This is a two-CPU system, meaning that there's about 50 percent CPU usage. You can verify this result if you notice the 48.5 percent idle CPU value. (In the `top` command output, the idle CPU value is shown before the `id` label.)

Use the load average as a quick overview of how the system is performing.

Run the `uptime` command to obtain the load average.

## Disk (I/O) resource

When you investigate I/O performance issues, the following terms help you understand where the issue occurs.

| Term | Description |
|--|--|
| **IO Size** | The amount of data that's processed per transaction, typically defined in bytes. |
| **IO Threads** | The number of processes that are interacting with the storage device. This value depends on the application. |
| **Block Size** | The I/O size as defined by the backing block device. |
| **Sector Size** | The size of each of the sectors at the disk. This value is typically 512 bytes. |
| **IOPS** | Input Output Operations Per Second. |
| **Latency** | The time that an I/O operation takes to finish. This value is typically measured in milliseconds (ms). |
| **Throughput** | A function of the amount of data transferred that's over a specific amount of time. This value is typically defined as megabytes per second (MB/s). |

### IOPS

*Input Output Operations Per Second* (IOPS) is a function of the number of input and output (I/O) operations that are measured over a certain time (in this case, seconds). I/O operations can be either reads or writes. Deletes or discards can also be counted as an operation against the storage system. Each operation has an allocation unit that corresponds equally to the I/O size.

I/O size is typically defined at the application level as the amount of data that's written or read per transaction. A commonly used I/O size is 4K. However, a smaller I/O size that contains more threads yields a higher IOPS value. Because each transaction can be completed relatively fast (because of its small size), a smaller I/O enables more transactions to be completed in the same amount of time.

On the contrary, suppose you have the same number of threads but use a larger I/O. IOPS decreases because each transaction takes longer to complete. However, throughput increases.

Consider the following example:

1,000 IOPS means that for each second, one thousand operations finish. Each operation takes roughly one millisecond. (There are 1,000 milliseconds in one second.) In theory, each transaction has roughly one millisecond to finish, or about 1-ms latency.

By knowing the IOSize value and the IOPS, you can calculate the throughput by multiplying IOSize by IOPS.

For example:

- 1,000 IOPS at 4K IOSize = 4,000 KB/s, or 4 MB/s (3.9 MB/s to be precise)

- 1,000 IOPS at 1M IOSize = 1,000 MB/s, or 1 GB/s (976 MB/s to be precise)

A more equation-friendly version could be written as follows:

> `IOPS * IOSize = IOSize/s (Throughput)`

### Throughput

Unlike IOPS, throughput is a function of the amount of data over time. This means that during each second, a certain amount of data is either written or read. This speed is measured in *\<amount-of-data>*/*\<time>*, or megabytes per second (MB/s).

If you know the throughput and IOSize values, you can calculate IOPS by dividing the throughput by IOSize. You should normalize the units to the smallest connotation. For example, if IOSize is defined in kilobytes (kb), the throughput should be converted.

The equation format is written as follows:

> `Throughput / IOSize = IOPS`

To put this equation into context, consider a throughput of 10 MB/s at an IOSize of 4K. When you enter the values into the equation, the result is *10,240/4=2,560 IOPS*.

> [!NOTE]
> 10 MB is precisely equal to 10,240 KB.

### Latency

Latency is the measurement of the average amount of time each operation takes to finish. IOPS and latency are related because both concepts are a function of time. For example, at 100 IOPS, each operation takes roughly 10 ms to complete. But the same amount of data could be fetched even quicker at lower IOPS. Latency is also known as seek time.

### Understand iostat output

As part of the sysstat package, the `iostat` tool provides insights into disk performance and usage metrics. `iostat` can help identify bottlenecks that are related to the disk subsystem.

You can run `iostat` in a simple command. The basic syntax is as follows:

> `iostat <parameters> <time-to-refresh-in-seconds> <number-of-iterations> <block-devices>`

The parameters dictate what information `iostat` provides. Without having any command parameter, `iostat` displays basic details:

```output
[host@rhel76 ~]$ iostat
Linux 3.10.0-957.21.3.el7.x86_64 (rhel76)       08/05/2019      _x86_64_        (1 CPU)
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          41.06    0.00   30.47   21.00    0.00    7.47
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda             182.77      5072.69      1066.64     226090      47540
sdd               2.04        42.56        22.98       1897       1024
sdb              12.61       229.23     96065.51      10217    4281640
sdc               2.56        46.16        22.98       2057       1024
md0               2.67        73.60        45.95       3280       2048
```

By default, `iostat` displays data for all existing block devices, although minimal data is provided for each device. Parameters are available that help identify problems by providing extended data (such as throughput, IOPS, queue size, and latency).

Run `iostat` by specifying triggers:

```bash
sudo iostat -dxctm 1
```

To further expand the `iostat` results, use the following parameters.

| Parameter | Action |
|--|--|
| `-d` | Display the device utilization report. |
| `-x` | Display extended statistics. This parameter is important because it provides IOPS, latency, and queue sizes. |
| `-c` | Display the CPU utilization report. |
| `-t` | Print the time for each report displayed. This parameter is useful for long runs. |
| `-m` | Display statistics in megabytes per second, a more human-readable form. |

The numeral `1` in the command tells `iostat` to refresh every second. To stop the refresh, select <kbd>Ctrl</kbd>+<kbd>C</kbd>.

If you include the extra parameters, the output resembles the following text:

```output
    [host@rhel76 ~]$ iostat -dxctm 1
    Linux 3.10.0-957.21.3.el7.x86_64 (rhel76)       08/05/2019      _x86_64_        (1 CPU)
        08/05/2019 07:03:36 PM
    avg-cpu:  %user   %nice %system %iowait  %steal   %idle
               3.09    0.00    2.28    1.50    0.00   93.14
    
    Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
    sda               0.02     0.52    9.66    2.46     0.31     0.10    70.79     0.27   23.97    6.68   91.77   2.94   3.56
    sdd               0.00     0.00    0.12    0.00     0.00     0.00    64.20     0.00    6.15    6.01   12.50   4.44   0.05
    sdb               0.00    22.90    0.47    0.45     0.01     5.74 12775.08     0.17  183.10    8.57  367.68   8.01   0.74
    sdc               0.00     0.00    0.15    0.00     0.00     0.00    54.06     0.00    6.46    6.24   14.67   5.64   0.09
    md0               0.00     0.00    0.15    0.01     0.00     0.00    89.55     0.00    0.00    0.00    0.00   0.00   0.00
```

### Understand values

The main columns from the `iostat` output are shown in the following table.

| Column | Description |
|--|--|
| `r/s` | Reads per second (IOPS) |
| `w/s` | Writes per second (IOPS) |
| `rMB/s` | Read megabytes per second (throughput) |
| `wMB/s` | Write megabytes per second (throughput) |
| `avgrq-sz` | Average I/O size in sectors; multiply this number by the sector size, which is usually 512 bytes, to get the I/O size in bytes (I/O Size) |
| `avgqu-sz` | Average queue size (the number of I/O operations queued waiting to be served) |
| `await` | Average time in milliseconds for I/O served by the device (latency) |
| `r_await` | Average read time in milliseconds for I/O served by the device (latency) |
| `w_await` | Average read time in milliseconds for I/O served by the device (latency) |

The data presented by `iostat` is informational, but the presence of certain data in certain columns doesn't mean that there's a problem. Data from `iostat` should always be captured and analyzed for possible bottlenecks. High latency could indicate that the disk is reaching a saturation point.

> [!NOTE]
> You can use the `pidstat -d` command to view I/O statistics per process.

## Network resource

Networks can experience two main bottlenecks: low bandwidth and high latency.

You can use `vnstat` to live-capture bandwidth details. However, `vnstat` isn't available in all distributions. The widely available `iptraf-ng` tool is another option to view real-time interface traffic.

### Network latency

Network latency in two different systems can be determined by using a simple `ping` command in Internet Control Message Protocol (ICMP):

```output
[root@rhel78 ~]# ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=53 time=5.33 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=53 time=5.29 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=53 time=5.29 ms
64 bytes from 1.1.1.1: icmp_seq=4 ttl=53 time=5.24 ms
^C
--- 1.1.1.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 5.240/5.291/5.339/0.035 ms
```

To stop the ping activity, select <kbd>Ctrl</kbd>+<kbd>C</kbd>.

### Network bandwidth

You can verify network bandwidth by using tools such as `iperf3`. The `iperf3` tool works on the server/client model in which the application is started by specifying the `-s` flag on the server. Clients then connect to the server by specifying the IP address or fully qualified domain name (FQDN) of the server in conjunction with the `-c` flag. The following code snippets show how to use the `iperf3` tool on the server and client.

- **Server**

  ```output
  root@ubnt:~# iperf3 -s
  -----------------------------------------------------------
  Server listening on 5201
  -----------------------------------------------------------
  ```
  
- **Client**
  
  ```output
  root@ubnt2:~# iperf3 -c 10.1.0.4
  Connecting to host 10.1.0.4, port 5201
  [  5] local 10.1.0.4 port 60134 connected to 10.1.0.4 port 5201
  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
  [  5]   0.00-1.00   sec  5.78 GBytes  49.6 Gbits/sec    0   1.25 MBytes
  [  5]   1.00-2.00   sec  5.81 GBytes  49.9 Gbits/sec    0   1.25 MBytes
  [  5]   2.00-3.00   sec  5.72 GBytes  49.1 Gbits/sec    0   1.25 MBytes
  [  5]   3.00-4.00   sec  5.76 GBytes  49.5 Gbits/sec    0   1.25 MBytes
  [  5]   4.00-5.00   sec  5.72 GBytes  49.1 Gbits/sec    0   1.25 MBytes
  [  5]   5.00-6.00   sec  5.64 GBytes  48.5 Gbits/sec    0   1.25 MBytes
  [  5]   6.00-7.00   sec  5.74 GBytes  49.3 Gbits/sec    0   1.31 MBytes
  [  5]   7.00-8.00   sec  5.75 GBytes  49.4 Gbits/sec    0   1.31 MBytes
  [  5]   8.00-9.00   sec  5.75 GBytes  49.4 Gbits/sec    0   1.31 MBytes
  [  5]   9.00-10.00  sec  5.71 GBytes  49.1 Gbits/sec    0   1.31 MBytes
  - - - - - - - - - - - - - - - - - - - - - - - - -
  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-10.00  sec  57.4 GBytes  49.3 Gbits/sec    0             sender
  [  5]   0.00-10.04  sec  57.4 GBytes  49.1 Gbits/sec                  receiver
  
  iperf Done.
  ```

Some common `iperf3` parameters for the client are shown in the following table.

| Parameter | Description                                                        |
|-----------|--------------------------------------------------------------------|
| `-P`      | Specifies the number of parallel client streams to run.            |
| `-R`      | Reverses traffic. By default, the client sends data to the server. |
| `--bidir` | Tests both upload and download.                                    |

## Memory resource

Memory is another troubleshooting resource to check because applications might or might not use a portion of memory. You can use tools such as `free` and `top` to review overall memory utilization and determine how much memory various processes are consuming:

```output
[root@rhel78 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7802         435        5250           9        2117        7051
Swap:             0           0           0
```

In Linux systems, it's common to see 99 percent memory utilization. In the `free` output, there's a column that's named `buff/cache`. The Linux kernel uses free (unused) memory to cache I/O requests for better response times. This process is called a *page cache*. During memory pressure (scenarios in which memory is running low), the kernel returns the memory that's used for the *page cache* so that applications can use that memory.

In the `free` output, the *available* column indicates how much memory is available for processes to consume. This value is calculated by adding the amounts of buff/cache memory and free memory.

You can configure the `top` command to sort processes by memory utilization. By default, `top` sorts by CPU percentage (%). To sort by memory utilization (%), select <kbd>Shift</kbd>+<kbd>M</kbd> when you run `top`. The following text shows output from the `top` command:

```output
[root@rhel78 ~]# top
top - 22:40:15 up  5:45,  2 users,  load average: 0.08, 0.08, 0.06
Tasks: 194 total,   2 running, 192 sleeping,   0 stopped,   0 zombie
%Cpu(s): 12.3 us, 41.8 sy,  0.0 ni, 45.4 id,  0.0 wa,  0.0 hi,  0.5 si,  0.0 st
KiB Mem :  7990204 total,   155460 free,  5996980 used,  1837764 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  1671420 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 45283 root      20   0 5655348   5.3g    512 R  99.7 69.4   0:03.71 tail
  3124 omsagent  20   0  415316  54112   5556 S   0.0  0.7   0:30.16 omsagent
  1680 root      20   0  413500  41552   5644 S   3.0  0.5   6:14.96 python
[...]
```
  
The `RES` column indicates *resident memory*. This represents actual process usage. The `top` tool provides a similar output to `free` in terms of kilobytes (KB).

Memory utilization can increase more than expected if the application experiences *memory leaks*. In a memory leak scenario, applications can't free up memory pages that are no longer used.

Here's another command that's used to view the top memory consuming processes:

```bash
ps -eo pid,comm,user,args,%cpu,%mem --sort=-%mem | head
```

The following text shows example output from the command:

```output
[root@rhel78 ~]# ps -eo pid,comm,user,args,%cpu,%mem --sort=-%mem | head
   PID COMMAND         USER     COMMAND                     %CPU %MEM
 45922 tail            root     tail -f /dev/zero           82.7 61.6
[...]
```

You can identify memory pressure from Out of Memory (OOM) *Kill* events, as shown in the following sample output:

```output
Jun 19 22:42:14 rhel78 kernel: Out of memory: Kill process 45465 (tail) score 902 or sacrifice child
Jun 19 22:42:14 rhel78 kernel: Killed process 45465 (tail), UID 0, total-vm:7582132kB, anon-rss:7420324kB, file-rss:0kB, shmem-rss:0kB
```

OOM is invoked after both RAM (physical memory) and SWAP (disk) are consumed.

> [!NOTE]
> You can use the `pidstat -r` command to view per process memory statistics.

## Determine whether a resource constraint exists

You can determine whether a constraint exists by using the previous indicators and knowing the current configuration. The constraint can be compared to the existing configuration.

Here's an example of a disk constraint:

> A D2s_v3 VM is capable of 48 MB/s of uncached throughput. To this VM, a P30 disk is attached that's capable of 200 MB/s. The application requires a minimum of 100 MB/s.

In this example, the limiting resource is the throughput of the overall VM. The requirement of the application versus what the disk or VM configuration can provide indicates the constraining resource.

If the application requires **\<measurement1> \<resource>**, and the current configuration for **\<resource>** is capable of delivering only **\<measurement2>**, then this requirement could be a limiting factor.

## Define the limiting resource

After you determine a resource to be the limiting factor in the current configuration, identify how it can be changed and how it affects the workload. There are situations in which limiting resources could exist because of a cost-saving measure, but the application is still able to handle the bottleneck without issues.

For example:

> If the application requires **128 GB (measurement)** of **RAM (resource)**, and the current configuration for **RAM (resource)** is capable of delivering only **64 GB (measurement)**, then this requirement could be a limiting factor.

Now, you can define the limiting resource and take actions based on that resource. The same concept applies to other resources.

If these limiting resources are expected as a cost-saving measure, the application should work around the bottlenecks. However, if the same cost-saving measures exist, and the application can't easily handle the lack of resources, this configuration might cause problems.

## Make changes based on obtained data

Designing for performance isn't about solving problems but about understanding where the next bottleneck can occur and how to work around it. Bottlenecks always exist and can only be moved to a different location of the design.

As an example, if the application is being limited by disk performance, you can increase the disk size to allow more throughput. However, the network then becomes the next bottleneck. Because resources are limited, there's no ideal configuration, and you must address issues regularly.

By obtaining data in the previous steps, you can now make changes based on actual, measurable data. You can also compare these changes against the baseline that you previously measured to verify that there's a tangible difference.

Consider the following example:

> When you obtained a baseline while the application was running, you determined that the system had a constant 100 percent CPU usage in a configuration of two CPUs. You observed a load average of 4. This meant that the system was queuing requests. A change to an 8-CPU system reduced CPU usage to 25 percent, and load average was reduced to 2 when the same load was applied.

In this example, there's a measurable difference when you compare the obtained results against the changed resources. Before the change, there was a clear resource constraint. But after the change, there are enough resources to increase the load.

## Migrate from on-premises to cloud

Migrations from an on-premises setup to cloud computing can be affected by several performance differences.

### CPU

Depending on the architecture, an on-premises setup might run CPUs that have higher clock speeds and bigger caches. The result would be decreased processing times and higher instructions-per-cycle (IPC). It's important to understand the differences in CPU models and metrics when you work on migrations. In this case, a one-to-one relationship between CPU counts might not be enough.

For example:

> In an on-premises system that has four CPUs that run at 3.7 GHz, there's a total of 14.8 GHz available for processing. If the equivalent in CPU count is created by using a D4s_v3 VM that's backed by 2.1-GHz CPUs, the migrated VM has 8.1 GHz available for processing. This represents around a 44 percent decrease in performance.

### Disk

Disk performance in Azure is defined by the type and size of disk (except for Ultra disk, which provides flexibility regarding size, IOPS, and throughput). The disk size defines IOPS and throughput limits.

Latency is a metric that's dependent on disk type instead of disk size. Most on-premises storage solutions are disk arrays that have DRAM caches. This type of cache provides sub-millisecond (about 200 microseconds) latency and high read/write throughput (IOPS).

Average Azure latencies are shown in the following table.

| Disk type                     | Latency                        |
|-------------------------------|--------------------------------|
| **Ultra disk/Premium SSD v2** | Three-digit μs (microseconds)  |
| **Premium SSD/Standard SSD**  | Single-digit ms (milliseconds) |
| **Standard HDD**              | Two-digit ms (milliseconds)    |

  > [!NOTE]
  > A disk is throttled if it reaches its IOPS or bandwidth limits, because otherwise the latency can spike to 100 milliseconds or more.

The latency difference between an on-premises (often less than a millisecond) and Premium SSD (single-digit milliseconds) becomes a limiting factor. Note the differences in latency between the storage offerings, and select the offering that better fits the requirements of the application.

### Network

Most on-premises network setups use 10 Gbps links. In Azure, network bandwidth is directly defined by the size of the virtual machines (VMs). Some network bandwidths can exceed 40 Gbps. Make sure that you select a size that has enough bandwidth for your application needs. In most cases, the limiting factor is the throughput limits of the VM or disk instead of the network.

### Memory

Select a VM size that has enough RAM for what's currently configured.

## Performance diagnostics (PerfInsights)

PerfInsights is the recommended tool from Azure support for VM performance issues. It's designed to cover best practices and dedicated analysis tabs for CPU, Memory, and I/O. You can run it either OnDemand through the Azure portal or from within the VM, and then share the data with the Azure support team.

### Run PerfInsights

PerfInsights is available for both the [Windows](how-to-use-perfinsights.md) and [Linux](how-to-use-perfinsights-linux.md) OS. Verify that your Linux distribution is in the list of [supported distributions](performance-diagnostics.md#linux) for Performance Diagnostics for Linux.

### Run and analyze reports through the Azure portal

When PerfInsights is [installed through the Azure portal](performance-diagnostics.md), the software installs an extension on the VM. Users can also install PerfInsights as an extension by going directly to [Extensions in VM blade](performance-diagnostics-vm-extension.md), and then selecting a performance diagnostics option.

#### Azure portal option 1

Browse the VM blade and select the **Performance diagnostics** option. You're asked to install the option (uses extensions) on the VM that you selected it for.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports-screen-install.png" alt-text="Screenshot that shows the Performance Diagnostics reports screen, and asks the user to install Performance diagnostics." border="false" lightbox="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports-screen-install.png":::

#### Azure portal option 2

Browse to the **Diagnose and Solve Problems** tab in the VM blade, and look for the **Troubleshoot** link under **VM Performance Issues**.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/troubleshoot-link-vm-perf-issues.png" alt-text="Screenshot that shows the Diagnose and Solve Problems tab in the VM blade, and the Troubleshoot link under VM Performance Issues." border="false" lightbox="media/troubleshoot-performance-bottlenecks-linux/troubleshoot-link-vm-perf-issues.png":::

#### What to look for in the PerfInsights report

After you run the PerfInsights report, the location of the contents depends on whether the report was run through the Azure portal or as an executable. For either option, access the generated log folder or (if in the Azure portal) download locally for analysis.

### Run through the Azure portal

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports.png" alt-text="Screenshot that shows the Performance Diagnostics reports screen and highlights the generated Diagnostics report." border="false" lightbox="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports.png":::

Open the PerfInsights report. The **Findings** tab logs any outliers in terms of resource consumption. If there are instances of slow performance because of specific resource usage, the **Findings** tab categorizes each finding as either **High** impact or **Medium** impact.

For example, in the following report, we see that **Medium** impact findings that are related to Storage were detected, and we see the corresponding recommendations. If you expand the **Findings** event, you see several key details.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perfinsights-report-findings.png" alt-text="Screenshot that shows the PerfInsights Report and details the results of the report, including Impact Level, Finding, Impacted Resources, and Recommendations." border="false" lightbox="media/troubleshoot-performance-bottlenecks-linux/perfinsights-report-findings.png":::

For more information about PerfInsights in the Linux OS, review [How to use PerfInsights Linux in Microsoft Azure](how-to-use-perfinsights-linux.md).

## More information

- [Troubleshoot Azure virtual machine performance on Linux or Windows](troubleshoot-performance-virtual-machine-linux-windows.md)

- [Performance diagnostics for Azure virtual machines](performance-diagnostics.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
