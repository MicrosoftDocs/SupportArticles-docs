---
title: Troubleshoot performance and isolate bottlenecks in Linux
description: Troubleshoot CPU, memory, and disk input and output performance, and isolate bottlenecks in Linux virtual machines
ms.date: 05/27/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-performance
author: genlin
ms.author: esflores
---
# Troubleshoot performance and isolate bottlenecks in Linux

## Performance issues and bottlenecks

Performance issues occur in different operating systems or applications, and every issue requires a unique approach to troubleshoot. Most issues are related to CPU, memory, networking, and input/output (I/O) as key areas where the issue occurs. Each of these areas generates different symptoms (sometimes simultaneously) and requires a different diagnosis and solution.

There are instances where performance problems could be caused by a misconfiguration of the application/setup. An example would be a web application with a caching layer is not correctly configured. This situation leads to more requests flowing back to the origin server, instead of being served by cache.

Another example would be when the redo log of a MySQL/MariaDB is located on the operating system (OS) disk or on a disk that is not up to the database requirements. leading to lower transactions per second (TPS) due to competition for resources.

Being able to fully understand the problem helps identifying where on the stack a misconfiguration could be leading to reduced performance. Troubleshooting performance issues requires the establishment of a *baseline*, which will serve to compare to the changes made after it, and evaluate if the overall performance improved or not.

Troubleshooting a virtual machine (VM) performance issue is no different that troubleshooting a performance issue on a physical computer; it's about finding which resource or component is causing a *bottleneck* in the system.

This guide will help you discover and resolve performance issues in Azure Virtual Machines in the Linux environment.

### Obtaining performance pointers

Performance pointers can be obtained to either confirm or deny if the resource constraint is present.

Depending on the resource being investigated, there are several tools that aid in obtaining data pertaining to said resource.

Examples are:

|Resource|Tool|
|---|---|
|CPU|top, htop|
|Disk|iostat|
|Network|vnstat, iptraf-ng|
|Memory|free|

To further expand, here are some pointers and tools to look for the four main resources.

## CPU

CPU is one resource to obtain details. Either a certain percentage of CPU is used or not, and either processes spend time in CPU (such as 80% usr usage) or not (such as 80% idle). The main tool to verify CPU usage is `top`.

The `top` tool runs in interactive mode by default, refreshing every single second, showing processes sorted by CPU usage:

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

If we look at the **dd process** line from above:

`22804 root      20   0  108096    616    516 R  99.7  0.0   1:05.71 dd`

We can see that it's consuming 100% of the CPU (note that `top` will show usage higher than 100% if the process is multithreaded and spans more than one CPU).

Another useful reference is load average (load avg). The *loadavg* shows system load average in 1-minute, 5-minute, and 15-minute intervals. The number indicates the level of load of the system and interpreting the number depends on the number of CPUs available. For example, a load average of 2 on a one-CPU system, means the system is so loaded that the processes started queuing up. If there is a load average of 2 on a four-CPU system, then there's about 50% overall CPU utilization.

In the example above, the load average is at 1.04. This is a two-CPU system, meaning there's about 50% CPU usage. This result can be confirmed by the 48% Idle CPU.

Use load average as a quick overview of how the system is performing.

## Disk

There are several terms that are important to define to better understand I/O constraints.

When dealing with I/O performance issues, the following terms help understanding where the problem resides.

- **IO Size**: The amount of data that is processed per transaction, normally defined in bytes.
- **IO Threads**: The number of processes that are interacting with the storage device, depends on the application.
- **Block Size**: Defined at the filesystem, is the amount of data that will be written to the storage device.
- **Sector Size**: The size of each of the sectors at the disk, typically 512 bytes.
- **IOPS**: Input Output Operations Per second.
- **Latency**: The amount of time an I/O Operation takes to complete.
- **Throughput**: A function of the amount of data transferred over a specific amount of time, typically defined as MB/s or megabytes per second.

### IOPS

