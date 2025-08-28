---
title: Identify containers causing high disk I/O latency in AKS clusters
description: Learn how to identify which containers and pods are causing high disk I/O latency in your Azure Kubernetes Service clusters to easily troubleshoot issues using the open source project Inspektor Gadget.
ms.date: 07/16/2025
ms.author: burakok
ms.reviewer: burakok, mayasingh, blanquicet
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot high disk I/O latency in AKS clusters

Disk I/O latency can severely impact the performance and reliability of workloads running in Azure Kubernetes Service (AKS) clusters. This article shows how to use the open source project [Inspektor Gadget](https://aka.ms/ig-website) to identify which containers and pods are causing high disk I/O latency in AKS.

Inspektor Gadget provides eBPF-based gadgets that help you observe and troubleshoot disk I/O issues in Kubernetes environments.

## Symptoms

You may suspect disk I/O latency issues when you observe the following behaviors in your AKS cluster:

- Applications become unresponsive during file operations
- [Azure Portal metrics](/azure/aks/monitor-aks-reference#supported-metrics-for-microsoftcomputevirtualmachines)(`Data Disk Bandwidth Consumed Percentage` and `Data Disk IOPS Consumed Percentage`) or other system monitoring shows high disk utilization with low throughput
- Database operations take significantly longer than expected
- Pod logs show file system operation errors or timeouts

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- Access to your AKS cluster with sufficient permissions to run privileged pods
- The open source project [Inspektor Gadget](../logs/capture-system-insights-from-aks.md#what-is-inspektor-gadget) for eBPF-based observability. For more information, see [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster)

> [!NOTE]
> The `top_blockio` gadget requires kernel version 6.5 or later. You can verify your AKS node kernel version by running `kubectl get nodes -o wide` to see the kernel version in the KERNEL-VERSION column.

## Troubleshooting checklist

### Step 1: Profile disk I/O latency with `profile_blockio`

The [`profile_blockio`](https://aka.ms/ig-profile-blockio) gadget gathers information about block device I/O usage and generates a histogram distribution of I/O latency when the gadget is stopped. This helps you visualize disk I/O performance and identify latency patterns. We can use this information to gather evidence to support or refute the hypothesis that the symptoms we are seeing are due to disk I/O issues. 

```console
kubectl gadget run profile_blockio --node <node-name>
```

> [!NOTE]
> The `profile_blockio` gadget requires specifying a specific node with the `--node` parameter. You can get node names by running `kubectl get nodes`.

**Baseline example** (empty cluster with minimal activity):

```
latency
        µs               : count    distribution
         0 -> 1          : 0        |                                        |
         1 -> 2          : 0        |                                        |
         2 -> 4          : 0        |                                        |
         4 -> 8          : 0        |                                        |
         8 -> 16         : 0        |                                        |
        16 -> 32         : 0        |                                        |
        32 -> 64         : 70       |                                        |
        64 -> 128        : 22       |                                        |
       128 -> 256        : 6        |                                        |
       256 -> 512        : 16       |                                        |
       512 -> 1024       : 1017     |*********                               |
      1024 -> 2048       : 2205     |********************                    |
      2048 -> 4096       : 2740     |**************************              |
      4096 -> 8192       : 1128     |**********                              |
      8192 -> 16384      : 708      |******                                  |
     16384 -> 32768      : 4211     |****************************************|
     32768 -> 65536      : 129      |*                                       |
     65536 -> 131072     : 185      |*                                       |
    131072 -> 262144     : 402      |***                                     |
    262144 -> 524288     : 112      |*                                       |
    524288 -> 1048576    : 0        |                                        |
   1048576 -> 2097152    : 0        |                                        |
   2097152 -> 4194304    : 0        |                                        |
   4194304 -> 8388608    : 0        |                                        |
   8388608 -> 16777216   : 0        |                                        |
  16777216 -> 33554432   : 0        |                                        |
  33554432 -> 67108864   : 0        |                                        |
```

**High disk I/O stress example** (with `stress-ng --hdd 10 --io 10` running to simulate I/O load):

```
latency
        µs               : count    distribution
         0 -> 1          : 0        |                                        |
         1 -> 2          : 0        |                                        |
         2 -> 4          : 0        |                                        |
         4 -> 8          : 0        |                                        |
         8 -> 16         : 42       |                                        |
        16 -> 32         : 236      |                                        |
        32 -> 64         : 558      |*                                       |
        64 -> 128        : 201      |                                        |
       128 -> 256        : 147      |                                        |
       256 -> 512        : 62       |                                        |
       512 -> 1024       : 2660     |******                                  |
      1024 -> 2048       : 6376     |***************                         |
      2048 -> 4096       : 8374     |********************                    |
      4096 -> 8192       : 3912     |*********                               |
      8192 -> 16384      : 2099     |*****                                   |
     16384 -> 32768      : 16703    |****************************************|
     32768 -> 65536      : 1718     |****                                    |
     65536 -> 131072     : 5758     |*************                           |
    131072 -> 262144     : 9552     |**********************                  |
    262144 -> 524288     : 6778     |****************                        |
    524288 -> 1048576    : 347      |                                        |
   1048576 -> 2097152    : 16       |                                        |
   2097152 -> 4194304    : 0        |                                        |
   4194304 -> 8388608    : 0        |                                        |
   8388608 -> 16777216   : 0        |                                        |
  16777216 -> 33554432   : 0        |                                        |
  33554432 -> 67108864   : 0        |                                        |
```

**Interpreting the results**: To identify which node has I/O pressure you can compare the baseline vs. stress scenarios:
- **Baseline**: Most operations (4,211 count) in the 16-32ms range, typical for normal system activity
- **Under stress**: Significantly more operations in higher latency ranges (9,552 operations in 131-262ms, 6,778 in 262-524ms)
- **Performance degradation**: The stress test shows operations extending into the 500ms-2s range, indicating disk saturation
- **Concerning signs**: Look for high counts above 100ms (100,000µs) which may indicate disk performance issues

### Step 2: Find top disk I/O consumers with `top_blockio`

The [`top_blockio`](https://aka.ms/ig-top-blockio) gadget provides a periodic list of containers with the highest disk I/O operations. Optionally we can limit the tracing to the node we identified in Step 1. This gadget requires kernel version 6.5 or higher (available on [Azure Linux Container Host clusters](/azure/aks/use-azure-linux)).

```console
kubectl gadget run top_blockio --namespace <namespace> [--node <node-name>]
```

Sample output:

```
K8S.NODE                      K8S.NAMESPACE   K8S.PODNAME   K8S.CONTAINERNAME   COMM     PID   TID MAJOR MINOR BYTES      US         IO  RW
aks-nodepool1-…99-vmss000000                                                              0     0   8     0     173707264  153873788  357 write
aks-nodepool1-…99-vmss000000                                                              0     0   8     0     24576      1549       6   read
```

From the output, we can identify containers with unusually high number of bytes read/written into the disk (`BYTES` column), time spent on reading/writing operations (`US` column), or number of IO operations (`IO` column) which may indicate high disk activity. In this example, we can see significant write activity (173MB) with considerable time spent (~154 seconds total).

> [!NOTE]
> Empty K8S.NAMESPACE, K8S.PODNAME, and K8S.CONTAINERNAME fields can occur during kernel space initiated operations or high-volume I/O. You can still use the `top_file` gadget for detailed process information when these fields are empty.

### Step 3: Identify files causing high disk activity with `top_file`

The [`top_file`](https://aka.ms/ig-top-file) gadget reports periodically the read/write activity by file, helping you identify specific processes in which containers are causing high disk activity.

```console
kubectl gadget run top_file --namespace <namespace>
```

Sample output:

```
K8S.NODE                      K8S.NAMESPACE   K8S.PODNAME   K8S.CONTAINERNAME   COMM     PID    TID   READS WRITES FILE              T RBYTES WBYTES
aks-nodepool1-…99-vmss000000  default         stress-hdd    stress-hdd          stress   49258  49258 0     17     /stress.ADneNJ    R 0 B    18 MB
aks-nodepool1-…99-vmss000000  default         stress-hdd    stress-hdd          stress   49254  49254 0     20     /stress.LEbDOb    R 0 B    21 MB
aks-nodepool1-…99-vmss000000  default         stress-hdd    stress-hdd          stress   49252  49252 0     18     /stress.eMOjmP    R 0 B    19 MB
aks-nodepool1-…99-vmss000000  default         stress-hdd    stress-hdd          stress   49264  49264 0     22     /stress.fLHpBC    R 0 B    23 MB
...
```

This output shows which files are being accessed most frequently, helping you pinpoint what specific file a given process is reading/writing the most. In this example, the stress-hdd pod is creating multiple temporary files with significant write activity (18-23MB each)

### Root cause analysis workflow

By combining all three gadgets, you can trace disk latency issues from symptoms to root cause:

1. **`profile_blockio`** identifies that disk latency exists in a given node (high counts in 100ms+ ranges)
2. **`top_blockio`** shows which processes are generating the most disk I/O (173MB writes with 154 seconds total time spent)
3. **`top_file`** reveals the specific files and commands causing the issue (stress command creating /stress.* files)

This complete visibility allows you to:
- **Identify the problematic pod**: `stress-hdd` pod in the `default` namespace
- **Find the specific process**: `stress` command with PIDs 49258, 49254, etc.
- **Locate the problematic files**: Multiple `/stress.*` temporary files with 18-23MB each
- **Understand the I/O pattern**: Heavy write operations creating temporary files

With this information, you can take targeted action rather than making broad system changes.

## Next steps

Based on the results from these gadgets, you can take the following actions:

- **High latency in `profile_blockio`**: Investigate the underlying disk performance and if the workload needs better disk performance, consider using [storage optimized nodes](/azure/virtual-machines/sizes/overview#storage-optimized)
- **High I/O operations in `top_blockio`**: Review application logic to optimize disk access patterns or implement caching
- **Specific files in `top_file`**: Analyze if files can be moved to faster storage, cached, or if application logic can be optimized

## Related content

- [Inspektor Gadget documentation](https://inspektor-gadget.io/docs/latest/gadgets/)
- [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster)
- [Troubleshoot high memory consumption in disk-intensive applications](high-memory-consumption-disk-intensive-applications.md)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]



