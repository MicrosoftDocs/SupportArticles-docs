---
title: Obtaining Performance metrics from a Linux system
description: Learn how to obtainer Performance metrics from a Linux system.
author: divargas-msft
ms.author: esflores
editor: divargas-msft
ms.reviewer: divargas
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting-general
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 07/16/2024

---

# Obtaining Performance metrics from a Linux system

**Applies to:** :heavy_check_mark: Linux VMs

This article is going to cover instructions to determine how to quickly obtain performance metrics from a Linux System.

There are several commands that can be used to obtain performance counters on Linux. Commands such as `vmstat` and `uptime`, provide general system metrics such as CPU usage, System Memory, and System load.
Most of the commands are already installed by default with others being readily available in default repositories.
The commands can be separated into:

* CPU
* Memory
* Disk I/O
* Processes

## Sysstat utilities installation

The First step in this tutorial is to define environment variables, and install the corresponding package, if necessary.

```azurecli-interactive
export MY_RESOURCE_GROUP_NAME="myVMResourceGroup89f292"
export MY_VM_NAME="myVM89f292"
```

> [!NOTE]
> Some of these commands need to be run as `root` to be able to gather all relevant details.

> [!NOTE]
> Some commands are part of the `sysstat` package which might not be installed by default. The package can be easily installed with `sudo apt install sysstat`, `dnf install sysstat` or `zypper install sysstat` for those popular distros.

The full command for installation of the `sysstat` package on some popular Distros is:

**Ubuntu:**

### [BASH](#tab/sysstatbashubuntu)

```bash
sudo apt install sysstat -y
```

### [AZ-CLI](#tab/sysstatcliubuntu)

You could also install this package using the Run-Command extension from Azure CLI, using the following command:

```azurecli-interactive
az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts "apt install sysstat -y"
```

---

**Red Hat:**

### [BASH](#tab/sysstatbashrhel)

```bash
sudo dnf install sysstat -y
```

### [AZ-CLI](#tab/sysstatclirhel)

You could also install this package using the Run-Command extension from Azure CLI, using the following command:

```azurecli-interactive
az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts "dnf install sysstat -y"
```

---

**SUSE:**

### [BASH](#tab/sysstatbashsuse)

```bash
sudo zypper install sysstat --non-interactive
```

### [AZ-CLI](#tab/sysstatclisuse)

You could also install this package using the Run-Command extension from Azure CLI, using the following command:

```azurecli-interactive
az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts "zypper install sysstat --non-interactive"
```

---


## CPU

### <a id="mpstat"></a>mpstat

The `mpstat` utility is part of the `sysstat` package. It displays per CPU utilization and averages, which is helpful to quickly identify CPU usage. `mpstat` provides an overview of CPU utilization across the available CPUs, helping identify usage balance and if a single CPU is heavily loaded.

The full command is:

### [BASH](#tab/mpstatbash)

```bash
mpstat -P ALL 1 2
```

### [AZ-CLI](#tab/mpstatcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'mpstat -P ALL 1 2')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The options and arguments are:

* `-P`: Indicates the processor to display statistics, the ALL argument indicates to display statistics for all the online CPUs in the system.
* `1`: The first numeric argument indicates how often to refresh the display in seconds.
* `2`: The second numeric argument indicates how many times the data refreshes.

The number of times the `mpstat` command displays data can be changed by increasing the second numeric argument to accommodate for longer data collection times. Ideally 3 or 5 seconds should suffice, for systems with increased core counts 2 seconds can be used to reduce the amount of data displayed.
From the output:

