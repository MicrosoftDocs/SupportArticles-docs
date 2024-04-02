---
title: Troubleshoot errors when you delete Azure classic storage accounts, containers, or VHDs
description: How to troubleshoot problems when deleting storage resources containing attached VHDs.
services: storage
author: AngshumanNayakMSFT
tags: top-support-issue,azure-service-management
ms.service: virtual-machines
ms.subservice: vm-disk
ms.topic: troubleshooting
ms.date: 01/11/2019
ms.author: annayak
---
# Troubleshoot classic storage resource deletion errors

This article provides troubleshooting guidance when one of the following errors occurs trying to delete Azure classic storage account, container, or *.vhd page blob file.

This article only covers issues with classic storage resources. If a user deletes a classic virtual machine using the Azure portal, PowerShell or CLI then the Disks aren't automatically deleted. The user gets the option to delete the "Disk" resource. In case the option isn't selected, the "Disk" resource will prevent deletion of the storage account, container and the actual *.vhd page blob file.

More information about Azure disks can be found [here](/azure/virtual-machines/managed-disks-overview). Azure prevents deletion of a disk that is attached to a VM to prevent corruption. It also prevents deletion of containers and storage accounts, which have a page blob that is attached to a VM.

## What is a "Disk"?

A "Disk" resource is used to mount a *.vhd page blob file to a virtual machine, as an OS disk or Data disk. An OS disk or Data disk resource, until deleted, will continue to hold a lease on the*.vhd file. Any storage resource in the path shown in below image can't be deleted if a "Disk" resource points to it.

:::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/disk-lease-illustration.png" alt-text="Screenshot of the 3 parts of a storage resource path: Storage Account, Container and Actual Page Blob i.e the *.vhd file. A Disk resource points to it." lightbox="media/storage-classic-cannot-delete-storage-account-container-vhd/disk-lease-illustration.png":::

## Steps while deleting a classic virtual machine

[!INCLUDE [classic-vm-deprecation](../../../includes/azure/classic-vm-deprecation.md)]

1. Delete the classic virtual machine.

2. If the "Disks" checkbox is selected, the **disk lease** (shown in image above) associated with the page blob *.vhd is broken. The actual page blob*.vhd file will still exist in the storage account.

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/steps-while-deleting-classic-vm.png" alt-text="Screenshot shows a dialog box to confirm deletion of a virtual machine." border="false":::  

3. Once the disk(s) lease is broken, the page blob(s) itself can be deleted. A storage account or container can be deleted once all "Disk" resource present in them are deleted.

>[!NOTE]
>If user deletes the VM but not the VHD, storage charges will continue to accrue on the page blob *.vhd  file. The charges will be in line with the type of storage account, check the [pricing page](https://azure.microsoft.com/pricing/details/storage/) for more details. If user no longer intends to use the VHD(s), delete it/them to avoid future charges.

## Unable to delete storage account

When user tries to delete a classic storage account that is no longer needed, user may see the following behavior.

#### Azure portal

User navigates to the classic storage account on the [Azure portal](https://portal.azure.com) and clicks **Delete**, user will see the following message:

With disk(s) "attached" to a virtual machine

:::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-storage-account-disks-attached-portal.png" alt-text="Screenshot shows a message explaining why a storage account can't be deleted." border="false":::

With disk(s) "unattached" to a virtual machine

:::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-storage-account-disks-unattached-portal.png" alt-text="Screenshot of the portal with the virtual machine (classic) Delete non-error pane open." border="false":::

#### Azure PowerShell

User tries to delete a storage account, that is no longer being used, by using classic PowerShell cmdlets. User will see the following message:

> Remove-AzureStorageAccount -StorageAccountName myclassicaccount
>
> Remove-AzureStorageAccount : BadRequest: Storage account myclassicaccount has some active image(s) and/or disk(s), e.g. myclassicaccount. Ensure these image(s) and/or disk(s) are removed before deleting this storage account.

## Unable to delete storage container

When user tries to delete a classic storage blob container that is no longer needed, user may see the following behavior.

#### Azure portal

Azure portal wouldn't allow the user to delete a container if a "Disk(s)" lease exists pointing to a *.vhd page blob file in the container. It's by design to prevent accidental deletion of a vhd(s) file with Disk(s) lease on them.

:::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-container-portal.png" alt-text="Screenshot of the portal, which shows the Delete button is in grey and the Lease State of the container is Leased." border="false":::

#### Azure PowerShell

If the user chooses to delete using PowerShell, it will result in the following error.

> Remove-AzureStorageContainer -Context $context -Name vhds
>
> Remove-AzureStorageContainer : The remote server returned an error: (412) There is currently a lease on the container and no lease ID was specified in the request.. HTTP Status Code: 412 - HTTP Error Message: There is currently a lease on the container and no lease ID was specified in the request.

## Unable to delete a vhd

After deleting the Azure virtual machine, user tries to delete the vhd file (page blob) and receive the message below:

#### Azure portal

On the portal, there could be two experiences depending on the list of blobs selected for deletion.

1. If only "Leased" blobs are selected, then the Delete button doesn't show up.

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-vhd-leased-portal.png" alt-text="Screenshot of the portal, with the container blob list pane open and only leased blobs selected." border="false" lightbox="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-vhd-leased-portal.png":::

2. If a mix of "Leased" and "Available" blobs are selected, the "Delete" button shows up. But the "Delete" operation will leave behind the page blobs, which have a Disk lease on them.

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-vhd-leased-unleased-portal.png" alt-text="Screenshot of the portal, with the container blob list pane open and both leased and available blobs selected." border="false" lightbox="media/storage-classic-cannot-delete-storage-account-container-vhd/unable-to-delete-vhd-leased-unleased-portal.png":::

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/leased-blobs-locked-deletion.png" alt-text="Screenshot of the Delete blobs dialog, saying Blobs in leased state are locked for deletion and will be skipped." border="false":::

#### Azure PowerShell

If the user chooses to delete using PowerShell, it will result in the following error.

> Remove-AzureStorageBlob -Context $context -Container vhds -Blob "classicvm-os-8698.vhd"
>
> Remove-AzureStorageBlob : The remote server returned an error: (412) There is currently a lease on the blob and no lease ID was specified in the request.. HTTP Status Code: 412 - HTTP Error Message: There is currently a lease on the blob and no lease ID was specified in the request.

## Resolution steps

### To remove classic Disks

Follow these steps on the Azure portal:

1. Navigate to the [Azure portal](https://portal.azure.com).
2. Navigate to the Disks(classic).
3. Click the Disks tab.

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/disks-classic.png" alt-text="Screenshot shows the Azure portal with Disks (classic) selected. A classic disk name and storage account is shown." border="false" lightbox="media/storage-classic-cannot-delete-storage-account-container-vhd/disks-classic.png":::

4. Select your data disk, then click Delete Disk.

    :::image type="content" source="media/storage-classic-cannot-delete-storage-account-container-vhd/delete-disk.png" alt-text="Screenshot shows the Azure portal with Disks (classic) selected. A data disk is selected and the Delete option is highlighted." border="false" lightbox="media/storage-classic-cannot-delete-storage-account-container-vhd/delete-disk.png":::

5. Retry the Delete operation that previously failed.
6. A storage account or container can't be deleted as long as it has a single Disk.

### To remove classic Images

Follow these steps on the Azure portal:

1. Navigate to the [Azure portal](https://portal.azure.com).
2. Navigate to OS images (classic).
3. Delete the image.
4. Retry the Delete operation that previously failed.
5. A storage account or container can't be deleted as long as it has a single Image.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