*Input Output Operations Per Second* (IOPS) is a function of the number of input and output (I/O) operations measured over a certain amount of time, in this case seconds. I/O Operations can be either reads or writes, deletes can also be counted as an operation against the storage system. Each operation will have an allocation unit that corresponds equally to the I/O Size.

Typically defined at the application level, I/O size is the amount of data that will be written or read per transaction. A commonly seen I/O size is 4k. Smaller IO with more threads will yield higher IOPS, because each transaction can be completed relatively quick (due to its small size), allowing for more to be completed in the same amount of time.

On the contrary, with the same number of threads but with a bigger I/O size, IOPS will go down as each transaction takes longer to complete.

Consider the following example:

1000 IOPS means that each second, a thousand operations will complete, so each operation will take roughly one millisecond (there are 1000 ms in one second). In theory, each transaction will have roughly one millisecond to complete, or about 1ms latency.

Knowing the IOSize and the IOPS, we can calculate the throughput by multiplying the IOSize by the IOPS.

For example:

1000 IOPS at 4K IOSize = 4000 KB/s, or 4 MB/s (3.9 MB/s to be precise), or 1000 IOPS at 1M = 1000 MB/s, or 1 GB/s (976 MB/s being technically correct).

A more equation-friendly version would be listed as: *IOPS `*` IOSize = IOSize/s (Throughput)*

### Throughput

Contrary to IOPS, throughput is a function of amount of data over time. This means that each second a certain amount of data will be either written or read, this speed is measured in *AMOUNTOFDATA/time* or MB/s (megabytes per second).

With the throughput and IOSize, we can calculate the IOPS by dividing the throughput by the IOSize, units should be normalized to the smallest connotation, for example if IOSize is defined as KB or Kilobytes the throughput should be converted.

The equation format looks like: *THROUGHPUT / IOSize = IOPS*

To put this equation into context, consider a throughput of 10 MB/s at an IOSize of 4K, adding the numbers into the equation looks like: *10240/4=2560 IOPS*

(10 MB is equal to 10240 Kilobytes)

### Latency

Latency is the measurement of the average amount of time each operation takes to complete, IOPS and latency are connected as both are a function of time. For example, at a 100 IOPS, each operation will take roughly 10ms to complete. But the same amount of data could be fetched quicker even at lower IOPS. Latency is also known as the seek time.

### Understanding iostat output

*`iostat`* is a utility part of the sysstat package, the utility provides insights on disk performance and usage metrics. `iostat` can help identify bottlenecks related to the disk subsystem.

`iostat` is a simple command to run, as the basic syntax is:

`iostat <parameters> <time to refresh in seconds> <times to iterate> <block devices>`

The options dictate what information `iostat` provides. Without any parameter, `iostat` displays some data which might be helpful:

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

By default, `iostat` displays data for all block devices present. Additionally, little data is provided for each device. There are options available that help identify problems by providing extended data such as throughput, IOPS, queue size, and latency.

Run `iostat` with triggers:

`sudo iostat -dxctm 1`

To further expand the `iostat` results, use these variables:

- `-d`: Display the device utilization report.
- `-x`: Display extended statistics. This variable is important as it provides IOPS, Latency, and Queue Sizes.
- `-c`: Display the CPU utilization report.
- `-t`: Print the time for each report displayed. Useful for long runs.
- `-m`: Display statistics in megabytes per second. A more human readable form.

The number **1** in the command tells `iostat` to refresh every second. Select Ctrl+C to stop the refresh.

With the extra parameters, the output looks like this:

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

### Understanding values

The main columns from the `iostat` output are as follows:

- **r/s**: Reads per second (IOPS)
- **w/s**: Writes per second (IOPS)
- **rMB/s**: Read Megabytes per second (throughput)
- **wMB/s**: Write Megabytes per second (throughput)
- **avgrq-sz**: Average I/O size in sectors (the number shown here, multiply by sector size. This size is usually 512 bytes to get I/O size in bytes) (I/O Size)
- **avgqu-sz**: Average queue size (the number of I/O operations queued waiting to be served)
- **await**: Average time in milliseconds for I/O served by the device (latency)
- **r_await**: Average read time in milliseconds for I/O served by the device (latency)
- **w_await**: Average read time in milliseconds for I/O served by the device (latency)

