---
title: Troubleshoot high CPU Usage issues in Linux
description: Troubleshoot CPU performance issues on Linux virtual machines in Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Performance, linux-related-content
ms.topic: troubleshooting
ms.collection: linux
author: paulxjp
ms.author: jianpingxi
ms.reviewer: divargas
ms.date: 09/30/2024
---
# Troubleshoot CPU performance issues in Linux

**Applies to:** :heavy_check_mark: Linux VMs

This article explains how to troubleshoot CPU performance issues on Azure Linux virtual machines (VMs) using performance monitoring utilities. The following utilities can be used to monitor CPU performance:

|Resource|Utilities|
|---|---|
|CPU|`top`, `vmstat`, `sysstat`, `pidstat`, `htop`, `mpstat`|

## top

The `top` utility is a primary CPU monitoring tool that offers a detailed view of CPU utilization. It provides real-time insights into server performance. The following is an example of a `top` report from a VM with two CPU cores:

```output
top - 03:12:38 up  1:53,  3 users,  load average: 1.72, 0.62, 0.25
Tasks: 198 total,   1 running, 197 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.3 us,  1.4 sy,  0.0 ni, 15.2 id, 82.5 wa,  0.2 hi,  0.3 si,  0.0 st
MiB Mem :   7697.8 total,   3672.6 free,    576.6 used,   3448.5 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   6838.4 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  17038 root      20   0    8476   2984   1984 D   3.7   0.0   0:00.77 dd
  17039 root      20   0    8476   2928   1916 D   3.7   0.0   0:01.14 dd
  16979 root      20   0       0      0      0 D   1.3   0.0   0:00.14 kworker+
    858 root      20   0 1176440  31088   4580 S   0.7   0.4   0:43.16 auoms
   1679 omsagent  20   0  350232  68976   9944 S   0.7   0.9   0:18.52 omsagent
    521 root      20   0       0      0      0 S   0.3   0.0   0:00.05 xfsaild+
  16018 root      20   0       0      0      0 I   0.3   0.0   0:00.29 kworker+
  16933 root      20   0   54400   4384   3756 R   0.3   0.1   0:00.21 top
      1 root      20   0  175948  14356   9180 S   0.0   0.2   0:04.02 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.10 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par+
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 slub_fl+
      7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker+
     10 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_perc+
     11 root      20   0       0      0      0 S   0.0   0.0   0:00.00 rcu_tas+
     12 root      20   0       0      0      0 S   0.0   0.0   0:00.00 rcu_tas+

```

Key metrics:

- `load average` (located on the right side of the top row): Represents the average number of processes that are either running or waiting for CPU time over specific time intervals. In the example `load average: 1.72, 0.62, 0.25`, it represents:

    - 1.72: The average load over the last 1 minute.
    - 0.62: The average load over the last 5 minutes.
    - 0.25: The average load over the last 15 minutes.
- `Tasks total`: Provides an overview of the total number of processes currently loaded in the system.
- `running`: The number of processes actively using CPU time.
- `zombie`: Processes completed execution but still have an entry in the process table.
- `us`: Percentage represents the amount of CPU consumed by user processes.
- `sy`: Percentage represents the amount of CPU consumed by system processes.
- `id`: Percentage represents how idle each CPU is.
- `wa`: Percentage of CPU time spent waiting for I/O operations to complete.

### Analyze the report

This VM contains two CPU cores, so a load average of 2.0 would mean that both cores are fully utilized. In this example, the `load average` over the last 1 minute is 1.72, which indicates that the system load is approaching its full capacity. The `15.2 id` value also indicates that the CPU is operating at low capacity, with an idle rate of 15.2% for CPUs.

> [!TIP]
> - You can quickly determine the CPU count by running the `nproc` command.
> - To display per-CPU usage in the `top` report, press the 1 key.
> - If a process is multithreaded and spans multiple CPUs, the top report will display a total usage exceeding 100%.

Next, check the `dd` process lines in the example output:

```output
PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
17038 root      20   0    8476   2984   1984 D   3.7   0.0   0:00.77 dd
17039 root      20   0    8476   2928   1916 D   3.7   0.0   0:01.14 dd
```

- `%CPU`: Indicates the CPU load percentage for a single core. You may see the value exceeds 100%, which means it is occupying a full CPU core and other CPU cores.

- `S`: Lists the state of the process. Here `D` state (TASK_UNINTERRUPTIBLE) is a state which occurs in a kernel code path where the execution can't be interrupted while a task is processed.

An example of `D` state might be a low level driver interacts with hardware, which includes:

- Retrieve network packet data from network interface card.
- Access a block of data on a hard disk drive.

## ps

