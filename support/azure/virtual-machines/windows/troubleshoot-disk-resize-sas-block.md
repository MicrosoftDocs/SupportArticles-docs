---
title: Troubleshoot disk resize blocked by an active SAS URI
description: Resolve the ChangeDiskSizeWhileActiveSasNotAllowed error when resizing a managed disk that has an active SAS token from disk export or Azure Backup.
ms.reviewer: scotro, v-leedennis
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Troubleshoot disk resize blocked by an active SAS URI

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

This article helps you resolve the `ChangeDiskSizeWhileActiveSasNotAllowed` error that occurs when you try to resize a managed disk that has an active Shared Access Signature (SAS) URI.

## Symptoms

When you try to resize a managed disk in the Azure portal or by using Azure CLI or PowerShell, you receive the following error:

> **ChangeDiskSizeWhileActiveSasNotAllowed**: The disk \<disk-name\> has an active SAS URI. Retry after the SAS URI expires or revoke it.

The **Save** or **Resize** button might also be unavailable (dimmed) if the SAS lease is detected before the request is submitted.

## Cause

An active SAS URI creates a read lease on the disk's backing page blob. The Disk resource provider (RP) refuses all size modifications while this lease is active. Common causes of an active SAS include:

- **Disk export**: You selected **Generate URL** on the **Disk Export** blade, which creates a time-limited SAS.
- **Azure Backup**: A backup job for this VM is currently running. Azure Backup takes a snapshot and creates a SAS URI to transfer data.
- **Azure Site Recovery**: Replication may hold a SAS on the disk during sync cycles.
- **Third-party backup tools**: Some backup solutions create SAS tokens for disk-level reads.

## Diagnostic steps

### Check for an active disk export

1. In the [Azure portal](https://portal.azure.com), go to the disk resource.
1. Select **Disk Export** from the left menu.
1. If you see a download URL with an expiry timestamp, the SAS is still active.

### Check for a running Azure Backup job

1. Go to the **Recovery Services vault** that protects this VM.
1. Select **Backup Jobs** from the left menu.
1. Look for a running or pending job for this VM.
1. Note the job type:
   - **Backup**: Creates a snapshot and SAS for data transfer.
   - **Restore**: May also hold a lease during disk operations.

### Check using Azure CLI

Run the following command to check for an active SAS grant on the disk:

```azurecli
az disk show --resource-group <resource-group> --name <disk-name> --query "diskState"
```

If the disk state is `ActiveSAS`, a SAS token is currently held.

### Check using PowerShell

```azurepowershell
$disk = Get-AzDisk -ResourceGroupName '<resource-group>' -DiskName '<disk-name>'
$disk.DiskState
```

A value of `ActiveSAS` confirms the lease.

## Resolution

### Option 1: Revoke the SAS token (disk export)

1. Go to the disk resource in the Azure portal.
1. Select **Disk Export** from the left menu.
1. Select **Revoke access**.
1. Wait for the revocation to complete (usually a few seconds).
1. Retry the disk resize.

Using Azure CLI:

```azurecli
az disk revoke-access --resource-group <resource-group> --name <disk-name>
```

Using PowerShell:

```azurepowershell
Revoke-AzDiskAccess -ResourceGroupName '<resource-group>' -DiskName '<disk-name>'
```

### Option 2: Wait for Azure Backup to finish

If Azure Backup is running:

1. Go to the Recovery Services vault and select **Backup Jobs**.
1. Wait for the job to complete. Most VM backup jobs finish within 30 minutes.
1. Retry the disk resize after the job finishes.

To cancel the job (if you need to resize urgently):

1. Select the running job and choose **Cancel**.
1. Wait for the cancellation to complete.
1. Retry the disk resize.

> [!WARNING]
> Canceling a backup job means the recovery point won't be created for this run. The next scheduled backup runs normally.

### Option 3: Wait for the SAS to expire

If you don't need to resize immediately, wait for the SAS token to expire. The expiry time is shown on the **Disk Export** blade. After expiry, the lease is automatically released.

## Verify the fix

After revoking the SAS or waiting for the backup to complete:

1. Go to the disk resource and select **Size + performance**.
1. Enter the new size and select **Save**.
1. Verify that the resize operation succeeds in the **Notifications** pane.

## Additional resources

- [Troubleshoot Azure disk resize failures](troubleshoot-disk-resize.md)
- [Expand virtual hard disks — Windows](/azure/virtual-machines/windows/expand-disks)
- [Revoke disk access — REST API](/rest/api/compute/disks/revoke-access)
- [Azure Backup overview](/azure/backup/backup-overview)
