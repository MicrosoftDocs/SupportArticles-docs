---
title: Troubleshoot high Memory Usage issues in Linux
description: Troubleshoot Memory performance issues on Linux virtual machines in Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Performance, linux-related-content
ms.topic: troubleshooting
ms.collection: linux
author: malachma
ms.author: malachma
ms.date: 05/06/2025
---
# Troubleshoot Memory performance issues in Linux

**Applies to:** :heavy_check_mark: Linux VMs

This article describes how to troubleshoot Memory performance issues on Linux virtual machines in Azure. 

When you work on a memory related issues, the first step is to understand how memory is being used by the applications hosted on the system. This includes analyzing their workload patterns and verifying whether the system is configured appropriately. This helps to determine if the available memory on the system is sufficient. Then you may need to consider scaling the virtual machine (VM), or choosing between a NUMA (Non-Uniform Memory Access) and UMA (Uniform Memory Access) architecture. Also it's worth to think about whether the application performance would benefit from Transparent Huge Pages (THP). The best approach is to collaborate with the application vendor to understand the recommended memory requirements.

## Key areas impacted by memory

- **Process Memory Allocation** - Memory is a resource which every proces including the kernel does require. The amount of memory needed depends on the process's design and purpose. Memory is usually assigned to either the stack or the heap. For example, in-memory databases like SAP HANA rely heavily on memory to store and process data efficiently.

- **Page Cache Usage** - Memory can also indirectly be consumed via an increase of the page cache. The page cache is an in memory representation of a file which is read from a disk before. It heples avoid repeated disk reads. The best example is a file server which does benefit from this underlying kernel functionality.

- **Memory Architecture** - It's important to be aware of what application or applications are running on the same virtual machine (VM), and whether they might compete for the available memory. You might also need to check if the VM is configured with Non-Uniform Memory Access (NUMA) or Uniform Memory Access (UMA) architecture. Depending on the memory requirements of a process, it might be to prefer an UMA architecture. Where the complete RAM can be address without a penalty, on the other hand, for HPC with many small processes or processes fitting in one of the NUMA-Nodes you can benefit from the CPU cache-locality. 

- **Memory Overcommitment** - Another point to keep in mind is whether the kernel allows memory overcommitment. Depending on its configuration, every memory request is fulfilled. Or it's denied if the amount of memory requested isn't available.

