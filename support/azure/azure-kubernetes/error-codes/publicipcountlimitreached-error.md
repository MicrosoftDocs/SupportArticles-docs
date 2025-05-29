---
title: Troubleshoot PublicIPCountLimitReached Error Code
description: Learn how to resolve the PublicIPCountLimitReached error when you try to upgrade an Azure Kubernetes Service cluster.
ms.date: 10/06/2024
editor: v-jsitser
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a PublicIPCountLimitReached error so that I can upgrade the cluster successfully.
---
# Troubleshoot the PublicIPCountLimitReached error code

This article explains how to identify and resolve the "PublicIPCountLimitReached" error. This error occurs when you try to create, update, or upgrade an Azure Kubernetes Service (AKS) cluster. This error can also be caused by any other action that triggers the creation of a Public IP address, such as deploying a Kubernetes Service-type Public Load Balancer.

## Symptoms

An AKS cluster creation, update, upgrade, or other operation that triggers the creation of a Public IP address, such as deploying a Kubernetes Service that has a Public Load Balancer, fails and returns a "PublicIPCountLimitReached" error message.

## Cause

This error occurs if you've reached the maximum number of public IP addresses that are allowed for your subscription. The limit varies based on your subscription type. For more information about public IP address limits, refer to [this detailed guide](/azure/azure-resource-manager/management/azure-subscription-service-limits#publicip-address).

## Solution

To increase the public IP limit or quota for your subscription, follow these steps:

1. Navigate to the [Azure portal](https://portal.azure.com/#view/Microsoft_Azure_Billing/SubscriptionsBladeV2), and select the subscriptions for which you're performing the operation.
2. In the **Settings** section, select **Usage + quotas**. Set the **Provider** to **Networking**, and optionally filter by the region of your AKS cluster.
3. Locate the **Public IP Addresses** record. On the same line, select the **Create a new support request** button. 

   :::image type="content" source="media/publicipcountlimitreached-error/submit-quotas-request.png" alt-text="Screenshot that shows how to create a support request for quota increase." lightbox="media/publicipcountlimitreached-error/submit-quotas-request.png":::

4. On the **New support request** page, specify the new limit that you require, and then follow the instructions to create the support request.

   :::image type="content" source="media/publicipcountlimitreached-error/new-limit-public-ip.png" alt-text="Screenshot that how to specify the new limit for public IP addresses." lightbox="media/publicipcountlimitreached-error/new-limit-public-ip.png":::

After the quota change takes effect, retry the operation that initially triggered the "PublicIPCountLimitReached" error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
