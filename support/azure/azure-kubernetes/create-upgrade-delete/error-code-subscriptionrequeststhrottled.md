---
title: Troubleshoot SubscriptionRequestsThrottled error code (429) in AKS
description: Learn how to troubleshoot the SubscriptionRequestsThrottled error (429) when you create an AKS cluster. Identify throttled requests and retry safely.
ms.date: 11/16/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubscriptionRequestsThrottled error code (status 429) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot "SubscriptionRequestsThrottled" error code (429) in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the `SubscriptionRequestsThrottled` error code (status 429) that occurs when you create and deploy an Azure Kubernetes Service (AKS) cluster. Identify the throttled request, reduce unnecessary requests, and retry safely.

## Symptoms

When you try to create an AKS cluster, you receive the following "Reconcile standard load balancer failed" error message that shows a **SubCode** value of **SubscriptionRequestsThrottled** and a **Status** value of **429**.

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

The operation encountered request throttling while accessing an Azure resource. Azure Resource Manager (ARM) and individual resource providers enforce separate limits.

In the preceding example, the affected dependency is Microsoft.Network/PublicIPAdresses, and the error identifies the issue as a backend-storage limit.

The applicable limit and scope depend on the service and operation. Review the complete error and available response headers to identify the affected request.

For more information, see [ARM Request Limits](/azure/azure-resource-manager/management/request-limits-and-throttling).

## Troubleshooting

The following steps help you identify the affected request and reduce unnecessary requests before retrying.

### Identify the affected request

Inspect the complete error and available response headers from the failing client. Record the affected operation or dependency, HTTP status, error details, and `Retry-After` value.

If the AKS resource exists, open the cluster in the Azure portal, select **Diagnose and solve problems**, and search for **Azure Resource Request Throttling**. Select the incident time range and compare total requests and throttled requests by operation and user agent. Review other clients sharing the affected scope.

### Reduce requests and retry safely

Reduce or pause nonessential automation that accesses the affected resources. Run discovery and monitoring queries less frequently, and query specific resources instead of repeatedly listing an entire subscription where possible.

Wait at least as long as the actual response's `Retry-After` value before retrying.

Before resubmitting a management operation, check whether the original operation is still running. For an accepted asynchronous operation, follow its returned operation-status URL and polling guidance instead of repeatedly submitting the same change.

Apply the following additional mitigation when appropriate:

- Space out changes and allow the preceding operation to complete before submitting another.
- Consider distributing new deployments across subscriptions or regions after confirming the affected limit's scope.

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)