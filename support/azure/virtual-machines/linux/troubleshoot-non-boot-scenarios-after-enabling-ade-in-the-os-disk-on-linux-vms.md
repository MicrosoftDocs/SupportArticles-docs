---
title: Troubleshoot non-boot scenarios after enabling Azure Disk Encryption in the OS disk on Linux VMs
description: Resolve issues when a Linux VM is not booting after enabling Azure Disk Encryption
author: elicorme
ms.author: elcorral
ms.date: 04/01/2025
ms.reviewer: divargas
ms.service: azure-virtual-machines
ms.custom: linux-related-content
ms.topic: troubleshooting
ms.collection: linux
---

# How to fix issues related to VMs not booting after enabling Azure Disk Encryption

**Applies to:** :heavy_check_mark: Linux VMs

When deploying Azure Disk Encryption (ADE), various essential settings related to the boot process and system components are modified by editing files. If ADE fails or is interrupted, the virtual machine is likely to get stuck in emergency mode or become unusable. Especially when the OS disk is the one being encrypted.

Based on this, here you can find a list of the most common scenarios for a VM not to boot after ADE is deployed and how to approach them towards a feasible solution.

Remember that in all cases, you should [take a snapshot](/azure/virtual-machines/linux/snapshot-copy-managed-disk) and/or create a backup before disks are encrypted.

Backups ensure that a recovery option is possible if an unexpected failure occurs during encryption. For more information about how to back up and restore encrypted VMs, see the [Azure Backup](/azure/backup/backup-azure-vms-encryption) article.

## Common issues related to non-boot scenarios on machines using Azure Disk Encryption

For many of the issues related to non-boot scenarios, you need to pay attention to the extension logs showed either in the serial console or the extension log file, which is normally located at `/var/log/azure/Microsoft.Azure.Security.AzureDiskEncryptionForLinux/extension.log`.

## <a id="initram-miss"> </a> ADE modules missing in the initramfs image

If the OS disk is using LVM and you see a message like this:

 ```output
 Warning: /dev/mapper/rootvg-rootlv does not exist 
 ...
 Entering emergency mode. Exit the shell to continue.
 dracut:/# 
 ```

Chances are that the required modules were not added to the initial ram disk image, then try to:

