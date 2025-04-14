---
title: Troubleshoot the SubscriptionRequestsThrottled error code (429)
description: Learn how to troubleshoot the SubscriptionRequestsThrottled error (status 429) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/10/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubscriptionRequestsThrottled error code (status 429) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the SubscriptionRequestsThrottled error code (429)

This article discusses how to identify and resolve the `SubscriptionRequestsThrottled` error (status 429) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following "Reconcile standard load balancer failed" error message that shows a "SubCode" value of **SubscriptionRequestsThrottled** and a "Status" value of **429**:

> Reconcile standard load balancer failed.
>
> Details: outboundReconciler retry failed:
>
> Category: ClientError;
>
> SubCode: SubscriptionRequestsThrottled;
>
> Dependency: Microsoft.Network/PublicIPAddresses;
>
> OrginalError: autorest/azure: Service returned an error. **Status=429**
>
> **Code="SubscriptionRequestsThrottled"**
>
> Message="Number of requests for subscription '*\<subscription-id-guid>*' and operation 'GET/SUBSCRIPTIONS/RESOURCEGROUPS/PROVIDERS/MICROSOFT.NETWORK/PUBLICIPADDRESSES' exceeded the backend storage limit. Please try again after '6' seconds.";
>
> AKSTeam: Networking, Retriable: false.

Request throttling can occur on different Azure components, so the error message might be different based on the kind of resource this issue is occurring on.

## Cause

Azure Resource Manager requests are being throttled. For information about how Azure Resource Manager limits work, and the specific limits per hour, see [Throttling Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling).

## Solution 1: Use another subscription

If you have access to a different subscription, you can simply deploy the cluster to that subscription.

## Solution 2: Modify your access patterns

To resolve this issue, examine your access patterns for the throttled subscription. The following table lists the possible access patterns and corresponding solutions.

| Access pattern | Solution |
| -------------- | -------- |
| Automated scripts constantly scan the subscription | Run the scripts less frequently |
| Many users access the subscription | Have each user use their own subscription |
| Scripts scan every storage account in the subscription | Scope the script to query only the resources that it must have |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