```output
Linux 5.14.0-362.8.1.el9_3.x86_64 (alma9)       02/21/24        _x86_64_        (8 CPU)

16:55:50     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
16:55:51     all   69.09    0.00   30.16    0.00    0.38    0.38    0.00    0.00    0.00    0.00
16:55:51       0   77.23    0.00   21.78    0.00    0.99    0.00    0.00    0.00    0.00    0.00
16:55:51       1   97.03    0.00    0.99    0.00    0.99    0.99    0.00    0.00    0.00    0.00
16:55:51       2   11.11    0.00   88.89    0.00    0.00    0.00    0.00    0.00    0.00    0.00
16:55:51       3   11.00    0.00   88.00    0.00    0.00    1.00    0.00    0.00    0.00    0.00
16:55:51       4   83.84    0.00   16.16    0.00    0.00    0.00    0.00    0.00    0.00    0.00
16:55:51       5   76.00    0.00   23.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00
16:55:51       6   96.00    0.00    3.00    0.00    0.00    1.00    0.00    0.00    0.00    0.00
16:55:51       7  100.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
[...]

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     all   74.02    0.00   25.52    0.00    0.25    0.21    0.00    0.00    0.00    0.00
Average:       0   63.00    0.00   36.67    0.00    0.33    0.00    0.00    0.00    0.00    0.00
Average:       1   97.33    0.00    1.67    0.00    0.33    0.67    0.00    0.00    0.00    0.00
Average:       2   42.33    0.00   57.33    0.00    0.33    0.00    0.00    0.00    0.00    0.00
Average:       3   34.33    0.00   65.00    0.00    0.33    0.33    0.00    0.00    0.00    0.00
Average:       4   88.63    0.00   11.04    0.00    0.00    0.33    0.00    0.00    0.00    0.00
Average:       5   71.33    0.00   28.33    0.00    0.33    0.00    0.00    0.00    0.00    0.00
Average:       6   95.65    0.00    4.01    0.00    0.00    0.33    0.00    0.00    0.00    0.00
Average:       7   99.67    0.00    0.00    0.00    0.33    0.00    0.00    0.00    0.00    0.00
```

There are a couple of important things to note. The first line displays useful information:

* Kernel and release: `5.14.0-362.8.1.el9_3.x86_64`
* Hostname: `alma9`
* Date: `02/21/24`
* Architecture: `_x86_64_`
* Total amount of CPUs (this information is useful to interpret the output from other commands): `(8 CPU)`

Then the metrics for the CPUs are displayed, to explain each of the columns:

* `Time`: The time the sample was collected
* `CPU`: The CPU numeric identifier, the ALL identifier is an average for all the CPUs.
* `%usr`: The percentage of CPU utilization for user space, normally user applications.
* `%nice`: The percentage of CPU utilization for user space processes with a nice (priority) value.
* `%sys`: The percentage of CPU utilization for kernel space processes.
* `%iowait`: The percentage of CPU time spent idle waiting for outstanding I/O.
* `%irq`: The percentage of CPU time spent serving hardware interrupts.
* `%soft`: The percentage of CPU time spent serving software interrupts.
* `%steal`: The percentage of CPU time spent serving other virtual machines (not applicable to Azure due to no overprovisioning of CPU).
* `%guest`: The percentage of CPU time spent serving virtual CPUs (not applicable to Azure, only applicable to bare metal systems running virtual machines).
* `%gnice`: The percentage of CPU time spent serving virtual CPUs with a nice value (not applicable to Azure, only applicable to bare metal systems running virtual machines).
* `%idle`: The percentage of CPU time spent idle, and without waiting for I/O requests.

#### Things to look out for

Some details to keep in mind when reviewing the output for `mpstat`:

* Verify that all CPUs are properly loaded and not a single CPU is serving all the load. This information could indicate a single threaded application.
* Look for a healthy balance between `%usr` and `%sys` as the opposite would indicate more time spent on the actual workload than serving kernel processes.
* Look for `%iowait` percentages as high values could indicate a system that is constantly waiting for I/O requests.
* High `%soft` usage could indicate high network traffic.

### `vmstat`

The `vmstat` utility is widely available in most Linux distributions, it provides high level overview for CPU, Memory, and Disk I/O utilization in a single pane.
The command for `vmstat` is:

### [BASH](#tab/vmstatbash)

```bash
vmstat -w 1 5
```

### [AZ-CLI](#tab/vmstatcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'vmstat -w 1 5')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The options and arguments are:

* `-w`: Use wide printing to keep consistent columns.
* `1`: The first numeric argument indicates how often to refresh the display in seconds.
* `5`: The second numeric argument indicates how many times the data refreshes.

The output:

```output
--procs-- -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu--------
   r    b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st
  14    0            0     26059408          164       137468    0    0    89  3228   56  122   3   1  95   1   0
  14    1            0     24388660          164       145468    0    0     0  7811 3264 13870  76  24   0   0   0
  18    1            0     23060116          164       155272    0    0    44  8075 3704 15129  78  22   0   0   0
  18    1            0     21078640          164       165108    0    0   295  8837 3742 15529  73  27   0   0   0
  15    2            0     19015276          164       175960    0    0     9  8561 3639 15177  73  27   0   0   0
```

