---
title: Duplicated inspection responses
description: Reviews the audit log and offline profile filters to prevent duplicated inspection responses in Microsoft Dynamics 365 Field Service.
ms.reviewer: jobaker, v-wendysmith, v-shaywood
ms.date: 01/29/2026
ms.custom: sap:Mobile application\Issues completing inspections
---
# Duplicated inspection responses in Dynamics 365 Field Service

Due to the current design of the [inspection feature](/dynamics365/field-service/inspections) and offline functionality, some scenarios can create duplicate inspection responses in Microsoft Dynamics 365 Field Service.

## Symptoms

When you open a work order service task with an associated inspection for the first time, the system automatically creates an inspection response record. In some cases, the system creates a duplicate inspection response. Users might report that their answers to inspection questions are cleared. This problem happens because the new inspection response replaces the previous one.

## Resolution

Administrators can review the audit log of the work order service task to check if the associated inspection response is created twice. 

### In offline scenarios

The default offline profile has filters to download all work order service tasks and inspection responses. If you change the filter of the offline profile, some tasks might fail to download. Therefore, when you open a work order service task record while the device is offline, the associated inspection response can't be found. The system assumes that an inspection response doesn't exist and creates a new one. 

To resolve the issue, review the filters of your custom offline profile to download all required records. For more information, see [Configure offline capabilities](/dynamics365/field-service/mobile/set-up-offline-profile).

### With custom security roles and privileges

The predefined security role **Field Service - Resource** has permission to update inspection responses and work order service tasks.

If administrators create custom security roles and don't give users permission to access both record types, users might be unable to read the related inspection response on a work order service task. The system then creates a new inspection response when users open the work order service task.

To resolve the issue, ensure that the users have permissions to access inspection responses and work order service tasks.

### Using multiple devices

In some scenarios, a user has two devices that run in offline mode, and both devices download the offline data. If the user opens a work order service task on one device, and later opens the same work order service task on the other device, the system creates an inspection response record on each device. When the devices sync with the service once online, inspection responses are duplicated.

A similar issue occurs if the user opens the same work order service task on the web and on an offline device. Both actions create an inspection response that leads to duplicated records.
