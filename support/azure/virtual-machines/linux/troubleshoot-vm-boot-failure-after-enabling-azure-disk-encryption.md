---
title: Troubleshoot Linux VM boot failure after enabling Azure Disk Encryption
description: Provides troubleshooting steps to an issue where an Azure Linux virtual machine fails to boot after deploying Azure Disk Encryption fails.
ms.date: 04/24/2025
ms.service: azure-virtual-machines
ms.custom: sap:Azure Disk Encryption (ADE) for Linux, linux-related-content
ms.reviewer: divargas, elcorral, v-weizhu
---
# Troubleshoot Linux VM boot failure after enabling Azure Disk Encryption

**Applies to:** :heavy_check_mark: Linux VMs

When you deploy Azure Disk Encryption (ADE) for an Azure Linux virtual machine (VM), various essential settings related to the boot process and system components are modified by editing files. If the ADE deployment fails or is interrupted, the VM might become stuck in emergency mode or unusable, especially when the operating system (OS) disk is encrypted.

This article lists common scenarios where a Linux VM fails to boot after an ADE deployment and provides steps to troubleshoot the issue.

## Prerequisites

In all scenarios, you should [take a snapshot](/azure/virtual-machines/linux/snapshot-copy-managed-disk) or create a backup before disks are encrypted. Backups ensure that a recovery option is possible if an unexpected failure occurs during encryption. For more information about how to back up and restore encrypted VMs, see [Azure Backup](/azure/backup/backup-azure-vms-encryption).

## Extension logs

To troubleshoot Linux VM boot issues, check the extension logs in the Azure serial console or the extension log file `/var/log/azure/Microsoft.Azure.Security.AzureDiskEncryptionForLinux/extension.log`.

## <a id="initram-miss"> </a> Scenario 1: ADE modules are missing in the initramfs image

If the OS disk uses Logical Volume Manager (LVM) and you see a warning message like the following text, the required modules aren't included in the initial ram disk image:

 ```output
 Warning: /dev/mapper/rootvg-rootlv does not exist 
 ...
 Entering emergency mode. Exit the shell to continue.
 dracut:/# 
 ```

To resolve this issue, follow these steps:

1. [Restore the VM from a backup](/azure/backup/restore-azure-encrypted-virtual-machines) and attempt the encryption again.
2. If a restore isn't feasible, use the Azure CLI extension [az vm repair](unlock-encrypted-linux-disk-offline-repair.md#method1) to create a repair VM, or use the [manual method](unlock-encrypted-linux-disk-offline-repair.md#method2) to create a rescue VM, then attach and unlock the OS disk of the faulty VM to that repait/rescue VM.
3. Once you are in [chroot](chroot-environment-linux.md), execute the following commands:

    > [!NOTE]
    > Replace the kernel and extension version accordingly in the following commands.

    ### [RHEL 8 and 9](#tab/redhat)

    1. Copy the following files from the extension configuration directory to the initramfs scripts directory:

        ```bash
        sudo cp /var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-X.X.X.X/main/oscrypto/91adeOnline /usr/lib/dracut/modules.d/
        ```

    2. Regenerate the initramfs image:

        ```bash
        sudo dracut -f -v /boot/initramfs-X.XX.X-XXX.XX.X.x86_64.img <kernal version>
        ```

    3. Test the modified kernel by booting the VM from it. If it works, regenerate any remaining initramfs files.

    ### [Ubuntu](#tab/ubuntu)

    > [!NOTE]
    > This procedure might also apply to boot issues that occur after a VM upgrades from Ubuntu 18 to Ubuntu 20.

    1. Copy the following files from the extension configuration directory to the initramfs scripts directory:

        ```bash
        sudo cd /var/lib/waagent/Microsoft.Azure.Security.AzureDiskEncryptionForLinux-X.X.X.X/main/oscrypto/ubuntu_2004/encryptscripts
        sudo cp crypt-ade-boot /usr/share/initramfs-tools/scripts/init-premount/
        sudo cp crypt-ade-hook /usr/share/initramfs-tools/hooks/
        ```

    2. Once the file `crypt-ade-boot` is copied, replace the `ROOTPARTUUID` variable in the following line with the OS partition path from `/dev/disk/by-partuuid/`:

        ```bash
        sudo ls -l /dev/disk/by-partuuid/ | grep -w <partition containing the OS>
        lrwxrwxrwx 1 root root  10 May 18 17:33 ef61c3c3-50bb-40f0-8124-4cbe8cb2a380 -> ../../sda1
        ```

    3. Replace the `ROOTPARTUUID` variable with the one obtained in the preceding step. Replace the Universally Unique Identifier (UUID) of the partition according to your environment.

        ```bash
        cryptsetup luksOpen /dev/disk/by-partuuid/ROOTPARTUUID osencrypt --header /boot/luks/osluksheader -d /mnt/azure_bek_disk/LinuxPassPhraseFileName
        ```

    4. Regenerate the initramfs image:

        ```bash
        update-initramfs -u -k all
        ```

        An output similar to the following text is expected:

        ```output
        update-initramfs: Generating /boot/initrd.img-5.15.0-1038-azure
        cryptsetup: WARNING: target 'osencrypt' not found in /etc/crypttab
        + PREREQS=udev
        + mount -a
        + cryptsetup luksOpen /dev/disk/by-partuuid/ef61c3c3-50bb-40f0-8124-4cbe8cb2a380 osencrypt --header /boot/luks/osluksheader -d /mnt/azure_bek_disk/LinuxPassPhraseFileName
        Device osencrypt already exists.
        + exit 0
        ```

    ---

