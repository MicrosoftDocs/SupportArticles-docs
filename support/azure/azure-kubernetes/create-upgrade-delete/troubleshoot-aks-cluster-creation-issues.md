---
title: Troubleshoot Azure Kubernetes Service cluster creation issues
description: Learn about basic troubleshooting methods to use when you can't create or deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/30/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), devx-track-azurecli
#Customer intent: As an Azure Kubernetes user, I want to use basic troubleshooting methods to resolve issues that occur when I try to create or deploy an Azure Kubernetes Service (AKS) cluster.
---
# Basic troubleshooting of AKS cluster creation issues

This article outlines the basic troubleshooting methods to use if you can't create or deploy a Microsoft Azure Kubernetes Service (AKS) cluster successfully.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or a later version).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## View errors from Azure CLI

If the operation fails when you try to create clusters by using Azure CLI, the output displays error information. Here's a sample Azure CLI command and output:

```azurecli-interactive
# Create a cluster specifying subnet

az aks create --resource-group myResourceGroup
--name MyManagedCluster \
--load-balancer-sku standard \
--vnet-subnet-id /subscriptions/<subscriptions-id>/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/aks_demo_vnet/subnets/AKS
```

Sample of output:

```output
It is highly recommended to use USER assigned identity (option --assign-identity)when you want to bring you own subnet, which will have no latency for the role assignment to take effect. When you SYSTEM assigned identity, azure-cli will grant Network Contributor role to the system assigned identity after the cluster is created, and the role assignment will take some time to take effect, see https://learn.microsoft.com/azure/aks/use-managed-identity, proceed to create cluster with system assigned identity? (y/N): y`

