---
title: Troubleshoot High Memory Usage Issues in Linux
description: Troubleshoot memory performance issues on Linux virtual machines in Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Performance, linux-related-content
ms.topic: troubleshooting
ms.collection: linux
author: malachma
ms.author: malachma
ms.date: 05/06/2025
---
# Troubleshoot memory performance issues in Linux

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses how to troubleshoot memory performance issues that occur on Linux virtual machines (VMs) in Microsoft Azure. 

The first step to working on memory-related issues is to understand how memory is used by the applications that are hosted on the system. You can begin by analyzing workload patterns and determining whether the system is configured correctly. This step helps you to evaluate the appropriate level of available memory on the system. Next, you might have to consider scaling the VM or choosing between a NUMA (Non-Uniform Memory Access) and UMA (Uniform Memory Access) architecture. Also, it's worthwhile to consider whether the application performance would benefit from Transparent Huge Pages (THP). The best approach is to collaborate with the application vendor to understand the recommended memory requirements.

## Key areas affected by memory

- **Process Memory Allocation** - Memory is a necessary resource for every process, including the kernel. The amount of memory that's required depends on the process design and purpose. Memory is usually assigned to either the stack or the heap. For example, in-memory databases such as SAP HANA rely heavily on memory to store and process data efficiently.

- **Page Cache Usage** - Memory can also be consumed indirectly through an increase of the page cache. The page cache is an in-memory representation of a file that was previously read from a disk. This cache helps avoid repeated disk reads. The best example of this process is a file server that benefits from this underlying kernel functionality.

- **Memory Architecture** - It's important to know which application or applications are running on the same VM, and whether they might compete for the available memory. You might also have to check whether the VM is configured by using Non-Uniform Memory Access (NUMA) or Uniform Memory Access (UMA) architecture. Depending on the memory requirements of a process, it might be to prefer an UMA architecture. Where the complete RAM can be address without a penalty, on the other hand, for HPC with many small processes or processes fitting in one of the NUMA-Nodes you can benefit from the CPU cache-locality. 

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

