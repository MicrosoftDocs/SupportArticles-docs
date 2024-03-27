---
title: An Azure Linux VM on a 3.10-based kernel panics after a host node upgrade
description: Discusses a problem that occurs when an Azure Linux VM that's running the 3.10-based kernel crashes after a host node upgrade in Azure. Provides a resolution.
ms.date: 07/21/2020
ms.reviewer: craigw, scotro, anandram, borisb
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
---
# An Azure Linux VM on a 3.10-based kernel panics after a host node upgrade

This article  discusses a problem that occurs when an Azure Linux VM that's running the 3.10-based kernel crashes after a host node upgrade in Azure.

_Original product version:_ &nbsp; Virtual Machine running Linux, Virtual Machine running RedHat  
_Original KB number:_ &nbsp; 3212236

## Symptoms

Consider the following scenario:

- You have a Microsoft Azure Linux virtual machine (VM) that is running a RHEL/CentOS-based distribution with a Linux kernel version earlier than version 3.10.0-327.10.1, including those that are included with:

  - Red Hat Enterprise Linux 7.1 and 7.0
  - CentOS 7.1 and 7.0
  - Oracle Linux 7.1 and 7.0 with Red Hat-compatible kernel

- A [Memory preserving update](/azure/virtual-machines/maintenance-and-updates?toc=/azure/virtual-machines/windows/toc.json&bc=/azure/virtual-machines/windows/breadcrumb/toc.json#maintenance-that-doesnt-require-a-reboot) operation occurs on an Azure host node.

In this scenario, the VM becomes unresponsive, and a VM panic that resembles the following is logged in the Linux serial log:

```
[11480839.438577] Call Trace:
[11480839.439615] [<ffffffff816045b6>] dump_stack+0x19/0x1b
[11480839.441556] [<ffffffff8106e29b>] warn_slowpath_common+0x6b/0xb0
[11480839.443818] [<ffffffff8106e33c>] warn_slowpath_fmt+0x5c/0x80
[11480839.445983] [<ffffffff8123e585>] sysfs_add_one+0xa5/0xd0
[11480839.447983] [<ffffffff8123e77c>] create_dir+0x7c/0xe0
[11480839.449876] [<ffffffff8123eb29>] sysfs_create_dir+0xa9/0x130
[11480839.451971] [<ffffffff812d74ab>] kobject_add_internal+0xbb/0x2f0
[11480839.454310] [<ffffffff812d79e5>] kobject_add+0x75/0xd0
[11480839.456236] [<ffffffff813cfa85>] device_add+0x125/0x7a0
[11480839.458167] [<ffffffff813df9fc>] ? __pm_runtime_resume+0x5c/0x80
[11480839.460469] [<ffffffff813fe9cc>] scsi_sysfs_add_sdev+0xac/0x280
[11480839.462628] [<ffffffff813fcfbb>] do_scan_async+0x7b/0x150
[11480839.464632] [<ffffffff8109e849>] async_run_entry_fn+0x39/0x120
[11480839.467170] [<ffffffff8108f0cb>] process_one_work+0x17b/0x470
[11480839.469354] [<ffffffff8108fe9b>] worker_thread+0x11b/0x400
[11480839.472310] [<ffffffff8108fd80>] ? rescuer_thread+0x400/0x400
[11480839.475265] [<ffffffff8109727f>] kthread+0xcf/0xe0
[11480839.477904] [<ffffffff810971b0>] ? kthread_create_on_node+0x140/0x140
[11480839.481074] [<ffffffff81614358>] ret_from_fork+0x58/0x90
[11480839.483873] [<ffffffff810971b0>] ? kthread_create_on_node+0x140/0x140
[11480839.487072] ---[ end trace 1f7736c59e96a8a0 ]---
[11480839.489584] ------------[ cut here ]------------
......
[11480864.118093] Call Trace:
[11480864.118093] [<ffffffff815f2535>] klist_put+0x25/0xa0
[11480864.118093] [<ffffffff815f25be>] klist_del+0xe/0x10
[11480864.118093] [<ffffffff813ce908>] device_del+0x58/0x1f0
[11480864.118093] [<ffffffff813ceabe>] device_unregister+0x1e/0x60
[11480864.118093] [<ffffffff812c36ee>] bsg_unregister_queue+0x5e/0xa0
[11480864.118093] [<ffffffff813fec49>] __scsi_remove_device+0xa9/0xd0
[11480864.118093] [<ffffffff813fcfc7>] do_scan_async+0x87/0x150
[11480864.118093] [<ffffffff8109e849>] async_run_entry_fn+0x39/0x120
[11480864.118093] [<ffffffff8108f0cb>] process_one_work+0x17b/0x470
[11480864.118093] [<ffffffff8108fe9b>] worker_thread+0x11b/0x400
[11480864.118093] [<ffffffff8108fd80>] ? rescuer_thread+0x400/0x400
[11480864.118093] [<ffffffff8109727f>] kthread+0xcf/0xe0
[11480864.118093] [<ffffffff810971b0>] ? kthread_create_on_node+0x140/0x140
[11480864.118093] [<ffffffff81614358>] ret_from_fork+0x58/0x90
[11480864.118093] [<ffffffff810971b0>] ? kthread_create_on_node+0x140/0x140
```

## Cause

This problem may be caused by faulty locking logic in the SCSI subsystem that is exposed when a SCSI disk is removed from a running RHEL/CentOS-based VM guest on a Microsoft Hyper-V host.

## Resolution

To fix this problem and restore functionality, manually restart the VM.

To avoid this problem in the future, update to kernel version 3.10.0-327.10.1 or a later version, including those found in:

- Red Hat Enterprise Linux 7.2
- CentOS 7.2
- Oracle Linux 7.2 with Red Hat-compatible kernel

## More Information

For more information about [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and open-source technologies in Azure, see [Support for Linux and open source technology in Azure](https://support.microsoft.com/help/2941892).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
