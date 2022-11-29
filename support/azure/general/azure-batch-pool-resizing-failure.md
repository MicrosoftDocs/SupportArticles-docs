---
title: Azure batch pool resizing failure
description: An Azure batch pool resizing failure occurs. You can review the symptoms, understand the causes, and apply solutions to this problem.
ms.date: 11/24/2022
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: biny
ms.service: batch
---
# Azure batch pool resizing failure

When you create a Batch pool, the operation succeeds. However, no nodes are provisioned and you see a warning in the **Overview** pane of the created pool. The warning indicates that the desired number of dedicated nodes could not be allocated.

:::image type="content" source="media/azure-batch-pool-resizing-failure/allocation-failure-warning.png" alt-text="Screenshot of the allocation failure warning.":::

This article describes how to resolve such Azure batch pool resizing failure.

## Scenario 1: Batch pool virtual network related issue

### Symptom for Scenario 1

After you access the warning, the following error message appears:

> **Code:** AllocationFailed  
> **Message:**  
> Desired number of dedicated nodes could not be allocated  
> **Values:**
> Reason - Allocation failed as subnet has delegation to external resources.

### Cause: Subnet has delegation to service resource

This error occurs because the subnet that you're using has delegation to a service. This network property allows you to deploy dedicated Azure Services in the virtual network to communicate with the service resources privately through private IP addresses. However, this feature is still not supported by the Azure Batch Service.

### Solution: Disable subnet delegation

To resolve this issue, disable the subnet delegation by using the Azure portal, PowerShell, Azure CLI or Azure Resource Manager Template. Then you'll be able to allocate Batch nodes.

For more information, see [Add or remove a subnet delegation in an Azure virtual network](/azure/virtual-network/manage-subnet-delegation#remove-subnet-delegation-from-an-azure-service).

## Scenario 2: Selected VM size doesn't support generation 2 image

### Symptom for Scenario 2

After you access the warning, the following error message appears:

> **Code:** AllocationFailed  
> **Message:**  
> Desired number of dedicated nodes could not be allocated  
> **Values:**  
> Provider Error Json - {  
> "error": {  
    "code": "BadRequest",  
     "message": "The selected VM size 'STANDARD_A1_V2' cannot boot Hypervisor Generation '2'. If this was a Create operation please check that the Hypervisor Generation of the Image matches the Hypervisor Generation of the selected VM Size. If this was an Update operation please select a Hypervisor Generation '2' VM Size."  
    }  
    }  
    Provider Error Json Truncated - False

### Cause: Selected image and VM size aren't compatible

This error occurs because the selected image and VM size aren't compatible.

In this scenario, the selected image has Hypervisor Generation 2 while the selected VM size doesn't support Hypervisor Generation 2.

Some VM sizes only support generation 2 images. When you select an image with Hypervisor Generation 1 and a VM size supporting only Hypervisor Generation 2, a similar error occurs.

### Solution 1: Select VM size that matches Hypervisor Generation of VM image or vice versa

To resolve this issue, select a VM size that matches the Hypervisor Generation of the VM image or vice versa. Some VM sizes support both Hypervisor Generation 1 and 2. For more information, see [Azure support for generation 2 VMs](/azure/virtual-machines/generation-2).

### Solution 2: Create custom image

If the image you want to use doesn't support the VM size that you plan to use, create and use a custom image of the VM that supports the Hypervisor Generation.

For more information, see [Tutorial - Create custom VM images with the Azure CLI](/azure/virtual-machines/linux/tutorial-custom-images).  

When you create the image definition, the image is created from generation 1 by default.

If you want to use generation 2, specify it by using the `az sig image-definition create` command as the following example:

```azurecli
az sig image-definition create --resource-group myGalleryRG --gallery-name myGallery --gallery-image-definition myImageDefinition --publisher myPublisher --offer myOffer --sku mySKU --os-type Linux --os-state specialized --hyper-v-generation V2
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
