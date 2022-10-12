---
title: How to recover Azure Linux VMs from a no boot scenario when the OS file system isn't accessible from initramfs
description: Provides solutions to an issue in which a Linux virtual machine (VM) cannot boot because the OS file system isn't accessible from initramfs
author: divargas-msft
ms.author: divargas
ms.date: 10/10/2022
ms.reviewer: jofrance
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting
---

# How to recover an Azure Linux virtual machine that landed at the Dracut Emergency Shell

This article provides solutions to an issue in which a Linux virtual machine (VM) can't boot because the OS file system isn't accessible from the RAMdisk. The VM lands into the Dracut or initramfs emergency shell.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-dracut-boot-issue"></a>How to identify a Dracut boot issue?

Use the Azure portal to view the serial console log output of the VM in the boot diagnostics pane, serial console pane, or [AZ CLI](/cli/azure/serial-console#az-serial-console-connect).

All the VMs with this issue, will land at the Dracut or initramfs emergency shell, and will show up at the end of the serial console log:

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
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

The serial console is the fastest method to resolve issues. It allows you to directly fix the issue without having to present the system disk to a recovery VM. Make sure you have met the necessary prerequisites for your distribution. For more information, see [Virtual machine serial console for Linux](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).  

1. [Identify if your VM is actually landing at the Dracut emergency shell](#identify-dracut-boot-issue).
2. Not every issue causing the VM to land into Dracut would be able to be addressed using the Azure serial console.
3. To give it a try, using the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux):
    1. Trigger a **_Restart VM (Hard)_** from the Azure Serial Console.
    2. Interrupt your VM at the GRUB menu with the `ESC` key.
    3. Press `e` to modify the first kernel entry in the GRUB menu.
    4. Go to the `linux16` line and validate if there's any evident GRUB misconfiguration and correct it. You could look for:
        * Duplicated parameters.
        * Wrong root device name, UUID, or root volume name.
        * Any obvious typo.

    For further information, check each of the following sections:
      * [GRUB misconfiguration](#dracut-grub-misconf):
        * [Wrong root device path in the GRUB configuration file](#dracut-grub-misconf-wrong-root).
        * [Duplicated parameters in the GRUB configuration file](#dracut-grub-misconf-dup-params).
4. After manually modifying the GRUB settings on the fly, you can press `CTRL+x` to try to boot the VM.

    > [!IMPORTANT]
    > Keep in mind, any modification done at this stage is a non-persistent modification. If the VM is able to boot, the issue needs to be corrected in the GRUB configuration file or it will reoccur.

5. Once the VM is back online, proceed to persistently fix the detected configuration issues in `/etc/default/grub` configuration file and update the GRUB configuration, following the instructions in [Reinstall GRUB and regenerate GRUB configuration file](/troubleshoot/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file).
6. Do a sanity reboot of the VM to ensure it's able to boot up without any manual intervention.

## <a id="offline-troubleshooting"></a>Offline troubleshooting

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. In case the [Azure serial console](serial-console-linux.md) isn't working in the specific VM or isn't an option in your subscription, you can also troubleshoot this issue using a rescue/repair VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux).

2. Review each of the following sections, that will help you to determine what specific issue are you facing and its resolution:

    * [ADE Encrypted VM unable to boot caused by disabling VFAT](#dracut-ade-without-vfat).
    * [Hyper-V drivers missing](#dracut-hyperv-drivers-disabled).
    * [GRUB misconfiguration](#dracut-grub-misconf).
        * [Wrong root device path in the GRUB configuration file](#dracut-grub-misconf-wrong-root).
        * [Duplicated parameters in the GRUB configuration file](#dracut-grub-misconf-dup-params).
    * [Root file system corruption](#dracut-rootfs-corruption).
    * [Issues with Logical Volume Manager (LVM) activation](#dracut-lvm-issues).
    * [Root partition missing](#dracut-rootpart-missing).
    * [Initrd or initramfs corruption](#dracut-initramfs-corruption).

3. After the Dracut/initramfs related boot issue has been resolved, perform the following actions:

    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue/repair VM.

    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

    4. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

## <a id="dracut-ade-without-vfat"></a>ADE Encrypted VM unable to boot caused by disabling VFAT

This scenario has been covered in the [How to recover an Azure Linux virtual machine from no boot caused by disabling VFAT](/troubleshoot/azure/virtual-machines/vfat-disabled-boot-issues) document.

## <a id="dracut-hyperv-drivers-disabled"></a>Hyper-V drivers missing

The Hyper-V drivers are already included in the Linux kernel of all modern Linux distributions.

If they've been disabled, they will need to be re-enabled and the initramfs or initrd image will need to be regenerated. This scenario has been covered in the [Troubleshoot Linux virtual machine boot and network issues due to Hyper-V driver associated errors - Scenario 3: Other Hyper-V drivers disabled](troubleshoot/azure/virtual-machines/linux-hyperv-issue#hyperv-drivers-disabled) document. Please follow the instructions to troubleshoot and fix this specific issue.

In case the VM is Red Hat and it's has been migrated from on-premises, please refer to [The Hyper-V driver could not be included in the initial RAM disk when using a non-Hyper-V hypervisor](/azure/virtual-machines/linux/redhat-create-upload-vhd#the-hyper-v-driver-could-not-be-included-in-the-initial-ram-disk-when-using-a-non-hyper-v-hypervisor), for further information about how to re-enable the required Hyper-V drivers in the initramfs image.

## <a id="dracut-grub-misconf"></a>GRUB misconfiguration

> [!IMPORTANT]
> The parameter `rd.break` forces the VM to boot in the Dracut emergency shell. Make sure that option isn't hardcoded in the GRUB configuration file.

### <a id="dracut-grub-misconf-wrong-root"></a>Wrong root device path in the GRUB configuration file

Validate the GRUB configuration. Look for the root path `root=/dev/***` and make sure the proper device path is being used:

* If you're inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Validate the file `/etc/default/grub`, `GRUB_CMDLINE_LINUX` entry and look for the parameter `root=`, in case it has been hardcoded in the configuration.
    3. Update the GRUB configuration file, for more information, see [Reinstall GRUB and regenerate GRUB configuration file](/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file).
* If you're in the Azure serial console:
    1. Follow step 3 in [Online troubleshooting](#online-troubleshooting).
    2. Validate the `linux16` line and look for the  `root=` parameter and fix it.
    3. Then press `CTRL+x` to boot the VM with these non persistent modification.
    4. Once the VM successfully boots, the changes need to be done persistently: 
        1. Modify the `/etc/default/grub` file accordingly, fixing the root parameter, and update the GRUB configuration file, as instructed in [Reinstall GRUB and regenerate GRUB configuration file](/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file).

A few things to have in consideration during this validation:

* In ubuntu VMs with OS encryption, make sure the device name is `/dev/mapper/osencrypt`
* In VMs with LVM in the OS disk, the root volume is `/dev/mapper/rootvg-rootlv`. This same path is used in RHEL VMs with ADE OS disk encrypted.
* Make sure no device names in the form of `/dev/sdX` are used, as they will change across reboots, they aren't persistent in Linux. For more information, see [Troubleshoot Linux VM device name changes](/troubleshoot/azure/virtual-machines/troubleshoot-device-names-problems).
* If UUIDs are used, make sure the proper root file system UUID is used and the proper syntax has been used as well: `root=UUID=xxx-yyy-zzz`

### <a id="dracut-grub-misconf-dup-params"></a>Duplicated parameters in the GRUB configuration file

Validate the GRUB configuration. Look for duplicated parameters:

* If you're inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Validate the file `/etc/default/grub`, `GRUB_CMDLINE_LINUX` entry.
    3. Look for duplicated parameters and remove them.
    4. Update the GRUB configuration file, for more information, see [Reinstall GRUB and regenerate GRUB configuration file](/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file).
* If you're in the Azure serial console:
    1. Follow step 3 in [Online troubleshooting](#online-troubleshooting).
    2. Validate the `linux16` line, look for duplicated parameters and get remove them.
    3. Then press `CTRL+x` to boot the VM with these non persistent modification.
    4. Once the VM successfully boots up, modify the `/etc/default/grub` file accordingly, fixing the configuration issues previously identified, and update the GRUB configuration file, as instructed in [Reinstall GRUB and regenerate GRUB configuration file](/azure/virtual-machines/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file)

## <a id="dracut-rootfs-corruption"></a>Root file system corruption

It's possible the root file system is corrupted, hence it's unable to be mounted from the initrd/initramfs image.

To fix the root file system corruption, follow the instructions in [Troubleshoot Linux virtual machine boot issues due to filesystem errors - Perform filesystem repair](/troubleshoot/azure/virtual-machines/linux-recovery-cannot-start-file-system-errors#perform-filesystem-repair).

## <a id="dracut-lvm-issues"></a>Issues with Logical Volume Manager (LVM) activation
<!--Issue getting the LVM VG activated-->

It's possible there're issues trying to access the LVM physical volume (PV), volume group (VG) and/or logical volume (LV).

This process isn't possible to be address from the Azure Serial console. A repair/rescue VM will be required.

From a rescue/repair VM:

1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
2. Run the following commands and identify any issue by taking a look a the following outputs:
    1. Identify which device corresponds to the OS disk. Also, verify if it's detected as a PV, by taking a look at the outputs

    ```bash
    lsblk
    pvs
    ```

    2. Validate if the `rootvg` VG has been detected, using the following command:

    ```bash
    vgs
    ```

    3. Validate if the LV has been detected, using the following command:

    ```bash
    lvs
    ```

3. Troubleshoot the LVM error.

    Below some common LVM errors causing issues to access the root volume:

    * **Unknown PV, when the rootvg VG has only a single PV (this is the standard Azure configuration)**
      * The partition holding the PV has been deleted by mistake, incorrectly resized or created wrong. This could be caused by a human error or during errors trying to perform partition resize operations. For further information, see [Root partition missing](#dracut-rootpart-missing).
    * **Unknown PV, when the rootvg VG has been modified and it has been split across more than one disk.**
      * Please keep in mind this isn't a recommended configuration.
      * In this scenario, it's possible the data disk was detached from the virtual machine and the rootvg logical volumes are no longer accessible. To resolve this issue, reattach the original disk to the VM and restart it.
4. If the PV is unrecoverable, perform a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).


## <a id="dracut-rootpart-missing"></a>Root partition missing

It's possible the root file system is inaccessible because of issues at partition level, which might be caused by mistakes during partition resize operations, or others.

In this scenario, if you've documented the original partition table layout, with the exact start and end sectors for each of the original partitions, and **no further modifications were done on the system**, like new file systems creation, you can try to recreate the partitions using the same original layout with tools like **fdisk** (for MBR partition tables) or **gdisk** (for GPT partition tables) to gain access to the inaccessible file system.

> [!IMPORTANT]
> This recovery operation will need to be followed from a repair/rescue VM, for further details, see the [Offline troubleshooting](#offline-troubleshooting) section.

If that approach doesn't work, the recommended option left, is to perform a [restore from backup](/azure/backup/backup-azure-arm-restore-vms).

## <a id="dracut-initramfs-corruption"></a>Initrd or initramfs corruption

It's possible the initrd/initramfs image has some level of corruption causing issues to mount the root volume and start the OS start up process.

* From inside chroot in a repair/rescue VM:
    1. Follow step 1 in [Offline troubleshooting](#offline-troubleshooting).
    2. Follow the instructions in [Regenerate missing initramfs manually](/troubleshoot/azure/virtual-machines/kernel-related-boot-issues#missing-initramfs-manual)
    3. Restart the VM to confirm if it's able to boot.

## Next steps

In case the specific boot error isn't a Dracut or initramfs issue, refer to the [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