1. [Restore from backup](/azure/backup/restore-azure-encrypted-virtual-machines) and attempt the encryption again.
2. If a restore is not feasible then use either the Azure CLI extension [az vm repair](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#method1) or the [manual method](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#method2) to  create a rescue VM, attach and unlock the OS disk of the failed Linux machine to that rescue VM
3. Once you are in [chroot](/azure/virtual-machines/linux/chroot-environment-linux), execute the following commands. Replace the kernel and extension version accordingly

    ### [RHEL 8,9](#tab/redhat)
    a. Copy the following files from the extension configuration directory to the initramfs scripts directory:
       
    ```bash
    sudo cp /var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-X.X.X.X/main/oscrypto/91adeOnline /usr/lib/dracut/modules.d/
    ```
    
    b. Regenerate the initramfs image

    ```bash
    sudo dracut -f -v /boot/initramfs-X.XX.X-XXX.XX.X.x86_64.img <KERNEL VERSION>
    ```
    
    c. Test the modified kernel by booting the VM from it, if everything works fine, regenerate the rest of the `initramfs` files if there are more.

    ### [Ubuntu](#tab/ubuntu)

    > [!NOTE]
    > This procedure could apply to non-boot scenarios after upgrading from Ubuntu 18 to Ubuntu 20. Review the scenario to confirm if it applies.

    a. Copy the following files from the extension configuration directory to the initramfs scripts directory:

    ```bash
    sudo cd /var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-X.x.x.xx/main/oscrypto/ubuntu_2004/encryptscripts
    sudo cp crypt-ade-boot /usr/share/initramfs-tools/scripts/init-premount/
    sudo cp crypt-ade-hook /usr/share/initramfs-tools/hooks/
    ```

    b. Once the file `crypt-ade-boot` is copied, replace `ROOTPARTUUID` variable in the line below with the OS partition path from `/dev/disk/by-partuuid/`.

    ```bash
    Example:
    sudo ls -l /dev/disk/by-partuuid/ | grep -w <partition containing the OS>
    lrwxrwxrwx 1 root root  10 May 18 17:33 ef61c3c3-50bb-40f0-8124-4cbe8cb2a380 -> ../../sda1
    ```

    c. Replace the `ROOTPARTUUID` variable below with the one obtained in the step above. Remember to replace the UUID according to your environment

    ```bash
    cryptsetup luksOpen /dev/disk/by-partuuid/ROOTPARTUUID osencrypt --header /boot/luks/osluksheader -d /mnt/azure_bek_disk/LinuxPassPhraseFileName
    ```

    d. Regenerate the initramfs image

    ```bash
    update-initramfs -u -k all
    ```

    e. An output similar to the one below is expected:

    ```output
    update-initramfs: Generating /boot/initrd.img-5.15.0-1038-azure
    cryptsetup: WARNING: target 'osencrypt' not found in /etc/crypttab
    + PREREQS=udev
    + mount -a
    + cryptsetup luksOpen /dev/disk/by-partuuid/ef61c3c3-50bb-40f0-8124-4cbe8cb2a380 osencrypt --header /boot/luks/osluksheader -d /mnt/azure_bek_disk/LinuxPassPhraseFileName
    Device osencrypt already exists.
    + exit 0
    ```

4. Swap the failed OS disk with the one containing the fix.
5. Review the extension and console logs to ensure the encryption process has finished successfully. Example:
   ```output
   [AzureDiskEncryption] 3670: [Info] ======= MACHINE STATE: completed =======
   [AzureDiskEncryption] 3670: [Info] Encryption succeeded for all volumes
   [AzureDiskEncryption] 3670: [Info] Executing: lvs --noheadings --nameprefixes --unquoted -o lv_name,vg_name,lv_kernel_major,lv_kernel_minor
   [AzureDiskEncryption] 3670: [Info] OS PV is encrypted
   [AzureDiskEncryption] 3670: [Info] found one ide with vmbus: 00000000-0000-8899-0000-000000000000 and the sdx path is: sda
   [AzureDiskEncryption] 3670: [Info] found one ide with vmbus: 00000000-0001-8899-0000-000000000000 and the sdx path is: sdb
   [AzureDiskEncryption] 3670: [Info] found one ide with vmbus: 00000001-0001-8899-0000-000000000000 and the sdx path is: sdc
   [AzureDiskEncryption] 3670: [Info] Executing: pvs
   [AzureDiskEncryption] 3670: [Info] Found OS block device: /dev/mapper/osencrypt
   ```
6. Review the `initramfs` files to ensure that the Azure Disk Encryption modules were propely added
   
   **RHEL 8,9:**
   A similar output to the one below is expected. Replace the `initramfs` file name accordingly.
   
   ```output
   sudo lsinitrd /boot/initramfs-4.18.0-553.45.1.el8_10.x86_64.img | egrep -w "ade|adeOnline"
   adeOnline
   -rwxr--r--   1 root     root         1126 Jan 15  2024 usr/lib/dracut/hooks/cmdline/30-parse-crypt-ade.sh
   -rwxr--r--   1 root     root          681 Jan 15  2024 usr/sbin/crypt-run-generator-ade
   ```

   **Ubuntu:**
   ```output
    lsinitramfs /boot/initrd.img-5.15.0-1082-azure | egrep -i ade
    boot/luks/osluksheader
    conf/conf.d/cryptheader
    scripts/init-premount/crypt-ade-boot
   ```
   
## Interrupted encryption

It depends on where the encryption process was interrupted to determine what steps to follow for troubleshooting, keep in mind that there could be scenarios where the only option will be to [restore from backup](/azure/backup/restore-azure-encrypted-virtual-machines).

1. Review the console logs and look for any error messages, normally extension deployment problems will be presented in the form of python errors, for example:
 ```output
[AzureDiskEncryption] 7293: [Info] Command /sbin/e2fsck -f -y /dev/korn-fromme failed with return code 8
stdout:
Possibly non-existent device?

stderr:
e2fsck 1.46.5 (30-Dec-2021)
/sbin/e2fsck: No such file or directory while trying to open /dev/korn-fromme

[AzureDiskEncryption] 7293: [Error] check shrink fs failed with code 8 for /dev/korn-fromme
[AzureDiskEncryption] 7293: [Info] Your file system may not have enough space to do the encryption or file System may not support resizing
[AzureDiskEncryption] 7293: [Error] Failed to encrypt data volumes with error: Encryption failed for name:korn-fromme type:lvm fstype:ext4 mountpoint:/someone label: model: size:6442450944 majmin:None device_id:, stack trace: Traceback (most recent call last):
  File '/var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-1.4.0.7/main/handle.py', line 2172, in daemon_encrypt
    while not daemon_encrypt_data_volumes(encryption_marker=encryption_marker,
  File '/var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-1.4.0.7/main/handle.py', line 2438, in daemon_encrypt_data_volumes
    raise Exception(message)
Exception: Encryption failed for name:korn-fromme type:lvm fstype:ext4 mountpoint:/someone label: model: size:6442450944 majmin:None device_id:
```

2. Ensure all the [extension pre-requisites](/azure/virtual-machines/linux/disk-encryption-overview#additional-vm-requirements) are met.

3. If required, work on a rescue VM and analyze the failed disk. For the operating system disk ensure that:
     1. The required partitions are in place and the data is healthy.
     2. The [operating system LUKS header file](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#identify-the-header-file) is called `osluksheader` and is stored separately under the `/boot` partition. If the disk was encrypted and this file is missing or corrupted, there is no way to recover the virtual machine unless you have a working backup.
     3. The initramfs contains the required ADE modules. If he modules are missing, follow the steps on [ADE modules missing in the initram image](#initram-miss).
     4. The BEK VOLUME contains the [ADE key file](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#identify-the-ade-key-file).
     
4. In case the key file is missing, then create a test machine and encrypt it (volume type DATA) using the original encryption settings used to encrypt the faulty VM, once encrypted, check the test VM looking for the ADE key file in the BEK volume.
     1. Copy the ADE key file
     2. Start the faulty machine
     3. While in the emergency mode, [Identify the ADE key file](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#identify-the-ade-key-file), [Identify the header file](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#identify-the-header-file) then, based on the disk layout LVM or raw, [open the disk from encryption manually](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair#unlock-by-files).
     4. Let the machine boot.
     5. If the ADE key file is still missing, and the BEK volume is mounted, manually create a file called `/mnt/azure_bek_disk/LinuxPassPhraseFileName` with the ADE key file contents.
     6. Reboot the machine
     7. Redeploy the machine.

## Not enough space in the boot partition (Ubuntu)

> [!NOTE]
> [Ubuntu 24](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.ubuntu-24_04-lts?tab=Overview) and higher images now come with a separate `/boot` partition with at least 1GB size.

ADE needs a separate partition for `/boot`, for that reason during the extension deployment it creates `/boot` as a separate partition and restore the original files back. At the end of the process a new initial ram disk file is created, if there is not enough space, this step is going to fail. This scenario is particularly complex since there are many variants and as for now [resizing the OS disk](/azure/virtual-machines/linux/how-to-resize-encrypted-lvm#scenarios) is not supported when the OS disk is using ADE.
At the time of writing, only Ubuntu images may fall under this process of boot split.

In order to avoid falling into this issue, check on the following items:

1. Delete old kernels not in use.
2. Ensure only the necessary files are under `/boot`.

## VFAT kernel module disabled

The VFAT kernel module is required in order to mount the BEK volume. If the module is not enabled the ADE key file is not going to be available, therefore the disk is not going to be unlocked.

Before continuing with the encryption [enable the VFAT module](/azure/virtual-machines/linux/vfat-disabled-boot-issues#ade-encrypted-vm-is-unable-to-access-root-volume)

## Problems related to missing packages

The ADE extension will install the required packages in case they are not installed by default.
If for some reason this installation step fails, the encryption will also fail. 

In order to identify the cause for packages not being installed review the extension logs from the console. 
1. Locate a message like this:

```output
[Info] Installing pre-requisites
```

2. Then, ensure all the packages were successfully installed. Visit [Package management](/azure/virtual-machines/linux/disk-encryption-isolated-network#package-management) for a full list of the required packages based on the Linux distro.
3. If there are errors related to package installation, identify which package failed and why it failed. 
4. Ensure the VM has access to the package repositories. Go to [Azure Disk Encryption on an isolated network](/azure/virtual-machines/linux/disk-encryption-isolated-network) in case the VM is under special network requirements.
5. For more information about troubleshooting repository issues see [Troubleshoot common issues in the yum and dnf package management tools for Linux](/azure/virtual-machines/linux/yum-dnf-common-issues?tabs=rhel7%2Crhel) and [Troubleshoot common issues with APT on Ubuntu](/azure/virtual-machines/linux/apt-common-issues-in-ubuntu)

## Missing parameters in the GRUB configuration

During the encryption process the extension will add a couple of parameters to the kernel options in the file `/etc/default/grub` these are related to the boot and root partition UUID:

`rd.luks.ade.partuuid` and `rd.luks.ade.bootuuid`

These parameters must be present and properly set to the `UUIDs` accordingly. If this is not case, [offline troubleshooting](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair) will be required in order to add the parameter manually. The UUIDs can be obtained in a `chroot` environment by running the command `blkid`.
For more information about regenerating the grub file see [Reinstall GRUB and regenerate the GRUB configuration file manually](/azure/virtual-machines/linux/troubleshoot-vm-boot-error#reinstall-grub-regenerate-grub-configuration-file)

## Missing or corrupted osluksheader file

LUKS stores its encryption metadata in a special section at the beginning of the encrypted partition called the LUKS header.
This header contains some critical information such as the cipher and mode, hash function, and key slots.
The actual encrypting of the partition is done using a master key.

When using ADE in the OS disk, the header is stored in a file under the `/boot` partition named `osluksheader`. If for any reason this file suffers corruption or if it is missing, the only way to retrive it is via a backup. Use the [offline troubleshooting](/azure/virtual-machines/linux/unlock-encrypted-linux-disk-offline-repair) method to mount the `boot` partition of the affected disk and place the `osluksheader` file from backup respectively.

## Resources

* [Azure Disk Encryption for Linux VMs](/azure/virtual-machines/linux/disk-encryption-overview)
* [Azure Disk Encryption troubleshooting](/azure/virtual-machines/linux/disk-encryption-troubleshooting)
* [Azure Disk Encryption frequently asked questions](/azure/virtual-machines/linux/disk-encryption-faq)
