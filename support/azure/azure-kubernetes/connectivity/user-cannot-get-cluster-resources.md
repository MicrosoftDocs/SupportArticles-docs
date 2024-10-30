---
title: User cannot view k8s resources due to "Error from server (Forbidden)"
description: Troubleshoot and resolve "Error from server (Forbidden)" RBAC related errors that occur when you try to view k8s resources in an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/26/2024
ms.reviewer: rissing chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes administrator, I want to fix RBAC related errors so that users can access their cluster resources.
ms.custom: sap:Connectivity
---
# User cannot view k8s resources due to "Error from server (Forbidden)"

This article describes how to troubleshoot and resolve "Error from server (Forbidden)" RBAC related errors that occur when you try to view k8s resources in an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/)).

> [!NOTE]
> If you use [Azure Cloud Shell](/azure/cloud-shell/overview) to run shell commands, kubectl is already installed. If you use a local shell and already have [Azure CLI](/cli/azure/install-azure-cli) installed, you can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When runnning kubectl commands to view the details of a given k8s resource type (e.g. a deployment, pod, or worker node), you might see the following error message:

```output
$ kubectl get nodes
Error from server (Forbidden): nodes is forbidden: User "aaaa11111-11aa-aa11-a1a1-111111aaaaa" cannot list resource "nodes" in API group "" at the cluster scope
```

## Cause
This error indicates that the user is trying to view k8s resources using a Microsoft Entra ID account which does not have the required RBAC permissions to do so. Depending on the type of RBAC used by the cluster ([k8s RBAC](/azure/aks/azure-ad-rbac) Vs [Azure RBAC](/azure/aks/manage-azure-rbac)) different solutions may apply.

## Solution
Run the following command to confirm which RBAC type is used by the cluster:

  ```bash
	az aks show -g <CLUSTER_RESOURCE_GROUP> -n <CLUSTER_NAME> --query aadProfile.enableAzureRbac
  ```

If the result of the previous command is **false** this means the cluster uses k8s RBAC, in which case proceed to step [Solving permission issues in k8s RBAC based AKS clusters](#k8srbac). If, on the other hand, the result of the previous command is **true** this means the cluster uses Azure RBAC, in which case proceed to step [Solving permission issues in Azure RBAC based AKS clusters](#azurerbac).

### Solving permission issues in k8s RBAC based AKS clusters<a name="k8srbac">
If the cluster uses k8s RBAC then permissions for a given user are configured through the creation of RoleBinding/ClusterRoleBinding k8s resources. You can check upstream [Kubernetes RBAC documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) for more details on this.

Furthermore, in Microsoft Entra ID integrated clusters a clusterrolebinding resource is automatically created granting members of a predesignated Microsoft Entra ID group the permissions to fully administer the cluster i.e. administrator access to the cluster.

Use one of the following options to solve the "Error from server (Forbidden)" error for a specific user:

#### Option 1 - Create a custom rolebinding/clusterrolebinding resource
You can create a custom rolebinding/clusterrolebinding resource granting the user (or a group of which the user is a member) the necessary permissions - check [Use Kubernetes role-based access control with Microsoft Entra ID in Azure Kubernetes Service](/azure/aks/azure-ad-rbac) for detailed guidance on how to create custom rolebindings/clusterrolebindings for specific users or groups in AKS.

#### Option 2 - Add the user to the predesignated Microsoft Entra ID admin group
Run the following command to retrieve the ID of the predesignated Microsoft Entra ID admin group:

  ```bash
	az aks show -g <CLUSTER_RESOURCE_GROUP> -n <CLUSTER_NAME> --query aadProfile.adminGroupObjectIDs
  ```

Add the user to the predesignated Microsoft Entra ID admin group - check [Add members or owners of a group](/entra/fundamentals/how-to-manage-groups#add-members-or-owners-of-a-group) for detailed guidance on how to add users to groups in Microsoft Entra ID.

### Solving permission issues in Azure RBAC based AKS clusters<a name="azurerbac">

If the cluster uses Azure RBAC then permissions for a given user are configured through the creation of [Azure Role Assignments](/azure/role-based-access-control/role-assignments).

AKS provides a set of built-in roles which can be used to create role assignments for giving Microsoft Entra ID users/groups access to k8s objects in a specific namespace or at cluster scope. Check [AKS built-in roles](/azure/aks/manage-azure-rbac#aks-built-in-roles) for detailed guidance on how to assign built-in roles to users/groups in Azure RBAC based clusters.

Alternatively you can also create your own custom Azure role definitions which allows for a more granular management of permissions over specific types of k8s objects and/or operations. Check [Create custom roles definitions](/azure/aks/manage-azure-rbac#create-custom-roles-definitions) for detailed guidance on how to create and assign custom roles to users/groups in Azure RBAC based clusters.



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
