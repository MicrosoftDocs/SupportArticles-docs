---
title: Solution upgrade or delete fails due to multiple publishers with shared components
description: Works around when solution upgrade or delete fails due to multiple publishers with shared components
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution upgrade or delete fails due to multiple publishers with shared components

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue when solution upgrade or delete of base layer fails due to different publishers owning base layer and the above layer for a shared component.

## Symptoms

When you try to upgrade or delete the base layer of a component, it can fail when a different publisher owns the base layer and the layer immediately above the base layer of a shared component.

You receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component '&lt;Component Name&gt;' with id '&lt;Component Id&gt;'. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

To determine if the solution component's base layer and immediate above layer is from different publisher [view the solution layers for the component](/power-apps/maker/data-platform/solution-layers#view-the-solution-layers-for-a-component). [Learn more about solution layering](/power-platform/alm/solution-layers-alm).

## Cause

The owner of a component is determined by the [solution publisher](/power-platform/alm/solution-concepts-alm#solution-publisher) that owns the base layer of the solution. The solution system doesn't allow the change of component ownership from one publisher to another.
Upgrade or delete operations that change the publisher of the base layer will fail.

For example, lets say publisher A owns the base layer of a component. Another managed solution from publisher B adds another layer of the same component. Trying to delete the base layer will fail because there is another layer above it from a different publisher. If publisher A tries to upgrade the base layer in a way that removes the component that publisher B depends on, it will also fail.

## Workaround

To work around this issue, either:

- Uninstall the solution.
- Remove the layers above the base layer that are from different publishers by removing the component through the above layer solution.
  In the source environment of the above layer solution, remove the component, export the solution by removing the above layer, and then import the solution using [upgrade or stage for upgrade](/power-apps/maker/data-platform/update-solutions) the solution the target environment.

### Examples

The following example scenarios demonstrate what happens when you try to remove the base layer by upgrading or deleting a solution.

#### Deleting the base layer when the base and the layer above have different publishers

Deleting all the managed layers above before deleting the base layer when multiple publishers have different layers. Here layer order 2 and 3 that are Managed layer coming through Publisher B and Publisher C need to be removed.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher C|
|2| Solution 2 | Publisher B|
|1| Solution 1 | Publisher A|

After deletion of all the above managed layers, delete the base layer

|Order | Solution | Publisher|
|------|-------|--------|
|1| Solution 1 | Publisher A|

After deletion of base layer when no above layer remains, the component gets deleted.

Learn more about [multiple solution layering and dependencies](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies)