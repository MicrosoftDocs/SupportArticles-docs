---
title: Troubleshoot Azure Cloud Service (classic) VIP swap failures
description: Troubleshoot cloud service VIP swap failures (VipSwapNotAllowedAsRollingUpgradeIsInProgress exceptions) in Azure Cloud Service (classic).
ms.service: cloud-services
ms.subservice: troubleshoot-deployment-classic
ms.date: 09/26/2022
ms.reviewer: chiragpa, v-leedennis
articleID: 85d6aaad-fed9-48c4-88e2-8d93e8eecedd
---
# Troubleshoot Azure Cloud Service (classic) cloud service VIP swap failures

> [!IMPORTANT]
> Cloud Services (classic) is now deprecated for new customers, and it will be retired on August 31st, 2024 for all customers. New deployments should use the new Azure Resource Manager-based deployment model, Azure Cloud Services (extended support).

This article helps you troubleshoot Azure Cloud Service VIP swap failures (VipSwapNotAllowedAsRollingUpgradeIsInProgress exceptions). VIP swap failures typically occur when deploying a new release of a cloud service in a staging environment. After staged deployment, you'll want to migrate it to a production environment by doing a VIP swap. Swaps are easy to manipulate, and require no downtime.

## Symptom

When a VIP swap failure occurs, you might receive either of the following internal server error messages (HTTP status code 500):

> The server encountered an internal error. Please retry the request.

> There was an error processing your request. Try again in a few moments.

## Cause 1: Service role instances aren't ready

Instances of service roles aren't in a started state (busy, recycling, updating, upgrading, and so on). VIP swap is possible only when all the instances are in a healthy state. You can check the status of the instances from the **Overview** pane on the [Azure portal](https://portal.azure.com).

### Solution: Check for the compute instances that aren't ready

To check or resolve the state of service role instances:

1. Make sure all compute instances are in a ready state and not a non-ready state.

1. If instances are stuck in a non-ready state, fix the problem before doing the swap. For more information, see the following articles:

    - [Troubleshoot roles that fail to start](../extended/role-startup-failure.md)

    - [Common causes of Cloud Service (classic) roles recycling](/azure/cloud-services/cloud-services-troubleshoot-common-issues-which-cause-roles-recycle)

    - [Troubleshoot Cloud Service (classic) deployment problems](/azure/cloud-services/cloud-services-troubleshoot-deployment-problems)

## Cause 2: A deployment update or upgrade prevented the VIP swap

A VIP swap was attempted when another deployment update or upgrade is in progress.

### Solution: Check for deployment update or upgrade events

To find out whether an automatic update is preventing a swap:

1. Select your cloud service from the [Azure portal](https://portal.azure.com).

1. In the **Properties** pane, look at the **Status** value. If it indicates **Ready**, then check **Last operation** to see whether a recent event prevented the swap.

1. Repeat the previous two steps for the production deployment.

    > [!NOTE]
    > If an automatic update is in process, wait for it to finish before doing the swap.

## Cause 3: A reserved IP address is in use

An attempt to add, change, or remove a reserved IP address was made during an update or upgrade. If you reserve a static IP address for your production slot, be sure to reserve your staging slots as well.

### Solution: Check for static IP address usage

Determine whether the service is using a static IP address for both staging and production environments. Make sure the cloud service's configuration blade shows the correct value for the deployment's reserved IP addresses. If the reserved IP addresses are incorrect, update the configuration file with the correct values.

## Cause 4: A service is in self-healing state

Service self-healing is in progress.

### Solution: Contact Azure support

If a VIP swap failed because a self-healing process is underway, contact [Azure support](https://azure.microsoft.com/support/options/) for further assistance.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
