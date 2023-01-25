---
title: Create a SWAP file for an Azure Linux VM
description: Describes how to create a SWAP file for an Azure Linux VM.
ms.date: 10/27/2022
ms.service: virtual-machines
ms.subservice: vm-linux-setup-configuration
ms.collection: linux
ms.author: mabicca
author: mabicca
---

# Create a SWAP file for an Azure Linux VM

To create a SWAP file on Azure Linux VMs, you need to set up cloud-init to automatically create it on the ephemeral (resource) disk of the VM. The resource disk is mounted under `/mnt` by default. It’s located on the physical server where the Linux VM is hosted and has lower latency. It's not recommended to create SWAP partitions on OS disks or data disks that might impact the performance of the operating system and apps. It's important to remember that the resource disk should never be used to store regular data since it's only temporary storage. When a VM is moved to another host or stopped/deallocated, any data written to this disk will be wiped. The resource disk is only recommended to be used for data that can be removed such as SWAP and caching files. For more information, see [Temporary disk](/azure/virtual-machines/managed-disks-overview#temporary-disk).

## Disable SWAP creation in waagent configuration

If the SWAP creation is configured in *Waagent.config*, you must disable it.

1. Disable resource disk formatting and SWAP configuration within Waagent.config, because this task is now handled by Cloud-Init. Set the parameters as follows:

    ```Configuration
    # Format if unformatted. If 'n', resource disk will not be mounted.
    ResourceDisk.Format=n

    # Create and use SWAPfile on resource disk.
    ResourceDisk.EnableSWAP=n

    #Mount point for the resource disk
    ResourceDisk.MountPoint=/mnt
  
    #Size of the SWAPfile.
    ResourceDisk.SWAPSizeMB=0
    ```

1. Restart the Azure Linux Agent. See [How to update the Azure Linux Agent on a VM](/azure/virtual-machines/extensions/update-linux-agent) for information about the restart commands for different Linux distributions.

Then, create the SWAP file under the resource disk path or a custom path.

## Create a SWAP file under the resource disk path

1. Create a new file named swap.sh under `/var/lib/cloud/scripts/per-boot` with the following script:

    ```bash
    #!/bin/sh

    # Percent of space on the ephemeral disk to dedicate to swap. Here 30% is being used. Modify as appropriate.
    PCT=0.3

    # Get size of the ephemeral disk and multiply it by the percent of space to allocate
    size=$(df -m --output=target,avail | awk -v percent="$PCT" '/\/mnt/{SIZE=int($2*percent);print SIZE}')
    echo "$size MB of space being allocated to swap file"

    # Create an empty file first and set correct permissions
    dd if=/dev/zero of=/mnt/swapfile bs=1M count=$size
    chmod 0600 /mnt/swapfile

    # Make the file available to use as swap
    mkswap /mnt/swapfile

    # Enable swap
    swapon /mnt/resource/swapfile
    swapon -a
    ```

    The script will be executed on every boot and allocates 30% of the available space in the resource disk. You can customize the values based on your situation.

1. Make sure the file is executable.

    ```bash
    chmod +x /var/lib/cloud/scripts/per-boot/swap.sh
    ```

1. Stop and start the VM. This is only necessary the first time after you create the SWAP file.

## Create a SWAP file under a custom path

1. Create a file named 99-resource-disk.cfg under `/etc/cloud/cloud.cfg.d/`

    ```yaml
    #cloud-config
    disk_setup:
    ephemeral0:
    table_type: mbr
    layout: [66, 33]
    overwrite: True
    fs_setup:
    - device: ephemeral0
    filesystem: ext4
    mounts:
    - ["ephemeral0", "/azure/resource", "auto", "defaults,nofail", "0", "0"]
    ```

1. Proceed with the same steps to create the script, but you should notice a different path. Instead of `/mnt`, we use `/azure/resource` as the custom path. You can change the path or SWAPsize based on your situation.

    ```bash
    #!/bin/sh

    # Percent of space on the ephemeral disk to dedicate to swap. Here 30% is being used. Modify as appropriate.
    PCT=0.3

    # Get size of the ephemeral disk and multiply it by the percent of space to allocate. Modify the custom path below (azure\/resource) as appropriate.
    size=$(df -m --output=target,avail | awk -v percent="$PCT" '/\azure\/resource/{SIZE=int($2*percent);print SIZE}')
    echo "$size MB of space being allocated to swap file"

    # Create an empty file first and set correct permissions
    dd if=/dev/zero of=/azure/resource/swapfile bs=1M count=$size
    chmod 0600 /azure/resource/swapfile

    # Make the file available to use as swap
    mkswap /azure/resource/swapfile

    # Enable swap
    swapon /azure/resource/swapfile
    swapon -a
    ```

1. Make sure the file is executable:

    ```bash
    chmod +x /var/lib/cloud/scripts/per-boot/swap.sh
    ```

1. Stop and start the VM. This is only necessary the first time after you create the SWAP file.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
