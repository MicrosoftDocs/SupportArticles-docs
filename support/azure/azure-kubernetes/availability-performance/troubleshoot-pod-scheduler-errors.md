---
title: Troubleshoot AKS pod scheduler errors
description: Learn how to troubleshoot AKS pod scheduler errors, understand common causes, and apply proven fixes to get pods running. Start resolving issues now.
ms.date: 10/27/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
ai-usage: ai-assisted
---
# Troubleshoot pod scheduler errors in Azure Kubernetes Service

## Summary

This article describes common pod scheduler errors in Azure Kubernetes Service (AKS), their causes, and solutions to get your pods running.

When you deploy workloads in AKS, you might encounter scheduler errors that prevent pods from running. The following sections describe common errors, their causes, and how to resolve them.

## Error: 0/(X) nodes are available: Y node(s) had volume node affinity conflict

> [!NOTE]
>  X and Y represent the number of nodes. These values depend on your cluster configuration.
 
Pods remain in the **Pending** state with the following scheduler error message.

>0/(X) nodes are available: Y node(s) had volume node affinity conflict.

### Cause

[Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#node-affinity) define `nodeAffinity` rules that restrict which nodes can access the volume. If none of the available nodes satisfy the volume's affinity rules, the scheduler can't assign the pod to any node.

### Solution

Follow these steps to resolve the volume node affinity conflict:

1. Review the node affinity set on your Persistent Volume resource. Run the following command.

    ```bash
     kubectl get pv <pv-name> -o yaml 
    ```

1. Check node labels in the cluster.

    ```bash
    kubectl get nodes --show-labels
    ```

1. Ensure that at least one node's labels match the `nodeAffinity` specified in the Persistent Volume's YAML spec.
1. To resolve the conflict, update the Persistent Volume's `nodeAffinity` rules to match existing node labels or add the required labels to the correct node.

    ```bash
    kubectl label nodes <node-name> <key>=<value>
    ```

    Or, modify the Persistent Volume's affinity rules to match existing node labels.
1. After resolving the conflict, monitor the pod status or retry the deployment.

## Error: 0/(X) nodes are available: Insufficient CPU

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Insufficient CPU.

### Cause

This issue occurs when one or more of the following conditions are true:

- All node resources are in use.
- The pending pod's resource requests exceed available CPU on the nodes.
- The node pools lack sufficient resources or have incorrect configuration settings.

### Solution

Follow these steps to resolve the insufficient CPU issue:

1. Review CPU usage on all nodes and check if there's enough unallocated CPU to meet the pod's request.

    ```bash
    kubectl describe pod <pod-name>
    kubectl describe nodes
    ```

1. If no node has enough CPU, increase the number of nodes or use larger VM sizes in the node pool. Run the following command to scale the node pool.

    ```bash
    az aks nodepool scale \
      --resource-group <resource-group> \
      --cluster-name <aks-name> \
      --name <nodepool-name> \
      --node-count <desired-node-count>
    ```

1. Optimize pod resource requests. Ensure that CPU requests and limits are appropriate for your node sizes.
1. Check if any scheduling constraints are restricting pod placement across available nodes.

## Error: 0/(X) nodes are available: Y node(s) had untolerated taint

Pods remain in the **Pending** state with the following error message.

>Error: 0/(X) nodes are available: Y node(s) had untolerated taint.

### Cause

The Kubernetes scheduler tries to assign the pod to a node, but it rejects all nodes for one of the following reasons:

- The node has a taint (`key=value:effect`) that the pod doesn't tolerate.
- The node has other taint-based restrictions that prevent the pod from being scheduled.

### Solution

Follow these steps to resolve the untolerated taint issue:

1. Check node taints.

    ```bash
     kubectl get nodes -o json | jq '.items[].spec.taints'   
    ```

1. Add necessary tolerations to the pod specifications. Edit your deployment or pod YAML to include matching tolerations for the taints on your nodes. For example, if your node has the taint `key=value:NoSchedule`, your pod spec must include the following: 

    ```yml
    tolerations:
      - key: "key"
        operator: "Equal"
        value: "value"
        effect: "NoSchedule"
    ```

   If the taint isn't needed, remove it from the node.
    
    ```bash
    kubectl taint nodes <node-name> <key>:<effect>-  
    ```

1. Redeploy or monitor the pod status.

    ```bash
    kubectl get pods -o wide  
    ```

## References

- [Kubernetes: Use Azure Disks with Azure Kubernetes Service](/azure/aks/azure-disks-dynamic-pv)
- [Kubernetes: Use node taints](/azure/aks/use-node-taints)
- [Kubernetes Documentation: Insufficient CPU](https://kubernetes.io/docs/concepts/scheduling-eviction/resource-bin-packing/#insufficient-resource)
- [Kubernetes Documentation: Assign and Schedule Pods with Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]