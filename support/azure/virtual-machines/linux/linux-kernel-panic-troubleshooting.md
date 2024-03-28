---
title: Troubleshooting Linux Kernel Panics in Azure
description: Discusses multiple conditions that can lead to a kernel panic and provides general troubleshooting guidance.
author: divargas-msft
ms.author: adelgadohell
ms.topic: troubleshooting
ms.date: 03/06/2023
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
---

# Kernel panic in Azure Linux VMs

This article discusses multiple conditions that can lead to a kernel panic and provides troubleshooting guidance.

In general, a kernel panic is a situation when the kernel is unable to load properly, and therefore the system fails to boot. Another form of kernel panic occurs when the kernel encounters a situation it doesn't know how to handle and protects itself by stopping.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## How to identify a kernel panic?

Use the Azure portal to view the serial console log output of the VM in the boot diagnostics blade, serial console blade, or [AZ CLI](/cli/azure/serial-console#az-serial-console-connect) to identify the specific kernel panic string.

A kernel panic looks similar to the output below and will show up at the end of the serial console log:

```output
Probing EDD (edd=off to disable)... ok
Memory KASLR using RDRAND RDTSC...
[  300.206297] Kernel panic - xxxxxxxx
[  300.207216] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G               ------------ T 3.xxx.x86_64 #1
```

Some of the most common kernel panic events:

|Panic Message|Reason|
|----------------|-------------------------------|
| **Oops: 0000 [#1] SMP " (check log for details)** | System panicked due to dereferencing a bad address. |
| **SysRq: Trigger a crashdump** | Core dump was user-initiated with sysrq-c or by echoing c into /proc/sysrq-trigger. |
| **kernel BUG at \<pathname/filename>:\<line number>!** | This format is the standard for a failed BUG check (which is just like an ASSERT, but the logic is inverted). The filename and line number will indicate which BUG check failed. |
| **Kernel panic - not syncing: softlockup: hung tasks** | The soft lockup detector has found a CPU that hasn't scheduled the watchdog task within the soft lockup threshold. |
| **Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 0** | The hard lockup detector has found a CPU that hasn't received any hrtimer interrupts within the hard lockup threshold. |
| **Kernel panic - not syncing: hung_task: blocked tasks** | The hung task watchdog has detected at least one task that has been in an uninterruptible state for more than the blocked task timeout value. |
| **Kernel panic - not syncing: out of memory. panic_on_oom is selected** | The system has run out of memory and swap and has been forced to start killing processes to free up memory (not default behavior). |
| **Kernel panic - not syncing: Out of memory and no killable processes...** | The system has run out of memory and swap and has been killing processes to free up memory but has run out of processes to kill off. |
| **Kernel panic - not syncing: An NMI occurred, see the Integrated Management Log for details.** | Watchdog has intercepted an NMI (non-maskable interrupt). |
| **Kernel panic - not syncing: NMI IOCK error: Not continuing** | The system received an IO check NMI from the hardware (not a memory parity error) and kernel.panic_on_io_nmi was set (not the default). |
| **Kernel panic - not syncing: NMI: Not continuing** |The system received an NMI (either hardware or memory parity error), and kernel.panic_on_unrecovered_nmi was set (not the default). |
| **Kernel panic - not syncing: nmi watchdog** | The system received an NMI, and either kernel.panic_on_timeout or kernel.panic_on_oops was set (not the default values). |
| **Kernel panic - not syncing: Fatal Machine check** | A machine check exception event has been raised for a fatal condition. |
| **Kernel panic - not syncing: Attempted to kill init!** | The init process is the first process to be started and should never exit. |

## Scenario 1: Kernel panic occurs at boot time

A kernel panic at boot time prevents the VM from finishing the operating system startup process. It happens every time the virtual machine is started, and it doesn't allow logging in.

This kind of event is commonly related but not limited to:

* [A recent kernel upgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupgrade).
* [A recent kernel downgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kerneldowngrade).
* [Kernel module changes](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelmodulechanges).
* [Operating system configuration changes](kernel-related-boot-issues.md#other-kernel-boot-issues-OSchanges) (GRUB, sysctl, and SELinux).
    * [SELinux issues](kernel-related-boot-issues.md#attempted-tokill-init-selinuxissues).
* [Missing important files and directories](kernel-related-boot-issues.md#attempted-tokill-init-missingfilesdirs).
* [Missing important system core libraries and packages](kernel-related-boot-issues.md#attempted-tokill-init-missinglibraries).
* [Wrong permissions on files](kernel-related-boot-issues.md#attempted-tokill-init-wrongpermissions).
* [Missing partitions](kernel-related-boot-issues.md#attempted-tokill-init-missingpartitions).

### Resolution for scenario 1

In order to deal with this kind of kernel panic, the following approaches can be used:

#### Method 1: Using the Azure serial console

Use the Azure serial console to interrupt the boot process and select a previous kernel version, if available. This way, the VM will be able to boot up again, then you can use one of the following methods to fix the specific issue with the non-booting kernel:

* [Reinstall or regenerate a missing initramfs](kernel-related-boot-issues.md#missing-initramfs).
* [Reinstall the problematic kernel](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupdate).
* [Review the loaded or missing kernel modules](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelmodulechanges).
* [Review the partitions](kernel-related-boot-issues.md#attempted-tokill-init-missingpartitions).

#### Method 2: Offline repair using a rescue VM

In case the Azure serial console isn't available or no previous kernel is available, you need a rescue/repair VM to do an offline repair.

Use the [**Repair VM** command](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the target VM's OS disk attached. Then use [chroot](chroot-environment-linux.md) mount the copy of the OS file systems in the repair VM. After that, try following methods to fix the kernel issues:

* [Reinstall or regenerate a missing initramfs](kernel-related-boot-issues.md#missing-initramfs).
* [Reinstall the problematic kernel](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupdate).
* [Review the loaded or missing kernel modules](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelmodulechanges).
* [Review the partitions](kernel-related-boot-issues.md#attempted-tokill-init-missingpartitions).
* [Recover missing files](kernel-related-boot-issues.md#attempted-tokill-init-missingfilesdirs).
* [Recover missing important system core libraries and packages](kernel-related-boot-issues.md#attempted-tokill-init-missinglibraries).

## Scenario 2: Kernel panic at run time

This kind of kernel panic will commonly get triggered at unpredictable times after the Operating System startup process completes and causes the VM to stop responding, preventing it from logging in. It is commonly related but not limited to:

* [A recent kernel upgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelupgrade).
* [A recent kernel downgrade](kernel-related-boot-issues.md#other-kernel-boot-issues-kerneldowngrade).
* [Kernel module changes](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelmodulechanges).
* [Operating system configuration changes](kernel-related-boot-issues.md#other-kernel-boot-issues-OSchanges) (GRUB, sysctl, and SELinux).
    * [SELinux issues](kernel-related-boot-issues.md#attempted-tokill-init-selinuxissues).
* Application workload changes.
* Application development changes or bugs.
* [Possible kernel bugs](kernel-related-boot-issues.md#other-kernel-boot-issues-kernelbugs).
* Performance-related issues.

### Resolution for scenario 2

In order to deal with this kind of kernel panic, the following approaches can be used:

* Review resource usage and overall system performance. The kernel panic might be related to a possible shortage of resources that could lead to a VM resize.
* If possible, install the latest updates available in the corresponding Linux distribution repositories. The kernel panic might be related to known bugs in either the kernel or other software.
* There's a possibility the kernel panic is related to a recent kernel change, in which case it's also advisable to boot over a previous kernel version, as explained in [Resolution for scenario 1](#method-1-using-the-azure-serial-console).
* If the options above aren't applicable, it might be necessary to configure kdump and generate a core dump to share with support for further analysis.

## More specific kernel panic scenarios

Common kernel panic scenarios with specific troubleshooting/recovering instructions:

| Document | Scenario |
|----------------|-------------------------------|
|[An Azure Linux VM on a 3.10-based kernel panics after a host node upgrade](linux-kernel-panics-upgrade.md)| This article discusses a problem that occurs when an Azure Linux VM that's running the 3.10-based kernel crashes after a host node upgrade in Azure. |
|[How to recover an Azure Linux virtual machine from kernel-related boot issues](kernel-related-boot-issues.md)|This article provides solutions to an issue in which a Linux virtual machine (VM) can't restart after applying kernel changes.|

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
