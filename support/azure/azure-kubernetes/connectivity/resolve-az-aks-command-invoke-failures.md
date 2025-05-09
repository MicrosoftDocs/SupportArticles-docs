---
title: Resolve az aks command invoke failures
description: Resolve az aks command invoke failures in Azure CLI when you try to access a private Azure Kubernetes Service (AKS) cluster.
ms.date: 05/09/2025
ms.reviewer: chiragpa, andbar, haitch, momajed, albarqaw， v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity, devx-track-azurecli
#Customer intent: As an Azure Kubernetes user, I want to resolve az aks command invoke failures in Azure CLI so that I can successfully connect to my private Azure Kubernetes Service (AKS) cluster.
---
# Resolve "az aks command invoke" failures

This article describes how to resolve [az aks command invoke](/cli/azure/aks/command#az-aks-command-invoke) failures in Microsoft Azure CLI so that you can successfully connect to any Azure Kubernetes Service (AKS) cluster, especially to a [private AKS cluster](/azure/aks/command-invoke).

Other connection methods need to use extra configuration components, as shown in the following table.

| Connection methods | Extra configuration component                                                                                              |
|--------------------|----------------------------------------------------------------------------------------------------------------------------|
| Virtual network    | Virtual private network (VPN)                                                                                              |
| Peered network     | [Azure ExpressRoute](/azure/expressroute/expressroute-introduction)                                                        |
| Private endpoint   | [Jumpbox](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/connect-to-environments-privately) |

The `az aks command invoke` Azure CLI command is an alternative way of connecting to a cluster that doesn't require extra configuration components.

When you run the `az aks command invoke` command, Azure CLI automatically creates a `command-<ID>` pod in the `aks-command` namespace to access the AKS cluster and retrieve the required information.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

The following table lists common `az aks command invoke` error messages. Each error message has a link to the section that describes why the error is occurring, and how to fix it.

| Error message | Link |
|--|--|
| Operation returned an invalid status 'Not Found' | [Cause 1: The pod can't be created because of node or resource constraints](#cause-1-the-pod-cant-be-created-because-of-node-or-resource-constraints) |
| Failed to run command in managed cluster due to kubernetes failure. details: admission webhook "validation.gatekeeper.sh" denied the request: \<policy-specific-message> | [Cause 2: Azure Policy doesn't allow the pod creation](#cause-2-azure-policy-doesnt-allow-the-pod-creation) |
| Error from server (Forbidden): namespaces is forbidden: User "\<ID>" cannot list resource "\<resource>" in API group "" at the cluster scope | [Cause 3: Required roles aren't granted](#cause-3-required-roles-arent-granted) |
| Failed to connect to MSI. Please make sure MSI is configured correctly.<br/><br/>Get Token request returned: Response [400]; | [Cause 4: There's a Cloud Shell issue](#cause-4-theres-a-cloud-shell-issue) |

## Cause 1: The pod can't be created because of node or resource constraints

The operation returns a `Not Found` status because the `command-<ID>` pod can't reach a successful state, such as `Running`. (In many cases, the pod stays in the `Pending` state.) In this case, the nodes aren't able to schedule the pod. This scenario can have different causes, such as the following causes:

- Resource constraints
- Nodes that have a `NotReady` or `SchedulingDisabled` state
- Nodes that have taints that the pod can't tolerate 
- Other causes
  
Here are sample error messages for `KubernetesPerformanceError` or `KubernetesOperationError`:

```output
(KubernetesPerformanceError) Failed to run command due to cluster perf issue, container command-357ebsdfsd342869 in aks-command namespace did not start within 30s on your cluster, retry may helps. If issue persist, you may need to tune your cluster with better performance (larger node/paid tier).
Code: KubernetesPerformanceError
Message: Failed to run command due to cluster perf issue, container command-357ebc50d40c47a4a247ab6e067d2869 in aks-command namespace did not start within 30s on your cluster, retry may helps. If issue persist, you may need to tune your cluster with better performance (larger node/paid tier).
```

#### Solution 1: Change the configuration so that you can schedule and run the pod

Make sure that the `command-<ID>` pod can be scheduled and run by adjusting the configuration. For example:

- Increase the node pool size and make sure it has no pod secluding constraints like taints so that the `command-<ID>` pod can be deployed.
- Adjust resource requests and limits in your pod specifications.

## Cause 2: Azure Policy doesn't allow the pod creation

If you have specific Azure policies, the `az aks command invoke` command can fail because of a disallowed configuration in the `command-<ID>` pod. For example, you might have an Azure policy that requires a read-only root file system or other specific configuration.

#### Solution 2: Exempt the namespace for policies that prohibit pod creation

We recommend that you exempt the `aks-command` namespace for the associated Azure policies that don't allow the pod creation. For more information about exemption, see [Understand scope in Azure Policy](/azure/governance/policy/concepts/scope#:~:text=Exemption%20%2D%20A%20resource,Exemption%20definition.)

To exempt an Azure Policy:

1. In the [Azure portal](https://portal.azure.com), search for and select **Policy**.

1. In the **Policy** navigation pane, locate the **Authoring** section, and then select **Assignments**.

1. In the table of assignments, find the row that contains the **Assignment name** that you want to change, and then select the name of the assignment.

1. In the policy assignment page for that assignment, select **Edit assignment**.

1. Select the **Parameters** tab.

1. Clear the **Only show parameters that need input or review** option.

1. In the **Namespace exclusions** box, add the *aks-command* namespace to the list of namespaces to be excluded.

Alternatively, if the policy isn't a built-in policy, you can check the configuration of the `command-<ID>` pod, and adjust the policy as necessary. To explore the pod's YAML configuration, run the following command:

```bash
kubectl get pods command-<ID> --namespace aks-command --output yaml
```

You can exempt the `aks-command` namespace from restrictive policies by running the following command:

```bash
az policy exemption create --name ExemptAksCommand --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.ContainerService/managedClusters/{aks-cluster} --policyAssignment /subscriptions/{subscription-id}/providers/Microsoft.Authorization/policyAssignments/{policy-assignment-id}
```

## Cause 3: Required roles aren't granted

To use the `az aks command invoke` command, you must have access to the following roles on the cluster:

- `Microsoft.ContainerService/managedClusters/runCommand/action`
- `Microsoft.ContainerService/managedClusters/commandResults/read`

If you don't have these roles, the `az aks command invoke` command can't retrieve the required information.

#### Solution 3: Add the required roles

To resolve this issue, follow these steps:

1. Add the `Microsoft.ContainerService/managedClusters/runCommand/action` and `Microsoft.ContainerService/managedClusters/commandResults/read` roles.
2. Assign the necessary roles to the user:

    ```bash
    az role assignment create --assignee {user-principal-name} --role "Azure Kubernetes Service Cluster User Role" --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.ContainerService/managedClusters/{aks-cluster}
    ```

## Cause 4: There's a Cloud Shell issue

The `az aks command invoke` command isn't processed as expected when it's run directly in the [Azure Cloud Shell](/azure/cloud-shell/overview) environment. This is a known issue in Cloud Shell.

#### Solution 4a: Run the az login command first

In Cloud Shell, run the [az login](/cli/azure/reference-index#az-login) command before you run the `az aks command invoke` command. For example:

```bash
az login
az aks command invoke --resource-group {resource-group} --name {aks-cluster} --command "kubectl get pods"
```

#### Solution 4b: Run the command on a local computer or a virtual machine

Run the `az aks command invoke` command on a local computer or any virtual machine (VM) that has Azure CLI installed.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
