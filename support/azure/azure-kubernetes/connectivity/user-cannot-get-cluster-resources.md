---
title: User gets "Forbidden" message while accessing cluster resources in Azure Kubernetes Service
description: Troubleshoot and resolve "Error from server (Forbidden)" RBAC related errors that occur when you try to view Kubernetes resources in an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/26/2024
ms.reviewer: rissing chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes administrator, I want to fix RBAC related errors so that users can access their cluster resources.
ms.custom: sap:Connectivity
---
# User gets "Forbidden" message while accessing cluster resources

This article explains how to troubleshoot and resolve "Error from server (Forbidden)" errors related to Role-Based Access Control (RBAC) when you try to view Kubernetes resources in an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/)).

> [!NOTE]
> If you use [Azure Cloud Shell](/azure/cloud-shell/overview) to run shell commands, kubectl is already installed. If you use a local shell and already have [Azure CLI](/cli/azure/install-azure-cli) installed, you can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When you run `kubectl` commands to view details of a Kubernetes resource type likes a deployment, pod, or worker node, you might see the following error message:

```output
$ kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "aaaa11111-11aa-aa11-a1a1-111111aaaaa" cannot list resource "nodes" in API group "" at the cluster scope
```

## Cause
This error indicates that you're trying to access Kubernetes resources with a Microsoft Entra ID account that doesn’t have the required role-based access control (RBAC) permissions.

## Solution

Depending on the RBAC type configured for the cluster ([Kubernetes RBAC](/azure/aks/azure-ad-rbac) or [Azure RBAC](/azure/aks/manage-azure-rbac)), different solutions may apply. Run the following command to verify which RBAC type the cluster is using: 

  ```bash
	az aks show -g <CLUSTER_RESOURCE_GROUP> -n <CLUSTER_NAME> --query aadProfile.enableAzureRbac
  ```

- If the result of the command is **false**, the cluster uses Kubernetes RBAC. In this case, see [Solving permission issues in Kubernetes RBAC based AKS clusters](#solving-permission-issues-in-kubernetes-rbac-based-aks-clusters).
- If the result is **true,** the cluster uses Azure RBAC.  see [Solving permission issues in Azure RBAC based AKS clusters](#solving-permission-issues-in-azure-rbac-based-aks-clusters).

### Solving permission issues in Kubernetes RBAC based AKS clusters

If the cluster uses Kubernetes RBAC, permissions for the user account are configured through the creation of RoleBinding or ClusterRoleBinding Kubernetes resources. For more information, see [Kubernetes RBAC documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Furthermore, in Microsoft Entra ID integrated clusters, a ClusterRoleBinding resource is automatically created to grant members of a pre-designated Microsoft Entra ID group the permissions to fully administer the cluster likes administrator access to the cluster.

Use one of the following options to solve the "Error from server (Forbidden)" error for a specific user:

#### Option 1 - Create a custom RoleBinding or ClusterRoleBinding resource
You can create a custom RoleBinding or ClusterRoleBinding resource to grant the user (or a group of which the user is a member) the necessary permissions.  Fore detailed steps, see [Use Kubernetes role-based access control with Microsoft Entra ID in Azure Kubernetes Service](/azure/aks/azure-ad-rbac).

#### Option 2 - Add the user to the pre-designated Microsoft Entra ID admin group
1. Run the following command to retrieve the ID of the pre-designated Microsoft Entra ID admin group:

	```bash
	az aks show -g <CLUSTER_RESOURCE_GROUP> -n <CLUSTER_NAME> --query aadProfile.adminGroupObjectIDs
	```

1. Add the user to the pre-designated Microsoft Entra ID admin group using the group ID retrieved in the previous step. For detailed steps, see [Add members or owners of a group](/entra/fundamentals/how-to-manage-groups#add-members-or-owners-of-a-group).

### Solving permission issues in Azure RBAC based AKS clusters

If the cluster uses Azure RBAC, permissions for users are configured through the creation of [Azure Role Assignments](/azure/role-based-access-control/role-assignments).

AKS provides a set of built-in roles which can be used to create role assignments for the Microsoft Entra ID users or groups access to Kubernetes objects in a specific namespace or at cluster scope. For detailed steps on how to assign built-in roles to users or groups in Azure RBAC based clusters, see [AKS built-in roles](/azure/aks/manage-azure-rbac#aks-built-in-roles).

Alternatively, you can also create your own custom Azure role definitions which allow for a more granular management of permissions over specific types of Kubernetes objects and/or operations. Check [Create custom roles definitions](/azure/aks/manage-azure-rbac#create-custom-roles-definitions) for detailed guidance on how to create and assign custom roles to users/groups in Azure RBAC based clusters.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
