---
title: Troubleshoot Throttled (Status 429) error code in AKS
description: Learn how to resolve the Throttled error (status 429) when you create or deploy an Azure Kubernetes Service (AKS) cluster. Follow the steps to fix it.
ms.date: 11/11/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ai-usage: ai-assisted
ms.reviewer: jovieir, chiragpa, v-weizhu, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the Throttled error code (status 429) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot "Throttled (Status 429)" error code in Azure Kubernetes Service

## Summary

This article helps you identify and resolve the "Throttled (Status 429)" error that occurs when you create or deploy an Azure Kubernetes Service (AKS) cluster, so that your cluster operations can complete successfully.

## Symptoms

When you try to create an AKS cluster, you receive the following "The PutManagedClusterHandler.PUT request limit has been exceeded" error message that shows a **SubCode** value of **Throttled** and a **Status** value of **429**.

> Category: ClientError;
>
> SubCode: Throttled;
>
> OrginalError: autorest/azure: Service returned an error. **Status=429**
>
> **Code="Throttled"**
>
> Message="> The PutManagedClusterHandler.PUT request limit has been exceeded for SubID='*\<subscription-id-guid>*', please retry again in X seconds. For more information, please visit aka.ms/aks/throttling";

Request throttling can occur on various Azure components, so the error message might be different depending on the type of resource where this issue occurs.

Resource provider throttling is independent of Azure Resource Manager (ARM) throttling and is tailored to the operations of a specific resource provider. In this scenario, AKS resource provider throttling is specific to the AKS resource provider and applies only to operations related to AKS resources.

## Cause

AKS requests are throttled. For information about how AKS limits work and the specific limits per hour, see [Throttling limits on AKS resource provider APIs](/azure/aks/quotas-skus-regions#throttling-limits-on-aks-resource-provider-apis).

## Solution

To resolve this issue, examine and modify your access pattern of the throttled subscription. The following table lists the possible access patterns and corresponding solutions.

| Access pattern | Solution |
| -------------- | -------- |
| Automated scripts constantly run LIST operations against managedCluster resources. | Run the scripts less frequently. |
| Users attempt to deploy multiple AKS clusters in a short period of time. | Space out deployments or use different subscriptions.|
| Users attempt to modify the same AKS cluster multiple times consecutively. | Space out operations. Ensure successful completion before initiating another one.|
| Users attempt to add, modify, or delete one or more agentPools on the same AKS cluster. | Space out operations. Ensure successful completion before initiating another one. |

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)