The `ps` command displays running processes and can be sorted by CPU or memory. You can use the following `ps` command  to list the top five CPU consuming processes:

```bash
sudo ps -eo pcpu,pmem,pid,user,args | sort -r -k1 | head -6
```

Example of the output

```output
%CPU %MEM     PID USER     COMMAND
33.3  0.0   17039 root     dd if=/dev/zero of=/cases/file1.bin bs=1M count=2048 status=progress
21.0  0.0   17038 root     dd if=/dev/zero of=/cases/file2.bin bs=1M count=2048 status=progress
 0.6  0.3     858 root     /opt/microsoft/auoms/bin/auoms
 0.3  1.7    1057 root     /opt/microsoft/mdatp/sbin/wdavdaemon
 0.3  0.4    2034 root     /usr/libexec/platform-python -u bin/WALinuxAgent-2.11.1.4-py3.9.egg -run-exthandlers
```

### CPU resource metrics

The utilization of a CPU is dependent on which resource is trying to access it. A scheduler exists in the kernel which is responsible for scheduling resources. It gives different priorities to the different resources. The next lists explain the priorities from highest to lowest.

- `Hardware Interrupts` - requests created by hardware on the system to process data. Hardware interrupt sends requests without waiting for current program to finish. It's unconditional and immediate. For example, it could be a key stroke, mouse movement, a Network Card Interface signal when a packet arrived.

- `Soft Interrupts` - kernel software interrupts to do maintenance of the kernel. For example, the kernel clock tick thread is a soft interrupt. On a regular interval, it checks and makes sure that a process doesn't pass its allotted time on a processor.

- `Real Time Threads` - real time processes may come on the CPU and preempt the kernel.

- `Kernel Threads` - A kernel thread is a kernel entity, like processes and interrupt handlers. It's the entity handled by the system scheduler. The operating system handles Kernel-level threads directly.

- `User Threads` - This space is often referred to as "user land" and all software applications run in the user space. This space has the lowest priority in the kernel scheduling mechanism. In order to understand how the kernel manages these different resources, we need understand some key concepts such as context switches, run queues, and utilization.

### sar

The `sar` utility is provided by the **sysstat** package, which also provides other statistical reporting tools, such as `iostat`. The `sysstat` package isn't installed by default. 

To configure and enable `sar` to start on boot, run the following command:

```bash
sudo systemctl enable sysstat
sudo systemctl start sysstat
```

### How to use sar

The `sar` provides value in various ways, both directly and indirectly:

- It's an overall barometer of system performance. When working with a system without a clear understanding of its "normal" state, check `sar` data from the past few days is useful to establish a baseline of standard activity.
- It offers insights into CPU load, load average, memory usage, etc.
- It detects system activity that may lead to a crash or hang. This allows you to monitor system statistics prior to a critical event.
- It records statistics every 10 minutes by default.

**Basic Usage**

Display detailed CPU usage statistics for all processors on the VM:

```bash
sudo sar -t -P ALL
```

