---
title: Entity record names have duplicated numbers
description: Resolves issues with the incremental numbering of records for Dynamics 365 Field Service entities with auto-numbering.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:Administration
---
# Entity record names have duplicated numbers in Dynamics 365 Field Service

This article helps resolve issues with the incremental numbering of records for Microsoft Dynamics 365 Field Service entities, such as work orders.

## Symptoms

There are entities with duplicated numbers in the name.

## Resolution

When the system generates a large number of entities in parallel, such as work orders, by processing multiple agreements or custom automation, delays can create issues with incremental numbering. To prevent this issue, enable auto-number in the Dynamics 365 Field Service settings. Auto-numbering ensures that records get unique naming and that there are fewer gaps in the entity names because they're created when saving a record. You can configure the numbering settings for each supported entity.

For more information, see [Auto-numbering settings](/dynamics365/field-service/configure-default-settings#auto-numbering-settings).
