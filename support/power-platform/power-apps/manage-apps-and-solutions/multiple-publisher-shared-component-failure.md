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

When you try to perform an upgrade or delete of the base layer of a component, it can result in a failure. The failure is due to different publisher owning the base layer and the layer immediately above the base layer of a shared component.

You receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component ‘&lt;Component Name&gt;’ with id '&lt;Component Id&gt;’. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

To determine if the solution component's base layer and immediate above layer is from different publisher [view the solution layers for the component](/power-apps/maker/data-platform/solution-layers#view-the-solution-layers-for-a-component). [Learn more about solution layering](/power-platform/alm/solution-layers-alm).

## Cause

The [publisher of the solution](/power-platform/alm/solution-concepts-alm#solution-publisher) that owns the base layer determines the ownership of a component. The solution system doesn't allow the change of component ownership from one publisher to another. Deletion or upgrade operations that result in change of publisher of the base layer results in failure.

For example, when a publisher owns the base layer of a component, and there's another managed solution from a different publisher that brings in another layer of the same component. When delete of the base layer is performed, the delete results in failure as the layer above the base layer belongs to different publisher.

Another example, when upgrade of the base layer is initiated which removes the component in the solution. If above layer is owned by another publisher, upgrade results in failure.

## Workaround

To work around this issue, either uninstall the solution or remove the layers above the base layer that are from different publishers by removing the component through the above layer solution. In the source environment of the above layer solution, remove the component, export the solution by removing the above layer, and then import the solution using [upgrade  or stage for upgrade](/power-apps/maker/data-platform/update-solutions) the solution the target environment.

### Examples

The following example scenarios demonstrate what happens when base layer is attempted to be removed through solution upgrade or deletion.

#### Deleting the base layer when the base and the layer above has different publisher

Deleting all the above managed layers before deleting the base layer when multiple publishers have different layers. Here layer order 2 and 3 that are Managed layer coming through Publisher B and Publisher C need to be removed.

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