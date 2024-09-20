---
title: Troubleshoot performance CPU issues in Linux
description: Troubleshoot CPU performance issues on Linux virtual machines in Azure.
ms.service: virtual-machines
ms.custom: sap:VM Performance, linux-related-content
author: paulxjp
ms.author: jianpingxi
---
# Troubleshoot performance CPU issues in Linux

**Applies to:** :heavy_check_mark: Linux VMs

## Introduction to CPU

Monitoring CPU utilization is straightforward. From a percentage of CPU utilization in `top` utility output, to the more in-depth statistics reported by `ps` (stands for "process status") or `sar` (stands for "System Activity Report") command, it is possible to accurately determine how much CPU power is being consumed and by what.

You can obtain performance CPU metric using the tools in the following table.

|Resource|Tool|
|---|---|
|CPU|`top`, `vmstat`, `sysstat`, `pidstat`, `htop`, `mpstat`|


## top
The `top` utility is the first resource monitoring tool to provide an in-depth representation of CPU utilization, it gives you a real-time look at what’s going on with the server. Here is a top report from a 2-processor VM:

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

Some things to look for in this view would be the load average (displayed on the right side of the top row), and the value of the following for each CPU:

**load**: It refers to the number of processes which are either currently being executed by the CPU or are waiting for execution.
The load average is broken down into three time increments. The first shows the load for the last one minute, the second for the last five minutes, and the final value for the last 15 minutes.
Use the load average as a quick overview of how the system is performing.

**Tasks**

This section provides an overview of the total number of processes currently managed by the system.

**total**: Indicates the total count of processes currently being tracked by the system.

**running**: Represents the number of processes currently actively using CPU time.

**zombie**: Indicates processes that have completed execution but still have an entry in the process table.

**us**: This percentage represents the amount of CPU consumed by user processes.

**sy**: This percentage represents the amount of CPU consumed by system processes.

**id**: This percentage represents how idle each CPU is.

**wa**: This represents the percentage of CPU time spent waiting for I/O operations to complete.

In the previous example, the load average is at 1.72. This is a two-CPU system, meaning that the system load is approaching full. 

You can verify this result if you notice the 15.2 percent idle CPU value. (In the `top` command output, the idle CPU value is shown before the **id** label.)

> [!NOTE]
> You can quickly obtain the CPU count by running the `nproc` command.
```
[root@rhel8 ~]# nproc
2
```
>


> [!NOTE]
> - You can display per-CPU usage in the `top` tool by selecting <kbd>1</kbd>.
>
> - The `top` tool displays a total usage of more than 100 percent if the process is multithreaded and spans more than one CPU.
>


Now, look at the `dd` process lines from above output:

```output
PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
17038 root      20   0    8476   2984   1984 D   3.7   0.0   0:00.77 dd
17039 root      20   0    8476   2928   1916 D   3.7   0.0   0:01.14 dd
```

**%CPU** indicates CPU load percentage of a single core used. You may see this exceeds 100% which means it's occupying a full core plus another (or more).

The column **'S'** lists the state of the process. Here **"D"** state (TASK_UNINTERRUPTIBLE) is a state which occurs in a kernel code path where the execution can not be interrupted whilst a task is processed. 

An example of this might be a low level driver talking to hardware, either retrieving network packet data from NIC or accessing a block of data on a hard disk drive -- read and write I/O.

In above example it's writing to block disk using dd command.



## ps
Using `ps` to list the Top 5 CPU consuming processes:
```
# ps -eo pcpu,pmem,pid,user,args | sort -r -k1 | head -6
%CPU %MEM     PID USER     COMMAND
33.3  0.0   17039 root     dd if=/dev/zero of=/cases/file1.bin bs=1M count=2048 status=progress
21.0  0.0   17038 root     dd if=/dev/zero of=/cases/file2.bin bs=1M count=2048 status=progress
 0.6  0.3     858 root     /opt/microsoft/auoms/bin/auoms
 0.3  1.7    1057 root     /opt/microsoft/mdatp/sbin/wdavdaemon
 0.3  0.4    2034 root     /usr/libexec/platform-python -u bin/WALinuxAgent-2.11.1.4-py3.9.egg -run-exthandlers
```

<br>

The following sections discuss CPU related metrics.

## CPU resource metrics

The utilization of a CPU is mainly dependent on which resource is trying to access it. A scheduler exists in the kernel which is responsible for scheduling resources, mainly two and those are threads (single or multi) and interrupts. The scheduler gives different priorities to the different resources. Below list explain the priorities from highest to lowest.

Hardware Interrupts - These are requests created by hardware on the system to process data. This interrupt does this without waiting for current program to finish. It is unconditional and immediate. For example, a key stroke, mouse movement, a NIC may signal that a packet has been received.

Soft Interrupts - These are kernel software interrupts to do maintenance of the kernel. For example, the kernel clock tick thread is a soft interrupt. On a regular interval it checks and make sure that a process has not passed its allotted time on a processor.

Real Time Threads - A real time process may come on the CPU and preempt (or “kick off) the kernel..

Kernel Threads - A kernel thread is a kernel entity, like processes and interrupt handlers; it is the entity handled by the system scheduler. Kernel-level threads are handled by the operating system directly and the thread management is done by the kernel.

