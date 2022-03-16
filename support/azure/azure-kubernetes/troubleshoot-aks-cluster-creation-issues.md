---
title: Troubleshoot Azure Kubernetes Service cluster creation issues
description: Learn about general troubleshooting methods to use when you're unable to create or deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to take general troubleshooting measures so that I can resolve issues when trying to create or deploy an Azure Kubernetes Service (AKS) cluster.
---
# General troubleshooting of AKS cluster creation issues

This article outlines the general troubleshooting methods to use if you're unable to create or deploy a Microsoft Azure Kubernetes Service (AKS) cluster successfully.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or higher).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl using Azure CLI, enter the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## View errors from Azure CLI

When you create clusters using Azure CLI, errors are provided as output if the operation fails. Here's how a command, user input, and operation output might appear in a Bash console:

> `$ az aks create --resource-group myResourceGroup \` \
> `> --name MyManagedCluster \` \
> `> --load-balancer-sku standard \` \
> `> --vnet-subnet-id /subscriptions/01234567-89ab-cdef-0123-456789abcdef/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/aks_demo_vnet/subnets/AKS`
>
> `It is highly recommended to use USER assigned identity (option --assign-identity) when you want to bring you own subnet, which will have no latency for the role assignment to take effect. When you SYSTEM assigned identity, azure-cli will grant Network Contributor role to the system assigned identity after the cluster is created, and the role assignment will take some time to take effect, see https://docs.microsoft.com/azure/aks/use-managed-identity, proceed to create cluster with system assigned identity? (y/N): y`
>
> `(ControlPlaneAddOnsNotReady) Pods not in Running status: konnectivity-agent-67f7f5554f-nsw2g,konnectivity-agent-8686cb54fd-xlsgk,metrics-server-6bc97b47f7-dfhbr,coredns-845757d86-7xjqb,coredns-autoscaler-5f85dc856b-mxkrj`
>
> `Code: ControlPlaneAddOnsNotReady`
>
> `Message: Pods not in Running status: konnectivity-agent-67f7f5554f-nsw2g,konnectivity-agent-8686cb54fd-xlsgk,metrics-server-6bc97b47f7-dfhbr,coredns-845757d86-7xjqb,coredns-autoscaler-5f85dc856b-mxkrj`

These errors often contain detailed descriptions of what went wrong with the cluster creation, and they provide links to articles that give more details. In addition, you can use our troubleshooting articles as a reference based on what error an Azure CLI operation produces.

## View errors from the Azure portal

