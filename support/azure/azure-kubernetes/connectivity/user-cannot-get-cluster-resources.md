---
title: Troubleshoot Forbidden error when trying to access AKS cluster resources
description: Fix "Error from server (Forbidden)" RBAC errors in AKS so users can access Kubernetes resources again. Follow these steps to restore access.
ms.date: 11/06/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing chiragpa, v-leedennis, addobres, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes administrator, I want to fix RBAC-related errors so that users can access their cluster resources.
ms.custom: sap:Connectivity,innovation-engine
ai-usage: ai-assisted
---

# Troubleshoot Forbidden errors when you access Azure Kubernetes Service cluster resources

This article explains how to troubleshoot and resolve "Error from server (Forbidden)" errors related to role-based access control (RBAC) when you view Kubernetes resources in an Azure Kubernetes Service (AKS) cluster. Follow these steps to restore user access to cluster resources.

## Prerequisites

The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/)).

> [!NOTE]
> If you use [Azure Cloud Shell](/azure/cloud-shell/overview) to run shell commands, kubectl is already installed. If you use a local shell and already have [Azure CLI](/cli/azure/install-azure-cli) installed, you can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When you run `kubectl` commands to view details of a Kubernetes resource type, such as a deployment, pod, or worker node, you receive the following error message.

```output
$ kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "aaaa11111-11aa-aa11-a1a1-111111aaaaa" cannot list resource "nodes" in API group "" at the cluster scope
```

## Cause

This error indicates that you're trying to access Kubernetes resources by using a Microsoft Entra ID account that doesn't have the required RBAC permissions.

## Solution

Depending on the RBAC type that you configure for the cluster ([Kubernetes RBAC](/azure/aks/azure-ad-rbac) or [Azure RBAC](/azure/aks/manage-azure-rbac)), different solutions might apply. 

Run the following command to determine which RBAC type your AKS cluster is using.

```bash
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query aadProfile.enableAzureRbac
```

The following results are expected.

```output
false
```

- If the result is **null** or empty, the cluster doesn't have Microsoft Entra ID integration enabled. For more information, see [Solve permissions issues in local Kubernetes RBAC clusters](#solve-permissions-issues-in-local-kubernetes-rbac-clusters).
- If the result is **false**, the cluster uses Kubernetes RBAC. For more information, see [Solve permissions issues in Kubernetes RBAC-based AKS clusters](#solve-permissions-issues-in-kubernetes-rbac-based-aks-clusters).
- If the result is **true**, the cluster uses Azure RBAC. For more information, see [Solve permissions issues in Azure RBAC-based AKS clusters](#solve-permissions-issues-in-azure-rbac-based-aks-clusters).

### Solve permissions issues in local Kubernetes RBAC clusters

If your cluster doesn't have Microsoft Entra ID integration (result was null), it uses cluster admin credentials. The following command retrieves the admin credentials for the cluster, so you can access it fully.

```bash
# Get admin credentials for full access
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --admin

# Verify access
kubectl get nodes
``` 

> [!WARNING]
> Admin credentials provide full cluster access. Use them carefully and consider enabling Microsoft Entra ID integration for better security.

### Solve permissions issues in Kubernetes RBAC-based AKS clusters

If the cluster uses Kubernetes RBAC, configure permissions for the user account by creating **RoleBinding** or **ClusterRoleBinding** Kubernetes resources. For more information, see [Kubernetes RBAC documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Also, in Microsoft Entra ID integrated clusters, a **ClusterRoleBinding** resource is automatically created to grant the administrator access to the cluster to members of a pre-designated Microsoft Entra ID group.

To resolve the "Error from server (Forbidden)" error for a specific user, use one of the following methods.

#### Method 1: Create a custom RoleBinding or ClusterRoleBinding resource

Create a custom **RoleBinding** or **ClusterRoleBinding** resource to grant the necessary permissions to the user (or a group that includes the user). For detailed steps, see [Use Kubernetes role-based access control with Microsoft Entra ID in Azure Kubernetes Service](/azure/aks/azure-ad-rbac).

#### Method 2: Add the user to the pre-designated Microsoft Entra ID admin group

Follow these steps:

1. Retrieve the ID of the pre-designated Microsoft Entra ID admin group. To do this, run the following command.

   ```bash
   az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query aadProfile.adminGroupObjectIDs
   ```

   Results:

   ```output
   [
     "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   ]
   ```

1. Add the user to the pre-designated Microsoft Entra ID admin group by using the group ID that you retrieved in the previous step. For more detailed steps, see [Add members or owners of a group](/entra/fundamentals/how-to-manage-groups#add-members-or-owners-of-a-group).

### Solve permissions issues in Azure RBAC-based AKS clusters

If the cluster uses Azure RBAC, you configure permissions for users by creating [Azure role assignments](/azure/role-based-access-control/role-assignments).

AKS provides a set of built-in roles that you can use to create role assignments for the Microsoft Entra ID users or groups to give them access to Kubernetes objects in a specific namespace or at cluster scope. For detailed steps to assign built-in roles to users or groups in Azure RBAC-based clusters, see [AKS built-in roles](/azure/aks/manage-azure-rbac#aks-built-in-roles).

Alternatively, you can create your own custom Azure role definitions to provide a more granular management of permissions over specific types of Kubernetes objects and operations. For detailed guidance to create and assign custom roles to users and groups in Azure RBAC-based clusters, see [Create custom roles definitions](/azure/aks/manage-azure-rbac#create-custom-roles-definitions).