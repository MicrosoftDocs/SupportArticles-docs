---
title: Azure Linux virtual machine boot enters dracut emergency shell
description: Provides solutions to an issue in which a Linux virtual machine (VM) can't boot because the OS file system isn't accessible from RAMdisk.
author: divargas-msft
ms.author: divargas
ms.date: 03/06/2023
ms.reviewer: jofrance
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.topic: troubleshooting
---

# Azure Linux virtual machine fails to boot and enters dracut emergency shell

This article provides solutions to an issue in which an Azure Linux virtual machine (VM) can't boot because the operating system (OS) file system isn't accessible from the RAMdisk. The VM lands in the dracut emergency shell.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-dracut-boot-issue"></a>How to identify dracut boot issue

To identify a dracut boot issue, use the Azure portal to view the serial console log output of the VM in the boot diagnostics pane, serial console pane, or use [AZ CLI](/cli/azure/serial-console#az-serial-console-connect).

All the VMs with the boot issue will land in the dracut or initramfs emergency shell and will show up at the end of the serial console log:

* **RHEL/CentOS/SLES/Oracle Linux:**

    ```output
    [  201.935612] dracut-initqueue[455]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  201.941153] dracut-initqueue[455]: Warning: Could not boot.
             Starting Setup Virtual Console...
    [[0;32m  OK  [0m] Started Setup Virtual Console.
             Starting Dracut Emergency Shell...
    Warning: /dev/mapper/rootvg-rootlv does not exist
    
    Generating "/run/initramfs/rdsosreport.txt"
    
    
    Entering emergency mode. Exit the shell to continue.
    Type "journalctl" to view system logs.
    You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
    after mounting them and attach it to a bug report.
    
    
    dracut:/# 
    ```

* **Ubuntu:**

    ```output
    mdadm: No arrays found in config file or automatically
    done.
    Gave up waiting for root file system device.  Common problems:
     - Boot args (cat /proc/cmdline)
       - Check rootdelay= (did the system wait long enough?)
     - Missing modules (cat /proc/modules; ls /dev)
    ALERT!  /dev/mapper/osencrypt does not exist.  Dropping to a shell!
    
    
    BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.4) built-in shell (ash)
    Enter 'help' for a list of built-in commands.
    
    (initramfs)
    ```

## <a id="online-troubleshooting"></a>Online troubleshooting

> [!TIP]
> If you have a recent backup of the VM, [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

The serial console is the fastest method to resolve issues. It allows you to directly fix the issue without having to present the system disk to a recovery VM. Make sure you meet the necessary prerequisites for your distribution. For more information, see [Virtual machine serial console for Linux](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).  

1. [Identify if your VM lands in the dracut emergency shell](#identify-dracut-boot-issue).

2. Try to troubleshoot the issue by using the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).

    > [!NOTE]
    > Not every issue can be addressed by using the Azure serial console.

    1. Trigger **Restart VM (Hard)** from the serial console.
    2. Interrupt your VM at the GRUB menu with the <kbd>ESC</kbd> key.
    3. Select <kbd>E</kbd> to modify the first kernel entry in the GRUB menu.
    4. Go to the `linux16` line, and then validate and correct [GRUB misconfiguration](#dracut-grub-misconf) as follows:
        * [Wrong root device path in the GRUB configuration file](#dracut-grub-misconf-wrong-root), wrong UUID or root volume name.
        * [Wrong swap device path in GRUB configuration file](#dracut-grub-misconf-wrong-swap).
        * [Duplicated parameters in the GRUB configuration file](#dracut-grub-misconf-dup-params).
        * Any obvious typo.

3. After manually modifying the GRUB settings, select <kbd>Ctrl</kbd>+<kbd>X</kbd> to boot the VM.

    Any modification done at this stage is a non-persistent modification. If the VM is able to boot, resolve this issue in the GRUB configuration file, or it will reoccur.

4. Once the VM is back online, fix the configuration issues in the `/etc/default/grub` configuration file and update the GRUB configuration. To do this, see [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

5. Reboot the VM to ensure it's able to boot up without any manual intervention.

## <a id="offline-troubleshooting"></a>Offline troubleshooting

> [!TIP]
> If you have a recent backup of the VM, [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

1. In case the [Azure serial console](serial-console-linux.md) doesn't work in the specific VM or isn't an option in your subscription, troubleshoot this issue by using a rescue/repair VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. Go to the following sections to resolve specific issues:

    * [ADE encrypted VM fails to boot because VFAT is disabled](#dracut-ade-without-vfat).
    * [Hyper-V drivers are missing](#dracut-hyperv-drivers-disabled).
    * [GRUB misconfiguration](#dracut-grub-misconf).
        * [Wrong root device path in the GRUB configuration file](#dracut-grub-misconf-wrong-root).
        * [Wrong swap device path in GRUB configuration file](#dracut-grub-misconf-wrong-swap).
        * [Duplicated parameters in the GRUB configuration file](#dracut-grub-misconf-dup-params).
    * [Root file system corruption](#dracut-rootfs-corruption).
    * [Issues with LVM activation](#dracut-lvm-issues).
    * [Root partition is missing](#dracut-rootpart-missing).
    * [Initrd or initramfs corruption](#dracut-initramfs-corruption).

3. After the dracut/initramfs-related boot issue is resolved, perform the following actions:

    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue/repair VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

## <a id="dracut-ade-without-vfat"></a>ADE encrypted VM fails to boot because VFAT is disabled

For more information,see [ADE encrypted VMs fail to boot](vfat-disabled-boot-issues.md#offline-troubleshooting-encrypted).

## <a id="dracut-hyperv-drivers-disabled"></a>Hyper-V drivers are missing

If the Hyper-V drivers included in the Linux kernel of all modern Linux distributions are disabled, re-enable them and regenerate the initramfs/initrd image. For more information, see [Scenario 3: Other Hyper-V drivers are disabled](linux-hyperv-issue.md#hyperv-drivers-disabled).

If the VM is Red Hat and is migrated from on-premises, enable the required Hyper-V drivers in the initramfs image. For more information, see [The Hyper-V driver could not be included in the initial RAM disk when using a non-Hyper-V hypervisor](/azure/virtual-machines/linux/redhat-create-upload-vhd#the-hyper-v-driver-could-not-be-included-in-the-initial-ram-disk-when-using-a-non-hyper-v-hypervisor).

## <a id="dracut-grub-misconf"></a>GRUB misconfiguration

The `rd.break` parameter forces the VM to boot in the dracut emergency shell. Make sure this parameter isn't hardcoded in the GRUB configuration file.

### <a id="dracut-grub-misconf-wrong-root"></a>Wrong root device path in GRUB configuration file

Validate if the root path `root=/dev/***` in the GRUB configuration file is correct. Make sure the proper device path is used.

* If you're inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Validate the `/etc/default/grub` file, the `GRUB_CMDLINE_LINUX` entry, and look for the `root=` parameter in case it's hardcoded in the configuration file.
    3. [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

* If you're in the Azure serial console:
    1. Follow step 3 in [Online troubleshooting](#online-troubleshooting).
    2. Validate the `linux16` line, and then look for the `root=` parameter and fix it.
    3. Select <kbd>Ctrl</kbd>+<kbd>X</kbd> to boot the VM.
    4. Once the VM successfully boots, modify the `/etc/default/grub` file, fix the `root` parameter, and update the GRUB configuration file, as instructed in [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

During this validation, make sure the following things:

* In Ubuntu VMs with OS encryption, make sure the device name is `/dev/mapper/osencrypt`.
* In VMs with Logical Volume Manager (LVM) in the OS disk, the root volume is `/dev/mapper/rootvg-rootlv`. The same path is used in RHEL VMs with ADE OS disk encrypted.
* Make sure no device names in the form of `/dev/sdX` are used, as they'll change across reboots, and they aren't persistent in Linux. For more information, see [Troubleshoot Linux VM device name changes](troubleshoot-device-names-problems.md).
* If UUIDs are used, make sure the proper root file system UUID is used and the syntax is `root=UUID=xxx-yyy-zzz`.

### <a id="dracut-grub-misconf-wrong-swap"></a>Wrong swap device path in GRUB configuration file

In this scenario, A VM fails to complete the boot process and enters the **dracut** emergency shell with an error similar to the following:

```output
[  188.000765] dracut-initqueue[324]: Warning: /dev/VG/SwapVol does not exist
         Starting Dracut Emergency Shell...
Warning: /dev/VG/SwapVol does not exist
```

The GRUB configuration file in this example is set to load a Logical Volume (LV) as swap with the parameter `rd.lvm.lv=VG/SwapVol`. However, the VM is unable to locate  this LV during the boot process.

It's important to note that using a swap device in this way in Azure Linux VMs is not recommended. For more information, see [Create a SWAP file for an Azure Linux VM](create-swap-file-linux-vm.md).

To resolve this issue, locate the swap path `rd.lvm.lv=VG/SwapVol` in the GRUB configuration file (`/etc/default/grub`) and remove it. To do this, use one of the following methods:

* If you're inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Edit the `/etc/default/grub` file, go to the `GRUB_CMDLINE_LINUX` entry, locate the `rd.lvm.lv=VG/SwapVol` parameter, and then remove it from the configuration.
    3. [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

* If you're in the Azure serial console:
    1. Follow step 3 in [Online troubleshooting](#online-troubleshooting).
    2. Go to the line starting with `linux`, locate the `rd.lvm.lv=VG/SwapVol` parameter and remove it.
    3. Select `<kbd>Ctrl</kbd>+<kbd>X</kbd>` to boot the VM.
    4. Once the VM successfully boots, modify the `/etc/default/grub` file, remove the `rd.lvm.lv=VG/SwapVol` parameter, and then update the GRUB configuration file, as instructed in [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file) section.

### <a id="dracut-grub-misconf-dup-params"></a>Duplicated parameters in GRUB configuration file

Validate if there are duplicated parameters in the GRUB configuration file:

* If you're inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Validate the `/etc/default/grub` file and the `GRUB_CMDLINE_LINUX` entry.
    3. Look for duplicated parameters and remove them.
    4. Update the GRUB configuration file. For more information, see [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

* If you're in the Azure serial console:
    1. Follow step 3 in [Online troubleshooting](#online-troubleshooting).
    2. Validate the `linux16` line, look for duplicated parameters and remove them.
    3. Select <kbd>Ctrl</kbd>+<kbd>X</kbd> to boot the VM.
    4. Once the VM successfully boots up, modify the `/etc/default/grub` file accordingly, fix the configuration issues previously identified, and update the GRUB configuration file, as instructed in [Reinstall GRUB and regenerate GRUB configuration file](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

## <a id="dracut-rootfs-corruption"></a>Root file system corruption

When the root file system is corrupted, it's unable to be mounted from the initrd/initramfs image.

To fix the root file system corruption, follow the instructions in [Troubleshoot Linux virtual machine boot issues due to filesystem errors - Perform filesystem repair](linux-recovery-cannot-start-file-system-errors.md#perform-filesystem-repair).

## <a id="dracut-lvm-issues"></a>Issues with LVM activation

Some issues may occur when you access the LVM physical volume (PV), volume group (VG), and/or logical volume (LV).
They can't be addressed from the Azure Serial console. To resolve them, use a repair/rescue VM.

1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
2. To identify the issues, run the following commands and take a look at the command outputs.
    1. Identify which device corresponds to the OS disk and verify if it's detected as a PV:

        ```bash
        lsblk
        pvs
        ```

    2. Validate if the `rootvg` VG is detected:

        ```bash
        vgs
        ```

    3. Validate if the LV is detected:

        ```bash
        lvs
        ```

3. Troubleshoot the following common LVM errors that cause issues with accessing the root volume:

    * **Unknown PV when the rootvg VG has only a single PV (this is the standard Azure configuration)**

        The partition holding the PV is incorrectly deleted, resized, or created. To resolve this issue, see [Root partition is missing](#dracut-rootpart-missing).

    * **Unknown PV when the rootvg VG is modified and split across more than one disk**

        Having 2 PVs in the rootvg VG isn't a recommended configuration. In this scenario, the data disk may be detached from the virtual machine, and the rootvg logical volumes are no longer accessible. To resolve this issue, reattach the original disk to the VM and restart it.

4. If the PV is unrecoverable, perform a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

## <a id="dracut-rootpart-missing"></a>Root partition is missing

The root file system may be inaccessible because of some issues that occur at the partition level during partition resize operations or others.

In this scenario, if you've documented the original partition table layout, with the exact start and end sectors for each of the original partitions (and no further modifications are done on the system, like new file systems creation), recreate the partitions by using the same original layout. You can do this with tools like `fdisk` (for MBR partition tables) or `gdisk` (for GPT partition tables) to gain access to the inaccessible file system. Follow this recovery operation from a repair/rescue VM. For more information, see the [Offline troubleshooting](#offline-troubleshooting) section.

If this approach doesn't work, we recommend performing a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

## <a id="dracut-initramfs-corruption"></a>Initrd or initramfs corruption

The initrd/initramfs image has some level of corruption which causes mounting the root volume and starting the OS startup process to fail.

To resolve this issue, follow these steps from inside chroot in a repair/rescue VM:

1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
2. [Regenerate missing initramfs manually](kernel-related-boot-issues.md#missing-initramfs-manual).
3. Restart the VM to confirm if it's able to boot.

## Next steps

In case the specific boot error isn't a dracut or initramfs issue, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
