---
title: Troubleshoot Azure Kubernetes Service cluster startup issues
description: Learn about basic troubleshooting methods to use when you can't start an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/19/2026
ms.reviewer: chiragpa, v-weizhu, jovieir, addobres
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), devx-track-azurecli
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting measures to resolve issues that occur when I try to start an Azure Kubernetes Service (AKS) cluster.
---
# Basic troubleshooting of AKS cluster startup issues

## Summary

This article provides basic troubleshooting steps for an Azure Kubernetes Service (AKS) cluster that was previously stopped by using the AKS stop/start feature and doesn't return to a running state. If the failure occurred during cluster creation, upgrade, node pool provisioning, or normal Kubernetes API access, use the troubleshooting guidance for that operation.

## Prerequisites

- Install the latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- Sign in to Azure by using `az login`.
- Confirm that the CLI is using the subscription that contains the AKS cluster.
- Install `kubectl` if Kubernetes API checks will be performed after the cluster starts.

Check the Azure CLI version and current subscription:

```azurecli
az version
az account show --output table
```

If necessary, select the correct subscription:

```azurecli
az account set --subscription "<subscription-name-or-id>"
```

To install `kubectl` by using Azure CLI, run:

```azurecli
az aks install-cli
```

## Confirm that the cluster is ready to start

Before you start the cluster, check its power and provisioning state:

```azurecli
az aks show \
  --resource-group myResourceGroup \
  --name MyManagedCluster \
  --query "{powerState:powerState.code, provisioningState:provisioningState}" \
  --output table
```

Confirm that:

- `powerState` is `Stopped`.
- `provisioningState` is `Succeeded`.
- The previous stop operation is no longer in progress.

If `provisioningState` is `Stopping`, wait for the stop operation to finish before you try to start the cluster. After you use the stop operation, wait 15-30 minutes before you restart the cluster so that the related services have time to stop completely.

> [!CAUTION]
> Stopping an AKS cluster deallocates the control plane and releases capacity. In a region that has limited capacity, Azure might not be able to start the stopped cluster immediately. We don't recommend using stop/start for mission-critical workloads.

The stop/start feature is supported only for Virtual Machine Scale Set-backed clusters. It isn't supported for clusters that use node auto-provisioning.

## View errors from Azure CLI

When you start a cluster by using Azure CLI, errors are recorded as output if the operation fails:

```console
az aks start --resource-group myResourceGroup --name MyManagedCluster

(VMExtensionProvisioningError) Unable to establish an outbound connection from the agent nodes.
Code: VMExtensionProvisioningError
```

Keep the complete output because the error code identifies the next troubleshooting step. Use the error code and message to locate the matching AKS troubleshooting article. Don't rely only on the last line of the CLI output.

The start operation runs asynchronously. Check the cluster state:

```azurecli
az aks show \
  --resource-group myResourceGroup \
  --name MyManagedCluster \
  --query "{powerState:powerState.code, provisioningState:provisioningState}" \
  --output table
```

Interpret the result as follows:

- If `provisioningState` is `Starting`, the start operation is still in progress.
- If `powerState` is `Running` and `provisioningState` is `Succeeded`, the management-plane start operation is complete. Continue with the Kubernetes API and node checks.
- If `provisioningState` is `Failed`, review the Azure Activity Log, AKS diagnostics, and failed resource details.
- If `powerState` remains `Stopped` and there's no active start operation, review the start command output and Azure Activity Log.

## View error details in the Azure portal

