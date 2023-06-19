---
title: Entity record names have duplicated numbers
description: Troubleshoot issues with incremental numbering of records for Field Service entities with auto-numbering.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Entity record names have duplicated numbers

This article helps resolve issues with the incremental numbering of records for Field Service entities, such as work orders.

## Symptoms

There are entities with duplicated numbers in the name.

## Resolution

When the system generates a large number of entities in parallel, for example work orders by processing multiple agreements or custom automation, delays can create issues with incremental numbering. To prevent this issue, enable auto-number in the Field Service settings. Auto-numbering ensures that records get unique naming and that there are fewer gaps in the entity names because they're created when saving a record. You can configure the numbering settings for each supported entity.

For more information, see [Auto-numbering settings](/dynamics365/field-service/configure-default-settings#auto-numbering-settings).
