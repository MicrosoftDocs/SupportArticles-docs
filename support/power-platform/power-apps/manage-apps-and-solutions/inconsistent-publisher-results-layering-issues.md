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

When you try to perform an upgrade or delete of a solution, it can result in faiure due to:

- Failed Upgrade or Failed to delete a Solution due to dependencies errors.
- Multiple layers involved with same component.
- Different publishers bring different layers.

You receive an error message like the following one:

> Microsoft.Crm.CrmException: The uninstall operation will delete the base layer for the component ‘<Component Name>’ with id '<Component Id>’. The operation cannot continue because there are other managed layers over the base layer. You can use the solution layers to find out which other solutions are blocking the operation.

## Cause

When different publishers use the same component and bring different layers.  

When the first layer from a publisher owns the base layer, and another publisher brings another layer through another version. 

When delete of bottom layer of a component is initiated but the above layer is owned by another publisher through another solution, not active solution then this delete is not allowed and it fails.

When upgrade of base layer but above layer is owned by another publisher. 

This scenario is only affecting when delete/upgrade is happening in base layer. 

## Workaround

Remove the layers above the base layer, by removing the component through solution. In the source environment of the solution, remove the component, export the solution by removing the above layer, import in the target environment.  

Only need to remove layers above from different publishers. If all the layers above is through different publishers, then remove all layers. 

The active layer does not count here, if the active layer is through another publisher, it still works for both delete/upgrade 

If layers above base are through same publisher, then operation will be successful. So, the layer above becomes the base layer. 

This is not a problem for removing layer in the middle of stack. 

Authoring the same solution through different publishers, give reference to doc, which says do not use different publisher solutions and use environment separation for layer. 