`vmstat` splits the output in six groups:

* `procs`: statistics for processes.
* `memory`: statistics for system memory.
* `swap`: statistics for swap.
* `io`: statistics for disk io.
* `system`: statistics for context switches and interrupts.
* `cpu`: statistics for CPU usage.

>Note: `vmstat` shows overall statistics for the entire system (that is, all CPUs, all block devices aggregated).

#### `procs`

The `procs` section has two columns:

* `r`: The number of runnable processes in the run queue.
* `b`: The number of processes blocked waiting for I/O.

This section immediately shows if there's any bottleneck on the system. High numbers on either of the columns indicate processes queuing up waiting for resources.

The `r` column indicates the number of processes that are waiting for CPU time to be able to run. An easy way to interpret this number is as follows: if the number of processes in the `r` queue is higher than the number of total CPUs, then it can be inferred that the system has the CPU heavily loaded, and it can't allocate CPU time for all the processes waiting to run.

The `b` column indicates the number of processes waiting to run that are being blocked by I/O requests. A high number in this column would indicate a system that's experiencing high I/O, and processes are unable to run due to other processes waiting to completed I/O requests. Which could also indicate high disk latency.

#### `memory`

The memory section has four columns:

* `swpd`: The amount swap memory used.
* `free`: The amount of memory free.
* `buff`: The amount of memory used for buffers.
* `cache`: The amount of memory used for cache.

> [!NOTE]
> The values are shown in bytes.

This section provides a high level overview of memory usage.

#### `swap`

The swap section has two columns:

* `si`: The amount of memory swapped in (moved from system memory to swap) per second.
* `so`: The amount of memory swapped out (moved from swap to system memory) per second.

If high `si` is observed, it might represent a system that is running out of system memory and is moving pages to swap (swapping).

#### `io`

The `io` section has two columns:

* `bi`: The number of blocks received from a block device (reads blocks per second) per second.
* `bo`: The number of blocks sent to a block device (writes per second) per second.

> [!NOTE]
> These values are in blocks per second.

#### `system`

The `system` section has two columns:

* `in`: The number of interrupts per second.
* `cs`: The number of context switches per second.

A high number of interrupts per second might indicate a system that is busy with hardware devices (for example network operations).

A high number of context switches might indicate a busy system with many short running processes, there's no good or bad number here.

#### `cpu`

This section has five columns:

* `us`: User space percent utilization.
* `sy`: System (kernel space) percent utilization.
* `id`: Percent utilization of the amount of time the CPU is idle.
* `wa`: Percent utilization of the amount of time the CPU is idle waiting for processes with I/O.
* `st`: Percent utilization of the amount of time the CPU spent serving other virtual CPUs (not applicable to Azure).

The values are presented in percentage. These values are the same as presented by the `mpstat` utility and serve to provide a high level overview of CPU usage. Follow a similar process for "[Things to look out for](#mpstat)" for `mpstat` when reviewing these values.

### `uptime`

Lastly, for CPU related metrics, the `uptime` utility provides a broad overview of the system load with the load average values.

#### [BASH](#tab/uptimebash)

```bash
uptime
```

#### [AZ-CLI](#tab/uptimecli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'uptime')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

```output
16:55:53 up 9 min,  2 users,  load average: 9.26, 2.91, 1.18
```

The load average displays three numbers. These numbers are for `1`, `5` and `15` minute intervals of system load.

To interpret these values, it's important to know the number of available CPUs in the system, obtained from the `mpstat` output before. The value depends on the total CPUs, so as an example of the `mpstat` output the system has 8 CPUs, a load average of 8 would mean that ALL cores are loaded to a 100%.

A value of `4` would mean that half of the CPUs were loaded at 100% (or a total of 50% load on ALL CPUs). In the previous output, the load average is `9.26`, which means the CPU is loaded at about 115%.

The `1m`, `5m`, `15m` intervals help identify if load is increasing or decreasing over time.

> [NOTE]
> The `nproc` command can also be used to obtain the number of CPUs.

## Memory

For memory, there are two commands that can obtain details about usage.

### `free`

The `free` command shows system memory utilization.

To run it:

#### [BASH](#tab/freebash)

```bash
free -h
```

#### [AZ-CLI](#tab/freecli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'free -h')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The options and arguments are:

* `-h`: Display values dynamically as human readable (for example: Mib, Gib, Tib)

The output:

