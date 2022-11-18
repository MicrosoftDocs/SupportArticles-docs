---
title: Troubleshoot Linux virtual machine boot issues due to full OS disk
description: Provides solutions for Linux virtual machine boot issues due to a full OS disk.
author: pagienge
ms.author: pagienge
ms.topic: troubleshooting
ms.date: 10/15/2022
ms.service: virtual-machines
ms.collection: linux
---
# Troubleshoot Azure Linux virtual machine boot issues due to full OS disk

Under certain circumstances and configurations, a full operating system (OS) disk may lead to Linux virtual machine (VM) boot issues. This article provides some causes and solutions for the boot issues.

## Symptoms

During normal system operations, if the OS disk or critical system partitions become full, the following issues may occur:

- A VM shuts down unexpectedly.
- A VM doesn't boot successfully.

## Prerequisites

To troubleshoot the boot issues and to complete system repairs, the following requirements should be met:

- Permissions to create a disk snapshot or operate some backup and restore tools.

    In this article, data or disks will be altered, so having the ability to revert the VM to a previous state is a critical component of safe system administration.

- [Boot diagnostics](/azure/virtual-machines/boot-diagnostics) should be enabled and configured.

    Having this configuration in place will allow for future reviewing of the storage of the console log, and interaction with the serial console interface of the VM.

- Permissions to create a VM in case a rescue VM is needed at any point.

- Permissions to create, detach, and attach disks in case swapping disks is required.

> [!NOTE]
> Not all requirements apply to every issue scenario below.

## Scenario 1: VM shuts down unexpectedly and fails to boot

Many security hardening practices can lead to difficulties in maintaining systems. If an error occurs when writing to the audit log, one common configuration requires the system to shut down immediately. To check if this is the reason for a system shutdown, perform the following actions:

- Check the system shutdown messages in the [serial console](/azure/virtual-machines/boot-diagnostics) log.

    If the system is booted, a "Starting Security Auditing Service…" message is displayed. This message doesn't indicate that the service started. Instead, the VM immediately transitions to shut down, and a "power down" message is displayed. If the system is running and unexpectedly shuts down, the serial console may show an orderly shutdown process ending in a "Power down" message. See the following screenshots as an example:

    :::image type="content" source="media/linux-fulldisk-boot-error/fulldisk-secaud-starting.png" alt-text="Screenshot of the 'Starting Security Auditing Service…' message in the serial console.":::
    
    :::image type="content" source="media/linux-fulldisk-boot-error/fulldisk-secaud-poweroff.png" alt-text="Screenshot of the 'Power-off' message in the serial console.":::

- Mount the OS disk by using [az vm repair](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) commands, a manual [recovery VM](troubleshoot-recovery-disks-portal-linux.md), or [single user mode](serial-console-grub-single-user-mode.md). Then, examine the disk utilization by using the `df` command and check if the disk containing the */var/log/audit* directory is near 100% utilization.

- Access the OS filesystem by using [az vm repair](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) commands, a manual [recovery VM](troubleshoot-recovery-disks-portal-linux.md), or [single user mode](serial-console-grub-single-user-mode.md), and verify if the */etc/audit/auditd.conf* file contains the following configurations:

    ```output
    [root@linux /]# grep action /etc/audit/auditd.conf
    admin_space_left_action = HALT
    disk_full_action = HALT
    disk_error_action = HALT
    ```

### Resolution: Disable HALT conditions temporarily 

If the auditd configuration causes the system shutdown on audit log failures, temporarily disabling the `HALT` configuration will allow the VM to boot to the full OS for remediation. Once the system is booted, use normal OS tools to check the filesystem utilization or expand the disk if needed. Once the issue is resolved, revert the configuration file to the previous state as soon as possible. 

To disable HALT conditions temporarily, follow these steps:

1. Take a snapshot of the OS disk to provide a recovery state.

2. Gain access to the configuration file by using [az vm repair](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) commands, a manual [recovery VM](troubleshoot-recovery-disks-portal-linux.md), or [single user mode](serial-console-grub-single-user-mode.md).

3. Take note of the current configuration, as there may not be space available to take a backup of the file in the VM.

