---
title: Solution delete fails due to circular dependencies between two solutions.
description: Works around the issue where solution delete fails due to having a circular dependendencies between two solutions.
ms.reviewer: jdaly
ms.date: 09/25/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution delete fails due to circular dependencies between two solutions

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when solution delete fails due to having a circular dependendencies between two solutions. Circular dependencies exist when the two solutions, each have dependencies on a component from the other solution.

## Symptoms

When you try to delete a solution the operation results in failure due to dependency on this solution from another solution. When you try to delete the other solution, it fails too due to dependency on the other solution from this solution. Delete of either solution isn't allowed and results in failure.
> **Failed deleting solution \<solution name\>. Solution dependencies exist, cannot uninstall**

## Cause

Failure of delete solutions can be due to circular dependencies between two solutions. Circular dependencies between solutions can happen due to lack of isolation of development environment for different solutions. It results in unintentional component dependencies between two solutions being developed in same environment. The issue surface in the scenario when both the solutions take dependencies on the other solution and deletion of either solution isn't allowed until dependencies are removed.

## Workaround

To work around the circular dependencies between the two solutions, first you need to understand the dependencies between different solutions. When the solution deletion fails with **Failed deleting solution \<solution name\>. Solution dependencies exist, cannot uninstall** along with **View dependencies** button in the notification. The Dependencies show all the components which are dependent on the solution you're trying to uninstall. You can click each component in the list and use the **See solution layers** to find the dependent solutions from which the component is coming. While trying to delete the dependent solution, if you encounter same issue and find that dependent solution also has dependency on the current solution, it's circular dependency.

> [!TIP]
> You can also check solution dependencies in the solution explorer by clicking [**Show dependencies**](/power-apps/maker/data-platform/view-component-dependencies). This can help to catch the issue before trying solution delete.

##### Example

Let's take an example. Solution A and Solution B are two different solutions, both taking dependencies on each other.
Solution A has two components Component 1 and Component 2. Solution B has two components Component 3 and Component 4.
Component 2 from Solution A takes dependency on Component 3 from Solution B. And Component 4 from Solution B takes dependency on Component 1 from Solution A.
When attempting to delete Solution A, it fails due to Solution B having dependencies on Solution A. And when attempting to delete Solution B, it fails due to Solution A having dependencies on Solution B

:::image type="content" source="media/circular-dependency.png" alt-text="Example of two solutions having dependencies on each other." lightbox="media/circular-dependency.png":::

#### Upgrade to remove dependencies

To resolve the circular dependencies, work on any one of the solutions involved and update it to [remove dependency](/power-platform/alm/removing-dependencies) on the other one.

- Either, go to the source environment of Solution A, edit Component 2 to remove dependency on Component 3. Export the Solution A as a new version and upgrade to the target environment. You're allowed to delete Solution B now, as Solution A does not have dependency on Solution B anymore.

:::image type="content" source="media/solutionB-dependency-on-solutionA.png" alt-text="Example of two solutions having dependencies on each other." lightbox="media/solutionB-dependency-on-solutionA.png":::

- Or, go to the source environment of Solution B, edit Component 4 to remove dependency on Component 1. Export the Solution B as a new version and import to the target environment. You're allowed to delete Solution A now, as Solution B does not have dependency on Solution A.

:::image type="content" source="media/solutionA-dependency-on-solutionB.png" alt-text="Example of two solutions having dependencies on each other." lightbox="media/solutionA-dependency-on-solutionB.png":::

#### Active change to remove dependencies

If the intent is to remove the dependencies to be able to delete the solutions. It can be achieved by removing the dependencies in the active layer and then deleting the solution.

- Either, in the target environment, edit Component 2 and remove dependency on Component 3 that can be done in the active layer. Deletion of Solution B is allowed now. Once the Solution B is deleted, Solution A can be deleted too.

- Or, in the target environment, edit Component 4 and remove dependency on Component 1 that can be done in the active layer. Deletion of Solution A is allowed now. Once the Solution A is deleted, Solution B can be deleted too.

> [!TIP]
> To avoid circular dependencies between the two solutions, use different environments for [developing different solutions](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies). Isolation of environment become more critical when using components like data, entitites, etc.
