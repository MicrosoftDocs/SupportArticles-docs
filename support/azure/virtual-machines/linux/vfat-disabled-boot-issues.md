---
title: Recover Azure Linux VM from boot issue due to VFAT disabled
description: Provides solutions to an issue in which a Linux virtual machine (VM) can't boot after disabling VFAT.
author: divargas-msft
ms.author: divargas
ms.date: 10/10/2022
ms.reviewer: jofrance
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
ms.topic: troubleshooting
---
# Azure Linux virtual machine fails to boot after VFAT file system type is disabled

This article provides solutions to an issue in which an Azure Linux virtual machine (VM) can't boot after disabling the virtual file allocation table (VFAT) file system type.

VFAT is required in the following scenarios:

- [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros) VMs mount the */boot/efi* file system.

    Linux Gen2 VMs (UEFI based) require the */boot/efi* file system, but it's included in the Gen1 (BIOS-based) Linux images.

- Encrypt both OS and data disks of the Azure Linux VMs by using [Azure Disk Encryption(ADE)](/azure/virtual-machines/linux/disk-encryption-overview).

Disabling VFAT will cause the Azure Linux VMs to fail to boot. Several hardening tools can disable VFAT. To avoid this kind of issue, make sure VFAT is excluded from the hardening and is enabled.

## Prerequisites

Make sure the [serial console](serial-console-linux.md) is enabled and functional in the Linux VM.

## <a id="identify-vfat-disabled-boot-issue"></a>How to identify boot issue

