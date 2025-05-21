---
title: Troubleshoot CPU Pressure in AKS Clusters Using PSI Metrics
description: Provides troubleshoot guidance on CPU pressure using PSI metrics in an AKS cluster.
ms.date: 05/21/2025
ms.reviewer: aritraghosh, dafell, alvinli, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot CPU pressure in AKS clusters using PSI metrics

CPU pressure is a more accurate indicator of resource contention than traditional CPU utilization metrics. While high CPU usage shows resource consumption, it doesn't necessarily indicate performance problems. In an Azure Kubernetes Service (AKS) cluster, understanding CPU pressure through Pressure Stall Information (PSI) metrics helps identify true resource contention issues.

When a node in an AKS cluster experiences CPU pressure, applications might suffer from poor performance even when CPU utilization appears moderate. PSI metrics provide insight into actual resource contention by measuring task delays rather than just resource consumption.

This article helps you monitor CPU pressure using PSI metrics and provides best practices to resolve resource contention issues.

## Symptoms

The following table outlines the common symptoms of CPU pressure:

|Symptom | Description |
|---|---|
|Increased application latency|Services respond slower even when CPU utilization appears moderate.|
|Throttled containers|Containers experience delays in processing despite having CPU resources available on the node.|
|Degraded performance|Applications experience unpredictable performance variations that don't correlate with CPU usage percentages.|

## Troubleshooting checklist

To identify and resolve CPU pressure issues, follow these steps:

### Step 1: Enable and monitor PSI metrics

Use one of the following methods to access PSI metrics:

- In a web browser, use Azure Monitoring Managed Prometheus or other monitoring solution to query PSI metrics.
- In a console, use the Kubernetes command-line tool (`kubectl`).

### [Browser](#tab/browser)

Azure Monitoring Managed Prometheus provides a way to monitor PSI metrics:

