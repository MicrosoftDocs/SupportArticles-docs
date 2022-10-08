---
title: Recover Azure Linux VM from kernel-related boot issues
description: Provides solutions to an issue in which a Linux virtual machine (VM) can't boot after applying kernel changes.
author: divargas-msft
ms.author: divargas
ms.date: 10/08/2022
ms.reviewer: jofrance
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting
---
# How to recover an Azure Linux virtual machine from kernel-related boot issues

This article provides solutions to an issue in which a Linux virtual machine (VM) can't boot after applying kernel changes.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-kernel-boot-issue"></a>How to identify kernel related boot issue

To identify a kernel related boot issue, use one of the following methods:

- Use the Azure portal to view the serial console log output of the VM in the boot diagnostics pane or  serial console pane.

- Use the [AZ CLI](/cli/azure/serial-console#az-serial-console-connect) to identify the specific kernel panic string.

A kernel-related boot issue looks like the following output and will show up at the end of the serial console log:

```output
Probing EDD (edd=off to disable)... ok
Memory KASLR using RDRAND RDTSC...
[  300.206297] Kernel panic - xxxxxxxx
[  300.207216] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G               ------------ T 3.xxx.x86_64 #1
```

## <a id="online-troubleshooting"></a>Online troubleshooting

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

The serial console is the fastest method to resolve this issue. It allows you to directly fix the issue without having to present the system disk to a recovery VM. Make sure you've met the necessary prerequisites for your distribution. For more information, see [Virtual machine serial console for Linux](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).  

1. [Identify the specific kernel-related boot issue](#identify-kernel-boot-issue).
2. Use the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux), interrupt your VM at the GRUB menu and select any previous kernel to boot it up. Follow the detailed instructions in [Booting the system on an older kernel version](#bootingup-differentkernel-ASC) for further information.

3. The VM will boot up fine over the previous kernel version. At this point, the issue isn't yet fixed. Go to the corresponding section and follow the provided instructions to resolve your specific issue:

    - [Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)](#missing-initramfs)
    - [Kernel panic - not syncing: Attempted to kill init!](#attempted-tokill-init)
    - [Other kernel related boot issues](#other-kernel-boot-issues)

4. After the kernel-related boot issue is resolved, restart the VM so it can boot over the latest kernel version.

## <a id="offline-troubleshooting"></a>Offline troubleshooting

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

1. If the [Azure serial console](serial-console-linux.md) doesn't work in the specific VM or isn't an option in your subscription, troubleshoot this issue by using a rescue/repair VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux).

2. [Identify the specific kernel-related boot issue](#identify-kernel-boot-issue). Go to the corresponding section and follow the provided instructions to resolve your specific issue:

    - [Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)](#missing-initramfs)
    - [Kernel panic - not syncing: Attempted to kill init!](#attempted-tokill-init)
    - [Other kernel related boot issues](#other-kernel-boot-issues)

3. After the kernel-related boot issue is resolved, perform the following actions:

    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue/repair VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

4. If there are important kernel related contents, the entire /boot partition, or other important contents are missing, and they can't be recovered, we recommend restoring the VM from a backup. For more information, see [How to restore Azure VM data in Azure portal](/azure/backup/backup-azure-arm-restore-vms).

See the following sections for detailed errors, possible causes, and solutions.

## <a id="bootingup-differentkernel"></a>Boot an older kernel version

### <a id="bootingup-differentkernel-ASC"></a>Use Azure Serial console

1. Restart the VM by using the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux):
    1. Select the **shutdown** button at the top of the serial console window.
    2. Select **Restart VM (Hard)** option.

2. Once the serial console connection resumes, you'll see a countdown counter at the top left corner of the serial console screen. Start pressing the **Escape** key to interrupt your VM at the GRUB menu.

3. Use the down arrow key to select any previous kernel version.

    :::image type="content" source="media/kernel-related-boot-issues/boot-previous-kernel-01.gif" alt-text="Animated GIF shows the process of interrupting the boot process at GRUB menu level to choose an older kernel to boot the system on.":::

> [!NOTE]
> If there's only one kernel version listed in the GRUB menu, follow the [Offline Troubleshooting](#offline-troubleshooting) approach to troubleshoot this issue from a repair VM.

### <a id="bootingup-differentkernel-ARVMALAR"></a>Use repair VM (ALAR scripts)

1. Use the [Azure Cloud Shell](/azure/cloud-shell/overview), Bash option, create a repair VM by using the instructions in [Use Azure Linux Auto Repair (ALAR) to fix a Linux VM - kernel option](/troubleshoot/azure/virtual-machines/repair-linux-vm-using-alar#kernel), also shown below.

    ```azurecli
    az vm repair create --verbose -g $RGNAME -n $VMNAME --repair-username rescue --repair-password 'password!234' --copy-disk-name repairdiskcopy
    ```

2. The following command replaces the broken kernel with the previously installed version.

    ```azurecli
    az vm repair run --verbose -g $RGNAME -n $VMNAME --run-id linux-alar2 --parameters kernel --run-on-repair
    
    az vm repair restore --verbose -g $RGNAME -n $VMNAME
    ```

    > [!NOTE]
    > If there is only one kernel version installed in the system, follow the [Offline troubleshooting](#offline-troubleshooting) approach to troubleshoot this issue mounting all the file systems from a repair VM.

### <a id="bootingup-differentkernel-ARVMManual"></a>Change default kernel version manually

You could also modify the default kernel from a repair VM (inside chroot) by using the following commands.

> [!NOTE]
> This same process could be used to change the default kernel version on a running VM.
> If a kernel downgrade rollback, you'll want to choose the most recent kernel version instead of the older one.

- **RHEL 7, Oracle Linux 7 and CentOS 7**

    1. Validate the list of available kernels in the GRUB configuration file
    
        - **Gen1 VMs:**
    
            ```bash
            cat /boot/grub2/grub.cfg | grep menuentry
            ```
    
        - **Gen2 VMs:**
    
            ```bash
            cat /boot/efi/EFI/*/grub.cfg | grep menuentry
            ```
    
    2. Set the new default kernel using the following command and specifying the corresponding kernel title:
    
        ```bash
        # grub2-set-default 'Red Hat Enterprise Linux Server, with Linux 3.10.0-123.el7.x86_64'
        ```
    
        > [!NOTE]
        > Replace **_Red Hat Enterprise Linux Server, with Linux 3.10.0-123.el7.x86_64_** by the corresponding menu entry title.
    
    3. Validate the new default kernel is the desired one:
    
        ```bash
        grub2-editenv list
        ```
    
    4. Make sure the /etc/default/grub GRUB_DEFAULT is set to saved. In case you need to modify it, make sure you [regenerate the GRUB configuration file](/troubleshoot/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file) to apply the changes.

- **RHEL 8/9 and CentOS 8**

    1. List the available kernels using the following command:
    
        ```bash
        ls -l /boot/vmlinuz-*
        ```
    
    2. Set the new default kernel using the following command:
    
        ```bash
        grubby --set-default /boot/vmlinuz-4.18.0-372.19.1.el8_6.x86_64
        ```
    
        > [!NOTE]
        > Replace **_4.18.0-372.19.1.el8_6.x86_64_** by the corresponding kernel version.
    
    3. Validate the new default kernel is the desired one.
    
        ```bash
        grubby --default-kernel
        ```

- **SLES 12/15, Ubuntu 18.04/20.04**

1. List the available kernels in the GRUB configuration file

    - **Gen1 VMs:**

        ```bash
        cat /boot/grub2/grub.cfg | grep menuentry
        ```

    - **Gen2 VMs:**

        ```bash
        cat /boot/efi/EFI/*/grub.cfg | grep menuentry
        ```

2. Set the new default kernel modifying the GRUB_DEFAULT value in the /etc/default/grub file. The value of 0 is the default value for the most recent kernel version installed in the system. The next available kernel is set to "1>2"

    ```bash
    vi /etc/default/grub
    GRUB_DEFAULT="1>2"
    ```

    > [!NOTE]
    > Refer to the official [SUSE Boot Loader GRUB2](https://documentation.suse.com/sles/12-SP4/html/SLES-all/cha-grub2.html) and [Ubuntu Grub2/Setup](https://help.ubuntu.com/community/Grub2/Setup) documentation for details about how to properly configure GRUB_DEFAULT variable. As a reference: the top level menuentry value is 0, the first top level submenu value is 1 and each nested menuentry value starts with 0. E.g.: "1>2" is the third menuentry from the first submenu.

3. Regenerate the GRUB configuration file to apply the changes. Follow  the instructions in [Reinstall GRUB and regenerate GRUB configuration file](/troubleshoot/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file) for the corresponding Linux distribution and VM generation

## <a id="missing-initramfs"></a>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

This error is caused by a recent system update (kernel). It's most commonly seen in RHEL based distributions.
You can [identify this issue from the Azure serial console](#identify-kernel-boot-issue). You'll see any of the following messages:

1. _Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)_

    ```output
    [  301.026129] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
    [  301.027122] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G               ------------ T 3.10.0-1160.36.2.el7.x86_64 #1
    [  301.027122] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
    [  301.027122] Call Trace:
    [  301.027122]  [<ffffffff82383559>] dump_stack+0x19/0x1b
    [  301.027122]  [<ffffffff8237d261>] panic+0xe8/0x21f
    [  301.027122]  [<ffffffff8298b794>] mount_block_root+0x291/0x2a0
    [  301.027122]  [<ffffffff8298b7f6>] mount_root+0x53/0x56
    [  301.027122]  [<ffffffff8298b935>] prepare_namespace+0x13c/0x174
    [  301.027122]  [<ffffffff8298b412>] kernel_init_freeable+0x222/0x249
    [  301.027122]  [<ffffffff8298ab28>] ? initcall_blcklist+0xb0/0xb0
    [  301.027122]  [<ffffffff82372350>] ? rest_init+0x80/0x80
    [  301.027122]  [<ffffffff8237235e>] kernel_init+0xe/0x100
    [  301.027122]  [<ffffffff82395df7>] ret_from_fork_nospec_begin+0x21/0x21
    [  301.027122]  [<ffffffff82372350>] ? rest_init+0x80/0x80
    [  301.027122] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    ```

2. _error: file '/initramfs-*.img' not found_

    ```output
    error: file '/initramfs-3.10.0-1160.36.2.el7.x86_64.img' not found. 
    ```

In this kind of event, the initramfs file it's not properly generated or the GRUB configuration file has the initrd entry missing, after a patching process or a GRUB manual misconfiguration.

Prior rebooting a server, it's always recommended to validate the GRUB configuration and /boot contents in case there was a kernel update. This is important to ensure the update was properly done, and there're no missing initramfs files

- **BIOS based - Gen1 systems**

    ```bash
    # ls -l /boot
    # cat /boot/grub2/grub.cfg
    ```

- **UEFI based - Gen2 systems**

    ```bash
    # ls -l /boot
    # cat /boot/efi/EFI/*/grub.cfg
    ```

### <a id="missing-initramfs-alar"></a>Regenerate missing initramfs by using Azure Repair VM ALAR scripts

1. Using the [Azure Cloud Shell](/azure/cloud-shell/overview), Bash option, create a repair VM by using the instructions in [Use Azure Linux Auto Repair (ALAR) to fix a Linux VM - initrd option](/troubleshoot/azure/virtual-machines/repair-linux-vm-using-alar#initrd), also shown below.

    ```azurecli
    az vm repair create --verbose -g $RGNAME -n $VMNAME --repair-username rescue --repair-password 'password!234' --copy-disk-name repairdiskcopy
    ```

2. The following command is going to take care of regenerating the initrd/initramfs image, it also takes care of regenerating the GRUB configuration file in case it has the initrd entry missing. 

    ```azurecli
    az vm repair run --verbose -g $RGNAME -n $VMNAME --run-id linux-alar2 --parameters initrd --run-on-repair
    
    az vm repair restore --verbose -g $RGNAME -n $VMNAME
    ```

3. Once the restore command has been executed, then restart the original VM, and validate it was able to boot up.

### <a id="missing-initramfs-manual"></a>Regenerate missing initramfs manually

This method can be used in case you were able to get the virtual machine booted-up using a previous kernel version or inside chroot from the repair/rescue VM.

> [!IMPORTANT]
> If you're following this process from a repair VM, make sure the [Offline troubleshooting](#offline-troubleshooting) step 1 has been already followed and these commands are executed inside [chroot](chroot-environment-linux.md).

1. Identify the specific kernel version having issues to boot. You can extract that information from the corresponding kernel panic error, as highlighted in the image below

:::image type="content" source="media/kernel-related-boot-issues/missing-initramfs-01.png" alt-text="Screenshot to identify the specific kernel version that has the missing initramfs image missing.":::

2. Execute the following commands to regenerate the missing initramfs file:

    * **RHEL/CentOS/Oracle Linux 7/8**

    ```bash
    sudo depmod -a 3.10.0-1160.59.1.el7.x86_64
    sudo dracut -f /boot/initramfs-3.10.0-1160.59.1.el7.x86_64.img 3.10.0-1160.59.1.el7.x86_64
    ```

    >[!IMPORTANT]
    > Replace **_3.10.0-1160.59.1.el7.x86_64_** with the corresponding kernel version.

    * **SLES 12/15**

    ```bash
    sudo depmod -a 5.3.18-150300.38.53-azure
    sudo dracut -f /boot/initrd-5.3.18-150300.38.53-azure 5.3.18-150300.38.53-azure
    ```

    >[!IMPORTANT]
    > Replace **_5.3.18-150300.38.53-azure_** with the corresponding kernel version.

    * **Ubuntu 18.04**

    ```bash
    sudo depmod -a 5.4.0-1077-azure
    sudo mkinitramfs -k -o /boot/initrd.img-5.4.0-1077-azure
    ```

    >[!IMPORTANT]
    > Replace **_5.4.0-1077-azure_** with the corresponding kernel version.

3. Regenerate the GRUB configuration file. Follow  the instructions in [Reinstall GRUB and regenerate GRUB configuration file](/troubleshoot/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file) for the corresponding Linux distribution and VM generation

4. If this process has been followed from a repair VM, follow the instructions in [Offline Troubleshooting](#offline-troubleshooting) step 3. If this process has been followed from the Azure Serial console following the [Online Troubleshooting](#online-troubleshooting) method, then you can proceed with the reboot of your VM to boot it over the most recent kernel version.

## <a id="attempted-tokill-init"></a>Kernel panic - not syncing: Attempted to kill init!

You can [identify this issue from the Azure serial console](#identify-kernel-boot-issue). You'll see the following similar output:

```output
dracut Warning: Boot has failed. To debug this issue add "rdshell" to the kernel command line.
Kernel panic - not syncing: Attempted to kill init!
Pid: 1, comm: init Not tainted 2.6.32-754.17.1.el6.x86_64 #1
Call Trace:
 [<ffffffff81558bfa>] ? panic+0xa7/0x18b
 [<ffffffff81130370>] ? perf_event_exit_task+0xc0/0x340
 [<ffffffff81086433>] ? do_exit+0x853/0x860
 [<ffffffff811a33b5>] ? fput+0x25/0x30
 [<ffffffff81564272>] ? system_call_after_swapgs+0xa2/0x152
 [<ffffffff81086498>] ? do_group_exit+0x58/0xd0
 [<ffffffff81086527>] ? sys_exit_group+0x17/0x20
 [<ffffffff81564357>] ? system_call_fastpath+0x35/0x3a
 [<ffffffff8156427e>] ? system_call_after_swapgs+0xae/0x152
```

This kind of kernel panic occurs due to several possible causes:

* [Missing important files and directories](#attempted-tokill-init-missingfilesdirs).

* [Missing important system core libraries and packages](#attempted-tokill-init-missinglibraries)

* [Wrong file permissions](#attempted-tokill-init-wrongpermissions)

* [Missing partitions](#attempted-tokill-init-missingpartitions)

* [SELinux issues](#attempted-tokill-init-selinuxissues)

Below are the detailed possible causes, make sure the commands are executed from a repair/rescue VM, inside a chroot environment as instructed in [Offline Troubleshooting](#offline-troubleshooting).

### <a id="attempted-tokill-init-missingfilesdirs"></a> Missing important files and directories

Linux important files and directories are missing, due to a human error, like files accidentally deleted, or file system corruption.

1. Validate the OS disk contents after attaching the copy of the OS disk to a repair VM, and mounting the corresponding file systems using the [chroot](chroot-environment-linux.md) article instructions. You can compare the outputs with the ones from a working VM running the same OS version.

```bash
ls -l /
ls -l /usr/lib
ls -l /usr/lib64
ls -lR / | more
```

2. You'll need to restore the missing files from a backup. For more information, see [Recover files from Azure virtual machine backup](/azure/backup/backup-azure-restore-files-from-vm). Depending on the number of missing files, it might be better to do a full VM restore. For more information, see [How to restore Azure VM data in Azure portal](/azure/backup/backup-azure-arm-restore-vms).

### <a id="attempted-tokill-init-missinglibraries"></a>Missing important system core libraries and packages

Important system core libraries, files or packages were deleted from the system or got corrupted.

1. Look for glibc package, make sure it's installed and all their files are still present in the system.

```bash
rpm -qa | grep glibc
```

2. The following command can be used to verify all system packages and their corresponding status. The output can be compared against a healthy VM running the same OS version. You could try reinstalling the corrupted packages from a repair VM.

```bash
rpm --verify --all 
```

### <a id="attempted-tokill-init-wrongpermissions"></a> Wrong file permissions

Wrong system wide file permissions were modified by a human error (like someone running chmod 777 on / or other important OS file systems).

> [!NOTE]
> The following process works in Red Hat/CentOS VMs. In the rest of Linux distributions the initial recommendation it's a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

1. To attempt to restore the file permissions, execute the following command after attaching the copy of the OS disk to a repair VM, and mounting the corresponding file systems using the [chroot](chroot-environment-linux.md) article instructions.

```bash
rpm -a --setperms
rpm --setugids --all
chmod u+s /bin/sudo
chmod 660 /etc/sudoers.d/*
chmod 644 /etc/ssh/*.pub
chmod 640 /etc/ssh/*.key
```

>[!NOTE]
> Please avoid running this command on running production systems.

2. If the issues continue after trying to manually recover the corresponding file permissions, the recommendation is to perform a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

### <a id="attempted-tokill-init-missingpartitions"></a> Missing partitions

In cases where `/usr`, `/opt`, `/var`, `/home`, `/tmp` and `/` file systems are spread across different partitions, it's possible the data is inaccessible because of issues at partitions level, which might be caused by mistakes during partition resize operations, or others.

In this scenario, if you've documented the original partition table layout, with the exact start and end sectors for each of the original partitions, and **no further modifications were done on the system**, like new file systems creation, you can try to recreate the partitions using the same original layout with tools like **fdisk** (for MBR partition tables) or **gdisk** (for GPT partition tables) to gain access to the missing file system.

If that approach doesn't work, the recommended option left, is to perform a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

### <a id="attempted-tokill-init-selinuxissues"></a> SELinux issues

Wrong SELinux permissions might be preventing the system to access important files.

1. To verify if the system is having issues due to SELinux, you can try to start the system with SELinux disabled by adding **selinux=0** kernel option to the GRUB linux16 line.
2. If the system is able to boot up OK, then create the following file to trigger a SELinux relabel at boot time and reboot the system.

```bash
touch /.autorelabel
```

3. If the VM continues with issues to boot after this troubleshooting, the recommendation is to do a full VM restore from backup.  For more information, see [How to restore Azure VM data in Azure portal](/azure/backup/backup-azure-arm-restore-vms).

## <a id="other-kernel-boot-issues"></a>Other kernel related boot issues

There are several kernel panics not being covered in this article. We tried to cover the most common Linux kernel panics we've identified in Azure. For more information about kernel panic scenarios, see the following document [Kernel panic in Azure Linux VMs - Common kernel panic events](/azure/virtual-machines/linux-kernel-panic-troubleshooting#how-to-identify-a-kernel-panic).

However, in this section, we'll address, other important possible kernel panics that might cause no boot or no SSH scenarios.

Make sure you execute any commands from a repair VM, inside a chroot environment, as instructed in [Offline Troubleshooting](#offline-troubleshooting). If the system is already booted up over a previous kernel version, these commands can also be executed from the original VM using root privileges or sudo, as instructed in the [Online Troubleshooting](#online-troubleshooting) section.

### <a id="other-kernel-boot-issues-kernelupgrade"></a> Recent kernel upgrade

If the kernel panics started after a recent kernel upgrade, follow the instructions in [Booting an older kernel version](#bootingup-differentkernel) to boot the VM over the previous kernel version.

You could also check if there's already a newer kernel version released by the Linux distribution vendor and install it. For more information about how to install the latest kernel version, see [Kernel update process](#other-kernel-boot-issues-kernelupdate).

### <a id="other-kernel-boot-issues-kerneldowngrade"></a> Recent kernel downgrade

If the kernel panics started after a recent kernel downgrade process, the recommendation is to return to the latest installed kernel. You could also check if there's already a newer kernel version released by the Linux distribution vendor and install it. For more information about how to install the latest kernel version, see [Kernel update process](#other-kernel-boot-issues-kernelupdate).

To get the system booted over the most recent kernel version, you can follow the instructions in section [Changing the default kernel version manually](#bootingup-differentkernel-ARVMManual), but selecting the first kernel listed in the GRUB menu. In a manual modification, you could set the GRUB_DEFAULT value to 0 and regenerate the corresponding GRUB configuration file.

### <a id="other-kernel-boot-issues-kernelmodulechanges"></a> Kernel module changes

You might be experiencing a kernel panic related to a new kernel module, or a missing kernel module. You can get further details about the specific kernel module causing issues (if any) from the corresponding kernel panic trace.

You can validate your loaded kernel modules, also the ones disabled in /etc/modprobe.d/*.conf files.

* **RHEL/CentOS/Oracle Linux 7/8**

```bash
lsinitrd /boot/initramfs-3.10.0-1160.59.1.el7.x86_64.img
lsmod
cat /etc/modprobe.d/*.conf
```

>[!IMPORTANT]
> Replace **_3.10.0-1160.59.1.el7.x86_64_** with the corresponding kernel version.

* **SLES 12/15**

```bash
lsinitrd /boot/initrd-5.3.18-150300.38.53-azure
lsmod
cat /etc/modprobe.d/*.conf
```

>[!IMPORTANT]
> Replace **_5.3.18-150300.38.53-azure_** with the corresponding kernel version.

* **Ubuntu 18.04**

```bash
lsinitramfs /boot/initrd.img-5.4.0-1077-azure
lsmod
cat /etc/modprobe.d/*.conf
```

>[!IMPORTANT]
> Replace **_5.4.0-1077-azure_** with the corresponding kernel version.

In case you need to remove any specific kernel module, the following command can be used. Also, follow the instructions to [regenerate the initramfs](#missing-initramfs-manual), if needed.

```bash
rmmod <kernel_module_name>
```

> [!NOTE]
> In case there's a system service using that specific kernel module, you might need to disable it as well: `systemctl disable <serviceName>`, `systemctl stop <serviceName>` 

### <a id="other-kernel-boot-issues-OSchanges"></a> Operating system recent configuration changes

Identify any recent kernel configuration changes that might be causing issues. You might need to adjust those settings or roll back the configuration changes.

You can find persistent kernel parameters configured in any of the following files:

```bash
cat /etc/systctl.conf
cat /etc/sysctl.d/*
```

The following command can be used to analyze the current kernel parameters and their current values:

```bash
sysctl -a
```

> [!NOTE]
> That command should be used on a running system and not from a chroot environment

### <a id="other-kernel-boot-issues-missingfiles"></a> Possible missing files

For more information about this kind of issue, see [Missing important files and directories](#attempted-tokill-init-missingfilesdirs).

### <a id="other-kernel-boot-issues-wrongfilespermission"></a> Wrong permissions on files

For more information about this kind of issue, see [Wrong file permissions](#attempted-tokill-init-wrongpermissions).

### <a id="other-kernel-boot-issues-missingpartitions"></a> Missing partitions

For more information about this kind of issue, see [Missing partitions](#attempted-tokill-init-missingpartitions).

### <a id="other-kernel-boot-issues-kernelbugs"></a> Kernel bugs

You can [identify this issue from the Azure serial console](#identify-kernel-boot-issue). This kind of issue will look similar to the following output:

```output
[5275698.017004] kernel BUG at XXX/YYY.c:72!
[5275698.017004] invalid opcode: 0000 [#1] SMP
```

This kind of kernel panic is associated with kernel bugs or third party kernel bugs.

The recommendation in this kind of scenario, is to do a search in the vendor Knowledge Base, look for known issues in the corresponding kernel version your system is running, and include in your search the kernel BUG string. Below some important vendor resources:

* [Red Hat Kernel Oops Analyzer](https://access.redhat.com/labs/kerneloopsanalyzer/).
  * This tool is designed to help you diagnose a kernel crash. When you input a text or vmcore-dmesg.txt or a file including one or more kernel oops messages, we'll walk you through diagnosing the kernel crash issue.
* [Red Hat knowledge base](https://access.redhat.com/search/#/).
  * To get access to the Red Hat resources, it's required to link your Microsoft Azure and Red Hat accounts. For more information, see [How Microsoft Azure Customers Can Access the Red Hat Customer Portal
](https://access.redhat.com/articles/3189332).
* [SUSE knowledge base](https://www.suse.com/es-es/support/kb/help/).
* [Ubuntu knowledge base](https://wiki.ubuntu.com/KnowledgeBase).

In general terms, it's always recommended to keep all your systems up to date, to rule out any possible bugs already addressed in the most recent kernel versions. For more information, see [Kernel update process](#other-kernel-boot-issues-kernelupdate).

> [!IMPORTANT]
> It's recommended to have kdump configured and enabled, to generate a core dump, in case further analysis is required.

### <a id="other-kernel-boot-issues-kernelupdate"></a> Kernel update process

* To install the latest available kernel version, the following commands can be used:

  * **RHEL/CentOS/Oracle Linux**

    ```bash
    yum update kernel
    ```

  * **SLES 12/15**

    ```bash
    zypper refresh
    zypper update kernel*
    ```

  * **Ubuntu 18.04/20.04**

    ```bash
    apt update
    apt install linux-azure
    ```

* In case you need to reinstall a specific kernel version, the following command can be used. Make sure you aren't booted over the same kernel version you're trying to reinstall. Refer to [Booting the system on an older kernel version](#bootingup-differentkernel) to get further instructions.

  * **RHEL/CentOS/Oracle Linux**

    ```bash
    yum reinstall kernel-3.10.0-1160.59.1.el7.x86_64
    ```

    >[!IMPORTANT]
    > Replace **_3.10.0-1160.59.1.el7.x86_64_** by the corresponding kernel version.

  * **SLES 12/15**

    ```bash
    zypper refresh
    zypper install -f kernel-azure-5.3.18-150300.38.75.1.x86_64
    ```

    >[!IMPORTANT]
    > Replace **_kernel-azure-5.3.18-150300.38.75.1.x86_64_** by the corresponding kernel version.

  * **Ubuntu 18.04/20.04**

    ```bash
    apt update
    apt install --reinstall linux-azure=5.4.0.1091.68
    ```

    >[!IMPORTANT]
    > Replace **_5.4.0.1091.68_** by the corresponding kernel version.

* To update the system and apply the latest available changes, the following commands can be used:

  * **RHEL/CentOS/Oracle Linux**

    ```bash
    yum update
    ```

  * **SLES 12/15**

    ```bash
    zypper refresh
    zypper update
    ```

  * **Ubuntu 18.04/20.04**

    ```bash
    apt update
    apt upgrade
    ```

For more information about kernel panics that might be related to any of the following items, see [Kernel panics at run time](/troubleshoot/azure/virtual-machines/linux-kernel-panic-troubleshooting#scenario-2-kernel-panic-at-run-time).

* Application workload changes.
* Application development or application bugs.
* Performance related issues, etc.

## Next steps

In case the specific boot error isn't a GRUB rescue issue, refer to the [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
