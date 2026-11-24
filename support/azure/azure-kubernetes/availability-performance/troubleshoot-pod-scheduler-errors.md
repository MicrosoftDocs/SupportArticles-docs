---
title: Troubleshoot AKS pod scheduler errors
description: Learn how to troubleshoot AKS pod scheduler errors, understand common causes, and apply proven fixes to get pods running. Start resolving issues now.
ms.date: 11/24/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: ping.he, zhixinsun, kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
ai-usage: ai-assisted
---
# Troubleshoot pod scheduler errors in Azure Kubernetes Service

## Summary

This article helps you troubleshoot pod scheduler errors in Azure Kubernetes Service (AKS). It describes common errors, their causes, and solutions that get your pending pods running.

When you deploy workloads in AKS, you might encounter scheduler errors that prevent pods from running. The following sections describe common errors, their causes, and how to resolve them.

## Error: 0/(X) nodes are available: Y nodes had volume node affinity conflict

> [!NOTE]
>  X and Y represent the number of nodes. These values depend on your cluster configuration.
 
Pods remain in the **Pending** state with the following scheduler error message.

>0/(X) nodes are available: Y nodes had volume node affinity conflict.

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

## Error: 0/(X) nodes are available: Insufficient memory

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y Insufficient memory.

### Cause

The pod's effective memory request exceeds the remaining allocatable request budget on eligible nodes. 

### Solution

Follow these steps to resolve the insufficient memory issue:

1. Inspect the admitted memory requests and node accounting.

    ```bash
    kubectl describe pod <pod-name>
    kubectl describe node <eligible-node>
    ```
    
1. Right-size requests based on the application's needs, free legitimately reserved capacity, or provide an eligible node large enough for the pod.

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
    
## Error: 0/(X) nodes are available: Insufficient ephemeral-storage

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y Insufficient ephemeral-storage.

### Cause

The pod requests more local ephemeral storage than eligible nodes can allocate after other requests. This resource is separate from a PVC or Azure Disk's requested size.

This scheduler rejection differs from a pod that was scheduled and later evicted because of local-storage pressure. Memory-backed `emptyDir` volumes consume memory rather than this local-storage budget.

### Solution

Follow these steps to resolve the insufficient ephemeral-storage issue:

1. Inspect requests, node allocatable storage, and allocated resources:

    ```bash
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl describe node <eligible-node>
    ```

1. Correct erroneous units or an unrealistic request. Size the request for the workload's writable layer, disk-backed `emptyDir`, logs, and other applicable local storage.
1. If the request is legitimate, provide suitable eligible node storage or capacity. Increasing a PVC's size doesn't increase node ephemeral storage.
1. If events instead show eviction or `DiskPressure`, investigate consumption and the node condition rather than treating it as this request-fit error.

## Error: 0/(X) nodes are available: Insufficient nvidia.com/gpu

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y Insufficient nvidia.com/gpu.

### Cause

Eligible nodes can't satisfy the pod's advertised `nvidia.com/gpu` request. Possible conditions include:

- No suitable GPU node is available.
- GPU requests from other pods reserve the exposed devices.
- A GPU VM exists, but the supported driver or device-plugin configuration isn't healthy or doesn't expose the expected resource.
- Taints, selectors, or affinity exclude otherwise usable GPU nodes.

A mixed rejection message doesn't establish which of these conditions caused a specific report.

### Solution

Follow these steps to resolve the insufficient GPU issue:

1. Inspect the live GPU request and node resource advertisement:

    ```bash
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl describe node <gpu-node>
    kubectl get daemonsets,pods -n kube-system -o wide
    ```

1. Distinguish absent allocatable GPU resources from resources already reserved by requests. A GPU VM size or low observed GPU utilization alone isn't sufficient.
1. Verify the GPU pool's supported configuration and driver/device-plugin health. Follow [managed AKS GPU guidance](/azure/aks/aks-managed-gpu-nodes); don't install a second device plugin indiscriminately into a managed configuration.
1. For genuine capacity shortage, make an eligible GPU node available and inspect scale-up events, SKU restrictions, quota, and allocation failures. The [official AKS/KEDA example](/azure/aks/autoscale-gpu-workloads-with-keda) documents this scheduling error as a capacity signal.
1. Correct compatible placement/tolerations where necessary. Don't send an application to system nodes merely to bypass `CriticalAddonsOnly`.
1. Verify both scheduling and GPU functionality. Removing the GPU request isn't a validated remedy for a GPU-dependent application.

## Error: 0/(X) nodes are available: Node selector, affinity, or anti-affinity rules

Pods remain in the **Pending** state with one of the following scheduler errors.

