---
title: Container group remains in a transitioning state (StatusCode 409, ContainerGroupTransitioning) in ACI
description: Learn how to resolve a problem that causes a container group to get stuck in the transitioning state (status code 409, ContainerGroupTransitioning) in Azure Container Instances (ACI).
ms.date: 09/30/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kegonzal, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resume a container group that's stuck in a Transitioning state so that I can successfully perform a container group operation (such as create, start, restart, stop, or delete).
ai-usage: ai-assisted
---
# Container group remains in a transitioning state in Azure Container Instances

## Summary

This article explains how to fix an operational failure that happens when a container group remains in a transitioning state indefinitely in Azure Container Instances (ACI). The article also explains failures that happen during container group operations to [start, restart](/azure/container-instances/container-state#create-start-and-restart-operations), [stop, or delete](/azure/container-instances/container-state#stop-and-delete-operations) a container group.

## Symptoms

When you send a start or stop operation to a container group, you get the following error message.

**InternalErrorCode** - "ContainerGroupTransitioning"  
**StatusCode** - "409"  
**Message** - "The container group '\<container-group-name>' is still transitioning, please retry later."

## Cause

### Cause 1: After stop operation

During a continuous stop operation of the container group, system sidecar containers in the container group don't stop in time. This delay causes the container group to stay in a transitioning state.

### Cause 2: After start operation

The stopped state for the previous operation didn't reach the system yet or didn't reach it correctly (known platform issue). This problem causes the container group to stay in a transitioning state.

## Solution 1

Try the following steps to resolve the issue:

- Wait until the container group is fully stopped to allow the system sidecars to fully terminate. Wait at least 10 seconds between operations.
- If the [container is deployed by using an Azure Logic App](/azure/connectors/connectors-create-api-container-instances?toc=%2Fazure%2Fcontainer-instances%2Ftoc.json&bc=%2Fazure%2Fcontainer-instances%2Fbreadcrumb%2Ftoc.json), check the state of the container and then ensure the status is **Stopped** before you issue a start operation.
- For job container groups (process runs once and exits, restart policy is `Never`) in a **Terminated** state, issue a stop operation before a start operation to ensure the correct status is propagated. You can also issue a restart operation. A restart operation avoids a new container group deployment and instead restarts the application process inside the container.

> [!NOTE]
> As a best practice, always issue a stop operation before a start operation to ensure the correct status is propagated. If you start a container group that already has a running container, you might cause the transitioning state problem.

## Solution 2: Open a support ticket

If the previous solutions don't fix the problem and you still encounter the error message, open a support ticket.

## References

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)
- [Azure Container Instances states](/azure/container-instances/container-state)
- [Manually stop or start containers in Azure Container Instances](/azure/container-instances/container-instances-stop-start)
- [Update containers in Azure Container Instances](/azure/container-instances/container-instances-update)
