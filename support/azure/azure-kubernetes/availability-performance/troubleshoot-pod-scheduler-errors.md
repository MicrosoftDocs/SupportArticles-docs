---
title: Troubleshoot Pod scheduler Errors in Azure Kubernetes Service
description: Explains common scheduler errors, their causes, and how to resolve them.
ms.date: 06/30/2025
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---

# Troubleshoot pod scheduler errors in Azure Kubernetes Service

When you deploy workloads in Azure Kubernetes Service (AKS), you might encounter scheduler errors that prevent Pods from running. This article provides solutions to common scheduler errors.

## Error: 0/(X) nodes are available: Y node(s) had volume node affinity conflict

> [!NOTE]
>  X and Y represent the number of nodes. These values depend on your cluster configuration.
 
Pods remain in the Pending state with the following scheduler error:

>0/(X) nodes are available: Y node(s) had volume node affinity conflict.

### Cause

[Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#node-affinity) define `nodeAffinity` rules that restrict which nodes can access the volume. If none of the available nodes satisfy the volume's affinity rules, the scheduler cannot assign the Pod to any node.

### Solution

1. Review the node affinity set on your Persistent Volume resource:

    ```bash
     kubectl get pv <pv-name> -o yaml 
    ```
2. Check node labels in the cluster:

    ```bash
    kubectl get nodes --show-labels
    ```
3. Make sure that at least one node's labels match the `nodeAffinity` specified in the Persistent Volume's YAML spec.
4. To resolve the conflict, Update the Persistent Volume's `nodeAffinity` rules to match existing node labels or add the required labels to the correct node:

    ```bash
    kubectl label nodes <node-name> <key>=<value>
    ```
    Or, modify the PV's affinity rules to match existing node labels.
5. After resolving the conflict, monitor the Pod status or retry the deployment.


## Error: 0/(X) nodes are available: Insufficient CPU

Pods remain in the Pending state with the scheduler error:

>Error: 0/(X) nodes are available: Insufficient CPU.

### Cause

This issue occurs when one or more of the following conditions are met:

- All node resources are in use.
- The pending Pod's resource requests exceed available CPU on the nodes.
- The node pools lack sufficient resources or have incorrect configuration settings.

### Solution

1. Review CPU usage on all nodes and verify if there is enough unallocated CPU to meet the pod's request.

    ```bash
    kubectl describe pod <pod-name>
    kubectl describe nodes
    ```
2. If no node has enough CPU, increase the number of nodes or use larger VM sizes in the node pool：

    ```bash
    
    az aks nodepool scale \
      --resource-group <resource-group> \
      --cluster-name <aks-name> \
      --name <nodepool-name> \
      --node-count <desired-node-count>
    ```
3. Optimize Pod resource requests. Make sure that CPU requests and limits are appropriate for your node sizes.
4. Verify if any scheduling constraints are restricting pod placement across available nodes.

## Error: 0/(X) nodes are available: Y node(s) had untolerated taint

Pods remain in the Pending state with the error:

>Error: 0/(X) nodes are available: Y node(s) had untolerated taint.

### Cause

The Kubernetes scheduler tries to assign the Pod to a node, but all nodes are rejected for one of the following reasons:

- The node has a taint (`key=value:effect`) that the Pod doesn't tolerate.

- The node has other taint-based restrictions that prevent the Pod from being scheduled.

### Solution

1. Check node taints:
    ```bash
     kubectl get nodes -o json | jq '.items[].spec.taints'   
    ```
2. Add necessary tolerations to Pod spec: Edit your deployment or Pod YAML to include matching tolerations for the taints on your nodes. For example, if your node has the taint key=value:NoSchedule, your Pod spec must include: 

    ```yml
    tolerations:
      - key: "key"
        operator: "Equal"
        value: "value"
        effect: "NoSchedule"
    ```
   If the taint isn't needed, you can remove it from the node:
    
    ```bash
    kubectl taint nodes <node-name> <key>:<effect>-  
    ```
4. Redeploy or monitor the Pod status:

    ```bash
    kubectl get pods -o wide  
    ```
## Reference

- [Kubernetes: Use Azure Disks with Azure Kubernetes Service](/azure/aks/azure-disks-dynamic-pv)
- [Kubernetes: Use node taints](/azure/aks/use-node-taints)
- [Kubernetes Documentation: Insufficient CPU](https://kubernetes.io/docs/concepts/scheduling-eviction/resource-bin-packing/#insufficient-resource)
- [Kubernetes Documentation: Assign and Schedule Pods with Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
