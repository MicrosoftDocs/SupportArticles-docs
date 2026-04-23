---
title: Convert an Azure VM disk from MBR to GPT partition style
description: Hit the 2 TiB limit on an Azure VM disk? Learn how to convert MBR to GPT for data and OS disks and restore full usable capacity.
ms.reviewer: scotro, v-leedennis
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Convert an Azure VM disk from MBR to GPT partition style

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you resolve the issue where an Azure virtual machine (VM) disk that uses Master Boot Record (MBR) partition style can't use more than two (2) tebibytes (TiB) of space, even after you expand the disk beyond 2 TiB in the Azure portal.

## Symptoms

After you expand a managed disk beyond 2 TiB in the [Azure portal](https://portal.azure.com), one or more of the following symptoms occur:

- Disk Management shows only 2 TiB of the disk's total capacity. The remaining space isn't visible.
- You can't create partitions larger than 2 TiB.
- The volume shows the correct size in the Azure portal but not inside the VM.

## Cause

MBR partition tables use 32-bit Logical Block Addressing (LBA), which limits the maximum addressable disk size to 2 TiB (2,199,023,255,552 bytes). The operating system can't access space beyond this limit.

GUID Partition Table (GPT) uses 64-bit LBA and supports disks up to 18 exabytes (EB).

## Diagnostic steps

### Check the partition style

1. Open **Disk Management** (press Windows+R, type `diskmgmt.msc`, and press Enter).
1. In the lower pane, right-click the disk label (for example, **Disk 0** or **Disk 1**) and select **Properties**.
1. Select the **Volumes** tab.
1. Check the **Partition style** value:
   - **Master Boot Record (MBR)**: This disk is affected. Proceed with conversion.
   - **GUID Partition Table (GPT)**: This disk isn't affected. The issue has a different cause.

### Check using PowerShell

Run the following command to list all disks and their partition styles:

```powershell
Get-Disk | Select-Object Number, FriendlyName, PartitionStyle, Size | Format-Table
```

Look for `MBR` in the **PartitionStyle** column for disks larger than 2 TiB.

## Resolution

The conversion approach depends on whether the disk is a data disk or an operating system (OS) disk.

### Convert a data disk (destructive method)

> [!WARNING]
> This method erases all data on the disk. Back up your data before you proceed.

1. Back up all data from the data disk.

1. Open **Command Prompt** as administrator and start DiskPart:

   ```cmd
   diskpart
   list disk
   select disk <N>
   ```

   Replace `<N>` with the disk number from the list.

1. Clean and convert the disk:

   ```cmd
   clean
   convert gpt
   create partition primary
   format fs=ntfs quick label="Data"
   assign letter=<drive-letter>
   exit
   ```

1. Restore your data to the new GPT disk.

1. Open **Disk Management** and verify that the full disk capacity is visible.

### Convert an OS disk by using MBR2GPT (non-destructive method)

The `mbr2gpt.exe` tool converts an OS disk from MBR to GPT without data loss. This tool is built into Windows.

#### Prerequisites

- **Windows Server 2019 or later**, or Windows 10 version 1703 or later. Windows Server 2016 doesn't include `mbr2gpt.exe`.
- The VM must support Unified Extensible Firmware Interface (UEFI) boot. Generation 1 (Gen1) VMs need to be [upgraded to Trusted Launch](/azure/virtual-machines/trusted-launch-existing-vm-gen-1) first.
- The disk must have at most three primary partitions. MBR supports up to four, but MBR2GPT requires at least one free slot for the Extensible Firmware Interface (EFI) System Partition.

#### Solution

Perform the following steps to convert the OS disk from MBR to GPT:

1. Connect to the VM by using Remote Desktop Protocol (RDP).

1. Take a snapshot of the OS disk in the Azure portal before you proceed.

1. Open **Command Prompt** as Administrator.

1. Validate that the disk is eligible for conversion by running the following command:

   ```cmd
   mbr2gpt /validate /disk:0 /allowFullOS
   ```

   If validation succeeds, you see the message "Validation completed successfully."

1. Convert the disk:

   ```cmd
   mbr2gpt /convert /disk:0 /allowFullOS
   ```

1. After a successful conversion, restart the VM.

1. Open **Disk Management** and verify:
   - The **Partition style** on the **Volumes** tab now shows **GUID Partition Table (GPT)**.
   - The full disk capacity is visible.
   - An **EFI System Partition** is created.

> [!IMPORTANT]
> After converting the OS disk, verify that the VM boots correctly. If the VM doesn't boot, use [Azure Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows) or a [repair VM](/troubleshoot/azure/virtual-machines/windows/repair-windows-vm-using-azure-virtual-machine-repair-commands) to troubleshoot.

### Special considerations for SQL Server VMs

For SQL Server VMs deployed from Azure Marketplace that use Storage Spaces:

- Don't convert data disks in place. Storage Spaces pools manage the underlying disks.
- Instead, create new, larger GPT data disks, add them to the Storage Spaces pool, and use the SQL Server configuration blade to extend the volume.

For more information, see [Can't extend the volume on a SQL Server VM](cannot-extend-volume-sql-server.md).

## Verify the fix

1. Open **Disk Management**, right-click the disk, and select **Properties**. Verify that the **Volumes** tab shows **GUID Partition Table (GPT)**.

1. Extend the volume to use the newly visible space:
   - Right-click the volume and select **Extend Volume**.
   - Follow the wizard to use all available unallocated space.

1. Verify the final volume size from an elevated command prompt:

   ```cmd
   wmic logicaldisk get caption,size,freespace
   ```

## Resources

- [Troubleshoot Azure disk resize failures](troubleshoot-disk-resize.md)
- [MBR2GPT.exe documentation](/windows/deployment/mbr-to-gpt)
- [Upgrade a Gen1 VM to Trusted Launch](/azure/virtual-machines/trusted-launch-existing-vm-gen-1)
- [Windows and GPT FAQ](/windows-hardware/manufacture/desktop/windows-and-gpt-faq)
- [Expand virtual hard disks — Windows](/azure/virtual-machines/windows/expand-disks)
