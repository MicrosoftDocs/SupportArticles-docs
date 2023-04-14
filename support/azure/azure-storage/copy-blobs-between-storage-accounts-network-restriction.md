---
title: Use AzCopy to copy blobs between storage accounts with access restriction
description: Introduces how to copy blobs between storage accounts with AzCopy and how to implement this when network restrictions are set for the storage accounts.
ms.date: 04/14/2023
ms.topic: how-to
ms.service: storage
ms.author: v-weizhu
author: AmandaAZ
ms.reviewer: jiajwu, azurestocic
---
# Use AzCopy to copy blobs between Azure storage accounts with network restriction

This article introduces how to copy blobs between storage accounts by using the AzCopy command-line utility and how to implement the copy operation when network restrictions are configured for the storage accounts.

## Background

Copying blob files between two storage accounts is a common requirement for many Azure users. There are several reasons for this, such as data backup, storage account migration, or meeting business requirements. Azure Storage supports directly copying blobs from one storage account to another, which can be implemented by using the AzCopy command-line utility. Users don't need to download files to local disks or buffers and then upload them again.

Copying blobs between two storage accounts by using AzCopy doesn't rely on network bandwidth of your local computer. This method can take advantage of the performance of storage accounts and Azure virtual network to achieve better throughput than downloading and uploading files. If both storage accounts are in the same region, bandwidth cost is free of charge.

## AzCopy commands for copying blobs between storage accounts

- If you provide authorization credentials by using Azure Active Directory (Azure AD), use the following command:

    ```azcopy
    azcopy copy 'https://<source-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>' 'https://<destination-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>'
    ```

    In this scenario, you need to make sure your Azure AD identity has the proper role assignments for both source and destination accounts.

- If you use a Shared Access Signature (SAS) token, use the following command:

    ```azcopy
    azcopy copy 'https://<source-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path><SAS-token>' 'https://<destination-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path><SAS-token>'
    ```

    In this scenaio, you need to append a SAS token to both source or destination URL that use in your AzCopy commands.

For more information, see [Copy blobs between Azure storage accounts with AzCopy v10](/azure/storage/common/storage-use-azcopy-blobs-copy).

## Copy blobs between storage accounts with access restriction

If you need to restrict access to both source and destination storage account via the storage firewall, you may need more configurations for copying blobs between storage accounts by using AzCopy. This is because the copy request between two storage accounts uses private IP addresses and the IP addresses are dynamic.

Here are two supported scenarios:

### Scenario 1: The client uses public endpoint to access storage accounts

In this scenario, you must add the client's public IP address or virtual network (VNET) to the firewall allowlist in both source and destination storage account.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-with-vnet-in-allowlist.png" alt-text="Image that shows the process of coping blobs between storage accounts in scenario 1.":::

### Scenario 2: The client's VNET has private links configured and it uses private endpoint to access storage accounts

In this scenario, the firewall allowlist isn't needed.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-enabled-with-no-rule.png" alt-text="Image that shows the process of coping blobs between storage accounts in scenario 2.":::

Here's the full process of this mechanism for the two scenarios:

1. The client sent a PutBlockfromURL request to the destination storage.
2. After getting the requests, the destination storage tries to get blocks from the given URL that's the source storage. However, since the destination storage hasn't been allowed by the source firewall, it will get a "403 Forbidden" error.
3. After getting 403, the destination storage sent another GetBlob request on behalf of the client. If the client has access to the source storage, the destination will be able to get the blocks from the source with the response code 206 and return a success to the client.
4. The client sent PutBlockList to the destination storage to commit the blocks and finish the process after receiving success from request.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]