```output
               total        used        free      shared  buff/cache   available
Mem:            31Gi        19Gi        12Gi        23Mi        87Mi        11Gi
Swap:           23Gi          0B        23Gi
```

From the output, look for the total system memory vs the available, and the used vs total swap. The available memory takes into consideration memory allocated for cache, which can be returned for user applications.

Some swap usage is normal in modern kernels as some less often used memory pages can be moved to swap.

### `swapon`

The `swapon` command displays where swap is configured and the respective priorities of the swap devices or files.

To run the command:

#### [BASH](#tab/swaponbash)

```bash
swapon -s
```

#### [AZ-CLI](#tab/swaponcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'swapon -s')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The output:

```output
Filename      Type          Size          Used   Priority
/dev/zram0    partition     16G           0B      100
/mnt/swapfile file          8G            0B      -2
```

This information is important to verify if swap is configured on a location that isn't ideal, for example on a data or OS disk. In the Azure frame of reference, swap should be configured on the ephemeral drive as it provides the best performance.

### Things to look out for

* Keep in mind the memory is a finite resource, once both system memory (RAM) and swap is exhausted, the processes are to be killed by the Out Of Memorry killer (OOM).
* Verify swap isn't configured on a data disk or the OS disk, as that would create issues with I/O due to latency differences. Swap should be configured on the ephemeral drive.
* Keep also in consideration that it's common to see on the `free -h` output that the free values are close to zero, this behavior is due to page cache, the kernel releases those pages as needed.

## I/O

Disk I/O is one of the areas Azure suffers the most when throttled, as disks can reach `100ms+` latencies. The following commands help to identify these scenarios.

### `iostat`

The `iostat` utility is part of the `sysstat` package. It displays per block device usage statistics and helps identify block related performance issues.

The `iostat` utility provides details for metrics such as throughput, latency, and queue size. These metrics help understand if disk I/O becomes a limiting factor.
To run, use the command:

#### [BASH](#tab/iostatbash)

```bash
iostat -dxtm 1 5
```

#### [AZ-CLI](#tab/iostatcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'iostat -dxtm 1 5')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The options and arguments are:

* `-d`: Per device usage report.
* `-x`: Extended statistics.
* `-t`: Display the timestamp for each report.
* `-m`: Display in MB/s.
* `1`: The first numeric argument indicates how often to refresh the display in seconds.
* `2`: The second numeric argument indicates how many times the data refreshes.

The output:

```output
Linux 5.14.0-362.8.1.el9_3.x86_64 (alma9)       02/21/24        _x86_64_        (8 CPU)

02/21/24 16:55:50
Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
sda              1.07      0.02     0.00   0.00    1.95    20.40   23.25     24.55     3.30  12.42  113.75  1081.06    0.26    537.75     0.26  49.83    0.03 2083250.04    0.00    0.00    2.65   2.42
sdb             16.99      0.67     0.36   2.05    2.00    40.47   65.26      0.44     1.55   2.32    1.32     6.92    0.00      0.00     0.00   0.00    0.00     0.00   30.56    1.30    0.16   7.16
zram0            0.51      0.00     0.00   0.00    0.00     4.00    0.00      0.00     0.00   0.00    0.00     4.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00

```

The output has several columns that aren't important (extra columns due to the `-x` option), some of the important ones are:

* `r/s`: Read operations per second (IOPS).
* `rMB/s`: Read megabytes per second.
* `r_await`: Read latency in milliseconds.
* `rareq-sz`: Average read request size in kilobytes.
* `w/s`: Write operations per second (IOPS).
* `wMB/s`: Write megabytes per second.
* `w_await`: Write latency in milliseconds.
* `wareq-size`: Average write request size in kilobytes.
* `aqu-sz`: Average queue size.

#### Things to look out for

* Look for `r/s` and `w/s` (IOPS) and `rMB/s` and `wMB/s` and verify that these values are within the limits of the given disk. If the values are close or higher the limits, the disk are going to be throttled, leading to high latency. This information can also be corroborated with the `%iowait` metric from `mpstat`.
* The latency is an excellent metric to verify if the disk is performing as expected. Normally, less than `9ms` is the expected latency for PremiumSSD, other offerings have different latency targets.
* The queue size is a great indicator of saturation. Normally, requests would be served near real time and the number remains close to one (as the queue never grows). A higher number could indicate disk saturation (that is, requests queuing up). There's no good or bad number for this metric. Understanding that anything higher than one means that requests are queuing up helps determine if there's disk saturation.