The data presented by `iostat` is informational, but the presence of certain data in certain columns doesn't mean that there's a problem. Data from `iostat` should always be captured and analyzed for possible bottlenecks. High latency could be an indication of the disk reaching a saturation point.

## Network

There may be two main bottlenecks on a network: low bandwidth and high latency.

`vnstat` can be used to live-capture bandwidth details. However, `vnstat` is not available on all distributions. The `iptraf-ng` utility is widely available, and is another option to view real time interface traffic.

To determine latency, perform a ping.

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

To stop the ping, select Ctrl+C.

## Memory

Memory is another troubleshooting resource to check, as applications use a portion of memory or not. Tools like `free` and `top` are used to review overall memory usage and determine which processes are consuming how much memory:

```output
[root@rhel78 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7802         435        5250           9        2117        7051
Swap:             0           0           0
```

In Linux systems, it's common to see 99% memory usage. In the `free` output, there's a column called *buff/cache*. The Linux kernel will use free (unused) memory to cache I/O requests for better response times, which is called a page cache. During memory pressure (scenarios where memory is running low)the kernel will return memory used for page cache, so that it can be used by applications.

In the `free` output, the *available* column indicates how much memory is available for processes to consume. This amount is calculated by adding buff/cache and free memory.

The `top` command can be configured to sort processes by memory utilization. By default, `top` sorts by CPU percentage (%). To sort by memory utilization (%), select Shift+M when running `top`.

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
  1086 root      20   0  586440  20100   6708 S   0.0  0.3   0:02.07 tuned
  3278 root      20   0  401788  19080   4808 S   0.0  0.2   0:01.44 python
  1475 root      20   0  222764  13876   4260 S   0.0  0.2   0:00.21 python
   773 polkitd   20   0  614328  13160   4688 S   0.0  0.2   0:00.62 polkitd
 10637 nxautom+  20   0  585784  12324   3616 S   0.0  0.2   0:04.03 python
   845 root      20   0  547976   8716   6644 S   0.0  0.1   0:00.80 NetworkManager
  1472 root      20   0  222764   7992   5176 S   0.0  0.1   0:01.39 rsyslogd
 10592 nxautom+  20   0  187924   7460   3004 S   0.0  0.1   0:02.56 python
     1 root      20   0  128404   6960   4148 S   0.0  0.1   0:09.29 systemd
  1389 root      20   0  307900   6708   4884 S   0.0  0.1   0:31.47 omiagent
```
  
The RES column is the *resident memory*, which represents actual process usage. The `top` tool provides a similar output to `free` in terms of kilobytes (KB).

Memory usage can increase more than expected in scenarios where the application experiences *memory leaks*. Memory leaks refer to a problem where applications are unable to free up memory pages that are no longer used.

Here is another command used to view the top memory consuming processes:

`ps -eo pid,comm,user,args,%cpu,%mem --sort=-%mem | head`

The following is an output example:

```output
[root@rhel78 ~]# ps -eo pid,comm,user,args,%cpu,%mem --sort=-%mem | head
   PID COMMAND         USER     COMMAND                     %CPU %MEM
 45922 tail            root     tail -f /dev/zero           82.7 61.6
  3124 omsagent        omsagent /opt/microsoft/omsagent/rub  0.1  0.6
  1680 python          root     python -u bin/WALinuxAgent-  1.8  0.4
 45921 python          omsagent python /opt/microsoft/omsco  3.0  0.1
 45909 python          omsagent python /opt/microsoft/omsco  2.7  0.1
 45912 python          omsagent python /opt/microsoft/omsco  3.0  0.1
 45953 python          omsagent python /opt/microsoft/omsco 11.0  0.1
 45902 python          omsagent python /opt/microsoft/omsco  3.0  0.1
  3278 python          root     python /var/lib/waagent/Mic  0.0  0.1
