---
title: How to recover Azure Linux VM from kernel-related boot issues
description: Provides solutions to an issue in which a Linux virtual machine (VM) can't restart after applying kernel changes.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# How to recover an Azure Linux virtual machine from kernel-related boot issues

This article provides solutions to an issue in which a Linux virtual machine (VM) can't restart after applying kernel changes.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4091524

## Symptoms

After you apply certain kernel changes (such as a kernel upgrade) to a Linux virtual machine (VM) on Azure, the VM can't restart. One of the following kernel errors is logged during the startup process:

- An "no root device found" error that resembles the following one:

    ```
    dracut Warning: No root device "block:/dev/disk/by-uuid/UUID" found
    dracut Warning: Boot has failed. To debug this issue add "rdshell" to the kernel command line.
    dracut Warning: Signal caught!
    Kernel panic - not syncing: Attempted to kill init!
    Pid: 1, comm: init Not tainted 2.6.32-504.12.2.el6.x86_64 #1
    Call Trace:
    [<ffffffff8152933c>] ? panic+0xa7/0x16f
    [<ffffffff8107a5f2>] ? do_exit+0x862/0x870
    [<ffffffff8118fa25>] ? fput+0x25/0x30
    [<ffffffff8107a658>] ? do_group_exit+0x58/0xd0
    [<ffffffff8107a6e7>] ? sys_exit_group+0x17/0x20
    [<ffffffff8100b072>] ? system_call_fastpath+0x16/0x1b
    ```

- A kernel-timeout error that resembles the following one:

    ```
    INFO: task swapper:1 blocked for more than 120 seconds.
    Not tainted 2.6.32-504.8.1.el6.x86_64 #1
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    swapper       D 0000000000000000     0     1      0 0x00000000
    ffff88010f64fde0 0000000000000046 ffff88010f64fd50 ffffffff81074f95
    0000000000005c2f ffffffff8100bb8e ffff88010f64fe50 0000000000100000
    0000000000000002 00000000fffb73e0 ffff88010f64dab8 ffff88010f64ffd8
    Call Trace:
    [<ffffffff81074f95>] ? __call_console_drivers+0x75/0x90
    [<ffffffff8100bb8e>] ? apic_timer_interrupt+0xe/0x20
    [<ffffffff81075d51>] ? vprintk+0x251/0x560
    [<ffffffff8152a862>] schedule_timeout+0x192/0x2e0
    [<ffffffff810874f0>] ? process_timeout+0x0/0x10
    [<ffffffff8152a9ce>] schedule_timeout_uninterruptible+0x1e/0x20
    [<ffffffff81089650>] msleep+0x20/0x30
    [<ffffffff81c2a571>] prepare_namespace+0x30/0x1a9
    [<ffffffff81c2992a>] kernel_init+0x2e1/0x2f7
    [<ffffffff8100c20a>] child_rip+0xa/0x20
    [<ffffffff81c29649>] ? kernel_init+0x0/0x2f7
    [<ffffffff8100c200>] ? child_rip+0x0/0x20
    ```

