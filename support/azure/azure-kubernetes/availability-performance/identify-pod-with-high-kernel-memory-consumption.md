---
title: Identify CPU saturation in AKS clusters
description: Identify and resolve issues causing excessive memory usage due to Linux kernel behavior in pods.
ms.date: 05/10/2025
ms.reviewer: claudiogodoy, 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot High Memory Consumption in Disk-Intensive Applications

Disk input and output operations are costly, and most operating systems implement `caching` strategies for reading and writing data to the filesystem. In the case of the [Linux Kernel](https://www.kernel.org/doc), it employs several strategies, such as the [Page Cache](https://www.kernel.org/doc/gorman/html/understand/understand013.html), whose primary goal is to store data read from the filesystem in `cache`, making it available in `memory` for future read operations.

This article helps you identify when some *Kernel behavior* leads to a high memory consumption pattern on a `pod`.

## Prerequisites

- The `Kubernetes` [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

The following table outlines the common symptoms of memory saturation.

| Symptom | Description |
|---|---|
| [Working_Set](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#memory) metric too high | When there is a lot difference between the `working_set` reported by the [Kubernetes metrics API](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#metrics-server) and the actual memory consumed by application. |
| Out-of-memory (OOM) kill | An OOM problem is a indicative that you `pod` is facing memory issues. |

## Step 1: Inspect pod Working Set

If you don't already know which `pod` is consuming much memory refer to the documentation: [https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/availability-performance/identify-memory-saturation-aks](https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/availability-performance/identify-memory-saturation-aks?tabs=browser).

The [kubectl top pods](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_top/) command shows the actual [Working_Set](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#memory) reported by the  [Kubernetes metrics API](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#metrics-server).

```console
$ kubectl top pods -A | grep -i "<DEPLOYMENT_NAME>"
NAME                            CPU(cores)   MEMORY(bytes)
my-deployment-fc94b7f98-m9z2l   1m           344Mi
```

## Step 2: Inspect pod memory statistics

We can inspect the memory statistics of the [cgroup](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html) of the `pod` by following the steps below.

- Connect to the `pod` using the [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/) command.
- Navigate to the directory of `cgroup` statistics.
- List all memory-related files:

```console
$ kubectl exec <POD_NAME> -it -- bash
$ ls /sys/fs/cgroup | grep -e memory.stat -e memory.current
memory.current memory.stat
```

- `memory.current`: The total amount of memory currently being used by the cgroup and its descendants.

- `memory.stat`: This breaks down the `cgroup’s` memory footprint into different types of memory, type-specific details, and other information on the state and past events of the memory management system.

All the values listed on those files are in `bytes`. Run the following step to get an overview of how the memory consumption is distributed on the `pod`:

```console
$ cat /sys/fs/cgroup/memory.current
10645012480
$ cat /sys/fs/cgroup/memory.stat
anon 5197824
inactive_anon 5152768
active_anon 8192
...
file 10256240640
active_file 32768
inactive_file 10256207872
...
slab 354682456
slab_reclaimable 354554400
slab_unreclaimable 128056
...
```

`cAdvisor` uses `memory.current` and `inactive_file` to compute the `working_set` metric. You can replicate the calculation using the following formula:

```sh
working_set = (memory.current - inactive_file) / 1048576
            = (10645012480 - 10256207872) / 1048576
            = 370 MB
```

## Step 3: Determine what is Kernel vs Application memory consumption

As mentioned in the title, this issue may occur in applications that perform frequent `filesystem operations`. Usually the `Kernel` uses strategies such as the [Page Cache](https://www.kernel.org/doc/gorman/html/understand/understand013.html) to improve the overall performance.

The following table describes some memory segments we saw earlier:

| Segment | Description |
|---|---|
| anon | Amount of memory used in anonymous mappings. **The majority languages use this segment to allocate memory** |
| file | Amount of memory used to cache filesystem data, including tmpfs and shared memory. |
| slab  | Amount of memory used for storing **in-kernel** data structures. |

The majority of languages use the `anon` memory segment to allocate resources. In this case the `anon` represents `5197824 bytes` which is not even close to the total amount reported by the `working_set` metric.

On the other hand we have one of the segments that `Kernel` uses the `slab` representing `354682456 bytes`, which is almost all the memory reported by `working_set` metric on this `pod`.

## Step 4: Run a node drop cache

> [!NOTE]
> The following steps may lead to availability and performance issues, do not run it on a production environment.

Get the `node` name by the `kubectl get pod` command:

```console
$ kubectl get pod -A -o wide | grep "POD_NAME"
NAME          READY   STATUS    RESTARTS   AGE   IP            NODE                                NOMINATED NODE   READINESS GATES
my-deployment-fc94b7f98-m9z2l   1/1     Running   0          37m   10.244.1.17   aks-agentpool-26052128-vmss000004   <none>           <none>
```

Create a debugger `pod` using the [kubectl debug](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/) command and create a `kubectl` session:

```console
kubectl debug node/<NODE_NAME> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0

chroot /host
```

Run the command to drop the `kernel cache`:

```console
echo 1 > /proc/sys/vm/drop_caches
```

To determine if the last command caused any effect go through the Steps 1 and 2 again:

```console
$ kubectl top pods -A | grep -i "<DEPLOYMENT_NAME>"
NAME                            CPU(cores)   MEMORY(bytes)
my-deployment-fc94b7f98-m9z2l   1m           4Mi

$ kubectl exec <POD_NAME> -it -- cat /sys/fs/cgroup/memory.stat
anon 4632576
file 1781760
...
slab_reclaimable 219312
slab_unreclaimable 173456
slab 392768
```

If you had the same effect of a huge decrease in both `working_set` and `slab` memory segment you are definitely experiencing the issue of a great amount of `pod's` memory being used by the `Kernel`.

## Resolution

The only effective workaround for high memory consumption in `Kubernetes` is to set realistic `resource limits and requests` on your `pods`. By configuring appropriate memory [limits and requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits) in the `Kubernetes` or specification, you can ensure that `Kubernetes` manages `memory allocation` more efficiently, mitigating the impact of excessive **kernel-level caching** on `pod` memory usage. For example:

```yaml
resources: 
    requests: 
        memory: 30Mi
    limits:
        memory: 60Mi
```

> [!NOTE]
> A misconfiguration on `pod memory limits` may lead to problems such as OOM-Killed.

## More information

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]