---
title: Duplicated inspection responses
description: Reviews audit log and offline profile filters to prevent duplicated inspection responses in Microsoft Dynamics 365 Field Service.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/11/2023
---
# Duplicated inspection responses

Due to the current design of the inspection feature and offline functionality, some scenarios can create duplicate inspection responses in Microsoft Dynamics 365 Field Service.

## Symptoms

When a work order service task that has an associated inspection is opened the first time, it automatically creates an inspection response record. In some cases, the system might create a duplicate inspection response. Users might report that their answers to inspection questions are being cleared. This is due to the new inspection response replacing the previous one.

## Resolution

Administrators can review the audit log on the work order service task to check if the associated inspection response is created twice.

### In offline scenarios

The default offline profile has filter set to download all work order service tasks and inspection responses. If users change the filters for the offline profile, some might not get downloaded. So when a work order service task record is opened while the device is offline, it can't find the associated inspection response. The system assumes that an inspection response doesn't exist and creates a new one. Review the filters of your custom offline profile to download all required records.

### With custom security roles and privileges

The predefined security role "Field Service - Resource" has permissions to update inspection responses and work order service tasks.

If administrators create custom security roles and don't give users permissions to both record types, they might not be able to read the related inspection response on a work order service task. The system then creates a new inspection response when a user opens the work order service task.

### Using multiple devices

In some scenarios, a user has two devices that can run in offline more, and both devices have the offline data downloaded. If the user opens a work order service task on one device, and later opens the same work order service task on another device, the system creates an inspection response record on each device. When the devices sync with the service once online, inspection responses are duplicated.

A similar issue occurs, if the user opens the same work order service task on the web and on an offline device. Both actions create an inspection response that lead to duplicated records.
