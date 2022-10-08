---
title: Chroot environment in a Linux Rescue VM.
description: This article describes how to troubleshoot the chroot environment in the Rescue virtual machine (VM) in Linux.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.subservice: vm-backup-restore
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 05/17/2022
ms.author: genli

---

# Chroot environment in a Linux Rescue VM

This article describes how to troubleshoot the chroot environment in the Rescue virtual machine (VM) in Linux.

## Ubuntu 16.x && Ubuntu 18.x && Ubuntu 20.04

1. Stop or de-allocate the affected VM.
1. Create a rescue VM of the same generation, same OS version, in same resource group and location using managed disk.
1. Use the Azure portal to take a snapshot of the affected virtual machine's OS disk.
1. Create a disk out of the snapshot of the OS disk, and attach it to the Rescue VM.
1. Once the disk has been created, Troubleshoot the chroot environment in the Rescue VM.

   1. Access your VM as the root user using the following command:

      `sudo su -`

   1. Find the disk using `dmesg` (the method you use to discover your new disk may vary). The following example uses **dmesg** to filter on **SCSI** disks:

      `dmesg | grep SCSI`

      Your output will be similar to the following example. In this example, we want the **sdc** disk:

      ```console
      [    0.294784] SCSI subsystem initialized
      [    0.573458] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
      [    7.110271] sd 2:0:0:0: [sda] Attached SCSI disk
      [    8.079653] sd 3:0:1:0: [sdb] Attached SCSI disk
      [ 1828.162306] sd 5:0:0:0: [sdc] Attached SCSI disk
      ```

   1. Use the following commands to access the chroot environment:

      ```console
      mkdir /rescue
      mount /dev/sdc1 /rescue
      mount /dev/sdc15 /rescue/boot/efi
      
      mount -t proc /proc /rescue/proc
      mount -t sysfs /sys /rescue/sys
      mount -o bind /dev /rescue/dev
      mount -o bind /dev/pts /rescue/dev/pts
      mount -o bind /run /rescue/run
      chroot /rescue
      ```

   1. Troubleshoot the chroot environment.

   1. Use the following commands to exit the chroot environment:

      ```console
      exit

      umount /rescue/proc/
      umount /rescue/sys/
      umount /rescue/dev/pts
      umount /rescue/dev/
      umount /rescue/run
      cd /
      umount /rescue/boot/efi
      umount /rescue
      ```

      > [!NOTE]
      > If you receive the error `unable to unmount /rescue`, add -l option to the umount command.
      >
      > Example: `umount -l /rescue`

1. Detach the disk from the rescue VM and perform a disk swap with the original VM.
1. Start the original VM and check its connectivity.

## RHEL/Centos/Oracle 6.x && Oracle 8.x && RHEL/Centos 7.x with RAW Partitions

1. Stop or de-allocate the affected VM.
1. Create a Rescue VM image of the same OS version, in same resource group (RSG) and location using managed disk.
1. Use the Azure portal to take a snapshot of the affected virtual machine's OS disk.
1. Create a disk out of the snapshot of the OS disk, and attach it to the Rescue VM.
1. Once the disk has been created, Troubleshoot the chroot environment in the Rescue VM.

   1. Access your VM as the root user using the following command:

      `sudo su -`

   1. Find the disk using `dmesg` (the method you use to discover your new disk may vary). The following example uses **dmesg** to filter on **SCSI** disks:

      `dmesg | grep SCSI`

      Your output will be similar to the following example. In this example, we want the **sdc** disk:

      ```console
      [    0.294784] SCSI subsystem initialized
      [    0.573458] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
      [    7.110271] sd 2:0:0:0: [sda] Attached SCSI disk
      [    8.079653] sd 3:0:1:0: [sdb] Attached SCSI disk
      [ 1828.162306] sd 5:0:0:0: [sdc] Attached SCSI disk
      ```

   1. Use the following commands to access the chroot environment:

      ```console
      mkdir /rescue
      mount -o nouuid /dev/sdc2 /rescue
      mount -o nouuid /dev/sdc1 /rescue/boot/
      
      mount -t proc /proc /rescue/proc
      mount -t sysfs /sys /rescue/sys
      mount -o bind /dev /rescue/dev
      mount -o bind /dev/pts /rescue/dev/pts
      mount -o bind /run /rescue/run
      chroot /rescue
      ```

   1. Troubleshoot the chroot environment.

   1. Use the following commands to exit the chroot environment:

      ```console
      exit

      umount /rescue/proc/
      umount /rescue/sys/
      umount /rescue/dev/pts
      umount /rescue/dev/
      umount /rescue/run
      cd /
      umount /rescue/boot/
      umount /rescue
      ```

      > [!NOTE]
      > If you receive the error `unable to unmount /rescue`, add -l option to the umount command.
      >
      > Example: `umount -l /rescue`

