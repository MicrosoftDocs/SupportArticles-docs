---
title: PrimaryName attribute not found for entity
description: Provides a workaround for the error during solution import in Power Apps - PrimaryName attribute not found for Entity.
ms.reviewer: matp
ms.date: 08/02/2023
author: nhelgren
ms.author: nhelgren
---
# "PrimaryName attribute not found for entity" error occurs during solution import

This article provides a workaround for an error that occurs when you [import a solution](/power-apps/maker/data-platform/import-update-export-solutions) in Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you import a solution, you receive the following error message:

> PrimaryName attribute not found for Entity

## Cause

This error occurs when the [primary name attribute](/power-apps/developer/data-platform/entity-metadata#primary-name) of a table isn't included in the solution's *.xml* file.

## Workaround

To work around this issue, follow these steps:

1. Remove the table from the solution in the source environment.
2. Add the table and all assets back to the source environment to ensure that the necessary metadata is included.
3. Export the solution and import it again into the target environment.