- A null pointer error that resembles the following one:

    ```
    Pid: 242, comm: async/1 Not tainted 2.6.32-504.12.2.el6.x86_64 #1
    Call Trace:
    [<ffffffff81177468>] ? kmem_cache_create+0x538/0x5a0
    [<ffffffff8152aede>] ? mutex_lock+0x1e/0x50
    [<ffffffff81370424>] ? attribute_container_add_device+0x104/0x150
    [<ffffffffa009c1de>] ? storvsc_device_alloc+0x4e/0xa0 [hv_storvsc]
    [<ffffffff8138a1dc>] ? scsi_alloc_sdev+0x1fc/0x280
    [<ffffffff8138a739>] ? scsi_probe_and_add_lun+0x4d9/0xe10
    [<ffffffff8128e62d>] ? kobject_set_name_vargs+0x6d/0x70
    [<ffffffff8152aede>] ? mutex_lock+0x1e/0x50
    [<ffffffff81370424>] ? attribute_container_add_device+0x104/0x150
    [<ffffffff81367ae9>] ? get_device+0x19/0x20
    [<ffffffff8138b440>] ? scsi_alloc_target+0x2d0/0x300
    [<ffffffff8138b661>] ? __scsi_scan_target+0x121/0x740
    [<ffffffff8138bd07>] ? scsi_scan_channel+0x87/0xb0
    [<ffffffff8138bde0>] ? scsi_scan_host_selected+0xb0/0x190
    [<ffffffff8138bf51>] ? do_scsi_scan_host+0x91/0xa0
    [<ffffffff8138c13c>] ? do_scan_async+0x1c/0x150
    [<ffffffff810a7086>] ? async_thread+0x116/0x2e0
    [<ffffffff81064b90>] ? default_wake_function+0x0/0x20
    [<ffffffff810a6f70>] ? async_thread+0x0/0x2e0
    [<ffffffff8109e66e>] ? kthread+0x9e/0xc0
    [<ffffffff8100c20a>] ? child_rip+0xa/0x20
    [<ffffffff8109e5d0>] ? kthread+0x0/0xc0
    [<ffffffff8100c200>] ? child_rip+0x0/0x20
    BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
    IP: [<ffffffffa009c0a0>] storvsc_device_destroy+0x20/0x50 [hv_storvsc]
    PGD 0
    ```