- **Swap Space** The last point is the availability of swap space. Enabling swap improves overall system stability by providing a buffer during low-memory conditions that helps the system remain resilient under pressure. For more information, see the [kernel doc](https://docs.kernel.org/admin-guide/mm/concepts.html#concepts-overview)

## Understand the memory troubleshooting tools

### free

To view the amount of available and used memory on a system, use the `free` command.

![sample free output](media/troubleshoot-performance-memory-linux/free.png)

It provides a summary of reserved and available memory including total and used swap space.

### pidstat and vmstat

For a more detailed view of memory usage by individual processes, use the `pidstat -r` command.
![Sample pidstat -r output](media/troubleshoot-performance-memory-linux/pidstat.png)

When you analyze memory usage report, two important columns to observe are `VSZ`, `RSS`:

- VSZ (Virtual Set Size) shows the total amount of virtual memory reserved by a process in kilobytes.
- RSS (Resident Set Size) indicates how much of that memory is currently held in RAM (for example., committed memory).
  
Another useful metric is `majflt/s` (The number of major page faults per second) shows how often a memory page has to be read from a SWAP device. If there are concerns about high usage of SWAP, verify its usage with the tool `vmstat` to monitor the page-in and page-out statistics over a period of time.

**Sample vmstat output**
![Sample vmstat output](media/troubleshoot-performance-memory-linux/vmstat.png)

In this sample case, you may observe a high number of memory pages being read from or written to swap. These high numbers typically indicates that the system is running low on available memory.The cause could be multiple processes competing for memory or available memory cannot be used by most applications. One common reason for unavailable memory is the use of HugePages. HugePages are reserved memory. Only applications capable of utilizing HugePages can use this type of memory. For any other process, this memory isn't useable. In situations, you may need to evaluate whether HugePages are truly required for your applications. whether you require HugePages for your applications or whether they can also work with Transparent Huge Pages (THP). Alternatively, consider using Transparent Huge Pages (THP) which allow the kernel to manage large memory pages dynamically. For example, the Java Virtual Machine (JVM) can take advantage of THP by enabling the flag:
`-XX:+UseTransparentHugePages`. For more details about THP, see [Transparent HugePage Support](https://docs.kernel.org/admin-guide/mm/transhuge.html)
For information about HugePages, see [HugeTLB Pages](https://docs.kernel.org/admin-guide/mm/hugetlbpage.html)

### Testing THP usage with a sample program

To observe how THP are used by the system, you can run a small C program that allocates approximately 256 MB of RAM. The program uses the `madvise` system call to inform the kernel that the allocated memory should be treated as a single, contiguous region—enabling THP where supported.

```C
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

#define LARGE_MEMORY_SIZE (256 * 1024 * 1024) // 256MB

int main() {
    char str[2];

    // Allocate a large memory area
    void *addr = mmap(NULL, LARGE_MEMORY_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);


    if (addr == MAP_FAILED) {
        perror("mmap");
        return 1;
    }


    // Use madvise to give advice about the memory usage
    if (madvise(addr, LARGE_MEMORY_SIZE, MADV_HUGEPAGE) != 0) {
        perror("madvise");
        munmap(addr, LARGE_MEMORY_SIZE);
        return 1;
    }

    // Initialize the memory
    int *array = (int *)addr;
    for (int i = 0; i < LARGE_MEMORY_SIZE / sizeof(int); i++) {
        array[i] = i;
    }

    memset(addr, 0, LARGE_MEMORY_SIZE);

    printf("Press Enter to continue\n");
    fgets(str,2,stdin);

    // Clean up
    if (munmap(addr, LARGE_MEMORY_SIZE) == -1) {
        perror("munmap");
        return 1;
    }

    return 0;
}
```

If you the program, it isn't directly visible whether THP is used by the program or not.
You can check overall THP usage on the system via `/proc/meminfo`. Check the `AnonHugePages` field to determine the amount of memory using THP. This file only provides system-wide statistics. 

To find out whether a process uses THP, you have to inspect the `smaps` file in the `/proc` directory of the process in question. For example `/proc/2275/smaps` and search for a line containing the word `heap`
![THP usage by the sample C program](media/troubleshoot-performance-memory-linux/thp.png)

In this example, we can see that a large memory segment has been allocated and marked as `THPeligible`(THP are in use). With `madvice syscall`, the memory allocation is much more efficient to allocate this memory block, as one could do with HugePages. Depending on the size of the allocation, the kernel may assign either standard 4 KB pages or larger contiguous blocks. This optimization can improve performance for memory-intensive applications.

For more information, see [Transparent Hugepage Support](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html).

### NUMA

When the applicaitons are running on a NUMA (Non-Uniform Memory Access) system with multiple nodes, it's important to know how much memory is available on each node. Although all nodes can access the system's total memory, performance is typically best when a process uses memory that resides on the same NUMA node as the CPU executing it.

If a memory request cannot be fulfilled by the local node, the system allocates memory from another node. However, accessing memory across nodes introduces latency and can lead to performance penalties.

To optimize performance, monitor memory locality and ensure that workloads are aligned with the memory resources of their assigned NUMA nodes.

If you run on a NUMA system with more than one node available, it's also important to know what is the memory size each node does have. The complete available memory to the system can be addressed by each of the available nodes. Though, the best performance you get if the processes running on a particular NUMA NODE operate on the memory which is under direct control of this NODE. If, for example, a new memory request can't be fulfilled on the current node the memory is taken from another node. But operations on this part of the newly requested memory do imply a performance penalty. 

The following is a sample of the system's NUMA configuration.

![numactl output](media/troubleshoot-performance-memory-linux/numactl.png)

The configuration shows that accessing memory within the same Node does have distance level of 10. If you want to access memory on `Node 1` from `Node 0` has a higher distance value of 12 that are still manageable. But if you want to access memory on `NODE 3` from `NODE 0` (it's doable)， the distance level will become 32 which means three times slower to operate on memory. These differences are important to consider when diagnosing performance issues or optimizing memory-bound workloads.
See [document](https://www.kernel.org/doc/html/latest/admin-guide/mm/numaperf.html) for further details. For a description of the `numactl` tool, see [numactl(8)](https://man7.org/linux/man-pages/man8/migratepages.8.html).

To figure out whether there's a realignment of processes and a different Node required use the `numastat` tool. Its doc is located at [numastat(8)](https://man7.org/linux/man-pages/man8/numastat.8.html). With the help of `migratepages` tool [migratepages(8)](https://man7.org/linux/man-pages/man8/migratepages.8.html) one can then try to move the memory pages to the right NODE.

### Overcommitment

 Overcommitment is a crucial design decision and has a drastic effect on the functionality of the system performance or its stability. The Linux kernel supports three modes:
- 'Heuristic'
- 'Always overcommit'
- 'Don't overcommit'
  
By default the `Heuristic` scheme is used. This mode offers a balanced trade-off between always allowing memory overcommitment and strictly denying it. For more information, see the [kernel documentation](https://www.kernel.org/doc/Documentation/vm/overcommit-accounting).

An incorrect setting could be the reason memory pages fail to allocate, potentially affecting the creation of new processes or preventing internal kernel structures from obtaining sufficient memory.

If it’s confirmed that the issue is related to memory allocation, it may indicate that there are not enough resources left for the kernel. In such a situation the OOM killer might kick in to free some of the pages to make them available to kernel tasks or requests from other applications which would like to write a page or more. If there are signs of OOM killer activities, it's actually a signal to the administrator that the system is already on its limits. This means there are too many processes running or some have high memory requirements - if a memory leak can be excluded. The VM size needs to be increased or some of the applications needs to be hosted on a different server.

What information are logged if the OOM had to intervene? Given is the following simple C program to allocate memory and set  default value

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ONEGB (1 << 30)
int main() {
        int count = 0;
        while (1) {
                int *p = malloc(ONEGB);
              if (p == NULL) {
                printf("malloc refused after %d GB\n", count);
                return 0;
               }
        memset(p,1,ONEGB);
        printf("got %d GB\n", ++count);
     }
}
```

The program is utilizing too much of the available memory. It isn't possible to allocate more than 3G of memory.
![memory allocation error](media/troubleshoot-performance-memory-linux/malloc-error.png)
The information from the OOM we find on the console or simply with the command `dmesg`.
It starts with this detail at the beginning of the trace.
![invoked OOM killer](media/troubleshoot-performance-memory-linux/malloc-invoked-oom.png)
And ends with the following lines.
![out of memory](media/troubleshoot-performance-memory-linux/malloc-out-of-memory.png)
In between, the following content is displayed.
![OOM full detail #1](media/troubleshoot-performance-memory-linux/memory-details-1.png)
![OOM full detail #2](media/troubleshoot-performance-memory-linux/memory-details-2.png)


The important information we get from it are the following
```
4194160 kBytes physical memory 
No swap space
3829648 kBytes are in use
```

The malloc process requested a single page (4 KB) --> order=0, one single page sounds not much, when we look at the following lines there should be plenty of memory available
![lowmem reserv](media/troubleshoot-performance-memory-linux/lowmem-reserve.png)


On the first glimpse, there should be enough pages left. Let us further examine the situation. Memory is taken from the Normal Zone. Available memory is 29,500 kB, though the min value is 34628 kB. We are below the min-watermark, in that case only the kernel would be able to use the memory for any internal data structure. A user-space application isn't entitled to get the pages. At this point, the OOM gets involved finding a process which has the highest oom_score and also is utilizing most of the memory. The identified process is the one which gets scarified then. In the picture above you see that the oom_score for the malloc process is 0 and the RSS size is 917760. 
Among all the other processes, it has the highest RSS size.


Spotting an OOM issue is easy as the relevant information are printed on the console or in the system log. Allowing the administrator to reason about why the OOM did happen. 
But what about a steady increase  of memory usage, which don't turn into an OOM? What can be used to make the administrator aware of it?
A good tool to see how the memory does grow over a period of time is the 'sar' tool from the sysstat package. To focus on the memory details only, use the option 'r' --> 'sar -r'
Look at this example
![sar memory information](media/troubleshoot-performance-memory-linux/sar-info.png)

Here we see that memory usage does grow for about 2h. After, it suddenly returns to just 4% of memory utilization. It could be a normal application behavior and it should be investigated over some days when those spikes do occur. Maybe in the morning many users sign in to a specific application. Or there's a cron job running at this time per day or week. Another reason could be a reporting engine which requires much resources when reports are scheduled. In short, memory utilization isn't a bad thing by itself, instead it depends on the application or the applications running on this VM. Without this knowledge, it isn't possible to do a proper RCA in order to explain a high memory consumption.

If we would like to find out more about which process is responsible eating up all your available memory the 'pidstat' tool could be of help.
![pidstat output](media/troubleshoot-performance-memory-linux/pidstat-memory.png)

It prints all running processes and their statistics. Another approach is to use the 'ps' tool to get similar  `ps aux --sort=-rss | head -n 10`
![ps aux output](media/troubleshoot-performance-memory-linux/ps-aux.png)

Why do we sort on rss? RSS stands for 'Resident Set Size' the nonswapped physical memory that a task does use. VSZ is the 'Virtual Set Size' which contains the amount of memory the process reserved but not committed. Committed means that a page is written to the physical memory. So if we're interested which of the processes are occupying most of the available memory (physical + swap) we have to have a look at the RSS size of a process. In the screenshot above it looks like that 'snapd' does occupy much memory, though if we look at the RSS column we see that the process isn't that significant. On the other hand, there's a process named 'malloc' which has the same size of VSZ and RSS. So this one is indeed utilizing over 1.3G of memory. 



