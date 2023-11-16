---
title: Linux VM boots to GRUB rescue
description: Provides troubleshooting guidance for GRUB rescue issues with Linux virtual machines.
services: virtual-machines
documentationcenter: ''
author: divargas
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: na
ms.topic: troubleshooting
ms.date: 06/23/2022
ms.author: divargas
---

# Linux virtual machine boots to GRUB rescue

This article discusses multiple conditions that cause GRUB rescue issues and provides troubleshooting guidance.

During the boot process, the boot loader will try to locate the Linux kernel and hand off the boot control. If this handoff can't be performed, the virtual machine (VM) will enter a GRUB rescue console. The GRUB rescue console prompt won't be shown in the Azure serial console log, but it can be shown in the [Azure boot diagnostics screenshot](/azure/virtual-machines/boot-diagnostics#boot-diagnostics-view).

## <a id="identify-grub-rescue-issue"></a>Identify GRUB rescue issue

[View a boot diagnostics screenshot](/azure/virtual-machines/boot-diagnostics#boot-diagnostics-view) in the VM **Boot diagnostics** blade in the Azure portal. This screenshot will help diagnose the GRUB rescue issue and determine if a boot error causes the issue.

Here is an example of a GRUB rescue issue:

```output
error: file '/boot/grub2/i386-pc/normal.mod' not found.  
Entering rescue mode...  
grub rescue>
```

## <a id="offline-troubleshooting"></a>Troubleshoot GRUB rescue issue offline

1. To troubleshoot a GRUB rescue issue, a rescue/repair VM is required. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. [Identify GRUB rescue issue](#identify-grub-rescue-issue). When you encounter one of the following GRUB rescue issues, go to the corresponding section to resolve it:

    * [Error: unknown filesystem](#unknown-filesystem)
    * [Error 15: File not found](#error15)
    * [Error: file '/boot/grub2/i386-pc/normal.mod' not found](#normal-mod-file-not-found)
    * [Error: no such partition](#no-such-partition)
    * [Other GRUB rescue errors](#other-grub-rescue-errors)

3. After the GRUB rescue issue is resolved, perform the following actions:

    1. Unmount the copy of the file systems from the rescue/repair VM.

    2. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

    3. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

4. If the entire /boot partition or other important contents are missing and can't be recovered, we recommend restoring the VM from a backup. For more information, see [How to restore Azure VM data in Azure portal](/azure/backup/backup-azure-arm-restore-vms).

See the following sections for detailed errors, possible causes, and solutions.

> [!NOTE]
> In the commands mentioned in the following sections, replace `/dev/sdX` with the corresponding Operating System (OS) disk device.

## <a id="unknown-filesystem"></a>Error: unknown filesystem

The following screenshot shows the error message:

:::image type="content" source="./media/troubleshoot-vm-boot-error/grub-unknown-filesystem.png" alt-text="Screenshot of grub unknown file system error.":::

This error might be associated with one of the following issues:

* /boot file system corruption.

  To resolve this issue, follow the steps in [Fix /boot file system corruption](#fix-boot-file-system-corruption).

* GRUB boot loader is pointing to an invalid disk or partition.

  To resolve this issue, [reinstall GRUB and regenerate GRUB configuration file](#reinstall-grub-regenerate-grub-configuration-file).

* OS disk partition table issues caused by human error.

  To resolve such issues, follow the steps in [Error: No such partition](#no-such-partition) with recommendations to recreate the /boot partition if missing or created incorrectly.

### <a id="fix-boot-file-system-corruption"></a>Fix /boot file system corruption

1. Make sure that a rescue/repair VM has been created. If not, follow step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create it.

2. Refer to [Troubleshoot file system corruption errors in Azure Linux](linux-recovery-cannot-start-file-system-errors.md) to resolve the corruption issues in the corresponding /boot partition.

3. Proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

### <a id="reinstall-grub-regenerate-grub-configuration-file"></a>Reinstall GRUB and regenerate GRUB configuration file

1. Make sure that a rescue/repair VM has been created. If not, follow step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create it. Mount all the required file systems, including / and /boot in the rescue/repair VM, and then do [chroot](chroot-environment-linux.md).

2. Reinstall GRUB and regenerate the corresponding GRUB configuration file by using one of the following commands:

    * **RHEL/CentOS/Oracle 7.x/8.x Linux VMs without UEFI (BIOS based - Gen1)**

        ```bash
        # grub2-install /dev/sdX
        # grub2-mkconfig -o /boot/grub2/grub.cfg
        # sed -i 's/hd2/hd0/g' /boot/grub2/grub.cfg
        ```

    * **RHEL/CentOS/Oracle 7.x/8.x Linux VMs with UEFI (Gen2)**

        ```bash
        # grub2-install /dev/sdX
        # grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
        # sed -i 's/hd2/hd0/g' /boot/efi/EFI/redhat/grub.cfg
        ```

      If the VM is running CentOS, replace `redhat` with `centos` in the *grub.cfg* file absolute path */boot/efi/EFI/centos/grub.cfg*.

    * **SLES 12/15 Gen1 and Gen2**

        ```bash
        # grub2-install /dev/sdX
        # grub2-mkconfig -o /boot/grub2/grub.cfg
        # sed -i 's/hd2/hd0/g' /boot/grub2/grub.cfg
        ```

    * **Ubuntu 18.04/20.04**

        ```bash
        # grub-install /dev/sdX
        # update-grub
        ```
  
3. Proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

## <a id="error15"></a>Error 15: File not found

The following screenshot shows the error message:

:::image type="content" source="./media/troubleshoot-vm-boot-error/grub-error15-file-not-found.png" alt-text="Screenshot of grub error 15 file not found.":::

To resolve this issue, follow these steps:

1. Make sure that a rescue/repair VM has been created. If not, follow the step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create it. Mount all the required file systems, including / and */boot* in the rescue/repair VM, and then do [chroot](chroot-environment-linux.md).

2. Inspect the /boot file system contents and validate what's missing.

3. If the GRUB configuration file is missing, [reinstall GRUB and regenerate GRUB configuration file](#reinstall-grub-regenerate-grub-configuration-file).

4. Validate that the file permissions in the /boot file system are fine. You can compare the permissions by using another VM with the same Linux version.

5. If the entire /boot partition or other important contents are missing and can't be recovered, we recommend restoring the VM from a backup. For more information, see [How to restore Azure VM data in Azure portal](/azure/backup/backup-azure-arm-restore-vms).

6. Once the issue is resolved, proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

## <a id="normal-mod-file-not-found"></a>Error: file '/boot/grub2/i386-pc/normal.mod' not found

The following screenshot shows the error message:

:::image type="content" source="./media/troubleshoot-vm-boot-error/grub-normal-file-not-found.png" alt-text="Screenshot of grub error normal.mod not found.":::

1. Make sure that a rescue/repair VM has been created. If not, follow step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create one. Mount all the required file systems, including / and /boot in the rescue/repair VM, and then do [chroot](chroot-environment-linux.md).

2. If you're unable to mount the /boot file system due to a corruption error, [fix /boot file system corruption](#fix-boot-file-system-corruption).

3. Once you're located inside chroot, validate the contents in the */boot/grub2/i386-pc* directory. If the contents are missing, copy the contents from */usr/lib/grub/i386-pc*. To do this, use the following commands:

    ```bash
    # ls -l /boot/grub2/i386-pc
    # cp -rp /usr/lib/grub/i386-pc /boot/grub2
    ```

4. Proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

## <a id="no-such-partition"></a>Error: no such partition

The following screenshot shows the error message:

:::image type="content" source="./media/troubleshoot-vm-boot-error/grub-no-such-partition.png" alt-text="Screenshot of grub error no such partition.":::

This error will occur with a RHEL-based VM (Red Hat, Oracle Linux, CentOS) in one of the following scenarios:

* The /boot partition is deleted by mistake.
* The /boot partition is recreated with the wrong start and end sectors.

### Solution: Recreate /boot partition

If the /boot partition is missing, recreate it by following these steps:

1. Make sure that a rescue/repair VM has been created. If not, follow the step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create it.

2. Identify if the partition table is created as the **dos** or **GPT** type by using the following command:

    ```bash
    # fdisk -l /dev/sdX
    ```

    * **Dos partition table**

        :::image type="content" source="./media/troubleshoot-vm-boot-error/boot-dos01.png" alt-text="Screenshot shows boot with dos type partition table.":::

    * **GPT partition table**

        :::image type="content" source="./media/troubleshoot-vm-boot-error/boot-gpt01.png" alt-text="Screenshot shows boot with GPT type partition table.":::

3. If the partition table has **dos** as the partition table type, [recreate /boot partition in dos systems](#recreate-boot-partition-in-dos-systems). If the partition table has **GPT** as the partition table type, [recreate /boot partition in GPT systems](#recreate-boot-partition-in-gpt-systems).

4. Make sure that the GRUB boot loader is installed by using the proper disk. You can follow the steps in [Reinstall GRUB and regenerate GRUB configuration file](#reinstall-grub-regenerate-grub-configuration-file) to get it installed and configured.

5. Proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

#### <a id="recreate-boot-partition-in-dos-systems"></a>Recreate /boot partition in dos systems

1. Recreate the /boot partition by using the following command:

    ```bash
    # fdisk /dev/sdX
    ```

    Use the default values in the **First** and **Last** sectors, and **partition type** (83). Make sure the /boot partition table is marked as bootable by using the `a` option in the `fdisk` tool, as shown in the output below:

    ```output
    # fdisk /dev/sdc
    
    The device presents a logical sector size that is smaller than
    the physical sector size. Aligning to a physical sector (or optimal
    I/O) size boundary is recommended, or performance may be impacted.
    Welcome to fdisk (util-linux 2.23.2).
    
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.
    
    Command (m for help): n
    Partition type:
       p   primary (1 primary, 0 extended, 3 free)
       e   extended
    Select (default p): p
    Partition number (1,3,4, default 1): 1
    First sector (2048-134217727, default 2048):
    Using default value 2048
    Last sector, +sectors or +size{K,M,G} (2048-2099199, default 2099199):
    Using default value 2099199
    Partition 1 of type Linux and of size 1 GiB is set
    
    Command (m for help): t
    Partition number (1,2, default 2): 1
    Hex code (type L to list all codes): 83
    Changed type of partition 'Linux' to 'Linux'
    
    Command (m for help): a
    Partition number (1,2, default 2): 1
    
    Command (m for help): p
    
    Disk /dev/sdc: 68.7 GB, 68719476736 bytes, 134217728 sectors
    Units = sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 4096 bytes
    I/O size (minimum/optimal): 4096 bytes / 4096 bytes
    Disk label type: dos
    Disk identifier: 0x000b7179
    
    Device Boot      Start         End      Blocks   Id  System
    /dev/sdc1   *        2048     2099199     1048576   83  Linux
    /dev/sdc2         2099200   134217727    66059264   8e  Linux LVM
    
    Command (m for help): w
    The partition table has been altered!
    
    Calling ioctl() to re-read partition table.
    ```

2. After recreating the missing /boot partition, validate if the /boot file system is detected. You should be able to see an entry for `/dev/sdX1` (the missing /boot partition).

    ```bash
    # blkid /dev/sdX1
    ```

    ```output
    # blkid /dev/sdc1
    /dev/sdc1: UUID="<UUID>" TYPE="ext4"
    ```

3. If the /boot file system isn't visible in `blkid` after recreating the partition, it means the /boot data is no longer there. You'll need to recreate it (by using the same UUID and file system format than in the */etc/fstab* /boot entry) and [restore its contents from backup](/azure/backup/backup-azure-arm-restore-vms).

#### <a id="recreate-boot-partition-in-gpt-systems"></a>Recreate /boot partition in GPT systems

1. Recreate the /boot partition by using the following command:

    ```bash
    # gdisk /dev/sdX
    ```

    Use the default values in the **First** and **Last** sectors, and **partition type** (8300), as shown in the output below:

    ```output
    # gdisk /dev/sdc
    GPT fdisk (gdisk) version 1.0.3
    
    Partition table scan:
      MBR: protective
      BSD: not present
      APM: not present
      GPT: present
    
    Found valid GPT with protective MBR; using GPT.
    
    Command (? for help): n
    Partition number (1-128, default 1): 1
    First sector (34-134217694, default = 1026048) or {+-}size{KMGTP}:
    Last sector (1026048-2050047, default = 2050047) or {+-}size{KMGTP}:
    Current type is 'Linux filesystem'
    Hex code or GUID (L to show codes, Enter = 8300):
    Changed type of partition to 'Linux filesystem'
    
    Command (? for help): p
    Disk /dev/sdc: 134217728 sectors, 64.0 GiB
    Model: Virtual Disk
    Sector size (logical/physical): 512/4096 bytes
    Disk identifier (GUID): 6D915856-445A-4513-97E4-C55F2E1AD6C0
    Partition table holds up to 128 entries
    Main partition table begins at sector 2 and ends at sector 33
    First usable sector is 34, last usable sector is 134217694
    Partitions will be aligned on 2048-sector boundaries
    Total free space is 6076 sectors (3.0 MiB)
    
    Number  Start (sector)    End (sector)  Size       Code  Name
       1         1026048         2050047   500.0 MiB   8300  Linux filesystem
       2         2050048       134215679   63.0 GiB    8E00
      14            2048           10239   4.0 MiB     EF02
      15           10240         1024000   495.0 MiB   EF00  EFI System Partition
    
    Command (? for help): w
    
    Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
    PARTITIONS!!
    
    Do you want to proceed? (Y/N): Y
    OK; writing new GUID partition table (GPT) to /dev/sdc.
    Warning: The kernel is still using the old partition table.
    The new table will be used at the next reboot or after you
    run partprobe(8) or kpartx(8)
    The operation has completed successfully.
    ```

2. Validate if the /boot file system is detected by the system by using the following command:

    ```bash
    # blkid /dev/sdX1
    ```

    You should be able to see an entry for `/dev/sdX1` (the missing /boot partition).

    ```output
    # blkid /dev/sdc1
    /dev/sdc1: UUID="<UUID>" BLOCK_SIZE="4096" TYPE="xfs" PARTLABEL="Linux filesystem" PARTUUID="<PARTUUID>"
    ```

3. If the /boot file system isn't visible after recreating the partition, it means the /boot data is no longer there. You'll need to recreate the /boot file system (by using the same UUID than in the */etc/fstab* /boot entry) and [restore its contents from backup](/azure/backup/backup-azure-arm-restore-vms).

## <a id="other-grub-rescue-errors"></a>Other GRUB rescue errors

The following screenshot shows the error message:

:::image type="content" source="./media/troubleshoot-vm-boot-error/grub-rescue.png" alt-text="Screenshot of another grub rescue issue.":::

This kind of error will be triggered in one of the following scenarios:

* The GRUB configuration file is missing.
* The wrong GRUB configuration is in place.
* The /boot partition or its contents are missing.

To resolve this error, follow these steps:

1. Make sure that a rescue/repair VM has been created. If not, follow the step 1 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to create it. Mount all the required file systems, including / and /boot, and then do [chroot](chroot-environment-linux.md).

2. Make sure the */etc/default/grub* configuration file is configured. The [endorsed Azure Linux images](/azure/virtual-machines/linux/endorsed-distros) already have the required configurations in place. For more information, see the following articles:

    * [GRUB access in RHEL](serial-console-grub-single-user-mode.md#grub-access-in-rhel)
    * [GRUB access in CentOS](serial-console-grub-single-user-mode.md#grub-access-in-centos)
    * [GRUB access in Ubuntu](serial-console-grub-single-user-mode.md#grub-access-in-ubuntu)
    * [GRUB access in SUSE SLES](serial-console-grub-single-user-mode.md#grub-access-in-suse-sles)
    * [GRUB access in Oracle Linux](serial-console-grub-single-user-mode.md#grub-access-in-oracle-linux)

3. [Reinstall GRUB and regenerate GRUB configuration file](#reinstall-grub-regenerate-grub-configuration-file).

    > [!NOTE]
    > If the missing file is */boot/grub/menu.lst*, this error is for older OS versions (RHEL 6.x, Centos 6.x and Ubuntu 14.04). The commands will differ because GRUB version 1 is used in those systems instead. GRUB version 1 isn't covered in this article.

4. If the entire /boot partition is missing, follow the steps in [Error: no such partition](#no-such-partition).

5. Once the issue is resolved, proceed with step 3 in [Troubleshoot GRUB rescue issue offline](#offline-troubleshooting) to swap the OS disk.

## Next steps

If the specific boot error isn't a GRUB rescue issue, refer to [Troubleshoot Azure Linux Virtual Machines boot errors](boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
