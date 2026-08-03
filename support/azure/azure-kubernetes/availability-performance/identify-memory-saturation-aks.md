---
title: Troubleshoot memory saturation in AKS clusters
description: Find and fix memory saturation in AKS clusters across nodes, namespaces, and containers. Use this guide to identify pressure points and take action.
ms.date: 07/22/2026
author: kaushika-msft
ms.author: kaushika
editor: v-jsitser
ms.reviewer: chiragpa, aritraghosh, v-leedennis, v-liuamson, mariusbutuc, angrif
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot memory saturation in AKS clusters

## Summary

This article helps you troubleshoot memory saturation in AKS clusters. Learn how to identify saturated nodes, find high-memory pods and processes, and reduce memory pressure.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The open source project [Inspektor Gadget](../logs/capture-system-insights-from-aks.md#what-is-inspektor-gadget) for advanced process-level memory analysis. For more information, see [How to install Inspektor Gadget in an AKS cluster](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).

## Symptoms

The following table outlines the common symptoms of memory saturation.

| Symptom | Description |
| --- | --- |
| Unschedulable pods | You can't schedule more pods if the node is close to its set memory limit. |
| Pod eviction | If a node is running out of memory, the kubelet can evict pods. Although the control plane tries to reschedule the evicted pods on other nodes that have resources, there's no guarantee that other nodes have enough memory to run these pods. |
| Node not ready | Memory saturation can cause `kubelet` and `containerd` to become unresponsive, eventually causing node readiness problems. |
| Out-of-memory (OOM) kill | An OOM problem occurs if the pod eviction can't prevent a node problem. For more information, see [Troubleshoot OOMkilled in AKS clusters](./troubleshoot-oomkilled-aks-clusters.md). |

## Troubleshooting checklist

To reduce memory saturation, use effective monitoring tools and apply best practices.

### Step 1: Identify nodes with memory saturation

Use either of the following methods to identify nodes with memory saturation:

- In a web browser, use the Container Insights feature of AKS in the Azure portal.

- In a console, use the Kubernetes command-line tool (kubectl).

### [Browser](#tab/browser)

Container Insights is a feature within AKS that monitors container workload performance. For more information, see [Enable Container insights for Azure Kubernetes Service (AKS) cluster](/azure/azure-monitor/containers/container-insights-enable-aks).

1. In the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.
1. In the list of Kubernetes services, select the name of your cluster.
1. In the navigation pane of your cluster, find the **Monitoring** heading, and then select **Insights**.
1. Set the appropriate **Time Range** value.
1. Select the **Nodes** tab.
1. In the **Metric** list, select **Memory working set (computed from Allocatable)**.
1. In the percentiles selector, set the sample to **Max**, and then select the **Max %** column label two times. This action sorts the table nodes by the maximum percentage of memory used, from highest to lowest.

   :::image type="content" source="./media/identify-memory-saturation-aks/nodes-containerinsights-memorypressure.png" alt-text="Screenshot of the Nodes view in Container Insights for an AKS cluster in the Azure portal." lightbox="./media/identify-memory-saturation-aks/nodes-containerinsights-memorypressure.png":::

   The Azure portal screenshot shows a table of nodes. The table column values include **Name**, **Status**, **Max %** (the percentage of memory capacity that's used), **Max** (memory usage), **Containers**, **UpTime**, **Controller**, and **Trend Max % (1 bar = 15m)**. The nodes have an expand/collapse arrow icon next to their names.

      There are four rows in the table that represent four nodes in an AKS agent pool virtual machine (VM) scale set. The statuses are all **Ok**, the maximum percentage of memory used is from 64 to 58 percent, the maximum memory used is from 2.6 GB to 2.86 GB, the number of containers used is 20 to 24, and the uptime spans 6 to 15 days. No controllers are listed.
   :::image-end:::

1. Because the first node has the highest memory usage, select that node to investigate the memory usage of the pods that are running on the node.

   :::image type="content" source="./media/identify-memory-saturation-aks/containers-containerinsights-memorypressure.png" alt-text="Screenshot of container memory details for a selected AKS node in the Nodes view of Container Insights." lightbox="./media/identify-memory-saturation-aks/containers-containerinsights-memorypressure.png":::

      The Azure portal screenshot shows a table of nodes. The first node is expanded to display an **Other processes** heading and a sublist of processes that are running within the first node. As for the nodes themselves, the table column values for the processes include **Name**, **Status**, **Max %** (the percentage of memory capacity that's used), **Max** (memory usage), **Containers**, **UpTime**, **Controller**, and **Trend Max % (1 bar = 15m)**. The processes also have an expand/collapse arrow icon next to their names.

      Nine processes are listed under the node. The statuses are all **Ok**, the maximum percentage of memory used for the processes ranges from 16 to 0.3 percent, the maximum memory used is from 0.7 mc to 22 mc, the number of containers used is 1 to 3, and the uptime is 3 to 4 days. Unlike for the node, the processes all have a corresponding controller listed. In this screenshot, the controller names are prefixes of the process names, and they're hyperlinked.
   :::image-end:::

    > [!NOTE]
    > The percentage of memory usage for pods is based on the memory request specified for the container. It doesn't represent the percentage of memory usage for the node. Look at the actual memory usage values rather than the percentage when assessing pod-level consumption.

### [Command line](#tab/command-line)

This procedure uses the kubectl commands in a console. It displays only the current state of the nodes.

1. Get the memory usage of the nodes by running the [kubectl top node](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-node-em-) command:

   ```bash
   kubectl top node
   ```

   The output of this command resembles the following text:

   ```output
   NAME                                 CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
   aks-agentpool-30486455-vmss000003    239m         12%    3148Mi          69%
   aks-agentpool-30486455-vmss000005    326m         17%    2143Mi          46%
   aks-testmemory-30616462-vmss000000   66m          3%     1532Mi          28%
   aks-testmemory-30616462-vmss000001   90m          4%     1689Mi          31%
   aks-testmemory-30616462-vmss000002   74m          3%     1715Mi          31%
   ```

1. Get the list of pods that are running on the node and their memory usage by running the [kubectl get pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [kubectl top pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-pod-em-) commands:

   ```bash
   kubectl get pods --all-namespaces --field-selector spec.nodeName=<node-name> --no-headers \
     | awk '{print $1, $2}' \
     | xargs -n2 sh -c 'printf "%s " "$1"; kubectl top pod "$2" --namespace "$1" --no-headers' sh \
     | sort -k4 -hr \
     | column -t
   ```

   > [!NOTE]  
   > In this code snippet, replace  \<node-name\> with the actual node name.

   The output of the code snippet resembles the following text. The output columns are namespace, pod name, CPU usage, and memory usage:

   ```output
   kube-system    ama-logs-w5bmd                    12m   403Mi
   kube-system    ama-logs-rs-6db98d6dff-vj4xw      13m   259Mi
   kube-system    ama-metrics-node-54sfj            16m   249Mi
   default        adservice-795589cf6f-xs66r        4m    87Mi
   kube-system    csi-azuredisk-node-9fh7h          2m    46Mi
   kube-system    metrics-server-5f8d84558d-rc5nj   4m    43Mi
   kube-system    metrics-server-5f8d84558d-frsq4   4m    42Mi
   kube-system    csi-azurefile-node-9fcx8          2m    38Mi
   default        currencyservice-7977f668dc-rvbwm  12m   32Mi
   kube-system    coredns-59b6bf8b4f-5x62d          3m    25Mi
   kube-system    coredns-59b6bf8b4f-5zg5s          3m    24Mi
   kube-system    kube-proxy-c244z                  1m    22Mi
   kube-system    cloud-node-manager-wggqd          1m    16Mi
   kube-system    azure-ip-masq-agent-tb8xv         1m    16Mi
   default        shippingservice-7946db7679-qzplg  6m    15Mi
   kube-system    coredns-autoscaler-5655d66f64-9fp2k  1m  7Mi
   ```

1. Review the requests and limits for each pod on the node by running the [kubectl describe node](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

   ```bash
   kubectl describe node <node-name>
   ```

   The output of this command resembles the following text:

   ```output
     Namespace    Name                                 CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
     ---------    ----                                 ------------  ----------  ---------------  -------------  ---
     default      adservice-795589cf6f-dgrx7           200m (10%)    300m (15%)  180Mi (3%)       300Mi (6%)     49m
     default      cartservice-6d994d9676-tcr6m         200m (10%)    300m (15%)  64Mi (1%)        128Mi (2%)     49m
     default      frontend-848d9f9dc9-x712b            100m (5%)     200m (10%)  64Mi (1%)        128Mi (2%)     49m
     default      loadgenerator-5c9656f8d6-7vmjr       300m (15%)    500m (26%)  256Mi (5%)       512Mi (11%)    38m
     default      redis-cart-799c85c644-vzpjl          70m (3%)      125m (6%)   200Mi (4%)       256Mi (5%)     49m
     kube-system  ama-logs-zs4qf                       150m (7%)     1 (52%)     550Mi (12%)      1774Mi (38%)   16h
     kube-system  azure-ip-masq-agent-rqqpn            100m (5%)     500m (26%)  50Mi (1%)        250Mi (5%)     16h
     kube-system  cloud-node-manager-nbnrq             50m (2%)      0 (0%)      50Mi (1%)        512Mi (11%)    16h
     kube-system  coredns-59b6bf8b4f-m2prf             100m (5%)     3 (157%)    70Mi (1%)        500Mi (10%)    16h
     kube-system  csi-azuredisk-node-h445m             30m (1%)      0 (0%)      60Mi (1%)        400Mi (8%)     16h
     kube-system  csi-azurefile-node-489cp             30m (1%)      0 (0%)      60Mi (1%)        600Mi (13%)    16h
     kube-system  konnectivity-agent-665c7dfdb8-25p2f  20m (1%)      1 (52%)     20Mi (1%)        1Gi (22%)      15h
     kube-system  kube-proxy-v9gp4                     100m (5%)     0 (0%)      0 (0%)           0 (0%)         16h
   Allocated resources:
     ...
   ```

    > [!NOTE]
    > The percentage of CPU or memory usage for the node is based on the allocatable resources on the node instead of on the actual node capacity.

---

After you identify the pods that use high memory, you can identify the applications that run on the pod or identify processes that might be consuming excess memory.

### Step 2: Identify process-level memory usage

For advanced process-level memory analysis, use [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) to monitor real-time memory usage at the process level within pods:

1. Install Inspektor Gadget by following the instructions in the [documentation](../logs/capture-system-insights-from-aks.md#how-to-install-inspektor-gadget-in-an-aks-cluster).

1. Run the [top_process gadget](https://aka.ms/igtopprocess) to identify processes that use large amounts of memory. Use `--fields` to select certain columns and `--filter` to filter events based on specific field values. For example, filter by the pod names of previously identified pods with high memory consumption. You can also use the following commands:

   - Identify top 10 memory-consuming processes across the cluster:

        ```bash
        kubectl gadget run top_process --sort -memoryRelative --max-entries 10
        ```

   - Identify top memory-consuming processes on a specific node:

        ```bash
        kubectl gadget run top_process --sort -memoryRelative --filter k8s.node==<node-name>
        ```

   - Identify top memory-consuming processes in a specific namespace:

        ```bash
        kubectl gadget run top_process --sort -memoryRelative --filter k8s.namespace==<namespace>
        ```

   - Identify top memory-consuming processes in a specific pod:

        ```bash
        kubectl gadget run top_process --sort -memoryRelative --filter k8s.podName==<pod-name>
        ```

   The output of the Inspektor Gadget `top_process` command resembles the following output:

   ```output

      K8S.NODE                          K8S.NAMESPACE          K8S.PODNAME            PID       COMM   MEMORYVIRTUAL    MEMORYRSS   MEMORYRELATIVE     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21676     stress          944 MB       943 MB              5.6     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21678     stress          944 MB       943 MB              5.6      
      aks-agentpool-3…901-vmss000001    default                memory-stress        21677     stress          944 MB       872 MB              5.2     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21679     stress          944 MB       796 MB              4.8     

   ```

Use this output to identify the processes that consume the most memory on the node. The output can include the node name, namespace, pod name, container name, process ID (PID), command name (COMM), CPU, and memory usage. For more details, see [the documentation](https://aka.ms/igtopprocess).

### Step 3: Determine the cause of memory pressure

After you identify which pods and processes consume the most memory, determine the nature of the problem before you act. The appropriate remediation depends on whether you're dealing with an OOM kill event, stable high memory usage, or growing memory over time.

#### Confirm an OOM kill

Exit code 137 indicates that a container received a SIGKILL signal, but this code can have more than one cause. To determine whether an OOM kill occurred, inspect the pod's last termination state:

```bash
kubectl describe pod <pod-name> -n <namespace>
```

The following output shows a container that was terminated because it exceeded its memory limit:

```output
Last State:     Terminated
  Reason:       OOMKilled
  Exit Code:    137
  Started:      Mon, 18 Aug 2025 10:14:32 +0000
  Finished:     Mon, 18 Aug 2025 10:16:08 +0000
```

The following output shows a container that exited with code 137, but wasn't explicitly reported as OOMKilled:

```output
Last State:     Terminated
  Reason:       Error
  Exit Code:    137
```

In the `Last State` section of the output:

- `Reason: OOMKilled` — the container exceeded its cgroup memory limit and the Linux OOM killer terminated it. This condition can occur even when the node itself isn't under memory pressure, if the container exceeds its own configured limit.
- `Reason: Error` with exit code 137 — the container received a SIGKILL from another source, such as a liveness probe failure, kubelet-initiated eviction, or manual deletion.

> [!NOTE]
> The Linux OOM killer uses heuristics to select which process to terminate when memory is exhausted. The result is non-deterministic and the terminated process might not be the highest memory consumer. To influence kubelet eviction decisions under node memory pressure, configure [Quality of Service (QoS) classes](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) by setting appropriate resource requests and limits, and use [PriorityClass](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/) for critical workloads.

#### Identify the memory usage pattern

The remediation for memory saturation depends on whether memory usage is stable or growing over time.

- **Stable high usage** — Memory is consistently high but not increasing. The workload legitimately requires that amount of memory, or requests and limits are misconfigured. Right-size requests and limits to match actual observed usage.

- **Growing memory usage** — Memory increases steadily over time and doesn't return to a baseline after load decreases. This pattern typically indicates a memory leak or accumulation problem in the application. Growing memory usage can come from application heap growth, native or off-heap allocations, excessive thread stacks, memory-mapped files, in-memory caches, or memory-backed volumes such as `emptyDir` with `medium: Memory`. If the container exceeds its memory limit, the kernel OOM subsystem can terminate a process in the container. Scaling solutions can temporarily reduce pressure but don't resolve the root cause. Application-level investigation is required.

Use the **Trend** column in Container Insights or the time-series memory chart for a specific pod to identify which pattern applies to your workload.

### Step 4: Review best practices to avoid memory saturation

Review the following table to learn how to implement best practices for avoiding memory saturation.

| Best practice | Description |
| --- | --- |
| Use memory [requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits) | Kubernetes provides options to specify the minimum memory size (_request_) and the maximum memory size (_limit_) for a container. By configuring limits on pods, you can avoid memory pressure on the node. Make sure that the aggregate memory requests for pods that are running don't exceed the node's allocatable memory. Setting limits much higher than requests, or not setting limits, can increase the risk of memory overcommitment at runtime. The Kubernetes scheduler places pods based on resource requests, not actual usage. Additionally, while the kubelet is evicting pods, it prioritizes pods in which the memory usage exceeds their defined requests. Set the memory request close to the actual usage. |
| Configure [QoS classes](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) and [pod priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/) | A pod's QoS class is determined by the CPU and memory requests and limits of its containers. Pods receive the Guaranteed class only when every container has CPU and memory requests and limits set, and each request equals its corresponding limit. Pods receive the BestEffort class only when no container has CPU or memory requests or limits set. Configure PriorityClass for critical workloads to influence scheduling and kubelet eviction decisions under resource pressure. |
| Consider scaling solutions ([HPA](/azure/aks/tutorial-kubernetes-scale?tabs=azure-cli#autoscale-pods), [VPA](/azure/aks/vertical-pod-autoscaler), [KEDA](https://keda.sh)) | Scaling solutions can relieve memory pressure in specific scenarios. Use HPA when memory usage increases proportionally with load and distributing requests across additional replicas reduces per-pod consumption. Use VPA when containers consistently use more or less memory than their configured requests, as it recommends or updates resource requests based on observed usage. Use KEDA when memory pressure correlates with external event load or queue depth. Scaling solutions provide temporary mitigation for memory leaks but don't resolve the underlying cause. |
| Use dedicated node pools, [node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity), [taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/), and [pod anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity) | For scenarios in which memory usage is unbounded by design, isolate the workload on a dedicated node pool. Use node affinity or node selectors to place the workload on those nodes, and use taints and tolerations to prevent unrelated workloads from scheduling there. Use pod anti-affinity when you need to spread high-memory replicas across nodes so that they don't concentrate memory pressure on a single node. |
| Choose [higher SKU VMs](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) | VMs that have more random-access memory (RAM) are better suited to handle high memory usage. To use this option, you must create a new node pool, cordon the nodes (make them unschedulable), and drain the existing node pool. |
| Isolate [system and user workloads](/azure/aks/use-system-pools#system-and-user-node-pools) | Run your applications on a user node pool. This configuration makes sure that you can isolate the Kubernetes-specific pods to the system node pool and maintain the cluster performance. |

## More information

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]
