---
title: The maximum ram of a Linux VM is limited to 64 GB on Azure
description: The maximum memory of an Azure Linux virtual machine is limited to 64 GB due to a bug in Linux with the kernel version prior to 3.10.
ms.date: 09/18/2023
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: linux
---
# The maximum memory of an Azure Linux virtual machine is limited to 64 GB

This article provides a solution to an issue in which the maximum memory of an Azure Linux virtual machine is limited to 64 GB in Linux with the kernel version prior to 3.10.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4038684

## Symptoms

You create a Linux virtual machine (VM) that has more than 64-GB memory on Microsoft Azure. You find that the actual allocated memory on the Linux VM is only 64 GB.

> [!NOTE]
> You must check the available memory within the Linux VM to determine if the memory has been limited to 64 GB. For example, use the **free -m** command. Azure portal always shows the full memory size that is assigned to the VM.

## Cause

This issue is caused by a bug in the Linux kernel in versions prior to 3.10. The bug is fixed in Linux kernel version 3.10 and later versions.

VMs in Azure are hosted on Windows Server 2016 Hyper-V or Windows Server 2012 R2 Hyper-V. When the VM is running on a Windows Server 2012 R2 Hyper-V host, the bug does not manifest because the maximum physical address space size that Hyper-V provides to guest VMs is 4 TB. But when the guest VM is running on Windows Server 2016 Hyper-V host, the maximum physical address space size is raised to 16 TB. In this scenario, the bug manifests, and it causes the Linux guest to see a maximum of 64 GB of memory. The 64-GB value is controlled by the Memory Type Range Registers (MTRR) values that Hyper-V provides to the guest.

The assignment of a VM to a Windows Server 2012 R2 or Windows Server 2016 host is controlled by the Azure infrastructure and is not user selectable. So, some deployments may encounter this problem while others do not.

## Resolution

This bug occurs in the Linux kernel version in SUSE Linux Enterprise Server (SLES) 11 SP4, Red Hat Enterprise Linux (RHEL) 6.x, and CentOS 6.x. It is fixed in newer Linux kernels and does not occur in SLES 12, RHEL 7.x, and CentOS 7.x.
  
For kernels that have the bug, you can work around the issue by adding **disable_mtrr_trim**  as a kernel boot line option. Microsoft is working with the vendors of our endorsed distributions to update the images in Azure to add **disable_mtrr_trim** as a kernel boot line option. This option disables the MTRR interpretation and removes the 64-GB limit. If you create a new VM from an image that has been updated to include this kernel boot line option, you will not experience the 64-GB limit, regardless of which host version the VM is deployed on.

For existing VMs, you can manually add the same kernel boot line option by using the following steps.

- For RHEL/CentOS 6.x:ing:

    1. Open the `/boot/grub/grub.conf` file in a text editor.
    2. Add the parameter **disable_mtrr_trim** to the kernel command line.

        In the grub.conf file, there will be a line that looks like the following:  

        `kernel /vmlinuz-2.6.32-696.3.2.el6.x86_64 ro root=UUID=<ID>`

        Add **disable_mtrr_trim** as a separate parameter to the end of this line.
    3. Save and close the grub.conf file.
    4. Restart the VM.  

    For more information, see [Red Hat: GRUB Menu Configuration File](https://access.redhat.com/documentation/en-Us/red_hat_enterprise_linux/6/html/installation_guide/s1-grub-configfile).

- For SLES, refer to [SUSE: Booting with GRUB.](https://www.suse.com/documentation/sled11/book_sle_admin/data/sec_grub_basic.html)
- For Debian, refer to [Debian: Boot Parameters](https://www.debian.org/releases/stable/amd64/ch05s03.en.html).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