In this sample case, you may observe a high number of memory pages being read from or written to swap. These high numbers typically indicates that the system is running low on available memory. The cause could be multiple processes competing for memory or available memory cannot be used by most applications. One common reason for unavailable memory is the use of HugePages. HugePages are reserved memory. Only applications capable of utilizing HugePages can use this type of memory. For any other process, this memory isn't useable. In situations, you may need to evaluate whether HugePages are truly required for your applications. whether you require HugePages for your applications or whether they can also work with Transparent Huge Pages (THP). Alternatively, consider using Transparent Huge Pages (THP) which allow the kernel to manage large memory pages dynamically. For example, the Java Virtual Machine (JVM) can take advantage of THP by enabling the flag:
`-XX:+UseTransparentHugePages`. For more details about THP, see [Transparent HugePage Support](https://docs.kernel.org/admin-guide/mm/transhuge.html)
For information about HugePages, see [HugeTLB Pages](https://docs.kernel.org/admin-guide/mm/hugetlbpage.html)

### Testing THP usage with a sample program

To observe how THP is used by the system, you can run a small C program that allocates approximately 256 MB of RAM. The program uses the `madvise` system call to inform the kernel that the allocated memory should be treated as a single, contiguous region—enabling THP where supported.

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

When the applications are running on a NUMA (Non-Uniform Memory Access) system with multiple nodes, it's important to know how much memory is available on each node. Although all nodes can access the system's total memory, performance is typically best when a process uses memory that resides on the same NUMA node as the CPU executing it.

If a memory request cannot be fulfilled by the local node, the system allocates memory from another node. However, accessing memory across nodes introduces latency and can lead to performance penalties.

To optimize performance, monitor memory locality and ensure that workloads are aligned with the memory resources of their assigned NUMA nodes.

If you run on a NUMA system with more than one node available, it's also important to know what is the memory size each node does have. The complete available memory to the system can be addressed by each of the available nodes. Though, the best performance you get if the processes running on a particular NUMA NODE operate on the memory which is under direct control of this NODE. If, for example, a new memory request can't be fulfilled on the current node the memory is taken from another node. But operations on this part of the newly requested memory do imply a performance penalty. 

The following is a sample of the system's NUMA configuration.

![numactl output](media/troubleshoot-performance-memory-linux/numactl.png)

The configuration shows that accessing memory within the same Node does have distance level of 10. If you want to access memory on `Node 1` from `Node 0` has a higher distance value of 12 that are still manageable. But if you want to access memory on `NODE 3` from `NODE 0` (it's doable)， the distance level will become 32 which means three times slower to operate on memory. These differences are important to consider when diagnosing performance issues or optimizing memory-bound workloads.
See [document](https://www.kernel.org/doc/html/latest/admin-guide/mm/numaperf.html) for further details. For a description of the `numactl` tool, see [numactl(8)](https://man7.org/linux/man-pages/man8/migratepages.8.html).

To figure out whether there's a realignment of processes and a different Node required use the `numastat` tool. Its doc is located at [numastat(8)](https://man7.org/linux/man-pages/man8/numastat.8.html). With the help of `migratepages` tool [migratepages(8)](https://man7.org/linux/man-pages/man8/migratepages.8.html) one can then try to move the memory pages to the right NODE.

### Overcommitment and OOM killer

Overcommitting is an important design choice that can seriously impact how well the system performs or how stable it is. The Linux kernel supports three modes:

- 'Heuristic'
- 'Always overcommit'
- 'Don't overcommit'
  
By default the `Heuristic` scheme is used. This mode offers a balanced trade-off between always allowing memory overcommitment and strictly denying it. For more information, see the [kernel documentation](https://www.kernel.org/doc/Documentation/vm/overcommit-accounting).

An incorrect Overcommitting setting may cause memory pages to fail to allocate, potentially hindering the creation of new processes or preventing internal kernel structures from acquiring sufficient memory.

If it’s confirmed that the issue is related to memory allocation, it could indicate that there are not enough resources left for the kernel. In this kind of situation, the OOM (Out-Of-Memory) killer might may be invoked. Its job is to free up some memory pages, so they can be used by kernel tasks or other applications. When the OOM killer is invoked, it's a warning that the system has reached its resource limits. This could be caused by having too many processes running, or by some processes consuming a large amount of memory if a memory leak has already been eliminated as the cause. To address the issue, consider increasing the VM size or moving some applications to another server.

#### System logs generated during OOM Events

The following section introduces how to identify when the OOM Killer is triggered and what information is logged by the system.

The following simple C program tests how much memory can be allocated dynamically on a system before it fails.

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

When you run this program, you will find that memory allocation fails after around 3 GB.
![memory allocation error](media/troubleshoot-performance-memory-linux/malloc-error.png)

When the system runs out of memory, the OOM killer is invoked. You can view the related logs using the `dmesg` command. The log entries typically begin like this: 

![invoked OOM killer](media/troubleshoot-performance-memory-linux/malloc-invoked-oom.png)

And end with a summary of the memory state:

![out of memory](media/troubleshoot-performance-memory-linux/malloc-out-of-memory.png)

Between those entries, you’ll find detailed information about memory usage and the process selected for termination:

![OOM full detail #1](media/troubleshoot-performance-memory-linux/memory-details-1.png)
![OOM full detail #2](media/troubleshoot-performance-memory-linux/memory-details-2.png)

From this, we can extract the following insights:
```
4194160 kBytes physical memory 
No swap space
3829648 kBytes are in use
```

In the following log, the malloc process requested a single 4 KB page (order=0). Although 4 KB page is a small size, the system was already under pressure. The log shows that memory was being allocated from the "Normal Zone":
![lowmem reserv](media/troubleshoot-performance-memory-linux/lowmem-reserve.png)

The available memory (`free`) is 29,500 KB , but the minimum watermark (`min`) was 34,628 KB. Since the system was below this threshold, only the kernel could use the remaining memory， and user-space applications were denied. That’s when the OOM killer is involved. It selects the process with the highest `oom_score` and memory usage ('RSS'). In this example, the malloc process had an `oom_score` of 0 but the highest `RSS` (917760), so it's selected as the target for termination.


### Monitor gradual memory growth

OOM events are easy to detect since related messages are logged to the console and system logs. However, gradual increases in memory usage that don’t result in an OOM event can be harder to detect.

To monitor memory usage over time, use the `sar` tool from the `sysstat` package. To focus on the memory details, use the option 'r' such as 'sar -r'. 

Example output:

![sar memory information](media/troubleshoot-performance-memory-linux/sar-info.png)

In this case, memory usage does grow for about two hours. Then, it drops back to 4%. This behavior might be expected such as during peak login hours or resource-intensive reporting tasks. To determine whether this is normal, you may need to monitor usage over several days and correlate it with application activity. High memory usage is not necessarily a problem. It depends on the workload and how the applications are designed to use memory.

To find which processes are consuming the most memory, use `pidstat`. 

Example output:

![pidstat output](media/troubleshoot-performance-memory-linux/pidstat-memory.png)

It displays all running processes and their statistics. Another approach is to use the 'ps' tool to get similar  `ps aux --sort=-rss | head -n 10`

Example output:
![ps aux output](media/troubleshoot-performance-memory-linux/ps-aux.png)

#### Why sort by RSS?

Resident Set Size (RSS) is the portion of a process’s memory held in RAM (non-swapped physical memory). In contrast,  Virtual Set Size （VSZ） is the 'Virtual Set Size' represents the total amount of memory the process has reserved, including memory that hasn’t been committed. `Committed memory` refers to pages that are actually written to physical memory. If you're trying to identify which processes are using the most physical memory (including swap), focus on the `RSS` column. In the example output, the `snapd` process appears to use a lot of memory, but its `RSS` value is low. The `malloc` process has similar `VSZ` and `RSS` values that indicate it’s actively using over 1.3 GB of memory.