(ControlPlaneAddOnsNotReady) Pods not in Running status: konnectivity-agent-67f7f5554f-nsw2g,konnectivity-agent-8686cb54fd-xlsgk,metrics-server-6bc97b47f7-dfhbr,coredns-845757d86-7xjqb,coredns-autoscaler-5f85dc856b-mxkrj
```

You can identify the error code and error message from the output. In this case, they are:

- **Error code**: `ControlPlaneAddOnsNotReady`
- **Error message**: `Pods not in Running status: konnectivity-agent-67f7f5554f-nsw2g,konnectivity-agent-8686cb54fd-xlsgk,metrics-server-6bc97b47f7-dfhbr,coredns-845757d86-7xjqb,coredns-autoscaler-5f85dc856b-mxkrj`.

These descriptions often contain details of what went wrong in the cluster creation, and they link to articles that contain even more details. Additionally, you can use our troubleshooting articles as a reference, based on the errors that the Azure CLI operation produces.

## View error details in the Azure portal

To investigate the AKS cluster creation errors in the [Azure portal](https://portal.azure.com), open the [Activity Log](/azure/azure-monitor/essentials/activity-log). You can filter the results to fit your needs. To do this, select **Add Filter** to add more properties to the filter.

:::image type="content" source="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy-filtering.png" alt-text="Screenshot of how to add filter." lightbox="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy-filtering.png":::

On the **Activity Log** page, locate log entries in which the **Operation name** column shows **Create or Update Managed Cluster**.

The **Event initiated by** column shows the user who performed the operation, which could be a work account, a school account, or an [Azure managed identity](/entra/identity/managed-identities-azure-resources/how-manage-user-assigned-managed-identities).

If the operation is successful, the **Status** column value is **Accepted**. You'll also see suboperation entries for the creation of the cluster components, such as the following operation names:

- **Create or Update Route Table**
- **Create or Update Network Security Group**
- **Update User Assigned Identity Create**
- **Create or Update Load Balancer**
- **Create or Update Public Ip Address**
- **Create role assignment**
- **Update resource group**

In these suboperation entries, the **Status** value is **Succeeded** and the **Event initiated by** field is set to **AzureContainerService**.

:::image type="content" source="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy.png" alt-text="Screenshot of the view in Activity log." lightbox="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy.png":::

What if an error occurred instead? In that case, the **Status** value is **Failed**. Unlike in the operations to create cluster components, you must expand the failed suboperation entries to review them. Typical suboperation names are policy actions, such as **'audit' Policy action** and **'auditIfNotExists' Policy action.** Not all suboperations necessarily fail together. You can expect to see some of them succeed.

Select one of the failed suboperations to further investigate it. Select the **Summary**, **JSON**, and **Change History** tabs to troubleshoot the issue. The **JSON** tab contains the output text for the error in JSON format, and it usually provides the most helpful information.

:::image type="content" source="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy-json.png" alt-text="Screenshot of the detailed log in JSON format." lightbox="media/troubleshoot-aks-cluster-creation-issues/exploring-activitylog-azportal-visualy-json.png":::

Here's an example of the detailed log in JSON format:

```JSON
{
     "status": {
        "value": "Failed",
        "localizedValue": "Failed"
    },
    "subStatus": {
        "value": "",
        "localizedValue": ""
    },
    "submissionTimestamp": "2024-08-30T10:06:07Z",
    "subscriptionId": "<subscriptionId>",
    "tenantId": "<tenantId>",
    "properties": {
        "statusMessage": "{\"status\":\"Failed\",\"error\":{\"code\":\"ResourceOperationFailure\",\"message\":\"The resource operation completed with terminal provisioning state 'Failed'.\",\"details\":[{\"code\":\"VMExtensionProvisioningError\",\"message\":\"Unable to establish outbound connection from agents, please see https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/error-code-outboundconnfailvmextensionerror and https://aka.ms/aks-required-ports-and-addresses for more information.\"}]}}",
}
}
```


## View cluster insights

Was the cluster created in the Azure portal, and is it visible there? If this is true, you can generate cluster insights that will help you troubleshoot. To access this feature, follow these steps:

1. In [the Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. Select the name of your AKS cluster.

1. In the navigation pane of the AKS cluster page, select **Diagnose and solve problems**.

1. In the **Diagnose and solve problems** page, select the **Cluster insights** link. The cluster insights tool analyzes your cluster, and then provides a list of its findings in the **Observations and Solutions** section of the **Cluster Insights** page.

1. Select one of the findings to view more information about a problem and its possible solutions.

## View resources in the Azure portal

In the Azure portal, you might want to view the resources that were created when the cluster was built. Typically, these resources are in a resource group whose name begins in *MC_*. The managed cluster resource group might have a name such as **MC_MyResourceGroup_MyManagedCluster_\<location-code>**. However, the name may be different if you built the cluster by using a custom-managed cluster resource group.

To find the resource group, search for and select **Resource groups** in the Azure portal, and then select the resource group in which the cluster was created. The resource list is shown in the **Overview** page of the resource group.

> [!WARNING]
> We recommend that you don't modify resources in the *MC_* resource group. This action might adversely affect your AKS cluster.

To review the status of a virtual machine scale set, you can select the scale set name within the list of resources for the resource group. It might have a **Name** value that resembles **aks-nodepool1-12345678-vmss**, and it a **Type** value of **Virtual machine scale set**. The status of the scale set appears at the top of the node pool's **Overview** page, and more details are shown in the **Essentials** heading. If deployment was unsuccessful, the displayed status is **Failed**.

For all resources, you can review details to gain a better understanding about why the deployment failed. For a scale set, you can select the **Failed** status text to view details about the failure. The details are in a row that contains **Status**, **Level**, and **Code** columns. The following example shows a row of column values.

| Column | Example value |
| ------ | ------------- |
| Status | **Provisioning failed** |
| Level | **Error** |
| Code | **ProvisioningState/failed/VMExtensionProvisioningError** |

Select the row to see the **Message** field. This contains even more information about that failure. For example, the **Message** field for the example row begins in the following text:

> VM has reported a failure when processing extension 'vmssCSE'. Error message: "Enable failed: failed to execute command: command terminated with exit status=50 [stdout] [stderr] 0 0 0 --:

Armed with this information, you can conclude that the VMs in the scale set failed and generated exit status 50.

> [!NOTE]
> If the cluster deployment didn't reach the point at which these resources would have been created, you might not be able to review the managed cluster resource group in the Azure portal.

## Use Kubectl commands

For another option to help troubleshoot errors on your cluster, use kubectl commands to get details about the resources that were deployed in the cluster. To do this, first sign in to your AKS cluster:

```azurecli-interactive
az aks get-credentials --resource-group MyResourceGroup --name MyManagedCluster
```

Depending on the type of failure and when it occurred, you might not be able to sign in to your cluster to get more details. But if your cluster was created and appears in the Azure portal, you should be able to sign in and run kubectl commands.

### View cluster nodes (kubectl get nodes)

To determine the state of the cluster nodes, view the nodes by running the [`kubectl get nodes`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command. In this example, no nodes are reporting in the cluster:

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

By describing the status of the pods, you can view the configuration details and any events that have occurred on the pods. Run the [`kubectl describe pods`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
