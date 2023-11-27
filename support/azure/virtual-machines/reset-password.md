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

## Reset the password by using the serial console with single user mode.

Use the [Serial Console](serial-console-linux.md) to reset either the `admin user` or `root` account through `single user mode` for VM access.

1. Follow the [single user mode](troubleshoot/azure/virtual-machines/serial-console-grub-single-user-mode) process to reset or add a password.

2. Make sure that password authentication is enabled on the OpenSSH server if you try to log in to the server by using SSH and password authentication.

    ```bash
    egrep "^PasswordAuthentication" /etc/ssh/sshd_config
    ```    

3. Create the new password for the `admin_user` or `root` by using the `passwd` command.

    ```bash
    passwd <admin_user>
    ```
4. Check if `SElinux` is in `enforcing` mode in `/etc/sysconfig/selinux`(If there was RHEL distributions).

    ```bash
    cat /etc/sysconfig/selinux
    ```
5. If `SElinux` is in enforcing mode, make sure SElinux allows the file changes we did with the `passwd` command. On the upcoming reboot, this action will notify SELinux that the filesystem has been modified (due to the changed password), facilitating the loading of the alteration.

    ```bash
    touch /.autorelabel
    ```
6. Reboot the VM

    ```bash
    /usr/sbin/reboot -f
    ```
7. Try to access the VM.


## Reset the password by using a repair VM

This method has been tested by using [the supported Linux distributions and versions](/azure/virtual-machines/linux/endorsed-distros).

> [!NOTE]
> If you are experiencing problems that affect an Azure network virtual appliance, this method does not apply to your situation. Instead, you must contact the vendor of the network virtual appliance to get instructions about how to do a password reset safely.

Use [vm repair](/cli/azure/vm/repair) commands to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using chroot.

> [!NOTE]
> Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

1. Run following [az vm repair create](/cli/azure/vm/repair) commands. This creates a copy of the OS disk, and attach the disk to a recovery VM automatically.

    ```
    AZ_RESOURCE_GROUP="YourResourceGroupName"
    AZ_VM_NAME="VMname"
    AZ_ADMIN_USER="userName"
    AZ_MSADMIN_PASS="newPassword"

    az vm repair create -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --repair-username $AZ_ADMIN_USER --repair-password "$AZ_MSADMIN_PASS" --verbose
    ```

2. Log in to the repair VM and follow the [Chroot Process](/troubleshoot/azure/virtual-machines/chroot-environment-linux)

3. Once the `chroot process` is done. Make sure that password authentication is enabled on the OpenSSH server if you try to log in to the server by using SSH and password authentication.

    ```bash
    egrep "^PasswordAuthentication" /etc/ssh/sshd_config
    ```    
4. Create the new password for the `admin_user` or `root` by using the `passwd` command.

    ```bash
    passwd <admin_user>
    ```
6. Check if `SElinux` is in `enforcing` mode in `/etc/sysconfig/selinux`(If there was RHEL distributions).

    ```bash
    cat /etc/sysconfig/selinux
    ```

7. If `selinux` is in enforcing mode, make sure SElinux allows the file changes we did with the `passwd` command. On the upcoming reboot, this action notifies SELinux that the filesystem has been modified (due to the changed password), facilitating the loading of the alteration.

    ```bash
    touch /.autorelabel
    ```

8. Exit the [chroot process](/troubleshoot/azure/virtual-machines/chroot-environment-linux).

9. Remount the OS disk to the affected VM by swapping the OS disks:

    ```
    az vm repair restore -g $AZ_RESOURCE_GROUP -n $AZ_VM_NAME --verbose
    ```
10. Try to access the VM.

## Next steps

* [Troubleshoot Azure VM by attaching OS disk to another Azure VM](https://social.technet.microsoft.com/wiki/contents/articles/18710.troubleshoot-azure-vm-by-attaching-os-disk-to-another-azure-vm.aspx)

* [Azure CLI: How to delete and redeploy a VM from VHD](/archive/blogs/linuxonazure/azure-cli-how-to-delete-and-re-deploy-a-vm-from-vhd)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
