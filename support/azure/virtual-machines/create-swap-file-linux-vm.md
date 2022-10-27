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

To create a SWAP file on Azure Linux VMs, you need to set up cloud-init to automatically create it on the ephemeral (resource) disk of the VM. The resource disk is mounted under `/mnt` by default. It’s located on the physical server where the Linux VM is hosted and has lower latency. It's not recommended to create SWAP partitions on OS disks or data disks that may impact the performance of the operating system and apps. It's also important to remember that SWAP or cache files are the only things we recommend using the resource disk for. This is because when a VM is stopped or moved to a different container or host, all data on the resource disk will be lost. So it's ideal for temporary caches and SWAP files.

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

1. Create a new file named SWAP.sh under `/var/lib/cloud/scripts/per-boot` with the following script:

    ```bash
    #!/bin/sh
    size=`df -h --output=target, avail | grep -i ^\/mnt | awk '{print $2}' | cut -b1,2`
    SWAPsize=`echo "scale=0; ($size*0.3)/1" | bc`
    echo $SWAPsize
    dd if=/dev/zero of=/mnt/SWAPfile bs=1073741824 count=$SWAPsize
    chmod 0600 /mnt/SWAPfile
    mkSWAP /mnt/SWAPfile
    SWAPon /mnt/resource/SWAPfile
    SWAPon -a;
    ```

    The script will be executed on every boot and allocates 30% of the available space in the resource disk. You can customize the values based on your situation.

2. Make sure the file is executable.

    ```bash
    chmod +x /var/lib/cloud/scripts/pert-boot/SWAP.sh
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
    SWAPsize=`echo "scale=0; ($size*0.3)/1" | bc`
    echo $SWAPsize
    dd if=/dev/zero of=/azure/resource/SWAPfile bs=1073741824 count=$SWAPsize
    #fallocate --length $SWAPsizeGib /mnt/SWAPfile
    chmod 0600 /azure/resource/SWAPfile
    mkSWAP /azure/resource/SWAPfile
    SWAPon /azure/resource/SWAPfile
    SWAPon -a
    ```
4.	Make sure the file is executable:

    ```bash
    chmod +x /var/lib/cloud/scripts/pert-boot/SWAP.sh
    ```
5. Stop and start the VM. This is only necessary the first time after you create the SWAP file.

