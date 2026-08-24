---
title: Device displays non-debug deployment for a task sequence instead of a debug deployment
description: Describes a behavior in which a device has a debug deployment for a task sequence, but Configuration Manager displays a non-debug deployment instead.
ms.date: 08/21/2026
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Step for Other Operations
ms.reviewer: kaushika, frankroj, sccmcsscontent
ai-usage: ai-assisted
---
# Device displays a non-debug deployment for a task sequence instead of a debug deployment

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4517138

This article helps you resolve an issue in which a Configuration Manager device displays a non-debug deployment for a task sequence, even though a debug deployment for the same task sequence is targeted to the device.

## Symptoms

Consider the following scenario:

- You deploy a non-debug deployment for a Configuration Manager task sequence to a device.
- The device sees the non-debug deployment for the task sequence. This view can be either in Software Center or when starting up from PXE or media.
- You deploy a new debug deployment for the same task sequence to the same device.

In this scenario, the debug deployment for the task sequence doesn't display. Instead, you see only the original non-debug deployment for the task sequence.

## Cause

This behavior is by design. You can see only one deployment for any individual task sequence on a device at one time.

Typically, the oldest deployment is the one that's displayed. If you create the non-debug deployment for the task sequence first, you see only that deployment. If the reverse occurs and you create the debug deployment first, you see only the debug deployment.

## Resolution

To resolve the issue, use one of the following methods:

- In any collection that's the target of additional non-debug deployments for the task sequence, remove the device that the debug deployment has to run on.
- Create a copy of the task sequence that you want to debug, and then target the copy to the device as a debug deployment.
- Set the variable `TSDebugMode` to **TRUE** on a collection that the device is a member of.

  > [!NOTE]
  > This setting enables debug mode for all task sequences that are targeted to that collection and to all devices in that collection.

- Set the variable `TSDebugMode` to **TRUE** directly on the computer object for the device.

  > [!NOTE]
  > This setting enables debug mode for all task sequences that are targeted to the device.

- Delete any deployments for the task sequence that you created before the debug deployment for the task sequence.

  > [!NOTE]
  > This action deletes any history for those deployments. If you don't want to delete the history, use one of the other methods to resolve the issue.

When you use one of the solutions that uses the `TSDebugMode` variable, you don't have to also create a debug deployment for the task sequence that is targeted to the device. A non-debug deployment is sufficient.

## More information

For more information about how to enable debugging for task sequences, see [Debug a task sequence](/mem/configmgr/osd/deploy-use/debug-task-sequence).
