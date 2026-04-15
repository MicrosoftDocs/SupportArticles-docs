---
title: Troubleshoot Azure disk resize failures
description: Troubleshoot common issues when resizing managed disks on Azure virtual machines, including SAS locks, deallocation requirements, size limits, and error codes.
ms.reviewer: scotro, v-leedennis
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Troubleshoot Azure disk resize failures

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

This article helps you diagnose and resolve common failures when resizing managed disks on Azure virtual machines (VMs).

## Symptoms

You experience one of the following issues when you try to resize a managed disk:

- The **Save** or **Resize** button is unavailable (greyed out) on the **Size + performance** blade.
- You receive an error message after you select **Save** or **Resize**.
- The Azure portal shows the new disk size, but the operating system (OS) still reports the old size.

## Identify the error code

To find the specific error code:

1. In the [Azure portal](https://portal.azure.com), select the **bell icon** (Notifications) in the upper-right corner.
1. Find the failed resize operation and select it to see the full error details.

Alternatively, check the Activity Log:

1. Go to the disk resource and select **Activity log**.
1. Filter for **Failed** operations in the last 24 hours.
1. Select the failed operation. The **JSON** tab shows the error code and message.

## Error code reference

Use the following table to find the resolution for your specific error.

| Error code | Cause | Resolution |
|---|---|---|
| `ChangeDiskSizeWhileActiveSasNotAllowed` | A Shared Access Signature (SAS) URI holds a lease on the disk. A backup job or disk export may be in progress. | [Revoke the SAS token](#revoke-an-active-sas-token) |
| `ChangeDiskSizeWhileAttachedForSkuNotAllowed` | The disk SKU doesn't support online resize for this attach configuration. | [Deallocate the VM before resizing](#deallocate-the-vm-before-resizing) |
| `InvalidResizeForLargeDisks` | A Standard HDD, Standard SSD, or Premium SSD disk that is 4 TiB or smaller can't be expanded beyond 4 TiB while attached. | [Detach the disk before resizing past 4 TiB](#detach-the-disk-before-resizing-past-4-tib) |
| `LiveResizeSharedDiskNotAllowed` | A shared disk (Max shares > 1) can't be resized while attached to any VM. | [Detach a shared disk from all VMs before resizing](#detach-a-shared-disk-from-all-vms-before-resizing) |
| `InvalidParameter` / `InvalidResizeWithName` | The target size is outside the valid range for the disk SKU, or you're attempting to shrink the disk. | [Verify the target size is valid](#verify-the-target-size-is-valid) |

## Revoke an active SAS token

An active SAS URI creates a read lease on the disk's backing page blob. The Disk resource provider (RP) refuses all modifications while a lease is active.

### How to check

1. Go to the disk resource in the Azure portal.
1. Select **Disk Export** from the left menu.
1. If you see a download URL with an expiry timestamp, an active SAS is holding the lease.
1. If you don't see an export URL, check Azure Backup: go to **Recovery Services vault** > **Backup Jobs** and look for a running job on this VM.

### Resolution

- If there's an export URL, select **Revoke access**.
- If Azure Backup is running, wait for the job to complete, or cancel it from the vault's **Backup Jobs** pane.
- Retry the disk resize after revoking the SAS or after the backup job finishes.

> [!NOTE]
> For a detailed troubleshooting flow for SAS-blocked disk resize, see [Troubleshoot disk resize blocked by SAS URI](troubleshoot-disk-resize-sas-block.md).

## Deallocate the VM before resizing

The VM host's SCSI stack doesn't support in-place geometry changes for certain disk SKU and attach combinations.

Online resize (without deallocation) is **not supported** for:

- OS disks
- Shared disks (Max shares > 1)
- Standard HDD, Standard SSD, or Premium SSD data disks that are 4 TiB or smaller when expanding beyond 4 TiB

Online resize **is supported** for:

- Premium SSD v2 or Ultra Disk data disks (any size)
- Standard or Premium data disks that are already larger than 4 TiB

### Steps

1. In the Azure portal, go to your VM and select **Stop**.
1. Wait until the status shows **Stopped (deallocated)**.
1. Go to the disk resource, select **Size + performance**, enter the new size, and select **Save**.
1. Go back to the VM and select **Start**.

> [!IMPORTANT]
> "Stopped" and "Stopped (deallocated)" are different. Shutting down from inside Windows leaves the VM in the **Stopped** state (still billed, still holds leases). You must select **Stop** in the Azure portal to fully deallocate.

For the full list of online resize restrictions, see [Expand without downtime](/azure/virtual-machines/windows/expand-disks#expand-without-downtime).

## Detach the disk before resizing past 4 TiB

Managed disks use different storage backends below and above 4 TiB (single vs. striped page blobs). Crossing this boundary requires a backend migration that can't happen while the disk is attached.

### How to check

1. Go to the disk resource and select **Overview**.
1. Check the **Size** value. If it's 4,095 GiB or smaller and your target size is larger, this limitation applies.
1. Check the **SKU**. This limitation applies only to Standard HDD, Standard SSD, and Premium SSD. Premium SSD v2 and Ultra Disk are exempt.

### For data disks

1. Go to the VM, select **Disks**, and detach the data disk.
1. Go to the detached disk, select **Size + performance**, set the new size, and select **Save**.
1. Re-attach the disk to the VM.

### For OS disks

You can't detach an OS disk. Instead, stop (deallocate) the VM, resize the disk, and then start the VM.

## Detach a shared disk from all VMs before resizing

Shared disks use SCSI-3 Persistent Reservations across multiple VM hosts. Resizing would invalidate the reservation state.

### How to check

1. Go to the disk resource and select **Overview**.
1. Check **Max shares**. If the value is greater than 1, the disk is shared.

### Steps

1. Detach the shared disk from **all** VMs.
1. Resize the disk.
1. Re-attach the disk to all VMs.

> [!WARNING]
> For clustered workloads (Windows Server Failover Clustering, Storage Spaces Direct), coordinate with your cluster administrator before detaching. Detaching causes a storage failover.

For more information about shared disks, see [Azure shared disks](/azure/virtual-machines/disks-shared).

## Verify the target size is valid

The Disk RP validates the target size against the SKU's minimum, maximum, and increment rules. Shrinking a disk is not supported.

### How to check

1. Go to the disk resource, select **Overview**, and note the current **Size** and **SKU**.
1. Compare your target size against the [disk type comparison table](/azure/virtual-machines/disks-types#disk-type-comparison).
1. Verify that the target size is **larger** than the current size. Azure doesn't support reducing disk size.

If you need a smaller disk, see [Decrease the size of an Azure data disk without losing data](downsize-data-disk-without-losing-data.md).

## Volume doesn't reflect the new size in the OS

If the Azure portal shows the correct new disk size but the OS still reports the old size, see the following articles:

- [Expand the volume in the operating system](/azure/virtual-machines/windows/expand-disks#expand-the-volume-in-the-operating-system) — rescan disks and extend the volume.
- [Cannot extend volume — recovery partition blocks extend](cannot-extend-volume-recovery-partition.md) — a recovery partition is between the OS volume and unallocated space.
- [Convert MBR to GPT on an Azure VM](convert-mbr-to-gpt-azure-virtual-machine.md) — the disk uses MBR partition style, limiting usable size to 2 TiB.
- [Cannot extend an encrypted OS volume](cannot-extend-encrypted-os-volume.md) — Azure Disk Encryption placed a System Reserved partition that blocks the extend.
- [Can't extend the volume on a SQL Server VM](cannot-extend-volume-sql-server.md) — SQL Marketplace VMs use Storage Spaces pools.

## Additional resources

- [Expand virtual hard disks — Windows](/azure/virtual-machines/windows/expand-disks)
- [Expand virtual hard disks — Linux](/azure/virtual-machines/linux/expand-disks)
- [Azure managed disks overview](/azure/virtual-machines/managed-disks-overview)
- [Azure disk types comparison](/azure/virtual-machines/disks-types)
