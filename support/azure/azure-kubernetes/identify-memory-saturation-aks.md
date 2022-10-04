--- 
title: Identify memory saturation in AKS clusters
description: Learn how to identify  memory saturation in AKS clusters across namespaces and containers and how to identify the hosting node.
ms.date: 7/15/2022
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

## Why do we use the working set?

The memory working set includes both the resident memory and virtual memory (cache), so it's a total of what the application's using. Memory resident set size (RSS) shows only main memory (in other words, the resident memory). The memory RSS metric shows the actual capacity of available memory. What's the difference between resident memory and virtual memory?

* Resident memory or main memory is the actual amount of machine memory available to the nodes of the cluster.
* Virtual memory is reserved hard disk space (cache) used by the operating system to swap data from the resident memory to the disk cache when it's under memory pressure. The operating system fetches the data back to the resident memory when needed.

## What's next?

We recommend using [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/), [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/), or [Resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) to control resource consumption for pods and containers. You can use these settings to help prevent high saturation scenarios from occurring that might render a workload unusable.

What about scenarios where the memory is unbounded by design and expected to be nearly reaching the limits of its hosting node? In that case, the previous recommendations wouldn't accomplish anything, but there are other approaches that can be taken. For example, it's possible to use [nodeSelectors and Affinity/Anti-Affinity tags](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-isolation-restriction) in a YAML file where the workload could be isolated onto specific nodes. These tags would prevent any other workloads from scheduling any pods on them, and would ensure that everything continues to run as expected.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

## More information

* [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
