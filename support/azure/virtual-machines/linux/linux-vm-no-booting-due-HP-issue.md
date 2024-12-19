---
title: Linux VM not booting due to wrong amount of HugePages
description: Troubleshoot and resolve issues with Linux VMs not booting due to incorrect HugePages configuration.
author: msaenzbo
ms.author: msaenzbo
ms.date: 11/02/2022
ms.reviewer:
ms.service: azure-virtual-machines
ms.custom: linux-related-content
ms.topic: troubleshooting
ms.collection: linux
---

# Linux VM not booting due to wrong amount of HugePages

**Applies to:** :heavy_check_mark: Linux VMs

When migrating or downsizing a Linux Virtual Machine (VM) to Azure, you might encounter issues where the VM doesn't boot properly. An incorrect configuration of HugePages can cause this issue, leading to memory allocation problems.

## Prerequisites

- Access to the Azure Serial Console.
- Basic knowledge of Linux commands and system administration.

## How to identify the issue

### Symptoms

- After migrating a Linux VM from on-premises to Azure, the VM doesn't boot properly.
- After downsizing the Linux VM, it doesn't boot properly.
- The issue occurs when the VM boots with some services, but the login prompt is slow, and you can't log in.


### Console Log Summary

The console logs for various Linux distributions (Red Hat, Oracle, SUSE, Ubuntu) indicate the following common issues:

- Failed to start udev Kernel Device Manager.
- Timed out waiting for specific devices.
- Dependency failures for local file systems and emergency mode.
- Out of memory errors caused by the systemd-udevd service or other processes.
- Failed to start various network and system services.
- System hangs at login or boot.


- Output 1
```output
[FAILED] Failed to start udev Kernel Device Manager.
See 'systemctl status systemd-udevd.service' for details.
[FAILED] Failed to start udev Kernel Device Manager.
See 'systemctl status systemd-udevd.service' for details.
[ TIME ] Timed out waiting for device dev-di...\x2db5ea\x2dcc7e4fcafaad.device.
[DEPEND] Dependency failed for /boot.
[DEPEND] Dependency failed for Local File Systems.
[DEPEND] Dependency failed for Relabel all filesystems, if necessary.
[DEPEND] Dependency failed for Mark the need to relabel after reboot.
[DEPEND] Dependency failed for Migrate local... structure to the new structure.
[DEPEND] Dependency failed for /boot/efi.
[ TIME ] Timed out waiting for device dev-ttyS0.device.
[ TIME ] Timed out waiting for device dev-di...-azure_resource\x2dpart1.device.
[DEPEND] Dependency failed for File System C...disk/cloud/azure_resource-part1.
[ TIME ] Timed out waiting for device dev-disk-by\x2duuid-D147\x2d2497.device.
[  OK  ] Reached target Timers.
[  OK  ] Reached target Login Prompts.
[  OK  ] Reached target Cloud-init target.
[  OK  ] Reached target Network (Pre).
[  OK  ] Reached target Cloud-config availability.
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
[FAILED] Failed to start Crash recovery kernel arming.
See 'systemctl status kdump.service' for details.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Sockets.
[FAILED] Failed to start Import network configuration from initramfs.
See 'systemctl status rhel-import-state.service' for details.
[FAILED] Failed to start Create Volatile Files and Directories.
See 'systemctl status systemd-tmpfiles-setup.service' for details.
[FAILED] Failed to start Emergency Shell.
See 'systemctl status emergency.service' for details.
[DEPEND] Dependency failed for Emergency Mode.
[FAILED] Failed to start Tell Plymouth To Write Out Runtime Data.
See 'systemctl status plymouth-read-write.service' for details.
[FAILED] Failed to start Security Auditing Service.
See 'systemctl status auditd.service' for details.
[FAILED] Failed to start Update UTMP about System Boot/Shutdown.
See 'systemctl status systemd-update-utmp.service' for details.
[DEPEND] Dependency failed for Update UTMP about System Runlevel Changes.
[  OK  ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
[  OK  ] Reached target Local File Systems (Pre).
```

