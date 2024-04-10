---
title: User can't get cluster resources
description: Troubleshoot issues that are caused when a user can't list a resource within an API group in an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/07/2024
ms.reviewer: rissing chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-cluster-through-api-server
#Customer intent: As an Azure Kubernetes administrator, I want fix RBAC or security group assignments so that users can access their cluster resources.
---
# User can't get cluster resources

This article describes how to fix issues that occur when you can't get the details of a resource in an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/)).

> [!NOTE]
> If you use [Azure Cloud Shell](/azure/cloud-shell/overview) to run shell commands, kubectl is already installed. If you use a local shell and already have [Azure CLI](/cli/azure/install-azure-cli) installed, you can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

If you run kubectl to get the details of an AKS cluster node, you might see the following error message:

```output
$ kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "aaaa11111-11aa-aa11-a1a1-111111aaaaa" cannot list resource "nodes" in API group "" at the cluster scope
```

## Cause 1: Incorrect role and role binding permissions

When you enable role-based access control (RBAC) for your AKS cluster, you control the permissions for a User through Role and RoleBinding (or ClusterRole and ClusterRoleBinding) settings. If a User hasn't defined the correct permissions, the User sees errors when it tries to get the details of a resource in the cluster.

### Solution: Set the correct roles and role bindings

Make sure you set the correct Role and RoleBinding for the User. For detailed examples, see [Use Kubernetes RBAC with Microsoft Entra integration](/azure/aks/azure-ad-rbac).

## Cause 2: Incorrect access assignments within a security group

If AKS manages integration with Microsoft Entra ID, the user might not have the correct assignment for the security group.

### Solution: Have the security group admin assign the correct access level

Make sure the security group's administrator has given your account an Active  or Conditional Access assignment. See [AKS-managed Microsoft Entra integration](/azure/aks/managed-aad). This article has instructions for setting either [Active assignment](/azure/aks/managed-aad#configure-just-in-time-cluster-access-with-azure-ad-and-aks) or [Conditional Access assignment](/azure/aks/managed-aad#use-conditional-access-with-azure-ad-and-aks).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
