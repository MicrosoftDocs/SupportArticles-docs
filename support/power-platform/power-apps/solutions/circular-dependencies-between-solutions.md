---
title: Failed deleting solution error due to circular dependencies between two solutions
description: Works around an issue where you can't delete a solution due to circular dependencies between two solutions in Power Apps.
ms.reviewer: jdaly
ms.date: 10/16/2023
author: swatimadhukargit
ms.author: swatim
---
# "Failed deleting solution" error occurs due to circular dependencies between two solutions

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue where deleting a solution fails due to circular dependencies between two solutions. Circular dependencies exist when the two solutions each have dependencies on a component from the other solution.

> [!TIP]
> To avoid circular dependencies between the two solutions, use different environments for [developing different solutions](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies). Isolation of environments is critical when using components like data and tables.

## Symptoms

When you delete (uninstall) a solution, you receive the following error indicating that a dependency exists on another solution:

> Failed deleting solution \<solution name\>. Solution dependencies exist, cannot uninstall.

The same error occurs when you try to delete the other solution named in the error while deleting the first solution. This is a *circular dependency*.

## Cause

Circular dependencies between solutions can happen due to lack of isolation of development environment for different solutions. It results in unintentional component dependencies between two solutions being developed in the same environment.

## Workaround

To work around the circular dependencies between the two solutions, first you need to understand the dependencies between different solutions. When you encounter errors indicating a circular dependency, select the **View dependencies** button in the notification.

The dependencies show all the components that are dependent on the solution you're trying to uninstall. You can select each component in the list and select **See solution layers** to find the dependent solutions the component comes from.

### Example

For example, Solution A and Solution B have dependencies on each other. As shown in the diagram: 

- Solution A has two components, Component 1 and Component 2.
- Solution B has two components, Component 3 and Component 4.
- Component 2 from Solution A is dependent on Component 3 from Solution B.
- Component 4 from Solution B is dependent on Component 1 from Solution A.
- You can't delete either solution due to the circular dependencies.

:::image type="content" source="media/circular-dependencies-between-solutions/circular-dependency.png" alt-text="Example of two solutions having dependencies on each other.":::

#### Upgrade to remove dependencies

To resolve the circular dependencies, work on one of the solutions involved and update it to [remove dependency](/power-platform/alm/removing-dependencies) on the other one.

##### Option 1

1. Go to the source environment of Solution A and edit Component 2 to remove the dependency on Component 3.
1. Export Solution A as a new version, and upgrade it to the target environment.

You're allowed to delete Solution B now, as Solution A doesn't have a dependency on Solution B.

:::image type="content" source="media/circular-dependencies-between-solutions/solutionB-dependency-on-solutionA.png" alt-text="Example of removing the dependency on Solution B for Solution A.":::

##### Option 2

1. Go to the source environment of Solution B and edit Component 4 to remove the dependency on Component 1.
1. Export Solution B as a new version, and upgrade it to the target environment.

You're allowed to delete Solution A now, as Solution B doesn't have a dependency on Solution A.

:::image type="content" source="media/circular-dependencies-between-solutions/solutionA-dependency-on-solutionB.png" alt-text="Example of removing the dependency on Solution A for Solution B.":::

#### Active change to remove dependencies

If you want to remove the dependencies to be able to delete the solutions, remove the dependencies in the active layer, and then delete the solution.

##### Option 1

In the target environment, edit Component 2 and remove the dependency on Component 3 in the active layer. Deletion of Solution B is allowed now. Once Solution B is deleted, Solution A can also be deleted.

##### Option 2

In the target environment, edit Component 4 and remove the dependency on Component 1 in the active layer. Deletion of Solution A is allowed now. Once Solution A is deleted, Solution B can also be deleted.
