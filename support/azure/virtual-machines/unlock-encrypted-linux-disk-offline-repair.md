---
title: Unlocking an encrypted Linux disk for offline repair 
description: Describes how to repair a Linux VM that has an encrypted OS disk.
services: virtual-machines
ms.collection: linux
ms.service: virtual-machines
author: genlin
manager: dcscontentpm
editor: v-jesits
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure
ms.date: 08/24/2021
ms.author: genli
---
# Unlocking an encrypted Linux disk for offline repair

This article provides two methods to unlock an Azure Disk Encryption (ADE)-enabled OS disk for offline repair. These methods apply to only managed disks that use [single-pass encryption](/azure/virtual-machines/linux/how-to-verify-encryption-status).

## Method 1: Unlock an encrypted disk automatically (Recommended)

This method relies on [az vm repair](/cli/azure/vm/repair?view=azure-cli-latest&preserve-view=true) commands to automatically create a repair VM, attach the OS disk of the failed Linux VM  to that repair VM, and then unlock the disk if it is encrypted. This method requires using a public IP address for the repair VM, and it unlocks the encrypted disk regardless of whether the ADE key is unwrapped or wrapped by using a key encryption key (KEK).  

To repair the VM by using this automated method, follow the steps in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

If your infrastructure and company policy don't allow you to assign a public IP address, or if the `az vm repair` command doesn't unlock the disk, go to the next method.

## Method 2: Unlock an encrypted disk manually

To unlock and mount the encrypted disk manually, follow these steps:

