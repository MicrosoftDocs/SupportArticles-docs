---
title: Azure Batch node gets stuck in the Unusable state due to configuration issues
description: Provides solutions to issues that cause unusable Azure Batch nodes.
ms.date: 02/14/2023
ms.reviewer: biny, v-weizhu
ms.service: batch
---
# Azure Batch node gets stuck in the Unusable state due to configuration issues

Azure Batch might set [the state of a Batch node](/rest/api/batchservice/compute-node/get#computenodestate) to **Unusable** for many reasons. You can't schedule tasks to a node in the **Unusable** state, but it still incurs charges. In most cases, the Batch service will try to recover the node. However, if the **Unusable** state is caused by a configuration issue, the node couldn't be recovered. This article discusses some common configuration issues that cause nodes to be unusable and provides solutions.

## Virtual network configuration issues

In a pool that's associated with a subnet of a virtual network (VNet), all nodes are in the **Unusable** state. But there's no [error](/rest/api/batchservice/compute-node/get#computenodeerror) code on the nodes.

:::image type="content" source="media/azure-batch-node-unusable-state/node-state-shows-unusable.png" alt-text="Screenshot that shows the state of a node.":::

The symptom above means that the Batch service is unable to communicate with the nodes. In most cases, it's caused by VNet configuration issues. The following sections describe the two most common causes.

### Cause 1: Missing required network security group (NSG) rules

When an NSG is configured in the subnet, it's required to configure this NSG with at least the inbound and outbound security rules, as shown below, so that the Batch service can communicate with nodes. If the communication to the nodes in the specified subnet is denied by the NSG, the Batch service will set the state of the nodes to **Unusable**.

- Inbound security rules

    :::image type="content" source="media/azure-batch-node-unusable-state/inbound-security-rules.png" alt-text="Screenshot of inbound security rules." border="false":::

- Outbound security rules

    :::image type="content" source="media/azure-batch-node-unusable-state/outbound-security-rules.png" alt-text="Screenshot of outbound security rules." border="false":::

### Solution 1: Configure NSG with required inbound and outbound security rules

To resolve this issue, configure the NSG with the required inbound and outbound security rules as recommended in [Network security groups for Virtual Machine Configuration pools: Specifying subnet-level rules](/azure/batch/batch-virtual-network#network-security-groups-for-virtual-machine-configuration-pools-specifying-subnet-level-rules).

To perform the configuration, follow these steps:

1. Navigate to the pool from the Azure portal.
1. Check the pool properties to obtain the VNet and subnet names.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png" alt-text="Screenshot of the network configuration." lightbox="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png":::

1. Navigate to the VNet. On the VNet page, select **Settings** > **Subnets**. In the list of subnets, select the expected subnet. In the subnet pane, find the NSG.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-nsg-associated-to-subnet.png" alt-text="Screenshot of the subnet information." lightbox="media/azure-batch-node-unusable-state/check-nsg-associated-to-subnet.png":::

1. Navigate to the NSG. Check the configuration on the NSG page.

    :::image type="content" source="media/azure-batch-node-unusable-state/nsg-configuration.png" alt-text="Screenshot of the NSG configuration." lightbox="media/azure-batch-node-unusable-state/nsg-configuration.png":::

1. Configure this NSG with the required inbound and outbound security rules.
1. Reboot the node to be back to the normal state.

### Cause 2: Missing required user-defined routes (UDR)

When the VNet, where the pool is associated, has forced tunneling enabled, it's required to add a UDR corresponding to the BatchNodeManagement.\<region> service tag in the region where your Batch account exists. Otherwise, the traffic between the Batch service and nodes will be blocked, and the compute nodes will become unusable.

### Solution 2: Add UDR corresponding to BatchNodeManagement.\<region> service tag

To resolve this issue, add a UDR corresponding to the BatchNodeManagement.\<region> service tag in the region where your Batch account exists and set the **Next hop type** to **Internet**. For more information, see [User-defined routes for forced tunneling](/azure/batch/batch-virtual-network#user-defined-routes-for-forced-tunneling).

To do this, follow these steps:

1. Navigate to the pool from the Azure portal.
1. Check the pool properties to obtain the VNet and subnet names.

    :::image type="content" source="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png" alt-text="Screenshot of the network configuration." lightbox="media/azure-batch-node-unusable-state/check-vnet-subnet-name.png":::

1. Navigate to the VNet. On the VNet page, select **Settings** > **Subnets**. In the list of subnets, select the route table associated with the expected subnet.

    :::image type="content" source="media/azure-batch-node-unusable-state/select-route-table.png" alt-text="Screenshot that shows the subnet and its route table.":::

1. On the root table page, select **Routes** > **Add**. In the **Add route** pane, add the required UDR and set the **Next hop type** to **Internet**.

    :::image type="content" source="media/azure-batch-node-unusable-state/add-route-table.png" alt-text="Screenshot that shows how to add a UDR.":::

1. Reboot the node to be back to the normal state.

### Cause 3: Bad DNS configuration causing node unable to communicate with node management endpoint

This scenario is for the pool in batch account **with nodeManagement private endpoint enabled**. (Usually these pools are with simplified node communication and without public IP.) If the DNS is not well configured, that will also cause the nodes unable to communicate with the Batch service endpoint, then further cause the Batch nodes in unusable status.

### Solution 3: Verify the DNS resolution and modify it if it's not well configured

To verify if the custom DNS is working as expected, follow these steps:
1. Navigate to the **Batch Account** from the Azure portal.
1. Note down the **Node management endpoint URL** from **Batch Account Overview** page, **Essentials** part. It usullay seems like **\<GUID>.\<region>.service.batch.azure.com**

    :::image type="content" source="media/azure-batch-node-unusable-state/nodemanagementendpoint.png" alt-text="Screenshot of the node management endpoint URL." lightbox="media/azure-batch-node-unusable-state/nodemanagementendpoint.png":::

1. Navigate to the **Node management private endpoint** in the Azure Portal, click on **DNS configuration** page and note down the **private IP address** of the node management private endpoint.

    :::image type="content" source="media/azure-batch-node-unusable-state/node-management-endpoint-PE-ip.png" alt-text="Screenshot of the node management private endpoint IP." lightbox="media/azure-batch-node-unusable-state/node-management-endpoint-PE-ip.png":::

1. Create a Batch node or a Virtual Machine inside **same Vnet with which the pool is created**, connect into the node and open a PowerShell window (windows) or Shell window (Linux).

1. Test the DNS resolution by command **nslookup \<nodeMmanagementEndpointURL>**. (nslookup is default installed in Windows. For Linux, please install this at first or use other tools) The expected result is the same as the private IP address of node management private endpoint.
```
PS C:\Users\xxx> nslookup <nodeMmanagementEndpointURL>
Server:  UnKnown
Address:  x.x.x.x

Name:    <nodeMmanagementEndpointURL>
Address:  <private-ipnode-management-endpoint-private-ip>
Aliases:  <nodeMmanagementEndpointURL>
```

1. Test the connectivity by command **Test-NetConnection -ComputerName \<nodeMmanagementEndpointURL> -Port 443**. (For Linux, please use nc -v \<nodeMmanagementEndpointURL> 443) The expected result is being able to connect.
```
PS C:\Users\xxx> Test-NetConnection -ComputerName <nodeMmanagementEndpointURL> -Port 443

ComputerName     : <nodeMmanagementEndpointURL>
RemoteAddress    : <private-ipnode-management-endpoint-private-ip>
RemotePort       : 443
InterfaceAlias   : Ethernet
SourceAddress    : <vm-private-ip>
TcpTestSucceeded : True
```

If the result of nslookup command is not expected, please check the custom DNS setting of the VNet of the pool, including **Private DNS zone with name privatelink.batch.azure.com**, **custom DNS server** and any other services/components which may impact the DNS resolution.

If the result of nslookup command is expected, but the result of Test-NetConnection or nc command is not expected, please confirm if there is any service such as Network Security Group and Firewall which can block the outgoing connectivity from the VNet.


## Disk full issue

A node is in the **Unusable** state, and the following error message shows on the node:

> **Code:** DiskFull
> **Message:**  
> There is not enough disk space on the node  
> **Values:**  
> Message - The VM disk is full. Delete job, tasks, or file on the node to free up spaces and then reboot the node.

:::image type="content" source="media/azure-batch-node-unusable-state/node-error-disk-full.png" alt-text="Screenshot of the 'DiskFull' error message." lightbox="media/azure-batch-node-unusable-state/node-error-disk-full.png":::

### Cause: Not enough disk space on the node

When a job runs on the node, each task in the job may produce output data. This output data is written to the file system of the Batch node. When this data reaches more than 90% capacity of the disk size of the node SKU, the Batch service marks the node unusable and blocks the node from running any further tasks until the Batch service has performed a cleanup.

The Batch node agent reserves 10% capacity of the disk space for its functionality. Before any tasks are scheduled to run, depending on the capacity of the Batch node, it's essential to keep enough space on the disk. For best practices while designing the tasks, see [Tasks](/azure/batch/best-practices#tasks).

### Solution: Clear files in task folders

To resolve the issue, follow these steps:

1. Connect to the node by using RDP.
2. Check the space available on the disk.

    - If there isn't enough space available on the disk, go to step 3.

        The following example shows there isn't enough space available on the disk. In this example, the VM SKU for Windows and Linux is Standard_D2s_V3, where the disk size is 16 Gigabytes (GB).
    
        For Windows, the following screenshot shows there's less than 1 GB of space available on the disk:
    
        :::image type="content" source="media/azure-batch-node-unusable-state/disk-space-less-than-one-gigabyte.png" alt-text="Screenshot that shows the available disk space is less than 1 Gigabyte.":::
    
        > [!NOTE]
        > For Windows, you can also use File Explorer to check the disk space.

        For Linux, the following screenshot shows that 100% of the mounted disk has been utilized:

        :::image type="content" source="media/azure-batch-node-unusable-state/100-percent-usage-of-mounted-disk.png" alt-text="Screenshot that shows the 100% of the mounted disk has been used.":::

        Task related files on Linux are located under `./mnt/batch/tasks/workitems/`.

    - If there is enough space available on the disk for the tasks to run, but the node is unusable, this may be because the Batch service has cleaned up the files based on the retention policy of the task. In this case, go to step 4.

3. Navigate to each task folder and clear the files.
4. Once the files are cleared, restart the node.

    After the node is restarted, the node should be in a healthy state and can accept new tasks.

    :::image type="content" source="media/azure-batch-node-unusable-state/node-in-healthy-state.png" alt-text="Screenshot of node in a healthy state.":::

## Custom image configuration issue

Sometimes, custom image configuration issues, for example, custom images aren't appropriately prepared, can result in unusable nodes. Custom images use a wide range of variables. These variables may cause nodes to be unusable.

A Batch node is in the **Unusable** or **Starting** state, and the following error code shows on the node:

> **Code:**  
> BatchAgentInstallationFailure  
> **Message:**  
> The batch agent extension provisioning has failed on compute node

:::image type="content" source="media/azure-batch-node-unusable-state/batchagentinstallationfailure-error-message.png" alt-text="Screenshot of the BatchAgentInstallationFailure error message." lightbox="media/azure-batch-node-unusable-state/batchagentinstallationfailure-error-message.png":::

### Cause: OS SKU of the custom image is different from OS SKU selected during pool creation

When you create an Azure Batch pool via the Azure portal, if you set **Image Type** to **Custom Image – Shared Image Gallery**, the Azure portal won't perform the OS SKU validation. If you select an OS SKU that's different from the actual OS SKU used in the custom image, Azure Batch will install Batch Node Agent that matches the selected OS SKU instead of the actual OS SKU used in the custom image.

In the following screenshot, the custom image is based on Canonical's Ubuntu 20 Azure Marketplace image. When setting the **OS sku**, the Azure Batch won't perform the validation.

:::image type="content" source="media/azure-batch-node-unusable-state/set-batch-pool-image-type-os-sku.png" alt-text="Screenshot that shows the setting of the image type and OS sku during pool creation.":::

### Solution: Recreate the pool with OS SKU of custom image

To resolve this issue, recreate the pool with the OS SKU used in the custom image.

For more information about how to create a custom image, see the following articles:

- [Use the Azure Compute Gallery to create a custom image pool](/azure/batch/batch-sig-images)
- [Remove machine specific information by generalizing a VM before creating an image](/azure/virtual-machines/generalize)

## Managed identity configuration issue

When the authentication mode of the linked Azure Storage account (also called auto-storage account) is set to **Batch Account Managed Identity**, as shown below, the wrong configuration on the pool identity will cause nodes to be unusable. For more information, see [Behavior scenarios](use-managed-identities-azure-batch-account-pool.md#behavior-scenarios).

:::image type="content" source="media/azure-batch-node-unusable-state/batch-account-managed-identity-authentication-mode.png" alt-text="Screenshot of the 'Batch Account Managed Identity' authentication mode.":::

A Batch node is in the **Unusable** state, and the following error code shows on the node:

> **Code:** ApplicationPackageError  
> **Message:**  
> One or more application packages specified for the pool are invalid  
> **Values:**  
> ApplicationPackageReference - asdf:0.0.1
> Message - Resource download failed

:::image type="content" source="media/azure-batch-node-unusable-state/application-package-error.png" alt-text="Screenshot of the ApplicationPackageError.":::

### Cause: Managed identity defined in node identity reference isn't added to pool identity

When you create the pool, you can specify multiple managed identities. If the managed identity defined in the node identity reference (configured in the auto-storage account) isn't added to the pool identity, nodes can't use the correct managed identity for authentication. This causes the application package download process to fail, which causes the node to be unusable.

### Solution: Re-create the pool with the right managed identity

To resolve this issue, re-create the pool with the right managed identity defined in the node identity reference. For more information about using Batch pool managed identity, see [Set up managed identity in your batch pool](use-managed-identities-azure-batch-account-pool.md#set-up-managed-identity-in-your-batch-pool).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
