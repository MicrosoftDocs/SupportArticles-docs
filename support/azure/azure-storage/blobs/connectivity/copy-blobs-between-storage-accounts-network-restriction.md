---
title: Use AzCopy to copy blobs between storage accounts with access restriction
description: Introduces how to copy blobs between storage accounts with AzCopy and how to implement the copy operation when network restrictions are set for the storage accounts.
ms.date: 03/25/2024
ms.topic: how-to
ms.service: azure-storage
ms.reviewer: jiajwu, jeromeliu, azurestocic, v-weizhu
ms.custom: sap:Connectivity
---
# Use AzCopy to copy blobs between Azure storage accounts with network restrictions

This article introduces how to copy blobs between storage accounts by using the AzCopy command-line utility. It also explains how to implement the copy operation when network restrictions are configured for the storage accounts.

## Background

Copying blob files between two storage accounts is a common requirement for many Azure users. Azure Storage supports directly copying blobs from one storage account to another, which can be implemented by using the AzCopy command-line utility. Users don't need to download files to local disks or buffers and then upload them again.

Copying blobs between two storage accounts by using AzCopy doesn't rely on the network bandwidth of your local computer. This method can take advantage of the performance of storage accounts and Azure Virtual Network to achieve better throughput than downloading and uploading files. There are no bandwidth charges if both storage accounts are in the same region.

## AzCopy commands for copying blobs between storage accounts

- If you provide authorization credentials by using Microsoft Entra ID, use the following command:

    ```azcopy
    azcopy copy 'https://<source-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>' 'https://<destination-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>'
    ```

    In this scenario, you need to make sure your Microsoft Entra identity has the proper role assignments for both source and destination accounts.

- If you use a Shared Access Signature (SAS) token, use the following command:

    ```azcopy
    azcopy copy 'https://<source-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path><SAS-token>' 'https://<destination-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path><SAS-token>'
    ```

    In this scenario, you need to append a SAS token to both the source and destination URL used in your AzCopy commands.

For more information, see [Copy blobs between Azure storage accounts with AzCopy v10](/azure/storage/common/storage-use-azcopy-blobs-copy).

## Copy blobs between storage accounts with access restriction

If you need to restrict access to both source and destination storage accounts via the storage firewall, you may need more configurations for copying blobs between storage accounts by using AzCopy. This is because the copy request between two storage accounts uses private IP addresses, and the IP addresses are dynamic.

Here are two supported scenarios:

### Scenario 1: The client uses a public endpoint to access storage accounts

In this scenario, you must add the client's public IP address or virtual network (VNet) to the firewall allowlist in the source and destination storage accounts.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-with-vnet-in-allowlist.png" alt-text="Diagram that shows the process of coping blobs between storage accounts in scenario 1.":::

### Scenario 2: The client's VNet has private links configured, and it uses a private endpoint to access storage accounts

In this scenario, the firewall allowlist isn't needed.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-enabled-with-no-rule.png" alt-text="Diagram that shows the process of coping blobs between storage accounts in scenario 2.":::

Here's the full process of this mechanism for the two scenarios:

1. The client sends a PutBlockfromURL request to the destination storage.
2. The destination storage receives the requests, and it tries to get blocks from the given source URL. However, since the destination storage hasn't been allowed by the source firewall, it receives a "403 Forbidden" error.
3. After the destination storage receives the "403 Forbidden" error, it sends another GetBlob request on behalf of the client. If the client has access to the source storage, the destination will be able to get the blocks from the source and return a success response code to the client.
4. The client sends PutBlockList to the destination storage to commit the blocks and finish the process after receiving a success response code from the request.

## Copy blobs between storage accounts in a Hub-spoke architecture using private endpoints
A 403 Error occurs when using AzCopy to copy blobs between Storage accounts connected to private endpoints in different Spoke VNets from a VM in a Hub VNet. You can find a "403 This request is not authorized to perform this operation - CannotVerifyCopySource" error in the AzCopy logs or in the Azure Storage logs. The following architecture diagram shows the scenario in which the error occurs.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture.png" alt-text="Diagram that shows the 403 error of copying blobs between storage accounts in a Hub & Spoke architecture using Private Endpoints.":::

### Workaround 1: Create a private endpoint for the destination storage account in the source VNet
A possible workaround is to create a private endpoint for the destination storage account in the source VNet. This configuration allows the VM to successfully copy the blobs between the storage accounts by using AzCopy. The following architecture diagram shows the process of copying blobs between storage accounts in Workaround 1.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture-mitigation-1.png" alt-text="Diagram that shows the process of copying blobs between storage accounts in Workaround 1.":::

### Workaround 2: Place the VM in the same VNet as the source storage account and configure VNet peering between the source and destination VNets
Another option is to place the VM within the same VNet as the source storage account and set up [virtual network peering](azure/virtual-network/virtual-network-peering-overview) between this VNet and the destination VNet. This peering needs to be directly between the two VNets and cannot be done through the hub VNet. The following architecture diagram shows the process of copying blobs between storage accounts in Workaround 2.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture-mitigation-2.png" alt-text="Diagram that shows the process of copying blobs between storage accounts in Workaround 2.":::

More information, see [Virtual network peering FAQ](azure/virtual-network/virtual-networks-faq#virtual-network-peering).

### Workaround 3: Use a temporary staging account to copy the data
If you're unable to implement the previously mentioned workarounds or are restricted from changing the existing network configuration of the storage account or VNet, you can use a temporary staging account to copy the data:

1. Create a temporary storage account in the same region as the source storage account and the destination storage account.
2. Use AzCopy to copy the data from the source storage account to the temporary storage account.
3. Copy the data from the temporary storage account to the destination storage account. Make sure that the temporary storage account has a private endpoint in the same VNet as the destination storage account before performing the data transfer.

### Workaround 4: Use a VM and download the data to the VM and then upload the data to the destination storage account
Only use this workaround if other methods aren't feasible. Use a VM to download the data from the source storage account, and then upload it to the destination storage account. This can be done with AzCopy. Make sure that the VM's size and disk capacity are suitable for the data transfer process.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
