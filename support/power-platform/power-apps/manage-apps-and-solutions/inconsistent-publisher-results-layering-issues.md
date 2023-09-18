---
title: Inconsistent publishers results in solution layering issues in Power Apps
description: Works around the Cannot start the requested operation because there is another running error that occurs when you perform multiple solution operations at a time in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Inconsistent publishers results in solution layering issues

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you perform multiple solution operations simultaneously in Microsoft Power Apps. These concurrent operations can cause failures because only one operation can be performed at a time. If you encounter a failure, retry the operation later.

## Symptoms

When you try to perform an upgrade or delete of the base layer in a solution, it can result in a faiure due to different publisher owning the base layer and the layer above base layer of a component.

You receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component ‘&lt;Component Name&gt;’ with id '&lt;Component Id&gt;’. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

## Cause

The reason behind this error is due to having multiple publishers bringing different layers of the same component.

For example, if the first layer of a component is from a publisher who owns the base layer, and there is another publisher who brings in another layer of the same component through another solution. Now, when delete of base layer of a component is initiated but the layer above the base layer is owned by another publisher through another solution that is not active solution then this delete is not allowed and it fails.

Another example, when upgrade of base layer which is owned by a publisher is initiated but the layer above is owned by another publisher, upgrade results in unexpected behavior.

## Workaround

To work around this issue, remove the layers above the base layer which are from different publisher by removing the component through solution. To perform this in the source environment of the solution, remove the component, export the solution by removing the above layer, import in the target environment.  Few things to keep in mind:

- You need to remove layer above the base layer, only if the above layer is from different publishers. If there are multiple layer above base layer through different publishers, then remove all of those layers.
- The active layer need not be accounted for in this scenario, if the active layer is through another publisher, it continues to works for both delete/upgrade.
- The layer above the base layer is through same publisher, then no action is required. In this scenario the operation will be successful and the above layer from same publisher becomes the base layer.
- If you are deleting a layer which is not base layer but a layer in the middle of stack, no action is required. This is not a problem for removing layer in the middle of stack.

Learn more about [multiple solution layering and dependencies](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies).

The following examples demonstrate what happens when upgrade or delete is initiated for base layer which has different publisher then the layer above:
