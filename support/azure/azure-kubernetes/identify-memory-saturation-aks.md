--- 
title: Identify memory saturation in AKS clusters
description: Learn how to identify  memory saturation in AKS clusters across namespaces and containers and how to identify the hosting node.
ms.date: 11/08/2022
author: kelleyguiney22
ms.author: v-kegui
editor: v-jsitser
ms.reviewer: chiragpa
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-cluster-performance
#Customer intent: As an Azure Kubernetes user, I want to understand how to identify memory saturation in my Azure Kubernetes Service (AKS) clusters so I don't experience service interruption or other memory saturation issues. 
---
# Identify memory saturation in AKS clusters

Memory saturation occurs when at least one application or process needs more memory than a container host can supply&mdash;or when it's exhausted the available memory. High memory consumption can occur in various ways, but it's usually caused by user actions or applications. When a host is at or reaching its memory limits, there are various potential symptoms. You might not be able to schedule more pods. Or you might experience Out-of-memory (OOM) kill events that kill off workloads to prevent the host from becoming unstable.

Run the following [Kubectl commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) to identify memory saturation across namespaces and for containers. These commands evaluate the working memory set in bytes. This method requires more mappings to determine the hosting node.

## Identify memory saturation across all namespaces

```console
kubectl top pods --sort-by=memory -A
```

The **Memory (bytes)** column in the output shows the pods with the highest working memory set in bytes at the top.

