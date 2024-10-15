---
title: Troubleshoot PublicIPCountLimitReached error code
description: Learn how to troubleshoot the PublicIPCountLimitReached error when you try to upgrade an Azure Kubernetes Service cluster.
ms.date: 10/06/2024
editor: v-jsitser
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a PublicIPCountLimitReached error so that I can upgrade the cluster successfully.
---

# Troubleshoot the "PublicIPCountLimitReached" error code

This article explains how to identify and resolve the "PublicIPCountLimitReached" error, which occurs when attempting to create, update, or upgrade an Azure Kubernetes Service (AKS) cluster. This error can also appear as a result of any other action that triggers the creation of a Public IP address, such as deploying a Kubernetes Service type Public Load Balancer.

## Symptoms

AKS cluster creation, update, upgrade, or any operation that triggers the creation of a Public IP address, such as deploying a Kubernetes Service with a Public Load Balancer, may fail with the error message "PublicIPCountLimitReached".

## Cause

This error occurs when you've reached the maximum number of public IP addresses allowed for your subscription. The limit varies based on your subscription type. For more information on public IP address limits, refer to [this detailed guide](/azure/azure-resource-manager/management/azure-subscription-service-limits#publicip-address).

## Solution

To increase the public IP limit or quota for your subscription, follow these steps:

1. Navigate to the [Azure portal](https://portal.azure.com/#view/Microsoft_Azure_Billing/SubscriptionsBladeV2), select your subscriptions that you're performing the operation.
2. In the **Settings** section, select **Usage + quotas**. Set the **Provider** to **Networking**, and optionally filter by the region of your AKS cluster.
3. Locate the **Public IP Addresses** record. In the same line, select the **Create a new support request** button. You'll be redirected to a page where you can specify the new limit you require and provide additional details such as contact information.

This process will create a support request to increase your public IP address quota for the specified region. See the screenshots below for visual guidance.

![public-ip-limit](https://github.com/user-attachments/assets/85e93fa0-e151-4410-99b3-13410b4049b1)

![specify-new-limit](https://github.com/user-attachments/assets/de006bb5-e5c3-4c7e-91db-3a89b2991450)

Once the quota change takes effect, retry the operation that initially triggered the "PublicIPCountLimitReached" error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