1. Enable Azure Monitoring Managed Prometheus for your AKS cluster by following the instructions in [Enable Prometheus and Grafana](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-prometheus-and-grafana).

    To enable customized scrape metrics for Prometheus, see [Scrape configs](/azure/azure-monitor/containers/prometheus-metrics-scrape-configuration#scrape-configs). We recommend setting `minumum ingestion profile` to `false` and `node-exporter` to `true`.

2. Navigate to the Azure Monitor workspace associated with the AKS cluster from the [Azure portal](https://portal.azure.com).

    :::image type="content" source="media/troubleshoot-node-cpu-pressure-psi/configure-azure-monitor-for-containers.png" alt-text="Screenshot that shows how to navigate to the Azure Monitor workspace." lightbox="media/troubleshoot-node-cpu-pressure-psi/configure-azure-monitor-for-containers.png":::

3. Under **Monitoring**, select **Metrics**.

4. Select **Prometheus metrics** as the data source.

    > [!NOTE]
    > To use the metrics, you need to enable them in Azure Monitoring Managed Prometheus. These metrics are exposed by Node Exporter or cAdvisor.

5. Query specific PSI metrics in Prometheus explorer:

   - For node-level CPU pressure, use the `node_pressure_cpu_waiting_seconds_total` Prometheus Query Language (PromQL).

      :::image type="content" source="media/troubleshoot-node-cpu-pressure-psi/node-level-cpu-pressure.png" alt-text="Screenshot that shows how to query node-level CPU pressure." lightbox="media/troubleshoot-node-cpu-pressure-psi/node-level-cpu-pressure.png":::

   - For pod-level CPU pressure, use the `container_cpu_cfs_throttled_seconds_total` PromQL.

6. Calculate the PSI-some percentage (percentage of time at least one task is stalled on CPU):

   `rate(node_pressure_cpu_waiting_seconds_total[5m]) * 100`

> [!NOTE]
> Some of the container level metrics such as `container_pressure_cpu_waiting_seconds_total` and `container_pressure_cpu_stalled_seconds_total` aren't available in AKS as they're part of the Kubelet PSI feature gate that is in alpha state. AKS begins supporting the use of the feature when it reaches beta stage.

### [Command Line](#tab/command-line)

Access PSI metrics safely using kubectl without requiring Secure Shell (SSH) access:

1. Use kubernetes proxy and node metrics:

   ```bash
   # Start the kubernetes proxy in a separate terminal
   kubectl proxy
   
   # Access node metrics API
   kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes
   ```

2. For more detailed PSI metrics, use the `kubectl debug` feature to create a temporary debug pod:

   ```bash
   # Create a debug pod that mounts the host filesystem
   kubectl debug node/<node_name> -it --image=busybox

   # Once inside the debug pod, check PSI metrics
   cat /host/proc/pressure/cpu
   ```

   Here's an example command output:

   ```output
   some avg10=0.00 avg60=0.00 avg300=0.00 total=0
   full avg10=0.00 avg60=0.00 avg300=0.00 total=0
   ```

   - The `some` line indicates the percentage of time at least one task is stalled on CPU.
   - The `full` line indicates the percentage of time all tasks are stalled on CPU.

---

### Step 2: Review best practices to prevent CPU pressure

Review the following table to learn how to implement best practices for avoiding CPU pressure:

| Best practice | Description |
|---|---|
|Focus on PSI metrics instead of utilization|Use PSI metrics as your primary indicator of resource contention rather than CPU utilization percentages. For more information, see [PSI - Pressure Stall Information](https://docs.kernel.org/accounting/psi.html).|
|Identify pods utilizing the most CPU|Isolate the pods that are utilizing the most CPU and identify solutions to reduce pressure. For more information, see [Troubleshoot high CPU usage in AKS clusters](./identify-high-cpu-consuming-containers-aks.md).|
|Minimize CPU limits|Consider removing CPU limits and rely on [Linux's Completely Fair Scheduler](https://docs.kernel.org/scheduler/sched-design-CFS.html) with CPU shares based on requests. For more information, see [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/).|
|Use appropriate Quality of Service (QoS) classes|Set the right QoSclass for each pod based on its importance and contention sensitivity. For more information, see [Configure Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/).|
|Optimize pod placement|Use pod anti-affinity rules to avoid placing CPU-intensive workloads on the same nodes. For more information, see [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/).|
|Monitor for brief pressure spikes|Short pressure spikes can indicate issues even when average utilization appears acceptable. For more information, see [Resource metrics pipeline](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/).|

## Key PSI metrics to monitor

> [!NOTE]
> If a node's CPU usage is moderate but the containers on the node experience CFS throttling, increase the resource limits, or remove them and follow [Linux's Completely Fair Scheduler (CFS)](https://docs.kernel.org/scheduler/sched-design-CFS.html) algorithm.

### Node-level PSI metrics

- `node_pressure_cpu_waiting_seconds_total`: Cumulative time tasks wait for CPU.
- `node_cpu_seconds_total`: Traditional CPU utilization for comparison.

### Container-level PSI indicators

- `container_cpu_cfs_throttled_periods_total`: The number of periods a container is throttled.
- `container_cpu_cfs_throttled_seconds_total`: Total time a container is throttled.
- Throttling percentage: `rate(container_cpu_cfs_throttled_periods_total[5m]) / rate(container_cpu_cfs_periods_total[5m]) * 100`

## Why using PSI metrics?

AKS uses PSI metrics as an indicator for CPU pressure instead of load average for several reasons:

- In oversized and multi-core nodes, load average often underreports CPU saturation.
- On chattier and containerized nodes, load average can over-signal, leading to alert fatigue.
- Since load average doesn't have per-cgroup visibility, noisy pods can hide behind a low system average.

## References

- [Linux PSI documentation](https://docs.kernel.org/accounting/psi.html)
- [Kubernetes resource management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [AKS performance best practices](/azure/aks/concepts-clusters-workloads)
- [Enable Prometheus and Grafana](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-prometheus-and-grafana)
- [Quality of Service in Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/)
- [Linux Completely Fair Scheduler](https://docs.kernel.org/scheduler/sched-design-CFS.html)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
