---
title: How to reset local Linux password on Azure VMs
description: Provides the steps to reset the local Linux password on Azure VMs.
services: virtual-machines
documentationcenter: ''
manager: dcscontentpm
editor: 'v-jesits'
tags: ''
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.topic: how-to
ms.date: 11/30/2023
ms.reviewer: v-six
---

# How to reset a local Linux password on Azure VMs

This article provides three methods to reset local Linux Virtual Machine (VM) passwords. If the user account is expired or you want to create a new account, you can use the following methods to create a new local admin account and regain access to the VM.

## Reset the password by using Azure Linux Agent

You can reset the password without attaching the OS disk to another VM. This method requires that the [Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux) be installed on the affected VM.

1. Make sure that the Azure Linux Agent (waagent) service is running on the affected VM and is in a ready state in the Azure portal.

2. Set up the environment variables, and use the Azure CLI or Azure Cloud Shell to do the password reset:

    ```azurecli
    AZ_RESOURCE_GROUP="YourResourceGroupName"
    AZ_VM_NAME="VMname"
    AZ_ADMIN_USER="adminName"
    AZ_MSADMIN_PASS="newPassword"

    az vm user update -u $AZ_ADMIN_USER -p $AZ_MSADMIN_PASS -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME
    ```

3. Try to access the VM.

To update the SSH key, see [Manage administrative users, SSH by using the VMAccess Extension with the Azure CLI](/azure/virtual-machines/extensions/vmaccess#update-ssh-key).

You can also reset the password or SSH key by using the **Reset Password** feature in the Azure portal.

For more information, see [vmaccess extension for Linux](/azure/virtual-machines/extensions/vmaccess).

## Reset the password by using the serial console with single-user mode

You can use the [serial console](serial-console-linux.md) to reset the `admin user` or `root` account through single-user mode for VM access.

1. Follow the [single-user mode](serial-console-grub-single-user-mode.md) process to reset or add a password.

2. Make sure that password authentication is enabled on the OpenSSH server if you try to log in to the server by using the SSH and password authentication.

    1. Check whether the `PasswordAuthentitcation` value is set to `yes` or `no` in `/etc/ssh/sshd_config` by running the following command:

        ```bash
        egrep "^PasswordAuthentication" /etc/ssh/sshd_config
        ```

    1. If the `PasswordAuthentication` value is set to `no`, use a text editor such as `vi` or `nano` to change the value to `yes`.

3. Create a new password for the `admin user` or `root` account by running the `passwd` command:

    ```bash
    passwd <admin_user>
    ```

4. Check whether `SElinux` is in `enforcing` mode in `/etc/sysconfig/selinux` by running the following command:

    ```bash
    cat /etc/sysconfig/selinux
    ```

5. If `SElinux` is in `enforcing` mode, make sure that `SElinux` allows the file changes made with the `passwd` command. After the password is changed, you can run the following command to relabel the file system to facilitate the loading of the alteration.

    ```bash
    touch /.autorelabel
    ```

6. Reboot the VM by running the following command:

    ```bash
    /usr/sbin/reboot -f
    ```

7. Try to access the VM.

## Reset the password by using a repair VM

This method has been tested by using [the supported Linux distributions and versions](/azure/virtual-machines/linux/endorsed-distros).

> [!NOTE]
> If you're experiencing problems that affect an Azure network virtual appliance, this method doesn't apply to your situation. Instead, you must contact the vendor of the network virtual appliance to get instructions about how to do a password reset safely.

You can run the [vm repair](/cli/azure/vm/repair) commands to create a repair VM that has a copy of the affected VM's OS disk attached. Then, mount the copy of the OS file systems on the repair VM via the [chroot environment](chroot-environment-linux.md).

> [!NOTE]
> Alternatively, create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

1. Run the following [az vm repair create](/cli/azure/vm/repair) commands to create a copy of the OS disk. Then, the disk is attached to a recovery VM automatically.

    ```azurecli
    AZ_RESOURCE_GROUP="YourResourceGroupName"
    AZ_VM_NAME="VMname"
    AZ_ADMIN_USER="userName"
    AZ_MSADMIN_PASS="newPassword"

    az vm repair create -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --repair-username $AZ_ADMIN_USER --repair-password "$AZ_MSADMIN_PASS" --verbose
    ```

2. Log in to the repair VM and [troubleshoot the chroot environment](chroot-environment-linux.md).

3. Make sure that password authentication is enabled on the OpenSSH server if you try to log in to the server by using the SSH and password authentication.

    1. Check whether the `PasswordAuthentitcation` value is set to `yes` or `no` in `/etc/ssh/sshd_config` by running the following command:

        ```bash
        egrep "^PasswordAuthentication" /etc/ssh/sshd_config
        ```

    1. If the `PasswordAuthentication` value is set to `no`, use a text editor such as `vi` or `nano` to change the value to `yes`.

4. Create a new password for the `admin user` or `root` account by running the `passwd` command:

    ```bash
    passwd <admin_user>
    ```

5. Check whether `SElinux` is in `enforcing` mode in `/etc/sysconfig/selinux` by running the following command:

    ```bash
    cat /etc/sysconfig/selinux
    ```

6. If `SElinux` is in `enforcing` mode, make sure that `SElinux` allows the file changes made with the `passwd` command. After the password is changed, you can run the following command to relabel the file system to facilitate the loading of the alteration.

    ```bash
    touch /.autorelabel
    ```

7. Exit the [chroot environment](chroot-environment-linux.md).

8. Remount the OS disk to the affected VM by swapping the OS disk with the following command:

    ```azurecli
    az vm repair restore -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --verbose
    ```

9. Try to access the VM.

## Next steps

* [Troubleshoot Azure VM by attaching OS disk to another Azure VM](https://social.technet.microsoft.com/wiki/contents/articles/18710.troubleshoot-azure-vm-by-attaching-os-disk-to-another-azure-vm.aspx)

* [Azure CLI: How to delete and redeploy a VM from VHD](/archive/blogs/linuxonazure/azure-cli-how-to-delete-and-re-deploy-a-vm-from-vhd)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
