---
title: Identify the containers consuming high CPU in an AKS cluster
description: Describes how to identify the containers consuming high CPU in an AKS cluster
ms.date: 07/08/2021
ms.reviewer: chiragpa
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-cluster-performance
---
# Identify the containers consuming high CPU in an AKS cluster

High CPU consumption is a symptom of one or more applications, or processes, that are requiring enough CPU time, that the performance or usability of the machine is impacted. High CPU consumption can occur in a variety of ways, but is most commonly driven by either user action or applications.

When a machine experiences high CPU consumption, the applications running on the machine can be negatively impacted, and the user experience will be degraded. Applications or processes also become unstable, which may lead to issues beyond slow responses.

[Container Insights](/azure/azure-monitor/containers/container-insights-overview) is a feature within [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) that is designed to monitor the performance of container workloads. You can use Container Insights to identify containers or pods that are driving high CPU consumption.

## Identify high CPU containers in an AKS cluster

To identify containers or pods that are driving high CPU consumption:

1. On the [Azure portal](https://portal.azure.com), navigate to the cluster.

1. Under **Monitoring** select **Insights**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/Insights.png" alt-text="Screenshot of the insights option under the Monitoring selection.":::

1. Set the appropriate **Time Range**.

   :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/six-hour-time-range.png" alt-text="Screenshot of a time range of six hours.":::

1. Select **Containers**.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/containers-option.png" alt-text="Screenshot of the Containers option.":::

1. Select the Metric **CPU Usage (millicores)**  and set the sample to **Max**.

    :::image type="content" source="media/identify-high-cpu-consuming-containers-aks/cpu-usage-at-max.png" alt-text="Screenshot of the CPU usage, which is set to Max and is located on the right side of the time options.":::

In the following example, a container named **myapp-container** inside of the **ultrapewpew2** pod has been up for 36 days. For the last six hours, **myapp-container** has been driving roughly two cores (1834 millicores, 1.8 cores to be exact) of Max CPU usage.

:::image type="content" source="media/identify-high-cpu-consuming-containers-aks/containers-example.png" alt-text="Screenshot of the CPU usage output.":::

## Run simple commands on the node

A customer may run a simple command because this type of interaction is not available from the Azure portal outside of using one of the az run-commands, which is a slower and less desirable experience for this kind of interaction.

Simple commands can be run on a node through Secure Shell (SSH) to help identify any high CPU consuming containers.

1. Access the afflicted node with SSH. Depending on the version of the cluster, run either `docker stats` or `crictl stats`, depending on whether or not you have **ContainerD**. ContainerD is a container runtime that executes containers and [manages container images on a node](/azure/aks/cluster-configuration#container-runtime-configuration).

   1. If you don't have **ContainerD**, run this command:

      `docker stats --no-stream --format "table {{.ID}}\t{{.CPUPerc}}" | sort -t " " --key=2 -h -r | head`.

   1. If you have **ContainerD**, run this command:

      `crictl stats -o "table {{.ID\t{{.CPUPerc}}" | sort -t " " --key=2 -h -r | head`.

1. To identify the hosting pod of the container, run either `docker inspect` or `crictl inspect`, depending on whether or not you have **ContainerD**:

   1. If you don't have **ContainerD**, run this command:

      `docker inspect containerid –format "{{json .Config.Hostname}}"`.

   1. If you have **ContainerD**, run this command:

      `crictl inspect --output go-template --template "{{.info.runtimeSpec.hostname}}" YOUR_CONTAINER_ID`.

## Additional information

- [Container insights overview](/azure/azure-monitor/containers/container-insights-overview)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)
- [How to manage the Container insights agent](/azure/azure-monitor/containers/container-insights-manage-agent)

### External links (Kubernetes)

- [Resource Limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