1. Detach the disk from the rescue VM and perform a disk swap with the original VM.
1. Start the original VM and check its connectivity.

## RHEL/Centos 7.x & 8.X with LVM

   > [!NOTE]
   > If your original VM includes Logical Volume Manager (LVM) on the OS Disk, create the Rescue VM using the image with Raw Partitions on the OS Disk

1. Stop or de-allocate the affected VM.
1. Create a Rescue VM image of the same OS version, in same resource group (RSG) and location using managed disk.
1. Use the Azure portal to take a snapshot of the affected virtual machine's OS disk.
1. Create a disk out of the snapshot of the OS disk, and attach it to the Rescue VM.
1. Once the disk has been created, Troubleshoot the chroot environment in the Rescue VM.

   1. Access your VM as the root user using the following command:

      `sudo su -`

   1. Find the disk using `dmesg` (the method you use to discover your new disk may vary). The following example uses **dmesg** to filter on **SCSI** disks:

      `dmesg | grep SCSI`

      Your output will be similar to the following example. In this example, we want the **sdc** disk:

      ```console
      [    0.294784] SCSI subsystem initialized
      [    0.573458] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
      [    7.110271] sd 2:0:0:0: [sda] Attached SCSI disk
      [    8.079653] sd 3:0:1:0: [sdb] Attached SCSI disk
      [ 1828.162306] sd 5:0:0:0: [sdc] Attached SCSI disk
      ```

   1. Use the following command to activate the logical volume group:

      ```console
      vgscan --mknodes
      vgchange -ay
      lvscan
      ```

   1. Use the `lsblk` command to retrieve the lvm names:

      ```console
      [user@myvm ~]$ lsblk
      NAME              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
      sda                 8:0    0   64G  0 disk
      ├─sda1              8:1    0  500M  0 part /boot
      ├─sda2              8:2    0   63G  0 part /
      sdb                 8:16   0    4G  0 disk
      └─sdb1              8:17   0    4G  0 part /mnt/resource
      sdc                 8:0    0   64G  0 disk
      ├─sdc1              8:1    0  500M  0 part
      ├─sdc2              8:2    0   63G  0 part
      ├─sdc3              8:3    0    2M  0 part
      ├─sdc4              8:4    0   63G  0 part
        ├─rootvg-tmplv  253:0    0    2G  0 lvm  
        ├─rootvg-usrlv  253:1    0   10G  0 lvm  
        ├─rootvg-optlv  253:2    0    2G  0 lvm  
        ├─rootvg-homelv 253:3    0    1G  0 lvm  
        ├─rootvg-varlv  253:4    0    8G  0 lvm  
        └─rootvg-rootlv 253:5    0    2G  0 lvm
      ```

   1. Use the following commands to access the chroot environment:

      ```console
      mkdir /rescue
      mount /dev/mapper/rootvg-rootlv /rescue
      mount /dev/mapper/rootvg-varlv /rescue/var
      mount /dev/mapper/rootvg-homelv /rescue/home
      mount /dev/mapper/rootvg-usrlv /rescue/usr
      mount /dev/mapper/rootvg-tmplv /rescue/tmp
      mount /dev/mapper/rootvg-optlv /rescue/opt
      mount /dev/sdc2 /rescue/boot/
      mount /dev/sdc1 /rescue/boot/efi

      mount -t proc /proc /rescue/proc
      mount -t sysfs /sys /rescue/sys
      mount -o bind /dev /rescue/dev
      mount -o bind /dev/pts /rescue/dev/pts
      mount -o bind /run /rescue/run
      chroot /rescue
      ```

   1. Troubleshoot the chroot environment.

   1. Use the following commands to exit the chroot environment:

      ```console
      exit

      umount /rescue/proc/
      umount /rescue/sys/
      umount /rescue/dev/pts
      umount /rescue/dev/
      umount /rescue/run
      cd /
      umount /rescue/boot/efi
      umount /rescue/boot
      umount /rescue/home
      umount /rescue/var
      umount /rescue/usr
      umount /rescue/tmp
      umount /rescue/opt
      umount /rescue
      ```

      > [!NOTE]
      > If you receive the error `unable to unmount /rescue`, add -l option to the umount command.
      >
      > Example: `umount -l /rescue`

1. Detach the disk from the rescue VM and perform a disk swap with the original VM.
1. Start the original VM and check its connectivity.

### Using the same LVM image

> [!NOTE]
> It is possible that you need to deploy the rescue VM using the same lvm image, if that's the case you would need to get around that by modifying some aspects of the rescue VM LVM.

1. Check the status of the disks prior attaching the disk you want to rescue

   ```console
   # lsblk -f
   NAME              FSTYPE      LABEL UUID                                   MOUNTPOINT
   sda
   ├─sda1            vfat              93DA-8C20                              /boot/efi
   ├─sda2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
   ├─sda3
   └─sda4            LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
   ├─rootvg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
   ├─rootvg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
   ├─rootvg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
   ├─rootvg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
   ├─rootvg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
   └─rootvg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
   sdb
   └─sdb1            ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8   /mnt
   ```

2. Attach the disk you want to rescue as a data drive
3. Check the disks again. Note that it will not show you the lvm structures right away.

   ```console
   # lsblk -f
   NAME              FSTYPE      LABEL UUID                                   MOUNTPOINT
   sda
   ├─sda1            vfat              93DA-8C20                              /boot/efi
   ├─sda2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
   ├─sda3
   └─sda4            LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
   ├─rootvg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
   ├─rootvg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
   ├─rootvg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
   ├─rootvg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
   ├─rootvg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
   └─rootvg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
   sdb
   └─sdb1            ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8   /mnt
   sdc
   ├─sdc1            vfat              93DA-8C20
   ├─sdc2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d
   ├─sdc3
   └─sdc4            LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU

   ```

4. lvm commands will complain about duplicated PV

   ```console
   # pvs
   WARNING: Not using lvmetad because duplicate PVs were found.
   WARNING: Use multipath or vgimportclone to resolve duplicate PVs?
   WARNING: After duplicates are resolved, run "pvscan --cache" to enable lvmetad.
   WARNING: Not using device /dev/sdc4 for PV pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU.
   WARNING: PV pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU prefers device /dev/sda4 because device is used by LV.
   PV         VG     Fmt  Attr PSize   PFree
   /dev/sda4  rootvg lvm2 a--  <63.02g <38.02g
   ```

5. Use the vmimportclone command to import the rootvg from the data drive using another name.

   This will also change the UUID of the PV and will activate it.

   ```console
   # vgimportclone -n rescuemevg /dev/sdc4
   WARNING: Not using device /dev/sdc4 for PV pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU.
   WARNING: PV pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU prefers device /dev/sda4 because device is used by LV.

   # vgchange -a y rescuemevg 
   6 logical volume(s) in volume group "rescuemevg" now active
   ```

6. Verify the name change

   ```console
   # lsblk -f
   NAME                  FSTYPE      LABEL UUID                                   MOUNTPOINT
   sda
   ├─sda1                vfat              93DA-8C20                              /boot/efi
   ├─sda2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
   ├─sda3
   └─sda4                LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
   ├─rootvg-tmplv      xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
   ├─rootvg-usrlv      xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
   ├─rootvg-optlv      xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
   ├─rootvg-homelv     xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
   ├─rootvg-varlv      xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
   └─rootvg-rootlv     xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
   sdb
   └─sdb1                ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8   /mnt
   sdc
   ├─sdc1                vfat              93DA-8C20
   ├─sdc2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d
   ├─sdc3
   └─sdc4                LVM2_member       BbZsAT-5oOK-nITn-bHFW-IVyS-y0O3-93oDes
   ├─rescuemevg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207
   ├─rescuemevg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d
   ├─rescuemevg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3
   ├─rescuemevg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0
   ├─rescuemevg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86
   └─rescuemevg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809
   ```