User Threads - This space is often referred to as “user land” and all software applications run in the user space. This space has the lowest priority in the kernel scheduling mechanism. In order to understand how the kernel manages these different resources, we need understand some key concepts such as context switches, run queues, and utilization.


## SAR (System Activity Reporter)

How to use SAR (System Activity Reporter) from the sysstat package to Monitor System Performance

https://access.redhat.com/solutions/276533

SAR is provided by the **sysstat** package, which also provides other statistical reporting tools, such as iostat. Note that the sysstat package is not installed by default.

Configure and enable SAR to start on boot with the below commands:
```
# systemctl enable sysstat
# systemctl start sysstat
```

<br>

**How is SAR useful?**

SAR is useful in many ways, both directly and indirectly.

* Overall barometer of system performance. When working with a system and not knowing what the "normal" state is, looking at SAR data over the last several production days is useful to establish a baseline of standard activity.

* To get a feel for CPU load, load average, memory usage, etc.

* Detecting system activity leading up to a crash or hang. Again, you can watch system statistics leading up to a fatal event.

  Did CPU or other resources usage creep up?

  Did the IO-wait climb to 100%?

* By default SAR record statistics every 10 minutes. 

<br>

**Basic Usage**

Print all CPU statistics for today:
```
# sar -t -P ALL
```

Display CPU utilization statistics from file sa10:
```
# sar -t -u -f /var/log/sa/sa10
```


## vmstat:

`vmstat` (virtual memory statistics) provides information about block IO and CPU activity in addition to memory.

vmstat will typically be called using two numerical parameters.
```
vmstat [delay] [count]
```

[delay]: specifies the refresh interval in second. 

[count]: specifies the times of refreshes. 

If you specify only one parameter, it will be taken as the refresh interval, then output will refresh unlimited.

<br>

**vmstat outputs while high I/O activity command dd is running**

The first line of the report will contain the average values since the last time the computer was rebooted. All other lines in the report will represent their respective current values. 

```
# vmstat 2
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

Meaning of the individual metrics:


**Procs**

    r: The number of processes waiting for run time.
    b: The number of processes in uninterruptible sleep.

**System**

    in: The number of interrupts per second, including the clock.
    cs: The number of context switches per second.

**CPU**

    These are percentages of total CPU time.
    us: Time spent running non-kernel code. (user time, including nice time)
    sy: Time spent running kernel code. (system time)
    id: Time spent idle.
    wa: Time spent waiting for IO.
    st: Time stolen from a virtual machine.

<br>

**How to identify which process is causing high context switches**

The `pidstat` command is used for monitoring individual  tasks  currently being managed by the Linux kernel. 

Run following command to check which process is causing issue. Like vmstat option usage, it runs 5 times with 2 seconds interval.

```
pidstat -wt 2 5
```

**-w**:  Report task switching activity

**-t**:  Display statistics for threads associated with selected tasks.

<br>

Here is an pidstat output while running stess-ng command `stress-ng --cpu 2 --switch 50 --timeout 60s` which purposely generate high CPU context switch:

<br>

**vmstat outputs while high CPU context switch is running**
```
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
107  0      0 5632724  11576 1571512    0    0    41    33   45   33  2  2 96  0  0
104  0      0 5630920  11576 1571600    0    0     0    52   30 203814 13 87  0  0  0
104  0      0 5630196  11576 1571700    0    0     0     8   29 203877 12 88  0  0  0
103  0      0 5626776  11576 1571916    0    0     0     8   42 200318 15 85  0  0  0

```

<br>

**pidstat outputs while high CPU context switch is running**

```
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

<br>

## Q & A scenario
<details>
<summary> Q: I need root cause of a high CPU issue occurring in the past or intermittently, is it possible or what logs do we need? </summary>
<BR>
A: Is sysstat enabled and running? Do we have the sar logs (which is also included in sosreport log bundle) while issue is occurring?
   Without sysstat running active, which means there is no baseline we can use for comparison if a performance issue arises, it will be hard to tell how much the performance downgrade during peak usage periods.
   If you are using 3rd-party monitoring tools, explains how it works because we need understand and compare it with the metrics retrieved from native Linux command tools.

</details>

<details>
<summary> Q: The VM is currently going through high CPU usage. </summary>
<BR>
A: Using the tools mentioned (top, ps, vmstat) to identify the issue.
</details>

<details>
<summary> Q: I have identified the high CPU process, is there any way to debug it? </summary>
<BR>
A: The following code obtain the the list of threads and show the stack of each thread of Top 3 High CPU processes:
    
```
   for H_PID in $(ps -eo pcpu,pid,ppid,user,args | sort -k1 -r | grep -v PID | head -3 | awk '{print $2}'); do ps -Llp $H_PID; sudo cat /proc/$H_PID/stack; echo; done
```
</details>

<details>
<summary> Q: The high CPU issue occurs intermittently and keeps very short time every few minutes. We also have the sosreport with sysstat enabled. </summary>
<BR>
A: The default SAR collection interval is 10 minutes, if the issue is occurring in a very short time, SAR may not reveal the problem because the metric result is aggregated.
   If the default 10 minute interval isn't giving the resolution needed, remember that SAR's time interval can be tuned so that is appropriate for the problem.
</details>
