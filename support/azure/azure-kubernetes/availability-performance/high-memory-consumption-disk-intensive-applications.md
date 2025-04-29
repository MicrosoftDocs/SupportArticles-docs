---
title: Troubleshoot High Memory Consumption in Disk-Intensive Applications
description: Helps identify and resolve excessive memory usage due to Linux kernel behaviors on Kubernetes pods.
ms.date: 04/29/2025
ms.reviewer: claudiogodoy, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot high memory consumption in disk-intensive applications

Disk input and output operations are costly, and most operating systems implement caching strategies for reading and writing data to the filesystem. The [Linux kernel](https://www.kernel.org/doc) usually uses strategies such as the [page cache](https://www.kernel.org/doc/gorman/html/understand/understand013.html) to improve overall performance. The primary goal of the page cache is to store data read from the filesystem in the cache, making it available in memory for future read operations.

This article helps you identity and avoid high memory consumption in disk-intensive applications due to Linux kernel behaviors on Kubernetes pods.

## Prerequisites

A tool to connect to the Kubernetes cluster, such as the `kubectl` tool. To install `kubectl` using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When a disk-intensive application running on a pod performs frequent filesystem operations, high memory consumption might occur.

The following table outlines common symptoms of high memory consumption:

| Symptom | Description |
| --- | --- |
| The [working set](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#memory) metric is too high. | This issue occurs when there's a significant difference between the [working set](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#memory) metric reported by the [Kubernetes Metrics API](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/#metrics-server) and the actual memory consumed by an application. |
| Out-of-memory (OOM) kill. | This issue indicates memory issues exist on your pod. |
| Increased memory usage after heavy disk activity. | After operations such as backups, large file reads/writes, or data imports, memory consumption rises. |
| Memory usage grows indefinitely. | The pod's memory consumption increases over time without reducing, like a memory leak, even if the application itself isn't leaking memory.|

## Troubleshooting checklist

### Step 1: Inspect the pod working set

To inspect the working set of pods reported by the Kubernetes Metrics API, run the following [kubectl top pods](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_top/) command:

```console
$ kubectl top pods -A | grep -i "<DEPLOYMENT_NAME>"
NAME                            CPU(cores)   MEMORY(bytes)
my-deployment-fc94b7f98-m9z2l   1m           344Mi
```

For detailed steps about how to identify which pod is consuming excessive memory, see [Troubleshoot memory saturation in AKS clusters](identify-memory-saturation-aks.md#step-1-identify-nodes-that-have-memory-saturation).

### Step 2: Inspect pod memory statistics

To inspect the memory statistics of the [cgroup](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html) on the pod that's consuming excessive memory, follow these steps:

1. Connect to the pod:

    ```console
    $ kubectl exec <POD_NAME> -it -- bash
    ```

2. Navigate to the `cgroup` statistics directory and list the memory-related files:

    ```console
    $ ls /sys/fs/cgroup | grep -e memory.stat -e memory.current
    memory.current memory.stat
    ```

    - `memory.current`: Total memory currently used by the `cgroup` and its descendants.
    - `memory.stat`: This breaks down the cgroup's memory footprint into different types of memory, type-specific details, and other information about the state and past events of the memory management system.

    All the values listed in those files are in bytes.

3. Get an overview of how memory consumption is distributed on the pod:

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

    `cAdvisor` uses `memory.current` and `inactive_file` to compute the working set metric. You can replicate the calculation using the following formula:

    `working_set = (memory.current - inactive_file) / 1048576 = (10645012480 - 10256207872) / 1048576 = 370 MB`

### Step 3: Determine kernel and application memory consumption

The following table describes some memory segments:

| Segment | Description |
|---|---|
| `anon` | The amount of memory used in anonymous mappings. Most languages use this segment to allocate memory. |
| `file` | The amount of memory used to cache filesystem data, including tmpfs and shared memory. |
| `slab`  | The amount of memory used to store data structures in the Linux kernel. |

Combined with [Step 2](#step-2-inspect-pod-memory-statistics), `anon` represents 5,197,824 bytes, which isn't close to the total amount reported by the working set metric. The `slab` memory segment used by the Linux kernel represents 354,682,456 bytes, which is almost all the memory reported by the working set metric on the pod.

### Step 4: Drop the kernel cache on a debugger pod

> [!NOTE]
> This step might lead to availability and performance issues. Avoid running it in a production environment.

1. Get the node running the pod:

    ```console
    $ kubectl get pod -A -o wide | grep "<POD_NAME>"
    NAME                            READY   STATUS    RESTARTS   AGE   IP            NODE                                NOMINATED NODE   READINESS GATES
    my-deployment-fc94b7f98-m9z2l   1/1     Running   0          37m   10.244.1.17   aks-agentpool-26052128-vmss000004   <none>           <none>
    ```

2. Create a debugger pod using the [kubectl debug](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/) command and create a `kubectl` session:

    ```console
    $ kubectl debug node/<NODE_NAME> -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0
    $ chroot /host
    ```

3. Drop the kernel cache:

    ```console
    echo 1 > /proc/sys/vm/drop_caches
    ```

4. Verify if the command in the previous step causes any effect by repeating [Step 1](#step-1-inspect-the-pod-working-set) and [Step 2](#step-2-inspect-pod-memory-statistics):

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

If you observe a significant decrease in both the working set and the `slab` memory segment, you're experiencing an issue with the Linux kernel using a great amount of memory on the pod.

## Workaround: Configure appropriate memory limits and requests

The only effective workaround for high memory consumption on Kubernetes pods is to set realistic resource [limits and requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits). For example:

```yaml
resources:
    requests:
        memory: 30Mi
    limits:
        memory: 60Mi
```

By configuring appropriate memory limits and requests in Kubernetes or the specification, you can ensure that Kubernetes manages memory allocation more efficiently, mitigating the impact of excessive kernel-level caching on pod memory usage.

> [!CAUTION]
> Misconfigured pod memory limits can lead to problems such as OOMKilled errors.

## References

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
