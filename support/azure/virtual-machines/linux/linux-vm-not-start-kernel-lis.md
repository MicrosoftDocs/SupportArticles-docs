---
title: A Linux VM does not start correctly with kernel 3.10.0-514.16 after an LIS upgrade
description: Describes that A Linux VM does not start correctly with kernel 3.10.0-514.16 after a Linux Integration Services (LIS) upgrade. Provides a workaround.
ms.date: 11/26/2020
ms.author: genli
author: genlin
ms.reviewer: delhan, craigw
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
---
# A Linux VM does not start correctly with kernel 3.10.0-514.16 after an LIS upgrade

This article provides a workaround to an issue in which a Linux VM does not start correctly with kernel 3.10.0-514.16 after a Linux Integration Services (LIS) upgrade.

_Original product version:_ &nbsp; Microsoft Linux Integration Services; Microsoft Azure Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4022897

## Symptoms

If you install the Linux Integration Services (LIS) 4.1.3 drivers on a Linux virtual machine (VM) that uses kernel 3.10.0-514.16.1, the VM does not restart correctly, and you receive error messages that resemble the following:

> depmod: WARNING: /lib/modules/3.10.0-514.16.1.el7.x86_64/weak-updates/microsoft-hyper-v/hv_netvsc.ko needs unknown symbol vmbus_setevent
depmod: WARNING: /lib/modules/3.10.0-514.16.1.el7.x86_64/weak-updates/microsoft-hyper-v/hv_sock.ko needs unknown symbol vmbus_send_tl_connect_request
depmod: WARNING: /lib/modules/3.10.0-514.16.1.el7.x86_64/weak-updates/microsoft-hyper-v/hv_sock.ko needs unknown symbol vmbus_set_chn_rescind_callback depmod: WARNING: /lib/modules/3.10.0-514.16.1.el7.x86_64/weak-updates/microsoft-hyper-v/hv_sock.ko needs unknown symbol vmbus_hvsock_device_unregister

## Cause

This issue occurs because of changes that were made to the Kernel Application Binary interface (kABI). Because of these changes, the LIS driver (4.1.3) upgrade on kernel 3.10.0-514.16.1 fails.

## Workaround

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

We recommend that you do not upgrade the LIS driver 4.1.3 on a VM that is using kernel 3.10.0-514.16.1. Instead, we recommend that you install LIS 4.2.0 or a later version if you use kernel 3.10.0-514.16.1.

If LIS version 4.2.0 or later is not available in your Linux distribution package management system, you can manually download [LIS 4.2.0](https://www.microsoft.com/download/details.aspx?id=55106).

### Known issues in LIS 4.2.0

When you install the LIS 4.2.0 driver, you may experience an issue in which you can start the VM only in the latest kernel.

Microsoft is working to address this issue in an upcoming LIS update.

### Uninstall LIS 4.1.3

If you have already installed LIS 4.1.3, and you cannot start the VM, follow these steps to delete LIS 4.1.3, as appropriate for your setup.

#### For a Linux Hyper-V guest with console access

1. Start the VM in Rescue mode by using rescue media.
2. At the command prompt, run the following command to change the root directory to the system image:

    ```
    chroot /mnt/sysimage
    ```

3. Run the following commands to delete the LIS packages:

    ```
    packages=($(rpm -qa *microsoft-hyper-v*))
    rpm -e ${packages[@]}
    ```

#### For a Linux VM running in Azure

1. Follow the steps in the following article to create a recovery VM and mount the affected disk:

    [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM with the Azure CLI 2.0](/azure/virtual-machines/linux/troubleshoot-recovery-disks)

2. Run the following command to change the root directory to the system image:

    ```
    chroot /mnt/troubleshootingdisk
    ```

3. Run the following commands to delete the LIS packages:

    ```
    packages=($(rpm -qa *microsoft-hyper-v*))  
    rpm -e ${packages[@]}
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