### `lsblk`

The `lsblk` utility shows the block devices attached to the system, while it doesn't provide performance metrics, it allows a quick overview of how these devices are configured and which mountpoints are being used.

To run, use the command:

#### [BASH](#tab/lsblkbash)

```bash
lsblk
```

#### [AZ-CLI](#tab/lsblkcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'lsblk')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The output:

```output
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0  300G  0 disk
└─sda1   8:1    0  300G  0 part /mnt
sdb      8:16   0   30G  0 disk
├─sdb1   8:17   0    1M  0 part
├─sdb2   8:18   0  200M  0 part /boot/efi
├─sdb3   8:19   0    1G  0 part /boot
└─sdb4   8:20   0 28.8G  0 part /
zram0  252:0    0   16G  0 disk [SWAP]
```

#### Things to look out for

* Look for where the devices are mounted.
* Verify swap it's not configured inside of a data disk or OS disk, if enabled.

> Note: An easy way to correlate the block device to a LUN in Azure is by running `ls -lr /dev/disk/azure`.

## Process

Gathering details on a per process basis helps understand where the load of the system is coming from.

The main utility to gather process statics is `pidstat` as it provides details per process for CPU, Memory, and I/O statistics.

Lastly, a simple `ps` to sort process by top CPU, and memory usage complete the metrics.

> [!NOTE]
> Since these commands display details about running processes, they need to run as root with `sudo`. This command allows all processes to be displayed and not just the user's.

### `pidstat`

The `pidstat` utility is also part of the `sysstat` package. It's like `mpstat` or iostat where it displays metrics for a given amount of time. By default, `pidstat` only displays metrics for processes with activity.

Arguments for `pidstat` are the same for other `sysstat` utilities:

* 1: The first numeric argument indicates how often to refresh the display in seconds.
* 2: The second numeric argument indicates how many times the data refreshes.

> [!NOTE]
> The output can grow considerably if there are many processes with activity.

#### Process CPU statistics

To gather process CPU statistics, run `pidstat` without any options:

##### [BASH](#tab/pidstatbash)

```bash
pidstat 1 2
```

##### [AZ-CLI](#tab/pidstatcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'pidstat 1 2')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The output:

```output
Linux 5.14.0-362.8.1.el9_3.x86_64 (alma9)       02/21/24        _x86_64_        (8 CPU)

# Time        UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
16:55:48        0        66    0.0%    1.0%    0.0%    0.0%    1.0%     0  kworker/u16:2-xfs-cil/sdb4
16:55:48        0        70    0.0%    1.0%    0.0%    0.0%    1.0%     0  kworker/u16:6-xfs-cil/sdb4
16:55:48        0        92    0.0%    1.0%    0.0%    0.0%    1.0%     3  kworker/3:1H-kblockd
16:55:48        0       308    0.0%    1.0%    0.0%    0.0%    1.0%     1  kworker/1:1H-kblockd
16:55:48        0      2068    0.0%    1.0%    0.0%    0.0%    1.0%     1  kworker/1:3-xfs-conv/sdb4
16:55:48        0      2181   63.1%    1.0%    0.0%   35.9%   64.1%     5  stress-ng-cpu
16:55:48        0      2182   28.2%    0.0%    0.0%   70.9%   28.2%     6  stress-ng-cpu
16:55:48        0      2183   28.2%    0.0%    0.0%   69.9%   28.2%     7  stress-ng-cpu
16:55:48        0      2184   62.1%    0.0%    0.0%   36.9%   62.1%     0  stress-ng-cpu
16:55:48        0      2185   43.7%    0.0%    0.0%   54.4%   43.7%     2  stress-ng-cpu
16:55:48        0      2186   30.1%    0.0%    0.0%   68.0%   30.1%     7  stress-ng-cpu
16:55:48        0      2187   64.1%    0.0%    0.0%   34.0%   64.1%     3  stress-ng-cpu
```

The command displays per process usage for `%usr`, `%system`, `%guest` (not applicable to Azure), `%wait`, and total `%CPU` usage.

##### Things to look out for

* Look for processes with high %wait (iowait) percentage as it might indicate processes that are blocked waiting for I/O, which might also indicate disk saturation.
* Verify that no single process consumes 100% of the CPU as it might indicate a single threaded application.

#### Process Memory statistics

To gather process memory statistics, use the `-r` option:

