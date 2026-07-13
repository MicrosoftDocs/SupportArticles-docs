---
title: Can't extend a volume on an Azure Windows VM
description: Troubleshoot why you can't extend a volume on an Azure Windows VM due to NTFS, recovery partition, MBR, or RBAC limits, and fix the issue now.
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, donajilugo, v-leedennis
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Windows (Guest OS)
ms.topic: troubleshooting
---

# Can't extend a volume on an Azure Windows VM

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot scenarios where you can't extend a disk volume at the guest operating system (OS) level on an Azure Windows virtual machine (VM). After you resize a managed disk in the Azure portal, you still need to extend the volume inside the VM. Several conditions can prevent this step from succeeding.

> [!NOTE]
> If you receive an error when you try to resize the disk itself in the Azure portal (before reaching the guest OS), see [Troubleshoot Azure VM disk resize errors](troubleshoot-disk-resize-errors.md) instead.

> [!NOTE]
> For SQL Server VMs deployed from Azure Marketplace, the storage pool configuration prevents standard volume extension. Use the **SQL Server configuration** menu in the Azure portal instead. For details, see [Can't extend the volume on a SQL Server-based standalone server VM](cannot-extend-volume-sql-server.md).

## Symptoms

After you resize a managed disk in the Azure portal, one of the following issues occurs inside the VM:

- **The "Extend Volume" option is greyed out in Disk Management** even though unallocated space is visible on the disk.
- **The volume doesn't extend to the full disk size** and stops at a smaller size than expected.
- **The "Save" button is greyed out** when you try to resize the disk in the Azure portal.
- **An error message appears** when you try to extend the volume, such as "The volume cannot be extended because of the number of clusters."

## Causes

The following conditions can prevent you from extending a volume on a Windows VM.

### Cause 1: NTFS allocation unit size limits

The NTFS file system has a maximum volume size that depends on the allocation unit size (also called cluster size or "Bytes Per Cluster"). If you format the volume with a small allocation unit size, you can't extend it beyond a certain limit.

| Allocation unit size | Maximum NTFS volume size |
|---|---|
| 4 KB (default) | 16 TB |
| 8 KB | 32 TB |
| 16 KB | 64 TB |
| 32 KB | 128 TB |
| 64 KB | 256 TB |

### Cause 2: Recovery partition blocks extension

A recovery partition might be located between the OS volume and the unallocated space on the disk. Because you can only extend volumes into *adjacent* unallocated space, the recovery partition prevents the OS volume from expanding.

### Cause 3: MBR partition style limits disk to 2 TB

If the disk uses the Master Boot Record (MBR) partition style, the maximum partition size is 2 TB. The GUID Partition Table (GPT) partition style doesn't have this limitation.

### Cause 4: Azure Disk Encryption (ADE) partition layout

When you apply Azure Disk Encryption (ADE) to a VM that you created from a custom image, it might place a System Reserved partition after the OS volume. This placement blocks the OS volume from extending into unallocated space. For detailed steps to resolve this specific scenario, see [Can't extend an encrypted OS volume in Windows](cannot-extend-encrypted-os-volume.md).

### Cause 5: Insufficient RBAC permissions

If the **Save** button is greyed out in the Azure portal when you try to resize a disk, your account might not have the required role-based access control (RBAC) permissions on the disk resource.

## Resolution

### Step 1: Check the NTFS allocation unit size

Run the following command in an elevated Command Prompt to check the allocation unit size:

```cmd
fsutil fsinfo ntfsinfo C:
```

In the output, find the **Bytes Per Cluster** value. Compare it to the table in [Cause 1](#cause-1-ntfs-allocation-unit-size-limits) to determine the maximum volume size for your configuration.

If the current allocation unit size limits the volume to a size smaller than what you need, move the data to a new volume that's formatted with a larger allocation unit size:

1. Create a new data disk with the target size.

   #### [Azure portal](#tab/portal)

   In the Azure portal, go to the VM, select **Disks** > **Create and attach a new disk**, specify the size, and select **Apply**.

   #### [Azure PowerShell](#tab/powershell)

   ```azurepowershell
   $diskConfig = New-AzDiskConfig -SkuName Premium_LRS -Location <location> -CreateOption Empty -DiskSizeGB <size>
   $disk = New-AzDisk -ResourceGroupName <resource-group> -DiskName <disk-name> -Disk $diskConfig
   $vm = Get-AzVM -ResourceGroupName <resource-group> -Name <vm-name>
   $vm = Add-AzVMDataDisk -VM $vm -Name <disk-name> -CreateOption Attach -ManagedDiskId $disk.Id -Lun <lun>
   Update-AzVM -ResourceGroupName <resource-group> -VM $vm
   ```

   #### [Azure CLI](#tab/cli)

   ```azurecli
   az vm disk attach --resource-group <resource-group> --vm-name <vm-name> --name <disk-name> --size-gb <size> --sku Premium_LRS --new
   ```

   ---

1. Format the new disk with a larger allocation unit size. During the New Simple Volume Wizard, select a larger allocation unit size (for example, 64 KB for volumes up to 256 TB).
1. Copy the data from the old volume to the new volume by using [robocopy](/windows-server/administration/windows-commands/robocopy):

   ```cmd
   robocopy D:\ E:\ /mir /z /w:5 /r:2 /mt
   ```

1. Detach and delete the old data disk.

> [!IMPORTANT]
> You can't change the allocation unit size of an existing volume without reformatting it.

### Step 2: Remove a blocking recovery partition

> [!NOTE]
> Perform this resolution inside the VM guest operating system by using DiskPart. Azure CLI and Azure PowerShell aren't applicable for this step.

> [!IMPORTANT]
> Before you proceed, take a snapshot of the OS disk as a backup. If anything goes wrong, you can restore the VM from the snapshot.

Azure VMs don't use the Windows Recovery Environment (WinRE) because there's no console access. You can safely remove the recovery partition to free up adjacent space for extending the OS volume.

1. Open an elevated Command Prompt.
1. Start DiskPart:

   ```cmd
   diskpart
   ```

1. List and select the disk:

   ```cmd
   list disk
   select disk 0
   ```

1. List the partitions and identify the recovery partition:

   ```cmd
   list partition
   ```

1. Select the recovery partition (for example, Partition 4):

   ```cmd
   select partition 4
   ```

1. Delete the recovery partition:

   ```cmd
   delete partition override
   ```

1. In Disk Management, right-click the OS volume and select **Extend Volume**.

### Step 3: Convert MBR to GPT for disks larger than 2 TB

> [!NOTE]
> Perform this resolution step inside the VM guest operating system. Azure CLI and Azure PowerShell aren't applicable for this step.

If the disk uses the MBR partition style and you need a partition larger than 2 TB:

- **For the OS disk**, use `MBR2GPT.exe` to convert without data loss:

  ```cmd
  MBR2GPT /convert /allowFullOS
  ```

  > [!NOTE]
  > `MBR2GPT.exe` works only for system (OS) disks. It isn't available on Windows Server 2016. You must upgrade to Windows Server 2019 or later before you convert. It's recommended to extend the OS volume before you convert, because extending the OS volume after conversion isn't supported.

  For detailed steps, see [Update the guest OS volume from MBR to GPT](/azure/virtual-machines/trusted-launch-existing-vm-gen-1?tabs=windows%2Cpowershell#update-guest-os-volume).

- **For data disks**, back up the data, delete the existing MBR partition, re-create the disk as GPT, and restore the data. For Linux VMs, see [Failed to resize MBR partition for a data disk larger than 2 TB](../linux/convert-mbr-partition-to-gpt.md).

  > [!WARNING]
  > For SQL Server data drives, create a new GPT drive and migrate or copy the data to it. Converting an existing drive carries increased risk for SQL workloads.

### Step 4: Check RBAC permissions on the disk resource

If the **Save** button is disabled in the Azure portal when you try to resize a disk, verify that your account has the required permissions:

#### [Azure portal](#tab/portal)

1. In the Azure portal, go to the disk resource.
1. Select **Access control (IAM)**.
1. Verify that your account has the **Contributor** or **Disk Operator** role (or a custom role that includes `Microsoft.Compute/disks/write`).

#### [Azure PowerShell](#tab/powershell)

```azurepowershell
Get-AzRoleAssignment -Scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Compute/disks/<disk-name> | Format-Table RoleDefinitionName, DisplayName
```

Verify that the output includes the **Contributor** or **Disk Operator** role for your account. If it doesn't, assign the role:

```azurepowershell
New-AzRoleAssignment -SignInName <user@domain.com> -RoleDefinitionName "Contributor" -Scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Compute/disks/<disk-name>
```

#### [Azure CLI](#tab/cli)

```azurecli
az role assignment list --scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Compute/disks/<disk-name> --output table
```

Verify that the output includes the **Contributor** or **Disk Operator** role for your account. If it doesn't, assign the role:

```azurecli
az role assignment create --assignee <user@domain.com> --role "Contributor" --scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Compute/disks/<disk-name>
```

---

If you don't have the required permissions, ask your subscription administrator to assign the appropriate role.

If none of the preceding steps resolve the issue, [contact Azure Support](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

## References

- [Start here for troubleshooting Azure VM disk resize issues](troubleshoot-disk-resize-overview.md)
- [Can't extend an encrypted OS volume in Windows](cannot-extend-encrypted-os-volume.md)
- [Troubleshoot Azure VM disk resize errors](troubleshoot-disk-resize-errors.md)
- [Troubleshoot live resize failure](troubleshoot-live-resize-failure.md)
- [Failed to resize MBR partition for a data disk larger than 2 TB](../linux/convert-mbr-partition-to-gpt.md)
- [Expand virtual hard disks on a Windows VM](/azure/virtual-machines/windows/expand-os-disk)
- [Downsize a data disk without losing data](downsize-data-disk-without-losing-data.md)
