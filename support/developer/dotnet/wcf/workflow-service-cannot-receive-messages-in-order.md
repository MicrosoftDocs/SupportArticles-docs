---
title: Workflow service may not receive messages in order
description: This article provides resolutions for the problem where Windows Workflow Services service may not receive messages in order when it has multiple sequential Receives.
ms.date: 08/24/2020
ms.reviewer: smason
---
# A Windows Workflow Services service has multiple sequential Receives may not receive messages in order

This article helps you resolve the problem where Windows Workflow Services service may not receive messages in order when it has multiple sequential Receives.

_Original product version:_ &nbsp; Windows Workflow Services  
_Original KB number:_ &nbsp; 2015689

## Symptoms

In Microsoft Windows Workflow Services, you receive the following error message:
  
> System.ServiceModel.FaultException: Operation  
'MyServiceContractName{`https://MyServiceContractNamespace`}MyOperation' on service instance with identifier '12345678-90ab-cdef-1234-567890abcdef' cannot be performed at this time. Please ensure that the operations are performed in the correct order and that the binding in use provides ordered delivery guarantees.

## Cause

This issue occurs because this instance is not ready to process a given message. This behavior may occur for one of the following reasons:

- A client application sent a message out-of-order.

- The order of messages that were sent was affected during the message delivery process.

## Resolution

To resolve this issue, try the following methods:

- Make sure that your binding supports ordered delivery guarantees.

- If you want to be able to process messages that are delivered out-of-order instead of rejecting them, you must enable out-of-order message processing in the workflow. To do this, use the AllowBufferedReceive flag in the `WorkflowService` class.

> [!NOTE]
> In a WCF Workflow Service Application project (.xamlx file), you can find this property in the root node of the workflow.