>Error: 0/(X) nodes are available: Y nodes didn't match Pod's node affinity or selector.
>
>Error: 0/(X) nodes are available: Y nodes didn't match pod affinity rules.
>
>Error: 0/(X) nodes are available: Y nodes didn't match pod anti-affinity rules.
>
>Error: 0/(X) nodes are available: Y nodes didn't satisfy existing pods anti-affinity rules.

### Cause

A required placement rule excludes the candidate nodes. The rule can apply to node labels or to the location of other pods:

- **Node selector/node affinity:** Node labels don't satisfy the pod's `nodeSelector` or required node affinity. If you configure both, the node labels must satisfy both. All selector labels must match. Required affinity terms are alternatives, while expressions within a term must all match.
- **Pod affinity:** No matching pod is found in the required namespace and topology domain.
- **Pod anti-affinity:** The incoming pod excludes domains occupied by matching pods, or an existing pod's rule excludes the incoming pod from its domain. An existing pod's rule can reject the incoming pod even if the incoming pod has no anti-affinity. 

Preferred affinity rules alone don't cause these hard rejections. For self-affinity, a pod that matches its own selector can schedule without an peer when the other first-pod exception conditions are met.

### Solution

Follow these steps to resolve the placement rule mismatch:

1. Inspect the live pod's selectors and affinity rules, and compare them with node labels:

    ```bash
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl get nodes --show-labels
    ```

1. For pod affinity or anti-affinity, inspect pods in the relevant namespaces and topology domains. Check label selectors, namespace scope, and `topologyKey`. For anti-affinity, also inspect existing pods' rules:

    ```bash
    kubectl get pods -A -o wide
    kubectl get pod <existing-pod-name> -n <existing-pod-namespace> -o yaml
    ```

1. Apply the fix for the affected rule:

    **Node selector/node affinity:** Correct mistaken or stale selector or label values, or provide nodes that meet the requirement.

    **Pod affinity:** Restore the intended matching pod or correct the selector, namespace, or topology key. The matching pod must be in a domain the incoming pod can also use.

    **Pod anti-affinity:** Make another genuine topology domain eligible by adding suitable nodes or correcting an overly restrictive node selector. Keep all applicable required anti-affinity exclusions satisfied.

1. Make workload changes through the controller's pod template. Correct unintended rules or label matches, and relax required rules only when hardware, security, and availability requirements permit it. Don't falsify hardware or topology labels, delete unrelated production peers as a routine fix, or use `spec.nodeName` to bypass scheduling.
1. Confirm the pending or replacement pod schedules on an eligible node in a permitted topology domain. Recheck current events and verify that both incoming and existing pods' required policies are satisfied.


## Error: 0/(X) nodes are available: Y nodes didn't match pod topology spread constraints

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y nodes didn't match pod topology spread constraints.

### Cause

A hard spread constraint (`whenUnsatisfiable: DoNotSchedule`) can't place the pod without exceeding `maxSkew`. Eligible domains depend on topology labels, selectors or affinity, and the configured node inclusion policies.  

When there are fewer eligible domains than `minDomains`, the global minimum becomes zero. A cluster can have several nodes but only one eligible domain for a particular pod.

### Solution

Follow these steps to resolve the topology spread constraint issue:

1. Inspect the constraint, selected replicas, and node labels:

    ```bash
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl get pods -n <namespace> -l <spread-selector> -o wide
    kubectl get nodes --show-labels
    ```

   - Check `topologyKey`, `labelSelector`, `maxSkew`, `minDomains`, `nodeAffinityPolicy`, and `nodeTaintsPolicy`. Restore sufficient genuinely eligible domains or correct an unintended restriction.
1. Change skew or domain requirements only after assessing availability intent. `ScheduleAnyway` makes the policy soft; successful placement after that change doesn't prove the original hard requirement is met.
1. Verify the resulting distribution.

## Error: 0/(X) nodes are available: Y Too many pods

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y Too many pods.

### Cause

Eligible nodes reached the scheduler's pod-count limit. Available CPU or memory doesn't override node allocatable `pods` or node pool `maxPods`.

### Solution

Follow these steps to resolve the pod-count limit issue:

1. Check the limit and assigned pods.

    ```bash
    kubectl describe node <eligible-node>
    kubectl get pods -A --field-selector spec.nodeName=<eligible-node> -o wide
    ```

1. Account for system DaemonSets and other workloads, not only the application's replicas.
1. Release capacity by removing only legitimately obsolete workloads, or add eligible nodes. If changing `maxPods` requires a new pool, plan that change with the supported AKS networking/IP limits.
1. Confirm the pending pod schedules after a slot becomes available. Don't patch node capacity to fabricate slots.

## Error: 0/(X) nodes are available: Y nodes were unschedulable

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y nodes were unschedulable.

### Cause

All eligible nodes are cordoned (`spec.unschedulable: true`) or otherwise excluded by the corresponding scheduling condition. This condition can be intentional during maintenance.

