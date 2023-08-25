---
title: Troubleshoot Cloud Service role recycle threshold exceptions
description: Troubleshoot UpdateDeploymentRoleRecycleThresholdReached (role recycle threshold) exceptions in Azure Cloud Service (classic).
ms.service: cloud-services
ms.subservice: troubleshoot-deployment-classic
ms.date: 09/26/2022
ms.reviewer: chiragpa, v-leedennis
---
# Troubleshoot Cloud Service (Classic) role recycle threshold exceptions

> [!IMPORTANT]
> Cloud Services (classic) is now deprecated for new customers, and it will be retired on August 31st, 2024 for all customers. New deployments should use the new Azure Resource Manager-based deployment model, Azure Cloud Services (extended support).

This article helps you troubleshoot UpdateDeploymentRoleRecycleThresholdReached exceptions that occur during the deployment of cloud services.

## Symptom

Your service role instances have continuously recycled during an update or upgrade. The update or upgrade with your configuration settings prevented the role instances from running.

The following message is displayed:

> Your role instances have recycled a number of times during an update or upgrade operation. This indicates that the new version of your service or the configuration settings you provided when configuring the service prevent the role instances from running. Verify your code does not throw unhandled exceptions and that your configuration settings are correct and then start another update or upgrade operation.

## Cause

An UpdateDeploymentRoleRecycleThresholdReached exception means the Cloud Service's role instances have been recycling for a while during an update.

For more information about unhandled role exceptions, see [Common issues that cause Azure Cloud Service (classic) roles to recycle](/azure/cloud-services/cloud-services-troubleshoot-common-issues-which-cause-roles-recycle).

## Solution

To resolve this issue, take one of the following steps:

- [Delete the deployment](/previous-versions/azure/virtual-network/virtual-networks-reserved-public-ip#remove-a-reserved-ip-from-a-running-deployment) slot from which the roles are recycling. Then do a new deployment to an empty slot.

- Create a new cloud service instance, deploy it, and update the service's canonical name (CName).

What if you don't want to lose the IP address that's associated with your existing deployment slot? Then follow these steps to reserve and release the address. For more information, see [Reserved IP addresses for Cloud Services & Virtual Machines](https://azure.microsoft.com/blog/reserved-ip-addresses/).

1. Reserve the IP address of the existing deployment slot.

1. Release the associated reserved IP address.

1. Delete the deployment slot.

1. Make a new deployment to that slot.

1. Associate the required reserved IP address to this cloud service slot.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
