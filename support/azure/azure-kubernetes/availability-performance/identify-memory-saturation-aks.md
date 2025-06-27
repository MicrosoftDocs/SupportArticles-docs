--- 
title: Troubleshoot memory saturation in AKS clusters
description: Troubleshoot memory saturation in Azure Kubernetes Service (AKS) clusters across namespaces and containers. Learn how to identify the hosting node.
ms.date: 06/27/2025
editor: v-jsitser
ms.reviewer: chiragpa, aritraghosh, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot memory saturation in AKS clusters

This article discusses methods for troubleshooting memory saturation issues. Memory saturation occurs if at least one application or process needs more memory than a container host can provide, or if the host exhausts its available memory.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- The open source project [Inspektor Gadget](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#what-is-inspektor-gadget) for advanced process level memory analysis. For more information, see [How to install Inspektor Gadget in an AKS cluster](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster). 

## Symptoms

The following table outlines the common symptoms of memory saturation.

| Symptom | Description |
|---|---|
| Unschedulable pods | Additional pods can't be scheduled if the node is close to its set memory limit. |
| Pod eviction | If a node is running out of memory, the kubelet can evict pods. Although the control plane tries to reschedule the evicted pods on other nodes that have resources, there's no guarantee that other nodes have sufficient memory to run these pods. |
| Node not ready | Memory saturation can cause `kubelet` and `containerd` to become unresponsive, eventually causing node readiness issues. |
| Out-of-memory (OOM) kill | An OOM problem occurs if the pod eviction can't prevent a node issue. |

## Troubleshooting checklist

To reduce memory saturation, use effective monitoring tools and apply best practices.

### Step 1: Identify nodes that have memory saturation

Use either of the following methods to identify nodes that have memory saturation:

- In a web browser, use the Container Insights feature of AKS in the Azure portal.

- In a console, use the Kubernetes command-line tool (kubectl).

### [Browser](#tab/browser)

Container Insights is a feature within AKS that monitors container workload performance. For more information, see [Enable Container insights for Azure Kubernetes Service (AKS) cluster](/azure/azure-monitor/containers/container-insights-enable-aks).

1. On the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**.
1. In the list of Kubernetes services, select the name of your cluster.
1. In the navigation pane of your cluster, find the **Monitoring** heading, and then select **Insights**.
1. Set the appropriate **Time Range** value.
1. Select the **Nodes** tab.
1. In the **Metric** list, select **Memory working set (computed from Allocatable)**.
1. In the percentiles selector, set the sample to **Max**, and then select the **Max %** column label two times. This action sorts the table nodes by the maximum percentage of memory used, from highest to lowest.

   :::image type="complex" source="./media/identify-memory-saturation-aks/nodes-containerInsights-memorypressure.png" alt-text="Azure portal screenshot of the Nodes view in Container Insights within an Azure Kubernetes Service (AKS) cluster." lightbox="./media/identify-memory-saturation-aks/nodes-containerInsights-memorypressure.png":::

      The Azure portal screenshot shows a table of nodes. The table column values include **Name**, **Status**, **Max %** (the percentage of memory capacity that's used), **Max** (memory usage), **Containers**, **UpTime**, **Controller**, and **Trend Max % (1 bar = 15m)**. The nodes have an expand/collapse arrow icon next to their names.

      There are four rows in the table, and they represent four nodes in an AKS agent pool virtual machine scale set. The statuses are all **Ok**, the maximum percentage of memory used is from 64 to 58 percent, the maximum memory used is from 2.6 GB to 2.86 GB, the number of containers used is 20 to 24, and the uptime spans 6 to 15 days. No controllers are listed.
   :::image-end:::

1. Because the first node has the highest memory usage, select that node to investigate the memory usage of the pods that are running on the node.

   :::image type="complex" source="./media/identify-memory-saturation-aks/containers-containerinsights-memorypressure.png" alt-text="Azure portal screenshot of a node's containers under the Nodes view in Container Insights within an Azure Kubernetes Service (AKS) cluster." lightbox="./media/identify-memory-saturation-aks/containers-containerinsights-memorypressure.png":::
      The Azure portal screenshot shows a table of nodes, and the first node is expanded to display an **Other processes** heading and a sublist of processes that are running within the first node. As for the nodes themselves, the table column values for the processes include **Name**, **Status**, **Max %** (the percentage of memory capacity that's used), **Max** (memory usage), **Containers**, **UpTime**, **Controller**, and **Trend Max % (1 bar = 15m)**. The processes also have an expand/collapse arrow icon next to their names.
      Nine processes are listed under the node. The statuses are all **Ok**, the maximum percentage of memory used for the processes ranges from 16 to 0.3 percent, the maximum memory used is from 0.7 mc to 22 mc, the number of containers used is 1 to 3, and the uptime is 3 to 4 days. Unlike for the node, the processes all have a corresponding controller listed. In this screenshot, the controller names are prefixes of the process names, and they're hyperlinked.
   :::image-end:::

    > [!NOTE]
    > The percentage of CPU or memory usage for pods is based on the CPU request specified for the container. It doesn't represent the percentage of the CPU or memory usage for the node. So, look at the actual CPU or memory usage rather than the percentage of CPU or memory usage for pods.

### [Command Line](#tab/command-line)

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

2. Get the list of pods that are running on the node and their memory usage by running the [kubectl get pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [kubectl top pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-pod-em-) commands: 

   ```bash
   kubectl get pods --all-namespaces --output wide \
       | grep <node-name> \
       | awk '{print $1" "$2}' \
       | xargs -n2 kubectl top pods --namespace \
       | awk 'NR==1 || NR%2==0' \
       | sort -k3n \
       | column -t
   ```

   > [!NOTE]  
   > In this code snippet, replace <_node-name_> with the actual node name.

   The output of the code snippet resembles the following text:

   ```output
   NAME                                 CPU(cores)   MEMORY(bytes)
   coredns-autoscaler-5655d66f64-9fp2k  1m           7Mi
   shippingservice-7946db7679-qzplg     6m           15Mi
   azure-ip-masq-agent-tb8xv            1m           16Mi
   cloud-node-manager-wggqd             1m           16Mi
   kube-proxy-c244z                     1m           22Mi
   coredns-59b6bf8b4f-5zg5s             3m           24Mi
   coredns-59b6bf8b4f-5x62d             3m           25Mi
   currencyservice-7977f668dc-rvbwm     12m          32Mi
   csi-azurefile-node-9fcx8             2m           38Mi
   metrics-server-5f8d84558d-frsq4      4m           42Mi
   metrics-server-5f8d84558d-rc5nj      4m           43Mi
   csi-azuredisk-node-9fh7h             2m           46Mi
   adservice-795589cf6f-xs66r           4m           87Mi
   ama-metrics-node-54sfj               16m          249Mi
   ama-logs-rs-6db98d6dff-vj4xw         13m          259Mi
   ama-logs-w5bmd                       12m          403Mi
   ```

3. Review the requests and limits for each pod on the node by running the [kubectl describe node](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

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
    > The percentage of CPU or memory usage for the node is based on the allocatable resources on the node rather than the actual node capacity.

---

Now that you've identified the pods that are using high memory, you can identify the applications that are running on the pod or identify processes that may be consuming excess memory.

### Step 2: Identify process level memory usage

For advanced process level memory analysis, use [Inspektor Gadget](https://go.microsoft.com/fwlink/?linkid=2260072) to monitor real time memory usage at the process level within pods:

1. Install Inspektor Gadget using the instructions found in the [documentation](/troubleshoot/azure/azure-kubernetes/logs/capture-system-insights-from-aks#how-to-install-inspektor-gadget-in-an-aks-cluster)

2. Run the [top_process gadget](https://aka.ms/igtopprocess) to identify processes that are using large amounts of memory. You can use `--fields` to select certain columns and `--filter` to filter events based on specific field values, for example the pod names of previously identified pods with high memory consumption. You can also:

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

   The output of the Inspektor Gadget `top_process` command resembles the following:

   ```output

      K8S.NODE                          K8S.NAMESPACE          K8S.PODNAME            PID       COMM   MEMORYVIRTUAL    MEMORYRSS   MEMORYRELATIVE     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21676     stress          944 MB       943 MB              5.6     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21678     stress          944 MB       943 MB              5.6      
      aks-agentpool-3…901-vmss000001    default                memory-stress        21677     stress          944 MB       872 MB              5.2     
      aks-agentpool-3…901-vmss000001    default                memory-stress        21679     stress          944 MB       796 MB              4.8     

   ```   


You can use this output to identify the processes that are consuming the most memory on the node. The output can include the node name, namespace, pod name, container name, process ID (PID), command name (COMM), CPU and memory usage, check [the documentation](https://aka.ms/igtopprocess) for more details.


### Step 3: Review best practices to avoid memory saturation

Review the following table to learn how to implement best practices for avoiding memory saturation.

| Best practice | Description |
|---|---|
| Use memory [requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits) | Kubernetes provides options to specify the minimum memory size (*request*) and the maximum memory size (*limit*) for a container. By configuring limits on pods, you can avoid memory pressure on the node. Make sure that the aggregate limits for all pods that are running doesn't exceed the node's available memory. This situation is called *overcommitting*. The Kubernetes scheduler allocates resources based on set requests and limits through [Quality of Service](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) (QoS). Without appropriate limits, the scheduler might schedule too many pods on a single node. This might eventually bring down the node. Additionally, while the kubelet is evicting pods, it prioritizes pods in which the memory usage exceeds their defined requests. We recommend that you set the memory request close to the actual usage. |
| Enable the [horizontal pod autoscaler](/azure/aks/tutorial-kubernetes-scale?tabs=azure-cli#autoscale-pods) | By scaling the cluster, you can balance the requests across many pods to prevent memory saturation. This technique can reduce the memory footprint on the specific node. |
| Use [anti-affinity tags](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity) | For scenarios in which memory is unbounded by design, you can use node selectors and affinity or anti-affinity tags, which can isolate the workload to specific nodes. By using anti-affinity tags, you can prevent other workloads from scheduling pods on these nodes. This reduces the memory saturation problem. |
| Choose [higher SKU VMs](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) | Virtual machines (VMs) that have more random-access memory (RAM) are better suited to handle high memory usage. To use this option, you must create a new node pool, cordon the nodes (make them unschedulable), and drain the existing node pool. |
| Isolate [system and user workloads](/azure/aks/use-system-pools#system-and-user-node-pools) | We recommend that you run your applications on a user node pool. This configuration makes sure that you can isolate the Kubernetes-specific pods to the system node pool and maintain the cluster performance. |

## More information

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
