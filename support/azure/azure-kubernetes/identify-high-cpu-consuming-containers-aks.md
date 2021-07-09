---
title: Identify the containers consuming high CPU in an AKS cluster
description: Describes how to identify the containers consuming high CPU in an AKS cluster
ms.date: 07/08/2021
ms.prod-support-area-path: 
ms.reviewer: chiragpa
ms.service: cloud-services
---
# Identify the containers consuming high CPU in an AKS cluster

[Container Insights](/azure/azure-monitor/containers/container-insights-overview) is a feature within [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) that is designed to monitor the performance of container workloads. You can use Container Insights to identify containers or pods that are driving high CPU consumption.

## Identify high CPU containers in an AKS cluster

To identify containers or pods that are driving high CPU consumption:

1. On the [Azure Portal](https://portal.azure.com), navigate to the cluster.

1. Under **Monitoring** select **Insights**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/Insights.png" alt-text="Screenshot of the insights option under the Monitoring selection.":::

1. Set the appropriate **Time Range**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/six-hour-time-range.png" alt-text="Screenshot of a time range of six hours.":::

1. Select **Containers**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/containers-option.png" alt-text="Screenshot of the Containers option.":::

1. Select the Metric **CPU Usage (millicores)**  and set the sample to **Max**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/cpu-usage-at-max.png" alt-text="Screenshot of the CPU usage set to Max, which is located on the right side of the time options.":::

In the following example, a container named **myapp-container** inside of the **ultrapewpew2** pod has been up for 36 days. For the last six hours, **myapp-container** has been driving roughly two cores (1834 millicores, 1.8 cores to be exact) of Max CPU usage.

:::image type="content" source="media/identify-high-cpu-consuming-containers-aks/containers-example.png" alt-text="Screenshot of the CPU usage output.":::

## Run simple commands on the node

Simple commands can be run on a node through Secure Shell (SSH) to help identify any high CPU consuming containers.

1. Access the afflicted node with SSH. Depending on the version of the cluster, run either `docker stats` or `crictl stats`.

1. Run the following command:

   `docker stats --no-stream --format "table {{.ID}}\t{{.CPUPerc}}" | sort -t " " --key=2 -h -r | head`.

   1. If you have **ContainerD**, run this command:

      `crictl stats -o "table {{.ID\t{{.CPUPerc}}" | sort -t " " --key=2 -h -r | head`.

      :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/docker-stats-command-output.png" alt-text="Screenshot of the output of running the docker stats command.":::

1. To identify the hosting pod of the container, run the following command:

   `docker inspect containerid –format “{{json .Config.Hostname}}”`.

   1. If you have **ContainerD**, run this command:

      `crictl inspect --output go-template --template "{{.info.runtimeSpec.hostname}}" YOUR_CONTAINER_ID`.

      :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/docker-inspect-command-output.png" alt-text="Screenshot of the output of running the docker inspect command.":::

Additional information

- [Container insights overview](/azure/azure-monitor/containers/container-insights-overview)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)
- [How to manage the Container insights agent](/azure/azure-monitor/containers/container-insights-manage-agent)
