---
title: Spot containers remain in the Waiting state
description: Learn how to resolve a scenario in Azure Container Instances in which Spot containers remain in the Waiting state.
ms.date: 05/13/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: alaljase, v-rekhanain, v-leedennis
ms.service: container-instances
ms.custom: sap:Management
ms.topic: troubleshooting-problem-resolution
#customer intent: As a user of Azure Container Instances, I want resolve a scenario in which Spot containers remain in the Waiting state so that I can use Spot containers successfully.
---
# Spot containers remain in the Waiting state

This article discusses how to resolve a scenario in which Spot containers remain stuck in the `Waiting` state in Microsoft Azure Container Instances.

## Symptoms

Azure Spot containers remain stuck in the `Waiting` state for an extended amount of time (30 minutes or more).

## Cause 1: The underlying Spot virtual machine was evicted

Containers typically become stuck in the `Waiting` state because the underlying Spot virtual machine (VM) was evicted. This action forces all containers within the container group to wait for a new VM node to be assigned. Azure Spot VMs can be evicted at any time for any of the following reasons:

- Resource constraints on the host VM (for example, because of insufficient CPU cores or memory).

- Capacity adjustments that can cause worker VM nodes to be evicted at any time from a virtual machine scale set and, therefore, require your container group to be moved to another VM node. These capacity adjustments include the following scenarios.

  | Eviction scenario | Effect on the container group |
  |--|--|
  | A node in a cluster gets evicted. | The container group has to be moved to another node in the same cluster (if present). |
  | All nodes in a cluster get evicted. | The container group has to be moved to a node in another cluster (if present). |
  | All nodes in all clusters get evicted. | A Spot Restore occurs, and the container group has to be moved to a new node in any cluster. |

## Cause 2: Network-related problems

Network-related problems cause containers to remain in the `Waiting` state.

## Solution

Follow these steps to gather troubleshooting information and apply possible solutions for the problem:

1. Retrieve container logs and events by running the following [az container logs](/cli/azure/container#az-container-logs) command:

   ```azurecli
   az container logs --resource-group <resource-group-name> --name <container-group-name>
   ```

1. Check the container logs for any error messages or events about image pulling, networking, or other container-specific problems.

1. Check for eviction events.

1. Make sure that your container deployment settings fall within the parameters that are defined in the [Resource availability & quota limits for Azure Container Instances](/azure/container-instances/container-instances-resource-and-quota-limits).

1. Consider specifying lower CPU and memory settings for the container.

1. If the problem persists, consider deploying your container to a different Azure region.

1. If the problem is related to capacity adjustments, consider deploying your containers during off-peak hours.

By following these steps, you can identify the cause of the `Waiting` state problem for your Azure Spot containers and take the appropriate action to resolve the problem. Remember to monitor your containers and adjust your deployment strategy as necessary to reduce disruptions.

## Resources

- [Azure Spot Virtual Machines for Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/use-spot)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
