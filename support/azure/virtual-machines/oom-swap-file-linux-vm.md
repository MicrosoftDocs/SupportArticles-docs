---
title: Out of memory error occurs in Linux Azure virtual machine
description: Describes how to add swap space in Linux Azure virtual machines.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.collection: linux
---
# Out of memory error occurs in Linux Azure virtual machine

This article helps understand and troubleshoot an out-of-memory (OOM) error when using Linux Azure virtual machine.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4010058

## Symptoms

On a Linux Azure virtual machine, you encounter an OOM error. For example, the System log shows the following error:

> localhost kernel: Out of memory: Kill process 2154 (oom) score 844 or sacrifice child

## Cause

This issue may be caused by the lack of a swap file.

## Resolution

Add a swap file to increase the virtual memory in Linux Azure virtual machines. To do this, follow these steps.

> [!NOTE]
>
> - The following commands are executed as root.
> - You should set the swap file in compliance with the guidance from your Linux vendor: [Ubuntu](https://help.ubuntu.com/community/SwapFaq), [Red Hat](https://access.redhat.com/documentation/en-US/red_hat_enterprise_linux/4/html/system_administration_guide/swap_space).
> - Before you create a swap file, you can run the following command to learn how much space is available under `/mnt/resource` or `/mnt`: `df -h`.

1. To create a swap file in the directory that's defined by the **ResourceDisk.MountPoint** parameter, you can update the **/etc/waagent.conf** file by setting the following three parameters:

    ```
    ResourceDisk.Format=y
    ResourceDisk.EnableSwap=y
    ResourceDisk.SwapSizeMB= xx
    ```

   > [!NOTE]
   > The xx placeholder represents the desired number of megabytes (MB) for the swap file.

2. Restart the WALinuxAgent service by running one of the following commands, depending on the system in question:

    ```bash
    Ubuntu: service walinuxagent restart
    Red Hat/Centos: service waagent restart
    ```

3. Run one of the following commands to show the new swap apace that's being used after the restart:

    ```bash
    dmesg | grep swap
    swapon -s
    cat /proc/swaps
    file /mnt/resource/swapfile
    free| grep -i swap
    ```

4. If the swap file isn't created, you can restart the virtual machine by using one of the following commands:

    ```bash
    shutdown -r now
    init 6
    ```

For more information, see [Ubuntu Cloud Images](https://cloud-images.ubuntu.com/) and [SWAP space in Windows Azure Virtual Machines running pre-built Linux Images](https://azure.microsoft.com/blog/swap-space-in-windows-azure-virtual-machines-running-pre-built-linux-images-part-1/).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
