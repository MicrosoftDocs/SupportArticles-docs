---
title: GPU is disabled after you upgrade Ubuntu 16.04 LTS to 4.4.0-75 kernel on an Azure VM
description: Describes an issue with Ubuntu 16.04 kernel 4.4.0-75.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.custom: linux-related-content
ms.collection: linux
---
# GPU is disabled after you upgrade Ubuntu 16.04 LTS to 4.4.0-75 kernel on an Azure VM

_Original product version:_ &nbsp; Virtual Machine running Ubuntu  
_Original KB number:_ &nbsp; 4023409

## Symptoms

After you upgrade Azure N-Series VMs that are running Ubuntu 16.04 LTS to 4.4.0-75 version of the Linux kernel, the GPU functionality is disabled. Additionally, the following error is logged in the serial output log:

```
[[0;32m  OK  [0m] Started Authenticate and Authorize Users to Run Privileged Tasks.
[[0;32m  OK  [0m] Started Accounts Service.
[[0;1;31mFAILED[0m] Failed to start xxxx xxx file share.
See 'systemctl status fathom-mount.service' for details.
         Starting NVIDIA Persistence Daemon...
[[0;32m  OK  [0m] Started NVIDIA Persistence Daemon.
[[0;32m  OK  [0m] Started NVIDIA Persistence Daemon.
         Stopping NVIDIA Persistence Daemon...
[[0;32m  OK  [0m] Stopped NVIDIA Persistence Daemon.
[   32.811290] BUG: unable to handle kernel NULL pointer dereference at 0000000000000340
[   32.812372] IP: [<ffffffffc0740f8f>] _nv011740rm+0x1f/0x170 [nvidia]
[   32.812372] PGD e97efb067 PUD e99caf067 PMD 0 
[   32.993171] Oops: 0000 [#1] SMP 
[   32.993171] Modules linked in: nvidia_uvm(POE) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt pci_hyperv input_leds joydev mac_hid i2c_piix4 serio_raw hv_balloon 8250_fintek ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic hv_netvsc hid_hyperv hv_storvsc hv_utils scsi_transport_fc hid hyperv_keyboard hyperv_fb crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd psmouse pata_acpi hv_vmbus floppy fjes
[   33.166988] CPU: 5 PID: 961 Comm: nvidia-smi Tainted: P           OE   4.4.0-75-generic #96-Ubuntu
[   33.166988] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090006  01/06/2017
[   33.622272] task: ffff880e9cfe0e00 ti: ffff880e96574000 task.ti: ffff880e96574000
[   33.622272] RIP: 0010:[<ffffffffc0740f8f>]  [<ffffffffc0740f8f>] _nv011740rm+0x1f/0x170 [nvidia]
[   33.622272] RSP: 0018:ffff880e965779d0  EFLAGS: 00010282
[   33.622272] RAX: 0000000000000000 RBX: ffff880e9becc008 RCX: ffff880e9c052f44
[   33.622272] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff880e9becc008
[   33.622272] RBP: ffff880e9c052f40 R08: ffffffffc0e49c70 R09: ffff880e99c80008
[   33.622272] R10: ffff880e99c80000 R11: ffffffffc0900730 R12: 0000000000000000
[   33.622272] R13: ffff880e956c0008 R14: ffff880e954af008 R15: ffff880e94e92008
[   33.622272] FS:  00007efcec002700(0000) GS:ffff880ea5740000(0000) knlGS:0000000000000000
[   33.622272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.622272] CR2: 0000000000000340 CR3: 0000000e99bad000 CR4: 00000000001406e0
[   33.622272] Stack:
[   33.622272]  ffff880e9becc008 ffff880e9becc008 ffff880e956c0008 ffffffffc07342f7
[   33.622272]  0000000000000000 ffffffffc0734080 0000000000000000 ffff880e956c0008
[   33.622272]  ffff880e9becc008 0000000000000000 ffff880e954af008 ffffffffc0968f87
[   33.622272] Call Trace:
[   33.622272]  [<ffffffffc07342f7>] ? _nv011899rm+0x5e7/0x680 [nvidia]
[   33.622272]  [<ffffffffc0734080>] ? _nv011899rm+0x370/0x680 [nvidia]
[   33.622272]  [<ffffffffc0968f87>] ? _nv012138rm+0x117/0x290 [nvidia]
[   33.622272]  [<ffffffffc0a0c877>] ? _nv017599rm+0x327/0x480 [nvidia]
[   33.622272]  [<ffffffffc0a0e04b>] ? _nv000800rm+0xeb/0x6e0 [nvidia]
[   33.622272]  [<ffffffffc0a02198>] ? rm_init_adapter+0x128/0x130 [nvidia]
[   33.622272]  [<ffffffff810ac515>] ? wake_up_process+0x15/0x20
[   33.622272]  [<ffffffffc045547d>] ? nv_open_device+0x12d/0x6d0 [nvidia]
[   33.622272]  [<ffffffffc0455cfd>] ? nvidia_open+0x14d/0x2f0 [nvidia]
[   33.622272]  [<ffffffffc0454328>] ? nvidia_frontend_open+0x58/0xa0 [nvidia]
[   33.622272]  [<ffffffff8121384f>] ? chrdev_open+0xbf/0x1b0
[   33.622272]  [<ffffffff8120c96f>] ? do_dentry_open+0x1ff/0x310
[   33.622272]  [<ffffffff81213790>] ? cdev_put+0x30/0x30
[   33.622272]  [<ffffffff8120db04>] ? vfs_open+0x54/0x80
[   33.622272]  [<ffffffff8121983b>] ? may_open+0x5b/0xf0
[   33.622272]  [<ffffffff8121d6b7>] ? path_openat+0x1b7/0x1330
[   33.622272]  [<ffffffff812360ff>] ? simple_xattr_get+0x2f/0xb0
[   33.622272]  [<ffffffff8121fa21>] ? do_filp_open+0x91/0x100
[   33.622272]  [<ffffffff8122d326>] ? __alloc_fd+0x46/0x190
[   33.622272]  [<ffffffff8120ded8>] ? do_sys_open+0x138/0x2a0
[   33.622272]  [<ffffffff8122fda4>] ? mntput+0x24/0x40
[   33.622272]  [<ffffffff81218cee>] ? path_put+0x1e/0x30
[   33.622272]  [<ffffffff8120e05e>] ? SyS_open+0x1e/0x20
[   33.622272]  [<ffffffff8183b972>] ? entry_SYSCALL_64_fastpath+0x16/0x71
[   33.622272] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 55 ba 08 00 00 00 41 54 53 48 83 ed 08 4c 8b a7 08 1e 00 00 48 89 fb 48 8d 4d 04 4c 89 e6 <41> ff 94 24 40 03 00 00 85 c0 be 00 00 56 00 75 30 0f b6 45 04 
[   33.622272] RIP  [<ffffffffc0740f8f>] _nv011740rm+0x1f/0x170 [nvidia]
[   33.622272]  RSP <ffff880e965779d0>
[   33.622272] CR2: 0000000000000340
[   37.191743] ---[ end trace 815c3088feb15df9 ]---
         Starting NVIDIA Persistence Daemon...
[[0;32m  OK  [0m] Started NVIDIA Persistence Daemon.
         Stopping NVIDIA Persistence Daemon...
```

## Workaround

To work around this issue, upgrade the kernel to at least kernel version 4.4.0-77.
The Marketplace image for Ubuntu 16.04 LTS with the 4.4.0-77 kernel is published and available.

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
