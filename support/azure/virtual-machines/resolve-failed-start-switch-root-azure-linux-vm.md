---
title: Failed to start Switch Root error in an Azure Linux VM
description: This article shows how to resolve the error "Failed to start Switch Root" for an Azure Linux Virtual Machine (VM).
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue
ms.service: virtual-machines
ms.topic: troubleshooting
ms.date: 08/19/2021
ms.author: tibasham

---
# Resolve "Failed to start Switch Root" for an Azure Linux VM

This article shows how to resolve the error "Failed to start Switch Root" for an Azure Linux Virtual Machine (VM). This issue can occur when you update to the following GRUB package versions on Oracle 8 SP2:

- grub2-common-2.02-78.0.3.el8_1.1.noarch
- grub2-pc-modules-2.02-78.0.3.el8_1.1.noarch
- grub2-efi-x64-2.02-78.0.3.el8_1.1.x86_64
- grub2-tools-extra-2.02-78.0.3.el8_1.1.x86_64
- grub2-tools-2.02-78.0.3.el8_1.1.x86_64
- grub2-pc-2.02-78.0.3.el8_1.1.x86_64
- grub2-tools-minimal-2.02-78.0.3.el8_1.1.x86_64

If your Azure issue is not addressed in this article, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). Post your issue in either these forums or to [@AzureSupport on Twitter](https://twitter.com/AzureSupport).

To submit an Azure support request on the [Azure support](https://azure.microsoft.com/support/options/) page, select **Get support**.

## Manually fix the issue in the Guest OS

If you have access to the [Azure Serial Console](serial-console-linux.md) proceed with the steps in the following [Azure Serial Console method](#azureconsole) section.

If you're unable to use the Azure Serial Console section, proceed to the [Offline method](#offlinemethod).

### <a name="azureconsole"></a>Azure Serial Console method

1. Reboot the VM using the Azure Serial Console, and hold the Escape key to access the GRUB menu.

2. Select the entry for the rescue kernel.

3. Copy the *kernelopts* value from the *grubenv* file.

   Example:

   ```console
   [root@examplevm ~] # cat /boot/efi/EFI/redhat/grubenv
   saved_entry=d606d39f9aa249beb74216035ea11733-4.18.0-193.19.1.el8_2.x86_64  
   kernelopts=**root=UUID=bc0bc3e1-e621-40ab-96ca-8d6a5268f17e ro  crashkernel=auto console=tty0 console=ttyS0,115200n8**  
   boot_success=1 
   ```

4. Edit the desired boot entry from `/boot/loader/entries` and manually add both `kernelopts` and `earlyprintk=ttyS0` to the command.

   Example:

   ```console
   [root@examplevm ~] # vi /boot/loader/entries/a358b364a6d3492898bedc8d1dea3e92-4.18.0-147.8.1.el8_1.x86_64.conf
   title Oracle Linux Server (4.18.0-147.8.1.el8_1.x86_64) 8.2  
   version 4.18.0-147.8.1.el8_1.x86_64  
   linux /vmlinuz-4.18.0-147.8.1.el8_1.x86_64 **root=UUID=bc0bc3e1-e621-40ab-96ca-8d6a5268f17e ro  crashkernel=auto console=tty0 console=ttyS0,115200n8 _earlyprintk=ttyS0_**  
   initrd /initramfs-4.18.0-147.8.1.el8_1.x86_64.img $tuned_initrd  
   options $kernelopts $tuned_params  
   id ol-20200407213902-4.18.0-147.8.1.el8_1.x86_64  
   grub_users $grub_users  
   grub_arg --unrestricted  
   grub_class kernel  
   ```

5. Reboot the VM. If more than one kernel is installed, you might need to select the modified entry from the GRUB menu.

### <a name="offlinemethod"></a>Offline method

If you're unable to access the VM using the Azure Serial Console, then the repair must be done in offline mode, as the VM isn't booting.

1. Use steps 1-3 of the [VM Repair Commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.

2. Using SSH, connect to the Repair VM.

3. Once connected to the repair VM, use `lsblk` to find your boot and efi partitions:

   :::image type="content" source="media/resolve-failed-start-switch-root-azure-linux-vm/find-boot-efi-partitions.png" alt-text="Screenshot shows the boot and efi partitions.":::

4. Create a temporary mount point. For example, use `/repair`.

   `mkdir /repair`

5. Mount the boot partition on the temporary mount point. For example, use `/dev/sdc1`.

   `mount /dev/sdc1 /repair/`

6. Mount the efi partition under `efi` on the temporary mount point. For example, use `/dev/sdc15`.

   `mount /dev/sdc15 /repair/efi/`

7. Copy the *kernelopts* value from the *grubenv* file.

   Example:

   ```console
   [root@repairvm ~] # cat /boot/efi/EFI/redhat/grubenv
   saved_entry=d606d39f9aa249beb74216035ea11733-4.18.0-193.19.1.el8_2.x86_64  
   kernelopts=**root=UUID=bc0bc3e1-e621-40ab-96ca-8d6a5268f17e ro  crashkernel=auto console=tty0 console=ttyS0,115200n8**  
   boot_success=1 
   ```

8. Edit the desired boot entry from `/boot/loader/entries` and manually add both `kernelopts` and `earlyprintk=ttyS0` to the command.

   Example:

   ```console
   [root@repairvm ~] # vi /boot/loader/entries/a358b364a6d3492898bedc8d1dea3e92-4.18.0-147.8.1.el8_1.x86_64.conf
   title Oracle Linux Server (4.18.0-147.8.1.el8_1.x86_64) 8.2  
   version 4.18.0-147.8.1.el8_1.x86_64  
   linux /vmlinuz-4.18.0-147.8.1.el8_1.x86_64 **root=UUID=bc0bc3e1-e621-40ab-96ca-8d6a5268f17e ro  crashkernel=auto console=tty0 console=ttyS0,115200n8 _earlyprintk=ttyS0_**  
   initrd /initramfs-4.18.0-147.8.1.el8_1.x86_64.img $tuned_initrd  
   options $kernelopts $tuned_params  
   id ol-20200407213902-4.18.0-147.8.1.el8_1.x86_64  
   grub_users $grub_users  
   grub_arg --unrestricted  
   grub_class kernel  
   ```

9. Unmount the efi partition. For example,   `/repair/efi/`.

   `umount /repair/efi`

10. Unmount the boot partition. For example,  `/repair/`.

    `umount /repair`

11. Use step 5 of [VM Repair Commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to rebuild the VM.

12. Start the VM. If more than one kernel is installed, you might need to select the modified entry from the GRUB menu.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