Display CPU utilization statistics from the log file `sa10`:
```bash
sar -t -u -f /var/log/sa/sa10
```
For more information, see [Use sar to Monitor Resources in Linux](https://access.redhat.com/solutions/276533)

## vmstat

The `vmstat` utility provides a high-level overview of CPU, memory, and disk I/O utilization in a single pane.

Typically runs it with the following two numerical parameters:

```bash
vmstat [delay] [count]
```

- `delay`: specifies the refresh interval in seconds.

- `count`:  Defines how many times the output refreshes.

If you provide only one parameter, it’s treated as the refresh interval, and the output will refresh on an infinite loop.

### Outputs example during high I/O activity command `dd` is running

In the following example, the first line of the report `2 3 0 33639696 ...` contains the average values since the last time the computer was rebooted. All other lines in the report represent their respective current values. 

```bash
vmstat 2 5
```

```output
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 2  3      0 3639696   9500 3634812    0    0    43   326   45  357  2  1 96  1  0
 0  3      0 3452428   9500 3821728    0    0     0 71700  127  972  1  2  1 96  0
 1  3      0 3266588   9500 4011400    0    0     0 68612  144 1266  2  4  6 88  0
 0  3      0 3096384   9500 4181596    0    0     0 107520  114  952  1  2  4 93  0
 0  3      0 2931908   9500 4346168    0    0     0 74770   81  759  0  1  0 98  0
 1  2      0 2765040   9500 4512992    0    0     0 61442   73  756  0  2  4 94  0
 0  3      0 2608596   9500 4669520    0    0     0 74758  111  862  1  1  6 92  0
 0  3      0 2440972   9500 4836968    0    0     0 108544   91  789  0  2  1 97  0

```

**Procs**

- r: The number of processes waiting for run time.
- b: The number of processes in uninterruptible sleep.

**System**

- in: The number of interrupts per second, including the clock.
- cs: The number of context switches per second.

**CPU**

These are percentages of total CPU time.

- us: Time spent running non-kernel code. (user time, including nice time)
- sy: Time spent running kernel code. (system time)
- id: Time spent idle.
- wa: Time spent waiting for IO.
- st: Time stolen from a virtual machine.

### How to identify which process is causing high context switches

To identify which process is causing high I/O activity, you can use the `pidstat` command.  It monitors individual tasks currently which the Linux kernel manages.

Run following command to check which process is causing issue. Like `vmstat` option usage, it runs **five** times with **2-second** interval.

```bash
sudo pidstat -wt 2 5
```

- `-w`:  Report task switching activity.
- `-t`: Display statistics for threads associated with selected tasks.

The following are the `vmstat` rerport and  the `pidstat` output while running `stess-ng` command `stress-ng --cpu 2 --switch 50 --timeout 60s` which purposely generate high CPU context switch:

**vmstat outputs while high CPU context switch is running**

```output
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
107  0      0 5632724  11576 1571512    0    0    41    33   45   33  2  2 96  0  0
104  0      0 5630920  11576 1571600    0    0     0    52   30 203814 13 87  0  0  0
104  0      0 5630196  11576 1571700    0    0     0     8   29 203877 12 88  0  0  0
103  0      0 5626776  11576 1571916    0    0     0     8   42 200318 15 85  0  0  0

```

**pidstat outputs while high CPU context switch is running**

```output
Linux 4.18.0-553.16.1.el8_10.x86_64 (rhel8)     09/19/2024      _x86_64_       (2 CPU)

06:05:09 AM   UID      TGID       TID   cswch/s nvcswch/s  Command

06:11:38 AM     0     32321         -    728.09      0.53  stress-ng-switc
06:11:38 AM     0         -     32321    728.09      0.53  |__stress-ng-switc
06:11:38 AM     0     32322         -    853.80      0.62  stress-ng-switc
06:11:38 AM     0         -     32322    853.80      0.62  |__stress-ng-switc
06:11:38 AM     0     32323         -    744.08      0.27  stress-ng-switc
06:11:38 AM     0         -     32323    744.08      0.27  |__stress-ng-switc
06:11:38 AM     0     32324         -    708.30      0.18  stress-ng-switc
06:11:38 AM     0         -     32324    708.30      0.18  |__stress-ng-switc
06:11:38 AM     0     32325         -    804.77      0.27  stress-ng-switc
06:11:38 AM     0         -     32325    804.77      0.27  |__stress-ng-switc
06:11:38 AM     0     32326         -    907.16      0.62  stress-ng-switc
06:11:38 AM     0         -     32326    907.16      0.62  |__stress-ng-switc
06:11:38 AM     0     32327         -    789.05      0.62  stress-ng-switc
06:11:38 AM     0         -     32327    789.05      0.62  |__stress-ng-switc

```

## Frequently Asked Questions

### How to identify the root cause of a high CPU issue that has occurred recently or intermittently. What logs should I check?

To identify the root cause of the high CPU issue, the performance monitor tool like `sysstat` must be enabled and running during the issue occurs, and we need the sar logs (included in the `SOSREPORT` log bundle) from the time the issue occurred.

Without the sar logs, we cannot establish a baseline for comparison when a performance issue occurs. This makes it challenging to determine how much performance downgrade during peak usage periods.

If you are using third-party monitoring tools, provide details about these tools when contacting our support team. Understanding the details such metrics is essential for comparing them with data retrieved from native Linux command-line tools.

### The VM is currently experiencing high CPU usage. How can I identify the root cause?

You can utilize the tools in a script to identify the issue. You can use tools like top and ps to identify the issue, as explained in this article.

### I identified the high CPU process. Is there any way to debug it?

You use the following script to retrieves the list of threads. It shows the stack of each thread of top three high CPU processes:
    
```bash
for H_PID in $(ps -eo pcpu,pid,ppid,user,args | sort -k1 -r | grep -v PID | head -3 | awk '{print $2}'); do ps -Llp $H_PID; sudo cat /proc/$H_PID/stack; echo; done
```

### The high CPU issue occurs intermittently and persists for a short time every few minutes. We have the `sosreport` with `sysstat` enabled. How can I check the sar log to identify the root cause?

The default `sar` collection interval is 10 minutes. If the issue is occurring in a short time, `sar` may not reveal the problem because the metric result is aggregated.
If the default 10-minute interval isn't giving the resolution needed, You can adjust `sar`'s time interval to make it suitable for the problem.

