---
title: Troubleshoot SubscriptionPolicyCountExceeded exceptions in Azure
description: Troubleshoot common errors related to SubscriptionPolicyCountExceeded exceptions when you deploy Azure Cloud Services (classic).
ms.service: cloud-services
ms.subservice: troubleshoot-deployment-classic
ms.date: 09/26/2022
ms.reviewer: chiragpa, v-leedennis
articleID: 1eb5e3dd-a286-45d4-b653-7f87972b103e
---
# Troubleshoot Cloud Service (classic) SubscriptionPolicyCountExceeded exceptions

> [!IMPORTANT]
> Cloud Services (classic) is now deprecated for new customers, and it will be retired on August 31st, 2024 for all customers. New deployments should use the new Azure Resource Manager-based deployment model, Azure Cloud Services (extended support).

This article helps you troubleshoot common errors that are related to SubscriptionPolicyCountExceeded exceptions.

## Summary

Microsoft Azure Limits and Microsoft Azure Quotas are configured with each Azure compute subscription and Azure Classic Compute. Exceeding these limits and quotas causes subscription policy count failures.

For more information, see [Azure subscription limits and quotas - Azure Resource Manager](/azure/azure-resource-manager/management/azure-subscription-service-limits#managing-limits).

## Symptom

The Azure Cloud Service subscription failed to deploy. Either of the following error messages are displayed:

> "code":"DomainNameOperationFailed",
"message":"Unable to create domain name 'CloudServiceName': 'The subscription policy limit for resource type 'hosted service count' was exceeded. The limit for resource type 'hosted service count' is 20 per subscription, the current count is 20, and the requested increment is 1."

> "code":"OperationFailed",
"message":"The operation 'operation-id' failed: The subscription policy limit for resource type 'cores count' was exceeded. The limit for resource type 'cores count' is 350 per subscription, the current count is 345, and the requested increment is 10."

## Cause 1: Too many hosted cloud services

If you see the following error message:

> The subscription policy limit for resource type 'hosted service count' was exceeded.

Then you attempted to exceed the maximum number of cloud service resources allowed. An Azure subscription can have a maximum of 20 cloud services per subscription (default limit).

## Cause 2: Too many classic cores used

If you see the following error message:

> The subscription policy limit for resource type 'cores count' was exceeded.

Then you attempted to exceed the limit imposed on the maximum number of classic cores (vCPUs) allowed.

## Solution

1. Go to the [Azure portal](https://portal.azure.com), then search for and select **Subscriptions**.

1. Select the subscription associated with your cloud service.

1. Follow the instructions in [Check resource usage against limits](/azure/networking/check-usage-against-limits) to see what resources you've used and what the subscription limits are.

If the usage quota is at 100% or about to exceed the limit, request a quota increase using the following steps:

1. Select **Request Quota Increase** from the **Subscription Usage + Quotas** page.

1. Choose **Cloud Service** from under **Quota Type**.

1. Create a request to increase the quota values.

> [!NOTE]
> All resources have a maximum limit listed in the [Azure subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). If your current limit is already at the maximum number, the limit can't be increased.

For more information, see [Understanding Azure limits and increases](https://azure.microsoft.com/blog/azure-limits-quotas-increase-requests/).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