```

Memory pressure can be identified from Out of Memory (OOM) *Kill* events such as the following:

```output
Jun 19 22:42:14 rhel78 kernel: Out of memory: Kill process 45465 (tail) score 902 or sacrifice child
Jun 19 22:42:14 rhel78 kernel: Killed process 45465 (tail), UID 0, total-vm:7582132kB, anon-rss:7420324kB, file-rss:0kB, shmem-rss:0kB
```

OOM is invoked once both RAM (physical memory) and SWAP (Disk memory) are consumed.

## Determining if a resource constraint exists

You can determine if a constraint exists by using the previous indicators and knowing the current configuration, as the constraint can be compared to the existing configuration.

Here is an example of a disk constraint: *"A D2s_v3 VM is capable of 48MB/s of uncached throughput, to this a P30 disk is attached which is capable of 200MBs. The application requires a minimum of 100MB/s."*

In the example above, the limiting resource is the throughput of the overall VM. The requirement of the application, versus what the disk or VM configuration can provide, shows you what is the constraining resource.

If the application requires **< insert a measurement > < insert resource >** and the current configuration for **< insert resource >** is only capable of delivering **< insert measurement >**, then this requirement could be a limiting factor.

## Defining the limiting resource

Once a resource is determined to be the limiting factor in the current configuration, identify how it can be changed and how it affects the workload. There are instances where limiting resources could exist due to a cost saving measure, but the application is still able to handle the bottleneck without issues.

For example:

"If the application requires **< 128GB (measurement) >** of **< RAM (resource) >** and the current configuration for **< RAM (resource) >** is only capable of delivering **< 64GB (measurement) >**, then this requirement  could be a limiting factor."

Now you can define the limiting resource and take actions based on that resource. The same concept applies to other resources.

If these limiting resources are expected as a cost saving measure, the workload should work around the bottlenecks. However, if the same cost saving measures exist, and the workload is unable to easily handle the lack of resources, you must address this problem.

## Perform changes based on obtained data

Designing for performance is not about solving problems. Performance problems can't be completely solved, as there will always be a limiting resource. Bottlenecks will always exist  and can only be moved to a different location of the design.

As an example, if the application is being limited by disk performance, you can increase the disk size to allow more throughput. However, the network then becomes the next bottleneck. Because resources are limited, there is no ideal configuration, and issues must be addressed regularly.

With the data obtained in the previous steps, changes can now be made based on actual, measurable data. These changes can also be compared against the baseline measured before to confirm there's a tangible difference.

Examine the following example:

"When obtaining a baseline while the application was running, it was determined that the system had a constant 100% CPU usage with a configuration of two CPUs. A load average of 4 was observed which meant the system was queuing requests. A change to an 8CPU system reduced CPU usage to 25%, and load average was reduced to 2 with the exact same load."

In the example above, there's a measurable difference when comparing the obtained results against the changed resources. Before the change, there was a clear resource constraint. But after the change, there are enough resources to increase the load

## Migrating from on-premises to cloud

Migrations from on-premises involves moving from an on-premises setup to the cloud.

There are several performance differences between on-premises computing and cloud computing:

**CPU**: Depending on the architecture, an on-premises setup might run CPUs with higher clock speeds and bigger caches, resulting in decreased processing times and higher instructions-per-cycle (IPC). It's important to understand the differences in CPU models and metrics when working on migrations. In this case, a one-to-one relationship between CPU counts might not be enough.

For example:

"A system running on-premises with four CPUs at 3.7 GHz have a total of 14.8 GHz available for processing. If the equivalent in CPU count is created using a D4s_v3 which is backed by 2.1 GHz CPUs, the migrated VM will have 8.1 GHz available for processing, or around a 44 percent decrease in performance."

**Disk**: Disk performance in Azure is defined by the type and size of disk (except for UltraSSD, which provides flexibility on size, IOPS, and throughput), and disk size defines IOPS and throughput limits.

Latency is a metric that is dependent on disk type rather than disk size. Most on-premises storage solutions are disk arrays with DRAM caches, and this type of cache provides sub-millisecond (200us~) latency and high read/write throughput (IOPS).

Average Azure latencies are:

- **UltraSSD**: 300 us to 600 us (microseconds)
- **PremiumSSD/StandardSSD**: 3 ms to 10 ms (milliseconds)
- **StandardHDD**: 50 ms to 100 ms (milliseconds)

  > [!NOTE]
  > Without the throttling feature being active, latencies can increase to 800~1000ms when throttling a disk.

The latency difference between on-premises (200 us) and PremiumSSD (3000 us or 3 ms) is prohibitive, with PremiumSSD being 94% slower (in terms of latency) than on-premises.

**Network**:
Most on-premises network setups will use 10 Gbps links. In Azure, network performance is directly defined by the size of the virtual machines (VMs) and some can exceed 40 Gpbs. Be sure that you select a size that has enough bandwidth for your application needs. In most cases, the limiting factor will be the throughput limits of the VM or disk rather than the network.

**Memory**: Select a VM size with enough RAM for what is currently configured.

### Performance Diagnostics (PerfInsights)

PerfInsights is the recommended tool from Azure support for VM performance issues. It's designed to cover best practices and dedicated analysis tabs for CPU, Memory, and I/O. You can run it either OnDemand through the Azure portal or from within the VM, and then share the data with the Azure support team.

#### Run PerfInsights

PerfInsights is available for both the [Windows](how-to-use-perfinsights.md) and [Linux](how-to-use-perfinsights-linux.md) OS. Verify that your distro is in the list of [supported distros](performance-diagnostics.md#linux) for Performance Diagnostics for Linux.

#### Run and analyze reports through Azure portal

When PerfInsights is [installed through the Azure portal](performance-diagnostics.md), the software installs an extension on the VM. Users can also install PerfInsights as an extension by going directly to [Extensions in VM blade](performance-diagnostics-vm-extension.md), and then choosing a performance diagnostics option.

##### Azure portal Option 1

Browse the VM blade and select the **Performance diagnostics** option. You'll be asked to install the option (uses extensions) on the VM that you selected it for.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports-screen-install.png" alt-text="Screenshot shows the Performance Diagnostics reports screen, and asks the user to install Performance diagnostics.":::

#### Azure portal Option 2

Browse to the **Diagnose and Solve Problems** tab in the VM blade, and look for look for the **Troubleshoot** link under **VM Performance Issues**.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/troubleshoot-link-vm-perf-issues.png" alt-text="Screenshot shows Diagnose and Solve Problems tab in the VM blade, and the Troubleshoot link under VM Performance Issues":::

#### What to look for in the PerfInsights report

After you run the PerfInsights report, the location of the contents depends on whether it was run through the Azure portal or as an executable. For either option, access the generated log folder or (if in the Azure portal) download locally for analysis.

### Run through the Azure portal

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perf-diagnostics-reports.png" alt-text="Screenshot shows the Performance Diagnostics reports screen, and highlights the generated Diagnostics report.":::

Where to start
Open the PerfInsights report. The **Findings** tab logs any outliers in terms of resource consumption. If there are instances of slow performance due to specific resource usage, the **Findings** tab will categorize it as either High Impact or Medium Impact.

For example, in the following report, we are seeing Medium impact findings related to Storage that have been detected and we have the corresponding recommendations. If you expand the **Findings** event, you'll see several key details.

:::image type="content" source="media/troubleshoot-performance-bottlenecks-linux/perfinsights-report-findings.png" alt-text="Screenshot shows the PerfInsights Report and details the results of the report, including Impact Level, Finding, Impacted Resources, and Recommendations.":::

For more information on PerfInsights in the Linux OS, review [How to use PerfInsights Linux in Microsoft Azure - Virtual Machines](how-to-use-perfinsights-linux.md).

## Additional Resources

- [Troubleshoot Azure virtual machine performance on Linux or Windows - Virtual Machines](troubleshoot-performance-virtual-machine-linux-windows.md)

- [Performance diagnostics for Azure virtual machines](performance-diagnostics.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
