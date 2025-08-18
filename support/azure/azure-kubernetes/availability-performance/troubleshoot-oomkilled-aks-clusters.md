--- 
title: Troubleshoot OOMkilled in AKS clusters
description: Troubleshoot and resolve out-of-memory (OOMkilled) issues in Azure Kubernetes Service (AKS) clusters.
ms.date: 08/18/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshooting OOMKilled in AKS clusters

## Understanding OOM Kills

When you run workloads in Azure Kubernetes Service (AKS), you might
encounter out of memory errors that cause restarts on your system or
application pods. This guide helps identify and resolve out-of-memory
(OOMKilled) issues in AKS cluster nodes.

> [!IMPORTANT]
> Use the [AKS Diagnose and Solve
> Problems](/azure/aks/aks-diagnostics#open-aks-diagnose-and-solve-problems)
> section in the Azure portal to help address with memory issues in your
> cluster.

### OOMKilled and Evictions Explained

In Kubernetes environments like AKS, memory-related issues can result in
two distinct types of events: **OOMKilled** and **Evictions**. While
both are triggered by resource pressure, they differ in cause, scope,
and behavior.

OOMKilled will only be reported for containers that have been terminated
by the kernel OOM killer. It\'s important to note that it\'s the
container that exceeds its memory limit that gets terminated, and by
default restarted, as opposed to the whole pod. Evictions on the other
hand happen at the pod level and are triggered by Kubernetes,
specifically by the **Kubelet** running on every node, when the node is
running low on memory. Pods that have been evicted will report a status
of **Failed** and a reason of **Evicted**.

### OOMKilled: Container-Level Termination

**OOMKilled** occurs when a **container** exceeds its memory limit and
is terminated by the **Linux kernel's Out-Of-Memory (OOM) killer**.

This is a container-specific event. Only the container that breaches its memory limit is affected. The pod may continue running if it contains other healthy containers. The terminated container is typically restarted automatically.

Common indicators include **exit code 137** and the reason **OOMKilled**
in `kubectl describe pod`.

### Evictions: Pod-Level Removal by Kubelet

While this guide focuses on **OOMKilled**, it is useful to understand
that **Evictions** are a separate mechanism in Kubernetes. They occur at
the **pod level**, for instance when the [node is under memory
pressure](./identify-memory-saturation-aks.md).

> [!NOTE]
> This guide does not cover all probable causes of pod eviction, as its scope is
> limited to memory-related OOMKilled events.

- The **Kubelet** may evict pods to free up memory and maintain node stability.

- Evicted pods will show a status of **Failed** and a reason of **Evicted**.

- Unlike OOMKilled, which targets individual containers, evictions affect the entire pod.

## Possible Causes of OOM Kills

OOMKilled events may occur due to several reasons. The following are the most common causes:

- **Resource Overcommitment**: Pod resource requests and limits are not set appropriately, leading to excessive memory usage.

- **Memory Leaks**: Applications may have memory leaks that cause them to consume more memory over time.

- **High Workload**: Sudden spikes in application load can lead to increased memory usage beyond allocated limits.

- **Insufficient Node Resources**: The node may not have enough memory to support the running pods, leading to OOM kills.

- **Inefficient Resource Management**: Lack of resource quotas and limits can lead to uncontrolled resource consumption.

## Identifying OOM Killed Pods

You can use one of these various methods to identify the POD which is killed due to memory pressure:

> [!NOTE]
> OOMKilled can happen to both **system pods (those in the kube-system
> namespace created by AKS)** and **user pods (pods in other namespaces)**. It is
> essential to first identify which pods are affected before taking further action.
> [!IMPORTANT]
> Use the [AKS Diagnose and Solve
> Problems](/azure/aks/aks-diagnostics#open-aks-diagnose-and-solve-problems)
> section in the Azure portal to help address with memory issues in your cluster.

### Check Pod Status

Use the following command to check the status of all pods in a namespace:

- `kubectl get pods -n <namespace>`

Look for pods with statuses of OOMKilled.

### Describe the Pod

Use `kubectl describe pod <pod-name>` to get detailed information about the pod.

- `kubectl describe pod <pod-name> -n <namespace>`

In the output, check the Container Statuses section for indications of OOM kills.

### Pod Logs

Review pod logs using `kubectl logs <pod-name>` to identify memory-related issues.

To view the logs of the pod, use:

- `kubectl logs <pod-name> -n <namespace>`

If the pod has restarted, check the previous logs:

- `kubectl logs <pod-name> -n <namespace> --previous`

### Node Logs

You can [review the kubelet logs](/azure/aks/kubelet-logs) on the node to see if there are messages indicating that the OOM killer was triggered at the time of the issue and that pod's memory usage reached its limit.

Alternatively, you can [SSH into the node](/azure/aks/node-access) where the pod was running and check the kernel logs for any OOM messages. This command will display which processes the OOM killer terminated:

`chroot /host # access the node session`

`grep -i "Memory cgroup out of memory" /var/log/syslog`

### Events

- Use `kubectl get events --sort-by=.lastTimestamp -n <namespace>` to find OOMKilled pods.

- Use the events section from the pod description to look for OOM-related messages:

  - `kubectl describe pod <pod-name> -n <namespace>`

## Handling OOMKilled for system pods

> [!NOTE]
> System pods refer to those located in the kube-system namespace and created by AKS.

### metrics-server

**Issue:**

- OOMKilled due to insufficient resources.

**Solution:**

- [Configure Metrics Server VPA](/azure/aks/use-metrics-server-vertical-pod-autoscaler)
can be used to allocate additional resources to the Metrics Server.

### CoreDNS

**Issue:**

- OOMKilled due to traffic spikes.

**Solution:**

- [Customize CoreDNS scaling](/azure/aks/coredns-custom) to properly configure its auto-scaling based on the workload requirements.

### Other pods in the kube-system namespace

Make sure that the cluster includes a [system node pool](/azure/aks/use-system-pools?tabs=azure-cli) and a user node pool to isolate memory-heavy user workloads from system
pods. You should also confirm that the system node pool has at least three nodes.

## Handling OOMKilled for User pods

User pods may be OOMKilled due to insufficient memory limits or excessive memory consumption. Solutions include setting appropriate resource requests and limits, and engaging application vendors to investigate memory usage.

### Cause 1: User workloads may be running in a system node pools

It is recommended to create user node pools for user workloads. For more information, see: [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools).

### Cause 2: Application pod keeps restarting due to OOMkilled

This behavior might be due to the pod not having enough memory assigned
to it and it requires more, which will cause the pod to constantly
restart.

To solve, review request and limits documentation to understand how to modify
your deployment accordingly. For more information, see [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits).

`kubectl set resources deployment <deployment-name>
--limits=memory=<LIMITS>Mi ---requests=memory=<MEMORY>Mi`

Setting resource requests and limits to the recommended amount for the
application pod.

To diagnose, see [Azure Kubernetes Service (AKS) Diagnose and Solve Problems
overview](/azure/aks/aks-diagnostics).

### Cause 3: Application running in pod is consuming excessive memory

Confirm the Memory Pressure at the pod level:

Use kubectl top to check memory usage:

`kubectl top pod <pod-name> -n <namespace>`

If metrics are unavailable, you can inspect cgroup stats directly:

`kubectl exec -it <pod-name> -n <namespace> -- cat /sys/fs/cgroup/memory.current`

Or you can use this to see the value in MB:

`kubectl exec -it <pod-name> -n <namespace> -- cat /sys/fs/cgroup/memory.current | awk '{print $1/1024/1024 " MB"}'`

This helps to confirm whether the pod is approaching or exceeding its
memory limits.

- Check for OOMKilled Events

`kubectl get events --sort-by='.lastTimestamp' -n <namespace>`

To resolve, engage the application vendor. If the app is from a third party, check
if they have known issues or memory tuning guides. Also, depending on the application framework, ask the vendor to verify whether they are using the latest version of Java or .Net as recommended in [Memory saturation occurs in pods after cluster upgrade to Kubernetes 1.25](../create-upgrade-delete/aks-memory-saturation-after-upgrade.md).

The application vendor or team can investigate the application to determine why it is using so much memory, such as checking for a memory leak or assessing if the app needs higher memory resource limits in the pod configuration. In the meantime, to temporarily mitigate the problem increase the memory limit for the containers experiencing OOMKill events.

## Avoiding OOMKill in the future

### Validating and Setting resource limits

Review and set appropriate [resource requests and limits](/azure/aks/developer-best-practices-resource-management#define-pod-resource-requests-and-limits)
for all application pods. Use `kubectl top` and `cgroup` stats to validate memory usage.

### Setting up system and user node pools

Make sure the cluster includes a [system node pool](/azure/aks/use-system-pools?tabs=azure-cli) and a user node pool to isolate memory-heavy user workloads from system
pods. You should also confirm that the system node pool has at least three nodes.

### Application assessment

To ensure optimal performance and avoid memory starvation within your AKS cluster, we recommend reviewing the resource usage patterns of your application. Specifically, assess whether the application is requesting appropriate memory limits and whether its behavior under load aligns with the allocated resources. This evaluation will help identify if adjustments are needed to prevent pod evictions or OOMKilled events.