1. [Create a new repair VM, and attach the encrypted disk to this VM during VM creation](#create-a-repair-vm).
   
   You must attach the encrypted disk the during the VM creation create the VM. This is because if you attach the encrypted disk at the time that you create the repair VM, the system detects that the attached disk is encrypted. Therefore, it fetches the ADE key from your Azure key vault, and then creates a new volume that's named "BEK VOLUME" to store the key file.

2. [Log in to the repair VM, then unmount any mounted partitions on the encrypted disk](#unmount-any-mounted-partitions-on-the-encrypted-disk).
3. [Identify the ADE key file in the BEK volume](#unmount-any-mounted-partitions-on-the-encrypted-disk).
4. [Identify the header file in the boot partition of the encrypted OS](#identify-the-header-file).
4. [Unlock the encrypted disk by using the ADE key file and the header file](#unlock-by-files).
5. Mount the partition: [LVM](#lvm), [RAW or non-LVM](#non-lvm).

### Create a Repair VM

1. [Take a snapshot of the encrypted OS disk](troubleshoot-recovery-disks-portal-linux.md#take-a-snapshot-of-the-os-disk).
1. [Create a disk from the snapshot](troubleshoot-recovery-disks-portal-linux.md#create-a-disk-from-the-snapshot). For the new disk, choose the same location and availability zone as that of the problem VM that you want to repair. 
1. Create a VM that's based on the following guidelines:
   - In the Azure Marketplace, choose the same image for the repair VM that was used for the failed VM. (The OS version should be the same.)
   - Choose a size that allocates at least 8 GB of memory to the VM.  
   - Assign this new VM to the same resource group, region, and availability settings that you used for the new disk that you created in step 2.

1. On the **Disks** page of the **Create a Virtual Machine** wizard, attach the new disk (that you just created from the snapshot) as a data disk. 

> [!IMPORTANT]
> Make sure that you add the new disk during the VM creation. Only, in this case, the encryption settings are detected. This enables a volume that contains the ADE key file to be added to the VM automatically.

### Unmount any mounted partitions on the encrypted disk

1. After the repair VM is created, SSH to your repair VM, log in by using the appropriate credentials，and then elevate the account to root:

   ```bash
   sudo -s 
   ```
2. List the attached devices by using the **lsblk** command. In the output, you should see multiple attached disks. These disks include the active OS disk and the encrypted disk. They can appear in any order.

3. Identify the encrypted disk by using the following information:

   - The disk will have multiple partitions
   - The disk will not list the root directory ("/") as a mountpoint for any of its partitions.
   - The disk will match the size that you noted when you created it from the snapshot.

   In the following example, the output indicates that "sdd" is the encrypted disk. It's the only disk that has multiple partitions that does not list "/" as a mountpoint.

   ![The image about the first example](media/unlock-encrypted-linux-disk-offline-repair/dev-sample-1.png)

4. Unmount any partitions on the encrypted data disk that have been mounted in the file system. For example, in the previous example, you would have to unmount both "/boot/efi"* and "/boot".

   ```bash
   umount /boot/efi 

   umount /boot 
   ```

### Identify the ADE key file

You need the key file and the header file to unlock the encrypted disk. The key file is stored in the BEK volume, and the header file is in the boot partition of the encrypted OS disk.

1. Determine which partition is the BEK volume.  

   ```bash
   lsblk -fs | grep -i bek 
   ```
   The following example output indicates that sdb1 is the BEK volume: 

   ```output
   >sdb1  vfat   BEK VOLUME      04A2-FE67 
   ```

   If no BEK volume is present, re-create the repair VM by having the encrypted disk attached. If the BEK volume still does not attach automatically, [re-enable the ADE on the disk](#re-encrypt) to retrieve the BEK volume.
1. Create a directory that's named "azure_bek_disk" under the "/mnt" folder:

   ```bash
   mkdir /mnt/azure_bek_disk 
   ```
1. Mount the BEK volume in the "/mnt/azure_bek_disk" directory. For example, if sdb1 is the BEK volume, you would type the following command: 
   ```bash
   mount /dev/sdb1 /mnt/azure_bek_disk 
   ```
1. List the available devices again. You will see that the partition you determined to be the BEK volume is now mounted in "/mnt/azure_bek_disk".

1. View the contents in the "/mnt/azure_bek_disk/" directory.
   ```bash
   ls -l /mnt/azure_bek_disk
   ```
   You see the following files in the output. The ADE key file is "LinuxPassPhraseFileName".

   ```output
   >total 1 

    -rwxr-xr-x 1 root root 148 Aug  4 01:04 CRITICAL_DATA_WARNING_README.txt 
    -r-xr-xr-x 1 root root 172 Aug  4 01:04 LinuxPassPhraseFileName
    ```
  
### Identify the header file

The boot partition of the encrypted disk contains the header file. You use this file, together with the "LinuxPassPhraseFileName"  key file, to unlock the encrypted disk.

1. Use the command `lsblk -o NAME,SIZE,LABEL,PARTLABEL,MOUNTPOINT` to show selected attributes of the available disks and partitions.

   ```output
   NAME     SIZE LABEL           PARTLABEL            MOUNTPOINT 

   sda       64G 
   ├─sda1   500M                 EFI System Partition 
   ├─sda2   500M 
   ├─sda3     2M 
   └─sda4    63G 

   sdb       48M 
   └─sdb1    46M BEK VOLUME                           /mnt/azure_bek_disk 

   sdc       30G 
   ├─sdc1  29.9G cloudimg-rootfs                      / 
   ├─sdc14    4M 
   └─sdc15  106M UEFI                                 /boot/efi 

   sdd       16G 
   └─sdd1    16G                                      /mnt 

   sr0      628K 
   ```
1. On the encrypted disk, identify the OS partition (root partition). This is the largest partition on the encrypted disk. In the previous example output, the OS partition is "sda4." This partition must be specified when you run the unlock command.
3. In the root directory ("/") of the file structure, create a directory to which to mount the root partition of the encrypted disk. You will use this directory later, after the disk is unlocked. To distinguish it from the active OS partition of the repair VM, give it the name "investigateroot".

   ```bash
   mkdir /{investigateboot,investigateroot}
   ```
1. On the encrypted disk, identify the boot partition, which contains the header file. On the encrypted disk, the boot partition is the second largest partition that shows no value in the LABEL or PARTLABEL column. In the previous example output, the boot partition of the encrypted disk is "sda2." In the following example output, the boot partition of the encrypted disk is "sdc2"

1. Mount the boot partition that you identified in step 4 into the /investigateboot/ directory. In the following example, the boot partition of the encrypted disk is sda2. However, the location on your system might differ.

   ```bash
   mount /dev/sda2 /investigateboot/ 
   ```
   If mounting the partition fails and returns a "wrong fs type, bad option, bad superblock" error message, try again by using the `mount -o nouuid` command, as in the following example:

   ```bash
   mount -o nouuid /dev/sda2 /investigateboot/ 
   ```
1. List the files that are in the /investigateboot/ directory. The "luks" subdirectory contains the header file that you must have to unlock the disk.

1. List the files that are in the /investigateboot/luks/ directory. The header file is named "osluksheader."

   ```bash
   ls -l /investigateboot/luks 
   ```

### <a name="unlock-by-files"></a> Use the ADE key file and the header file to unlock the disk

1. Use the following command to unlock the root partition on the encrypted disk:

   ```bash
   cryptsetup luksOpen --key-file /mnt/azure_bek_disk/LinuxPassPhraseFileName --header /investigateboot/luks/osluksheader <path to root partition> <new name>
   ```
   For example, if the path to the root partition containing the encrypted OS is /dev/sda4, and you want to assign the unlocked partition the name "osencrypt," you would enter the following command:  

   ```bash
   cryptsetup luksOpen --key-file /mnt/azure_bek_disk/LinuxPassPhraseFileName --header /investigateboot/luks/osluksheader /dev/sda4 osencrypt 
   ```
1. Now that you have unlocked the disk, unmount the encrypted disk’s boot partition from the /investigateboot/ directory. You will need to mount this partition to another directory later.

      ```bash
      umount /investigateboot/ 
      ```
      The next step is to mount the partition you have just unlocked. The method you use to mount the partition depends on the device mapper framework (LVM or non-LVM) that used by the disk.

1. List the device information with the file system type.
      ```bash
      lsblk -o NAME,FSTYPE 
      ```
   You will see the unlocked partition with the name you assigned it. In our example, that name is "osencrypt".
 
   - For the LVM partition such as "LVM_member", see [Mount the LVM partition](#lvm)[RAW or non-LVM](#non-lvm).
   - For the non-LVM partition, see [Mount the non-LVM partition](#non-lvm).

### <a name="lvm"></a> Mount the unlocked partition and enter the chroot environment (LVM only) 
If the disks use the LVM device mapper framework, you need to take extra steps to mount the disk and enter the chroot environment. To use the chroot utility with the encrypted disk, the unlocked partition ("osencrypt") and its logical volumes must be recognized as the volume group named rootvg. However, by default, the repair VM’s OS partition and its logical volumes are already assigned to a volume group with the name rootvg. We first need to resolve this conflict.

1. Use the `pvs` command to display the properties of the LVM physical volumes. You might see warning messages, as in the following example, that indicate that the unlocked partition ("/dev/mapper/osencrypt") and another device are using duplicate universally unique identifiers (UUIDs). Alternatively, you might see two partitions assigned to rootvg.

   ```output
   WARNING: Not using lvmetad because duplicate PVs were found. 

   WARNING: Use multipath or vgimportclone to resolve duplicate PVs? 

   WARNING: After duplicates are resolved, run "pvscan --cache" to enable lvmetad. 

   WARNING: PV Nv0rQb-DqIR-t7if-UghJ-Vz97-u48A-C3FCnb on /dev/mapper/osencrypt was already found on /dev/sda4. 

   WARNING: PV Nv0rQb-DqIR-t7if-UghJ-Vz97-u48A-C3FCnb prefers device /dev/sda4 because device is used by LV. 

   PV         VG     Fmt  Attr PSize   PFree 

   /dev/sda4  rootvg lvm2 a--  <63.02g <38.02g 
   ```
   You want only the unlocked partition ("osencrypt") to be assigned to the rootvg volume group so that you can access its logical volumes through the chroot utility. To fix this problem, you will temporarily import the partition into a different volume group and activate that volume group. Next, you will rename the current rootvg volume group. Only later, after you enter the chroot environment, will you rename the encrypted disk’s volume group as rootvg. 

1. Import the newly unlocked partition into a new volume group. In this example, we are temporarily naming the new volume group "rescuemevg".
Import the newly unlocked partition into a new volume group. In this example, we are temporarily naming the new volume group "rescuemevg".

1. Activate the new volume group.

   ```bash
   vgchange -a y rescuemevg 
   ```
1. Rename the old rootvg volume group.  In this example, we will use the name "oldvg."

   ```bash
   vgrename rootvg oldvg 
   ```

1. Run the command `lsblk -o NAME,SIZE,LABEL,PARTLABEL,MOUNTPOINT` to review the available devices. You will now see both volume groups listed by the names you have assigned them.

6. Mount the rescuemevg/rootlv logical volume to the /investigateroot/ directory without using the duplicate UUIDs. 

   ```bash
   mount -o nouuid /dev/rescuemevg/rootlv /investigateroot/ 
   ```

   Now the root partition of the failed VM is unlocked and mounted, you can acesss the root partition to troubleshoot the issues. For more information, see [Repair the VM offline](linux-recovery-cannot-start-file-system-errors.md#repair-the-vm-offline). 

   However, if you want to use the chroot utility for troubleshooting, continue with the following steps.

7. Mount the encrypted disk’s boot partition to the directory /investigateroot/boot/ without using the duplicate UUIDs. (Remember that the encrypted disk’s boot partition is the second largest that is assigned no partition label.) In our current example, the encrypted disk’s boot partition is sda2.

   ```bash
   mount -o nouuid /dev/sda2 /investigateroot/boot
   ```
1. Mount the encrypted disk’s EFI system partition to the directory /investigateroot/boot/efi. You can identify this partition by its label. In our current example, the EFI system partition is sda1.
   ```bash
   mount /dev/sda1 /investigateroot/boot/efi
   ```
1. Mount the remaining unmounted logical volumes in the encrypted disk’s volume group into subdirectories of "/investigateroot/".
   ```bash
   mount -o nouuid /dev/mapper/rescuemevg-varlv /investigateroot/var
   mount -o nouuid /dev/mapper/rescuemevg-homelv /investigateroot/home
   mount -o nouuid /dev/mapper/rescuemevg-usrlv /investigateroot/usr
   mount -o nouuid /dev/mapper/rescuemevg-tmplv /investigateroot/tmp
   mount -o nouuid /dev/mapper/rescuemevg-optlv /investigateroot/opt
   ```
1. Change the active directory to the mounted root partition on the encrypted disk.
      ```bash
      cd /investigateroot
      ```
1. Enter the following commands to prepare the chroot environment:

      ```bash
      mount -t proc proc proc
      mount -t sysfs sys sys/
      mount -o bind /dev dev/
      mount -o bind /dev/pts dev/pts/
      mount -o bind /run run/
      ```
12. Enter the chroot environment:
      ```bash
      chroot /investigateroot/
      ```
13. Rename the rescuemevg to rootvg to avoid conflicts or possible issues with grub and initramfs. Keep the same naming convention when regenerating initramfs.
      ```bash
      vgrename rescuemevg rootvg
      ```

14. Troubleshoot issues in the chroot environment. For example, you can read logs or run a script. For more information, see [Perform fixes in the chroot environment](chroot-logical-volume-manager.md#perform-fixes).

### <a name="non-lvm"></a> Mount the unlocked disk, and enter the chroot environment (RAW/non-LVM)

1. In the root directory ("/") of the file structure, create a directory into which to mount the root partition of the encrypted disk. You will use this directory later, after the disk is unlocked. To distinguish it from the active OS partition of the repair VM, name it to "investigateroot".
   ```bash
   mkdir /{investigateboot,investigateroot}
   ```
1. Mount the newly unlocked partition ("osencrypt") to the /investigateroot/ directory.

   ```bash
   mount /dev/mapper/osencrypt /investigateroot/ 
   ```

   If mounting the partition fails with an "wrong fs type, bad option, bad superblock" error, try again by using the mount -o nouuid command: 

   ```bash
   mount -o nouuid /dev/mapper/osencrypt /investigateroot/ 
   ```

1. Attempt to display the contents of the /investigateroot/ directory to verify that the mounted partition is now unlocked. 

   ```bash
   ls /investigateroot/ 
   ```

1.  Now the root partition of the failed VM is unlocked and mounted, you can acesss the root partition to troubleshoot the issues. For more information, see [Repair the VM offline](linux-recovery-cannot-start-file-system-errors.md#repair-the-vm-offline).

      However, if you want to use the chroot utility for troubleshooting, continue with the following steps.
   
1. Use the command `lsblk -o NAME,SIZE,LABEL,PARTLABEL,MOUNTPOINT` to review the available devices. Identify the boot partition on the encrypted disk as the second largest partition that is assigned no label. 

1. Mount the boot partition on the encrypted disk to the "/investigateroot/boot/" directory, as in the following example:

   ```bash
   mount /dev/sdc2 /investigateroot/boot/ 
   ```

1. Change the active directory to the mounted root partition on the encrypted disk. 

   ```bash
   cd /investigateroot 
   ```

1. Enter the following commands to prepare the chroot environment:

   ```bash
   mount -t proc proc proc 

   mount -t sysfs sys sys/ 

   mount -o bind /dev dev/ 

   mount -o bind /dev/pts dev/pts/ 

   mount -o bind /run run/ 
   ```

1. Enter the chroot environment:

   ```bash
   chroot /investigateroot/ 
   ```
1. Troubleshoot issues in the chroot environment. For example, you can read logs or run a script.  For more information, see [Perform fixes in the chroot environment](chroot-logical-volume-manager.md#perform-fixes).

## <a name="re-encrypt"></a>Re-enable Azure Data Encryption on the disk

If you cannot find the BEK volume, try the following method to re-enable Disk encryption for the encrypted disk. This method only applies to the managed disk.

1.  Create the repair VM to attach a copy of the locked disk to a repair VM. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a repair VM ](troubleshoot-recovery-disks-portal-linux.md).

   If the process of creating a new repair VM when you attach the encrypted disk, you can create the VM without attaching the encrypted disk. After the repair VM is created, attach the encrypted disk to the VM through the Azure portal.

1. In the Azure portal, navigate to the Disks blade of the repair VM.

1. At the top menu, click Additional Settings.

1. On the **Disk Settings** page, reapply **Azure Data Encryption** to the data disk only. Be sure to specify the same key vault, key, and version as those used to encrypt the disk the first time.  

   This procedure will trigger the VM to create and attach the BEK volume. 
1. Proceed to [Identify the ADE key file in the BEK volume](#identify-the-header-file) and from that point,  continue following the steps to unlock the disk.

## Next steps
If you're having problems connecting to your VM, see Troubleshoot Remote Desktop connections to an Azure VM. For problems accessing applications that run on your VM, see Troubleshoot application connectivity issues on virtual machines in Azure.
