---
title: Azure Batch node is stuck in Unusable state
description: Provides solutions to issues that cause unusable Azure Batch nodes.
ms.date: 02/14/2023
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: biny
ms.service: batch
---
# Azure Batch node is stuck in Unusable state

Azure Batch might set the [node state](/rest/api/batchservice/compute-node/get#computenodestate) to **Unusable** for many reasons. Tasks can't be scheduled to the node that's stuck in the **Unusable** state, but it still incurs charges. In most cases, Batch will try to recover the node. However, if the **Unusable** state is caused by a configuration issue, the node couldn't be recovered.

This article outlines some issues that cause nodes unusable and provides solutions.

## Scenario 1: Virtual network configuration issue

### Symptom for Scenario 1

- All nodes in the pool are in the **Unusable** state.
- There's no [error](/rest/api/batchservice/compute-node/get#computenodeerror) code on the nodes.

:::image type="content" source="media/azure-batch-node-unusable-state/node-state-shows-unusable.png" alt-text="Image alt text.":::

This symptom means that the Batch service is unable to communicate with the virtual machine (VM). In most cases, it's caused by VNet configuration issues. The following sections describes the two most common causes.

### Cause 1: Missing required network security group (NSG) rules

When the pool is associated with a subnet of a virtual network (VNet) and an NSG is configured in the subnet, if the communication to the compute nodes in the specified subnet is denied by the NSG, the Batch service will set the state of the compute nodes to **Unusable**.

### Solution for Cause 1: Configure NSG with inbound and outbound security rules

To resolve this issue, configure the NSG with at least the inbound and outbound security rules as shown below so that Batch can communicate with compute nodes.

Inbound security rules

:::image type="content" source="media/azure-batch-node-unusable-state/inbound-security-rules.png" alt-text="Screenshot of inbound security rules.":::

Outbound security rules

:::image type="content" source="media/azure-batch-node-unusable-state/outbound-security-rules.png" alt-text="Screenshot of outbound security rules.":::

To perform the configuration, follow these steps:

1. Check the pool properties to obtain the VNet and subnet name.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png" alt-text="Screenshot of the network configuration.":::

1. Search for the VNet name from the Azure portal.
1. Select **Subnets** under the **Settings** section. Select the subnet to open it.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-nsg-associated-to-subnet.png" alt-text="Screenshot of the subnet information.":::

1. In the right pane, find the NSG.
1. Search for the NSG. In the NSG page, check the configuration from **Overview**.

    :::image type="content" source="media/azure-batch-node-unusable-state/nsg-configuration.png" alt-text="Screenshot of the NSG configuration.":::

1. Configure this NSG with at least the inbound and outbound security rules as mentioned in [Network security groups for Virtual Machine Configuration pools: Specifying subnet-level rules](/azure/batch/batch-virtual-network#network-security-groups-for-virtual-machine-configuration-pools-specifying-subnet-level-rules)
1. Reboot the node to be back to the normal state.

### Cause 2: Missing required user-defined routes (UDR)

When the pool is associated with a subnet of a virtual network (VNet) and the VNet has forced tunneling enabled, if you don't add a UDR corresponding to the BatchNodeManagement.\<region> service tag in the region where your Batch account exists for the subnet, the traffic between the Batch service and compute nodes will be blocked and the compute nodes will become unusable.

### Solution for Cause 2: add UDR corresponding to BatchNodeManagement.\<region> service tag for the subnet

To resolve this issue, add a UDR corresponding to the BatchNodeManagement.\<region> service tag in the region where your Batch account exists for the subnet and set the **Next hop type** to **Internet**. For more information, see [User-defined routes for forced tunneling](/azure/batch/batch-virtual-network#user-defined-routes-for-forced-tunneling).

To do this, follow these steps:

1. Check the pool properties to obtain the VNet and subnet name.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png" alt-text="Screenshot of the network configuration.":::

1. Search for the VNet name from the Azure portal.
1. In the VNet page, select **Subnets** under the **Settings** section.
1. In the **Subnets** pane, find the subnet and select the route table associated with it.

    :::image type="content" source="media/azure-batch-node-unusable-state/select-route-table.png" alt-text="Screenshot that shows the subnet and its route table.":::

1. In the root table page, select **Routes** > **Add**.
1. In the **Add route** pane, add the required BatchNodeManagement and set the **Next hop type** to **Internet**.

    :::image type="content" source="media/azure-batch-node-unusable-state/select-route-table.png" alt-text="Screenshot that shows how to add a UDR.":::

1. Reboot the node to be back to the normal state.

## Scenario 2: Disk full issue

### Symptom for Scenario 2

The Batch compute node is in unusable state and the following error message shows on the node:

> **Code:** DiskFull
> **Message:**  
> There is no enough disk space on the node  
> **Values:**  
> Message - The VM disk is full. Delete job, tasks, or file on the node to free up spaces and then reboot the node.

:::image type="content" source="media/azure-batch-node-unusable-state/node-error-disk-full.png" alt-text="Screenshot of the 'DiskFull' error message.":::

### Cause: No enough disk space on the node

When a job is run on the Batch compute node, each task in the job may produce output data. This output data is written to the file system of the Batch compute node. When this data reaches more than 90% capacity of the disk size of the compute node SKU, the Batch service marks the node unusable and blocks the node from running any further tasks until a cleanup has been done.

Batch node agent reserves 10% capacity of the disk space for its functionality. Before any tasks are scheduled to run depending on the capacity of the Batch compute node, it's essential to keep enough spaces on the disk. For best practices while designing the tasks, see [Tasks](/azure/batch/best-practices#tasks).

### Resolution: Clear files in task folders

To resolve the issue, follow these steps:

1. Connect to the Batch compute node that's in unusable state by using RDP.
2. Check the space available on the disk.

    If there isn't enough space available on the disk, go to the step 3. If there is enough space available on the disk for the tasks to run but the Batch compute node is unusable, this may be because the Batch service has cleaned up the files based on the retention policy of the task. In this case, go to step 4.

    For example, assume that the VM SKU for both Windows and Linux are Standard_D2s_V3 where the disk size is 16 Gigabytes (GB).

    For Windows, the following screenshot shows there's less than 1 GB space available on the disk.

    :::image type="content" source="media/azure-batch-node-unusable-state/disk-space-less-than-one-gigabyte.png" alt-text="Screenshot that shows the available disk space is less than 1 Gigabyte.":::

    > [!NOTE]
    > For Windows, you can also use the File Explorer to check the disk space.

    For Linux, the following screenshot shows that 100% of the mounted disk has been utilized:

    :::image type="content" source="media/azure-batch-node-unusable-state/100-percent-usage-of-mounted-disk.png" alt-text="Screenshot that shows the 100% of the mounted disk has been is used.":::

    Task related files on Linux are located under `./mnt/batch/tasks/workitems/`.

3. Navigate to each task folder and clear the files.
4. Once the files are cleared, restart the Batch compute node.

    After the Batch compute node is restarted, the node should be in healthy state and can accept new tasks.

    :::image type="content" source="media/azure-batch-node-unusable-state/node-in-healthy-state.png" alt-text="Screenshot of node in healthy state.":::

## Scenario 3: Custom image configuration issue

Sometimes, custom-image-related issues such as inappropriately prepared custom images result in unusable nodes. Because custom images introduce a wide range of variables that may cause unusable nodes, it's difficult to generate a comprehensive list of such causes. Instead, we have summarized a list of previously observed symptoms, causes, and resolutions.

### Symptom for Scenario 3

Batch compute node is in **Unusable** or **Starting** state and the following error code shows on the node:

> **Code:**  
> BatchAgentInstallationFailure  
> **Message:**  
> The batch agent extension provisioning has failed on compute node

:::image type="content" source="media/azure-batch-node-unusable-state/batchagentinstallationfailure-error-message.png" alt-text="Screenshot of the BatchAgentInstallationFailure error message.":::

### Cause: OS SKU of custom image is different from OS SKU selected during pool creation

When you create an Azure Batch pool via the Azure portal, if you set **Image Type** to **Custom Image – Shared Image Gallery**, the Azure portal won't perform the OS SKU validation. If you select an OS SKU that's different from the actual OS SKU used in the custom image, Azure Batch will install Batch Node Agent that matches the selected OS SKU instead of the actual OS SKU used by the custom image.

:::image type="content" source="media/azure-batch-node-unusable-state/set-batch-pool-image-type-os-sku.png" alt-text="Screenshot that shows the setting of the image type and OS sku during pool creation.":::

### Solution: Recreate the Batch pool with the right OS SKU

To resolve this issue, recreate the Batch pool with the right OS SKU.

For more information about how to create a custom image, see the following articles:

- [Use the Azure Compute Gallery to create a custom image pool](/azure/batch/batch-sig-images) 
- [Remove machine specific information by generalizing a VM before creating an image](/azure/virtual-machines/generalize)

## Scenario 4: Managed identity configuration issue

When the authentication mode of the linked Azure Storage account (or called auto-storage account) is set to **Batch Account Managed Identity** as shown below, wrong configuration on the pool identity will cause various problems. For more information, see [Behavior scenarios](use-managed-identities-azure-batch-account-pool.md#behavior-scenarios).

:::image type="content" source="media/azure-batch-node-unusable-state/batch-account-managed-identity-authentication-mode.png" alt-text="Screenshot of the 'Batch Account Managed Identity' authentication mode.":::

### Symptom for Scenario 4

Batch compute node is in unusable state and the following error code shows on the node:

> **Code:** ApplicationPackageError  
> **Message:**  
> One or more application packages specified for the pool are invalid  
> **Values:**  
> ApplicationPackageReference - asdf:0.0.1
> Message - Resource download failed

:::image type="content" source="media/azure-batch-node-unusable-state/application-package-error.png" alt-text="Screenshot of the ApplicationPackageError.":::

### Cause: Managed identity defined in the node identity reference isn't added to the pool identity

When you create the Batch pool, you can specify multiple managed identities. If the managed identity defined in the node identity reference (configured in the auto-storage account) isn't added to the pool identity, the compute nodes can't use the correct managed identity for authentication. This causes the application package download process fails, which causes the node unusable.

### Solution: re-create the pool with the right managed identity

To resolve this issue, re-create the pool with the right managed identity defined in the node identity reference. For more information about using Batch pool managed identity, see [Set up managed identity in your batch pool](use-managed-identities-azure-batch-account-pool.md#set-up-managed-identity-in-your-batch-pool).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