##### [BASH](#tab/pidstatrbash)

```bash
pidstat -r 1 2
```

##### [AZ-CLI](#tab/pidstatrcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'pidstat -r 1 2')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The output:

```output
Linux 5.14.0-362.8.1.el9_3.x86_64 (alma9)       02/21/24        _x86_64_        (8 CPU)

# Time        UID       PID  minflt/s  majflt/s     VSZ     RSS   %MEM  Command
16:55:49        0      2199 119244.12      0.00   13.6G    7.4G  23.5%  stress-ng-vm
16:55:49        0      2200 392911.76      0.00   13.6G    9.3G  29.7%  stress-ng-vm
16:55:49        0      2211   1129.41      0.00   72.3M    3.2M   0.0%  stress-ng-iomix
16:55:49        0      2220      0.98      0.00   71.8M    2.4M   0.0%  stress-ng-iomix
16:55:49        0      2239   1129.41      0.00   72.3M    3.2M   0.0%  stress-ng-iomix
16:55:49        0      2240   1129.41      0.00   72.3M    3.2M   0.0%  stress-ng-iomix
16:55:49        0      2256      0.98      0.00   71.8M    2.4M   0.0%  stress-ng-iomix
16:55:49        0      2265   1129.41      0.00   72.3M    3.2M   0.0%  stress-ng-iomix
```

The metrics collected are:

* `minflt/s`: Minor faults per second, this metric indicates the number of pages loaded from system memory (RAM).
* `mjflt/s`: Major faults per second, this metric indicates the number of pages loaded from disk (SWAP).
* `VSZ`: Virtual memory used in bytes.
* `RSS`: Resident memory used (actual allocated memory) in bytes.
* `%MEM`: Percentage of total memory used.
* `Command`: The name of the process.

##### Things to look out for

* Look for major faults per second, as this value would indicate a process that is swapping pages to or from disk. This behavior could indicate memory exhaustion, and could lead to `OOM` events or performance degradation due to slower swap.
* Verify that a single process doesn't consume 100% of the available memory. This behavior could indicate a memory leak.

> [!NOTE]
> the `--human` option can be used to display numbers in human readable format (that is, `Kb`, `Mb`, `GB`).

#### Process I/O statistics

To gather process memory statistics, use the `-d` option:

##### [BASH](#tab/pidstatdbash)

```bash
pidstat -d 1 2
```

##### [AZ-CLI](#tab/pidstatdcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'pidstat -d 1 2')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

The output:

```outputLinux 5.14.0-362.8.1.el9_3.x86_64 (alma9)       02/21/24        _x86_64_        (8 CPU)

# Time        UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
16:55:50        0        86     55.4k      0.0B      0.0B       0  kworker/1:1-xfs-conv/sdb4
16:55:50        0      2201      4.0k    194.1k      0.0B       0  stress-ng-iomix
16:55:50        0      2202      0.0B     99.0k      0.0B       0  stress-ng-iomix
16:55:50        0      2203      0.0B     23.8k      0.0B       0  stress-ng-iomix
16:55:50        0      2204      0.0B     15.8k      0.0B       0  stress-ng-iomix
16:55:50        0      2212      0.0B    103.0k      0.0B       0  stress-ng-iomix
16:55:50        0      2213      4.0k     99.0k      0.0B       0  stress-ng-iomix
16:55:50        0      2215      0.0B    178.2k      0.0B       0  stress-ng-iomix
16:55:50        0      2216      7.9k    237.6k      0.0B       0  stress-ng-iomix
16:55:50        0      2218      0.0B     95.0k      0.0B       0  stress-ng-iomix
16:55:50        0      2221      0.0B     15.8k      0.0B       0  stress-ng-iomix
```

The metrics collected are:

* `kB_rd/s`: Read kilobytes per second.
* `kB_wr/s`: Write kilobytes per second.
* `Command`: Name of the process.

##### Things to look out for

* Look for single processes with high read/write rates per second. This information is a guidance for processes with I/O more than identifying issues.
Note: the `--human` option can be used to display numbers in human readable format (that is, `Kb`, `Mb`, `GB`).

### `ps`

Lastly `ps` command displays system processes, and can be either sorted by CPU or Memory.

To sort by CPU and obtain the top 10 processes:

#### [BASH](#tab/psbash)

```bash
ps aux --sort=-%cpu | head -10
```

