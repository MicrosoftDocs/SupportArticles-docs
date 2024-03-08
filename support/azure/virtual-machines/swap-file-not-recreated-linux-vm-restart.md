---
title: Swap file isn't re-created after a Linux VM restarts
description: Describes how to resolve the problem that prevents a swap file from being re-created after a restart of a Linux virtual machine.
ms.date: 12/09/2021
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
ms.author: srijangupta
author: srijang
ms.reviewer: danis
---
# Swap file isn't  re-created after a Linux VM restarts

This article provides a resolution to an issue in which the swap file can't be re-created after a restart of a Linux virtual machine.

_Original product version:_ &nbsp; Azure, Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4577868

## Symptoms

On Linux virtual machines (VMs) that are provisioned by [cloud-init](/azure/virtual-machines/linux/using-cloud-init) and that have the [Microsoft Azure Linux Agent (waagent)](/azure/virtual-machines/linux/using-cloud-init#what-is-the-difference-between-cloud-init-and-the-linux-agent-wala) installed, you may discover that the swap file isn't re-created after a restart.

## Cause

This problem occurs because of a misconfiguration that causes both the Azure Linux Agent and cloud-init to try to configure the swap file.
When cloud-init is responsible for provisioning, the swap file must be configured by cloud-init to enable only one agent (either cloud-init or waagent) for provisioning. This issue can be intermittent because of the timing of when the waagent daemons start.

## Resolution

To resolve this problem, follow these steps:

1. Disable resource disk formatting and swap configuration within waagent configuration because this task is now handled by Cloud-Init. Set the parameters as follows:

    ```
    # Format if unformatted. If 'n', resource disk will not be mounted.
    ResourceDisk.Format=n

    # Create and use swapfile on resource disk.
    ResourceDisk.EnableSwap=n

    #Mount point for the resource disk
    ResourceDisk.MountPoint=/mnt
  
    #Size of the swapfile.
    ResourceDisk.SwapSizeMB=0
    ```

1. Restart the Azure Linux Agent. See [How to update the Azure Linux Agent on a VM](/azure/virtual-machines/extensions/update-linux-agent) for information about the restart commands for different Linux distributions.
1. Make sure that the VM is configured to create a swap file by using cloud-init:
  
    1. Create a script `/var/lib/cloud/scripts/per-boot/create_swapfile.sh` with the following commands:

        ```bash
        #!/bin/sh
        if [ ! -f '/mnt/swapfile' ]; then
        fallocate --length 2GiB /mnt/swapfile
        chmod 600 /mnt/swapfile
        mkswap /mnt/swapfile
        swapon /mnt/swapfile
        swapon -a 
        else
        swapon /mnt/swapfile; fi
        ```

        In some cases, the `fallocate` command won't create a swap file properly. If a swap file isn't created properly, you can use the alternate script below:

        ```
        dd if=/dev/zero of=/mnt/swapfile bs=1M count=2048
        ```

    1. Make the file executable by using the `# chmod +x create_swapfile.sh` command.
    1. Stop and Start the VM or Redeploy it from the portal, and check for swap enablement.
        Here is an example of how to enable the swap capability:

        ```
        root@ub1804-ephemeral:/var/lib/cloud/scripts/per-boot# free -m 
        total used free shared buff/cache available 
        Mem: 7953 296 7384 0 272 7412 
        Swap: 2047 0 2047
        ```

To isolate the issue, compare the logs from `/var/log/waagent.log` and `/var/log/cloud-init.log` for the reboot timeframe.

## Recommended fix

To avoid this situation completely, deploy the VM by using the swap configuration custom data during provisioning.

## Use cloud-init to configure a swap partition on a Linux VM

This article shows you how to use [cloud-init](https://cloudinit.readthedocs.io) to configure the swap partition on various Linux distributions. The swap partition was traditionally configured by the Linux Agent (WALA) based on which distributions required one.  This document will outline the process for building the swap partition on demand during provisioning time using cloud-init.  For more information about how cloud-init works natively in Azure and the supported Linux distros, see [cloud-init overview](/azure/virtual-machines/linux/using-cloud-init)

## Create swap partition for Ubuntu based images

By default on Azure, Ubuntu gallery images do not create swap partitions. To enable swap partition configuration during VM provisioning time using cloud-init - please see the [AzureSwapPartitions document](https://wiki.ubuntu.com/AzureSwapPartitions) on the Ubuntu wiki.

## Create swap partition for Red Hat and CentOS based images

Create a file in your current shell named _cloud_init_swappart.txt_ and paste the following configuration. For this example, create the file in the Cloud Shell not on your local machine. You can use any editor you wish. Enter `sensible-editor cloud_init_swappart.txt` to create the file and see a list of available editors. Choose #1 to use the **nano** editor. Make sure that the whole cloud-init file is copied correctly, especially the first line.  

```yaml
#cloud-config
disk_setup:
  ephemeral0:
    table_type: gpt
    layout: [66, [33,82]]
    overwrite: true
fs_setup:
  - device: ephemeral0.1
    filesystem: ext4
  - device: ephemeral0.2
    filesystem: swap
mounts:
  - ["ephemeral0.1", "/mnt"]
  - ["ephemeral0.2", "none", "swap", "sw,nofail,x-systemd.requires=cloud-init.service,x-systemd.device-timeout=2", "0", "0"]
```

The mount is created with the `nofail` option to ensure that the boot will continue even if the mount isn't completed successfully.

Before deploying this image, you need to create a resource group with the [az group create](/cli/azure/group) command. An Azure resource group is a logical container into which Azure resources are deployed and managed. The following example creates a resource group named _myResourceGroup_ in the _eastus_ location.

```azurecli-interactive
az group create --name myResourceGroup --location eastus
```

Now, create a VM with [az vm create](/cli/azure/vm) and specify the cloud-init file with `--custom-data cloud_init_swappart.txt` as follows:

```azurecli-interactive
az vm create \
  --resource-group myResourceGroup \
  --name centos74 \
  --image OpenLogic:CentOS:7-CI:latest \
  --custom-data cloud_init_swappart.txt \
  --generate-ssh-keys 
```

## Verify swap partition was created

SSH to the public IP address of your VM shown in the output from the preceding command. Enter your own **publicIpAddress** as follows:

```bash
ssh <publicIpAddress>
```

Once you have SSH'ed into the vm, check if the swap partition was created

```bash
swapon -s
```

The output from this command should look like this:

```output
Filename                Type        Size    Used    Priority
/dev/sdb2  partition   2494440 0   -1
```

> [!NOTE]
> If you have an existing Azure image that has a swap partition configured and you want to change the swap partition configuration for new images, you should remove the existing swap partition. For more information, see [Customize Images to provision by cloud-init](/azure/virtual-machines/linux/tutorial-automate-vm-deployment).

## Next steps

For additional cloud-init examples of configuration changes, see the following:

- [Add an additional Linux user to a VM](/azure/virtual-machines/linux/cloudinit-add-user)
- [Run a package manager to update existing packages on first boot](/azure/virtual-machines/linux/cloudinit-update-vm)
- [Change VM local hostname](/azure/virtual-machines/linux/cloudinit-update-vm-hostname)
- [Install an application package, update configuration files and inject keys](/azure/virtual-machines/linux/tutorial-automate-vm-deployment)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
