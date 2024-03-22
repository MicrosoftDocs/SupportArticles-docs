---
title: A task sequence debug deployment isn't displayed
description: Describes a behavior in which the debug deployment for a task sequence isn't displayed in Configuration Manager.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Step for Other Operations
ms.reviewer: kaushika, frankroj, sccmcsscontent
---
# Debug deployment for a task sequence isn't displayed in Configuration Manager

This article helps you resolve an issue where the debug deployment for a task sequence isn't displayed in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4517138

## Symptoms

Consider the following scenario:

- A non-debug deployment for a Configuration Manager task sequence is deployed to a device.
- The device sees the non-debug deployment for the task sequence. This can be either in Software Center or when starting up from PXE/media.
- A new debug deployment for the same task sequence is deployed to the same device.

In this scenario, the debug deployment for the task sequence is not displayed. Instead, only the original non-debug deployment for the task sequence is displayed.

## Cause

This behavior is by design. Only one deployment for any individual task sequence can be seen on a device at one time.

Typically, the oldest deployment is the one that is displayed. If the non-debug deployment for the task sequence is created first, only that deployment is displayed. If the reverse occurs and the debug deployment is created first, only the debug deployment is displayed.

## Resolution

To resolve the issue, use one of the following methods:

- In any collection that's the target of additional non-debug deployments for the task sequence, remove the device that the debug deployment has to run on.
- Create a copy of the task sequence that has to be debugged, and then target the copy to the device as a debug deployment.
- Set the variable `TSDebugMode` to **TRUE** on a collection that the device is a member of.

  > [!NOTE]
  > This enables debug mode for all task sequences that are targeted to that collection and to all devices in that collection.

- Set the variable `TSDebugMode` to **TRUE** directly on the computer object for the device.

  > [!NOTE]
  > This enables debug mode for all task sequences that are targeted to the device.

- Delete any deployments for the task sequence that were created before the debug deployment for the task sequence.

  > [!NOTE]
  > This deletes any history for those deployments. If this action is not desired, use one of the other methods to resolve the issue.

When you use one of the solutions that uses the `TSDebugMode` variable, you don't have to also create a debug deployment for the task sequence that is targeted to the device. A non-debug deployment is sufficient.

## More information

For more information about how to enable debugging for task sequences, see [Debug a task sequence](/mem/configmgr/osd/deploy-use/debug-task-sequence).
