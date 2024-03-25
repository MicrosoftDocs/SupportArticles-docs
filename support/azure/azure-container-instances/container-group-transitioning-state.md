---
title: Container group remains in transitioning state
description: Learn how to resolve a problem that causes a container group to get stuck in the transitioning state (status code 409, ContainerGroupTransitioning).
ms.date: 02/27/2024
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure administrator, I want to learn how to resume a container group that's stuck in a transitioning state so that I can successfully perform a container group operation (such as create, start, restart, stop, or delete).
---
# Container group remains in transitioning state

This article discusses how to resolve an operational failure that occurs when a container group remains in a transitioning state indefinitely in Microsoft Azure Container Instances. The article also discusses failures that occur during container group operations to [create, start, restart](/azure/container-instances/container-state#create-start-and-restart-operations), [stop, or delete](/azure/container-instances/container-state#stop-and-delete-operations) a container group.

## Symptoms

When you do something that directly or indirectly triggers a container group operation, such as deleting an Azure Kubernetes Service (AKS) cluster, you receive the following error message:

> **InternalErrorCode**: "ContainerGroupTransitioning"  
> **StatusCode**: "409"  
> **Message**: "The container group '\<container-group-name>' is still transitioning, please retry later."

## Cause

During a continuous start operation of the container group, sidecar containers in Container Instances aren't terminated as expected. In this situation, the container group is stuck in the **Succeeded** state.

## Solution 1: Stop and restart the container group

1. In the [Azure portal](https://portal.azure.com), search for and select **Container instances**.

1. In the list of container instances, select the name of your container group (container instance).

1. On the **Overview** page of your container group, select **Stop** to stop the container group. In the **Stop container instances** dialog box, select **Yes** to confirm this action.

1. Wait until the container group is completely stopped. (This can take up to three minutes.)

1. Select **Start** to start the container group again.

## Solution 2: Stop the container group for a non-running container (deployed by Logic Apps)

If the [container is deployed by using an Azure Logic App](/azure/connectors/connectors-create-api-container-instances?toc=%2Fazure%2Fcontainer-instances%2Ftoc.json&bc=%2Fazure%2Fcontainer-instances%2Fbreadcrumb%2Ftoc.json), check the state of the container. If the container isn't in the **Running** state, stop the container group. For more information, see [Run sentiment analysis based on triggers with Azure Container Instances and the Container Instances Logic Apps connector](/samples/azure-samples/aci-logicapps-integration/aci-logicapps-integration/).

> [!NOTE]
> As a best practice, we recommend that you check the state of the container before you stop or start a container group. If you start a container group that already has a running container, you might cause the transitioning state problem.

## Solution 3: Open a support ticket

If the previous solutions don't fix the problem, and you still encounter the error message, open a support ticket.

## More information

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

- [Azure Container Instances states](/azure/container-instances/container-state)

- [Manually stop or start containers in Azure Container Instances](/azure/container-instances/container-instances-stop-start)

- [Update containers in Azure Container Instances](/azure/container-instances/container-instances-update)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
