---
title: Azure storage account with firewall causes errors when executing Batch jobs
description: Provides solutions for access issues when you execute Azure Batch jobs.
ms.date: 05/23/2025
ms.service: azure-batch
ms.reviewer: biny, v-weizhu
ms.custom: sap:Azure Batch
---
# Access denied when executing Azure Batch jobs

The Azure Storage Account is a necessary dependent component for the Azure Batch account to store resource files, application packages, and output files. In many cases, you use Azure Storage Account with a firewall to enhance its security. However, Azure Storage Account with a firewall may cause errors when you execute Azure Batch jobs. This article provides solutions for such issues.

## Symptoms

When executing Azure Batch jobs, you may encounter errors related to the associated Azure storage account.

Here is an error example:

> **Category**: UserError  
> **Code**: ResourceContainerAccessDenied  
> **Message**: Access for one of the specified Azure Blog container(s) is denied

## Cause

When you create an Azure Batch pool, new virtual machines (Batch nodes) will be provisioned. If you don't assign a static public IP address to the Batch pool, a random public IP address will be assigned. Whenever you resize the number of nodes to 0 and resize out again, the public IP address of these new Batch nodes will change. Therefore, if the associated storage account has a firewall configured, it's hard for you to manage the allowlist of the firewall.

If the storage account and the Batch pool are in the same region, no matter if the Batch pool has a static public IP address or not, the outbound traffic from Batch nodes will always go via the Azure backbone internet (private IP addresses). The storage firewall isn't allowed to add a private IP address in the allowlist, which will cause the traffic to the storage account to be denied.

## Resolution

To resolve the issue, manage the Batch pool and the storage account configurations based on your scenarios.

> [!NOTE]
> If you need to upload application packages, none of following solutions will work. The storage account must not configure any firewall. For more information, see [Link a storage account](/azure/batch/batch-application-packages#link-a-storage-account).

### Scenario 1: Batch pool and storage account are in the same region, and Batch pool has a virtual network

1. Check **Subnet information** under **Network Configuration** from the Azure portal > **Batch Account** > **Pool** > **Properties**. Take note and write the information down.

    :::image type="content" source="media/access-denied-execute-azure-batch-job/azure-batch-pool-subnet.png" alt-text="Screenshot of the Azure Batch pool subnet information." lightbox="media/access-denied-execute-azure-batch-job/azure-batch-pool-subnet.png":::

2. Navigate to the storage account, and select **Networking**. In the **Firewalls and virtual networks** setting, select **Enable from selected virtual networks and IP addresses** for **Public network access**. Add the Batch pool's subnet in the firewall allowlist.

    :::image type="content" source="media/access-denied-execute-azure-batch-job/add-subnet-to-firewall-allow-list.png" alt-text="Screenshot that shows how to add subnet to firewall allowlist." lightbox="media/access-denied-execute-azure-batch-job/add-subnet-to-firewall-allow-list.png":::

    If the subnet doesn't enable the service endpoint, when you select it, a notification will be displayed as follows:

    > The following networks don't have service endpoints enabled for 'Microsoft.Storage'. Enabling access will take up to 15 minutes to complete. After starting this operation, it is safe to leave and return later if you don't wish to wait.

    Therefore, before you add the subnet, check it in the Batch virtual network to see if the service endpoint for the storage account is enabled.

    :::image type="content" source="media/access-denied-execute-azure-batch-job/service-endpoint-enabled.png" alt-text="Screenshot that shows how to check if the service endpoint is enabled.":::

After you complete the configurations above, the Batch nodes in the pool can access the storage account successfully.

### Scenario 2: Batch pool and storage account are in different regions

1. Create a new Batch pool in a virtual network with a static public IP address. For more information, see [Create a Batch pool with specified public IP addresses](/azure/batch/create-pool-public-ip).

    Because the Batch pool and storage account are in different regions, the outbound traffic will go through the public internet via the public IP address.

2. Write down the public IP address.

3. Assign the public IP address to the Batch pool public Load Balancer's IP.

    After that, check your Batch pool's properties. They will be like the ones in the following screenshot:

    :::image type="content" source="media/access-denied-execute-azure-batch-job/azure-batch-pool-properties.png" alt-text="Screenshot of Batch pool's properties." lightbox="media/access-denied-execute-azure-batch-job/azure-batch-pool-properties.png":::

4. Add the public IP address to the storage firewall allowlist.

    :::image type="content" source="media/access-denied-execute-azure-batch-job/azure-batch-pool-public-ip-address.png" alt-text="Screenshot of the public IP address." lightbox="media/access-denied-execute-azure-batch-job/azure-batch-pool-public-ip-address.png":::

    :::image type="content" source="media/access-denied-execute-azure-batch-job/add-public-ip-to-firewall-allow-list.png" alt-text="Screenshot that shows the public IP address is added to allowlist." lightbox="media/access-denied-execute-azure-batch-job/add-public-ip-to-firewall-allow-list.png":::

5. Run the Batch jobs with the newly created Batch pool.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