To identify a boot issue, use the [AZ CLI](/cli/azure/serial-console#az-serial-console-connect) or Azure portal to view the serial console log output of the VM in the boot diagnostics pane or serial console pane. If VFAT is disabled, you'll experience the following issues:

### Failed to mount /boot/efi

When the */boot/efi* file system fails to get mounted, one or more of the following outputs are displayed:

- Output 1

    ```output
    [[1;31mFAILED[0m] Failed to mount /boot/efi.
    
    See 'systemctl status boot-efi.mount' for details.
    
    [[1;33mDEPEND[0m] Dependency failed for Local File Systems.
    
    [[1;33mDEPEND[0m] Dependency failed for Relabel all filesystems, if necessary.
    
    [[1;33mDEPEND[0m] Dependency failed for Migrate local... structure to the new structure.
    
    [[1;33mDEPEND[0m] Dependency failed for Mark the need to relabel after reboot.
    ```

- Output 2

    ```output
    [FAILED] Failed to mount /boot/efi.
    See 'systemctl status boot-efi.mount' for details.
    [DEPEND] Dependency failed for Local File Systems.
    [DEPEND] Dependency failed for Mark the need to relabel after reboot.
    ```

- Output 3

    ```output
    [   17.707983] ------------[ cut here ]------------
    [   17.714144] request_module fs-vfat succeeded, but still no fs?
    [   17.714426] RPC: Registered named UNIX socket transport module.
    [   17.721163] WARNING: CPU: 1 PID: 933 at fs/filesystems.c:275 get_fs_type+0xcd/0xe0
    [   17.738587] RPC: Registered udp transport module.
    [   17.722103] Modules linked in: fat sunrpc(+) rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod intel_rapl_msr intel_rapl_common isst_if_mbox_msr isst_if_common ib_iser libiscsi nfit scsi_transport_iscsi ib_umad libnvdimm rdma_cm ib_ipoib iw_cm ib_cm kvm_intel kvm irqbypass mlx5_ib crct10dif_pclmul crc32_pclmul ib_uverbs ghash_clmulni_intel rapl pcspkr ib_core i2c_piix4 hv_balloon hv_utils joydev ip_tables xfs libcrc32c mlx5_core mlxfw tls pci_hyperv pci_hyperv_intf ata_generic sd_mod t10_pi sg hv_storvsc hv_netvsc hyperv_keyboard scsi_transport_fc hid_hyperv hyperv_fb ata_piix libata hv_vmbus crc32c_intel serio_raw dm_mod
    [   17.766462] RPC: Registered tcp transport module.
    [   17.722103] CPU: 1 PID: 933 Comm: mount Not tainted 4.18.0-305.17.1.el8_4.x86_64 #1
    [   17.722103] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
    [   17.722103] RIP: 0010:get_fs_type+0xcd/0xe0
    [   17.722103] Code: 5d 41 5c c3 80 3d 6a 7a 49 01 00 75 ec 48 89 da 44 89 e6 48 89 04 24 48 c7 c7 c8 47 ce b7 c6 05 50 7a 49 01 01 e8 6c 67 da ff <0f> 0b 48 8b 04 24 e9 66 ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44
    [   17.722103] RSP: 0018:ffffabd68394fe70 EFLAGS: 00010282
    [   17.722103] RAX: 0000000000000000 RBX: ffffa04a1e6879e0 RCX: 0000000000000000
    [   17.722103] RDX: ffffa04a37d267a0 RSI: ffffa04a37d167c8 RDI: ffffa04a37d167c8
    [   17.722103] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000092
    [   17.722103] R10: 00000000ff000000 R11: ffffabd682fec020 R12: 0000000000000004
    [   17.722103] R13: ffffa04a1d80f920 R14: ffffa04a1e6879e0 R15: 0000000000000000
    [   17.722103] FS:  00007fb0630e1080(0000) GS:ffffa04a37d00000(0000) knlGS:0000000000000000
    [   17.722103] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   17.722103] CR2: 00007fb86bb7a0c0 CR3: 000000029bfe4004 CR4: 00000000003706e0
    [   17.722103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [   17.722103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [   17.722103] Call Trace:
    [   17.722103]  do_mount+0x1f2/0x950
    [   17.722103]  ksys_mount+0xb6/0xd0
    [   17.722103]  __x64_sys_mount+0x21/0x30
    [   17.722103]  do_syscall_64+0x5b/0x1a0
    [   17.722103]  entry_SYSCALL_64_after_hwframe+0x65/0xca
    [   17.874253] RPC: Registered tcp NFSv4.1 backchannel transport module.
    [   17.722103] RIP: 0033:0x7fb06211192e
    [   17.722103] Code: 48 8b 0d 5d 15 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2a 15 2c 00 f7 d8 64 89 01 48
    [   17.722103] RSP: 002b:00007fff02a92b78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
    [   17.722103] RAX: ffffffffffffffda RBX: 00005626752f3460 RCX: 00007fb06211192e
    [   17.722103] RDX: 00005626752f36e0 RSI: 00005626752f3700 RDI: 00005626752f53d0
    [   17.722103] RBP: 00007fb062ebe184 R08: 00005626752f3670 R09: 0000000000000003
    [   17.722103] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 0000000000000000
    [   17.722103] R13: 00000000c0ed0000 R14: 00005626752f53d0 R15: 00005626752f36e0
    [   17.722103] ---[ end trace 910fa795ff1c6c89 ]---
    [[0;1;31mFAILED[0m] Failed to mount /boot/efi.
    
    See 'systemctl status boot-efi.mount' for details.
    ```

### ADE encrypted VM is unable to access root volume

When a VM with the OS encrypted and VFAT disabled fails to boot, the corresponding output is displayed, as shown below. After the system times out, the dracut or initramfs shell will show up at the end of the serial console log.

- Ubuntu VM with the OS disk encrypted and VFAT disabled:
    
    ```output
        [   24.062228] dracut-initqueue[261]: +++ '[' -z 0 ']'
        [   24.065039] dracut-initqueue[261]: + luksname=osencrypt
        [   24.068026] dracut-initqueue[261]: + ask_passphrase=1
        [   24.070498] dracut-initqueue[261]: + '[' /dev/sda2 '!=' /dev/sda2 ']'
        [   24.073528] dracut-initqueue[261]: + device=/dev/sda2
        [   24.076046] dracut-initqueue[261]: + numtries=1
        [   24.078410] dracut-initqueue[261]: + info 'luksOpen /dev/sda2 osencrypt'
        [   24.081822] dracut-initqueue[261]: + check_quiet
        [   24.084663] dracut-initqueue[261]: + '[' -z no ']'
        [   24.087067] dracut-initqueue[261]: + '[' no '!=' yes ']'
        [   24.089711] dracut-initqueue[261]: + echo 'luksOpen /dev/sda2 osencrypt'
        [   24.092857] dracut-initqueue[261]: luksOpen /dev/sda2 osencrypt
        [   24.095737] dracut-initqueue[261]: + ls '/mnt/azure_bek_disk/LinuxPassPhraseFileName*'
        [   24.099506] dracut-initqueue[261]: ls: cannot access /mnt/azure_bek_disk/LinuxPassPhraseFileName*: No such file or directory
        [   24.104460] dracut-initqueue[261]: + mkdir -p /mnt/azure_bek_disk/
        [   24.107648] dracut-initqueue[261]: + mount -L 'BEK VOLUME' /mnt/azure_bek_disk/
        [   24.111029] dracut-initqueue[261]: mount: unknown filesystem type 'vfat'
        [   24.114456] dracut-initqueue[261]: ++ ls '/mnt/azure_bek_disk/LinuxPassPhraseFileName*'
        [   24.118570] dracut-initqueue[261]: ls: cannot access /mnt/azure_bek_disk/LinuxPassPhraseFileName*: No such file or directory
        [   24.124108] dracut-initqueue[261]: + cryptsetupopts='--header /osluksheader'
        [   24.127630] dracut-initqueue[261]: + '[' -n '' -a '' '!=' none -a -e '' ']'
        [   24.131265] dracut-initqueue[261]: + '[' 1 -eq 0 ']'
        [   24.134614] dracut-initqueue[261]: + sleep 1 
        [   24.817478] dracut-initqueue[261]: + info 'No key found for /dev/sda2.  Will try 1 time(s) more later.'
        [   24.823243] dracut-initqueue[261]: + check_quiet
    ```

- RHEL 7.x VM with the OS disk encrypted and VFAT disabled:

    ```output
    %G%G[[32m  OK  [0m] Found device Virtual_Disk BEK_VOLUME.
    
             Mounting /bek...
    
    [[1;31mFAILED[0m] Failed to mount /bek.
    
    See 'systemctl status bek.mount' for details.
    ```

- RHEL 8.x VM with the OS disk encrypted and VFAT disabled:

    ```output
    [   11.592932] dracut-initqueue[470]: + systemctl start bek.mount
    [   11.600362] dracut-initqueue[470]: Bus n/a: changing state UNSET → OPENING         Mounting /bek...
    
    [   11.611171] dracut-initqueue[470]: Bus n/a: changing state OPENING → AUTHENTICATING
    [   11.616206] dracut-initqueue[470]: Executing dbus call org.freedesktop.systemd1.Manager StartUnit(bek.mount, replace)
    [   11.622972] dracut-initqueue[470]: Bus n/a: changing state AUTHENTICATING → RUNNING
    [   11.628048] dracut-initqueue[470]: Sent message type=method_call sender=n/a destination=org.freedesktop.systemd1 path=/org/freedesktop/systemd1 interface=org.freedesktop.systemd1.Manager member=StartUnit cookie=1 reply_cookie=0 signature=ss error-name=n/a error-message=n/a
    [   11.639221] dracut-initqueue[470]: Got message type=method_return sender=org.freedesktop.systemd1 destination=n/a path=n/a interface=n/a member=n/a cookie=1 reply_cookie=1 signature=o error-name=n/a error-message=n/a[[0;1;31mFAILED[0m] Failed to mount /bek.
    See 'systemctl status bek.mount' for details.
    ```

- In some old systems, you may see the following error in the Azure serial console:

    > unknown file system type ‘vfat’ error.

All the VMs with this issue will end up stuck at dracut/initramfs and show up at the end of the serial console log:

- **RHEL/CentOS/SLES:**

    ```output
    ///lib/dracut/hooks/emergency/80-\x2fdev\x2fmapper\x2frootvg-rootlv.sh@1(source): warn '/dev/mapper/rootvg-rootlv does not exist'
    //lib/dracut-lib.sh@79(warn): echo 'Warning: /dev/mapper/rootvg-rootlv does not exist'
    Warning: /dev/mapper/rootvg-rootlv does not exist
    /bin/dracut-emergency@19(main): echo
    ...
    /bin/dracut-emergency@29(main): '[' -f /run/dracut/fsck/fsck_help_auto.txt ']'
    /bin/dracut-emergency@30(main): '[' -f /etc/profile ']'
    /bin/dracut-emergency@30(main): . /etc/profile
    //etc/profile@1(source): PS1='dracut:${PWD}# '
    /bin/dracut-emergency@31(main): '[' -z 'dracut:${PWD}# ' ']'
    /bin/dracut-emergency@32(main): exec sh -i -l
    dracut:/# 
    ```

- **Ubuntu:**

    ```output
    Gave up waiting for root file system device.  Common problems:
     - Boot args (cat /proc/cmdline)
       - Check rootdelay= (did the system wait long enough?)
     - Missing modules (cat /proc/modules; ls /dev)
    ALERT!  /dev/mapper/osencrypt does not exist.  Dropping to a shell!
    
    
    BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.4) built-in shell (ash)
    Enter 'help' for a list of built-in commands.
    
    (initramfs)
    ```

To resolve the boot issue, go to [Online troubleshooting](#online-troubleshooting) or [Offline troubleshooting](#offline-troubleshooting).

> [!NOTE]
> If the OS disk isn't encrypted and only the data file systems are encrypted by using ADE, the ADE-encrypted data disks will fail to be mounted because VFAT is disabled. In this case, follow the same steps in [Online troubleshooting](#online-troubleshooting) or [Offline troubleshooting](#offline-troubleshooting) to resolve this issue.

## <a id="online-troubleshooting"></a>Online troubleshooting

> [!TIP]
> If you have a recent backup of the VM before VFAT is disabled, [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

The serial console is the fastest method to resolve this issue. It allows you to directly fix the issue without having to present the system disk to a recovery VM. Make sure you meet the necessary prerequisites for your distribution. For more information, see [Virtual machine serial console for Linux](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux).  

### <a id="online-troubleshooting-nonencrypted"></a> Non-encrypted VMs fail to mount /boot/efi

1. Use the [Azure serial console](/azure/virtual-machines/linux/serial-console#access-serial-console-for-linux) to boot the VM in single-user mode. For more information, see [Use Serial Console to access GRUB and single-user mode](serial-console-grub-single-user-mode.md).

    To boot the VM in single-user mode, interrupt the boot process at the GRUB menu level and edit the main kernel entry to add the `init=/bin/bash` kernel option in the GRUB line that starts with `linux`.

    :::image type="content" source="media/vfat-disabled-boot-issues/boot-singleuser.gif" alt-text="Animated GIF that shows the process of interrupting the boot process at GRUB menu level to boot the system in single-user mode.":::

2. Make sure all the required file systems are mounted and the root is in read and write mode.

    1. If you boot the system by using the `init=/bin/bash` kernel option, prepare the required file systems by running the following commands:

        ```bash
        mount -o rw,remount /
        mount -a
        ```

    2. [Re-enable VFAT](#reenable-vfat).

    3. Restart the system.

> [!NOTE]
> If the VM is Gen1 and it's not encrypted, you could also simply comment out the `/boot/efi` entry from */etc/fstab* as `/boot/efi` isn't needed in Gen1 VMs. For more information, see [Troubleshoot Linux VM starting issues due to fstab errors](linux-virtual-machine-cannot-start-fstab-errors.md).

### <a id="online-troubleshooting-encrypted"></a>ADE encrypted VMs fail to boot up

- **VM with OS disk encrypted:**

  When the OS disk is encrypted, it isn't possible to troubleshoot this issue from the Azure serial console.

- **VM with only data disks encrypted fails to boot due to /etc/fstab issues:**

  1. If only VM data disks are encrypted (the OS disk isn't encrypted), to boot up the system, add the `nofail` mount option to the corresponding entries in */etc/fstab* [from single-user mode](serial-console-grub-single-user-mode.md) by using the Azure serial console. For more information, see [Troubleshoot Linux VM starting issues due to fstab errors](linux-virtual-machine-cannot-start-fstab-errors.md).

  2. Once the VM is booted up, [re-enable VFAT](#reenable-vfat) and restart the VM.

## <a id="offline-troubleshooting"></a>Offline troubleshooting

> [!TIP]
> If you have a recent backup of the VM before VFAT is disabled, [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot issue.

If the [Azure serial console](serial-console-linux.md) doesn't work in the specific VM or isn't an option in your subscription, troubleshoot this issue by using a rescue/repair VM.

### <a id="offline-troubleshooting-nonencrypted"></a>Non-encrypted VMs fail to mount /boot/efi

1. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. [Re-enable VFAT](#reenable-vfat).

3. After the VFAT is re-enabled, perform the following actions:

    1. Exit chroot and unmount the copy of the file systems from the rescue/repair VM.

    2. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

    3. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

> [!NOTE]
> If the VM is Gen1 and it's not encrypted, you could also simply comment out the `/boot/efi` entry from */etc/fstab* as `/boot/efi` isn't needed in Gen1 VMs. For more information, see [Troubleshoot Linux VM starting issues due to fstab errors](linux-virtual-machine-cannot-start-fstab-errors.md).

### <a id="offline-troubleshooting-encrypted"></a>ADE encrypted VMs fail to boot

1. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached.

2. When the VM is encrypted by using ADE, the [Azure VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) take care of unlocking and mounting the encrypted file systems for you. The encrypted file systems will be mounted as `/investigateroot/*` and `/investigateboot`. You can sign in to the repair VM and remount the file systems to the desired mount points by using [chroot](chroot-environment-linux.md).

    > [!NOTE]
    > Alternatively, you can create a rescue VM manually by using the Azure portal and attaching a copy of the encrypted OS disk at VM creation time. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

3. [Re-enable VFAT](#reenable-vfat).

4. After the VFAT is re-enabled, perform the following actions:

    1. Exit chroot and unmount the copy of the file systems from the rescue/repair VM.

    2. Run the `az vm repair restore` command to swap the repaired OS disk with the original OS disk of the VM. For more information, see Step 5 in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

    3. Validate if the VM is able to boot up by taking a look at the Azure serial console or by trying to connect to the VM.

## <a id="reenable-vfat"></a>Re-enable VFAT

1. Identify the files that disable VFAT and the corresponding line numbers by running the following command:

    ```bash
    grep -nr vfat /etc/modprobe.d/
    ```

2. Modify the corresponding file and comment out or delete the VFAT entry. The entry will most commonly be: `install vfat /bin/true`.

    ```bash
    vi /etc/modprobe.d/disable.conf
    ```

    > [!NOTE]
    > Replace `disable.conf` with the corresponding file name where VFAT is disabled.

3. Regenerate the initramfs file by using the following corresponding command:

    - Run the command from the Azure serial console:
    
      - **RHEL/CentOS/Oracle Linux 7/8**
    
        ```bash
        dracut -f /boot/initramfs-$(uname -r).img $(uname -r)
        ```
    
      - **SLES 12/15**
    
        ```bash
        dracut -f /boot/initrd-$(uname -r) $(uname -r)
        ```
    
      - **Ubuntu 18.04**
    
        ```bash
        mkinitramfs -k -o /boot/initrd.img-$(uname -r)
        ```
    
    - Run the command from a repair/rescue VM:
    
        > [!IMPORTANT]
        > Make sure step 1 in [Offline troubleshooting](#offline-troubleshooting) is followed and these commands are executed inside [chroot](chroot-environment-linux.md).
    
      - **RHEL/CentOS/Oracle Linux 7/8**
    
        ```bash
        dracut -f /boot/initramfs-3.10.0-1160.59.1.el7.x86_64.img 3.10.0-1160.59.1.el7.x86_64
        ```
    
        > [!IMPORTANT]
        > Replace `3.10.0-1160.59.1.el7.x86_64` with the corresponding kernel version.
    
      - **SLES 12/15**
    
        ```bash
        dracut -f /boot/initrd-5.3.18-150300.38.53-azure 5.3.18-150300.38.53-azure
        ```
    
        > [!IMPORTANT]
        > Replace `5.3.18-150300.38.53-azure` with the corresponding kernel version.
    
      - **Ubuntu 18.04**
    
        ```bash
        mkinitramfs -k -o /boot/initrd.img-5.4.0-1077-azure
        ```
    
        > [!IMPORTANT]
        > Replace `5.4.0-1077-azure` with the corresponding kernel version.

## Next steps

If the specific boot error isn't a VFAT disabled issue, see [Troubleshoot Azure Linux Virtual Machines boot errors](./boot-error-troubleshoot-linux.md) for further troubleshooting options.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
