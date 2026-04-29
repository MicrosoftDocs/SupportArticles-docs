---
title: Use AzCopy to copy blobs between storage accounts with access restriction
description: Learn how to copy blobs between storage accounts with AzCopy when network restrictions are enabled, and follow the steps to get started.
ms.date: 03/25/2024
ms.topic: how-to
ms.service: azure-storage
ms.reviewer: jiajwu, jeromeliu, azurestocic, v-weizhu
ms.custom: sap:Connectivity
---
# Use AzCopy to copy blobs between Azure storage accounts with network restrictions

## Summary

This article introduces how to copy blobs between storage accounts by using the AzCopy command-line utility. It also explains how to implement the copy operation when network restrictions are configured for the storage accounts.

## Background

Copying blob files between two storage accounts is a common requirement for many Azure users. Azure Storage supports directly copying blobs from one storage account to another, which you can implement by using the AzCopy command-line utility. You don't need to download files to local disks or buffers and then upload them again.

Copying blobs between two storage accounts by using AzCopy doesn't rely on the network bandwidth of your local computer. This method can take advantage of the performance of storage accounts and Azure Virtual Network to achieve better throughput than downloading and uploading files. If both storage accounts are in the same region, you don't pay any bandwidth charges.

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

If you need to restrict access to both source and destination storage accounts through the storage firewall, you might need additional configurations for copying blobs between storage accounts by using AzCopy. This restriction exists because the copy request between two storage accounts uses private IP addresses, and the IP addresses are dynamic.

Two supported scenarios exist:

### Scenario 1: The client uses a public endpoint to access storage accounts

In this scenario, you must add the client's public IP address or virtual network (VNet) to the firewall allowlist in the source and destination storage accounts.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-with-vnet-in-allowlist.png" alt-text="Screenshot of blob copy between storage accounts in scenario 1 with a VNet in the firewall allowlist.":::

### Scenario 2: The client's VNet has private links configured, and it uses a private endpoint to access storage accounts

In this scenario, you don't need a firewall allowlist.

The following image shows the process of copying blobs between storage accounts in this scenario:

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/firewall-enabled-with-no-rule.png" alt-text="Screenshot of blob copy between storage accounts in scenario 2 by using private endpoints without a firewall allowlist.":::

Here's the full process of this mechanism for the two scenarios:

1. The client sends a PutBlockfromURL request to the destination storage.
1. The destination storage receives the requests and tries to get blocks from the given source URL. However, since the destination storage isn't allowed by the source firewall, it receives a **403 Forbidden** error.
1. After the destination storage receives the **403 Forbidden** error, it sends another GetBlob request on behalf of the client. If the client has access to the source storage, the destination can get the blocks from the source and return a success response code to the client.
1. The client sends PutBlockList to the destination storage to commit the blocks and finish the process after receiving a success response code from the request.

### Scenario 3: The client uses public endpoints with network security perimeter enforced

In this scenario, you need to configure network security perimeter access rules so the request succeeds for all three paths: client-to-destination, client-to-source, and destination-to-source. If there's no authorized access across any of the three paths, the copy operation fails and usually shows a **403 Forbidden** error. For more information about network security perimeters, see [What is a network security perimeter?](https://docs.azure.cn/private-link/network-security-perimeter-concepts#components-of-a-network-security-perimeter)

**Client, source, and destination accounts in the same perimeter** 

When the client, source account, and destination account are all within the same perimeter, traffic between them is allowed as intra-perimeter communication. This configuration is recommended, as intra-perimeter communication ensures that all three paths are authorized without requiring extra access rules. 

**Source and destination accounts in the same perimeter** 

When source and destination accounts are in the same perimeter, traffic between them is allowed as intra-perimeter communication. In this scenario, you need to ensure that inbound access is granted to the client from both accounts. 

1. The client sends a Put Block From URL request to the destination storage account.  

   To permit this request, ensure that inbound access is granted to the client from the destination account. 
   
1. The destination account sends a Get Block request to the source storage account. 

   The destination storage account receives the request and tries to retrieve blocks from the given source URL. Because the destination retrieves blocks from the source on behalf of the client, inbound access from the client must be granted on both the source and destination accounts.
   
   To permit this request, ensure that inbound access is granted to the client from the source account. 
   
