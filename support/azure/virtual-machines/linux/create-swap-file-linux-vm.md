---
title: Create a SWAP file for an Azure Linux VM
description: Describes how to create a SWAP file for an Azure Linux VM.
ms.date: 10/12/2023
ms.service: virtual-machines
ms.subservice: vm-linux-setup-configuration
ms.custom: linux-related-content
ms.collection: linux
ms.author: mabicca
author: mabicca
ms.reviewer: v-weizhu
---

# Create a SWAP partition for an Azure Linux VM

To create a SWAP partition on Azure Linux VMs, you need to set up cloud-init to automatically create it on the ephemeral (resource) disk of the VM. The resource disk is mounted under `/mnt` by default. It's located on the physical server where the Linux VM is hosted and has lower latency. It isn't recommended to create SWAP partitions on OS disks or data disks that might impact the performance of the operating system and apps. It's important to remember that the resource disk should never be used to store regular data since it's only temporary storage. When a VM is moved to another host or stopped/deallocated, any data written to this disk will be wiped. It's recommended to use the resource disk only for data that can be removed such as SWAP and caching files. For more information, see [Temporary disk](/azure/virtual-machines/managed-disks-overview#temporary-disk).

## Disable SWAP creation in waagent configuration

If the SWAP creation is configured in */etc/waagent.conf*, you must disable it.

1. Disable resource disk formatting and SWAP configuration within /etc/waagent.conf, because this task is now handled by Cloud-Init. Set the parameters as follows:

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

## Create a SWAP partition

You can create a SWAP partition by using one of the following options.

> [!NOTE]
> When a SWAP partition is created, a swap file is also created on it.

<details>
<summary>Option 1: Create a SWAP partition under the resource or custom disk path by using scripts</summary>

1. Create a SWAP creation script named *swap.sh* under */var/lib/cloud/scripts/per-boot* with the following script:

    ```bash
    #!/bin/sh

    # Percent of space on the ephemeral disk to dedicate to swap. Here 30% is being used. Modify as appropriate.
    PCT=0.3

    # Location of the swap file. Modify as appropriate based on the location of the ephemeral disk.
    LOCATION=/mnt

    if [ ! -f ${LOCATION}/swapfile ]
    then
    
        # Get size of the ephemeral disk and multiply it by the percent of space to allocate
        size=$(/bin/df -m --output=target,avail | /usr/bin/awk -v percent="$PCT" -v pattern=${LOCATION} '$0 ~ pattern {SIZE=int($2*percent);print SIZE}')
        echo "$size MB of space allocated to swap file"

         # Create an empty file first and set correct permissions
        /bin/dd if=/dev/zero of=${LOCATION}/swapfile bs=1M count=$size
        /bin/chmod 0600 ${LOCATION}/swapfile

        # Make the file available to use as swap
        /sbin/mkswap ${LOCATION}/swapfile
    fi

    # Enable swap
    /sbin/swapon ${LOCATION}/swapfile
    /sbin/swapon -a

    # Display current swap status
    /sbin/swapon -s
    ```

    The script will be executed on every boot and allocates 30% of the available space in the resource disk. You can customize the values based on your situation.

1. Make the script executable:

    ```bash
    chmod +x /var/lib/cloud/scripts/per-boot/swap.sh
    ```

1. Stop and start the VM. Stopping and starting the VM is only necessary the first time after you create the SWAP file.
</details>

<details>
<summary>Option 2: Create a SWAP partition under the resource disk path by using cloud-init</summary>

1. Create the `CLOUD_CFG` variable in */systemd/system.conf* to set both SWAP and the resource disk:

    ```bash
    sudo echo 'DefaultEnvironment="CLOUD_CFG=/etc/cloud/cloud.cfg.d/00-azure-swap.cfg"' >> /etc/systemd/system.conf
    ```
2. Create a YAML file that sets SWAP, resource disk creation, and mount points:

    ```bash
    sudo cat > /etc/cloud/cloud.cfg.d/00-azure-swap.cfg << EOF
    #cloud-config
    disk_setup:
      ephemeral0:
        table_type: mbr
        layout: [66, [33, 82]]
        overwrite: True
    fs_setup:
      - device: ephemeral0.1
        filesystem: ext4
      - device: ephemeral0.2
        filesystem: swap
    mounts:
      - ["ephemeral0.1", "/mnt"]
      - ["ephemeral0.2", "none", "swap", "sw,nofail,x-systemd.requires=cloud-init.service,x-systemd.device-timeout=2", "0", "0"]
    EOF
    ```

3. Stop and start the VM or redeploy it to create the SWAP partition on the resource disk.
</details>

<details>
<summary>Option 3: Create a SWAP partition under the custom resource disk path by using cloud-init</summary>

1. Create the `CLOUD_CFG` variable in */systemd/system.conf* to set both SWAP and the resource disk:

    ```bash
    sudo echo 'DefaultEnvironment="CLOUD_CFG=/etc/cloud/cloud.cfg.d/00-azure-swap.cfg"' >> /etc/systemd/system.conf
    ```
2. Create a YAML file that sets SWAP, resource disk creation, and custom mount points ("azure" is an example):

    ```bash
    sudo cat > /etc/cloud/cloud.cfg.d/00-azure-swap.cfg << EOF
    #cloud-config
    disk_setup:
      ephemeral0:
        table_type: mbr
        layout: [66, [33, 82]]
        overwrite: True
    fs_setup:
      - device: ephemeral0.1
        filesystem: ext4
      - device: ephemeral0.2
        filesystem: swap
    mounts:
      - ["ephemeral0.1", "/azure"]
      - ["ephemeral0.2", "none", "swap", "sw,nofail,x-systemd.requires=cloud-init.service,x-systemd.device-timeout=2", "0", "0"]
    EOF
    ```
    > [!NOTE]
    > Make sure the custom mount point exists at the location specified in the YAML file.

3. Stop and start the VM or redeploy it to create the SWAP partition on the resource disk.

</details>

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
