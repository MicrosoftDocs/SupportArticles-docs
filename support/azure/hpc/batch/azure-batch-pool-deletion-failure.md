---
title: Azure batch pool deletion failure
description: An Azure batch pool deletion failure occurs. You can review the symptoms, understand the causes, and apply solutions to this problem.
ms.date: 10/19/2022
editor: v-jsitser
ms.reviewer: biny, v-leedennis
ms.service: batch
#Customer intent: As an Azure Batch user, I want to troubleshoot why a batch pool deletion attempt fails so that I can successfully continue to use the Azure Batch service after I delete a batch pool.
---
# Azure batch pool deletion failure

This article describes how to resolve an Azure batch pool deletion failure.

## Scenario 1: Batch pool deletion fails quickly

When you try to delete a batch pool, the operation quickly fails. The activity log or Azure portal notification contains an error message that indicates one of two possible issues that involve resource locks.

### Symptom 1a

The following error message appears in the activity log or in the notification:

> Deleting pool failed\
> There is an error encountered while deleting pool '\<pool-name>', Server returns 'ScopeLocked: The scope '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Batch/batchAccounts/\<batch-account-mame>/pools/\<pool-name> cannot perform delete operation **because following scope(s) are locked: '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>**. Please remove the lock and try again.

#### Cause 1a: Batch account resource group is locked

A [resource lock][res-lock] was put onto the resource group of the batch account. This lock prevents any delete operations from being completed.

#### Solution 1a: Remove the resource lock on the resource group first

Remove the resource lock on the resource group before you delete the batch pool.

### Symptom 1b

The following error message appears in the activity log or in the notification:

> There is an error encountered while deleting pool '\<pool-name>', Server returns 'ScopeLocked: The scope '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Batch/batchAccounts/\<batch-account-name>/pools/\<pool-name> cannot perform delete operation **because following scope(s) are locked: '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Batch/batchAccounts/\<batch-account-name>**. Please remove the lock and try again.

#### Cause 1b: Batch account is locked

A [resource lock][res-lock] was put onto the batch account. This lock prevents any delete operations from being completed.

#### Solution 1b: Remove the resource lock on the batch account first

Remove the resource lock on the batch account before you delete the batch pool.

## Scenario 2: Batch pool is stuck in resizing mode after an attempted pool deletion

After you try a pool delete operation, the pool is stuck in resizing mode, and the node status is stuck in an "X -> 0" state. The following notification appears:

> Deleting pool... Running\
> Pool is currently being deleted.

If the pool enables a virtual network, check the activity logs of this batch account. If these activity logs don't show an error, check the activity log of the resource group that contains that virtual network. You might discover one of the following reported failures.

### Symptom 2a

The batch service can't delete the load balancer, as shown by the following activity log entry:

> The scope '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Network/loadBalancers/\<guid>-azurebatch-cloudserviceloadbalancer' cannot perform delete operation **because following scope(s) are locked: '/subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>**. Please remove the lock and try again.

#### Cause 2a: Extra networking resources in the resource group are locked

When you create a batch pool that enables a virtual network, the batch service automatically creates more networking resources in the resource group that contains the virtual network. If you delete the batch pool or resize the pool to zero nodes, the batch service tries to delete these extra networking resources. Because resource locks prevent the deletion of one or more of these extra resources, the pool deletion can't continue.

#### Solution 2a: Remove resource locks on the extra networking resources

Remove the resource lock from the resource group that contains the virtual network. The pool should then be fully deleted after about 20 minutes.

### Symptom 2b

The batch service can't delete the network security group (NSG), as shown by the following activity log entry:

> **Network security group** /subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Network/networkSecurityGroups/\<guid>-azurebatch-cloudservicenetworksecuritygroup **cannot be deleted because it is in use by the following resources: /subscriptions/\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Network/virtualNetworks/\<virtual-network-name>/subnets/\<subnet-name>**. In order to delete the Network security group, remove the association with the resource(s). To learn how to do this, see [Delete a network security group](/azure/virtual-network/manage-network-security-group#delete-a-network-security-group).

#### Cause 2b: Batch-created resource dependencies are locked

The resources that you created have a dependency on a resource that was created by the batch service. For instance, if you create a pool in a virtual network, the batch service creates an NSG, a public IP address, and a load balancer. If you use these resources outside the batch pool, the pool can't be deleted until that dependency is removed. In this example, the NSG is used by another subnet. This prevents the NSG from being deleted. Because the NSG isn't deleted, the batch service can't finish deleting the batch pool.

#### Solution 2b: Disassociate the resource dependencies

Remove the batch pool dependencies on the resources that are used outside the batch pool. For this example, you would [disassociate the NSG from the subnet](/azure/virtual-network/manage-network-security-group#associate-or-dissociate-a-network-security-group-to-or-from-a-subnet-or-network-interface). After you make this change, the batch service finishes deleting the batch pool after about 20 minutes.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[res-lock]: /azure/azure-resource-manager/management/lock-resources
