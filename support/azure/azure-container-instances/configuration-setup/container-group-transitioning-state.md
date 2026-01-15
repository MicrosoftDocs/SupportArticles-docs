---
title: Container group remains in transitioning state
description: Learn how to resolve a problem that causes a container group to get stuck in the transitioning state (status code 409, ContainerGroupTransitioning).
ms.date: 01/15/2025
author: kennethgp
ms.author: kegonzal
editor: v-jsitser
ms.reviewer: kegonzal
ms.service: azure-container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resume a container group that's stuck in a transitioning state so that I can successfully perform a container group operation (such as create, start, restart, stop, or delete).
---
# Container group remains in transitioning state

This article discusses how to resolve an operational failure that occurs when a container group remains in a transitioning state indefinitely in Microsoft Azure Container Instances. The article also discusses failures that occur during container group operations to [start, restart](/azure/container-instances/container-state#create-start-and-restart-operations), [stop, or delete](/azure/container-instances/container-state#stop-and-delete-operations) a container group.

## Symptoms

When you issue start/stop operation on a container group, this error is thrown:

> **InternalErrorCode**: "ContainerGroupTransitioning"  
> **StatusCode**: "409"  
> **Message**: "The container group '\<container-group-name>' is still transitioning, please retry later."

## Cause

### Cause 1: After stop operation

During a continuous stop operation of the container group, system sidecar containers the container group aren't terminated in time.

### Cause 2: After start operation

The stopped state for previous operation wasn't propagated yet or didn't propagate correctly (known platform issue).

## Solution

- Wait until the container group is fully stopped to allow the system sidecars to fully terminate (allow at least 10 seconds between operations).
- If the [container is deployed by using an Azure Logic App](/azure/connectors/connectors-create-api-container-instances?toc=%2Fazure%2Fcontainer-instances%2Ftoc.json&bc=%2Fazure%2Fcontainer-instances%2Fbreadcrumb%2Ftoc.json), check the state of the container, make sure the status is **Stopped** before issuing start operation.
- For Job container groups (process runs once and exits, restart policy is **Never**) in **Terminated** state, issue a stop operation before start operation to make sure the correct status is propagated first. Another alternative is to issue a restart operation instead. A restart operation avoids a new container group deployment and instead restarts the application process inside the container.

> [!NOTE]
> As a best practice, we recommend that you always issue a stop operation before a start operation to ensure the correct status is propagated. If you start a container group that already has a running container, you might cause the transitioning state problem.

## Solution 3: Open a support ticket

If the previous solutions don't fix the problem, and you still encounter the error message, open a support ticket.

## More information

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

- [Azure Container Instances states](/azure/container-instances/container-state)

- [Manually stop or start containers in Azure Container Instances](/azure/container-instances/container-instances-stop-start)

- [Update containers in Azure Container Instances](/azure/container-instances/container-instances-update)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
