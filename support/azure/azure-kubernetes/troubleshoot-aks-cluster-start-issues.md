---
title: Troubleshoot Azure Kubernetes Service cluster start issues
description: Learn about basic troubleshooting methods to use when you can't start an Azure Kubernetes Service (AKS) cluster.
ms.date: 01/23/2024
editor: v-jovieir
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir
ms.service: azure-kubernetes-service
ms.custom: devx-track-azurecli
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting measures to resolve issues that occur when I try to start an Azure Kubernetes Service (AKS) cluster.
---
# Basic troubleshooting of AKS cluster start issues

This article outlines the basic troubleshooting methods to use if you can't start a Microsoft Azure Kubernetes Service (AKS) cluster successfully.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or a later version).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## View errors from Azure CLI

When you start clusters by using Azure CLI, errors are recorded as output if the operation fails. Here's how a command, user input, and operation output might appear in a Bash console:

> `$ az aks start --resource-group myResourceGroup --name MyManagedCluster`
> 
> (VMExtensionProvisioningError) Unable to establish outbound connection from agents, please see `https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/error-code-outboundconnfailvmextensionerror` and `https://aka.ms/aks-required-ports-and-addresses` for more information.  
> Details: instance 3 has extension error details : {vmssCSE error messages : {vmssCSE exit status=50, output=AGE_SHA=sha-16fd35

These errors often contain detailed descriptions of what went wrong in the cluster start operation, and they provide links to articles that contain more details. Additionally, you can use our troubleshooting articles as a reference based on the error that an Azure CLI operation produces.

## View error details in the Azure portal

To view the details about errors in the [Azure portal](https://portal.azure.com), examine the [Azure activity log](/azure/azure-monitor/essentials/activity-log). To find the list of activity logs in the Azure portal, search on **Activity log**. Or, select **Notifications** (the bell icon), and then select **More events in the activity log**.

The list of logs on the **Activity log** page contains a line entry in which the **Operation name** column value is named **Start Managed Cluster**. The corresponding **Event initiated by** column value is set to the name of your work or school account. If the operation is successful, the **Status** column value shows **Accepted**. 

:::image type="content" source="media/troubleshoot-aks-cluster-start-issues/activity-log-errors.png" alt-text="Screenshot of an AKS cluster Activity Log blade displaying a start operation that has failed." border="false":::

What if an error occurred instead? In that case, the **Start Managed Cluster** operation **Status** field shows **Failed**. Unlike in the operations to create cluster components, here you must expand the failed operation entry to review the suboperation entries. Typical suboperation names are policy actions, such as **'audit' Policy action** and **'auditIfNotExists' Policy action.** Some of the suboperations will continue to show that they succeeded.

To further investigate, you can select one of the failed suboperations. A side pane opens so that you can review more information about the suboperation. You can troubleshoot values for fields such as **Summary**, **JSON**, and **Change History**. The **JSON** field contains the output text for the error in JSON format, and it usually provides the most helpful information.

:::image type="content" source="media/troubleshoot-aks-cluster-start-issues/activity-log-error-details.png" alt-text="Screenshot of an AKS cluster Activity Log suboperation side pane displaying a start operation failure cause." border="false":::

## View cluster insights

You may also generate cluster insights that will help you troubleshoot via the **Diagnose and solve problems** blade on the Azure portal. To access this feature, follow these steps:

1. In [the Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. Select the name of your AKS cluster.

1. In the navigation pane of the AKS cluster page, select **Diagnose and solve problems**.

1. In the **Diagnose and solve problems** page, select the **Cluster insights** link. The cluster insights tool analyzes your cluster, and then provides a list of its findings in the **Observations and Solutions** section of the **Cluster Insights** page.

1. Select one of the findings to view more information about a problem and its possible solutions.

## View resources in the Azure portal

In the Azure portal, you might want to view the resources that were created when the cluster was built. Typically, these resources are in a resource group that begins in *MC_*. The managed cluster resource group might have a name such as **MC_MyResourceGroup_MyManagedCluster_\<location-code>**. However, the name may be different if you built the cluster by using a custom-managed cluster resource group.

To find the resource group, search for and select **Resource groups** in the Azure portal, and then select the resource group in which the cluster was created. The resource list is shown in the **Overview** page of the resource group.

> [!WARNING]
> We recommend that you don't modify resources in the *MC_* resource group. This action might cause unwanted effects on your AKS cluster.
To review the status of a virtual machine scale set, you can select the scale set name within the list of resources for the resource group. It might have a **Name** similar to **aks-nodepool1-12345678-vmss**, and it would have a **Type** value of **Virtual machine scale set**. The status of the scale set appears at the top of the node pool's **Overview** page, and more details are shown in the **Essentials** heading. If deployment was unsuccessful, the displayed status is **Failed**.

For all resources, you can review details to gain a better understanding about why the deployment failed. For a scale set, you can select the **Failed** status text to view details about the failure. The details are in a row that contains **Status**, **Level**, and **Code** columns. The following example shows a row of column values.

| Column | Example value |
| ------ | ------------- |
| Status | **Provisioning failed** |
| Level | **Error** |
| Code | **ProvisioningState/failed/VMExtensionProvisioningError** |

Select the row to see the **Message** field. This contains even more information about that failure. For example, the **Message** field for the example row begins in the following text:

> VM has reported a failure when processing extension 'vmssCSE'. Error message: "Enable failed: failed to execute command: command terminated with exit status=50 [stdout] [stderr] 0 0 0 --:
Armed with this information, you can conclude that the VMs in the scale set failed and generated exit status 50.

## Use Kubectl commands

For another option to help troubleshoot errors on your cluster, enter kubectl commands to get details about the resources that were deployed in the cluster. To use kubectl, first sign in to your AKS cluster:

```azurecli-interactive
az aks get-credentials --resource-group MyResourceGroup --name MyManagedCluster
```

Depending on the type of failure and when it occurred, you might not be able to sign in to your cluster to get more details. But in general, if your cluster was created and shows up in the Azure portal, you should be able to sign in and run kubectl commands.

### View cluster nodes (kubectl get nodes)

To get more details to determine the state of the nodes, view the cluster nodes by entering the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) nodes command. In this example, no nodes are reporting in the cluster:

```console
$ kubectl get nodes

No resources found
```

### View pods in the system namespace (kubectl get pods)

Viewing the pods in the kube-system namespace is also a good way to troubleshoot your issue. This method lets you view the status of the Kubernetes system pods. In this example, we enter the `kubectl get pods` command:

```console
$ kubectl get pods -n kube-system
NAME                                  READY   STATUS    RESTARTS   AGE
coredns-845757d86-7xjqb               0/1     Pending   0          78m
coredns-autoscaler-5f85dc856b-mxkrj   0/1     Pending   0          77m
konnectivity-agent-67f7f5554f-nsw2g   0/1     Pending   0          77m
konnectivity-agent-8686cb54fd-xlsgk   0/1     Pending   0          65m
metrics-server-6bc97b47f7-dfhbr       0/1     Pending   0          77m
```

### Describe the status of a pod (kubectl describe pod)

By describing the status of the pods, you can view the configuration details and any events that have occurred on the pods. Run the [kubectl describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) pod command:

```console
$ kubectl describe pod coredns-845757d86-7xjqb -n kube-system
Name:                 coredns-845757d86-7xjqb
Namespace:            kube-system
Priority:             2000001000
Priority Class Name:  system-node-critical
Node:                 <none>
Labels:               k8s-app=kube-dns
                      kubernetes.io/cluster-service=true
                      pod-template-hash=845757d86
                      version=v20
...
Events:
  Type     Reason            Age                 From               Message
  ----     ------            ----                ----               -------
  Warning  FailedScheduling  24m (x1 over 25m)   default-scheduler  no nodes available to schedule pods
  Warning  FailedScheduling  29m (x57 over 84m)  default-scheduler  no nodes available to schedule pods
```

In the command output, you can see that the pod can't deploy to a node because no nodes are available.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]