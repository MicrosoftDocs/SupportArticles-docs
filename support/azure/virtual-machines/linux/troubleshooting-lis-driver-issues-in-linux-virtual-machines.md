---
title: Troubleshooting LIS Driver Issues on Linux Virtual Machines in Azure
description: Provides a solution to Azure Linux VM issues because of missing Hyper-V drivers in Azure.
ms.date: 02/24/2025
ms.author: msaenzbo
ms.reviewer: divargas
ms.topic: troubleshooting-general
ms.workload: infrastructure-services
ms.service: azure-virtual-machines
ms.tgt_pltfrm: vm-linux
ms.custom: sap:My VM is not booting, linux-related-content
---

# Troubleshooting LIS driver issues on Linux Virtual Machines in Azure

**Applies to:** :heavy_check_mark: Linux VMs

When you run a Linux virtual machine (VM) on Microsoft Azure, the Hyper-V drivers (also known as LIS - Linux Integration Services) are essential for proper VM operation. These drivers enable the VM to communicate with the underlying Azure hypervisor. If they're missing or not correctly loaded, the VM might not start because of the following reasons:

- Missing disk and network drivers: Azure VMs rely on Hyper-V storage and network drivers (for example, hv_storvsc, hv_netvsc). Without these drivers, the VM can't detect its OS disk.

- Lack of synthetic device support: Azure VMs use synthetic devices (for example, for storage and networking) that require Hyper-V drivers. Without these devices, the kernel might not recognize critical components.

- Hyper-V bus communication Failure: Essential components such as hv_vmbus handle communication between the VM and the Azure hypervisor. If this driver is missing, the VM can't correctly initialize.

- Kernel panic or initramfs prompt: Without the necessary drivers, the VM might drop to an initramfs shell because it can't mount the root file system.

## Prerequisites

- Access to az-cli
- Access to create a rescue VM
- Serial console access
- Familiarity with Linux commands and system administration

## Symptoms

The following issues can occur because of missing Hyper-V drivers in Azure:

- After you migrate a Linux VM from on-premises to Azure, the VM doesn't start correctly.

- After you disable the hyperv-drivers and restart the VM.

- If the Hyper-V drivers are not included in the initramfs, the VM doesn't start.

When you review the serial console logs for various Linux VMs (Red Hat, Oracle, SUSE, or Ubuntu), you might find entries for any of the following common issues.

| Symptom                               | Description |
|--------------------------------------|------------------------------------------------------------------|
| **VM Stuck at dracut/initramfs** | The VM doesn't start and drops into an initramfs shell or emergency mode because of missing storage drivers. |
| **Kernel Panic on Boot** | System doesn't respond during startup because of missing critical Hyper-V modules. |
| **Disk Not Found Errors** | Startup process fails and returns error messages such as "cannot find root device" or "unable to mount root filesystem." |
| **No Network Connectivity** | Even if the VM boots, network interfaces might not be detected. This situation prevents SSH access. |
| **Grub Boot Failure** | The system might not load the bootloader because of missing Hyper-V storage drivers. |
| **Slow Boot with ACPI Errors** | The VM might take a long time to start and might generate ACPI-related warnings that are caused by missing Hyper-V support. |
| **Failure to Attach Azure Disks** | Azure-managed disks might not be recognized or mounted correctly because of missing storage drivers. |
| **Cloud-Init or Waagent Failures** | Azure provisioning tools (`cloud-init` or `waagent`) might not configure the VM correctly. |


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


If running `cat /proc/partitions` in the dracut shell doesn't display any storage devices, it indicates that the Hyper-V storage driver `hv_storvsc` is missing or not loaded. Without this driver, the VM can't detect its virtual disks, leading to a boot failure

- Output 2

```bash
dracut:/# cat /proc/partitions 
dracut:/# 
dracut:/# 
```

## Cause

When you run a Linux virtual machine on Azure, Hyper-V drivers are crucial for communication with the underlying hypervisor. If these drivers are missing, disabled, or not correctly loaded, the VM might not start. This issue is common if a VM is migrated to Azure from another hypervisor, such as `VMware` or `KVM`. In these cases, the necessary Hyper-V drivers (`hv_vmbus, hv_storvsc, hv_netvsc, hv_utils`) might not be installed or enabled. This situation prevents the VM from detecting storage and network devices.

## Resolution

If you're experiencing any of these issues, follow the steps in the relevant "Resolution" section. The instructions are divided into two scenarios: one for cases in which Hyper-V modules are disabled and one for cases in which Hyper-V modules are missing from initramfs after migration.


### Scenario 1: Hyper-V modules disabled


1. Troubleshoot this issue by using a rescue (also known as "repair" or "recovery") VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems to the repair VM by using [chroot](chroot-environment-linux.md).

 > [!NOTE]
 > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see: [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).


2. After the chroot process is finished, go to the `/etc/modprobe.d` directory, and then locate any line that disables the `hv_ `.

      1. Identify the file that disables the `hv_` driver and the corresponding line numbers by running the following command:

      ```bash
      grep -nr "hv_" /etc/modprobe.d/
      ```

      2. Modify the corresponding file and comment out or delete the `hv_` entries:

      ```bash
      vi /etc/modprobe.d/disable.conf
      ```

    > [!NOTE]
    > - The Linux Operating System, not Microsoft, defines the entries that disable drivers.
    > - Replace `disable.conf` with the corresponding filename on a line where the `hv_` driver is disabled.

3. Rebuild the initial RAMdisk image for your affected kernel by following [Regenerate missing initramfs manually](/troubleshoot/azure/virtual-machines/linux/kernel-related-boot-issues#missing-initramfs-manual)

   
### Scenario 2: Hyper-V modules missing on initramfs after OS migration from on-premise to Azure


1. Troubleshoot this issue by using a rescue VM. Use [vm repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md) to create a rescue VM that has a copy of the affected VM's OS disk attached. Mount the copy of the OS file systems to the repair VM by using [chroot](chroot-environment-linux.md).

 > [!NOTE]
 > Alternatively, you can create a rescue VM manually by using the Azure portal. For more information, see: [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-linux.md).


2. After the chroot process is finished, check whether `hv_` modules are missing on the current kernel:

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
        >The Hyper-V storage driver, `hv_storvsc` or others, might not appear in initramfs because it's sometimes built directly into the kernel. This is especially true in Azure-optimized kernels. In such cases, the system loads the driver automatically at startup to ensure storage functionality. If the VM starts and detects storage correctly, no further action is necessary.


 3. Edit the `/etc/dracut.conf` or `/etc/initramfs-tools/modules` file, depending on your Linux distribution. Then, add the following line to the file:

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

4. Rebuild the initial RAMdisk image for your affected kernel by following the steps in [Regenerate missing initramfs manually](/troubleshoot/azure/virtual-machines/linux/kernel-related-boot-issues#missing-initramfs-manual).


## More resources

- [Create and Upload a Generic Linux Virtual Machine to Azure](/azure/virtual-machines/linux/create-upload-generic)

- [A Linux VM doesn't start correctly with kernel 3.10.0-514.16 after an LIS upgrade](/troubleshoot/azure/virtual-machines/linux/linux-vm-not-start-kernel-lis)


## FAQ


### If I'm experiencing some issue, such as connectivity, how can I make sure that the network driver, `hv_netvsc`, is working as expected after a fresh start or restart of the system?

To verify that the `hv_netvsc` (Hyper-V network driver) is active and functional after a system restart, check the system logs, and look for the following entry:

```output
*hv_vmbus: registering driver hv_netvsc* 
```

This message indicates that the driver registration process started. If no additional errors are reported after this line, the driver is successfully loaded and in a functional state. Therefore, the synthetic network interface that's provided by Hyper-V was detected, and the driver is correctly handling the network connection.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
