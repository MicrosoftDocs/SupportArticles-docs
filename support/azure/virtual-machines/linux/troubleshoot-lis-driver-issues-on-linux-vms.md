---
title: Troubleshoot LIS/Hyper-V Driver Issues on Linux Virtual Machines
description: Provides solutions to Azure Linux VM issues that occur because Hyper-V drivers are missing or disabled.
ms.date: 02/26/2025
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.custom: sap:My VM is not booting, linux-related-content
---
# Troubleshoot LIS/Hyper-V driver issues on Linux virtual machines

**Applies to:** :heavy_check_mark: Linux VMs

When you run a Linux Virtual Machine (VM) on Azure, the Hyper-V drivers, also known as Linux Integration Services (LIS) drivers, are crucial for proper VM operations. These drivers allow the VM to communicate with the underlying Azure hypervisor. If these drivers are missing or not properly loaded, the VM might fail to boot. This article provides solutions to LIS/Hyper-V driver issues in Azure Linux VMs.

## Prerequisites

- Access to [Azure Command-Line Interface (CLI)](/cli/azure/)
- Ability to create a repair/rescue VM
- Serial console access
- Familiarity with Linux commands and system administration

## Symptoms

In one of the following scenarios, Linux VMs might fail to boot because Hyper-V drivers are missing or disabled:

- After you migrate a Linux VM from on-premises to Azure.

    When a VM is migrated to Azure from another hypervisor (such as VMware or Kernel-based Virtual Machine (KVM)), the necessary Hyper-V drivers `hv_vmbus`, `hv_storvsc`, `hv_netvsc`, and `hv_utils` might not be installed or enabled, preventing the VM from detecting storage and network devices.

- After you disable the Hyper-V drivers and reboot the VM.
- When the Hyper-V drivers aren't included in the initramfs.

When you review the serial console logs for various Linux VMs (Red Hat, Oracle, SUSE, or Ubuntu), the following issues are commonly observed:

| Symptom                               | Description |
|--------------------------------------|------------------------------------------------------------------|
| **VM Stuck at dracut/initramfs** | VM fails to boot and drops into an initramfs shell or emergency mode due to missing storage drivers. |
| **Kernel Panic on Boot** | System crashes during boot due to missing critical Hyper-V modules. |
| **Disk Not Found Errors** | Boot process fails with errors like `cannot find root device` or `unable to mount root filesystem`. |
| **No Network Connectivity** | Even if the VM boots, network interfaces might not be detected, preventing Secure Shell (SSH) access. |
| **Grub Boot Failure** | The system might fail to load the bootloader due to missing Hyper-V storage drivers. |
| **Slow Boot with ACPI Errors** | VM might take a long time to boot with Advanced Configuration and Power Interface (ACPI) related warnings caused by missing Hyper-V support. |
| **Failure to Attach Azure Disks** | Azure managed disks might not be recognized or mounted correctly due to missing storage drivers. |
| **Cloud-Init or Waagent Failures** | Azure provisioning tools (`cloud-init` or `waagent`) might fail to configure the VM properly. |

Here are log entry examples:

- Output 1

    ```output
    [  201.568597] dracut-initqueue[351]: Warning: dracut-initqueue: starting timeout scripts
    [  202.086401] dracut-initqueue[351]: Warning: dracut-initqueue: timeout, still waiting for following initqueue hooks:
    [  202.097772] dracut-initqueue[351]: Warning: /lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fmapper\x2frootvg-rootlv.sh: "if ! grep -q After=remote-fs-pre.target /run/systemd/generator/systemd-cryptsetup@*.service 2>/dev/null; then
    [  202.128885] dracut-initqueue[351]:     [ -e "/dev/mapper/rootvg-rootlv" ]
    [  202.138322] dracut-initqueue[351]: fi"
    [  202.142466] dracut-initqueue[351]: Warning: dracut-initqueue: starting timeout scripts
    [  202.674872] dracut-initqueue[351]: Warning: dracut-initqueue: timeout, still waiting for following initqueue hooks:
    [  202.692200] dracut-initqueue[351]: Warning: /lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fmapper\x2frootvg-rootlv.sh: "if ! grep -q After=remote-fs-pre.target /run/systemd/generator/systemd-cryptsetup@*.service 2>/dev/null; then
    [  202.724308] dracut-initqueue[351]:     [ -e "/dev/mapper/rootvg-rootlv" ]
    [  202.731292] dracut-initqueue[351]: fi"
    [  202.732288] dracut-initqueue[351]: Warning: dracut-initqueue: starting timeout scripts
    [  202.740791] dracut-initqueue[351]: Warning: Could not boot.
             Starting Dracut Emergency Shell...
    Warning: /dev/mapper/rootvg-rootlv does not exist
    Generating "/run/initramfs/rdsosreport.txt"
    Entering emergency mode. Exit the shell to continue.
    Type "journalctl" to view system logs.
    You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
    after mounting them and attach it to a bug report.
    dracut:/# 
    dracut:/# 
    dracut:/# 
    ```

