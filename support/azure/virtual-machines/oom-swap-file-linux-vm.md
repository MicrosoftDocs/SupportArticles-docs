---
title: Out of memory error occurs in Linux Azure virtual machine
description: This article helps you understand how to fix out of memory errors by adding swap space in Linux Azure virtual machines.
ms.date: 10/27/2023
ms.reviewer: azurevmlnxcic, v-denlee
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.custom: linux-related-content
ms.collection: linux
author: pagienge
ms.author: pagienge
---
# Out of memory error occurs in Linux Azure virtual machine

This article discusses a few scenarios in which a Microsoft Azure Virtual Machine (VM) that runs the Linux operating system (OS) runs out of memory (OOM). An OOM condition causes new memory allocation requests to fail, or it causes the [OOM Killer](https://linux-mm.org/OOM_Killer) process to be invoked. If it's configured to do this, the [kernel panics](./linux-kernel-panic-troubleshooting.md), and a memory dump file is created.

*Original product version:* &nbsp; Virtual Machine running Linux  
*Original KB number:* &nbsp; 4010058

## Symptoms

In a Linux OS, memory allocation issues can occur at any time while the OS is running. These issues involve different logging scenarios. The following sections contain a few examples of common error messages.

### Symptom 1: Memory allocation failure

[12345.678901] ruby: page allocation failure: order:0, mode:0x1080020(GFP_ATOMIC), nodemask=(null)

### Symptom 2: Out of memory failure

You encounter an OOM error in logs or on the command line while interacting with the OS. For example, the system log file shows the following error:

```output
localhost kernel: Out of memory: Kill process 2154 (oom) score 844 or sacrifice child
```

The following text shows another form of the OOM message. This message indicates that the OOM Killer was invoked:

```output
Jul  7 21:09:50 hostname kernel: [ 1347.090377] output.rb:140 invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
```

In the serial console or the system log, a kernel stack trace is often generated for any OOM event. The message is similar to the following text:

```output
[1774674.375021] out_of_memory+0x1ab/0x4a0
```

### Symptom 3: Failure to fork

If the OS tries to start a new process but can't create that process, a "failed to fork" message occurs. This error message usually indicates the reason why the process can't be forked. One common reason — and the one that's applicable in this situation — is a failure to allocate the necessary memory for the initial process state. The following text contains one form of the message:

```output
Feb 29 08:35:52 hostname systemd: Failed to fork: Cannot allocate memory
```

## Cause

At the highest level, the basic cause of this error is that the OS can't allocate memory for the request that is made. The reasons for the errors can vary, and the system administrator must do diagnosis at the time that the error is encountered. Possible reasons for memory allocation failures include, but aren't limited to, the following occurrences:

- Unexpected or unanticipated spikes or growth in application load
- Memory fragmentation (small free blocks of memory are available, but none of the blocks are large enough to satisfy the request)
- Misconfiguration of memory parameters
- Memory leaks in applications
- Kernel bugs
- Lack of available swap space or full swap

### Diagnosis

Memory diagnosis must be done at the time that the errors are discovered. A diagnosis usually can't be done retrospectively. You can use various tools and methods to diagnose memory use and fragmentation. The following list of tools shouldn't be viewed as all-encompassing, but the list is a starting point for doing diagnosis:

- `free`
- `vmstat`
- `top`
- `htop`
- `atop`
- `cat /proc/meminfo`
- `cat /proc/buddyinfo`
- `echo m > /proc/sysrq-trigger`
  
  > [!NOTE]  
  > Output of this command is located in the system log. Typically, this log is the */var/log/messages* or */var/log/syslog* file.

- sa/sar
  
  > [!NOTE]  
  > You can use the `sa` toolkit to analyze historical aggregate data for the system as a whole, but without process-level detail.

## Solution

The most appropriate solution requires a thorough analysis of memory usage, patterns, and configurations. Such solutions include one or more of the following action items:

- Scaling up VM memory
- Reconfiguring `cgroup` definitions, if limits are used
- Changing huge page allocation
- Configuring swap space

To configure swap space in Azure, you can choose between two general approaches that follow Azure best practices. Both approaches require a VM model that includes a resource disk.

| System type | Approach description |
|--|--|
| Systems that use [cloud-init](https://cloudinit.readthedocs.io) | The preferred method is using cloud-init configurations or per-boot scripts. |
| Systems that don't use cloud-init but use the Azure Agent | Configuration directives exist in the */etc/waagent.conf* file to create a swap file in the resource disk at a customizable size. |

For more information about these methods, see the following articles:

- [Use cloud-init to configure a swap partition on a Linux VM](/azure/virtual-machines/linux/cloudinit-configure-swapfile)

- [Create a SWAP partition for an Azure Linux VM](./create-swap-file-linux-vm.md)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
