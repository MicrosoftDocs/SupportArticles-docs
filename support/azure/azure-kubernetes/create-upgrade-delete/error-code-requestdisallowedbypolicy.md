---
title: RequestDisallowedByPolicy Error When Deploying an AKS Cluster
description: Learn how to fix the RequestDisallowedByPolicy error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/13/2025
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, albarqaw, jacobbaek, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the RequestDisallowedByPolicy error so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# RequestDisallowedByPolicy error when deploying an AKS cluster

This article discusses how to identify and resolve the `RequestDisallowedByPolicy` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> Resource request failed due to RequestDisallowedByPolicy. Please see <https://aka.ms/aks-requestdisallowedbypolicy> for more details. The detailed error message: Code="RequestDisallowedByPolicy"
>
> **Message="Resource 'MC_clustername' was disallowed by policy.**

## Cause

For security or compliance, your subscription administrators might assign policies that limit how resources are deployed. For example, your subscription might have a policy that prevents you from creating public IP addresses, network security groups, user-defined routes, or route tables. The error message includes the specific reason why the cluster creation was blocked. 

> [!NOTE]
> Only you can manage the policies in your environment. Microsoft can't disable or bypass those policies.

## Solution

To fix this issue, follow these steps:

1. Find the policy that blocks the action. These policies are listed in the error message.   
   The name of a policy assignment or definition is the last segment of the `id` string that's shown in the error message.
   ```
   # Example
   Code: RequestDisallowedByPolicy
   Message: Resource 'resourcegroup' was disallowed by policy. Policy identifiers: '[{"policyAssignment":{"name":"Not allowed resource types","id":"/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/policyAssignments/00000000000000000000000"},"policyDefinition":{"name":"Not allowed resource types","id":"/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/policyDefinitions/not-allowed-resourcetypes","version":"1.0.0"}}]'.
   ```

1. If possible, update your deployment to comply with the policy restrictions, and then retry the deployment. Alternatively, if you have permission to update policy, [add an exemption](/azure/governance/policy/tutorials/disallowed-resources#create-an-exemption) to the policy.

To get details about the policy that blocked your cluster deployment, see [RequestDisallowedByPolicy error with Azure resource policy](/azure/azure-resource-manager/troubleshooting/error-policy-requestdisallowedbypolicy).

> [!NOTE]
> After you fix the policy that blocks the AKS cluster creation, run the `az aks update -g MyResourceGroup -n MyManagedCluster` command to change the cluster from a failed state to a successful state. This change reconciles the cluster and retries the last failed operation. For more information about clusters in a failed state, see [Troubleshoot Azure Kubernetes Service clusters or nodes in a failed state](../availability-performance/cluster-node-virtual-machine-failed-state.md).

## More information

[General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