7. Rename the rootvg of the rescue VM

   ```console
   # vgrename rootvg oldvg
   Volume group "rootvg" successfully renamed to "oldvg"
   ```

8. Check the disks

   ```console
   # lsblk -f
   NAME                  FSTYPE      LABEL UUID                                   MOUNTPOINT
   sda
   ├─sda1                vfat              93DA-8C20                              /boot/efi
   ├─sda2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
   ├─sda3
   └─sda4                LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
   ├─oldvg-tmplv       xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
   ├─oldvg-usrlv       xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
   ├─oldvg-optlv       xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
   ├─oldvg-homelv      xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
   ├─oldvg-varlv       xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
   └─oldvg-rootlv      xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
   sdb
   └─sdb1                ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8   /mnt
   sdc
   ├─sdc1                vfat              93DA-8C20
   ├─sdc2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d
   ├─sdc3
   └─sdc4                LVM2_member       BbZsAT-5oOK-nITn-bHFW-IVyS-y0O3-93oDes
   ├─rescuemevg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207
   ├─rescuemevg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d
   ├─rescuemevg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3
   ├─rescuemevg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0
   ├─rescuemevg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86
   └─rescuemevg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809
   ```

9. Mount the FS coming from the data drive.

   When using xfs use the -o nouuid option to avoid conflicts with the UUIDs and mount the needed filesystems to perform a chroot:

   ```console
   mkdir /rescue
   mount -o nouuid /dev/mapper/rescuemevg-rootlv /rescue
   mount -o nouuid  /dev/mapper/rescuemevg-homelv /rescue/home
   mount -o nouuid  /dev/mapper/rescuemevg-optlv /rescue/opt 
   mount -o nouuid  /dev/mapper/rescuemevg-tmplv /rescue/tmp 
   mount -o nouuid  /dev/mapper/rescuemevg-usrlv /rescue/usr 
   mount -o nouuid  /dev/mapper/rescuemevg-varlv /rescue/var 
   mount -o nouuid  /dev/sdc2 /rescue/boot
   mount /dev/sdc1 /rescue/boot/efi
   
   mount -t proc /proc /rescue/proc 
   mount -t sysfs /sys /rescue/sys
   mount -o bind /dev /rescue/dev 
   mount -o bind /dev/pts /rescue/dev/pts
   mount -o bind /run /rescue/run
   ```

10. Verify the mounts

    ```console
    # lsblk -f
    NAME                  FSTYPE      LABEL UUID                                   MOUNTPOINT
    sda
    ├─sda1                vfat              93DA-8C20                              /boot/efi
    ├─sda2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
    ├─sda3
    └─sda4                LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
    ├─oldvg-tmplv       xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
    ├─oldvg-usrlv       xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
    ├─oldvg-optlv       xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
    ├─oldvg-homelv      xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
    ├─oldvg-varlv       xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
    └─oldvg-rootlv      xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
    sdb
    └─sdb1                ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8   /mnt
    sdc
    ├─sdc1                vfat              93DA-8C20                              /rescue/boot/efi
    ├─sdc2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /rescue/boot
    ├─sdc3
    └─sdc4                LVM2_member       BbZsAT-5oOK-nITn-bHFW-IVyS-y0O3-93oDes
    ├─rescuemevg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /rescue/tmp
    ├─rescuemevg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /rescue/usr
    ├─rescuemevg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /rescue/opt
    ├─rescuemevg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /rescue/home
    ├─rescuemevg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /rescue/var
    └─rescuemevg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /rescue
    ```

11. Use chroot

    ```console
    chroot /rescue/
    ```