- Output2
```output
[  385.665208][  T709] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
[  385.675431][  T709] Call Trace:
[  385.678028][  T709]  <TASK>
[  385.680574][  T709]  dump_stack_lvl+0x45/0x5b
[  385.684222][  T709]  dump_header+0x4a/0x220
[  385.695420][  T709]  oom_kill_process+0xe8/0x140
[  385.710672][  T709]  out_of_memory+0x113/0x580
[  385.716986][  T709]  __alloc_pages_slowpath.constprop.112+0x980/0xc70
[  385.723770][  T709]  __alloc_pages+0x2d9/0x320
[  385.761856][  T709]  pagecache_get_page+0x1a8/0x480
[  385.774844][  T709]  filemap_fault+0x4c1/0xa30
[  385.779807][  T709]  ? next_uptodate_page+0x11e/0x270
[  385.785288][  T709]  __xfs_filemap_fault+0x5c/0x280 [xfs 2321eaa9ab2ad44a628250c07d85c25988bf91a0]
[  385.805707][  T709]  __do_fault+0x31/0xc0
[  385.809628][  T709]  __handle_mm_fault+0xd64/0x1220
[  385.838902][  T709]  ? switch_fpu_return+0x49/0xd0
[  385.843779][  T709]  handle_mm_fault+0xd7/0x290
[  385.848516][  T709]  do_user_addr_fault+0x1eb/0x730
[  385.853696][  T709]  exc_page_fault+0x67/0x150
[  385.858809][  T709]  ? asm_exc_page_fault+0x8/0x30
[  385.865062][  T709]  asm_exc_page_fault+0x1e/0x30
[  385.879856][  T709] RIP: 0033:0x55dc84c10950
[  385.891682][  T709] Code: Unable to access opcode bytes at RIP 0x55dc84c10926.
[  385.898248][  T709] RSP: 002b:00007ffeaf98d1e8 EFLAGS: 00010213
[  385.904334][  T709] RAX: 00007f3402d98ce0 RBX: 000055dc84f47ff0 RCX: 00007ffeaf98d2e0
[  385.918600][  T709] RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000055dc84f47ff0
[  385.926905][  T709] RBP: 00007ffeaf98d210 R08: 0000000016fae5c5 R09: 0000000000000002
[  385.933967][  T709] R10: 00007ffeaf98d110 R11: 011d994f1f52633a R12: 00007ffeaf98d208
[  385.942056][  T709] R13: 000055dc84f47620 R14: 0000000000000000 R15: 0000000000000001
[  385.949403][  T709]  </TASK>
[  385.952126][  T709] Mem-Info:
[  385.955048][  T709] active_anon:167 inactive_anon:10940 isolated_anon:0
[  385.955048][  T709]  active_file:15 inactive_file:362 isolated_file:0
[  385.955048][  T709]  unevictable:788 dirty:0 writeback:0
[  385.955048][  T709]  slab_reclaimable:7132 slab_unreclaimable:6898
[  385.955048][  T709]  mapped:448 shmem:5085 pagetables:634 bounce:0
[  385.955048][  T709]  free:29370 free_pcp:1347 free_cma:0
[  385.993037][  T709] Node 0 active_anon:668kB inactive_anon:43760kB active_file:60kB inactive_file:3304kB unevictable:3152kB isolated(anon):0kB isolated(file):0kB mapped:2140kB dirty:0kB writeback:0kB shmem:20340kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 4096kB writeback_tmp:0kB kernel_stack:2352kB pagetables:2536kB all_unreclaimable? yes
[  386.023392][  T709] Node 0 DMA free:14304kB boost:0kB min:128kB low:160kB high:192kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  386.050587][  T709] lowmem_reserve[]: 0 888 7864 7864 7864
[  386.056325][  T709] Node 0 DMA32 free:35408kB boost:0kB min:7616kB low:9520kB high:11424kB reserved_highatomic:0KB active_anon:0kB inactive_anon:12kB active_file:44kB inactive_file:60kB unevictable:0kB writepending:0kB present:1032128kB managed:966592kB mlocked:0kB bounce:0kB free_pcp:296kB local_pcp:296kB free_cma:0kB
[  386.083493][  T709] lowmem_reserve[]: 0 0 6976 6976 6976
[  386.088634][  T709] Node 0 Normal free:64832kB boost:0kB min:59836kB low:74792kB high:89748kB reserved_highatomic:4096KB active_anon:668kB inactive_anon:43748kB active_file:56kB inactive_file:4392kB unevictable:3152kB writepending:0kB present:7340032kB managed:7151896kB mlocked:80kB bounce:0kB free_pcp:5096kB local_pcp:4848kB free_cma:0kB
[  386.119264][  T709] lowmem_reserve[]: 0 0 0 0 0
[  386.124090][  T709] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 1*64kB (U) 1*128kB (U) 1*256kB (U) 1*512kB (U) 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 14304kB
[  386.139306][  T709] Node 0 DMA32: 12*4kB (UME) 10*8kB (UME) 5*16kB (UME) 4*32kB (UME) 4*64kB (UME) 4*128kB (UME) 4*256kB (UME) 1*512kB (E) 2*1024kB (ME) 3*2048kB (UME) 6*4096kB (M) = 35408kB
[  386.158584][  T709] Node 0 Normal: 284*4kB (UME) 246*8kB (UME) 268*16kB (UME) 212*32kB (UME) 141*64kB (UME) 77*128kB (ME) 36*256kB (UME) 30*512kB (UME) 9*1024kB (UM) 0*2048kB 0*4096kB = 66848kB
[  386.183411][  T709] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[  386.194414][  T709] Node 0 hugepages_total=3833 hugepages_free=3833 hugepages_surp=0 hugepages_size=2048kB
[  386.205473][  T709] 5679 total pagecache pages
[  386.210473][  T709] 0 pages in swap cache
[  386.214075][  T709] Swap cache stats: add 0, delete 0, find 0/0
[  386.221319][  T709] Free swap  = 0kB
[  386.226581][  T709] Total swap = 0kB
[  386.230305][  T709] 2097038 pages RAM
[  386.234587][  T709] 0 pages HighMem/MovableOnly
[  386.239784][  T709] 63576 pages reserved
[  386.243950][  T709] 0 pages cma reserved
[  386.248253][  T709] 0 pages hwpoisoned
[  386.252967][  T709] Tasks state (memory values in pages):
[  386.259648][  T709] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  386.270760][  T709] [    709]     0   709    19824      674   188416        0          -250 systemd-journal
[  386.283947][  T709] [    720]     0   720    21762      503   192512        0         -1000 systemd-udevd
[  386.293745][  T709] [    800]     0   800    24367       93    86016        0         -1000 auditd
[  386.303305][  T709] [    816]   499   816    12221      186   139264        0          -900 dbus-daemon
[  386.313051][  T709] [    818]     0   818     1943      180    61440        0             0 hv_kvp_daemon
[  386.325447][  T709] [    820]     0   820    23486       65    86016        0             0 irqbalance
[  386.336826][  T709] [    825]   489   825    69833       98   159744        0             0 nscd
[  386.347420][  T709] [    854]     0   854    17766      240   180224        0             0 systemd-logind
[  386.357018][  T709] [    973]     0   973    10708      313   131072        0             0 wickedd-auto4
[[0;32m  OK  [[  386.369228][  T709] [    985]     0   985    10709      317   122880        0             0 wickedd-dhcp4
[  386.380633][  T709] [    986]     0   986    10709      314   122880        0             0 wickedd-dhcp6
0m] Started [0;[  386.393786][  T709] [    989]     0   989    10738      345   131072        0             0 wickedd
1;39mBackup of /[  386.404982][  T709] [   1002]     0  1002    10715      326   126976        0             0 wickedd-nanny
etc/sysconfig[0[  386.417223][  T709] [   1048]     0  1048     3847       79    73728        0             0 bash
m.[  386.428454][  T709] [   1053]     0  1053    23636      109   192512        0             0 gc_linux_servic
[  386.441650][  T709] [   1063]     0  1063   123508     1761   143360        0         -1000 auomscollect

[  386.452738][  T709] [   1080]     0  1080     3114       75    69632        0             0 netconfig
[  386.465579][  T709] [   1082]     0  1082     3408      364    69632        0             0 netconfig
[  386.480799][  T709] [   1103]     0  1103     3408      364    61440        0             0 netconfig
[  386.491063][  T709] [   1104]     0  1104     3213      172    73728        0             0 dns-resolver
[  386.508797][  T709] [   1105]     0  1105     3213      172    65536        0             0 dns-resolver
[  386.520964][  T709] [   1106]     0  1106     3213      173    65536        0             0 dns-resolver
[  386.531198][  T709] [   1107]     0  1107     7028       29    86016        0             0 systemctl
[  386.542406][  T709] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=netconfig,pid=1082,uid=0
[  386.559765][  T709] Out of memory: Killed process 1082 (netconfig) total-vm:13632kB, anon-rss:1456kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:68kB oom_score_adj:0
[  386.582247][   T32] oom_reaper: reaped process 1082 (netconfig), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
[[0;32m  OK  [0m] Started [0;1;39mCheck if mainboard battery is Ok[0m.
```

