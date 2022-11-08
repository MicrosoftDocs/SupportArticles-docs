---
title: Can't connect a Linux VM using SSH connection
description: Resolves an issue in which SSH fails because the /var/empty/sshd file is not owned by the root directory and is not group or world-writable.
ms.date: 07/21/2020
ms.reviewer: vilibert, vilibert, ramakk
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
---
# Can't connect a Linux VM using SSH connection

This article provides a solution to an issue in which SSH fails because the /var/empty/sshd file is not owned by the root directory and is not group or world-writable.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4092816

Can't connect a Linux VM using SSH connection

## Symptoms

You cannot connect a Linux virtual machine (VM) by using a secure shell (SSH) connection. When this problem occurs, you may receive the following error message about the /var/empty/sshd file, depending on your Linux distribution.

**SuSE**

> /var/empty must be owned by root and not group or world-writable.  
startproc: exit status of parent of /usr/sbin/sshd: 255  
Failed

**CentOS**  

> Starting sshd: /var/empty/sshd must be owned by root and not group or world-writable.  
[FAILED]

## Cause

This problem may occur if the /var/empty/sshd file is not owned by the root directory and is not group-writable or world-writable.

## Resolution

To change the permissions on a Linux file if you don't have SSH access, use one of the following methods:

- [Azure portal](#azure-portal): Run a Linux custom script on the VM that issues the Linux chmod commands on the file that you have to change.
- [Manual attachment](#manually-attach-your-vmdisks-to-a-temporary-vm): Delete the VM, keep the disks, mount the system disk to another temporary VM, and then update the files on the temporary VM. Then, re-create the VM from the system disk.
- [CLI](#cli): Use the command-Line interface to run BASH commands on the VM.

### Azure portal

This method relies on the Azure Linux agent (WAgent).

Open the **Properties** window of the VM in the Azure portal to check the agent status. If the agent is enabled, follow these steps to change the permission:

1. Copy the following script to your local computer, and then rename the file to **update_perms.sh**.

    > [!NOTE]
    > You must update the script to reflect your system distribution. This script runs on Red Hat variants only.

    ```bash
    #!/bin/bash
    
    #Script to change permissions on a file
    ###################################################
    param=$1
    chmod 755 /var/empty/sshd;chown root:root /var/empty/sshd;service sshd restart
    ```

2. Go to the Azure portal, locate your VM settings, and then select **Extensions**  > **Add** > **Custom Script For Linux** > **Create**.
3. In **Script files**, upload the _update_perms.sh_ file, and then click **OK**.

    :::image type="content" source="media/connect-linux-vm-sshconnection/script-file.png" alt-text="Screenshot of uploading the update_perms.sh script." border="false":::

4. After the script is pushed to the VM, the **STATUS** value should be **Success**.

    :::image type="content" source="media/connect-linux-vm-sshconnection/success-status.png" alt-text="Screenshot shows a success status of the script." border="false":::

5. The **update_perms.sh** sample script changes the permissions on the /var/empty/sshd file from **777** to **755**  and sets the owner and group to **root:root**. Wait for script to run. This can take several minutes. The Linux Agent receives the request, and then it hands off to the correct extension.
If you can connect to the VM by using the SSH connection, and you want to see what occurred while the update_params.sh script ran, examine the _extension.log_ file in the `/var/log/azure/Microsoft.OSTCExtensions.CustomScriptForLinux/<version>` directory.

### Manually attach your VM disks to a temporary VM

Follow these steps:

1. Delete the VM, keep the disks, mount the system disk to another temporary VM, and then update the files (permissions and ownership) on the temporary VM.
2. Re-create the VM from disk.

For more information, see [CLI: How to delete and redeploy a VM from VHD (unmanaged disk)](/archive/blogs/linuxonazure/az-cli-how-to-delete-and-re-deploy-a-vm-from-vhd).

### CLI

Use the Command Line Interface (CLI) to inject commands into a VM. There are two versions of CLI. For more information, see [Use the Azure Custom Script Extension with Linux virtual machines](/azure/virtual-machines/linux/extensions-customscript).

The following example uses the newer CLI version 2. It resets the `/var/empty/sshd` file permissions and ownership by using the customScript extension through CLI. The sshd service is also restarted.

In this script, replace \<yourvm> with the actual name of the VM, and \<yourrg> with the actual name of the **Resource Group.**  

```azurecli
vmname=yourvm;rg=yourrg;timestamp=`date +%d%Y%H%M%S`;az vm extension set –resource-group $rg –vm-name $vmname –name customScript –publisher Microsoft.Azure.Extensions –settings "{'commandToExecute': 'bash -c \'chmod 755 /var/empty/sshd;chown root:root /var/empty/sshd;systemctl start sshd;ps -eaf | grep sshd\",'timestamp': "$((timestamp))"}"
```

### Serial Console

This feature lets you access the VM through a console as a physical server. This scheme allows you to modify files without using a custom script and without having to delete the VM.

:::image type="content" source="media/connect-linux-vm-sshconnection/serial-console.png" alt-text="Screenshot of resetting by using Serial Console." border="false":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
