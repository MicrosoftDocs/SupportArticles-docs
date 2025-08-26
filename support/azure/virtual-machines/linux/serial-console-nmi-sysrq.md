---
title: Azure Serial Console for SysRq and NMI Calls
description: Using Serial Console for SysRq and NMI calls in Azure virtual machines.
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure-services
ms.date: 8/26/2025
ms.author: jarrettr
---

# Use the Azure Serial Console for SysRq and NMI calls

**Applies to:** :heavy_check_mark: Linux Virtual Machines(VMs)

## System Request (SysRq)

A SysRq is a sequence of keys that's understood by the Linux operating system kernel and that can trigger a set of predefined actions. These commands are often used if virtual machine (VM) troubleshooting or recovery can't be performed through traditional administration. For example, if the VM isn't responding, you can use the SysRq feature of Azure Serial Console to mimic pressing the SysRq key and characters that are entered on a physical keyboard.

After the SysRq command is delivered, the kernel configuration controls how the system responds. For information about how to enable and disable SysRq, see [Linux Magic System Request Key Hacks](https://aka.ms/linuxsysrq) (SysRq Admin Guide).

The Azure Serial Console can be used to send a SysRq to an Azure VM by selecting the keyboard icon on the Command bar.

:::image type="content" source="media/serial-console-nmi-sysrq/command-menu.png" alt-text="Screenshot of the Azure Serial Console showing the keyboard icon highlighted and its menu visible. That menu contains a Send SysRq Command item.":::

Select "Send SysRq Command" to open a dialog box that provides common SysRq options or accepts a sequence of SysRq commands. The **Send SysRq** command enables a series of SysRq sequences to perform a high-level operation, such as a safe restart that uses the `REISUB` command.

:::image type="content" source="media/serial-console-nmi-sysrq/sysreq-ui.png" alt-text="Screenshot of the Send SysRq command sent to a Guest dialog box when the entering key option is selected and REISUB is input." border="false":::

The SysRq command can't be used on VMs that are stopped or whose kernel is in a nonresponsive state (for example, a kernel panic).

### Enable SysRq

SysRq can be configured so that all, none, or only certain commands are available. You can enable all SysRq commands by using the following step, although this change doesn't survive a restart:

```console
echo "1" >/proc/sys/kernel/sysrq
```

To make the SysReq configuration persistent, follow these steps to enable all SysRq commands:

1. Add the following line to */etc/sysctl.conf*: <br />
    `kernel.sysrq = 1`
1. Restart or update sysctl by running the following command: <br />
    `sysctl -p`

### Command keys

From the SysRq Admin Guide:

|Command| Function
| ------| ----------- |
|``b``  |   Immediately restarts the system without syncing or unmounting your disks.
|``c``  |   Performs a system crash by a NULL pointer dereference. A crash dump file is created if configured.
|``d``  |   Shows all locks that are held.
|``e``  |   Sends a SIGTERM to all processes, except for init.
|``f``  |   Calls the oom killer to kill a memory-intensive process.
|``g``  |   Used by kgdb (kernel debugger).
|``h``  |   Displays help. (Any key other than those that are listed here also displays help, but "h" is easy to remember.)
|``i``  |   Send a SIGKILL to all processes, except for init.
|``j``  |   Forcibly thaws filesystems that are frozen by the FIFREEZE ioctl.
|``k``  |   Secure Access Key (SAK) that kills all programs on the current virtual console.
|``l``  |   Shows a stack backtrace for all active CPUs.
|``m``  |   Dumps current memory information to your console.
|``n``  |   Allows real-time (RT) tasks to be reprioritized using the nice value. NOTE: The nice value controls a process's priority for CPU scheduling, where lower values indicate higher priority.
|``o``  |   Shuts off your system (if configured and supported).
|``p``  |   Dumps the current registers and flags to your console.
|``q``  |   Dumps CPU lists of all armed hrtimers (but not regular timer_list timers) and detailed information about all clockevent devices.
|``r``  |   Turns off keyboard raw mode and sets it to XLATE.
|``s``  |   Tries to sync all mounted filesystems.
|``t``  |   Dumps a list of current tasks and their information to your console.
|``u``  |   Tries to remount all mounted filesystems as read-only.
|``v``  |   Forcefully restores the framebuffer console.
|``v``  |   Creates an ETM buffer dump file [ARM-specific].
|``w``  |   Dumps tasks that are in uninterruptible (blocked) state.
|``x``  |   Used by the xmon interface on ppc/powerpc platforms. Shows global PMU registers on sparc64. Dumps all TLB entries on MIPS.
|``y``  |   Shows global CPU Registers [SPARC-64 specific].
|``z``  |   Dumps the ftrace buffer.
|``0``-``9`` | Sets the console log level to control which kernel messages are printed to your console. (For example, "0" restricts messages that are sent to your console to emergency messages, such as PANIC and OOPS.)

### Distribution-specific documentation

For distribution-specific documentation about SysRq and the steps to configure Linux to create a crash dump file when it receives a SysRq "Crash" command, see the following articles.

#### Ubuntu ####

- [Kernel Crash Dump](https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html)

#### Red Hat ####

- [What is the SysRq Facility and how do I use it?](https://access.redhat.com/articles/231663)
- [How to use the SysRq facility to collect information from a RHEL server](https://access.redhat.com/solutions/2023)

#### SUSE ####

- [Configure kernel core dump capture](https://www.suse.com/support/kb/doc/?id=3374462)

#### CoreOS ####

- [Collecting crash logs](https://github.com/coreos/docs/blob/master/os/collecting-crash-logs.md)

## Nonmaskable interrupt (NMI)

A nonmaskable interrupt (NMI) creates a signal that software on a VM doesn't ignore. Historically, NMIs are used to monitor for hardware issues on systems that require specific response times. Today, programmers, and system administrators often use NMI as a mechanism to debug or troubleshoot systems that aren't responding.

You can use the Serial Console to send an NMI to an Azure VM by using the keyboard icon on the Command bar. After the NMI is delivered, the VM configuration controls how the system responds. Linux systems can be configured to stop responding and create a memory dump file that the OS receives as an NMI.

:::image type="content" source="media/serial-console-nmi-sysrq/command-menu.png" alt-text="Screenshot of the Serial Console. The keyboard icon is highlighted, and its menu is visible. That menu contains a send nonmaskable interrupt item.":::

### Enable NMI

For Linux systems that support sysctl to configure kernel parameters, you can enable a panic  by running the following commands when you receive the NMI:

1. Add this line to */etc/sysctl.conf*: <br>
    `kernel.panic_on_unrecovered_nmi=1`
1. Restart or update sysctl by running: <br>
    `sysctl -p`

For more information about Linux kernel configurations, including `unknown_nmi_panic`, `panic_on_io_nmi`, and `panic_on_unrecovered_nmi`, see: [Documentation for /proc/sys/kernel/*](https://www.kernel.org/doc/Documentation/sysctl/kernel.txt). For distribution-specific documentation about NMI and the steps to configure Linux to create a crash dump file when it receives an NMI, see the following articles:

### Ubuntu

- [Kernel Crash Dump](https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html)

### Red Hat

- [What is an NMI and what can I use it for?](https://access.redhat.com/solutions/4127)
- [How can I configure my system to crash when NMI switch is pushed?](https://access.redhat.com/solutions/125103)
- [Crash Dump Admin Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide)

### SUSE

- [Configure kernel core dump capture](https://www.suse.com/support/kb/doc/?id=3374462)

### CoreOS

- [Collecting crash logs](https://github.com/coreos/docs/blob/master/os/collecting-crash-logs.md)

## Next steps

- See the main [Serial Console Linux documentation page](serial-console-linux.md).
- Use Serial Console to [start up into GRUB and enter Single User mode](serial-console-grub-single-user-mode.md)
- Learn about the [Serial Console for Windows VMs](../windows/serial-console-windows.md).
- Learn more about [boot diagnostics](../windows/boot-diagnostics.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
