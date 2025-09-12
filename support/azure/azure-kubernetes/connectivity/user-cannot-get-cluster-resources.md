---
title: Troubleshoot "Forbidden" error when trying to access AKS cluster resources
description: Troubleshoot "Error from server (Forbidden)" RBAC-related errors that occur when you try to view Kubernetes resources in an AKS cluster.
ms.date: 08/26/2024
ms.reviewer: rissing chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes administrator, I want to fix RBAC-related errors so that users can access their cluster resources.
ms.custom: sap:Connectivity,innovation-engine
---

# Troubleshoot "Forbidden" error when trying to access AKS cluster resources

This article explains how to troubleshoot and resolve "Error from server (Forbidden)" errors that are related to Role-Based Access Control (RBAC) when you try to view Kubernetes resources in an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/))

> [!NOTE]
> If you use [Azure Cloud Shell](/azure/cloud-shell/overview) to run shell commands, kubectl is already installed. If you use a local shell and already have [Azure CLI](/cli/azure/install-azure-cli) installed, you can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When you run `kubectl` commands to view details of a Kubernetes resource type, such as a deployment, pod, or worker node, you receive the following error message:

```output
$ kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "aaaa11111-11aa-aa11-a1a1-111111aaaaa" cannot list resource "nodes" in API group "" at the cluster scope
```

## Cause

This error indicates that you're trying to access Kubernetes resources by using a Microsoft Entra ID account that doesn’t have the required role-based access control (RBAC) permissions.

## Solution

Depending on the RBAC type that's configured for the cluster ([Kubernetes RBAC](/azure/aks/azure-ad-rbac) or [Azure RBAC](/azure/aks/manage-azure-rbac)), different solutions might apply. Run the following command to determine which RBAC type the cluster is using:

Run the following command to determine which RBAC type your AKS cluster is using:

```bash
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query aadProfile.enableAzureRbac
```

Results:

```output
false
```

- If the result is **null** or empty, the cluster doesn't have Azure AD integration enabled. See [Solving permission issues in local Kubernetes RBAC clusters](#solving-permissions-issues-in-local-kubernetes-rbac-clusters).
- If the result is **false**, the cluster uses Kubernetes RBAC. See [Solving permission issues in Kubernetes RBAC-based AKS clusters](#solving-permissions-issues-in-kubernetes-rbac-based-aks-clusters).
- If the result is **true**, the cluster uses Azure RBAC. See [Solving permission issues in Azure RBAC-based AKS clusters](#solving-permissions-issues-in-azure-rbac-based-aks-clusters).

### Solving permissions issues in local Kubernetes RBAC clusters

If your cluster doesn't have Azure AD integration (result was null), it uses cluster admin credentials:

```bash
# Get admin credentials for full access
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --admin

# Verify access
kubectl get nodes
```

**Warning**: Admin credentials provide full cluster access. Use carefully and consider enabling Azure AD integration for better security.

### Solving permissions issues in Kubernetes RBAC-based AKS clusters

If the cluster uses Kubernetes RBAC, permissions for the user account are configured through the creation of RoleBinding or ClusterRoleBinding Kubernetes resources. For more information, see [Kubernetes RBAC documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Additionally, in Microsoft Entra ID integrated clusters, a ClusterRoleBinding resource is automatically created to grant the administrator access to the cluster to members of a pre-designated Microsoft Entra ID group.

To resolve the "Error from server (Forbidden)" error for a specific user, use one of the following methods.

#### Method 1: Create a custom RoleBinding or ClusterRoleBinding resource

You can create a custom RoleBinding or ClusterRoleBinding resource to grant the necessary permissions to the user (or a group of which the user is a member). For detailed steps, see [Use Kubernetes role-based access control with Microsoft Entra ID in Azure Kubernetes Service](/azure/aks/azure-ad-rbac).

#### Method 2: Add the user to the pre-designated Microsoft Entra ID admin group

1. Retrieve the ID of the pre-designated Microsoft Entra ID admin group. To do this, run the following command:

   ```bash
   az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query aadProfile.adminGroupObjectIDs
   ```

   Results:

   ```output
   [
     "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   ]
   ```

2. Add the user to the pre-designated Microsoft Entra ID admin group by using the group ID that you retrieved in the previous step. For more detailed steps, see [Add members or owners of a group](/entra/fundamentals/how-to-manage-groups#add-members-or-owners-of-a-group).

### Solving permissions issues in Azure RBAC-based AKS clusters

If the cluster uses Azure RBAC, permissions for users are configured through the creation of [Azure role assignments](/azure/role-based-access-control/role-assignments).

AKS provides a set of built-in roles that can be used to create role assignments for the Microsoft Entra ID users or groups to give them access to Kubernetes objects in a specific namespace or at cluster scope. For detailed steps to assign built-in roles to users or groups in Azure RBAC-based clusters, see [AKS built-in roles](/azure/aks/manage-azure-rbac#aks-built-in-roles).

Alternatively, you can create your own custom Azure role definitions to provide a more granular management of permissions over specific types of Kubernetes objects and operations. For detailed guidance to create and assign custom roles to users and groups in Azure RBAC-based clusters, see [Create custom roles definitions](/azure/aks/manage-azure-rbac#create-custom-roles-definitions).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]