To view any errors from the [Azure portal](https://portal.azure.com), get your [Azure activity log](/azure/azure-monitor/essentials/activity-log). You can find the list of activity logs in the Azure portal if you search for and select **Activity log**. Or, select **Notifications** (the bell icon), and then select **More events in the activity log**.

In the list of logs on the **Activity log** page, there's a line entry in which the **Operation name** column value is named **Create or Update Managed Cluster**. The corresponding **Event initiated by** column value is set to the name of your work or school account. If the operation is successful, the **Status** column value is **Accepted**. You'll also see suboperation entries for the creation of the cluster components, such as the following operation names:

- **Create or Update Route Table**
- **Create or Update Network Security Group**
- **Update User Assigned Identity Create**
- **Create or Update Load Balancer**
- **Create or Update Public Ip Address**
- **Create role assignment**
- **Update resource group**

In these suboperation entries, the **Status** is **Succeeded**, and the **Event initiated by** field is set to **AzureContainerService**.

What if an error occurred instead? Then, the **Create or Update Managed Cluster** operation's **Status** is **Failed**. Unlike with the operations for the successful creation of cluster components, you must expand the failed operation entry to review the suboperation entries. Typical suboperation names are policy actions, such as **'audit' Policy action.** and **'auditIfNotExists' Policy action.** Some of the suboperations will still show that they succeeded.

To further investigate, you can select one of the failed suboperations. A side pane will display so that you can review more information about the suboperation. You can troubleshoot values for fields such as **Summary**, **JSON**, and **Change History**. The **JSON** field, which contains the output text for the error in JSON format, usually provides the most helpful information.

## View cluster insights

Was the cluster created in the Azure portal, and is it visible from there? Then, you generate cluster insights that will help assist with troubleshooting. To access this feature, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. Select the name of your AKS cluster.

1. From your AKS cluster page's navigation pane, select **Diagnose and solve problems**.

1. In the **Diagnose and solve problems** page, select the **Cluster insights** link. The cluster insights tool analyzes your cluster, and then provides a list of its findings in the **Observations and Solutions** section of the **Cluster Insights** page.

1. Select one of the findings to view more information about a problem and its possible solutions.

## View resources in the Azure portal

In the Azure portal, you might want to view the resources that were created when the cluster was built. Normally, these resources will be in a resource group that begins with *MC_*. The managed cluster resource group might have a name such as **MC_MyResourceGroup_MyManagedCluster_\<location-code>**. However, the name may be different if you built the cluster with a custom-managed cluster resource group.

To find the resource group, search for and select **Resource groups** in the Azure portal, and then select the resource group in which the cluster was created. The resource list is shown in the **Overview** page of the resource group.

> [!WARNING]
> Modifying resources in the *MC_* resource group isn't recommended. This action might cause unwanted effects on your AKS cluster.

To review the status of a virtual machine scale set, you can select the scale set name within the list of resources for the resource group. It might have a **Name** similar to **aks-nodepool1-12345678-vmss**, and it would have a **Type** value of **Virtual machine scale set**. The status of the scale set appears at the top of the node pool's **Overview** page, and further details are shown in the **Essentials** heading. If deployment was unsuccessful, the displayed status is **Failed**.

For all resources, you can review details to help get a better understanding of why the deployment failed. For a scale set, you can select the **Failed** status text to view details about the failure. The details are in a row that contains **Status**, **Level**, and **Code** columns. An example row of column values is shown below:

| Column | Example value |
| ------ | ------------- |
| Status | **Provisioning failed** |
| Level | **Error** |
| Code | **ProvisioningState/failed/VMExtensionProvisioningError** |

Select the row to see the **Message** field, which contains even more information about that failure. For example, the **Message** field for the example row begins with the following text:

> VM has reported a failure when processing extension 'vmssCSE'. Error message: "Enable failed: failed to execute command: command terminated with exit status=50 [stdout] [stderr] 0 0 0 --:

With this information, you can conclude that the VMs in the scale set failed with exit status 50.

> [!NOTE]
> If the cluster deployment didn't reach the point where these resources were created, you might be unable to review the managed cluster resource group in the Azure portal.

## Use Kubectl commands

For another option to help troubleshoot errors on your cluster, enter kubectl commands to get details about the resources that were deployed in the cluster. To use kubectl, first sign in to your AKS cluster:

```azurecli-interactive
az aks get-credentials --resource-group MyResourceGroup --name MyManagedCluster
```

Depending on the type of failure and when it occurred, you might be unable to sign in to your cluster and get more details. But in general, if your cluster was created and shows up in the Azure portal, you should be able to sign in and run kubectl commands.

### View cluster nodes (kubectl get nodes)

Viewing the cluster nodes will To help you get details to determine the state of the nodes, view the cluster nodes by entering the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) nodes command. In this example, no nodes are reporting in the cluster:

```console
$ kubectl get nodes

No resources found
```

### View pods in the system namespace (kubectl get pods)

Viewing the pods in the kube-system namespace is also a good way to help troubleshoot your issue. This method allows you to view the status of the Kubernetes system pods. In this example, we enter the `kubectl get pods` command:

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

By describing the status of the pods, you can view the configuration details and any events that have occurred on the pods. Enter the [kubectl describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) pod command:

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

From the command output, you can see that the pod is unable to deploy to a node, because no nodes are available.