A condition-related untolerated-taint message can also mention `node.kubernetes.io/unschedulable`.

### Solution

Follow these steps to resolve the unschedulable node issue:

1. Inspect the node and maintenance context.

    ```bash
    kubectl get node <node-name> -o yaml
    kubectl describe pod <pod-name> -n <namespace>
    ```

1. If maintenance is complete and the node is safe to use, uncordon that specific node.

    ```bash
    kubectl uncordon <node-name>
    ```

1. Otherwise, provide another eligible node or wait for authorized maintenance to complete. Don't globally uncordon nodes or add a blanket toleration to bypass maintenance.
1. Confirm node state and pod scheduling.

## Error: 0/(X) nodes are available: pod has unbound immediate PersistentVolumeClaims

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: pod has unbound immediate PersistentVolumeClaims.

### Cause

A claim that must bind before scheduling is still unbound. Possible causes include an incorrect or unavailable provisioner, provisioning or authorization failures, missing storage capacity, incompatible volume matching, or storage topology.

A pending `WaitForFirstConsumer` claim alone isn't this error.

### Solution

Follow these steps to resolve the unbound immediate PersistentVolumeClaim issue:

1. Inspect the claim's events and class.

    ```bash
    kubectl describe pvc <pvc-name> -n <namespace>
    kubectl get pvc <pvc-name> -n <namespace> -o yaml
    kubectl get storageclass <storageclass-name> -o yaml
    ```

1. Verify the provisioner is available and inspect its controllers and events. Resolve the actual authorization, SKU, capacity, or binding error rather than scaling CPU nodes blindly.
1. For new topology-aware Azure Disk claims, choose an appropriate working class by using `WaitForFirstConsumer`.
1. Preserve existing data and reclaim-policy semantics. Before replacing an unbound claim, verify that it has no data to preserve and that replacement is appropriate. Don't delete production claims as a generic binding remedy.
1. Confirm binding, pod scheduling, successful mounting, and a real data-access check.

## Error: 0/(X) nodes are available: Y nodes exceed max volume count

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y nodes exceed max volume count.

### Cause

The pod's distinct CSI volumes, together with volumes already needed on the node, exceed the driver's advertised per-node attachment count. This condition isn't a disk-size limit or a CPU shortage.

### Solution

Follow these steps to resolve the maximum volume count issue:

1. Inspect the real driver limit and claims:

    ```bash
    kubectl get csinode <eligible-node> -o yaml
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl get pvc -n <namespace>
    ```

1. For Azure Disks, examine `disk.csi.azure.com` under `CSINode.spec.drivers`, including `allocatable.count`. Compare volume demand from this and other assigned pods.
1. Place the workload on an eligible node size with sufficient real attachment capacity, distribute workloads appropriately, or use a storage design suitable for the required volume count.
1. Keep storage topology and access modes compatible. Fewer GiB per disk don't reduce the number of attachments.
1. Confirm every required volume mounts and supports real data access. Don't patch CSI limits or fabricate volume handles. See [Azure Disk per-node volume guidance](/azure/aks/azure-disks-dynamic-pv).

## Error: 0/(X) nodes are available: Y nodes didn't have free ports for the requested pod ports

Pods remain in the **Pending** state with the following scheduler error.

>Error: 0/(X) nodes are available: Y nodes didn't have free ports for the requested pod ports.

### Cause

Another assigned pod reserves an overlapping `hostPort` on eligible nodes. The scheduler checks requested host IP, protocol, and port; a CPU-capacity increase on the same node doesn't release that reservation.

This error isn't a Service `NodePort` allocation error. A host process causing a bind failure after placement is also a different diagnostic path.

### Solution

Follow these steps to resolve the unavailable host-port issue:

1. Inspect declared ports and assigned pods.

    ```bash
    kubectl get pod <pod-name> -n <namespace> -o yaml
    kubectl get pods -A --field-selector spec.nodeName=<eligible-node> -o yaml
    ```

1. Release only an obsolete authorized reservation, choose a nonconflicting port, or provide another eligible node.
1. If the workload doesn't need direct host-port binding, use an appropriate Service design instead.
1. Confirm scheduling and the application's intended network behavior. Successful scheduling alone doesn't confirm that an application is listening.

## References

- [Kubernetes: Use Azure Disks with Azure Kubernetes Service](/azure/aks/azure-disks-dynamic-pv)
- [Kubernetes: Use node taints](/azure/aks/use-node-taints)
- [Kubernetes Documentation: Insufficient CPU](https://kubernetes.io/docs/concepts/scheduling-eviction/resource-bin-packing/#insufficient-resource)
- [Managed AKS GPU node guidance](/azure/aks/aks-managed-gpu-nodes)
- [AKS GPU autoscaling example](/azure/aks/autoscale-gpu-workloads-with-keda)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