- A kernel panic error that resembles the following one:

    ```
    Invalid op code: 0000 [#2] [11427.908676] - end trace 61a458bb863d7f0f ]-
    Kernel panic - not syncing: attempted to kill the idle task!
    ```

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](https://docs.microsoft.com/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To recover the Linux VM on Azure, you must either install a newer kernel or roll back to an earlier version manually by using one of the following repair options.

To perform this action, use the usual procedure: Delete the affected Linux VM and keep the operating system disk, and then attach the disk to a new VM that has the same version of the affected VM (or, at least, of the same distribution). Then, use one of the following repair options.

#### Repair option 1

Roll back the kernel, and start from a previous working setup by editing the configuration files. For more information, see [How to update configuration files](#methods-to-update-configuration-files).

> [!NOTE]
> Linux boot loaders usually have more than one entry that defines which kernel to use for booting. When you do an upgrade to reference the new installed kernel, the entry is updated.

#### Repair option 2

Install or reinstall a kernel by attaching the affected VM operating system disk to a temporary new VM, and then running a tool such as apt-get, `Yellowdog Updater Modified` (YUM), or `Zypper`. For more information, see [Linux Recovery: Using CHROOT steps to recover VMs that are not accessible](https://docs.microsoft.com/archive/blogs/linuxonazure/linux-recovery-using-chroot-steps-to-recover-vms-that-are-not-accessible).

> [!NOTE]
> This second option may be the best way to do the repair because you don't have to edit files manually.

If the VM can't start from a previous kernel, you can try to rebuild the initramfs file, and then copy a new compressed image of the Linux kernel. For more information, see [How to rebuild the initramfs file](#how-to-rebuild-the-initramfs-file).

## More information

### About configuration files

You can use the command **uname -a** to get all system information. For example, if a Linux VM that is running CentOS 6.6 has kernel version 2.6.32-504.16.2.el6.x86_64 loaded, you would get the following output:

```
Linux vfldev 2.6.32-504.16.2.el6.x86_64 #1 SMP Date\Time x86_64 x86_64 x86_64 GNU/Linux
```

The boot loader configuration file contains the information about the kernel version that will be loaded. The file for CentOS is /boot/grub/grub.conf, and the new version as of RHEL 7 is /boot/grub2/grub.cfg.

The first four lines of the grub.conf file contain the following information about the currently loaded version:

- **title:** Specifies the title that only is displayed in the menu (not applicable in cloud environments).
- **root:** Specifies the root partition.
- **kernel:** Specifies the kernel command line that is being loaded at boot time and its parameters.
- **initrd:** Specifies the path for the initrd file that will be loaded to boot, which usually matches the installation path of the kernel.

The following are examples of grub files for different versions of the Linux kernel:

```
title CentOS (2.6.32-504.16.2.el6.x86_64)
root (hd0,0)
kernel /boot/vmlinuz-2.6.32-504.16.2.el6.x86_64 ro root=UUID=UUIDrd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300 crashkernel=auto
initrd /boot/initramfs-2.6.32-504.16.2.el6.x86_64.img
```

```
title CentOS (2.6.32-504.12.2.el6.x86_64)
root (hd0,0)
kernel /boot/vmlinuz-2.6.32-504.12.2.el6.x86_64 ro root=UUID=UUIDrd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300 crashkernel=auto
initrd /boot/initramfs-2.6.32-504.12.2.el6.x86_64.img
```

```
title CentOS (2.6.32-504.8.1.el6.x86_64)
root (hd0,0)
kernel /boot/vmlinuz-2.6.32-504.8.1.el6.x86_64 ro root=UUID=UUIDrd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300 crashkernel=auto
initrd /boot/initramfs-2.6.32-504.8.1.el6.x86_64.img
```

```
title CentOS (2.6.32-431.29.2.el6.x86_64)
root (hd0,0)
kernel /boot/vmlinuz-2.6.32-431.29.2.el6.x86_64 ro root=UUID=UUIDrd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300
initrd /boot/initramfs-2.6.32-431.29.2.el6.x86_64.img
```

### Methods to update configuration files

To change the boot loader (grub.conf) and force the Linux VM to load a different kernel, manual intervention is required. To perform this action, use one of the following methods.

#### Method 1: Serial console

The serial console is the fastest method to resolve this issue. This allows you to directly fix the issue without having to present the system disk to a recovery VM. Make sure you have met the necessary prerequisites for your distribution. For more information, see [Virtual machine serial console for Linux](https://docs.microsoft.com/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).  After you have access to the serial console, go to the [mitigation steps](#mitigation-steps).  After you complete the mitigation steps, restart the VM.

#### Method 2: Offline repair

If the serial console isn't enabled on your VM, or if it doesn't work, you can repair the system offline by following these steps:

1. Attach the system disk of the VM as a data disk to a recovery VM (any working Linux VM). To do it, [use CLI commands](https://docs.microsoft.com/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-linux) or [VM recovery script](https://github.com/Azure/azure-support-scripts/tree/master/VMRecovery/ResourceManager).
2. Follow the steps in the mitigation section.
3. Unmount and detach the original virtual hard disk, and then create a VM from the original system disk. To do it, [use CLI commands](https://docs.microsoft.com/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-linux) or [VM recovery script](https://github.com/Azure/azure-support-scripts/tree/master/VMRecovery/ResourceManager).

#### Mitigation steps

1. Modify the `/mnt/troubleshootingdisk /boot/grub.conf` file. Here is an example of a modified grub.conf file:

    ```
    #title CentOS (2.6.32-504.16.2.el6.x86_64)
    
    #root (hd0,0)
    
    #kernel /boot/vmlinuz-2.6.32-504.16.2.el6.x86_64 ro root=UUID=UUID rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300 crashkernel=auto
    
    #initrd /boot/initramfs-2.6.32-504.16.2.el6.x86_64.img
    ```

2. Check whether the device that is specified by the UUID value from the boot loader file grub.conf exists.

    For example, when you check the system disk that is mounted on `/mnt/troubleshootingdisk` by looking in `/mnt/troubleshootingdisk /dev/disk/by-uuid`, you can see that there's a corresponding UUID file on disk that is referenced in the grub.conf file. The file is actually a symbolic link that is denoted by the character **l** at the start of the **lrwxrwxrwx** attribute that is pointing to the operating system disk sda1. If the file is missing, the symbolic link can be re-created during system startup.
3. You can create symbolic links manually by running the following command if you know whether sda1 is your startup device and you know the corresponding UUID:

    ```console
    cd /mnt/troubleshootingdisk/dev/disk/by-uuid ln -s ../../sda1 UUID
    ```

    > [!NOTE]
    > The sda1 file is known as a block device in Linux. You can check it in the `ls` command output, in which it's denoted by the character `b` in the `brw-rw--` attribute.
4. You can also check whether this file exists on a CentOS 6.5, and the file can be re-created if it's missing. For example, run the following command:

    ```console
    cd /mnt/troubleshootingdisk/dev/disk/by-uuid ls -ltr ../../sda1
    ```

     The output resembles the following one:

    ```console
    brw-rw-- 1 root disk 8, 1 Date\Time ../../sda1
    ```

    You can use the following command to determine the type of the file:

    ```console
    file ../../sda1 ../../sda1: block special
    ```

### How to rebuild the initramfs file

You can see the initramfs and kernel files in the example grub file (in the previous section) as follows:

- Initramfs file

    `initrd /boot/initramfs-2.6.32-504.16.2.el6.x86_64.img`
- Kernel file 

    `/boot/vmlinuz-2.6.32-504.16.2.el6.x86_64`

Usually, you start a system from a recovery cd on-premises environment. However, in cloud environments, you have to attach the system disk to a temporary VM of the same operating system and version for recovering or manipulating system files for a no-boot scenario. It's needed when you try to copy or re-create initramfs and kernel files.
> [!NOTE]
> After you attach the operating system disk to a temporary VM on /mnt/troubleshootingdisk (first secure any data by copying off the operating system disk), revert any previously made changes to grub.conf if you had commented out entries that refer to the first kernel to boot re-instate them.

You can follow these steps to rebuild the initramfs file:

1. Generate an initramfs file that is based on the existing version:

    `mv /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.8.1.el6.x86_64.img /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.8.1.el6.x86_64.old-img dracut /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.8.1.el6.x86_64.img 2.6.32-504.8.1.el6.x86_64`

    For example, you have to build and use the latest version available on the temporary CentOS 6.6 Linux VM, because you can't locate the exact same initramfs file.

2. Copy the relevant vmlinuz file, and then update the grub.conf file to reflect new kernel values. To do it, use the commands in following table.

| **Command**| **Output** |
|---|---|
|`ls -ltr /lib/modules/`|`drwxr-xr-x. 7 root root 4096 Date 2.6.32-431.11.2.el6.x86_64`<br/>`drwxr-xr-x. 7 root root 4096 Date 2.6.32-431.17.1.el6.x86_64`<br/>`drwxr-xr-x. 7 root root 4096 Date 2.6.32-431.29.2.el6.x86_64`<br/>`drwxr-xr-x. 7 root root 4096 Date\Time 2.6.32-504.1.3.el6.x86_64`<br/>`drwxr-xr-x. 7 root root 4096 Date\Time 2.6.32-504.12.2.el6.x86_64`|
|`dracut /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.12.2.el6.x86_64.img 2.6.32-504.12.2.el6.x86_64`<br/>`ls -ltr /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.12.2.el6.x86_64.img`| `-rw---. 1 root root 19354168 Date\Time /mnt/troubleshootingdisk/boot/initramfs-2.6.32-504.12.2.el6.x86_64.img` |
|`cp /boot/vmlinuz-2.6.32-504.12.2.el6.x86_64 /mnt/troubleshootingdisk/boot/`<br/>`ls -ltr /mnt/troubleshootingdisk/boot/vmlinuz*`|`-rwxr-xr-x. 1 root root 4128368 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-431.el6.x86_64`<br/>`-rwxr-xr-x. 1 root root 4128688 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-431.3.1.el6.x86_64`<br/>`-rwxr-xr-x. 1 root root 4129872 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-431.17.1.el6.x86_64`<br/>`-rwxr-xr-x. 1 root root 4131984 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-431.29.2.el6.x86_64`<br/>`-rwxr-xr-x. 1 root root 4153008 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-504.8.1.el6.x86_64`<br/>`-rwxr-xr-x. 1 root root 4152720 Date\Time /mnt/troubleshootingdisk/boot/vmlinuz-2.6.32-504.12.2.el6.x86_64`|
|`vi /mnt/troubleshootingdisk/boot/grub/grub.conf`|title CentOS (2.6.32-504.12.2.el6.x86_64)<br/>root (hd0,0)<br/>`kernel /boot/vmlinuz-2.6.32-504.12.2.el6.x86_64 ro root=UUID=UUID rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM rhgb quiet numa=off console=ttyS0 earlyprintk=ttyS0 rootdelay=300`<br/>initrd /boot/initramfs-2.6.32-504.12.2.el6.x86_64.img|
|||