**Client, source account, and destination account in different perimeters** 

When the client, source account, and destination account are all in different perimeters, you can allow cross-perimeter communication and simplify access rule requirements by using perimeter links. For more information, see [az network perimeter link](/cli/azure/network/perimeter/link?view=azure-cli-latest&preserve-view=true). 

A perimeter link is the only supported method for granting inbound access to a client that resides in a different perimeter than the source or destination account. If you don't use a perimeter link to allow communication between source and destination account perimeters, you must configure the following access rules:

1. The client sends a Put Block From URL request to the destination storage account.  
      
1. The destination account sends a Get Block request to the source storage account. 

   To permit this request, ensure that: 
   
   - Outbound access is granted to the source account from the destination account.
   - Inbound access is granted to the destination account from the source account.
  
:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/outboundaccessrule.png" alt-text="Screenshot of the access rule definition." lightbox="media/copy-blobs-between-storage-accounts-network-restriction/outboundaccessrule.png":::   
      
For more information about managing inbound and outbound access, see [Network Security Perimeter Access Rules](/rest/api/network-security-perimeter/network-security-perimeter-access-rules/create-or-update?view=rest-network-security-perimeter-2025-05-01&tabs=HTTP&preserve-view=true) and [az network perimeter profile access-rule](/cli/azure/network/perimeter/profile/access-rule?view=azure-cli-latest&preserve-view=true).
   
## Copy blobs between storage accounts in a Hub-spoke architecture using private endpoints

A 403 error occurs when you use AzCopy to copy blobs between storage accounts connected to private endpoints in different spoke VNets from a VM in a hub VNet. You see a `403 This request is not authorized to perform this operation - CannotVerifyCopySource` error in the AzCopy logs or in the Azure Storage logs. The following architecture diagram shows the scenario in which the error occurs.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture.png" alt-text="Diagram that shows the 403 error of copying blobs between storage accounts in a Hub & Spoke architecture using Private Endpoints.":::

### Workaround 1: Create a private endpoint for the destination storage account in the source VNet

Create a private endpoint for the destination storage account in the source VNet. This configuration allows the VM to successfully copy the blobs between the storage accounts by using AzCopy. The following architecture diagram shows the process of copying blobs between storage accounts in Workaround 1.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture-mitigation-1.png" alt-text="Screenshot of blob copy between storage accounts in workaround 1 with a destination private endpoint in the source VNet.":::

### Workaround 2: Place the VM in the same VNet as the source storage account and configure VNet peering between the source and destination VNets

Place the VM within the same VNet as the source storage account and set up [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) between this VNet and the destination VNet. This peering needs to be directly between the two VNets and can't be done through the hub VNet. The following architecture diagram shows the process of copying blobs between storage accounts in Workaround 2.

:::image type="content" source="media/copy-blobs-between-storage-accounts-network-restriction/hub-spoke-network-topology-architecture-mitigation-2.png" alt-text="Screenshot of blob copy between storage accounts in workaround 2 with a VM in the source VNet and direct VNet peering.":::

For more information, see [Virtual network peering FAQ](/azure/virtual-network/virtual-networks-faq#virtual-network-peering).

### Workaround 3: Use a temporary staging account to copy the data

If you can't implement the previously mentioned workarounds or are restricted from changing the existing network configuration of the storage account or VNet, use a temporary staging account to copy the data:

1. Create a temporary storage account in the same region as the source storage account and the destination storage account.
1. Use AzCopy to copy the data from the source storage account to the temporary storage account.
1. Copy the data from the temporary storage account to the destination storage account. Make sure that the temporary storage account has a private endpoint in the same VNet as the destination storage account before you perform the data transfer.

### Workaround 4: Use a VM to download and upload data between storage accounts

Use this workaround only if other methods aren't feasible. Use a VM to download the data from the source storage account, and then upload it to the destination storage account. You can use AzCopy for this process. Make sure that the VM's size and disk capacity are suitable for the data transfer process.

 
