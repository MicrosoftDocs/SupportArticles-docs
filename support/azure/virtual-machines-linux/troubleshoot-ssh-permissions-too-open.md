---
title: Can’t SSH to Azure Linux VM because permissions are too open
description: Troubleshoot the permissions are too open error when you try to connect to Azure Linux VM
services: virtual-machines
author: genlin
manager: dcscontentpm
tags: 
ms.custom: linux-related-content
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.topic: troubleshooting
ms.date: 12/30/2021
ms.author: genli
---
# Can’t SSH to Azure Linux VM because permissions are too open

## Symptoms

You can't connect to your Microsoft Azure Linux virtual machine (VM) by using Secure Shell (SSH). You notice the following entries in the system log (/var/log/messages, /var/log/syslog, /var/log/secure, or /var/log/auth.log):

>sshd: error: Permissions 0777 for '/etc/ssh/sshKeyName' are too open.</br>
>sshd: error: It is required that your private key files are NOT accessible by others.</br>
>sshd: error: This private key will be ignored.</br>
>sshd: error: key_load_private: bad permissions</br>
>shd: error: Could not load host key: /etc/ssh/sshKeyName

## Cause

This issue might occur if the /etc/ssh configuration directory or the files in this directory are accessible by users other than the owner. This is usually caused by running a "chmod" command on the wrong directory or running a "chmod" command that has incorrect parameters.

## Resolution

To resolve the issue, restore the appropriate permissions to the configuration directory. To do this, follow the steps in the [online repair](#online-repair) section.
If you can't use the Run Command feature or the Azure Serial Console, go to the [Offline repair](#offline-repair) section.

### Online repair

**Run Command by using VM agent**

If the [VM agent](./windows-azure-guest-agent.md#step-1-check-whether-the-vm-is-started) is installed on the VM, you can use the **Run Command** feature to run the restoring script:

1. Sign in to the [Azure portal](https://portal.azure.com), and then go to the VM page.
1. In the **Operations** section, select **Run Command** > **RunScriptShell**, and then run the following script. Replace `<username>` with your user name.

    ``` bash
    chmod –R 644 /etc/ssh
    chmod 600 /etc/ssh/ssh_host*key
    chmod 600 /etc/ssh/sshd_config
    chmod 755 /home/<username>
    chmod 700 /home/<username>/.ssh
    chmod 600 /home/<username>/.ssh/authorized_keys
    cd /home
    chown <username> <username>
    ```

**Azure Serial Console**

1. Connect to the VM by using Azure Serial Console, and log on to your account.
1. Run the following command to restore the appropriate permissions to the configuration directory and the files. Replace `<username>` with your user name.

    ``` bash
    chmod –R 644 /etc/ssh
    chmod 600 /etc/ssh/ssh_host*key
    chmod 600 /etc/ssh/sshd_config
    chmod 755 /home/<username>
    chmod 700 /home/<username>/.ssh
    chmod 600 /home/<username>/.ssh/authorized_keys
    cd /home
    chown <username> <username>
    ```

1. Restart the sshd service, and try again to connect to the VM by using ssh.

    ```bash
    systemctl restart sshd
    ```

### Offline repair

If you can't access the VM by using the Azure Serial Console, then the repair must be done in offline mode because the VM isn't starting, or Serial Console is not enabled.

1. Follow steps 1-3 of the [VM Repair process](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM. The repair VM will mount a copy of the OS disk for the failed VM automatically.
1. Connect to the repair VM by using SSH.
1. Run `lsblk` to identify the root partition of the failed VM. Typically, the root partition is "sdc1."
1. Create a temporary mount point. For example, run the following command:

    ```bash
    mkdir /repair
    ```

1. Mount the root partition on the temporary mount point. For example, use `/dev/sdc1` in the following command:

    ```bash
    mount /dev/sdc1 /repair/
    ```

1. Restore the appropriate permissions to the configuration directory and files. Replace `<username>` with your user name.

    ```
    chmod –R 644 /repair/etc/ssh
    chmod 600 /repair/etc/ssh/ssh_host*key
    chmod 600 /repair/etc/ssh/sshd_config
    chmod 755 /home/<username>
    chmod 700 /home/<username>/.ssh
    chmod 600 /home/<username>/.ssh/authorized_keys
    cd /home
    chown <username> <username>
    ```

1. Unmount the boot partition:

    ```
    umount /repair
    ```

1. Use step 5 of the [VM Repair process](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to mount the repaired OS disk to the failed VM.
1. Start the failed VM, and try again to connect to the VM by using SSH.

## Next steps

If this article doesn't resolve your issue, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). You can post your issue in these forums, or post to [@AzureSupport on Twitter](https://twitter.com/AzureSupport).

You also can submit an Azure support request. To submit a support request, go to the [Azure support page](https://azure.microsoft.com/support/options/), and select **Get support**.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
