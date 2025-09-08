---
title: Troubleshoot TooManyRequestsReceived or SubscriptionRequestsThrottled Error Code
description: Learn how to resolve the TooManyRequestsReceived or SubscriptionRequestsThrottled error when you try to delete an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/03/2025
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, dorinalecu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the TooManyRequestsReceived or SubscriptionRequestsThrottled error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot TooManyRequestsReceived or SubscriptionRequestsThrottled error code

This article discusses how to identify and resolve the `TooManyRequestsReceived` or `SubscriptionRequestsThrottled` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive the following error message:

> internalErrorCode: TooManyRequestsReceived
>
> StatusCode: 429
>
> {
>
> message: "Number of read requests for subscription '.....''' exceeded the limit of '....' for time interval 'XX:XX:XX'. Please try again after '.....' seconds."
>
> }

## Cause

Every subscription-level and tenant-level operation is subject to throttling limits. These limits apply to each instance of Azure Resource Manager. When you reach the limit, you receive an HTTP response that indicates status code 429: "Too many requests."

## Solution

The HTTP response includes a `Retry-After` value. This specifies the number of seconds that your application should wait (or sleep) before it sends the next request. If you send a request before the retry value has elapsed, your request isn't processed, and a new retry value is returned. For more information about throttling limits, see [Throttling Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