4. Swap the failed OS disk with the one containing the fix.

5. Review the extension logs and serial console logs to ensure the encryption process finishes successfully:

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

6. Review the initramfs files to ensure that the ADE modules are properly added:

    > [!NOTE]
    > Replace the initramfs file name accordingly in the following commands.

   ### [RHEL 8 and 9](#tab/redhat)

   ```bash
   sudo lsinitrd /boot/initramfs-4.18.0-553.45.1.el8_10.x86_64.img | egrep -w "ade|adeOnline"
   ```

   An output similar to the following one is expected:

   ```output
   -rwxr--r--   1 root     root         1126 Jan 15  2024 usr/lib/dracut/hooks/cmdline/30-parse-crypt-ade.sh
   -rwxr--r--   1 root     root          681 Jan 15  2024 usr/sbin/crypt-run-generator-ade
   ```

   ### [Ubuntu](#tab/ubuntu)

   ```bash
    lsinitramfs /boot/initrd.img-5.15.0-1082-azure | egrep -i ade
   ```

    An output similar to the following one is expected:

    ```output
    boot/luks/osluksheader
    conf/conf.d/cryptheader
    scripts/init-premount/crypt-ade-boot
    ```

    ---

## Scenario 2: The encryption is interrupted

The steps for troubleshooting an interrupted encryption depend on where the process is interrupted. In some scenarios, [restoring from backup](/azure/backup/restore-azure-encrypted-virtual-machines) might be the only option.

1. Check the serial console logs for any error messages.

    Extension deployment issues are typically indicated by Python errors. For example:

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

