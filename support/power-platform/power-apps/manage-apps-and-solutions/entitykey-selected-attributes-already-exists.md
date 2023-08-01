---
title: An entitykey with the selected attributes already exists
description: Describes an issue where the message An entitykey with the selected attributes already exists on entity occurs during solution import.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 08/01/2023
author: nhelgren
ms.author: nhelgren
---
# An entitykey with the selected attributes already exists

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

During solution import, the following error is displayed:

> An entitykey [entity key name] with the selected attributes [GUID] already exists on entity with id [GUID] and name [entity name]

## Cause

This error happens when a table and column already exist in the target environment that includes an entitykey.

## Workaround

Choose one of the following options:

- Delete the entity key for the table and column in the target environment.

  > [!NOTE]
  > If the entity key is part of a managed solution. you'll need to perform a solution upgrade for every solution listed above the solution that included the deleted entity key.

- Remove the entity key from the solution before importing.