- Output 3
```output
[    0.847506] Kernel panic - not syncing: System is deadlocked on memory
[    0.847506] 
[    0.851071] CPU: 4 PID: 1 Comm: systemd Not tainted 4.18.0-553.22.1.el8_10.x86_64 #1
[    0.854342] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 08/23/2024
[    0.859012] Call Trace:
[    0.860073]  dump_stack+0x41/0x60
[    0.861499]  panic+0xe7/0x2ac
[    0.862980]  out_of_memory.cold.36+0x5e/0x7e
[    0.864883]  __alloc_pages_slowpath+0xbf0/0xcd0
[    0.867007]  __alloc_pages_nodemask+0x2e2/0x330
[    0.868934]  new_slab+0x3f4/0x4f0
[    0.870369]  ? srso_alias_return_thunk+0x5/0xfcdfd
[    0.872421]  ? pcpu_block_refresh_hint+0x7f/0xb0
[    0.874357]  ___slab_alloc+0x3a3/0x950
[    0.875968]  ? __kernfs_new_node+0x5d/0x1e0
[    0.877790]  ? srso_alias_return_thunk+0x5/0xfcdfd
[    0.880110]  ? __kernfs_iattrs.isra.7+0x3b/0xc0
[    0.882048]  ? kernfs_xattr_get+0x1d/0x50
[    0.883778]  ? __kernfs_new_node+0x5d/0x1e0
[    0.885589]  kmem_cache_alloc+0x252/0x280
[    0.887343]  __kernfs_new_node+0x5d/0x1e0
[    0.889081]  ? string+0x44/0x60
[    0.890452]  ? srso_alias_return_thunk+0x5/0xfcdfd
[    0.892504]  ? vsnprintf+0x340/0x520
[    0.894049]  kernfs_new_node+0x31/0x50
[    0.895869]  __kernfs_create_file+0x30/0xc0
[    0.897924]  cgroup_addrm_files+0x143/0x340
[    0.900250]  ? alloc_shrinker_info+0xca/0x100
[    0.902675]  css_populate_dir+0x86/0x140
[    0.904900]  cgroup_apply_control_enable+0xed/0x310
[    0.907558]  cgroup_mkdir+0x1c2/0x490
[    0.909521]  kernfs_iop_mkdir+0x5a/0xa0
[    0.911781]  vfs_mkdir+0x11b/0x1e0
[    0.913579]  do_mkdirat+0xec/0x120
[    0.915356]  do_syscall_64+0x5b/0x1a0
[    0.917315]  entry_SYSCALL_64_after_hwframe+0x66/0xcb
[    0.919947] RIP: 0033:0x7fd43f794d4b
[    0.921829] Code: 73 01 c3 48 8b 0d 3d 71 39 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 71 39 00 f7 d8 64 89 01 48
[    0.932128] RSP: 002b:00007ffd7e0fac28 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
[    0.936149] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd43f794d4b
[    0.939935] RDX: 00007ffd7e0faaf0 RSI: 00000000000001ed RDI: 000055b707c3c410
[    0.945738] RBP: 00007ffd7e0fac70 R08: 0000000000000022 R09: 002f70756f726763
[    0.949630] R10: 0000000000000100 R11: 0000000000000206 R12: 000055b707c1e500
[    0.953284] R13: 00000000000000a0 R14: 00007fd441021a7e R15: 0000000000000020
[    0.958110] Kernel Offset: 0x35000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.964040] fbcon: Taking over console
[    0.966128] ---[ end Kernel panic - not syncing: System is deadlocked on memory
[    0.966128]  ]--
```

