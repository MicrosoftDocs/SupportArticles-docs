---
title: Fail to connect to Azure Linux VM through SSH due to SELinux misconfiguration
description: Provides a solution to an issue where you fail to connect to an Azure virtual machine (VM) through Secure Shell (SSH) due to SELinux misconfiguration.
author: adelgadohell
ms.author: adelgadohell
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 01/31/2024
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.custom: linux-related-content
ms.collection: linux
---
# SSH connection to Azure Linux virtual machines fails due to SELinux misconfiguration

This article provides a solution to an issue where the Secure Shell (SSH) connection to an Azure virtual machine (VM) fails because of SELinux misconfiguration.

## Background

The Unix security model is based on Discretionary Access Control (DAC). Security-Enhanced Linux (SELinux) implements Mandatory Access Control (MAC) for Linux by using kernel modules and user space tools. MAC provides a more controlled environment for resource access and removes the ability of the root user to access all resources on the operating system (OS) without restrictions. It also mitigates multiple kinds of security risks by utilizing the traditional Unix security model.

Different distributions include SELinux out of the box or provide a straightforward way to activate kernel support and install user space tools. For more information, see the following SELinux articles from some of the major Linux providers:

* [Red Hat](https://www.redhat.com/en/topics/linux/what-is-selinux)
* SUSE
  * [SUSE Linux Enterprise Server 12](https://documentation.suse.com/sles/12-SP5/html/SLES-all/cha-selinux.html)
  * [SUSE Linux Enterprise Server 15](https://documentation.suse.com/sles/15-SP4/html/SLES-all/cha-selinux.html)
* [Debian](https://wiki.debian.org/SELinux)
* [CentOS](https://wiki.centos.org/HowTos/SELinux)

Red Hat-based images on Azure come with SELinux enabled; other distributions don't. When you use [SELinux in Ubuntu](https://wiki.ubuntu.com/SELinux), there's a warning about its unmaintained state on this distribution. Ubuntu implements a different solution for MAC, called [AppArmor](https://help.ubuntu.com/community/AppArmor).

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## Symptoms

A SELinux misconfiguration may result in the OS being unable to load the SELinux policy, which stops the OS from completing the boot.

Check the serial console from the Azure portal or through the Azure CLI. The following message appears near the end of the output:

:::image type="content" source="./media/linux-selinux-troubleshooting/error-message.png" alt-text="Screenshot that shows the 'Failed to load SELinux policy' error in the serial console log.":::

The SELinux configuration is managed by the system administrator. The system administrator can resolve this issue by using one of the following methods.

## <a id ="solution1"></a>Solution 1: Start VM with SELinux turned off by using serial console

1. Trigger **_Restart VM (Hard)_** from the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).
2. Interrupt your VM at the GRUB menu with the <kbd>ESC</kbd> key.
3. Select <kbd>E</kbd> to modify the first kernel entry in the GRUB menu.
4. Go to the `linux16` line and add `selinux=0` to disable SELinux temporarily.

    :::image type="content" source="media/linux-selinux-troubleshooting/disable-selinux-grub.gif" alt-text="Animated GIF that shows the process of interrupting boot at the GRUB menu level to disable SELinux temporarily.":::

5. Validate and correct the SELinux configuration in `/etc/selinux/config`.

    For example, one common mistake is setting the `SELINUXTYPE` key to one of the values used for the `SELINUX` key. See the following screenshot as an example:

    :::image type="content" source="./media/linux-selinux-troubleshooting/wrong-selinux-configuration.png" alt-text="Screenshot that shows the SELINUXTYPE key is incorrectly set to disabled.":::

    Notice the last line, `SELINUXTYPE=disabled`. The `SELINUXTYPE` key should be set to `targeted`, `minimum`, or `mls` rather than `disabled`. The following screenshot shows the correct configuration:

    :::image type="content" source="./media/linux-selinux-troubleshooting/correct-selinux-configuration.png" alt-text="Screenshot that shows the correct configuration of /etc/selinux/config.":::

## Solution 2: Repair SELinux misconfiguration by using a rescue VM

> [!TIP]
> If you have a recent backup of the VM, [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the configuration issue.

1. In case the [Azure serial console](serial-console-linux.md) doesn't work in the specific VM or isn't an option in your subscription, troubleshoot this issue by using a rescue/repair VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. Validate and correct the SELinux configuration in `/etc/selinux/config`. To do this, follow step 5 in [Solution 1: Start VM with SELinux turned off from serial console](#solution1).

3. After the SELinux configuration is corrected, perform the following actions:
    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue/repair VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

## Next steps

In case the issue isn't due to SELinux misconfiguration, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
