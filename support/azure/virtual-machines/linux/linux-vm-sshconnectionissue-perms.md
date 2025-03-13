---
title: SSH connection to Azure Linux VM fails due to permission and ownership issues 
description: Resolves an issue in which the SSH service fails because the /var/empty/sshd, /var/lib/empty, or /var/run/sshd directory doesn't exist, or it isn't owned by the root user, or it's group-writable or world-writable.
ms.date: 03/13/2025
author: pagienge
ms.reviewer: divargas, adelgadohell, saimsh
ms.service: azure-virtual-machines
ms.custom: sap:Cannot connect to my VM, linux-related-content
ms.collection: linux
---

# Troubleshoot SSH connection issues in Azure Linux VM due to permission and ownership issues

**Applies to:** :heavy_check_mark: Linux VMs

This article provides solutions to an issue in which connecting to a Linux virtual machine (VM) via Secure Shell (SSH) fails because the _/var/empty/sshd_ directory in RHEL, the _/var/lib/empty_ directory in SUSE, or the _/var/run/sshd_ directory in Ubuntu, doesn't exist, or it isn't owned by the root user, or it's group-writable or world-writable.

## Symptoms

When you connect to a Linux virtual machine (VM) via SSH, the connection fails. You may receive the following error message about the affected directory, depending on your Linux distribution.

### [RHEL](#tab/rhelsymp)

```bash
sudo tail /var/log/messages
```

```output
sshd: /var/empty/sshd must be owned by root and not group or world-writable.  
```

### [SUSE](#tab/slessymp)

```bash
sudo tail /var/log/messages
```

```output
sshd[4022]: /var/lib/empty must be owned by root and not group or world-writable.
```

### [Ubuntu](#tab/ubuntusymp)

```bash
sudo tail /var/log/auth.log
```

```output
sshd[1850]: /var/run/sshd must be owned by root and not group or world-writable.
```

---

## Cause

This problem may occur if the affected directory isn't owned by the root user, or if it's group-writable or world-writable.

To resolve this issue, use one of the following resolutions:

