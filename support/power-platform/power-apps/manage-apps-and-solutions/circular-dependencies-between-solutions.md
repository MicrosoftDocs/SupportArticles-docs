---
title: Solution delete fails due to circular dependencies between two solutions.
description: Works around the issue where solution delete fails due to circular dependencies between two solutions.
ms.reviewer: jdaly
ms.date: 09/25/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution delete fails due to circular dependencies between two solutions

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when solution delete fails due to circular dependencies between two solutions. Circular dependencies exist when the two solutions, each have dependencies on a component from the other solution.

## Symptoms

You can't delete (uninstall) a solution and the error indicates a dependency on another solution:

> **Failed deleting solution \<solution name\>. Solution dependencies exist, cannot uninstall**

The same error occurs when you try to delete the other solution named in the error while deleting the first solution. This is a *circular dependency*.

## Cause

Circular dependencies between solutions can happen due to lack of isolation of development environment for different solutions. It results in unintentional component dependencies between two solutions being developed in same environment.

## Workaround

To work around the circular dependencies between the two solutions, first you need to understand the dependencies between different solutions. When you have errors indicating a circular dependency, select the **View dependencies** button in the notification.

The dependencies show all the components that are dependent on the solution you're trying to uninstall. You can select each component in the list and select **See solution layers** to find the dependent solutions the component comes from.

<!-- jdaly
1. What action are they supposed to do here?
2. The sentence below is just repeating the symptoms. I would remove it. 
-->

While trying to delete the dependent solution, if you encounter same issue and find that dependent solution also has dependency on the current solution, then its circular dependency.

### Example

For example, Solution A and Solution B have dependencies on each other. As shown in the diagram, Solution A has two components Component 1 and Component 2. Solution B has two components Component 3 and Component 4. Component 2 from Solution A is dependent on Component 3 from Solution B. And Component 4 from Solution B is dependent on Component 1 from Solution A. You can't delete either solution because of these circular dependencies.

:::image type="content" source="media/circular-dependency.png" alt-text="Example of two solutions having dependencies on each other.":::

#### Upgrade to remove dependencies

To resolve the circular dependencies, work on either one of the solutions involved and update it to [remove dependency](/power-platform/alm/removing-dependencies) on the other one.

<!--jdaly

I went to the removing dependencies page and it wasn't immediately clear to me exactly how to remove dependencies.
It seems to depend on whether the solution is managed or un-managed. 

At this point, I think I would be very frustrated at this article. 

Can you be more specific about what 'removing dependencies' means?

I think it means you need to plan and carefully consider which solution any component should belong to and the order in which the solutions should be installed.  You touch on this in the TIP at the end of the article, perhaps this needs to be included in the cause. The cause is poor planning...

I don't see how it is possible to repair this situation with managed solutions. Is it possible?

I wish the power-platform/alm/removing-dependencies article was clearer. I just see a lot of scenarios and examples, but very little concrete guidance.

-->

- Either, go to the source environment of Solution A and edit Component 2 to remove dependency on Component 3. Export the Solution A as a new version and upgrade to the target environment. You're allowed to delete Solution B now, as Solution A doesn't have dependency on Solution B anymore.

:::image type="content" source="media/solutionB-dependency-on-solutionA.png" alt-text="Example of Solution A removed dependency on Solution B.":::

- Or, go to the source environment of Solution B and edit Component 4 to remove dependency on Component 1. Export the Solution B as a new version and import to the target environment. You're allowed to delete Solution A now, as Solution B doesn't have dependency on Solution A.

:::image type="content" source="media/solutionA-dependency-on-solutionB.png" alt-text="Example of Solution B removed dependency on Solution A.":::

#### Active change to remove dependencies

If you want to remove the dependencies to be able to delete the solutions, remove the dependencies in the active layer and then delete the solution.

- Either, in the target environment, edit Component 2 and remove dependency on Component 3 that can be done in the active layer. Deletion of Solution B is allowed now. Once the Solution B is deleted, Solution A can be deleted too.

- Or, in the target environment, edit Component 4 and remove dependency on Component 1 that can be done in the active layer. Deletion of Solution A is allowed now. Once the Solution A is deleted, Solution B can be deleted too.

<!-- jdaly
As mentioned above, this TIP seems an after thought and I'm not clear about how it applies in this 'Active change to remove dependencies' section. I think it belongs in the cause... 
-->

> [!TIP]
> To avoid circular dependencies between the two solutions, use different environments for [developing different solutions](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies). Isolation of environments is critical when using components like data, tables, etc.
