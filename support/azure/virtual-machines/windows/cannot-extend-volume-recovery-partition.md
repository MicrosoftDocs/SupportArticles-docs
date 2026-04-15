---
title: Cannot extend OS volume because a recovery partition blocks the extend
description: Resolve the issue where Extend Volume is unavailable (dimmed) in Disk Management because a Windows Recovery partition sits between the OS volume and unallocated space on an Azure VM.
ms.reviewer: scotro, v-leedennis
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Cannot extend an OS volume because a recovery partition blocks the extend

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you resolve the issue where **Extend Volume** is unavailable (dimmed) in Disk Management after you resize a managed disk in the Azure portal. The cause is a Windows Recovery Environment (WinRE) partition that sits between the OS volume (C:) and the new unallocated space.

## Symptoms

After you expand a managed disk in the Azure portal, you open Disk Management inside the VM and find:

- The new unallocated space is visible at the end of the disk.
- **Extend Volume** is unavailable (dimmed) when you right-click the C: volume.
- A **Recovery** partition (typically 450 MB to 1 GB) sits between the C: volume and the unallocated space.

The partition layout looks like this:

```
| C: (Primary, NTFS) | Recovery (450 MB) | Unallocated |
```

## Cause

NTFS can only extend into physically adjacent unallocated space. The Windows Recovery partition sits between the OS volume and the new space, which prevents the extend operation.

This partition layout is the default for most Azure Marketplace Windows images. The Recovery partition contains WinRE files.

## Is it safe to delete the recovery partition in Azure?

Yes. WinRE can't be triggered through its [standard entry points](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference#entry-points-into-winre) on Azure VMs because Azure doesn't provide local keyboard or console access during the boot process. The standard WinRE triggers (Shift+Restart at the login screen, Settings app, hardware recovery buttons) all require interactive access that isn't available in Azure.

Azure provides alternative recovery mechanisms that don't depend on the recovery partition:

- [Azure Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows) connects to the COM1 serial port for console-level troubleshooting.
- [Azure Virtual Machine repair commands](/troubleshoot/azure/virtual-machines/windows/repair-windows-vm-using-azure-virtual-machine-repair-commands) attach the OS disk to a repair VM for offline OS repair.

Deleting the recovery partition doesn't affect normal VM operation, startup, or Azure's ability to recover the VM.

## Resolution

> [!IMPORTANT]
> Before you proceed, take a snapshot of your OS disk in the Azure portal. Go to the disk resource, select **Snapshots**, and select **Create snapshot**.

### Option 1: Delete the recovery partition by using DiskPart

This option deletes the recovery partition so that the unallocated space becomes adjacent to C:.

1. Connect to the VM by using RDP or [Azure Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows).

1. Open **Command Prompt** as Administrator.

1. Start DiskPart and identify the partition layout:

   ```cmd
   diskpart
   list disk
   select disk 0
   list partition
   ```

   You should see output similar to the following example:

   ```output
     Partition ###  Type              Size     Offset
     -------------  ----------------  -------  -------
     Partition 1    Primary            127 GB  1024 KB
     Partition 2    Recovery           450 MB   127 GB
   ```

1. Select and delete the recovery partition:

   ```cmd
   select partition 2
   delete partition override
   ```

   The `override` flag is required because recovery partitions are protected by default.

1. Exit DiskPart:

   ```cmd
   exit
   ```

1. Open **Disk Management** (press Windows+R, type `diskmgmt.msc`, and press Enter).

1. Right-click the **C:** volume and select **Extend Volume**.

1. Follow the Extend Volume Wizard to expand C: into the unallocated space.

### Option 2: Move the recovery partition by using GParted

If you want to keep the recovery partition, you can move it to the end of the disk instead of deleting it. This option preserves WinRE.

1. Stop (deallocate) the VM.

1. Create a [repair VM](/troubleshoot/azure/virtual-machines/windows/troubleshoot-recovery-disks-portal-windows) and attach the OS disk as a data disk.

1. On the repair VM, download a [GParted Live ISO](https://gparted.org/livecd.php) or install GParted.

1. In GParted, select the attached disk and move the recovery partition to the end of the disk.

1. Apply changes, detach the disk, and reattach it to the original VM as the OS disk.

1. Start the VM and extend the C: volume.

> [!NOTE]
> Option 2 requires more steps and a temporary repair VM. Use this option only if you must preserve the WinRE partition for compliance or organizational requirements.

## Verify the fix

After extending the volume:

1. Open **Disk Management** and verify that C: shows the full disk size.

1. Open **File Explorer** and confirm the free space on C: matches the expanded size.

1. Optionally, verify from an elevated command prompt:

   ```cmd
   wmic logicaldisk get size,freespace,caption
   ```

## Additional resources

- [Troubleshoot Azure disk resize failures](troubleshoot-disk-resize.md)
- [Expand the volume in the operating system](/azure/virtual-machines/windows/expand-disks#expand-the-volume-in-the-operating-system)
- [Azure Serial Console for Windows](/azure/virtual-machines/troubleshooting/serial-console-windows)
- [Cannot extend an encrypted OS volume](cannot-extend-encrypted-os-volume.md)
