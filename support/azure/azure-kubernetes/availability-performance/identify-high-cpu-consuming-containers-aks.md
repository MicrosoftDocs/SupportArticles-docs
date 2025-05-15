---
title: Identify high CPU utilization in AKS clusters
description: Troubleshoot high CPU that the node and containers consume in an AKS cluster.
ms.date: 08/30/2024
ms.reviewer: chiragpa, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot high CPU usage in AKS clusters

> [!NOTE]
> This article discusses high CPU utilization. In many situations, CPU Pressure Stall Information (PSI) metrics provide a more accurate indication of CPU Pressure than utilization alone. For more information, see [Troubleshoot CPU pressure in AKS clusters using PSI metrics](troubleshoot-node-cpu-pressure-psi.md).

High CPU usage is a symptom of one or more applications or processes that require so much CPU time that the performance or usability of the machine is impacted. High CPU usage can occur in many ways, but it's mostly caused by user configuration.

When a node in an [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) cluster experiences high CPU usage, the applications running on it can experience degradation in performance and reliability. Applications or processes also become unstable, which may lead to issues beyond slow responses.

This article helps you identify the nodes and containers that consume high CPU and provides best practices to resolve high CPU usage.

## Symptoms

The following table outlines the common symptoms of high CPU usage:

|Symptom | Description |
|---|---|
|CPU starvation|CPU-intensive applications slow down other applications on the same node.|
|Slow state changes|Pods may take longer to get ready.|
|NotReady node state|A node enters the **NotReady** state. This issue occurs because the container with high CPU usage causes the Kubectl command line tool to be unresponsive.|

## Troubleshooting checklist

To resolve high CPU usage, use effective monitoring tools and apply best practices.

### Step 1: identify nodes/containers with high CPU usage

Use either of the following methods to identify nodes and containers with high CPU usage:

- In a web browser, use the Container Insights feature of AKS in the Azure portal.

- In a console, use the Kubernetes command-line tool (kubectl).

### [Browser](#tab/browser)

[Container Insights](/azure/azure-monitor/containers/container-insights-overview) is a feature within AKS. It's designed to monitor the performance of container workloads. You can use Container insights to identify nodes, containers, or pods that drive high CPU usage.

To identify nodes, containers, or pods that drive high CPU usage, follow these steps:

1. Navigate to the cluster from the [Azure portal](https://portal.azure.com).

1. Under **Monitoring**, select **Insights**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/Insights.png" alt-text="Screenshot of the Monitoring under Insights":::

1. Set the appropriate **Time range**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/six-hour-time-range.png" alt-text="Screenshot of a time range of six hours.":::

1. Locate the nodes with high CPU usage and check if the node CPU usage is stable.

    Select **Nodes**. Set **Metric** to **CPU Usage (millicores)** and then set the sample to **Max**. Use the sort feature on the **Max** to order the nodes by **Max%**. The nodes with the highest CPU usage appear at the top.

    In the following screenshot, the node only uses 12% of the max CPU and has been running for 16 days.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/node-container-insights.png" alt-text="Screenshot of the Nodes under the Monitoring selection." lightbox="media/identify-high-cpu-consuming-containers-aks/node-container-insights.png":::

1. Once you locate the nodes with high CPU usage, select the nodes to find pods on them and their CPU usage.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/containers-in-node-insights.png" alt-text="Screenshot of the insights option for pods under the Monitoring selection." lightbox="media/identify-high-cpu-consuming-containers-aks/containers-in-node-insights.png":::

    > [!NOTE]
    > The percentage of CPU or memory usage for pods is based on the CPU request specified for the container. It doesn't represent the percentage of the CPU or memory usage for the node. So, look at the actual CPU or memory usage rather than the percentage of CPU or memory usage for pods.

    Once you get the list of pods with high CPU usage, you can map it to the applications that cause the spike in CPU usage.

### [Command Line](#tab/command-line)

> [!NOTE]
> This method can only be used to diagnose high CPU usage at the current time.

1. Use the `kubectl top node` command to get the CPU usage of all nodes.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/identify-top-node-cpu.png" alt-text="Screenshot of running the kubectl top node command.":::

1. Get the list of pods running on the node and their CPU usage by running the following command. Replace the `node_name` with the actual node name.

    ```bash
    kubectl get pods --all-namespaces -o wide | grep <node_name> | awk '{print $1" "$2}' | xargs -n2 kubectl top pods --no-headers --namespace | sort -t ' ' --key 2 --numeric --reverse
   ```

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/pods-on-node-kubectl.png" alt-text="Screenshot of top pods on a node." lightbox="media/identify-high-cpu-consuming-containers-aks/pods-on-node-kubectl.png":::

1. Check the requests and limits for each pod on the node with the `Kubectl describe node <node_name>` command.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/describe-node-kubectl.png" alt-text="Screenshot of kubectl describe node.":::

    > [!NOTE]
    > The percentage of CPU or memory usage for the node is based on the allocatable resources on the node rather than the actual node capacity.

    After you identify the pods that use excessive CPU, you can identify the applications running on the pods.

---

### Step 2: Review best practices to avoid high CPU usage

Review the following table to learn how to implement best practices for avoiding high CPU usage:

| Best practice | Description |
|---|---|
|[Set appropriate limits for containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)|Kubernetes allows specifying requests and limits on the resources for containers. Resource requests and limits represent the minimum and maximum number of resources a container can use. We recommend you set appropriate requests and limits to choose the appropriate Kubernetes [Quality of Service (QoS)](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) class for each pod. |
|[Enable Horizontal Pod Autoscaler (HPA)](/azure/aks/concepts-scale)|Setting appropriate limits along with enabling HPA can help in resolving high CPU usage.|
|[Select higher SKU VMs](https://azure.microsoft.com/pricing/details/virtual-machines/series/)|To handle high CPU workloads, use higher SKU VMs. To do this, create a new node pool, cordon off the nodes to make them unschedulable, and drain the existing node pool.|
|[Isolate system and user workloads](/azure/aks/use-system-pools)|We recommend that you create a separate node pool (other than the agent pool) to run your workloads. This can prevent overloading the system node pool and provide better performance.|

## References

- [Container insights overview](/azure/azure-monitor/containers/container-insights-overview)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)
- [How to manage the Container insights agent](/azure/azure-monitor/containers/container-insights-manage-agent)
- [Resource Limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
- [Quality of Service](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/)


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