To view the details about errors in the [Azure portal](https://portal.azure.com), examine the [Azure activity log](/azure/azure-monitor/essentials/activity-log). To find the list of activity logs in the Azure portal, search on **Activity log**. Or, select **Notifications** (the bell icon), and then select **More events in the activity log**.

Locate the latest **Start Managed Cluster** operation for the affected cluster.

Confirm that **Event initiated by** shows the expected user or workload identity. The operation might have been started by a user, service principal, managed identity, or automation process.

Expand the operation, and review its final status and suboperations. A status of **Accepted** means that Azure accepted the asynchronous request. It doesn't confirm that the cluster finished starting successfully.

:::image type="content" source="media/troubleshoot-aks-cluster-start-issues/activity-log-errors.png" alt-text="Screenshot of an AKS cluster activity log blade showing a failed start operation.":::

If the final operation or a suboperation shows **Failed**, open the failed entry and review the following information:

- **Summary**
- **JSON**
- Error code
- Error message
- Correlation ID, if available

Use the error code and message to continue with the relevant AKS troubleshooting guidance.

:::image type="content" source="media/troubleshoot-aks-cluster-start-issues/activity-log-error-details.png" alt-text="Screenshot of a suboperation side pane of an AKS cluster activity log showing why a start operation failed.":::

## View cluster insights

You can also generate cluster insights to help you troubleshoot via the **Diagnose and solve problems** blade in the Azure portal. To access this feature, follow these steps:

1. In [the Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.

1. Select the name of your AKS cluster.

1. In the navigation pane of the AKS cluster page, select **Diagnose and solve problems**.

1. On the **Diagnose and solve problems** page, select the **Cluster insights** link. The cluster insights tool analyzes your cluster, and then provides a list of its findings in the **Observations and Solutions** section of the **Cluster Insights** page.

1. Select one of the findings to view more information about a problem and its possible solutions.

## View resources in the Azure portal

In the Azure portal, you might want to view the resources that were created when the cluster was built. Typically, these resources are in a resource group that begins with *MC_*. The managed cluster resource group might have a name such as **MC_MyResourceGroup_MyManagedCluster_\<location-code>**. However, the name may be different if you built the cluster by using a custom-managed cluster resource group.

To find the resource group, search for and select **Resource groups** in the Azure portal, and then select the resource group in which the cluster was created. The resource list is shown on the **Overview** page of the resource group.

> [!WARNING]
> We recommend that you don't modify resources in the *MC_* resource group. This action might cause unwanted effects on your AKS cluster.

To review the status of a virtual machine scale set, you can select the scale set name within the resource list of the resource group. It might have a **Name** similar to **aks-nodepool1-12345678-vmss** and a **Type** value of **Virtual machine scale set**. The status of the scale set appears at the top of the node pool's **Overview** page, and more details are shown in the **Essentials** heading. If the deployment was unsuccessful, the displayed status is **Failed**.

For all resources, you can review details to better understand why the deployment failed. For a scale set, you can select the **Failed** status text to view details about the failure. The details are in a row that contains the **Status**, **Level**, and **Code** columns. The following example shows a row of column values.

| Column | Example value |
| ------ | ------------- |
| Status | **Provisioning failed** |
| Level | **Error** |
| Code | **ProvisioningState/failed/VMExtensionProvisioningError** |

Select the row to see the **Message** field. This contains even more information about that failure. For example, the **Message** field for the example row begins with the following text:

> VM has reported a failure when processing extension 'vmssCSE'. Error message: "Enable failed: failed to execute command: command terminated with exit status=50 [stdout] [stderr] 0 0 0 --:
Armed with this information, you can conclude that the VMs in the scale set failed and generated exit status 50.

## Use kubectl commands

Use `kubectl` only after the cluster reports `powerState` as `Running` and `provisioningState` as `Succeeded`.

Your client must also have DNS and network access to the Kubernetes API server. For a private cluster, run the commands from a network that can resolve and reach the private API server. If API server authorized IP ranges are enabled, confirm that the client IP address is allowed.

Retrieve or merge the cluster credentials:

```azurecli
az aks get-credentials \
  --resource-group MyResourceGroup \
  --name MyManagedCluster
```

The `az aks get-credentials` command updates kubeconfig. It doesn't confirm that the Kubernetes API server is reachable.

Test API connectivity:

```azurecli
kubectl cluster-info
kubectl get nodes
```

If the API server can't be reached, continue checking:

- The cluster power and provisioning state.
- Private DNS and network routing.
- Firewall rules.
- API server authorized IP ranges.

A stopped cluster remains visible in the Azure portal even though its Kubernetes API server is unavailable.

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

In the command output, you can see that the pod can't be deployed to a node because no nodes are available.

## Confirm that the cluster recovered

After the start operation is complete, confirm that:

1. The cluster reports `powerState` as `Running` and `provisioningState` as `Succeeded`.
1. `kubectl cluster-info` can reach the Kubernetes API server.
1. The cluster nodes return to the `Ready` state.
1. Critical pods in the `kube-system` namespace return to a healthy state.

Run:

```azurecli
kubectl get nodes
kubectl get pods --namespace kube-system
```

If nodes remain unavailable or system pods remain pending, continue with the node provisioning, networking, or VM extension troubleshooting guidance that matches the reported error.

 
