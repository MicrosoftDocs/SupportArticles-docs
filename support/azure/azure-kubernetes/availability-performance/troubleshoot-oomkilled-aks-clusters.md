--- 
title: Troubleshoot OOMKilled errors in AKS clusters
description: Troubleshoot OOMKilled issues in AKS clusters and resolve memory-related pod restarts fast. Use this guide to identify causes and fix them.
ms.date: 10/27/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
ai-usage: ai-assisted
---
# Troubleshoot OOMKilled errors in Azure Kubernetes Service clusters

## Summary

This article helps you troubleshoot OOMKilled errors in Azure Kubernetes Service (AKS) clusters. Identify the root causes and apply solutions to prevent memory-related pod restarts.

When you run workloads in Azure Kubernetes Service (AKS), you might encounter out of memory errors that cause restarts on your system or
application pods. This guide helps you identify and resolve out-of-memory (*OOMKilled*) issues in AKS cluster nodes.

> [!IMPORTANT]
> Use the [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics#open-aks-diagnose-and-solve-problems) section in the [Azure portal](https://portal.azure.com) to help address memory issues in your cluster.

## OOMKilled and evictions explained

In Kubernetes environments like AKS, memory-related issues can result in two distinct types of events: **OOMKilled** and **Evictions**. While
both are triggered by resource pressure, they differ in cause, scope, and behavior.

OOMKilled is only reported for containers that have been terminated. It's important to note that it's the container that exceeds its memory limit that gets terminated, and by default restarted, as opposed to the whole pod. 

Evictions happen at the pod level and are triggered by Kubernetes, specifically by the Kubelet running on every node, when the node is running low on memory. Pods that are evicted report a status of **Failed** and a reason of **Evicted**.

### OOMKilled: Container-level termination

**OOMKilled** errors occur when a container exceeds its memory limit and is terminated by the Linux kernel's Out-Of-Memory (OOM) killer.

This event affects only the container that breaches its memory limit. The pod might continue running if it contains other healthy containers. The terminated container is typically restarted automatically.

Common indicators include **exit code 137** and the reason OOMKilled occurred in `kubectl describe pod`.

### Evictions: Pod-level removal by Kubelet

While this guide focuses on OOMKilled errors, it's useful to understand that Evictions are a separate mechanism in Kubernetes. They occur at
the pod level, like when the [node is under memory pressure](./identify-memory-saturation-aks.md).

> [!NOTE]
> This guide doesn't cover all probable causes of pod eviction, as its scope is limited to memory-related OOMKilled events.

The following points summarize key aspects of pod evictions due to memory pressure:

- The Kubelet might evict pods to free up memory and maintain node stability.
- Evicted pods show a status of **Failed** and a reason of **Evicted**.
- Unlike OOMKilled errors which target individual containers, evictions affect the entire pod.

## Possible causes of OOMKilled events

Several conditions can cause OOMKilled events. The most common causes include the following conditions:

- **Resource overcommitment** - You don't set pod resource requests and limits appropriately, which leads to excessive memory usage.
- **Memory leaks** - Applications have memory leaks that cause them to consume more memory over time.
- **High workload** - Sudden spikes in application load lead to increased memory usage beyond allocated limits.
- **Insufficient node resources** - The node doesn't have enough memory to support the running pods.
- **Inefficient resource management** - Lack of resource quotas and limits lead to uncontrolled resource consumption.

## Identifying OOMKilled pods

Use the following methods to identify the pod that Kubernetes killed due to memory pressure.

> [!NOTE]
> The OOMKilled status can happen to both system pods (those in the `kube-system` namespace created by AKS) and user pods (pods in other namespaces). It's essential to first identify which pods are affected before taking further action.
>
> [!IMPORTANT]
> Use the [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics#open-aks-diagnose-and-solve-problems) section in the Azure portal to help address memory problems in your cluster.

### Check pod status

Use the following command to check the status of all pods in a namespace.

- `kubectl get pods -n <namespace>`

Look for pods with statuses of `OOMKilled`.

### Describe the pod

Use `kubectl describe pod <pod-name>` to get detailed information about the pod.

- `kubectl describe pod <pod-name> -n <namespace>`

In the output, check the **Container Statuses** section for indications of OOMKilled events.

### Pod logs

Review pod logs by using `kubectl logs <pod-name>` to identify memory-related issues.

To view the logs of the pod, use the following command.

- `kubectl logs <pod-name> -n <namespace>`

If the pod restarts, check the previous logs.

- `kubectl logs <pod-name> -n <namespace> --previous`

### Node logs

[Review the kubelet logs](/azure/aks/kubelet-logs) on the node to see if any messages indicate that the OOMKilled event triggered at the time of the issue and that the pod's memory usage reached its limit.

Alternatively, [SSH into the node](/azure/aks/node-access) where the pod was running and check the kernel logs for any OOM messages. This command displays which processes the OOMKilled event terminated.

`chroot /host # access the node session`

`grep -i "Memory cgroup out of memory" /var/log/syslog`

### Events

The following commands help you identify OOMKilled events in your cluster.

- Use `kubectl get events --sort-by=.lastTimestamp -n <namespace>` to find OOMKilled pods.
- Use the events section from the pod description to look for OOM-related messages:
  - `kubectl describe pod <pod-name> -n <namespace>`

## Handling OOMKilled for system pods

The following sections describe how to handle OOMKilled events for system pods in the `kube-system` namespace.

> [!NOTE]
> System pods are those located in the `kube-system` namespace and created by AKS.

### Metrics-server

**Issue** - OOMKilled event happens due to insufficient resources.

**Solution** - [Configure Metrics Server VPA](/azure/aks/use-metrics-server-vertical-pod-autoscaler)
to allocate extra resources to the Metrics Server.

### CoreDNS

**Issue** - OOMKilled event occurs due to traffic spikes.

**Solution** - [Customize CoreDNS scaling](/azure/aks/coredns-custom) to properly configure its auto-scaling based on the workload requirements.

### Other pods in the kube-system namespace

Ensure that the cluster includes a [system node pool](/azure/aks/use-system-pools?tabs=azure-cli) and a user node pool to isolate memory-heavy user workloads from system pods. Ensure that the system node pool is properly configured and confirm that it has at least three nodes.

## Handle OOMKilled events for user pods

User pods might experience OOMKilled events due to insufficient memory limits or excessive memory consumption. Solutions include setting appropriate resource requests and limits, and engaging application vendors to investigate memory usage.

### Cause 1: User workloads might be running in a system node pool

Create user node pools for user workloads. For more information, see [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools).

### Cause 2: Application pod keeps restarting due to OOMKilled event

This behavior occurs because the pod doesn't have enough memory assigned to it and needs more memory. The pod constantly restarts due to OOMKilled events. This condition happens because the pod is being terminated due to insufficient memory and it requires more memory, which causes the pod to constantly restart.

Set resource requests and limits to the recommended amount for the application pod in your deployment accordingly. For more information, see [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits).

The following command sets the memory requests and limits for the deployment.

`kubectl set resources deployment <deployment-name>
--limits=memory=<LIMITS>Mi ---requests=memory=<MEMORY>Mi`

Setting resource requests and limits to the recommended amount for the application pod.

To diagnose, see [Azure Kubernetes Service (AKS) Diagnose and Solve Problems Overview](/azure/aks/aks-diagnostics).

### Cause 3: Application running in pod is consuming excessive memory

Confirm the memory pressure at the pod level. Use `kubectl top` to check memory usage.

`kubectl top pod <pod-name> -n <namespace>`

If metrics are unavailable, you can inspect cgroup stats directly.

`kubectl exec -it <pod-name> -n <namespace> -- cat /sys/fs/cgroup/memory.current`

You can also use this command to see the value in MB.

`kubectl exec -it <pod-name> -n <namespace> -- cat /sys/fs/cgroup/memory.current | awk '{print $1/1024/1024 " MB"}'`

This information helps you confirm whether the pod is approaching or exceeding its memory limits.

### Check for OOMKilled events

Run the following command to check for OOMKilled events.

`kubectl get events --sort-by='.lastTimestamp' -n <namespace>`

To resolve this issue, contact the application vendor. If the app is from a third party, check if they have known issues or memory tuning guides. Depending on the application framework, ask the vendor to verify whether they're using the latest version of Java or .NET as recommended in [Memory saturation occurs in pods after cluster upgrade to Kubernetes 1.25](../create-upgrade-delete/aks-memory-saturation-after-upgrade.md).

The application vendor or team can investigate the application to determine why it's using so much memory. They might check for a memory leak or assess if the app needs higher memory resource limits in the pod configuration. In the meantime, to temporarily mitigate the problem, increase the memory limit for the containers experiencing OOMKill events.

## Avoid OOMKill events in the future

The following best practices can help you avoid OOMKill events in the future.

### Validate and set resource limits

Review and set appropriate [resource requests and limits](/azure/aks developer-best-practices-resource-management#define-pod-resource-requests-and-limits) for all application pods. Use `kubectl top` and `cgroup` stats to validate memory usage.

### Set up system and user node pools

Ensure the cluster includes a [system node pool](/azure/aks/use-system-pools?tabs=azure-cli) and a user node pool to isolate memory-heavy user workloads from system pods. Confirm that the system node pool has at least three nodes.

### Application assessment

To ensure optimal performance and avoid memory starvation within your AKS cluster, review the resource usage patterns of your application. Specifically, assess whether the application requests appropriate memory limits and whether its behavior under load aligns with the allocated resources. This evaluation helps identify if adjustments are needed to prevent pod evictions or OOMKilled events.
