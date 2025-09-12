---
title: Solution upgrade or deletion fails when a shared component has multiple publishers
description: Works around an issue where you can't upgrade or delete the base layer of components that have multiple publishers in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 04/17/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Solution layers
---
# Solution upgrade or deletion fails when a shared component has multiple publishers

This article provides a workaround for an issue where a solution upgrade or deletion of the base layer fails because different publishers own the base layer and the above layer of a shared component in Microsoft Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When different publishers own the base layer and the layer immediately above the base layer of a shared component, you can't upgrade or delete the base layer of the component.

In this scenario, you receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component '\<Component Name>' with id '\<Component ID>'. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

To check if the solution component's base layer and the layer immediately above it are from different publishers, [view the solution layers for the component](/power-apps/maker/data-platform/solution-layers#view-the-solution-layers-for-a-component). For more information, see [Solution layers](/power-platform/alm/solution-layers-alm).

## Cause

The owner of a component is determined by the [solution publisher](/power-platform/alm/solution-concepts-alm#solution-publisher) that owns the base layer of the solution. The solution system doesn't allow users to change component ownership from one publisher to another. Therefore, upgrade or deletion operations that change the publisher of the base layer fail.

For example, publisher A owns the base layer of a component. Another managed solution from publisher B adds another layer to the same component. In this case, attempts to delete the base layer fail because there's another layer above it from a different publisher. If publisher A tries to upgrade the base layer by removing the component that publisher B depends on, it also fails.

## Workaround

To work around this issue, use one of the following options:

- Uninstall the solution.
- Remove the layers that are from different publishers above the base layer by deleting the component through the above layer solution. To do so, in the source environment of the above layer solution, remove the component, export the solution by removing the above layer, and then import the solution using [upgrade or stage for upgrade](/power-apps/maker/data-platform/update-solutions) into the target environment.

### Example

The following example demonstrates what happens when you try to remove the base layer by upgrading or deleting a solution.

There are multiple publishers for the base layer and the layers above it. Layer order 2 and order 3 are managed layers coming from publisher B and publisher C, and need to be removed.  

|Order | Solution | Publisher|
|------|-------|--------|
|3| Solution 3 | Publisher C|
|2| Solution 2 | Publisher B|
|1| Solution 1 | Publisher A|

After you delete all the managed layers, the only layer that remains is the base layer.

|Order | Solution | Publisher|
|------|-------|--------|
|1| Solution 1 | Publisher A|

After you delete the base layer and there are no layers remaining, the component is deleted.

For more information, see [multiple solution layering and dependencies](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies).
