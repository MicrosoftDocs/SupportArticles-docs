---
title: Troubleshoot the Microsoft.virtualnodes Extension in AKS
description: Learn how to troubleshoot installation and pod deployment issues for the Microsoft.virtualnodes extension on Azure Kubernetes Service (AKS). Start now.
ms.date: 09/23/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tscuiu
ms.service: azure-container-instances
ms.custom: sap:Management
#Customer intent: As an Azure Kubernetes Service administrator, I want to troubleshoot Microsoft.virtualnodes extension and workload pod failures so that I can run pods on Azure Container Instances.
ai-usage: ai-assisted
---
# Troubleshoot Microsoft.virtualnodes extension installation and pod deployment

## Summary

This article describes how to troubleshoot installation and pod deployment issues for the `Microsoft.virtualnodes` extension on Azure Kubernetes Service (AKS).

## Troubleshoot extension installation

Follow the guidance in [Troubleshoot errors when deploying AKS cluster extensions](../../azure-kubernetes/extensions/cluster-extension-deployment-errors.md). If the issue persists, follow these steps to troubleshoot the `Microsoft.virtualnodes` extension:

1. If Azure CLI reports errors about the cluster configuration or parameters, correct any unsupported settings or AKS cluster configuration, and then retry the installation.
1. If installation fails or the extension has a `Failed` provisioning state, make sure that no Azure Policy or Kubernetes policy prevents the extension from creating the `vn-system` namespace or resources in that namespace.
1. Check the extension resource for errors. Use Azure CLI to run the following command.

   ```azurecli
   az k8s-extension show --name <extension-name> --cluster-type managedClusters --cluster-name <aks-cluster-name> --resource-group <resource-group>
   ```

   Review the response for error details. The response might show `"provisioningState": "Pending"` during the first few minutes of installation.

1. If the extension resource doesn't show a relevant error, use a command line interface (CLI) tool to check whether the virtual node is healthy.

   ```bash
   kubectl get nodes
   ```

   A healthy virtual node appears in the `Ready` state, as shown in this example:

   ```output
   NAME                                      STATUS   ROLES    AGE     VERSION
   aks-agentpool-22784341-vmss00000n         Ready    <none>   4d13h   v1.34.9
   aks-agentpool-22784341-vmss00000p         Ready    <none>   4d13h   v1.34.9
   <extension-name>-virtualnode-0            Ready    <none>   17d     v1.34.6
   ```

1. If the virtual node is `NotReady`, check the infrastructure pods. These pods are always in the `vn-system` namespace. Run the following command.

   ```bash
   kubectl get pods -n vn-system
   ```

   Healthy infrastructure pods have all their containers in the `Ready` state as listed in the following example.

   ```output
   NAME                                                 READY   STATUS    RESTARTS      AGE
   virtual-node-admission-controller-68ff9b4dbb-4cp8j   1/1     Running   1 (28h ago)   28h
   <extension-name>-virtualnode-0                       6/6     Running   1 (28h ago)   28h
   ```

1. If an infrastructure pod isn't healthy, inspect its status and events. Run the following command.

   ```bash
   kubectl describe pod <infrastructure-pod-name> -n vn-system
   ```

   The events can reveal common issues such as image pull errors or Kubernetes probe failures.

1. If one or more infrastructure pods report errors, inspect the logs from all containers. Run the following command.

   ```bash
   kubectl logs <infrastructure-pod-name> -n vn-system --all-containers=true --prefix
   ```

   To inspect a specific container, run the following command. You can redirect the output to a file if the logs are large.

   ```bash
   kubectl logs <infrastructure-pod-name> -n vn-system -c <container-name>
   ```

Error messages often identify an actionable issue, such as insufficient permissions. If the error isn't clear or doesn't identify an action that you can take, [create an Azure support request](https://aka.ms/azuresupport) for Azure Container Instances. Provide the following information:

- Any correlation ID shown in the Kubernetes events or infrastructure container logs
- Subscription ID
- Resource group name

If the issue concerns the extension resource rather than virtual node enablement, create an Azure support request for AKS Extensions.

## Troubleshoot pod deployment

For specialized scenarios, see the following guidance:

- [Confidential container troubleshooting](https://github.com/microsoft/virtualnodesOnAzureContainerInstances/blob/main/Docs/Troubleshooting.md#confidential-troubleshooting)
- [Network troubleshooting](https://github.com/microsoft/virtualnodesOnAzureContainerInstances/blob/main/Docs/Troubleshooting.md#network-troubleshooting)

To inspect any workload pod, run the following command.

```bash
kubectl describe pod <pod-name> -n <namespace>
```

The pod status and events can reveal scheduling failures, image pull failures, registry authorization errors, Kubernetes probe failures, and container creation or startup errors.

### Common problems

#### 1. Image pull failures

Ensure that you can access the container registry and that the specified image and tag exist. 

#### 2. Pod isn't scheduled on the virtual node

Check the node on which the pod is scheduled. Run the following command.

```bash
kubectl get pods -o wide -n <namespace>
```

If the pod is scheduled on a standard AKS node instead of the virtual node, the output resembles the following example.

```output
NAME       READY   STATUS    RESTARTS   AGE   IP         NODE                                  NOMINATED NODE   READINESS GATES
demo-pod   1/1     Running   0          92s   10.1.0.6   aks-nodepool1-17551885-vmss000000     <none>           <none>
```

Ensure that the pod specification contains the required node selectors and toleration. Run the following command.

```yaml
nodeSelector:
  virtualization: virtualnode2
  "kubernetes.io/os": linux
tolerations:
- effect: NoSchedule
  key: virtual-kubelet.io/provider
  operator: Exists
```

#### 3. Collect information for support

If an error isn't clear or doesn't identify an action that you can take, [create an Azure support request](https://aka.ms/azuresupport) for Azure Container Instances. Run the following command to retrieve the container ID to include in the request.

```bash
kubectl get pod <pod-name> -n <namespace> -o jsonpath='{.status.containerStatuses[?(@.name=="<container-name>")].containerID}'
```

Provide the following information:

- Container ID
- Any correlation ID shown in the Kubernetes events
- Subscription ID
- Resource group name
