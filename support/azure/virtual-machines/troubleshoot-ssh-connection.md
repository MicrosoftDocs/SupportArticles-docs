---
title: Troubleshoot SSH connection issues to an Azure VM
description: How to troubleshoot issues such as 'SSH connection failed' or 'SSH connection refused' for an Azure VM running Linux.
keywords: ssh connection refused, ssh error, azure ssh, SSH connection failed
services: virtual-machines
ms.subservice: vm-cannot-connect
author: genlin
manager: dcscontentpm
tags: top-support-issue,azure-service-management,azure-resource-manager
ms.custom: devx-track-azurecli
ms.service: virtual-machines
ms.collection: linux
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.topic: troubleshooting
ms.date: 05/30/2017
ms.author: genli
---
# Troubleshoot SSH connections to an Azure Linux VM that fails, errors out, or is refused

This article helps you find and correct the problems that occur due to Secure Shell (SSH) errors, SSH connection failures, or SSH is refused when you try to connect to a Linux virtual machine (VM). You can use the Azure portal, Azure CLI, or VM Access Extension for Linux to troubleshoot and resolve connection problems.

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Quick troubleshooting steps

After each troubleshooting step, try reconnecting to the VM.

1. [Reset the SSH configuration](#reset-the-ssh-configuration).
2. [Reset the credentials](#reset-ssh-credentials-for-a-user) for the user.
3. Verify the [network security group](/azure/virtual-network/network-security-groups-overview) rules permit SSH traffic and role assignment.
   * Ensure that a [Network Security Group rule](#check-security-rules) exists to permit SSH traffic (by default, TCP port 22).
   * You cannot use port redirection / mapping without using an Azure load balancer.
   * If you are using Microsoft Entra ID to manage SSH logins, the user must be assigned the **Virtual Machine Administrator Login** or **Virtual Machine User Login** role on the resource group that contains the VM and its associated resources. Otherwise, the "Permission denied (publickey)" error will be received. For more information, see [Configure role assignments for the VM that uses Microsoft Entra login](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-linux#configure-role-assignments-for-the-vm).
4. Check the [VM resource health](/azure/service-health/resource-health-overview).
   * Ensure that the VM reports as being healthy.
   * If you have [boot diagnostics enabled](boot-diagnostics.md), verify the VM is not reporting boot errors in the logs.
5. [Restart the VM](#restart-a-vm).
6. [Redeploy the VM](#redeploy-a-vm).

Continue reading for more detailed troubleshooting steps and explanations.

## Available methods to troubleshoot SSH connection issues

You can reset credentials, SSH configuration, or troubleshoot the status of the SSH service by using one of the following methods:

* [Azure portal](#use-the-azure-portal) - great if you need to quickly reset the SSH configuration or SSH key and you don't have the Azure tools installed.
* [Azure VM Serial Console](./serial-console-linux.md) - the VM serial console will work regardless of the SSH configuration, and will provide you with an interactive console to your VM. In fact, "can't SSH" situations are specifically what the serial console was designed to help solve. More details below.
* [Use Run Command through Azure portal](#runcommand) - You can run basic commands by using the Run Command functionality through the Azure portal. The output will be returned to the portal.
* [Azure CLI](#use-the-azure-cli) - if you are already on the command line, quickly reset the SSH configuration or credentials. If you are working with a classic VM, you can use the [Azure classic CLI](#use-the-azure-classic-cli).
* [Azure VMAccessForLinux extension](#use-the-vmaccess-extension) - create and reuse json definition files to reset the SSH configuration or user credentials.

After each troubleshooting step, try connecting to your VM again. If you still cannot connect, try the next step.

## Use the Azure portal

The Azure portal provides a quick way to reset the SSH configuration or user credentials without installing any tools on your local computer.

To begin, select your VM in the Azure portal. Scroll down to the **Help** section and select **Reset password** as in the following example:

:::image type="content" source="media/troubleshoot-ssh-connection/reset-credentials-using-portal.png" alt-text="Screenshot to reset the S S H configuration or credentials in the Azure portal.":::

### Reset the SSH configuration

To reset the SSH configuration, select `Reset configuration only` in the **Mode** section as in the preceding screenshot, then select **Update**. Once this action has completed, try to access your VM again.

### Reset SSH credentials for a user

To reset the credentials of an existing user, select either `Reset SSH public key` or `Reset password` in the **Mode** section as in the preceding screenshot. Specify the username and an SSH key or new password, then select  **Update**.

You can also create a user with sudo privileges on the VM from this menu. Enter a new username and associated password or SSH key, and then select **Update**.

### Check security rules

Use [IP flow verify](/azure/network-watcher/diagnose-vm-network-traffic-filtering-problem) to confirm if a rule in a network security group is blocking traffic to or from a virtual machine. You can also review effective security group rules to ensure inbound "Allow" NSG rule exists and is prioritized for SSH port (default 22). For more information, see [Using effective security rules to troubleshoot VM traffic flow](/azure/virtual-network/diagnose-network-traffic-filter-problem).

### Check routing

Use Network Watcher's [Next hop](/azure/network-watcher/diagnose-vm-network-routing-problem) capability to confirm that a route isn't preventing traffic from being routed to or from a virtual machine. You can also review effective routes to see all effective routes for a network interface. For more information, see [Using effective routes to troubleshoot VM traffic flow](/azure/virtual-network/diagnose-network-routing-problem).

## Use the Azure VM Serial Console

The [Azure VM Serial Console](./serial-console-linux.md) provides access to a text-based console for Linux virtual machines. You can use the console to troubleshoot your SSH connection in an interactive shell. Ensure you have met the [prerequisites](./serial-console-linux.md#prerequisites) for using Serial Console and try the commands below to further troubleshoot your SSH connectivity.

### Check that SSH service is running

To check the service status, use the following command, which is available in most current Linux distributions:

```console
sudo systemctl status sshd.service
```

See the following output example. Check the service status from the `Active` line in the output. The output also shows the port and IP addresses being listened to.

```console
user@hostname:~$ sudo systemctl status sshd.service
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-06-23 17:44:36 UTC; 1 day 3h ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 829 (sshd)
      Tasks: 1 (limit: 9535)
     Memory: 5.1M
     CGroup: /system.slice/ssh.service
             └─829 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

Jun 23 17:44:35 ubu2004 systemd[1]: Starting OpenBSD Secure Shell server...
Jun 23 17:44:36 ubu2004 sshd[829]: Server listening on 0.0.0.0 port 22.
Jun 23 17:44:36 ubu2004 sshd[829]: Server listening on :: port 22.
Jun 23 17:44:36 ubu2004 systemd[1]: Started OpenBSD Secure Shell server.
```

If this command isn't available or returns unexpected results, use other available commands. You can use the `ss` command either as root or via the `sudo` command to verify whether the SSH service is running on your VM.

The following example shows how to run the `ss` command through `sudo`:

```console
sudo ss --listen --tcp --process --numeric | grep sshd
```

> [!NOTE]
> We recommend the `ss` command because the `netstat` command is deprecated and not always available in modern distributions.

If there is any output, SSH is up and running. See the following output example:

```console
$ sudo ss -ltpn | grep sshd
LISTEN    0         128                0.0.0.0:22               0.0.0.0:*        users:(("sshd",pid=829,fd=3))
LISTEN    0         128                   [::]:22                  [::]:*        users:(("sshd",pid=829,fd=4))
```

`-ltpn` is the shortened form of the `--listen --tcp --process –numeric` arguments. The output shows that the SSHD process 829 is listening on both IPv4 and IPv6 addresses.

### Check which port SSH is running on

The command output above shows that the SSHD process is listening on port 22. When the SSHD process is configured to run on another port, the port will be displayed in the output. To check if the change was made in the standard configuration file, examine the default configuration file, */etc/ssh/sshd_config* by using one of the following commands:

```console
grep -i port /etc/ssh/sshd_config
```

or

```console
grep -i listen /etc/ssh/sshd_config
```

The output will look like the following:

```output
Port 22
```

Any line that begins with `#` in the output is a comment and can be safely ignored. If nothing is returned, or the lines are comments, the default configuration is used. The default configuration is to listen to all IP addresses on the system, on port 22.

## <a id="runcommand">Use Run Command through Azure portal</a>

If you are not able to run commands through the Serial Console, for example when only SSH keys are used for authentication, the Run Command feature can be used to issue commands and view the output. All commands that were previously run from the Serial Console can be run non-interactively in the Run Command section in the Azure portal. The output will be returned to the Azure portal. There is no need to use `sudo` to run commands in the Run Command context.

## Use the Azure CLI

If you haven't already, install the latest [Azure CLI](/cli/azure/install-az-cli2) and sign in to an Azure account using [az login](/cli/azure/reference-index).

If you created and uploaded a custom Linux disk image, make sure the [Microsoft Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux) version 2.0.5 or later is installed. For VMs created using Gallery images, this access extension is already installed and configured for you.

### Reset SSH configuration

You can initially try resetting the SSH configuration to default values and rebooting the SSH server on the VM. This does not change the user account name, password, or SSH keys.
The following example uses [az vm user reset-ssh](/cli/azure/vm/user) to reset the SSH configuration on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
az vm user reset-ssh --resource-group myResourceGroup --name myVM
```

### Reset SSH credentials for a user

The following example uses [az vm user update](/cli/azure/vm/user) to reset the credentials for `myUsername` to the value specified in `myPassword`, on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
az vm user update --resource-group myResourceGroup --name myVM \
     --username myUsername --password myPassword
```

If using SSH key authentication, you can reset the SSH key for a given user. The following example uses **az vm access set-linux-user** to update the SSH key stored in `~/.ssh/id_rsa.pub` for the user named `myUsername`, on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
az vm user update --resource-group myResourceGroup --name myVM \
    --username myUsername --ssh-key-value ~/.ssh/id_rsa.pub
```

## Use the VMAccess extension

The VM Access Extension for Linux reads in a json file that defines actions to carry out. These actions include resetting SSHD, resetting an SSH key, or adding a user. You still use the Azure CLI to call the VMAccess extension, but you can reuse the json files across multiple VMs if desired. This approach allows you to create a repository of json files that can then be called for given scenarios.

### Reset SSHD

Create a file named `settings.json` with the following content:

```json
{
    "reset_ssh":True
}
```

Using the Azure CLI, you then call the `VMAccessForLinux` extension to reset your SSHD connection by specifying your json file. The following example uses [az vm extension set](/cli/azure/vm/extension) to reset SSHD on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
az vm extension set --resource-group philmea --vm-name Ubuntu \
    --name VMAccessForLinux --publisher Microsoft.OSTCExtensions --version 1.2 --settings settings.json
```

### Reset SSH credentials for a user

If SSHD appears to function correctly, you can reset the credentials for a giver user. To reset the password for a user, create a file named `settings.json`. The following example resets the credentials for `myUsername` to the value specified in `myPassword`. Enter the following lines into your `settings.json` file, using your own values:

```json
{
    "username":"myUsername", "password":"myPassword"
}
```

Or to reset the SSH key for a user, first create a file named `settings.json`. The following example resets the credentials for `myUsername` to the value specified in `myPassword`, on the VM named `myVM` in `myResourceGroup`. Enter the following lines into your `settings.json` file, using your own values:

```json
{
    "username":"myUsername", "ssh_key":"mySSHKey"
}
```

After creating your json file, use the Azure CLI to call the `VMAccessForLinux` extension to reset your SSH user credentials by specifying your json file. The following example resets credentials on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
az vm extension set --resource-group philmea --vm-name Ubuntu \
    --name VMAccessForLinux --publisher Microsoft.OSTCExtensions --version 1.2 --settings settings.json
```

## Use the Azure classic CLI

If you haven't already, [install the Azure classic CLI and connect to your Azure subscription](/cli/azure/install-classic-cli). Make sure that you are using Resource Manager mode as follows:

```azurecli
azure config mode arm
```

If you created and uploaded a custom Linux disk image, make sure the [Microsoft Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux) version 2.0.5 or later is installed. For VMs created using Gallery images, this access extension is already installed and configured for you.

### Reset SSH configuration

The SSHD configuration itself may be misconfigured or the service encountered an error. You can reset SSHD to make sure the SSH configuration itself is valid. Resetting SSHD should be the first troubleshooting step you take.

The following example resets SSHD on a VM named `myVM` in the resource group named `myResourceGroup`. Use your own VM and resource group names as follows:

```azurecli
azure vm reset-access --resource-group myResourceGroup --name myVM \
    --reset-ssh
```

### Reset SSH credentials for a user

If SSHD appears to function correctly, you can reset the password for a giver user. The following example resets the credentials for `myUsername` to the value specified in `myPassword`, on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
azure vm reset-access --resource-group myResourceGroup --name myVM \
     --user-name myUsername --password myPassword
```

If using SSH key authentication, you can reset the SSH key for a given user. The following example updates the SSH key stored in `~/.ssh/id_rsa.pub` for the user named `myUsername`, on the VM named `myVM` in `myResourceGroup`. Use your own values as follows:

```azurecli
azure vm reset-access --resource-group myResourceGroup --name myVM \
    --user-name myUsername --ssh-key-file ~/.ssh/id_rsa.pub
```

## Restart a VM

If you have reset the SSH configuration and user credentials, or encountered an error in doing so, you can try restarting the VM to address underlying compute issues.

### Azure portal

To restart a VM using the Azure portal, select your VM and then select **Restart** as in the following example:

:::image type="content" source="media/troubleshoot-ssh-connection/restart-vm-using-portal.png" alt-text="Screenshot to restart a virtual machine in the Azure portal.":::

### Azure CLI

The following example uses [az vm restart](/cli/azure/vm) to restart the VM named `myVM` in the resource group named `myResourceGroup`. Use your own values as follows:

```azurecli
az vm restart --resource-group myResourceGroup --name myVM
```

### Azure classic CLI

[!INCLUDE [classic-vm-deprecation](../../includes/azure/classic-vm-deprecation.md)]

The following example restarts the VM named `myVM` in the resource group named `myResourceGroup`. Use your own values as follows:

```console
azure vm restart --resource-group myResourceGroup --name myVM
```

## Redeploy a VM

You can redeploy a VM to another node within Azure, which may correct any underlying networking issues. For information about redeploying a VM, see [Redeploy virtual machine to new Azure node](./redeploy-to-new-node-windows.md?toc=/azure/virtual-machines/windows/toc.json).

> [!NOTE]
> After this operation finishes, ephemeral disk data is lost and dynamic IP addresses that are associated with the virtual machine are updated.
>
>

### Azure portal

To redeploy a VM using the Azure portal, select your VM and scroll down to the **Help** section. Select **Redeploy** as in the following example:

:::image type="content" source="media/troubleshoot-ssh-connection/redeploy-vm-using-portal.png" alt-text="Screenshot to redeploy a virtual machine in the Azure portal.":::

### Azure CLI

The following example use [az vm redeploy](/cli/azure/vm) to redeploy the VM named `myVM` in the resource group named `myResourceGroup`. Use your own values as follows:

```azurecli
az vm redeploy --resource-group myResourceGroup --name myVM
```

### Azure classic CLI

The following example redeploys the VM named `myVM` in the resource group named `myResourceGroup`. Use your own values as follows:

```console
azure vm redeploy --resource-group myResourceGroup --name myVM
```

## VMs created by using the Classic deployment model

[!INCLUDE [classic-vm-deprecation](../../includes/azure/classic-vm-deprecation.md)]

Try these steps to resolve the most common SSH connection failures for VMs that were created by using the classic deployment model. After each step, try reconnecting to the VM.

* Reset remote access from the [Azure portal](https://portal.azure.com). On the Azure portal, select your VM and then select **Reset Remote...**.
* Restart the VM. On the [Azure portal](https://portal.azure.com), select your VM and select **Restart**.

* Redeploy the VM to a new Azure node. For information about how to redeploy a VM, see [Redeploy virtual machine to new Azure node](./redeploy-to-new-node-windows.md?toc=/azure/virtual-machines/windows/toc.json).

    After this operation finishes, ephemeral disk data will be lost and dynamic IP addresses that are associated with the virtual machine will be updated.
* Follow the instructions in [How to reset a password or SSH for Linux-based virtual machines](/previous-versions/azure/virtual-machines/linux/classic/reset-access-classic) to:

  * Reset the password or SSH key.
  * Create a *sudo* user account.
  * Reset the SSH configuration.
* Check the VM's resource health for any platform issues.<br>
     Select your VM and scroll down **Settings** > **Check Health**.

## Additional resources

* If you are still unable to SSH to your VM after following the after steps, see [more detailed troubleshooting steps](detailed-troubleshoot-ssh-connection.md) to review additional steps to resolve your issue.
* For more information about troubleshooting application access, see [Troubleshoot access to an application running on an Azure virtual machine](./troubleshoot-app-connection.md?toc=/azure/virtual-machines/linux/toc.json)
* For more information about troubleshooting virtual machines that were created by using the classic deployment model, see [How to reset a password or SSH for Linux-based virtual machines](/previous-versions/azure/virtual-machines/linux/classic/reset-access-classic).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