|Namespace|Name|CPU ([cores](https://medium.com/swlh/understanding-kubernetes-resource-cpu-and-memory-units-30284b3cc866))|Memory ([bytes](https://medium.com/swlh/understanding-kubernetes-resource-cpu-and-memory-units-30284b3cc866))
|---|---|---|---
|`default`|`memory-demo-3`|319 m|1026 Mi
|`kube-system`|`omsagent-7ppjm`|11 m|340 Mi
|`kube-system`|`omsagent-ddnvb`|10 m|335 Mi

## Identify memory saturation across all namespaces for all containers

```console
kubectl top pods -A –-containers
```
The **Name** field in the output indicates the name of the container. We recommend that you don't sort the columns. Sorting can break up the namespace order, which makes it less  than ideal to see the container view.

The **Memory** column displays the working memory set in bytes to show what's consuming the most memory.

|Namespace|Pod|Name|CPU ([cores](https://medium.com/swlh/understanding-kubernetes-resource-cpu-and-memory-units-30284b3cc866))|Memory ([bytes](https://medium.com/swlh/understanding-kubernetes-resource-cpu-and-memory-units-30284b3cc866))
|---|---|---|---|---
|`azure-arc`|`metrics-agent-7f5d48b7f9-d8njw`|`metrics-agent`|1 m|3 Mi
|`default`|`memory-demo-3`|`memory-demo-2-ctr`|338 m|1026 Mi
|`gatekeeper-system`|`gatekeeper-audit-7dc44b8dbc-stfml`|`gatekeeper-audit-container`|2 m|50 Mi
|`gatekeeper-system`|`gatekeeper-controller-d7c45bc7d7pn24`|`gatekeeper-controller-container`|11 m|49 Mi

Now that we've seen two ways to gather a high memory consumer, we must determine which node is hosting it.

## Identify which node is hosting the pod

```console
kubectl get pod memory-demo-3 –o wide
```

The **Node** field shows you which node is hosting the pod.

|Name|Ready|Status|Restarts|Age|IP|Node
|---|---|---|---|---|---|---
|`memory-demo-3`|1/1|Running|0|2 minutes, 15 seconds|172.31.255.255|`aks-agentpool-19575414-vmss000032`

## Identify memory saturation in an AKS cluster using Container insights

[Container insights](/azure/azure-monitor/containers/container-insights-overview) is an [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) feature that's designed to monitor the performance of container workloads. It's recommended as a scalable solution to monitor a cluster's resource consumption.

To use Container insights to identify containers or pods that are driving memory saturation:

1. On the [Azure portal](https://portal.azure.com/), navigate to the cluster.
1. Under **Monitoring**, select **Insights**.
1. Set the appropriate **Time Range**.
1. Select **Containers**.
1. For the Metric, select **Memory working set**, and set the sample to **Max**.

In the following example, a container named **myapp-maxmem** inside of the **maxmem-test** pod has been up for 14 minutes and is highly saturating the hosting node with memory requests.

:::image type="content" source="./media/identify-memory-saturation-aks/myapp-maxmem.png" alt-text="Screenshot of a Container insights  performance monitoring table that has eight columns with corresponding data. Columns are titled 'Name', 'Status', 'Max %', 'Max', 'Pod', 'Node', 'Restarts', and 'UpTime'." lightbox="./media/identify-memory-saturation-aks/myapp-maxmem.png":::

## Check node memory

Memory is another resource to troubleshoot because most applications use a portion of memory. You can use the [free](https://man7.org/linux/man-pages/man1/free.1.html) and [top](https://man7.org/linux/man-pages/man1/top.1.html) commands to review overall memory usage and determine which processes are running and how much memory they're consuming.

```console
[root@rhel78 ~]# free -m
```

The following table shows the output.

||total|used|free|shared|buff/cache|available
|---|---|---|---|---|---|---
|**Mem:**|7802|435|5250|9|2117|7051
|**Swap:**|0|0|0|||

In Linux systems, it's common to see 99 percent memory usage. In the `free` output, there's a column that's titled **buff/cache**. The Linux kernel will use free (unused) memory to cache I/O requests for better response times (*page cache*). During memory pressure (scenarios in which memory is running low), the kernel returns memory that's used for the page cache so that the memory can be used by applications.

In the `free` output, the **available** column indicates how much memory is available for processes to consume. This amount is calculated by adding the buff/cache and free memory values.

The `top` command can be configured to sort processes by memory use. By default, `top` sorts by CPU percentage (%). To sort by memory use percentage, select Shift+M when you run `top`.

```console
[root@rhel78 ~]# top
```

The `top` command produces the following summary:

```output 
top - 22:40:15 up  5:45,  2 users,  load average: 0.08, 0.08, 0.06
Tasks: 194 total,   2 running, 192 sleeping,   0 stopped,   0 zombie
%Cpu(s): 12.3 us, 41.8 sy,  0.0 ni, 45.4 id,  0.0 wa,  0.0 hi,  0.5 si,  0.0 st
KiB Mem :  7990204 total,   155460 free,  5996980 used,  1837764 buff/cache
```

Additional output is shown in the following table.

|PID|USER|PR|NI|VIRT|RES|SHR|S|%CPU|%MEM|TIME+ COMMAND
|---|---|---|---|---|---|---|---|---|---|---
|45283|root|20|0|5655348|5.3g|512|R|99.7|69.4|0:03.71 tail
|3124|omsagent|20|0|415316|54112|5556|S|0.0|0.7|0:30.16 omsagent
|1680|root|20|0|413500|41552|5644|S|3.0|0.5|6:14.96 python
|1086|root|20|0|586440|20100|6708|S|0.0|0.3|0:02.07 tuned
|3278|root|20|0|401788|19080|4808|S|0.0|0.2|0:01.44 python
|1475|root|20|0|222764|13876|4260|S|0.0|0.2|0:00.21 python
|773|polkitd|20|0|614328|13160|4688|S|0.0|0.2|0:00.62 polkitd
10637|nxautom+|20|0|585784|12324|3616|S|0.0|0.2|0:04.03 python
|845|root|20|0|547976|8716|6644|S|0.0|0.1|0:00.80 NetworkManager
|1472|root|20|0|222764|7992|5176|S|0.0|0.1|0:01.39 rsyslogd
|10592|nxautom+|20|0|187924|7460|3004|S|0.0|0.1|0:02.56 python
|1|root|20|0|128404|6960|4148|S|0.0|0.1|0:09.29 systemd
|1389|root|20|0|307900|6708|4884|S|0.0|0.1|0:31.47 omiagent

The RES column is the *resident memory*. This represents actual process usage. The `top` command provides a similar output to `free` in terms of kilobytes (KB).

Memory usage can increase more than expected in scenarios in which the application experiences *memory leaks*. Memory leakage is a situation in which applications can't free up memory pages that are no longer used.

You can also use this [ps command](https://man7.org/linux/man-pages/man1/ps.1.html) to view the top memory-consuming processes:

```console
[root@rhel78 ~]# ps -eo pid,comm,user,args,%cpu,%mem --sort=-%mem | head
```

Additional output is shown in the following table.

|PID|COMMAND|USER|COMMAND|%CPU|%MEM
|---|---|---|---|---|---
|45922|tail|root|tail -f /dev/zero|82.7|61.6
|3124|omsagent|omsagent|/opt/microsoft/omsagent/rub|0.1|0.6
|1680|python|root|python -u bin/WALinuxAgent-|1.8|0.4
|45921|python|omsagent|python /opt/microsoft/omsco|3.0|0.1
|45909|python|omsagent|python /opt/microsoft/omsco|2.7|0.1
|45912|python|omsagent|python /opt/microsoft/omsco|3.0|0.1
|45953|python|omsagent|python /opt/microsoft/omsco|11.0|0.1
|45902|python|omsagent|python /opt/microsoft/omsco|3.0|0.1
|3278|python|root|python /var/lib/waagent/Mic|0.0  0.1

Memory pressure can be identified from OOM kill events such as those shown in the following example:

```output
Jun 19 22:42:14 rhel78 kernel: Out of memory: Kill process 45465 (tail) score 902 or sacrifice child
Jun 19 22:42:14 rhel78 kernel: Killed process 45465 (tail), UID 0, total-vm:7582132kB, anon-rss:7420324kB, file-rss:0kB, shmem-rss:0kB
```

OOM is invoked after both RAM (physical memory) and SWAP (Disk memory) are consumed.

## Why do we use the working set?

The memory working set includes both the resident memory and virtual memory (cache). Therefore, it's the total of what the application uses. Memory resident set size (RSS) shows only main memory (also known as resident memory). The memory RSS metric shows the actual capacity of available memory. What's the difference between resident memory and virtual memory?

* Resident memory or main memory is the actual amount of machine memory that's available to the nodes of the cluster.
* Virtual memory is reserved hard disk space (cache) that's used by the operating system to swap data from the resident memory to the disk cache when it's under memory pressure. The operating system fetches the data and returns it to the resident memory when it's needed.

## What's next?

To control resource consumption for pods and containers, we recommend that you use [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/), [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/), or [Resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/). You can use these settings to help prevent high saturation scenarios that might render a workload unusable.

What about scenarios in which the memory is unbounded by design and is expected to be nearly reaching the limits of its hosting node? In this situation, the previous recommendations wouldn't accomplish anything. However, there are other approaches that you can take. For example, it's possible to use [nodeSelectors and Affinity/Anti-Affinity tags](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-isolation-restriction) in a YAML file in which the workload can be isolated on specific nodes. These tags would prevent any other workloads from scheduling pods on them, and would make sure that everything continues to run as expected.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

## More information

* [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