2. Ensure all the [extension prerequisites](/azure/virtual-machines/linux/disk-encryption-overview#additional-vm-requirements) are met.

3. If necessary, work on a rescue VM and analyze the failed disk. For the OS disk, ensure the following things:
     - The required partitions are in place and the data is healthy.
     - The [OS LUKS header file](unlock-encrypted-linux-disk-offline-repair.md#identify-the-header-file) is called `osluksheader` and stored separately under the boot partition. If the disk is encrypted and this file is missing or corrupted, there's no way to recover the VM unless you have a working backup.
     - The initramfs contains the required ADE modules. If the required modules are missing, follow the steps in the [ADE modules missing in the initram image](#initram-miss) section.
     - The BEK volume contains the [ADE key file](unlock-encrypted-linux-disk-offline-repair.md#identify-the-ade-key-file).

4. If the ADE key file is missing, create a test VM and encrypt it (volume type data) using the original encryption settings that encrypt the faulty VM. Once encrypted, follow these steps:
     1. Copy the ADE key file in the BEK volume on the test VM.
     2. Start the faulty VM.
     3. While in the emergency mode, [identify the ADE key file](unlock-encrypted-linux-disk-offline-repair.md#identify-the-ade-key-file) and then [identify the header file](unlock-encrypted-linux-disk-offline-repair.md#identify-the-header-file).
     4. Based on the disk layout LVM or raw, [open the disk from encryption manually](unlock-encrypted-linux-disk-offline-repair.md#unlock-by-files).
     5. Boot the VM.
     6. If the ADE key file is still missing and the BEK volume is mounted, manually create a file called `/mnt/azure_bek_disk/LinuxPassPhraseFileName` with the ADE key file contents.
     7. Reboot the VM.
     8. Redeploy the VM.

## Scenario 3: There isn't enough space in the boot partition (Ubuntu)

> [!NOTE]
> Starting with [Ubuntu 24](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.ubuntu-24_04-lts?tab=Overview), images come with a separate boot partition with at least 1 GB size.

ADE requires a separate boot partition. During an extension deployment, it creates `/boot` as a separate partition and restores the original files. At the end of this process, a new initial ram disk file is created. If there's insufficient space, this step fails. This scenario is complex due to many variants. When the OS disk uses ADE, [resizing the OS disk](/azure/virtual-machines/linux/how-to-resize-encrypted-lvm#scenarios) isn't supported. Currently, only Ubuntu images might fall under this process of boot split.

To prevent this issue, perform the following actions:

1. Delete old kernels not in use.
2. Ensure only the necessary files are under `/boot`.

## Scenario 3: The VFAT kernel module is disabled

The VFAT kernel module must be enabled to mount the BEK volume. If not, the ADE key file isn't available, which causes that the disk can't be unlocked. To proceed with the encryption, [enable the VFAT module](vfat-disabled-boot-issues.md#ade-encrypted-vm-is-unable-to-access-root-volume).

## Scenario 4: Required packages fail to install

The ADE extension installs required packages if they aren't installed by default. If this package installation fails, the encryption fails.

To determine the cause of package installation failures, follow these steps:

1. Review the extension logs from the Azure serial console and locate a message like this:

    ```output
    [Info] Installing pre-requisites
    ```

2. Ensure all the packages are successfully installed.

   For a full list of the required packages based on the Linux distro, see [Package management](/azure/virtual-machines/linux/disk-encryption-isolated-network#package-management).

3. If there are issues with the package installation, determine which package fails and the reason.

4. Ensure the faulty VM has access to the package repositories.

    If the faulty VM has specific network requirements, go to [Azure Disk Encryption on an isolated network](/azure/virtual-machines/linux/disk-encryption-isolated-network).

    For more information about troubleshooting repository issues, see [Troubleshoot common issues in the yum and dnf package management tools for Linux](yum-dnf-common-issues.md) and [Troubleshoot common issues with APT on Ubuntu](apt-common-issues-in-ubuntu.md).

## Scenario 5: Missing parameters in the GRUB configuration

During the encryption process, the extension adds several parameters to the kernel options in the file `/etc/default/grub`. These parameters are related to the UUID of the boot and root partitions: `rd.luks.ade.partuuid` and `rd.luks.ade.bootuuid`.

The parameters must be correctly set to the UUIDs. If not, use [offline troubleshooting](unlock-encrypted-linux-disk-offline-repair.md) method to add the parameters manually. You can obtain the UUIDs in a `chroot` environment using the `blkid` command.

For more information about regenerating the grub file, see [Reinstall GRUB and regenerate the GRUB configuration file manually](troubleshoot-vm-boot-error.md#reinstall-grub-regenerate-grub-configuration-file).

## Scenario 6: Missing or corrupted osluksheader file

LUKS stores its encryption metadata in the LUKS header at the beginning of the encrypted partition. This header includes crucial information such as the cipher, mode, hash function, and key slots. The partition is encrypted using a master key.

When ADE is used in the OS disk, the header is stored in a file located in the boot partition named `osluksheader`. If this file is corrupted or missing, it can only be restored from a backup. Use the [offline troubleshooting](unlock-encrypted-linux-disk-offline-repair.md) method to mount the boot partition of the affected disk and place the `osluksheader` file from backup respectively.

## Resources

- [Azure Disk Encryption for Linux VMs](/azure/virtual-machines/linux/disk-encryption-overview)
- [Azure Disk Encryption for Linux VMs troubleshooting guide](/azure/virtual-machines/linux/disk-encryption-troubleshooting)
- [Azure Disk Encryption for Linux virtual machines FAQ](/azure/virtual-machines/linux/disk-encryption-faq)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
