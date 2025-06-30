---
title: Troubleshoot Pod scheduler Errors in AKS
description: Explains common scheduling errors, their causes, and how to resolve them.
ms.date: 06/30/2025
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---

# Troubleshoot pod scheduler errors in AKS

When you deploy workloads in Azure Kubernetes Service (AKS), you might encounter scheduling errors that prevent Pods from running. This article explains common scheduling errors, their causes, and how to resolve them.

## Error: 0/(X) nodes are available: X node(s) had volume node affinity conflict

Pods remain in the Pending state with the scheduler message:

>0/(X) nodes are available: X node(s) had volume node affinity conflict.

### Cause

Persistent Volumes can define nodeAffinity rules that restrict which nodes can access the volume. If no node matches these rules, the Pod can't be scheduled.

### Solution

1. Review the node affinity set on your Persistent Volume resource:

    ```bash
     kubectl get pv <pv-name> -o yaml 
    ```
2. Check node labels in the cluster:

    ```bash
    kubectl get nodes --show-labels
    ```
3. Align node affinity with node labels by ensuring at least one node has labels that match the PV's nodeAffinity.
4. Update the PV or node labels:

    ```bash
    kubectl label nodes <node-name> <key>=<value>
    ```
    Or, modify the PV's affinity rules to match existing node labels.
5. After resolving the conflict, monitor the Pod status or retry the deployment.


## Error: 0/(X) nodes are available: X Insufficient CPU

Pods remain in the Pending state with the scheduler message:

>Error: 0/(X) nodes are available: X Insufficient CPU.

### Cause

This issue occurs when one or more of the following conditions are met:

- All node resources are in use.
- Pod's CPU request exceeds available capacity.
- The node pools lack sufficient resources or have incorrect configuration settings.

### Solution

1. Check resource usage and Pod requirements:

    ```bash
    kubectl describe pod <pod-name>
    kubectl describe nodes
    ```
2. Scale the node pool:

    ```bash
    
    az aks nodepool scale \
      --resource-group <resource-group> \
      --cluster-name <aks-name> \
      --name <nodepool-name> \
      --node-count <desired-node-count>
    ```
3. Optimize Pod resource requests. Make sure that  CPU requests and limits are appropriate for your node sizes.
4. Review taints and affinity rules. Check if other scheduling constraints are preventing placement.

## Error: 0/(X) nodes are available: X node(s) had untolerated taint

Pods remain in the Pending state with the scheduler message:

>Error: 0/(X) nodes are available: X node(s) had untolerated taint.

### Cause

The Kubernetes scheduler tries to assign the Pod to a node, but all nodes are rejected for one of the following reasons:

- The node has a taint (`key=value:effect`) that the Pod doesn't tolerate.

- The node has other taint-based restrictions that prevent the Pod from being scheduled.

### Solution

1. Check node taints:
    ```bash
     kubectl get nodes -o json | jq '.items[].spec.taints'   
    ```
2. Add necessary tolerations to Pod spec. Edit your deployment or Pod YAML to include matching tolerations for the taints on your nodes. For example, if your node has the taint key=value:NoSchedule, your Pod spec must include: 

    ```yml
    tolerations:
    
    - key: "key"
    
      operator: "Equal"
    
      value: "value"
    
      effect: "NoSchedule"
    ```
3. If the taint isn't needed, you can remove it from the node:
    
    ```bash
    kubectl taint nodes <node-name> <key>:<effect>-  
    ```
4. Redeploy or monitor the Pod status:

    ```bash
    kubectl get pods -o wide  
    ```
