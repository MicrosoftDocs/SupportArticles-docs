---
title: Troubleshoot SSH connection issues in Linux VM due to permission and ownership issues 
description: Resolves an issue in which SSH fails because the /var/empty/sshd, or /var/lib/empty, or /var/run/sshd directory isn't owned by the root user, or is group- or world-writable.
ms.date: 05/15/2023
author: saimsh-msft
ms.reviewer: divargas, adelgadohell
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
---

# Troubleshoot SSH connection issues in Linux VM due to permission and ownership issues

This article provides a solution to an issue in which SSH service fails because the _/var/empty/sshd_ directory in RHEL systems, the _/var/lib/empty_ in SUSE, or the _/var/run/sshd_, isn't owned by the root user, or is group- or world-writable.

## Symptoms

You can't connect a Linux virtual machine (VM) by using a secure shell (SSH) connection due to permission and ownership issues. When this problem occurs, you may receive the following error message about the affected directory.

### [CentOS/RHEL](#tab/rhelsymp)

```bash
sudo tail /var/log/messages
```

```output
Starting sshd: /var/empty/sshd must be owned by root and not group or world-writable.  
[FAILED]
```

### [SUSE](#tab/slessymp)

```bash
sudo tail /var/log/messages
```

```output
sshd[4022]: fatal: /var/lib/empty must be owned by root and not group or world-writable.
```

### [Ubuntu](#tab/ubuntusymp)

```bash
sudo tail /var/log/auth.log
```

```output
sshd[1850]: fatal: /run/sshd must be owned by root and not group or world-writable.
```

---

## Cause

This problem may occur if the affected directory isn't owned by the root user, or is group- or world-writable.

## Resolution

There are two ways to resolve the issue:

* Repair the VM online
  * [Serial Console](#onlinetroubleshooting-serialconsole)
  * [Run Command Extension](#onlinetroubleshooting-runcommand)
* Repair the VM offline
  * [Use Azure Linux Auto Repair (ALAR)](#offlinetroubleshooting-repairvm)
  * [Use Manual Method](#offlinetroubleshooting-manualvm)

### <a id="onlinetroubleshooting"></a>Repair the VM online

#### <a id="onlinetroubleshooting-serialconsole"></a>Serial Console

1. Connect to [the serial console](./serial-console-linux.md) of the VM from Azure portal.
2. Login to the VM using local administrative account and its corresponding credential/password.
3. Run the following commands to resolve the permission and ownership issue:

#### [RHEL/CentOS](#tab/rhelts1)

```bash
sudo chmod 755 /var/empty/sshd
sudo chown root:root /var/empty/sshd
```

#### [SUSE](#tab/slests1)

```bash
sudo chmod 755 /var/lib/empty
sudo chown root:root /var/lib/empty
```

#### [Ubuntu](#tab/ubuntuts1)

```bash
sudo chmod 755 /var/run/sshd
sudo chown root:root /var/run/sshd
```

---

#### <a id="onlinetroubleshooting-runcommand"></a>Run Command Extension

This method relies on the Azure Linux agent (WAagent). It's required that the VM has the agent installed and service running.

Open the **Properties** window of the VM in the Azure portal to check the agent status. If the agent is enabled and has "Ready" status, follow these steps to change the permission:

1. Go to the Azure portal, locate your VM settings, and then select **Run Command**  under **Operations** section.
2. Next, select **RunShellScript** and **Run** the following shell script:

#### [RHEL/CentOS](#tab/rhelts2)

```bash
#!/bin/bash
    
#Script to change permissions on a file
chmod 755 /var/empty/sshd;chown root:root /var/empty/sshd
```

#### [SUSE](#tab/slests2)

```bash
#!/bin/bash
    
#Script to change permissions on a file
chmod 755 /var/lib/empty;chown root:root /var/lib/empty
```

#### [Ubuntu](#tab/ubuntuts2)

```bash
#!/bin/bash
    
#Script to change permissions on a file
chmod 755 /var/run/sshd;chown root:root /var/run/sshd
```

> [!NOTE]
> In the case of Ubuntu systems, the _/var/run/sshd_ runs in memory. Restarting the VM will also fix the issue, so the offline troubleshooting in Ubuntu VMs isn't necessary.

---

3. After the script execution is completed, the output console window will provide `Enable succeeded` message.

If you can connect to the VM by using the SSH connection, and you want to analyze the details of the Run-command script execution, examine the _handler.log_ file inside the _/var/log/azure/run-command_ directory.

### <a id="offlinetroubleshooting"></a>Repair the VM offline

If the VM serial console access isn't available and the Waagent isn't ready, an alternative solution is to repair the vm offline. There are two ways to take an offline approach.

> [!NOTE]
> In the case of Ubuntu systems, the _/var/run/sshd_ runs in memory. Restarting the VM will also fix the issue, so the offline troubleshooting in Ubuntu VMs isn't necessary.

#### <a id="offlinetroubleshooting-repairvm"></a>Use Azure Linux Auto Repair (ALAR)

Azure Linux Auto Repair (ALAR) scripts are a part of VM repair extension described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](./repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
Implement the following steps to automate the manual offline process:

1. Use the [az vm repair create](/cli/azure/vm/repair#az-vm-repair-create) command to create a repair VM. The repair VM has a copy of the OS disk for the problematic VM attached. Replace `$RGNAME`, `$VMNAME`, `$USERNAME` and `$PASSWORD` values accordingly.

```azurecli-interactive
az vm repair create --verbose -g $RGNAME -n $VMNAME --repair-username $USERNAME --repair-password '$PASSWORD' --copy-disk-name  repairdiskcopy
 ```

2. Login to the repair vm. Mount and chroot to the filesystem of the attached copy of OS disk. Follow the detailed [chroot instructions](./chroot-environment-linux.md).
3. Next, follow the same steps to resolve the permission and ownership issue:

#### [RHEL/CentOS](#tab/rhelts3)

```bash
chmod 755 /var/empty/sshd
chown root:root /var/empty/sshd
```

#### [SUSE](#tab/slests3)

```bash
chmod 755 /var/lib/empty
chown root:root /var/lib/empty
```

---

4. Once the changes are applied, `az vm repair restore` command can be used to perform automatic OS disk swap with the original VM as shown in the following command. Replace `$RGNAME` and `$VMNAME` values accordingly.

```azurecli-interactive
az vm repair restore --verbose -g $RGNAME -n $VMNAME
 ```

> [!Note]
>The resource group name `"$RGNAME`, vm name `"$VMNAME"`, and `--copy-disk-name "repairdiskcopy"` are examples and the values need to change accordingly.

#### <a id="offlinetroubleshooting-manualvm"></a>Use Manual Method

If both serial console and ALAR approach aren't possible or fails, the repair has to be performed manually. Follow the steps here to manually attach the OS disk to a recovery VM and swap the OS disk back to the original VM:

* [Attach the OS disk to a recovery VM using the Azure portal](./troubleshoot-recovery-disks-portal-linux.md)
* [Attach the OS disk to a recovery VM using Azure CLI](./troubleshoot-recovery-disks-linux.md)

Once the OS disk is successfully attached to the recovery VM, follow the detailed [chroot instructions](./chroot-environment-linux.md) to mount and chroot to the filesystems of the attached OS disk. Then, follow step 3 from the [previous section](#offlinetroubleshooting-repairvm) to resolve permission and ownership issues.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