4. Change the configurations above in the */etc/audit/auditd.conf* file from `HALT` to any other valid value except `SINGLE`. In this scenario, the values can be `IGNORE`, `SUSPEND`, or any other values listed in the Linux `man` page for the *auditd.conf* file, which will give the appropriate parameters for the versions of software used in the VM.

    ```output
    [root@linux /]# grep action /etc/audit/auditd.conf
    admin_space_left_action = SUSPEND
    disk_full_action = SUSPEND
    disk_error_action = SUSPEND
    ```

- If you're using a recovery VM, follow the instructions in [Unmount and detach original virtual hard disk](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux#unmount-and-detach-original-virtual-hard-disk) to swap the OS disk back to the problematic VM, and try to boot the VM normally. If you're using single-user mode, exit, and the VM will reboot.

- Once the VM is fully booted, browse the filesystem and free some spaces by using command-line tools such as `df` and `du`. Around 10% of the filesystem containing the */var/log/audit* directory should be a good initial target.

> [!IMPORTANT]
> Be sure to revert the contents in the */etc/audit/auditd.conf* file to the original values and reboot the VM.

If this resolution doesn't work or isn't appropriate for your environment, see the [Resolution](#resolution) section.

## Scenario 2: VM disk is resized in Azure, but OS can't be resized, and VM doesn't fully boot

After a full disk is identified and the VM has been shut down to resize the OS disk, the VM may not boot successfully. This scenario may be confusing on some distributions where the OS will attempt to automatically resize the root (`/`) filesystem on reboot. If the disk is completely full, the resize operation may fail because the process requires a small number of free spaces to expand the filesystem. Having no free space can cause cloud-init to fail, and subsequently, the VM won't finish booting.

To identify this issue, review the boot logs in the serial console and check if lines like the following are present:

```output
[   15.384699] cloud-init[1142]: OSError: [Errno 28] No space left on device
[   15.384742] cloud-init[1142]: Original exception was:
[   15.384784] cloud-init[1142]: OSError: [Errno 28] No space left on device
```

Because the specific cloud-init messages may not be the most visible message returned, look for other lines containing the "[Errno 28] No space left on device" text or similar "no space" messages.

To resolve this issue, [clear unneeded data](#resolution1) to free disk space.

## Scenario 3: VM boots but is inaccessible due to service failures

A VM that seems to boot completely may show service issues during the boot, the Azure Agent may not show available, connections to the VM may fail or the VM may appear to be offline according to applications. During the boot, multiple messages such as "[Errno 28] No space left on device" or other formats of messages indicate that the root filesystem is full.

If a VM boots but appears unavailable, check the serial log in boot diagnostics to view the boot messages, or use the [serial console](/azure/virtual-machines/boot-diagnostics) to interact with the VM. If the space is insufficient, [clear unneeded data](#resolution1) to free spaces or [expand the disks](#resolution2).

If the console log contains many messages stating "ERROR ExtHandler /proc/net/route contains no routes", a full OS disk may be the cause as well, as the networking services are unable to completely start.

## <a id="resolution"></a>Resolution

The following resolutions apply to any of the scenarios above.

### <a id="resolution1"></a>Resolution 1: Clear unneeded data

1. Gain access to OS disk and partitions by using [az vm repair](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) commands, a manual [recovery VM](troubleshoot-recovery-disks-portal-linux.md), or [single user mode](serial-console-grub-single-user-mode.md), because the system won't boot normally.

2. Identify large files and directories by using standard Linux tools and commands:

    - `du -ks /* | sort -n` - Locate the most space-consuming files or directories in a location. Repeat with the largest directory reported until some large data is uncovered.
    
    - `ls -altSr /var/log` - List the contents of a directory, ordered by size, with the largest at the end.
    
    - `find / -size +500M -exec ls -alFh {} \;` - Find large individual files. Adjust the `500M` value to a number of megabytes or gigabytes as necessary to locate the most effective files to prune.
    
3. Remove any files that can be identified as unnecessary, such as old logs, forgotten backups, and similar files.

4. Once a suitable amount of space is cleared, target around 10% free disk, reboot the system.

### <a id="resolution2"></a> Resolution 2: Expand OS filesystem

If no data can be cleared from the OS filesystem, we recommend expanding the disk containing the critical OS volumes. For more information, see [Expand virtual hard disks on a Linux VM](/azure/virtual-machines/linux/expand-disks).

## Next steps

In case the specific boot error isn't a Linux boot issue due to full OS disk, refer to the [Troubleshoot Azure Linux Virtual Machines boot errors](boot-error-troubleshoot-linux.md) for further troubleshooting.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
