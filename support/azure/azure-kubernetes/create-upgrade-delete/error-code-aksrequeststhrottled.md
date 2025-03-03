---
title: Troubleshoot the Throttled error code (429)
description: Learn how to troubleshoot the Throttled error (status 429) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 2/7/2025
editor: jovieir
ms.reviewer: jovieir
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the Throttled  error code (status 429) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the Throttled error code (429)

This article discusses how to identify and resolve the `Throttled` error (status 429) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following "The PutManagedClusterHandler.PUT request limit has been exceeded" error message that shows a "SubCode" value of **Throttled** and a "Status" value of **429**:

> Category: ClientError;
>
> SubCode: Throttled;
>
> OrginalError: autorest/azure: Service returned an error. **Status=429**
>
> **Code="Throttled"**
>
> Message="> The PutManagedClusterHandler.PUT request limit has been exceeded for SubID='*\<subscription-id-guid>*', please retry again in X seconds. For more information, please visit aka.ms/aks/throttling";

Request throttling can occur on different Azure components, so the error message might be different based on the kind of resource this issue is occurring on.

Resource provider throttling is independent of ARM throttling and is tailored to the operations of a specific resource provider. In this scenario, AKS RP throttling is specific to the Azure kubernetes Service (AKS) resource provider, and applies only to operations related to AKS resources. 

## Cause

Azure Kubernetes Service requests are being throttled. For information about how AKS limits work, and the specific limits per hour, see [Throttling limits on AKS resource provider APIs](/azure/aks/quotas-skus-regions#throttling-limits-on-aks-resource-provider-apis).

## Solution: Modify your access patterns

To resolve this issue, examine your access patterns for the throttled subscription. The following table lists the possible access patterns and corresponding solutions.

| Access pattern | Solution |
| -------------- | -------- |
| Automated scripts constantly run LIST operations against managedCluster resources | Run the scripts less frequently |
| Users attempt to deploy multiple AKS clusters in a short period of time | Space out deployments or use different subscriptions |
| Users attempt to modify the same AKS cluster multiple times consecutively | Space out operations. Ensure successful completion before initiating another one |
| Users attempt to add, modify, or delete one or several agentPools on the same AKS cluster | Space out operations. Ensure successful completion before initiating another one |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
