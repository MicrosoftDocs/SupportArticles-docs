---
title: Duplicated inspection responses
description: Reviews the audit log and offline profile filters to prevent duplicated inspection responses in Microsoft Dynamics 365 Field Service.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/19/2023
ms.custom: sap:issue-completing-inspections
---
# Duplicated inspection responses in Dynamics 365 Field Service

Due to the current design of the [inspection feature](/dynamics365/field-service/inspections) and offline functionality, some scenarios can create duplicate inspection responses in Microsoft Dynamics 365 Field Service.

## Symptoms

When a work order service task with an associated inspection is opened for the first time, it automatically creates an inspection response record. In some cases, the system might create a duplicate inspection response. Users might report that their answers to inspection questions are cleared. This is due to the new inspection response replacing the previous one.

## Resolution

Administrators can review the audit log of the work order service task to check if the associated inspection response is created twice. 

### In offline scenarios

The default offline profile has filters to download all work order service tasks and inspection responses. If users change the filter of the offline profile, some tasks might fail to download. Therefore, when a work order service task record is opened while the device is offline, the associated inspection response can't be found. The system assumes that an inspection response doesn't exist and creates a new one. 

To resolve the issue, review the filters of your custom offline profile to download all required records. For more information, see [Configure offline capabilities](/dynamics365/field-service/mobile-power-app-system-offline).

### With custom security roles and privileges

The predefined security role **Field Service - Resource** has permission to update inspection responses and work order service tasks.

If administrators create custom security roles and don't give users permission to access both record types, users might be unable to read the related inspection response on a work order service task. The system then creates a new inspection response when users open the work order service task.

To resolve the issue, ensure that the users have permissions to access inspection responses and work order service tasks.

### Using multiple devices

In some scenarios, a user has two devices that can run in offline mode, and both devices have downloaded the offline data. If the user opens a work order service task on one device, and later opens the same work order service task on the other device, the system creates an inspection response record on each device. When the devices sync with the service once online, inspection responses are duplicated.

A similar issue may occur if the user opens the same work order service task on the web and on an offline device. Both actions create an inspection response that leads to duplicated records.