12. Verify tge mounts "inside" the chroot environment.

    Notice that now rescuemevg-rootlv is the one mounted on /

      ```console
      # lsblk -f
      NAME                  FSTYPE      LABEL UUID                                   MOUNTPOINT
      sda
      ├─sda1                vfat              93DA-8C20
      ├─sda2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d
      ├─sda3
      └─sda4                LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
      ├─oldvg-tmplv       xfs               9098eb05-0176-4997-8132-9152a7bef207
      ├─oldvg-usrlv       xfs               2f9ff36c-742d-4914-b463-d4152801b95d
      ├─oldvg-optlv       xfs               aeacea8e-3663-4569-af25-c52357f8a0a3
      ├─oldvg-homelv      xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0
      ├─oldvg-varlv       xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86
      └─oldvg-rootlv      xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809
      sdb
      └─sdb1                ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8
      sdc
      ├─sdc1                vfat              93DA-8C20                              /boot/efi
      ├─sdc2                xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
      ├─sdc3
      └─sdc4                LVM2_member       BbZsAT-5oOK-nITn-bHFW-IVyS-y0O3-93oDes
      ├─rescuemevg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
      ├─rescuemevg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
      ├─rescuemevg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
      ├─rescuemevg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
      ├─rescuemevg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
      └─rescuemevg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
      ```

13. Rename the VG to keep it consistent.

    Renaming the vg will keep you from facing issues when regenerating initrd and booting the disk again on the original VM

    ```console
    # vgrename rescuemevg rootvg
    Volume group "rescuemevg" successfully renamed to "rootvg"
    ```

14. Verify the change

      ```console
      # lsblk -f
      NAME              FSTYPE      LABEL UUID                                   MOUNTPOINT
      sda
      ├─sda1            vfat              93DA-8C20
      ├─sda2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d
      ├─sda3
      └─sda4            LVM2_member       pdSI2Q-ZEzV-oT6P-R2JG-ZW3h-cmnf-iRN6pU
      ├─oldvg-tmplv   xfs               9098eb05-0176-4997-8132-9152a7bef207
      ├─oldvg-usrlv   xfs               2f9ff36c-742d-4914-b463-d4152801b95d
      ├─oldvg-optlv   xfs               aeacea8e-3663-4569-af25-c52357f8a0a3
      ├─oldvg-homelv  xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0
      ├─oldvg-varlv   xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86
      └─oldvg-rootlv  xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809
      sdb
      └─sdb1            ext4              e72e7c2c-db27-4a73-a97e-01d63d21ccf8
      sdc
      ├─sdc1            vfat              93DA-8C20                              /boot/efi
      ├─sdc2            xfs               d5da486e-fdfe-4ad8-bc01-aa72b91fd47d   /boot
      ├─sdc3
      └─sdc4            LVM2_member       BbZsAT-5oOK-nITn-bHFW-IVyS-y0O3-93oDes
      ├─rootvg-tmplv  xfs               9098eb05-0176-4997-8132-9152a7bef207   /tmp
      ├─rootvg-usrlv  xfs               2f9ff36c-742d-4914-b463-d4152801b95d   /usr
      ├─rootvg-optlv  xfs               aeacea8e-3663-4569-af25-c52357f8a0a3   /opt
      ├─rootvg-homelv xfs               a79e43dc-7adc-41b4-b6e1-4e6b033b15c0   /home
      ├─rootvg-varlv  xfs               c7cb68e9-7865-4187-b3bd-e9a869779d86   /var
      └─rootvg-rootlv xfs               d8dc4d62-ada5-4952-a0d9-1bce6cb6f809   /
      ```

15. Proceed with the required activities to rescue the OS, this may include regenerating initramfs or the grub configuration
16. Exit the chroot environment

      ```console
      exit
      ```

17. Unmount and detach the data disk from the rescue VM and perform a disk swap with the original VM

      ```console
      umount /rescue/run/
      umount /rescue/dev/pts/
      umount /rescue/dev/ 
      umount /rescue/sys/
      umount /rescue/proc
      umount /rescue/boot/efi
      umount /rescue/boot
      umount /rescue/var
      umount /rescue/usr
      umount /rescue/tmp
      umount /rescue/opt
      umount /rescue/home
      umount /rescue
      ```

18. Start the original VM and verify its functionality

## Oracle 7.x

