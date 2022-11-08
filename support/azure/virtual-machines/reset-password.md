---
title: How to reset local Linux password on Azure VMs
description: Provides the steps to reset the local Linux password on Azure VM
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
editor: 'v-jesits'
tags: ''
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.topic: troubleshooting
ms.date: 08/23/2021
ms.author: genli

---

# How to reset a local Linux password on Azure VMs

This article provides two methods to reset local Linux Virtual Machine (VM) passwords. If the user account is expired or you want to create a new account, you can use the following methods to create a new local admin account and regain access to the VM.

## Reset the password by using Azure Linux Agent

You can reset the password without attaching the OS disk to another VM. This method requires that the [Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux) be installed on the affected VM.

1. Make sure that the Azure Linux Agent (waagent) service is running on the affected VM.

2. Set up the environment variables, and use the Azure CLI or Azure Cloud Shell to do the password reset:

    ```
    AZ_RESOURCE_GROUP="YourResourceGroupName"
    AZ_VM_NAME="VMname"
    AZ_ADMIN_USER="adminName"
    AZ_MSADMIN_PASS="newPassword"

    az vm user update -u $AZ_ADMIN_USER -p $AZ_MSADMIN_PASS -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME
    ```

3. Try to access the VM.

To update the SSH key, see [Manage administrative users, SSH by using the VMAccess Extension with the Azure CLI](/azure/virtual-machines/extensions/vmaccess#update-ssh-key).

You can also reset the password or SSH key by using the **Reset Password** feature in the Azure portal.

## Reset the password by using a recovery VM

This method has been tested by using [the supported Linux distributions and versions](/azure/virtual-machines/linux/endorsed-distros).

> [!NOTE]
> If you are experiencing problems that affect an Azure network virtual appliance, this method does not apply to your situation. Instead, you must contact the vendor of the network virtual appliance to get instructions about how to do a password reset safely.

1. Take a snapshot of the OS disk of the affected VM as a backup. For more information, see [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).
1. Run following [az vm repair create](/cli/azure/vm/repair) commands. This will create a copy of the OS disk, and attach the disk to a recovery VM automatically.

    ```
    AZ_RESOURCE_GROUP="YourResourceGroupName"
    AZ_VM_NAME="VMname"
    AZ_ADMIN_USER="userName"
    AZ_MSADMIN_PASS="newPassword"

    az vm repair create -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --repair-username $AZ_ADMIN_USER --repair-password "$AZ_MSADMIN_PASS" --verbose
    ```

1. Log in to the recovery VM. Mount the root file system on the data disk on /recovery, and set the password field a blank state.

    ```
    # You have to run the following commands as the root user.

    sudo -i

    # Identify the device name of the data disk that's attached to the VM.

    lsblk

    # Mount the OS disk that's attached as a data disk to the recovery VM. 

    mkdir /recovery
    mount /dev/sdc1 /recovery

    # [OPTIONAL] If the output from lsblk shows that the root file system is located on a logical volume, then you have to mount that logical volume instead.

    mount /dev/rootvg/rootlv /recovery

    # Make sure that password authentication is enabled on the OpenSSH server if you will try to log in to the server by using SSH and password authentication.

    egrep "^PasswordAuthentication" /recovery/etc/ssh/sshd_config

    # Enter the user name. It can be "root" or the name of the admin user.

    USER_NAME="root"

    # Make a backup of the current /recovery/etc/shadow file.

    cp -av /recovery/etc/shadow /recovery/etc/shadow.$( date '+%Y.%m.%d_%H.%M.%S' )

    # Remove the root password from the /recovery/etc/shadow file.

    sed -r -i.azbackup "s/${USER_NAME}\:[^\:]*/${USER_NAME}\:/g" /recovery/etc/shadow

    # Compare the differences between the password files.

    diff /recovery/etc/shadow /recovery/etc/shadow.azbackup

    # Make sure that you sync any pending I/O operations on the file system.

    sync 

    # Unmount the root file system before you remove the disk.
    umount /recovery
    ```

1. Remount the OS disk to the affected VM by swapping the OS disks:

    ```
    az vm repair restore -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --verbose
    ```

1. Log in to the server from the serial console or by using SSH and the user account for which the password field was reset to a blank state.. When the system asks for the user password, press **Enter** to log in to the system. If the serial console is not enabled on the VM, you will have to attach a storage account to it in order to enable boot diagnostics.

1. Use the `passwd` command to set up a new password for the user account intermediately.

1. Access the server by using SSH, and enter the new password that you set up from the serial console.

## Next steps

* [Troubleshoot Azure VM by attaching OS disk to another Azure VM](https://social.technet.microsoft.com/wiki/contents/articles/18710.troubleshoot-azure-vm-by-attaching-os-disk-to-another-azure-vm.aspx)

* [Azure CLI: How to delete and redeploy a VM from VHD](/archive/blogs/linuxonazure/azure-cli-how-to-delete-and-re-deploy-a-vm-from-vhd)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