### Cause

The issue occurs because the server runs out of memory to boot up, as all the memory is reserved for HugePages. This situation prevents the VM from running any processes due to the lack of available memory.

In this specific scenario, the `vm.nr_hugepages` value was set to `65536` in the `/etc/sysctl.conf` file, while the instance only had `16 GB` of total memory. This value of `65536 x 2048kb` would consume `134217728kb` of memory, causing an Out of Memory (OOM) condition.

## Resolution

1. Access the system to fix the issue using one of the following methods:

### a) Using the Serial Console

If the serial console is working, boot the VM in single-user mode.

Refer to: [Boot the VM in single-user mode using the Azure Serial Console](serial-console-grub-single-user-mode.md)

### b) Using the Azure VM Repair Utility

Refer to: [Repair a Linux VM using the Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md)

### c) Creating a Rescue VM Manually (Offline Method)

Refer to: [Use the manual method to fix VM boot issues](azure/virtual-machines/linux-virtual-machine-cannot-start-fstab-errors?source=recommendations#use-manual-method)

### Steps to Fix the HugePages Configuration

1. Access the VM using one of the previously mentioned methods.
2. Follow the chroot process in case using method **b** or **c**: [Use the manual method to fix VM boot issues](chroot-environment-linux.md)
3. Open the `/etc/sysctl.conf` or `/etc/sysctl.conf.d/*` file using a text editor.

```bash
sudo vi /etc/sysctl.conf
```

4. Locate the line that sets the `vm.nr_hugepages` value.

```bash
vm.nr_hugepages=65536
```

5. Comment the line for `vm.nr_hugepages` or ensure the number of HugePages is correct.
6. Save the changes and exit the text editor.
7. [Regenerate missing initramfs manually](azure/virtual-machines/kernel-related-boot-issues#missing-initramfs-manual.md) according to OS distribution.
8. To apply the changes, reboot the VM.

```bash
sudo reboot
```

[!IMPORTANT] Review how much memory the VM has and How much HugePage is set up. If the system needs 16GB for HugePages reservation and the VM size has only 16GB of RAM, the system runs out of memory. As a result, the VM doesn't  boot. In this case, the recommendation is to upgrade the VM with size that has at least 32G for example.
For refence on How much HugePages the VM and Database needs refer to: [Oracle Community](https://community.oracle.com/mosc/discussion/4516170/huge-pages)

### Next Steps

Monitor the VM to ensure it boots correctly and services start as expected.
Adjust the HugePages configuration further if necessary to balance performance and memory allocation.

