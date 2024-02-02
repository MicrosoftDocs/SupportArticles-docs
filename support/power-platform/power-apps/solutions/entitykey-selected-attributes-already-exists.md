---
title: An entitykey with the selected attributes already exists
description: Provides a workaround for the error during solution import in Power Apps - An entitykey with the selected attributes already exists on entity.
ms.reviewer: matp
ms.date: 08/02/2023
author: nhelgren
ms.author: nhelgren
---
# "An entitykey with the selected attributes already exists" error occurs during solution import

This article provides a workaround for an error that occurs when you [import a solution](/power-apps/maker/data-platform/import-update-export-solutions) in Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you import a solution, you receive the following error message:

> An entitykey [entity key name] with the selected attributes [GUID] already exists on entity with id [GUID] and name [entity name]

## Cause

This error occurs when a table and column that contain the entity key already exist in the target environment.

## Workaround

To work around this issue, use one of the following options:

- Delete the entity key for the table and column in the target environment.

  > [!NOTE]
  > If the entity key is part of a managed solution, you need to upgrade the solutions listed above the one that contains the deleted entity key.

- Remove the entity key from the solution before importing.