- [Resolution 1: Repair the VM online.](#onlinetroubleshooting)
- [Resolution 2: Repair the VM offline.](#offlinetroubleshooting)

## <a id="onlinetroubleshooting"></a>Resolution 1: Repair the VM online

Here are two methods to repair the VM offline:

- [Use the Serial Console.](#onlinetroubleshooting-serialconsole)
- [Use the "Run Command" extension.](#onlinetroubleshooting-runcommand)

### <a id="onlinetroubleshooting-serialconsole"></a>Use the Serial Console

1. Connect to [the Serial Console](serial-console-linux.md) of the VM from Azure portal.
2. Sign in to the VM by using a local administrative account and its corresponding credential or password.
3. Run the following commands to resolve the permission and ownership issue:

   ### [RHEL](#tab/rhelts1)

   ```bash
   sudo mkdir -p /var/empty/sshd
   sudo chmod 755 /var/empty/sshd
   sudo chown root:root /var/empty/sshd
   ```

   ### [SUSE](#tab/slests1)

   ```bash
   sudo mkdir -p /var/lib/empty
   sudo chmod 755 /var/lib/empty
   sudo chown root:root /var/lib/empty
   ```

   ### [Ubuntu](#tab/ubuntuts1)

   ```bash
   sudo mkdir -p /var/run/sshd
   sudo chmod 755 /var/run/sshd
   sudo chown root:root /var/run/sshd
   ```

   ---

### <a id="onlinetroubleshooting-runcommand"></a>Use the "Run Command" extension

> [!NOTE]
> This method relies on the Azure Linux VM Agent (waagent). Therefore, make sure that the agent is installed in the VM and that its service is running.

In the Azure portal, open the **Properties** window of the VM to check the agent status. If the agent is enabled and has the **Ready** status, follow these steps to change the permission:

1. Go to the Azure portal, locate your VM settings, and then select **Run Command** under **Operations**.
2. Execute the following shell script by selecting **RunShellScript** > **Run**:

   ### [RHEL](#tab/rhelts2)

   ```bash
   #!/bin/bash

   #Script to change permissions on a file
   mkdir -p /var/empty/sshd;chmod 755 /var/empty/sshd;chown root:root /var/empty/sshd
   ```

   ### [SUSE](#tab/slests2)

   ```bash
   #!/bin/bash

   #Script to change permissions on a file
   mkdir -p /var/lib/empty;chmod 755 /var/lib/empty;chown root:root /var/lib/empty
   ```

   ### [Ubuntu](#tab/ubuntuts2)

   ```bash
   #!/bin/bash

   #Script to change permissions on a file
   mkdir -p /var/run/sshd;chmod 755 /var/run/sshd;chown root:root /var/run/sshd
   ```

   > [!NOTE]
   > In Ubuntu, the _/var/run/sshd_ directory runs in memory. Restarting the VM will also fix the issue.

   ---

3. After the script execution finishes, the output console window will show an "Enable succeeded" message.

If you can connect to the VM via SSH, and you want to analyze the details of the Run-command script execution, examine the _handler.log_ file in the _/var/log/azure/run-command_ directory.

## <a id="offlinetroubleshooting"></a>Resolution 2: Repair the VM offline

> [!NOTE]
> - Use this resolution if the VM serial console access isn't available and the waagent isn't ready.
> - In Ubuntu, the _/var/run/sshd_ directory runs in memory. Restarting the VM will also fix the issue. Therefore, offline troubleshooting in Ubuntu VMs isn't necessary.

Here are two methods to repair the VM offline:

- [Use az vm repair](#offlinetroubleshooting-repairvm)
- [Use the manual method.](#offlinetroubleshooting-manualvm)

### <a id="offlinetroubleshooting-repairvm"></a>Use az vm repair

The `az vm repair`, part of the vm-repair extension for the Azure CLI, is described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

Follow these steps to automate the manual offline process:

> [!Note]
> In the following steps, replace `$RGNAME`, `$VMNAME`, `$USERNAME`, `$PASSWORD`, and `repairdiskcopy` values accordingly.

1. Use the [az vm repair create](/cli/azure/vm/repair#az-vm-repair-create) command to create a repair VM. The repair VM has a copy of the OS disk for the problematic VM attached.

   ```azurecli
   az vm repair create --verbose -g $RGNAME -n $VMNAME --repair-username $USERNAME --repair-password $PASSWORD --copy-disk-name repairdiskcopy
   ```

2. Sign in to the repair VM. Mount and chroot to the filesystem of the attached copy of the OS disk. Follow the detailed [chroot instructions](chroot-environment-linux.md).

3. Run the following commands to resolve the permission and ownership issues:

   ### [RHEL](#tab/rhelts3)

   ```bash
   mkdir -p /var/empty/sshd
   chmod 755 /var/empty/sshd
   chown root:root /var/empty/sshd
   ```

   ### [SUSE](#tab/slests3)

   ```bash
   mkdir -p /var/lib/empty
   chmod 755 /var/lib/empty
   chown root:root /var/lib/empty
   ```
   
   ### [Ubuntu](#tab/ubuntuts3)

   ```bash
   mkdir -p /var/run/sshd
   chmod 755 /var/run/sshd
   chown root:root /var/run/sshd
   ```
   ---

4. Once the changes are applied, run the following `az vm repair restore` command to perform an automatic OS disk swap with the original VM.

   ```azurecli
   az vm repair restore --verbose -g $RGNAME -n $VMNAME
   ```

### <a id="offlinetroubleshooting-manualvm"></a>Use the manual method

If both the serial console and `az vm repair` approach don't apply to you or fail, the repair has to be performed manually. Follow the steps below to manually attach the OS disk to a recovery VM and swap the OS disk back to the original VM:

- [Attach the OS disk to a recovery VM using the Azure portal.](troubleshoot-recovery-disks-portal-linux.md)
- [Attach the OS disk to a recovery VM using Azure CLI.](troubleshoot-recovery-disks-linux.md)

Once the OS disk is successfully attached to the recovery VM, follow the detailed [chroot instructions](chroot-environment-linux.md) to mount and chroot to the filesystems of the attached OS disk. Then, follow step 3 in the [Use az vm repair](#offlinetroubleshooting-repairvm) section to resolve the permission and ownership issues.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
