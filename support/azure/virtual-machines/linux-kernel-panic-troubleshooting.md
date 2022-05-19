---
title: Troubleshooting Linux Kernel Panics in Azure.
description: Discusses multiple conditions that can lead to a kernel panic and provides general troubleshooting guidance.
author: divargas-msft
ms.author: adelgadohell
ms.topic: troubleshooting #Required.
ms.date: 05/19/2022
ms.service: virtual-machines
ms.collection: linux
---

# Linux :::no-loc text="kernel panic"::: in Azure

This article discusses multiple conditions that can lead to a :::no-loc text="kernel panic"::: and provides troubleshooting guidance.

Generally speaking, a :::no-loc text="kernel panic"::: is a situation when the kernel can't load properly and therefore the system fails to boot or the kernel encounters an unexpected situation, it does not know how to handle it, and protects itself by stopping.

## Prerequisites

Make sure the [serial console](/azure/virtual-machines/serial-console-linux.md) is enabled and functional in the Linux VM.

## Symptoms - How to identify a :::no-loc text="kernel panic":::?

Use the Azure Portal to view the serial console log output of the VM in the boot diagnostics blade, serial console blade, or [AZ CLI](/cli/azure/serial-console#az-serial-console-connect) to identify the specific :::no-loc text="kernel panic"::: string.

A :::no-loc text="kernel panic"::: will similar to the output below, and will show up at the end of the serial console log:

```bash
Probing EDD (edd=off to disable)... ok
Memory KASLR using RDRAND RDTSC...
[  300.206297] Kernel panic - xxxxxxxx
[  300.207216] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G               ------------ T 3.xxx.x86_64 #1
```

Some of the most common :::no-loc text="kernel panic"::: events:

|Panic Message|Reason|
|----------------|-------------------------------|
| "Oops: 0000 [#1] SMP " (check log for details)" | System panicked due to dereferencing a bad address |
| "SysRq : Trigger a crashdump" | Core dump was user initiated with sysrq-c or by echoing c into /proc/sysrq-trigger |
| "kernel BUG at \<pathname/filename>:\<line number>!" | This is the standard format for a failed BUG check (which is just like an ASSERT but the logic is inverted). The filename and line number will indicate which BUG check failed |
| ":::no-loc text="Kernel panic"::: - not syncing: softlockup: hung tasks" | The soft lockup detector has found a CPU that has not scheduled the watchdog task within the soft lockup threshold |
| ":::no-loc text="Kernel panic"::: - not syncing: Watchdog detected hard LOCKUP on cpu 0" | The hard lockup detector has found a CPU that has not received any hrtimer interrupts within the hard lockup threshold. |
| ":::no-loc text="Kernel panic"::: - not syncing: hung_task: blocked tasks" | The hung task watchdog has detected at least one task that has been in uninterruptible state for more than the blocked task timeout value |
| ":::no-loc text="Kernel panic"::: - not syncing: out of memory. panic_on_oom is selected" | The system has run out of memory and swap and has been forced to start killing processes to free up memory (not default behaviour) |
| ":::no-loc text="Kernel panic"::: - not syncing: Out of memory and no killable processes..." | The system has run out of memory and swap and has been killing processes to free up memory but has run out of processes to kill off. |
| ":::no-loc text="Kernel panic"::: - not syncing: An NMI occurred, please see the Integrated Management Log for details." | Watchdog has intercepted an NMI (non-maskable interrupt). |
| ":::no-loc text="Kernel panic"::: - not syncing: NMI IOCK error: Not continuing" | The system received an IO check NMI from the hardware (not a memory parity error) and kernel.panic_on_io_nmi was set (not the default). |
| ":::no-loc text="Kernel panic"::: - not syncing: NMI: Not continuing" |The system received an NMI (either hardware or memory parity error) and kernel.panic_on_unrecovered_nmi was set (not the default). |
| ":::no-loc text="Kernel panic"::: - not syncing: nmi watchdog" | The system received an NMI and either kernel.panic_on_timeout or kernel.panic_on_oops was set (not the default values). |
| ":::no-loc text="Kernel panic"::: - not syncing: Fatal Machine check" | A machine check exception event has been raised for a fatal condition |
| ":::no-loc text="Kernel panic"::: - not syncing: Attempted to kill init!" | The init process is the first process to be started and should never exit. |

### Which specific :::no-loc text="kernel panic"::: is occurring?

It is key to be able to identify what type of :::no-loc text="kernel panic"::: is happening to be able to determine more specific actions.

#### Is it a :::no-loc text="kernel panic"::: at boot time?

A :::no-loc text="kernel panic"::: at boot time prevents the VM from finishing the Operating System start up process. It happens every time the virtual machine is started and it does not allow to log in.

#### Is it a panic happening during VM operation?

This kind of kernel panic will commonly get triggered at unpredictable times after the Operating System start up process completes, and causes the VM to stop responding, preventing to log in.

## Scenario 1 - :::no-loc text="Kernel panic"::: at boot time

This kind of event, is commonly related but not limited to: a recent kernel upgrade, kernel downgrade, kernel module changes, operating system configuration changes (GRUB, sysctl, selinux), possible missing files, wrong permissions on files, or missing partitions.

## Resolution 1

To deal with this kind of :::no-loc text="kernel panic":::, the following approaches can be used:

### Method 1: Using the azure serial console

Use the azure serial console to interrupt the boot process and select a previous kernel version, if available. This way the VM will be able to boot up again to be able to fix the specific issue with the non booting kernel: reinstall or regenerate a missing initramfs, reinstall the problematic kernel, review loaded/missing kernel modules, review partitions, and so on, and so forth.

### Method 2: Offline repair using a rescue VM

In case the Azure serial console is not available or no  previous kernel is available, a rescue/repair VM can be created.

The [Azure repair VM feature](/azure/virtual-machines/repair-linux-vm-using-azure-virtual-machine-repair-commands.md) can be used, to get a repair VM created, along with a copy of the OS disk attached. Then [chroot](/azure/virtual-machines/chroot-environment-linux.md) can be used to get the copy of the OS file systems mounted in the repair VM from which it's possible to: reinstall or regenerate a missing initramfs, reinstall the problematic kernel, review loaded/missing kernel modules, review partitions, possible missing files, and so on, and so forth.

## Scenario 2 - Kernel panic at run time

This kind of event, is commonly related but not limited to: a recent kernel upgrade, kernel downgrade, kernel module changes, operating system configuration changes (sysctl), application workload changes, application development changes or bugs, performance related issues.

## Resolution 2

To deal with this kind of :::no-loc text="kernel panic":::, the following approaches can be used:

* Review resource usage and over all system performance. The :::no-loc text="kernel panic"::: might be related to a possible shortage of resources that could lead to a VM resize.
* If possible, install the latest updates available in the corresponding Linux distribution repositories. The :::no-loc text="kernel panic"::: might be related to known bugs in either the kernel or other software.
* There is a possibility the :::no-loc text="kernel panic"::: is related to recent kernel change, in which case it is also advisable to boot over a previous kernel version. This is explained in [Resolution 1](#method-1-using-the-azure-serial-console).
* If the options above are not applicable, it might be necessary to configure kdump and generate a core dump to share with support for further analysis.

## More specific :::no-loc text="kernel panic"::: scenarios

Common :::no-loc text="kernel panic"::: scenarios with specific troubleshooting/recovering instructions:

| Document | Scenario |
|----------------|-------------------------------|
|[An Azure Linux VM on a 3.10-based :::no-loc text="kernel panics"::: after a host node upgrade](/azure/virtual-machines/linux-kernel-panics-upgrade.md)| This article discusses a problem that occurs when an Azure Linux VM that's running the 3.10-based kernel crashes after a host node upgrade in Azure. |
|[How to recover an Azure Linux virtual machine from kernel-related boot issues](/azure/virtual-machines/kernel-related-boot-issues.md)|This article provides solutions to an issue in which a Linux virtual machine (VM) can't restart after applying kernel changes.|

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
