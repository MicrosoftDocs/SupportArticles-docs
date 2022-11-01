---
title: Create a SWAP file for a Azure Linux VM
description: Describes how to create a SWAP file for a Azure Linux VM.
ms.date: 10/27/2022
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: linux
ms.author: mabicca
author: mabicca
---

# Create a SWAP file for a Azure Linux VM

To create a SWAP file on Azure Linux VMs, you need to set up cloud-init to automatically create it on the ephemeral (resource) disk of the VM. The resource disk is mounted under `/mnt` by default. It’s located on the physical server where the Linux VM is hosted and has lower latency. It's not recommended to create SWAP partitions on OS disks or data disks that may impact the performance of the operating system and apps. It is important to remember that the resource disk should never be used to store data since it's only temporary storage. When a VM is moved to another host or stopped/deallocated, any data written to this disk will be wiped. The resource is only recommended to be used for data that can be removed such as SWAP and caching files. For more information, see [Temporary disk](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#temporary-disk).

## Disable SWAP creation in waagent configuration

If the SWAP creation is configured in waagent.config, you need to disable it.

1. Disable resource disk formatting and SWAP configuration within waagent configuration, as this task is now handled by Cloud-Init. Set the parameters as follows:

    ```Config
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
    size=`df -h --output=target, avail | grep -i ^\/mnt | awk '{print $2}' | cut -b1,2`
    swapsize=`echo "scale=0; ($size*0.3)/1" | bc`
    echo $swapsize
    dd if=/dev/zero of=/mnt/swapfile bs=1073741824 count=$swapsize
    chmod 0600 /mnt/swapfile
    mkswap /mnt/swapfile
    swapon /mnt/resource/swapfile
    swapon -a;
    ```

    The script will be executed on every boot and allocates 30% of the available space in the resource disk. You can customize the values based on your situation.

2. Make sure the file is executable.

    ```bash
    chmod +x /var/lib/cloud/scripts/per-boot/swap.sh
    ```

3.Stop and start the VM. This is only necessary the first time after you create the SWAP file.

## Create a SWAP file under a custom path

1. Create a file named 99-resource-disk.cfg under `/etc/cloud/cloud.cfg.d/`

    ```YAML
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
2.	Proceed with the same steps to create the script, but you should notice a different path. Instead of `/mnt`, we use `/azure/resource` as the custom path. You can change the path or SWAPsize based on your situation.

    ```bash
    #!/bin/sh
    size=`df -h --output=target, avail | grep -i azure\/resource | awk '{print $2}' | cut -b1,2`
    swapsize=`echo "scale=0; ($size*0.3)/1" | bc`
    echo $swapsize
    dd if=/dev/zero of=/azure/resource/swapfile bs=1073741824 count=$swapsize
    #fallocate --length $swapsizeGib /mnt/swapfile
    chmod 0600 /azure/resource/swapfile
    mkswap /azure/resource/swapfile
    swapon /azure/resource/swapfile
    swapon -a;
    ```
4.	Make sure the file is executable:

    ```bash
    chmod +x /var/lib/cloud/scripts/per-boot/swap.sh
    ```
5. Stop and start the VM. This is only necessary the first time after you create the SWAP file.