#### [AZ-CLI](#tab/pscli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'ps aux --sort=-%cpu | head -10')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

```output
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        2190 94.8  0.0  73524  5588 pts/1    R+   16:55   0:14 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2200 56.8 43.1 14248092 14175632 pts/1 R+ 16:55   0:08 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2192 50.6  0.0  73524  5836 pts/1    R+   16:55   0:07 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2184 50.4  0.0  73524  5836 pts/1    R+   16:55   0:07 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2182 44.3  0.0  73524  5808 pts/1    R+   16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2187 43.4  0.0  73524  5708 pts/1    R+   16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2199 42.9 33.0 14248092 10845272 pts/1 R+ 16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2186 42.0  0.0  73524  5836 pts/1    R+   16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2191 41.2  0.0  73524  5592 pts/1    R+   16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
```

To sort by `MEM%` and obtain the top 10 processes:

##### [BASH](#tab/psauxbash)

```bash
ps aux --sort=-%mem| head -10
```

##### [AZ-CLI](#tab/psauxcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'ps aux --sort=-%mem| head -10')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted"
```

---

```output
       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        2200 57.0 43.1 14248092 14175632 pts/1 R+ 16:55   0:08 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        2199 43.0 33.0 14248092 10871144 pts/1 R+ 16:55   0:06 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
root        1231  0.2  0.1 336308 33764 ?        Sl   16:46   0:01 /usr/bin/python3 -u bin/WALinuxAgent-2.9.1.1-py3.8.egg -run-exthandlers
root         835  0.0  0.0 127076 24860 ?        Ssl  16:46   0:00 /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
root        1199  0.0  0.0  30164 15600 ?        Ss   16:46   0:00 /usr/bin/python3 -u /usr/sbin/waagent -daemon
root           1  0.2  0.0 173208 12356 ?        Ss   16:46   0:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 31
root         966  0.0  0.0 3102460 10936 ?       Sl   16:46   0:00 /var/lib/waagent/Microsoft.GuestConfiguration.ConfigurationforLinux-1.26.60/GCAgent/GC/gc_linux_service
panzer      1803  0.0  0.0  22360  8220 ?        Ss   16:49   0:00 /usr/lib/systemd/systemd --user
root        2180  0.0  0.0  73524  6968 pts/1    SL+  16:55   0:00 stress-ng --cpu 12 --vm 2 --vm-bytes 120% --iomix 4 --timeout 240
```

## Putting all together

A simple bash script can collect all details in a single run, and append the output to a file for later use:

### [BASH](#tab/mpstatpbash)

```bash
mpstat -P ALL 1 2 && vmstat -w 1 5 && uptime && free -h && swapon && iostat -dxtm 1 1 && lsblk && ls -l /dev/disk/azure && pidstat 1 1 -h --human && pidstat -r 1 1 -h --human && pidstat -d 1 1 -h --human && ps aux --sort=-%cpu | head -20 && ps aux --sort=-%mem | head -20
```

To run, create a file with the above contents, add execute permissions by running `chmod +x gather.sh`, and run with `sudo ./gather.sh`.

This script saves the output of the commands in a file located in the same directory where the script was invoked.

### [AZ-CLI](#tab/mpstatpcli)

The following commands can be used if you want to execute it from Azure CLI:

```azurecli-interactive
output=$(az vm run-command invoke --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts 'mpstat -P ALL 1 2 && vmstat -w 1 5 && uptime && free -h && swapon && iostat -dxtm 1 1 && lsblk && ls -l /dev/disk/azure && pidstat 1 1 -h --human && pidstat -r 1 1 -h --human && pidstat -d 1 1 -h --human && ps aux --sort=-%cpu | head -20 && ps aux --sort=-%mem | head -20')
value=$(echo "$output" | jq -r '.value[0].message')
extracted=$(echo "$value" | awk '/\[stdout\]/,/\[stderr\]/' | sed '/\[stdout\]/d' | sed '/\[stderr\]/d')
echo "$extracted" 
```

---

Additionally, all the commands in the bash block codes covered in this document, can be run through `az-cli` using the run-command extension, and parsing the output through `jq` to obtain a similar output to running the commands locally.

```azurecli-interactive
az vm run-command invoke -g $MY_RESOURCE_GROUP_NAME --name $MY_VM_NAME --command-id RunShellScript --scripts "ls -l /dev/disk/azure" --query value[0].message | jq 'split("\n")'
```
