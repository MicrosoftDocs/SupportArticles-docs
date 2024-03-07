---
title: Core dump on RHEL 7.4 when you run mssql-conf
description: This article provides a resolution for the problem where SQL Server terminates and generates a core dump on RHEL 7.4 when you try to run mssql-conf after installation.
ms.date: 09/25/2020
ms.custom: 'sap:SQL Server on Linux', linux-related-content
---
# SQL Server terminates and generates a core dump on RHEL 7.4 when you try to run mssql-conf

This article helps you resolve the problem where SQL Server terminates and generates a core dump on RHEL 7.4 when you try to run mssql-conf after installation.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4134638

## Symptoms

After you install Microsoft SQL Server on RHEL 7.4, the program terminates and generates a core dump when you try to run the mssql-conf tool. Additionally, the following entry is logged in the systemctl logs for the mssql-server service (journalctl -u mssql-server.service):

> This program has encountered a fatal error and cannot continue running.  
The following diagnostic information is available:  
>
> Reason: 0x00000003  
      Message: result  
  Stacktrace: 00005577212bcd92 0000557721266767  
      Process: 590 - sqlservr  
      Thread: 594 (application thread 0x1000)  
  Instance Id: afe0f97b-fdbc-4a4d-910c-038e7ee2049b  
     Crash Id: 544c4c67-0f49-4877-a959-92c14798d58e  
  Build stamp: f7473acad6f0299cd161863aaa02e4284434ab6d915c7b467e2a14e907290249  
>
Capturing core dump and information...

## Cause

This problem occurs because SQL Server on Linux is incompatible with legacy VA layouts. Because of settings that are enabled on RHEL 7.4, all processes start by `using legacy_va_layout`.

During startup, SQL Server on Linux verifies the address ranges. When it finds an incompatibility because of a legacy VA layout, it raises an assert, terminates the program, and generates a core dump.

RHEL 7.4 might switch to using a legacy VA layout for either of the following reasons:

- The soft stack limit value is set to **Unlimited** (for example, a modified limits.conf script or a **ulimit -s** setting).
- A global legacy VA layout is enabled (for example, `sysctl vm.legacy_va_layout` or `modify/etc/sysctl.conf`).

## Resolution

1. In the `/etc/security/limits.conf` layout, add a new row, and then enter the code:

     ```console
     mssql soft stack 8192
     root soft stack 8192
     ```

1. In the `/etc/sysctl.conf` layout, add a new row, and then enter the code: `vm.legacy_va_layout = 0`.
1. Restart the computer: `reboot`.
1. Make sure that the soft stack setting for both users, **root** and **mssql**, is **8192**. Switch to the context of the user, and then run the following command: `ulimit -s`.
1. Make sure that the global legacy VA layout is **0**: `Sysctl vm.legacy_va_layout`.

## Checking the stack size limit

Checking the stack size limit and the **legacy_va_layout** setting (default values, taken from a fresh RHEL-7 installation).

```console
[root@localhost ~]# sysctl vm.legacy_va_layout
vm.legacy_va_layout = 0
[root@localhost ~]# ulimit -s
8192
```

When these settings are made in an x64 system, the address space layout resembles the following:

> +----------------------+  TASK_SIZE     ((1UL << 47) - PAGE_SIZE)  
|            STACK            |  
+----------------------+  
+----------------------+  MMAP_BASE     (STACK_SIZE + RND_OFFSET)  
|          MMAP()           |  
|vvvvvvvvvvvvvvvvvvvv|  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|^^^^^^^^^^^^^^|  
|            HEAP             |  
+----------------------+  
|     ELF SEGMENTS     |  
+----------------------+  
+----------------------+ 0

`MMAP_BASE` is near the top of the address space. As mappings get added, the address space allocation grows down. This is the default setup for RHEL, and this is what SQL Server expects to encounter when it starts.

## Running a simple program

Running a simple program that mmaps a page and returns the address returned by the kernel (example):

```c
mmap code
 =========
 #include <stdio.h>
 #include <sys/mman.h>

int main()
{
    void* result = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
    printf("mmap %p\n", result);
    return 0;
}

[root@localhost ~]# ./mmap
 mmap 0x7fb6976d6000
```

However, if either or both of the parameters are changed, the VA layout might revert to its legacy layout:

> +----------------------+  TASK_SIZE     ((1UL << 47) - PAGE_SIZE)  
|            STACK            |  
|vvvvvvvvv^vvvvvvvvvv|  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|                                  |  
|^^^^^^^^^^^^^^|  
|          MMAP()           |  
+----------------------+ TASK_UNMAPPED_BASE     (PAGE_ALIGN(TASK_SIZE / 3))  
|                                  |  
|                                  |  
|                                  |  
|^^^^^^^^^^^^^^|  
|            HEAP             |  
+----------------------+  
|     ELF SEGMENTS     |  
+----------------------+  
+----------------------+ 0

Here, the `MMAP_BASE` is placed at one-third of the address space. As mappings get added, the address space allocation grows up (expands).

Because we have a 47-bit virtual address space, in 64-bit Linux, `MMAP_BASE` gets placed around the 42nd TB virtual 0x2A0000000000. Therefore, mssql bumps on addresses that are already mapped below 64 TB when it tries to set its fixed maps.

## Adjusting the stack size, to grow unbounded - unlimited

[root@localhost ~]# ulimit -s unlimited  
[root@localhost ~]# ./mmap  
mmap 0x2b6634464000

## Adjusting vm.legacy_va_layout

[root@localhost ~]# ulimit -s 8192  
[root@localhost ~]# sysctl -w vm.legacy_va_layout=1  
vm.legacy_va_layout = 1  
[root@localhost ~]# ./mmap  
mmap 0x2b46f28f9000  

You can get the same effect as setting `vm.legacy_va_layout` by adjusting the stack size to grow unlimited. The difference is that after an administrator sets `vm.legacy_va_layout=1`, the system will globally use that legacy VA layout for all processes. (The only way to override this is by resetting that sysctl knob to **0**.) However, if you have `vm.legacy_va_layout=0 (default)`, you can adjust that characteristic by adjusting the stack size limit on a per-login-session basis by issuing ulimit (or customizing limits.conf).
