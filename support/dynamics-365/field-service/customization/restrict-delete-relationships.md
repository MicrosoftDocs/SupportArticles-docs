---
title: Can't delete record because of an restrict-delete relationships
description: Identify and delete related records to resolve issues with restrict-delete associations in Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Can't delete record because of an restrict-delete relationships

This article helps resolve issues with deleting records with a restrict-delete association in Dynamics 365 Field Service.

## Symptoms

Related records with a restrict-delete association block the record deletion.

## Resolution

To fix this issue, identify the relevant entities with such relationships, and then delete the records of those entities related to the record you are now trying to delete.

1. Go to **Settings** > **Customizations**.
2. Select **Customize the system**.
3. Locate the entity with records you want to delete (for example, **Accounts**).
4. Go to **1:N Relationships** for the entity.
5. Find any relationships where the **Type of Behavior** is *Referential, Restrict Delete*.
6. Take note of the related entity for each of those relationships; these are the type of records that may be restricting your ability to delete the record.
