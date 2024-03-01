---
title: Azure Container Instances shows unexpected memory usage metrics
description: Learn why Azure Container Instances shows unexpected memory usage metrics in the Azure portal compared to other memory usage reporting tools.
ms.date: 02/22/2024
ms.author: tysonfreeman
author: tysonfms
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
#customer intent: As a user of Azure Container Instances, I want to fix the display of memory usage metrics in the Azure portal so that it matches the memory usage values shown in the 'free' command for an individual container.
---
# Azure Container Instances shows unexpected memory usage metrics

This article discusses scenarios in which you see lower-than-expected memory usage values in Microsoft Azure Container Instances when you check the values in the Azure portal.

## Symptoms

When you check the memory usage metric of a multi-container container group in the Azure portal, the metric shows values that are lower than what you see when you run the [free -h](https://www.man7.org/linux/man-pages/man1/free.1.html) command while you're connecting to the main container.
  
## Cause

The memory usage metric in the Azure portal displays an average value for all containers that are in the container group. It doesn't show the memory usage for only one particular container. This metric is calculated by using a default time interval of one minute. Multi-container averaging can cause the memory usage that's shown in the Azure portal to be slightly different from the usage that's shown in the output of the `free` command.

Values for aggregation types (such as Average, Minimum, and Maximum) are available only as an average across all containers in the container group. These statistics aren't available for an individual container within a container group that has many containers. For more information, see [Supported metrics per resource type in Azure Monitor](/azure/azure-monitor/reference/supported-metrics/metrics-index#microsoftcontainerinstance).

## Solution

You can add a dimension filter to view metrics on a per-container basis if your container group contains multiple containers. For more information, see [Get metrics in the Azure portal when monitoring container resources in Azure Container Instances](/azure/container-instances/container-instances-monitor#get-metrics---azure-portal).

## Reference

- [Supported metrics for Microsoft.ContainerInstance/containerGroups](/azure/azure-monitor/reference/supported-metrics/microsoft-containerinstance-containergroups-metrics)

- [Tutorial: Deploy a multi-container group using an Azure Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

- [Use dimension filters and splitting](/azure/azure-monitor/essentials/analyze-metrics#use-dimension-filters-and-splitting)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
