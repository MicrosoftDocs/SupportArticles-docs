---
title: Troubleshooting SSH connection issues on Azure caused by SELinux
description: Discusses multiple SELinux related scenarios that prevent users from connecting to their VM.
author: adelgadohell
ms.author: adelgadohell
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 10/11/2022
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: linux
---

# SELinux issues on Azure Linux VMs that prevent users from connecting

This article lists commonly seen issues connecting to Linux VMs on Azure over SSH, caused by SELinux misconfiguration.

The Unix security model is based on Discretionary Access Control (DAC). SELinux implements Mandatory Access Control (MAC) for Linux using kernel modules and user space tools. MAC provides a more controlled environment for resource access and removes the ability of the root user to access all resources on the operating system without restrictions. It also mitigates multiple kinds of security risks based on the traditional Unix security model.

Different distributions include SELinux out of the box or provide a straightforward way to activate kernel support and install user space tools. For reference, the following are links to SELinux documentation from some of the major Linux providers:

* [Red Hat](https://www.redhat.com/en/topics/linux/what-is-selinux)
* SUSE
  * [SUSE Linux Enterprise Server 12](https://documentation.suse.com/sles/12-SP4/html/SLES-all/cha-selinux.html)
  * [SUSE Linux Enterprise Server 15](https://documentation.suse.com/sles/15-SP4/html/SLES-all/cha-selinux.html)
* [Debian](https://wiki.debian.org/SELinux)
* [CentOS](https://wiki.centos.org/HowTos/SELinux)

Ubuntu has a [page](https://wiki.ubuntu.com/SELinux) about using SELinux, but there's a warning about its unmaintained state on that distribution. Ubuntu implements a different solution for MAC, called [AppArmor](https://help.ubuntu.com/community/AppArmor).

Red Hat based images on Azure come with SELinux enabled; other distributions, don't.

Managing the SELinux configuration isn't trivial, and requires system administrator skills. Studying and practicing with SELinux is recommended before implementing it. The following scenarios have been observed on Azure VMs, and are provided as a reference.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## SELinux misconfiguration stops boot from completing

An improperly configured SELinux may result in the OS being unable to load the SELinux policy. This will stop the operating system from completing the boot. Use the Serial console from the portal or through Azure CLI. The following message appears near the end of the output:

:::image type="content" source="./media/linux-selinux-troubleshooting/selinux-misconfiguration-01.png" alt-text="screenshot of serial console with SELinux failing to load policy":::

The specific reason for the failure won't be called out explicitly in the output.

### Resolution

The system administrator is responsible for locating and correcting the issue. To do so, as the VM is unable to start, multiple approaches are available:

#### Method 1: Starting the VM with SELinux turned off from the serial console

To give it a try, using the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux):

1. Trigger a **_Restart VM (Hard)_** from the Azure Serial Console.
2. Interrupt your VM at the GRUB menu with the `ESC` key.
3. Press `e` to modify the first kernel entry in the GRUB menu.
4. Go to the `linux16` line and add `selinux=0`

:::image type="content" source="media/linux-selinux-troubleshooting/disable-selinux-grub.gif" alt-text="Animated GIF shows the process of interrupting boot at the GRUB menu level to disable SELinux temporarily.":::

5. <a id="selinux-misconfiguration-example"></a> Validate and correct the SELinux configuration in `/etc/selinux/config`. For example, one common mistake is having set `SELINUXTYPE` to one of the values that is used for the `SELINUX` key, as seen on the following image:

:::image type="content" source="./media/linux-selinux-troubleshooting/selinux-misconfiguration-02.png" alt-text="screenshot of /etc/selinux/config with a wrong value of disabled for the SELINUX key":::

Notice that the last line, `SELINUXTYPE=disabled`, should have one of the three values detailed in the lines above (targeted, minimum or mls), rather than disabled. This is the corrected version of the same configuration:

:::image type="content" source="./media/linux-selinux-troubleshooting/selinux-misconfiguration-03.png" alt-text="screenshot the default configuration of /etc/selinux/config":::

#### Method 2: Using a rescue VM to repair SELinux offline

> [!TIP]
> If you've a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the configuration issue.

1. In case the [Azure serial console](serial-console-linux.md) isn't working in the specific VM or isn't an option in your subscription, you can also troubleshoot this issue using a rescue/repair VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).
    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](/troubleshoot/azure/virtual-machines/troubleshoot-recovery-disks-portal-linux).
2. Validate and correct the SELinux configuration in `/etc/selinux/config`. An example of this is available in [the previous section](#selinux-misconfiguration-example).
3. After the SELinux configuration has been corrected, perform the following actions:
    1. Exit chroot.
    2. Unmount the copy of the file systems from the rescue/repair VM.
    3. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).
    4. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

## Next steps

In case the specific error isn't due to SELinux, refer to the [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
