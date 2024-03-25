---
title: Azure Storage data protection, backup, and recovery
description: This article discusses data backup and protection options and recovery scenarios for Azure Storage.
ms.date: 04/17/2023
ms.service: azure-storage
ms.reviewer: jiajwu, ryanchen, azurestocic, v-weizhu
ms.topic: how-to
---
# Best practices for Azure Storage data protection, backup, and recovery

The article provides Azure Storage data protection and backup options, self-serve recovery scenarios, and Microsoft-assist recovery possibilities.

## Data protection, backup, and recovery options

Azure Storage data protection refers to strategies for:

- Protecting the storage account and data within it from being deleted or modified.
- Restoring data after it has been deleted or modified.

This section introduces available data protection, backup, and recovery options. For more information, see [data backup and protection options](/azure/storage/blobs/data-protection-overview#overview-of-data-protection-options).

### Data protection and backup options

The following sections introduce data protection scenarios and recommended protection options:

- [Scenario 1: Storage account protection](#scenario-1-storage-account-protection)
- [Scenario 2: Blob container protection](#scenario-2-blob-container-protection)
- [Scenario 3: Blob file protection](#scenario-3-blob-file-protection)

#### Scenario 1: Storage account protection

Enable Azure Resource Manager (ARM) lock to lock all your storage accounts and prevent the deletion of the storage account. For more information about ARM lock, see [Apply an Azure Resource Manager lock to a storage account](/azure/storage/common/lock-account-resource).

Benefits and limitations:

- Protects the storage account against deletion or configuration changes.
- Doesn't protect containers or blobs in the account from being deleted or overwritten.
- It supports Azure Data Lake Storage (ADLS) Gen 2.

#### Scenario 2: Blob container protection

- Enable immutability policies on a container to protect business-critical documents, such as to meet legal or regulatory compliance requirements.

  Benefits and limitations:

  - Protects a container and its blobs from all deletes and overwrites.
  - When a legal hold or a locked time-based retention policy is in effect, the storage account is also protected from deletion. Containers for which no immutability policy has been set aren't protected from deletion.
  - It supports ADLS Gen 2 in preview.

  For more information about immutability policies on a container, see [Store business-critical blob data with immutable storage](/azure/storage/blobs/immutable-storage-overview).

- Enable container soft-delete to restore a deleted container within a specified interval.

  Benefits and limitations:

  - A deleted container and its contents may be restored within the retention period. The best practice for a minimum retention interval is seven days.
  - Only container-level operations, like "Delete container", can be restored. Container soft delete doesn't enable you to restore an individual blob in the container if that blob is deleted.
  - It supports ADLS Gen 2.

  For more information on container soft delete, see [Soft delete for containers](/azure/storage/blobs/soft-delete-container-overview).

#### Scenario 3: Blob file protection

- Enable immutability policies on a blob version to prevent a blob version from being deleted for an interval you control.

  Benefits and limitations:

  - Protects a blob version from being deleted and its metadata from being overwritten. An overwrite operation creates a new version.
  - If at least one container has version-level immutability enabled, the storage account is also protected from deletion.  
  - Container deletion fails if at least one blob exists in the container.
  - It's *not* available for ADLS Gen2.

  For more information on immutability policies on a blob version, see [Store business-critical blob data with immutable storage](/azure/storage/blobs/immutable-storage-overview).

- Enable blob soft delete to restore a deleted blob or blob version within a specified interval.

  Benefits:

  - A deleted blob or blob version may be restored within the retention period. The best practice for a minimum retention interval is seven days.
  - It supports ADLS Gen 2.

  For more information on blob soft delete, see [Soft delete for blobs](/azure/storage/blobs/soft-delete-blob-overview).

- Enable blob snapshot to manually save the state of a blob at a given point in time.

  Benefits and limitations:

  - A blob may be restored from a snapshot if the blob is overwritten. However, if the blob is deleted, snapshots are also deleted.
  - It supports ADLS Gen 2 in preview.

  For more information on blob snapshots, see [Blob snapshots](/azure/storage/blobs/snapshots-overview).

- Enable blob versioning to automatically save the state of a blob in a previous version when it's overwritten.

  Benefits and limitations:

  - Every blob write operation creates a new version. The current version of a blob may be restored from a previous version if the current version is deleted or overwritten.
  - It's not available for ADLS Gen2.  

  For more information on blob versioning, see [Blob versioning](/azure/storage/blobs/versioning-overview).

- Enable Point-in-time restore to restore a set of block blobs to a previous point in time.

  Benefits and limitations:

  - A set of block blobs may be reverted to their state at a specific point in the past.
  - Only operations performed on block blobs are reverted.  
  - Any operations performed on containers, page blobs, or append blobs aren't reverted.
  - It's not available for ADLS Gen2.

  For more information on point-in-time restore, see [Point-in-time restore for block blobs](/azure/storage/blobs/point-in-time-restore-overview).

- Copy data to a second account via Azure Storage object replication or tools like AzCopy or Azure Data Factory.

  Benefits and limitations:

  - Data can be restored from the second storage account if the primary account is compromised in any way.
  - AzCopy and Azure Data Factory are supported.
  - Object replication isn't supported.

### Data recovery options

The following sections introduce data recovery scenarios and possible recovery options:

- [Scenario 1: Storage account recovery](#scenario-1-storage-account-recovery)
- [Scenario 2: Blob container recovery](#scenario-2-blob-container-recovery)
- [Scenario 3: Blob file recovery](#scenario-3-blob-file-recovery)

You can recover data after [data protection and backup options](#data-protection-and-backup-options) are enabled.

#### Scenario 1: Storage account recovery

Refers to [Recover deleted storage accounts from the Azure portal](#recover-deleted-storage-accounts-from-the-azure-portal).

#### Scenario 2: Blob container recovery

- Recover the soft-deleted container and its contents.

  Requirements for recovery:

  - Container soft delete is enabled.
  - The container soft delete retention period hasn't yet expired.
  
  For more information, see [Enable and manage soft delete for containers](/azure/storage/blobs/soft-delete-container-enable).

- Recovery from a second storage account.

  Requirements for recovery: All container and blob operations have been replicated to a second storage account.

#### Scenario 3: Blob file recovery

- Recover blobs to previous versions via blob versioning.

  Requirements for recovery:

  - Blob versioning is enabled.
  - The blob has one or more previous versions.

  For more information, see [Enable and manage blob versioning](/azure/storage/blobs/versioning-enable).

  This option is currently not supported for ADLS workloads.

  Recovery procedures:

  1. Go to the affected blob from the Azure portal.

      :::image type="content" source="media/data-protection-backup-recovery/select-affected-blob.png" alt-text="Screenshot that shows the affected blob." lightbox="media/data-protection-backup-recovery/select-affected-blob.png":::

  1. Select the ellipses (...) for the blob you want to recover.
  1. Select **View versions**.

      :::image type="content" source="media/data-protection-backup-recovery/view-previous-version.png" alt-text="Screenshot that shows the 'View versions' option." lightbox="media/data-protection-backup-recovery/view-previous-version.png":::

  1. Select the version that's required to restore from.
  1. Select **Make current version**.

      :::image type="content" source="media/data-protection-backup-recovery/make-current-version.png" alt-text="Screenshot that shows the 'Make current version' option." lightbox="media/data-protection-backup-recovery/make-current-version.png":::

- Recover blobs via blob soft delete.

  Requirements for recovery:

  - Blob soft delete is enabled.
  - The soft delete retention interval hasn't expired.

  For more information, see [Manage and restore soft-deleted blobs](/azure/storage/blobs/soft-delete-blob-manage).

- Recover a set of block blobs via point-in-time.

  Requirements for recovery:

  - Point-in-time restore is enabled.
  - The restore point is within the retention interval.
  - The storage account hasn't been compromised or corrupted.

  For more information, see [Perform a point-in-time restore on block blob data](/azure/storage/blobs/point-in-time-restore-manage).

- Recover blobs via snapshots.

  Requirements for recovery: The blob has one or more snapshots. For more information, see [Create and manage a blob snapshot in .NET](/azure/storage/blobs/snapshots-manage-dotnet).

  Recovery procedures:

  1. Go to the affected blob from the Azure portal.

      :::image type="content" source="media/data-protection-backup-recovery/select-affected-blob.png" alt-text="Screenshot that shows the affected blob." lightbox="media/data-protection-backup-recovery/select-affected-blob.png":::

  1. Select the ellipses (...) for the blob you want to recover.
  1. Select **View snapshots**.

      :::image type="content" source="media/data-protection-backup-recovery/view-snapshots.png" alt-text="Screenshot that shows the 'View snapshots' option." lightbox="media/data-protection-backup-recovery/view-snapshots.png":::

  1. Select the snapshot that's required to restore from.
  1. Select **Promote**.

      :::image type="content" source="media/data-protection-backup-recovery/promote.png" alt-text="Screenshot that shows the 'Promote' option." lightbox="media/data-protection-backup-recovery/promote.png":::

## Best practice for Azure RBAC

Another best practice to avoid accidental account deletion is to limit the number of users who have permissions to delete an account via role-based access control (Azure RBAC).

Here are some recommended methods:

- Only grant the access users need.
- Limit the number of subscription owners.
- Use Microsoft Entra Privileged Identity Management.
- Assign roles to groups, not users.
- Assign roles using the unique role ID instead of the role name.

For more information, see [Best practices for Azure RBAC](/azure/role-based-access-control/best-practices).

## Non-supported storage recovery

Microsoft doesn't support the following storage recovery scenarios:

- Azure Storage Queue recovery isn't supported.
- Azure Storage Table entries recovery isn't supported, while deleted table recovery is supported. For more information, see [Supported Storage Recovery](#supported-storage-recovery).
- Azure Blob files recovery without enabling blob file protection isn't supported, but deleted container recovery is supported. For more information, see [Supported Storage Recovery](#supported-storage-recovery).

## Supported storage recovery

This section describes several supported storage recovery scenarios when some prerequisites are met:

- [Scenario 1: Storage account recovery (ARM storage account recovery)](#scenario-1-storage-account-recovery-arm-storage-account-recovery)
- [Scenario 2: Classic storage account recovery](#scenario-2-classic-storage-account-recovery)
- [Scenario 3: Container recovery](#scenario-3-container-recovery)
- [Scenario 4: ADLS Gen 2 data and file system recovery](#scenario-4-adls-gen-2-data-and-file-system-recovery)
- [Scenario 5: Table recovery](#scenario-5-table-recovery)
- [Scenario 6: Disk recovery](#scenario-6-disk-recovery)

Microsoft is making every effort to recover the data but cannot guarantee the amount of data that can be restored.

### Scenario 1: Storage account recovery (ARM storage account recovery)

Prerequisites:

- The storage account was deleted within the past 14 days.
- The storage account was created with the Azure Resource Manager deployment model.
- A new storage account with the same name hasn't been created since the original account was deleted.
- The user recovering the storage account must be assigned an Azure RBAC role that provides the **Microsoft.Storage/storageAccounts/write** permissions. For information about built-in Azure RBAC roles that provide this permission, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles).
- Make sure the resource group that deleted the storage account exists. If the resource group was deleted, you must recreate it manually.  
- [For specific cases only] If the deleted storage account used customer-managed keys with Azure Key Vault and the key vault has also been deleted, you must restore the key vault before you restore the storage account. For more information, see [Azure Key Vault recovery overview](/azure/key-vault/general/key-vault-recovery).

Suggestions:

- Recover a storage account from an existing storage account.
- Recover a storage account via a support ticket.

For more information, see [Recover deleted storage accounts from Azure portal](#recover-deleted-storage-accounts-from-the-azure-portal).

### Scenario 2: Classic storage account recovery

Prerequisites:

- A new storage account with the same name hasn't been created since the original account was deleted.
- The storage account was deleted within the past 14 days.

Suggestions:

- Seek help from support engineers to evaluate the situation.

### Scenario 3: Container recovery

Prerequisites:

- The storage account replication was set to geo-redundant storage (GRS), geo-zone-redundant storage (GZRS), read-access geo-zone-redundant storage (RAGZRS), or read-access geo-redundant storage (RA-GRS) prior to "container" deletion. Storage accounts with LRS aren't supported to recover a deleted container.

Suggestions:

- Seek help from support engineers to evaluate the situation.

### Scenario 4: ADLS Gen 2 data and file system recovery

Prerequisites:

- Storage account with Hierarchical Namespace (HNS) enabled.
- The ADLS Gen2 file or folder was deleted within three days.

Suggestions:

- Seek help from support engineers to evaluate the situation.

### Scenario 5: Table recovery

Prerequisites:

- The whole table is deleted using the "DELETE Table" operation without modifying the table entry data. 

Suggestions:

- Seek help from support engineers to evaluate the situation.

### Scenario 6: Disk recovery

Prerequisites:

- The prerequisites of disk recovery vary depending on a few factors. For instance, is soft delete enabled? Or does the recovery disk refer to managed disk or unmanaged disk?

Suggestions:

- Seek help from support engineers to evaluate the situation.

## Recover deleted storage accounts from the Azure portal

There are two ways for end users to recover a deleted storage account from the Azure portal:

- [Recover the deleted account from an existing storage account](#recover-a-deleted-storage-account-from-another-storage-account).

- [Recover the account via a support ticket](#recover-storage-accounts-via-a-support-ticket).

### Recover a deleted storage account from another storage account

To recover a deleted storage account from within another storage account, follow these steps:

1. Navigate to the list of your storage account in the Azure portal.
1. Select the **Restore** button to open the **Restore deleted account** pane.

    :::image type="content" source="media/data-protection-backup-recovery/restore-button.png" alt-text="Screenshot that shows the 'Restore' button." lightbox="media/data-protection-backup-recovery/restore-button.png":::

1. Select the subscription for the account you want to recover from the **Subscription** drop-down list.

    :::image type="content" source="media/data-protection-backup-recovery/subscription-drop-down-list.png" alt-text="Screenshot that shows how to select the subscription." lightbox="media/data-protection-backup-recovery/subscription-drop-down-list.png":::

1. From the drop-down list, select the account to recover. If the storage account you want to recover isn't in the drop-down list, it can't be recovered.
1. Select the **Restore** button to recover the account. The portal displays a notification that the recovery is in progress.

For more information, see [Recover a deleted account from the Azure portal](/azure/storage/common/storage-account-recover#recover-a-deleted-account-from-the-azure-portal).

### Recover storage accounts via a support ticket

1. In the Azure portal, navigate to **Help + support**.
1. Select **Create a support request**.
1. On the **Problem description** tab, in the **Issue type** field, select **Technical**.
1. In the **Subscription** field, select the subscription that contained the deleted storage account.
1. In the **Service** field, select **Storage Account Management**.
1. In the **Resource** field, select any storage account resource. The deleted storage account doesn't appear in the list.
1. Add a brief summary of the issue.
1. In the **Problem type** field, select **Deletion and Recovery**.
1. In the **Problem subtype** field, select **Recover deleted storage account**.

    The following screenshot shows an example of the **Problem description** tab being filled out:

    :::image type="content" source="media/data-protection-backup-recovery/set-fields-under-problem-description-tab.png" alt-text="Screenshot that shows an example of the Problem description tab being filled out.":::

1. Navigate to the **Recommended solution** tab, and select **Customer-Controlled Storage Account Recovery**.

    :::image type="content" source="media/data-protection-backup-recovery/customer-controlled-storage-account-recovery.png" alt-text="Screenshot of the Customer-Controlled Storage Account Recovery button.":::

1. From the drop-down list, select the account to recover. If the storage account you want to recover isn't in the drop-down list, it can't be recovered.

    :::image type="content" source="media/data-protection-backup-recovery/deleted-storage-accounts-list.png" alt-text="Screenshot of the deleted storage accounts list for the last 14 days.":::

1. Select **Recover** to restore the account. The portal displays a notification that the recovery is in progress.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
