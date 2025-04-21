---
title: Troubleshoot OperationNotAllowed or PublicIPCountLimitReached
description: Introduces how to troubleshoot the OperationNotAllowed or PublicIPCountLimitReached quota error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/03/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, dorinalecu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OperationNotAllowed or PublicIPCountLimitReached quota error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the OperationNotAllowed or PublicIPCountLimitReached error

This article describes how to identify and resolve the `OperationNotAllowed` or `PublicIPCountLimitReached` quota error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> **Code="OperationNotAllowed"**
>
> Message="**Operation could not be completed as it results in exceeding approved standardEv3Family Cores quota.**
>
> Additional details - Deployment Model: Resource Manager,
>
> Location: uksouth,
>
> Current Limit: 200,
>
> Current Usage: 200,
>
> Additional Required: 8,
>
> (Minimum) New Limit Required: 208.
>
> Submit a request for Quota increase at `https://aka.ms/ProdportalCRP/#blade/Microsoft_Azure_Capacity/UsageAndQuota.ReactView/Parameters/<parameter-id>` by specifying parameters listed in the 'Details' section for deployment to succeed. Please read more about quota limits at `https://learn.microsoft.com/azure/azure-supportability/per-vm-quota-requests`"

Or, you receive the following error message:

> Reconcile standard load balancer failed.
>
> Details: outboundReconciler retry failed: Category: ClientError; **SubCode: PublicIPCountLimitReached**;
>
> **Dependency: Microsoft.Network/PublicIPAddresses;**
>
> OrginalError: Code="PublicIPCountLimitReached"
>
> Message="Cannot create more than 1000 public IP addresses for this subscription in this region." Details=[]; AKSTeam: Networking, Retriable: false.

## Cause

You've exhausted the quota for a resource in an SKU's region.

## Solution 1: Request a quota increase for your SKU

Typically, these error messages provide a link to create a support ticket to increase the quota for that SKU. In most cases, these requests are approved automatically, and the increased quota will be available in a short time.

If you don't have the link to request a quota increase, make the request in the Azure portal, as follows:

1. In the [Azure portal](https://portal.azure.com), search for and select **Quotas**.

1. Select **Microsoft.Compute** to view the list of quota records.

1. Use the **Location** list to filter for records from only your region.

1. In the specific record that's out-of-quota, select the pencil icon at the end of the record row.

1. In the **Request quota increase** pane, complete the **New limit** field, and then select **Submit**.

After your quota increase request is approved, you can retry the cluster creation operation.

## Solution 2: Reprovision the cluster in another region or SKU

Alternatively, you can reprovision the cluster in a different region or SKU that has enough capacity for your cluster.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
