---
title: Swap file is not re-created after a Linux VM restarts
description: Describes how to resolve the problem that prevents a swap file from being re-created after a restart of a Linux virtual machine.
ms.date: 10/10/2020
ms.prod-support-area-path: 
ms.service: virtual-machines-linux
ms.author: genli
author: genli
ms.reviewer: danis
---
# Swap file is not re-created after a Linux VM restarts

This article provides a resolution to an issue in which the swap file can't be re-created after a restart of a Linux virtual machine.

_Original product version:_ &nbsp; Azure, Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4577868

## Symptoms

On Linux virtual machines (VMs) that are provisioned by [cloud-init](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init) and that have the [Microsoft Azure Linux Agent (waagent)](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init#what-is-the-difference-between-cloud-init-and-the-linux-agent-wala) installed, you may discover that the swap file is not re-created after a restart.

## Cause

This problem occurs because of a misconfiguration that causes both the Azure Linux Agent and cloud-init to try to configure the swap file.
When cloud-init is responsible for provisioning, the swap file must be configured by cloud-init to enable only one agent (either cloud-init or waagent) for provisioning. This issue can be intermittent because of the timing of when the waagent daemons start.

## Resolution

To resolve this problem, follow these steps:

1. Disable resource disk formatting, and then swap the configuration within the waagent configuration file: `/etc/waagent.conf`. To do this, follow the cloud-init method:

    ```
    # Format if unformatted. If 'n', resource disk will not be mounted. ResourceDisk.Format=n 
    # Create and use swapfile on resource disk. ResourceDisk.EnableSwap=n** 
    ```

2. Make sure that the Azure Linux Agent is not trying to mount the ephemeral disk. This is because the task is typically handled by cloud-init. Set the parameters as follows:

    ```
    # vi /etc/waagent.conf 
    #Mount point for the resource disk 
    ResourceDisk.MountPoint=/mnt 

    #Create and use swapfile on resource disk. 
    ResourceDisk.EnableSwap=n 

    # Create and use swapfile on resource disk. 
    ResourceDisk.EnableSwap=n 

    #Size of the swapfile. 
    ResourceDisk.SwapSizeMB=0
    ```

3. Restart the Azure Linux Agent. See [How to update the Azure Linux Agent on a VM](https://docs.microsoft.com/azure/virtual-machines/extensions/update-linux-agent) for information about the restart commands for different Linux distributions.
4. Make sure that the VM is configured to create a swap file by using cloud-init:
  
    1. Add the following script to `/var/lib/cloud/scripts/per-boot`.

        ```
        root@ub1804-ephemeral:/var/lib/cloud/scripts/per-boot# cat create_swapfile.sh
        #!/bin/sh
        if [ ! -f '/mnt/swapfile' ]; then
        fallocate --length 2GiB /mnt/swapfile    --> Here, set the swapsize as necessary.
        chmod 600 /mnt/swapfile
        mkswap /mnt/swapfile
        swapon /mnt/swapfile
        swapon -a ; fi
        ```

    2. Make the file executable by using the `# chmod +x create_swapfile.sh` command.
    3. Stop and Start the VM or Redeploy it from the portal, and check for swap enablement.
        Here is an example of how to enable the swap capability: 

        ```    
        root@ub1804-ephemeral:/var/lib/cloud/scripts/per-boot# free -m 
        total used free shared buff/cache available 
        Mem: 7953 296 7384 0 272 7412 
        Swap: 2047 0 2047
        ```

To isolate the issue, compare the logs from `/var/log/waagent.log` and `/var/log/cloud-init.log` for the reboot timeframe.

## Recommended fix

To avoid this situation completely, deploy the VM by using the swap configuration custom data during provisioning. For more information, see [Use cloud-init to configure a swap partition on a Linux VM](https://docs.microsoft.com/azure/virtual-machines/linux/cloudinit-configure-swapfile).