- Output 2

    ```output
    Gave up waiting for root file system device.  Common problems:
     - Boot args (cat /proc/cmdline)
       - Check rootdelay= (did the system wait long enough?)
     - Missing modules (cat /proc/modules; ls /dev)
    ALERT!  UUID=143c811b-9b9c-48f3-b0c8-040f6e65f50aa does not exist.  Dropping to a shell!
    BusyBox v1.27.2 (Ubuntu 1:1.27.2-2ubuntu3.4) built-in shell (ash)
    Enter 'help' for a list of built-in commands.
    (initramfs)
    ```

If running `cat /proc/partitions` in the dracut shell doesn't display any storage devices, it indicates that the Hyper-V storage driver `hv_storvsc` is missing or not loaded. Without this driver, the VM can't detect its virtual disks, leading to a boot failure.

```bash
dracut:/# cat /proc/partitions 
dracut:/# 
dracut:/# 
```

## Cause

If LIS/Hyper-V drivers are missing or not correctly loaded, the VM might not start because of the following reasons:

- Missing disk and network drivers

    Azure VMs rely on Hyper-V storage and network drivers (for example, `hv_storvsc` and `hv_netvsc`). Without these drivers, the VM can't detect its operating system (OS) disk, leading to a boot failure.

- Lack of synthetic device support

    Azure VMs use synthetic devices (for example, for storage and networking), which require Hyper-V drivers. Without these drivers, the kernel might not recognize critical components.

- Hyper-V VMBus communication failure

    Essential components like `hv_vmbus` handle communication between the VM and Azure hypervisor. If this driver is missing, the VM can't properly initialize.

- Kernel panic or initramfs prompt

    Without the necessary drivers, the VM might drop to an initramfs shell due to the inability to mount the root filesystem, causing a boot failure.


## Solution 1: Enable Hyper-V drivers

> [!NOTE]
> This solution applies to the scenario where Hyper-V drivers are disabled.

1. Use [VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached.

     > [!NOTE]
     > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).
3. Once the chroot process is completed, go to the */etc/modprobe.d* directory.
4. Identify the file that disables the `hv_` driver and the corresponding line numbers:

    ```bash
    grep -nr "hv_" /etc/modprobe.d/
    ```

5. Modify the corresponding file and comment out or delete the `hv_` entries:

    ```bash
    vi /etc/modprobe.d/disable.conf
    ```

    > [!NOTE]
    > - The entries that disable drivers are defined by the Linux OS instead of Microsoft.
    > - Replace `disable.conf` with the corresponding file name where the `hv_` driver is disabled.

## Solution 2: Regenerate missing Hyper-V drivers in the initramfs

> [!NOTE]
> This solution applies to the scenario where Hyper-V drivers are missing from the initramfs after the VM migration from on-premise to Azure.

1. Use [VM repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached.

     > [!NOTE]
     > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).

2. Mount the copy of the OS file systems in the repair VM by using [chroot](chroot-environment-linux.md).
3. Once the chroot process is completed, verify if `hv_` drivers are missing on the current kernel:

     - For RHEL-based images:
        
        ```bash
        lsinitrd /boot/initramfs-<kernel-version>.img | grep -i hv_
        ```
    - For SLES-based images:
    
       ```bash
       lsinitrd /boot/initrd-<versión-del-kernel> | grep -i hv_
       ```
    - For Ubuntu/Debian-based images:
        
        ```bash
        lsinitrd /boot/initrd.img-$(uname -r)  | grep -i hv_
        ```

    > [!NOTE]
    > The Hyper-V storage driver `hv_storvsc` or others might not appear in initramfs because it's sometimes built directly into the kernel, especially in Azure-optimized kernels. In such cases, the system loads it automatically at boot, ensuring storage functionality. If the VM boots and detects storage correctly, no action is needed.

3. Edit the */etc/dracut.conf* or */etc/initramfs-tools/modules* file, depending on your Linux distribution, and add the following line to the file:

     - For RHEL/SLES-based images:

       ```bash
       vi /etc/dracut.conf
       ```

       ```output
       add_drivers+=" hv_vmbus hv_netvsc hv_storvsc "
       ```

     - For Ubuntu/Debian-based images:

       ```bash
       vi /etc/initramfs-tools/modules
       ```

       ```output
       hv_vmbus
       hv_netvsc
       hv_storvsc
       ```

4. Rebuild the initial RAM disk image for your affected kernel by following the steps in [Regenerate missing initramfs manually](kernel-related-boot-issues.md#missing-initramfs-manual).

## FAQ

### If I'm experiencing some issues, such as connectivity, how can I make sure that the network driver, hv_netvsc, is working as expected after a fresh start or restart of the system?

To confirm that the Hyper-V network driver (`hv_netvsc`) is active and functional, check the system logs and look for the following entry:

```output
*hv\_vmbus: registering driver hv\_netvsc*
```

This message indicates that the driver registration process has started. If no further errors are reported after it, the driver has been successfully loaded and is functioning correctly. This indicates that the synthetic network interface provided by Hyper-V was detected, and the driver is properly handling the network connection.

## References

- [Create and upload a generic Linux Virtual Machine to Azure](/azure/virtual-machines/linux/create-upload-generic)
- [A Linux VM doesn't start correctly with kernel 3.10.0-514.16 after an LIS upgrade](linux-vm-not-start-kernel-lis.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
