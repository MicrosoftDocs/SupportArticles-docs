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

When you try to perform an upgrade or delete of the base layer of a component, it can result in a faiure due to different publisher owning the base layer and the layer immediately above the base layer of a component.

You receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component ‘&lt;Component Name&gt;’ with id '&lt;Component Id&gt;’. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

## Cause

The ownership of a component is determined by the [publisher of the solution](/power-platform/alm/solution-concepts-alm#solution-publisher) that is the base layer. The solution system does not allow the change of component ownership from one publisher to another. Deletion or upgrade operations which result in change of publisher of the base layer results in failure.

For example, if the first layer of a component is from a publisher who owns the base layer, and there is another publisher who brings in another layer of the same component through another solution. When delete of base layer of a component is initiated but the layer above the base layer is owned by another publisher through another solution (that is not active solution) then delete results in failure.

Another example, when upgrade of base layer is initiated which removes the component in the solution. The layer above is owned by another publisher, upgrade results in failure.

## Workaround

To work around this issue, remove the layers above the base layer which are from different publisher by removing the component through the above layer solution. To perform this in the source environment of the above layer solution, remove the component, export the solution by removing the above layer, and then import in the target environment.

Few things to keep in mind:

- You need to remove layer above the base layer, only if the above layer is from different publishers. If there are multiple layer above base layer through different publishers, then remove all the above layers with different publisher.
- The active layer need not be accounted for in this scenario, if the active layer is through another publisher, it continues to works for both delete/upgrade.
- The layer above the base layer is through same publisher, then no action is required. In this scenario the operation will be successful and the above layer from same publisher becomes the base layer.
- If you are deleting a layer which is not base layer but a layer in the middle of stack, no action is required. This is not a problem for removing layer in the middle of stack.

Learn more about [multiple solution layering and dependencies](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies).

### Examples

The following examples demonstrate what happens when delete or upgrade(to remove) the base layer is initiated:

##### Deleting base layer when base and above layer has same publisher

Deleting base layer (Order 1), Publisher A is owner of the component. Above layer is same publisher as base layer.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher B|
|2| Solution 2 | Publisher A|
|1| Solution 1 | Publisher A|

Delete is successful

|Order | Solution | Publisher|
|------|-------|--------|
|2| Solution 3 | Publisher B|
|1| Solution 2 | Publisher A|

##### Deleting base layer when base and above layer has different publisher

Deleting base layer (Order 1), Publisher A is owner of the component. Above layer is from Publisher B.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher C|
|2| Solution 2 | Publisher B|
|1| Solution 1 | Publisher A|

Delete is not allowed, as it results in change in ownership of Solution from Publisher A to Publisher B

##### Deleting above layer when base and above has different publisher

Deleting above layer (Order 2), Publisher A is owner of the component.

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher B|
|2| Solution 2 | Publisher A (or B)|
|1| Solution 1 | Publisher A|

Delete is successful if it is not base layer, the ownership of solution remain Publisher A. Even if above layer is from different publisher, delete is successful.

##### Deleting base layer by deleting all above layers

Deleting all above layers before deleting base layer when multiple publishers for different layers

|Order | Solution | Publisher|Layer|
|------|-------|--------|-------|
|4| Solution 3 | Publisher D|Active
|3| Solution 2 | Publisher C|
|2| Solution 2 | Publisher B|
|1| Solution 1 | Publisher A|

Afrer deletion all the above managed layers

|Order | Solution | Publisher|Layer|
|------|-------|--------|-------|
|4| Solution 3 | Publisher D|Active
|1| Solution 1 | Publisher A|

After deletion of base layer when no above layer remains, the component gets deleted.
