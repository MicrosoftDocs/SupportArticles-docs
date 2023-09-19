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

## Cause

The [publisher of the solution](/power-platform/alm/solution-concepts-alm#solution-publisher) that owns the base layer determines the ownership of a component. The solution system doesn't allow the change of component ownership from one publisher to another. Deletion or upgrade operations that result in change of publisher of the base layer results in failure.

For example, if the base layer of a component is owned by a publisher, and there's another publisher who brings in another layer of the same component through another solution. When delete of the base layer is performed, the delete results in failure as the layer above the base layer is owned by another publisher through another solution.

Another example, when upgrade of the base layer is initiated which removes the component in the solution. If above layer is owned by another publisher, upgrade results in failure.

## Workaround

To work around this issue, remove the layers above the base layer that are from different publishers by removing the component through the above layer solution. In the source environment of the above layer solution, remove the component, export the solution by removing the above layer, and then import the solution in the target environment.

### Examples

The following example scenarios demonstrate what happens when base layer is attempted to be removed through solution upgrade or deletion.

#### Deleting the base layer when the base and the layer above has different publisher

When base layer has different publisher than above layer, deletion of base layer results in failure as it changes the ownership of the solution.

The only way to resolve  is that you need to remove layer above the base layer, only if the above layer is from different publishers. If there are multiple layers above base layer through different publishers, then remove all the above layers with different publisher.

The active layer isn't accounted for even if the active layer is through another publisher, it continues to works for both delete/upgrade irrespective of the publisher of active layer.

##### Example

Deleting all the above managed layers before deleting the base layer when multiple publishers have different layers. Here layer order 2 and 3 that are Managed layer coming through Publisher B and Publisher C need to be removed.

|Order | Solution | Publisher|Layer|
|------|-------|--------|-------|
|4| Solution 4 | Publisher D|Active
|3| Solution 3 | Publisher C|
|2| Solution 2 | Publisher B|
|1| Solution 1 | Publisher A|

After deletion of all the above managed layers, delete the base layer

|Order | Solution | Publisher|Layer|
|------|-------|--------|-------|
|4| Solution 4 | Publisher D|Active
|1| Solution 1 | Publisher A|

After deletion of base layer when no above layer remains, the component gets deleted.

#### Deleting base layer when base and above layer has same publisher

The layer above the base layer is through same publisher, then no action is required. In this scenario, the operation is successful and the above layer from same publisher becomes the base layer.

##### Example

Deleting the base layer (Order 1), Publisher A is owner of the component. Above layer is from the same publisher as the base layer.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher B|
|2| Solution 2 | Publisher A|
|1| Solution 1 | Publisher A|

Deletion of base layer is successful as there's no change in the ownership of the component. Publisher A remains the owner of the component.

|Order | Solution | Publisher|
|------|-------|--------|
|2| Solution 3 | Publisher B|
|1| Solution 2 | Publisher A|

##### Deleting the layer above the base layer when the base and the above layer has different publisher

If you're deleting a layer that isn't a base layer but a layer in the middle of the stack, no action is required and deletion is successful.

##### Example

Deleting the above layer (Order 2) irrespective of which publisher owns the layer.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher B|
|2| Solution 2 | Publisher A (or B)|
|1| Solution 1 | Publisher A|

Deletion is successful if it isn't the base layer, irrespective of the publisher through which the layer came. The ownership of the solution remains Publisher A.

Learn more about [multiple solution layering and dependencies](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies)