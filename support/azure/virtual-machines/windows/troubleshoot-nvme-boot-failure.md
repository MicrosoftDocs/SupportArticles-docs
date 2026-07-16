---
title: Troubleshoot VM boot failure after SCSI-to-NVMe disk controller change
description: Fix VM boot failure after a SCSI-to-NVMe controller change, including Windows BSOD and Linux kernel panic scenarios; use the recovery steps now.
services: virtual-machines
author: kaushika-msft
ms.service: azure-virtual-machines
ms.collection: windows, linux
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.topic: troubleshooting
ms.date: 04/16/2026
ms.author: glimoli
ms.reviewer: saimsh, divargas, kageorge, scotro, ruedward, sukon, msaenzbo
ms.custom: sap:My VM is not booting
---

# Troubleshoot VM boot failure after SCSI-to-NVMe disk controller change

## Summary

This article helps you resolve boot failures that occur after an Azure virtual machine's (VM's) disk controller type changes from Small Computer System Interface (SCSI) to NVM Express (NVMe). This change usually happens due to a VM resize, manual conversion, or deployment on an NVMe-default VM size.

## Symptoms

After resizing a VM from a SCSI-based size (for example, v3, v4) to an NVMe-default size (for example, v5, v6, v7), or after manually changing the disk controller type to NVMe, the VM fails to boot.

### Windows symptoms

| Symptom | Stop Code | Description |
|---------|-----------|-------------|
| Blue screen (BSOD) | **0x7B — INACCESSIBLE_BOOT_DEVICE** | The Windows kernel can't find the boot disk because the NVMe storage driver (`stornvme.sys`) isn't loaded in the boot configuration. |
| Blue screen (BSOD) | **0xED — UNMOUNTABLE_BOOT_VOLUME** | The operating system (OS) locates the boot device but can't mount the NTFS file system under the NVMe controller. |
| Blue screen (BSOD) | **0xEF — CRITICAL_PROCESS_DIED** | The storage stack fails during early boot initialization. |
| VM stuck in "Starting" | Not applicable (N/A) | The VM never reaches the running state and CRP reports `OSProvisioningTimedOut`. |
| Black screen in boot diagnostics | Not applicable (N/A) | No output beyond Unified Extensible Firmware Interface (UEFI) or Basic Input/Output System (BIOS). The OS fails before producing console output. |

### Linux symptoms

| Symptom | Description |
|---------|-------------|
| Kernel panic — "VFS: Unable to mount root fs" | The initial RAM filesystem (initramfs) doesn't include `nvme.ko` or `nvme-core.ko` kernel modules. |
| Dracut timeout | The boot loader can't find disks using the NVMe controller. |
| VM stuck in "Starting" | The guest OS never signals readiness to the Azure platform. |
| Missing data disks | The VM boots (OS disk works) but data disks aren't visible in `lsblk` or Disk Manager. |

## Cause

When a VM's disk controller type changes from SCSI to NVMe, the OS must have the appropriate NVMe storage driver loaded in its boot configuration as demonstrated in the following examples:

- **Windows**: `stornvme.sys` must be registered as a boot-start driver.
- **Linux**: Include `nvme.ko` and `nvme-core.ko` in the initramfs or initial ramdisk (initrd).

If these drivers aren't present, the OS can't access the boot disk through the NVMe controller and fails immediately.

### Common triggers

| Trigger | Description |
|---------|-------------|
| **VM resize** | Resizing from `Standard_D4s_v3` (SCSI) to `Standard_D4s_v5` (NVMe default) and the disk controller type changes without notice. |
| **Manual conversion** | Running `az vm update --disk-controller-type NVMe` or `$vm.StorageProfile.DiskControllerType = "NVMe"` without verifying driver readiness. |
| **New VM from custom image** | Deploying a custom image (built on SCSI) to an NVMe-default VM size and the image lacks NVMe drivers in the boot path. |
| **Conversion script** | Using a SCSI-to-NVMe conversion script without pre-flight driver validation. |

### Affected OS versions

| OS | NVMe Support |
|----|-------------|
| Windows Server 2022, 2025 | ✅ `stornvme.sys` included by default |
| Windows Server 2019 | ✅ `stornvme.sys` included by default |
| Windows Server 2016 | ✅ `stornvme.sys` included (might need Windows Update) |
| **Windows Server 2012 R2** | ❌ **Not supported** — no native NVMe driver |
| **Windows Server 2012, 2008** | ❌ **Not supported** |
| Windows 10/11 | ✅ `stornvme.sys` included by default |
| Ubuntu 18.04+ | ✅ NVMe modules included in default initramfs |
| RHEL/CentOS 7.4+ | ✅ NVMe modules available (might need initramfs rebuild) |
| SLES 12 SP3+ | ✅ NVMe modules available |
| Older Linux kernels (<4.15) | ⚠️ Might require manual module installation |

## Resolution

### Option 1: Revert disk controller type to SCSI (fastest recovery)

If the VM isn't booting, revert the disk controller type back to SCSI. Use Azure CLI or PowerShell to run the following commands.

1. Stop the VM (if not already stopped).

**Azure CLI**

```azurecli
   az vm stop --resource-group myRG --name myVM
   az vm deallocate --resource-group myRG --name myVM
```

2. Change the disk controller type back to SCSI.

**Azure CLI**

```azurecli
   az vm update --resource-group myRG --name myVM --disk-controller-type SCSI
```

**PowerShell**

```powershell
   $vm = Get-AzVM -ResourceGroupName "myRG" -Name "myVM"
   $vm.StorageProfile.DiskControllerType = "SCSI"
   Update-AzVM -ResourceGroupName "myRG" -VM $vm
```

3. Resize the SCSI-based VM size back to the original size (as needed).

**Azure CLI**

```azurecli
   az vm resize --resource-group myRG --name myVM --size Standard_D4s_v3
```

4. Start the VM.
   
**Azure CLI**

```azurecli
   az vm start --resource-group myRG --name myVM
```

### Option 2: Install NVMe drivers by using a rescue VM (Windows)

If you need to keep the VM on an NVMe-capable size, install the NVMe driver offline.

1. Stop and deallocate the failed VM.
1. Create a rescue VM on a SCSI-based size (for example, `Standard_D2s_v3`).
1. Attach the OS disk of the failed VM as a data disk on the rescue VM.
1. On the rescue VM, use PowerShell to load the `stornvme.sys` driver into the attached disk's boot configuration.

```powershell
   # Identify the drive letter of the attached OS disk (e.g., F:)
   $offlineDrive = "F:"

   # Load the offline registry hive
   reg load HKLM\OFFLINE "$offlineDrive\Windows\System32\config\SYSTEM"

   # Check if stornvme is already registered
   reg query "HKLM\OFFLINE\ControlSet001\Services\stornvme"

   # If not present, create the service entry
   reg add "HKLM\OFFLINE\ControlSet001\Services\stornvme" /v Start /t REG_DWORD /d 0 /f
   reg add "HKLM\OFFLINE\ControlSet001\Services\stornvme" /v Type /t REG_DWORD /d 1 /f
   reg add "HKLM\OFFLINE\ControlSet001\Services\stornvme" /v ErrorControl /t REG_DWORD /d 1 /f
   reg add "HKLM\OFFLINE\ControlSet001\Services\stornvme" /v ImagePath /t REG_EXPAND_SZ /d "System32\drivers\stornvme.sys" /f
   reg add "HKLM\OFFLINE\ControlSet001\Services\stornvme" /v Group /t REG_SZ /d "SCSI miniport" /f

   # Unload the hive
   reg unload HKLM\OFFLINE
```

5. Verify that `stornvme.sys` exists at `$offlineDrive\Windows\System32\drivers\stornvme.sys`. If not, copy it from `C:\Windows\System32\drivers\stornvme.sys` on the rescue VM.
6. Detach the OS disk from the rescue VM.
7. Reattach the rescue VM's OS disk as the OS disk on the original VM.
8. Set the disk controller type to NVMe and start the VM.

### Option 3: Rebuild initramfs by using a rescue VM (Linux)

To fix a Linux VM, complete the following steps:

 - Deallocate the failed VM. 
 - Create a rescue VM that has access to the failed VM's OS disk. 
 - Rebuild the initramfs image in a chroot environment.

#### Step 1: Deallocate the failed VM

Deallocate the failed VM before you attach its OS disk to a rescue VM. 

For more information, see [What's the difference between deallocated and stopped?](/answers/questions/574969/whats-the-difference-between-deallocated-and-stopp)

#### Step 2: Create a rescue VM

Create a rescue VM and attach the failed VM's OS disk as a data disk. Use either of the following methods.

**Method 1: Create the rescue VM automatically (recommended)**

Run the `az vm repair create` command to automatically create a rescue VM and attach a copy of the failed VM's OS disk as a data disk.

```azurecli
az vm repair create --verbose --resource-group <resource-group> --name <vm-name> --repair-username <username> --repair-password '<password>'
```

For more information, see [Repair a Linux VM by using the Azure Virtual Machine repair commands](../linux/repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

**Method 2: Create the rescue VM manually**

1. Create a rescue VM by using any available Linux VM.
1. Attach the OS disk of the failed VM as a data disk.

#### Step 3: Rebuild initramfs in a chroot environment

1. Use a command-line interface (CLI) tool to mount the OS disk and enter the [`chroot`](../linux/chroot-environment-linux.md) environment. The following commands show the general setup for a Linux image that uses raw (non-Logical Volume Manager (LVM)) partitions. Adjust the partition devices (for example, `/dev/sdc2`, `/dev/sdc1`) to match your OS disk layout:

   ```bash
   mkdir /rescue
   mount -o nouuid /dev/sdc2 /rescue
   mount -o nouuid /dev/sdc1 /rescue/boot/
   mount /dev/sdc15 /rescue/boot/efi   # Only if a separate EFI system partition exists. Adjust the device as needed.

   mount -t proc /proc /rescue/proc
   mount -t sysfs /sys /rescue/sys
   mount -o bind /dev /rescue/dev
   mount -o bind /dev/pts /rescue/dev/pts
   mount -o bind /run /rescue/run
   chroot /rescue
   ```

   > [!NOTE]
   > Partition numbers and mount commands vary by Linux distribution and disk layout. If your OS disk uses LVM or a different distribution (for example, Ubuntu, Oracle Linux, or SUSE Linux Enterprise Server), see [Chroot environment in a Linux rescue VM](../linux/chroot-environment-linux.md) for the exact steps that apply to your scenario.

2. Rebuild the initramfs image so that it includes the NVMe modules. The exact steps depend on your Linux distribution.

   **RHEL, CentOS, or SLES 12 SP3+**

   1. Determine the kernel version of the failed VM's OS disk (not the rescue VM). Select the latest kernel version that's installed on the attached OS disk:

      ```bash
      KVER=$(ls -1 /lib/modules | sort -V | tail -n 1)
      echo "Using kernel: $KVER"
      ```

      Alternatively, if you know the exact kernel version in use, set it manually:

      ```bash
      KVER="<full-kernel-version>"
      ```

   2. Add the NVMe modules to a persistent dracut configuration file. This configuration ensures that the modules are included again whenever a future kernel update rebuilds the initramfs image:

      ```bash
      cat > /etc/dracut.conf.d/azure-nvme.conf <<'EOF'
      add_drivers+=" nvme nvme_core "
      EOF
      ```

   3. Rebuild the initramfs image for the selected kernel version.

      ```bash
      dracut --force "/boot/initramfs-${KVER}.img" "${KVER}"
      ```

   **Ubuntu or Debian**

   1. Determine the kernel version of the failed VM's OS disk (not the rescue VM). Select the latest kernel version that's installed on the attached OS disk:

      ```bash
      KVER=$(ls -1 /lib/modules | sort -V | tail -n 1)
      echo "Using kernel: $KVER"
      ```

      Alternatively, if you know the exact kernel version, set it manually:

      ```bash
      KVER="<full-kernel-version>"
      ```

   2. Add the NVMe modules to the initramfs configuration so that they're included in current and future initramfs rebuilds:

      ```bash
      echo "nvme" >> /etc/initramfs-tools/modules
      echo "nvme_core" >> /etc/initramfs-tools/modules
      ```

   3. Rebuild the initramfs image for the selected kernel version.

      ```bash
      update-initramfs -u -k "${KVER}"
      ```

1. Exit the chroot environment and unmount the OS disk.

   ```bash
   exit
   sudo umount /rescue/sys
   sudo umount /rescue/proc
   sudo umount /rescue/dev
   sudo umount /rescue/boot/efi
   sudo umount /rescue/boot
   sudo umount /rescue
   ```

4. Swap the repaired OS disk to the original VM, and then start the VM. Use either of the following methods.

   **Method 1: Use the Azure Virtual Machine repair commands (recommended)**

   If you created the rescue VM by using the `az vm repair create` command, run the `az vm repair restore` command. This command swaps the repaired disk back to the original VM, starts the VM, and removes the rescue VM resources.

   ```azurecli
   az vm repair restore --verbose --resource-group <resource-group> --name <vm-name>
   ```

   **Method 2: Swap the disk manually**

   1. Detach the repaired OS disk from the rescue VM.
   1. On the original VM, use the **Swap OS disk** option in the [Azure portal](https://portal.azure.com) to replace its OS disk with the repaired disk.
   1. Start the original VM.

## Prevention

To prevent this issue in the future:

- **Always verify NVMe driver readiness before resizing**. For more information, see [NVMe FAQ: Pre-resize checklist](/azure/virtual-machines/enable-nvme-remote-faqs).
- **Create an OS disk snapshot** before any resize to an NVMe-capable size.
- **Use the safe conversion script**: [Convert-AzVMToNVMe.ps1](https://github.com/Azure/azure-support-scripts). This script includes preflight validation and automatic snapshots.
- **Don't deploy custom images to NVMe sizes** without testing them on an NVMe VM first.
- **Windows Server 2012 R2 doesn't support NVMe**. Don't attempt conversion.

## References

- [NVMe overview for Azure VMs](/azure/virtual-machines/nvme-overview)
- [NVMe FAQ](/azure/virtual-machines/enable-nvme-remote-faqs)
- [NVMe for Linux VMs](/azure/virtual-machines/nvme-linux)
- [VM sizes that support NVMe](/azure/virtual-machines/nvme-overview#supported-vm-sizes)
- [Repair a Linux VM by using the Azure Virtual Machine repair commands](../linux/repair-linux-vm-using-azure-virtual-machine-repair-commands.md)
- [Use the chroot environment to repair a Linux VM](../linux/chroot-environment-linux.md)