1. Stop or de-allocate the affected VM.
1. Create a Rescue VM image of the same OS version, in same resource group (RSG) and location using managed disk.
1. Use the Azure portal to take a snapshot of the affected virtual machine's OS disk.
1. Create a disk out of the snapshot of the OS disk, and attach it to the Rescue VM.
1. Once the disk has been created, Troubleshoot the chroot environment in the Rescue VM.

   1. Access your VM as the root user using the following command:

      `sudo su -`

   1. Find the disk using `dmesg` (the method you use to discover your new disk may vary). The following example uses **dmesg** to filter on **SCSI** disks:

      `dmesg | grep SCSI`

      Your output will be similar to the following example. In this example, we want the **sdc** disk:

      ```console
      [    0.294784] SCSI subsystem initialized
      [    0.573458] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
      [    7.110271] sd 2:0:0:0: [sda] Attached SCSI disk
      [    8.079653] sd 3:0:1:0: [sdb] Attached SCSI disk
      [ 1828.162306] sd 5:0:0:0: [sdc] Attached SCSI disk
      ```

   1. Use the following commands to access the chroot environment:

      ```console
      mkdir /rescue
      mount -o nouuid /dev/sdc2 /rescue
      mount -o nouuid /dev/sdc1 /rescue/boot/
      mount /dev/sdc15 /rescue/boot/efi

      mount -t proc /proc /rescue/proc
      mount -t sysfs /sys /rescue/sys
      mount -o bind /dev /rescue/dev
      mount -o bind /dev/pts /rescue/dev/pts
      mount -o bind /run /rescue/run
      chroot /rescue
      ```

   1. Troubleshoot the chroot environment.

   1. Use the following commands to exit the chroot environment:

      ```console
      exit

      umount /rescue/proc/
      umount /rescue/sys/
      umount /rescue/dev/pts
      umount /rescue/dev/
      umount /rescue/run
      umount /rescue/boot/efi
      umount /rescue/boot
      umount /rescue
      ```

      > [!NOTE]
      > If you receive the error `unable to unmount /rescue`, add -l option to the umount command.
      >
      > Example: `umount -l /rescue`

1. Detach the disk from the rescue VM and perform a disk swap with the original VM.
1. Start the original VM and check its connectivity.

## SUSE-SLES 12 SP4, SUSE-SLES 12 SP4 For SAP && ## SUSE-SLES 15 SP1, SUSE-SLES 15 SP1 For SAP

1. Stop or de-allocate the affected VM.
1. Create a Rescue VM image of the same OS version, in same resource group (RSG) and location using managed disk.
1. Use the Azure portal to take a snapshot of the affected virtual machine's OS disk.
1. Create a disk out of the snapshot of the OS disk, and attach it to the Rescue VM.
1. Once the disk has been created, Troubleshoot the chroot environment in the Rescue VM.

   1. Access your VM as the root user using the following command:

      `sudo su -`

   1. Find the disk using `dmesg` (the method you use to discover your new disk may vary). The following example uses **dmesg** to filter on **SCSI** disks:

      `dmesg | grep SCSI`

      Your output will be similar to the following example. In this example, we want the **sdc** disk:

      ```console
      [    0.294784] SCSI subsystem initialized
      [    0.573458] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
      [    7.110271] sd 2:0:0:0: [sda] Attached SCSI disk
      [    8.079653] sd 3:0:1:0: [sdb] Attached SCSI disk
      [ 1828.162306] sd 5:0:0:0: [sdc] Attached SCSI disk
      ```

   1. Use the following commands to access the chroot environment:

      ```console
      mkdir /rescue
      mount -o nouuid /dev/sdc4 /rescue
      mount -o nouuid /dev/sdc3 /rescue/boot/
      mount /dev/sdc2 /rescue/boot/efi

      mount -t proc /proc /rescue/proc
      mount -t sysfs /sys /rescue/sys
      mount -o bind /dev /rescue/dev
      mount -o bind /dev/pts /rescue/dev/pts
      mount -o bind /run /rescue/run
      chroot /rescue
      ```

   1. Troubleshoot the chroot environment.

   1. Use the following commands to exit the chroot environment:

      ```console
      exit

      umount /rescue/proc/
      umount /rescue/sys/
      umount /rescue/dev/pts
      umount /rescue/dev/
      umount /rescue/run
      umount /rescue/boot/efi
      umount /rescue/boot
      umount /rescue
      ```

      > [!NOTE]
      > If you receive the error `unable to unmount /rescue`, add -l option to the umount command.
      >
      > Example: `umount -l /rescue`

1. Detach the disk from the rescue VM and perform a disk swap with the original VM.
1. Start the original VM and check its connectivity.

## Next Steps

- [Troubleshoot ssh connection](troubleshoot-ssh-connection.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
