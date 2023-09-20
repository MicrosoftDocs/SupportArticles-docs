---
title: Solution uninstall or upgrade fails due to circular dependencies between two solutions.
description: Works around the issue where solution uninstall or upgrade fails due to having a circular dependendencies between two solutions.
ms.reviewer: jdaly
ms.date: 09/21/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution uninstall or upgrade fails due to circular dependencies between two solutions

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when solution upgrade or delete fails due to having a circular dependendencies between two solutions. Circular dependenciers exists when the two solution, each have dependencies on a component from the other solution.

## Symptoms

When you try to uninstall a solution or remove a component during solution upgrade, the operation results in failure. This situation happens both solution has dependencies on the component from the other solution, uninstall of either solution is not allowed by the Dataverse and results in failure.

## Cause

The circular dependencies between two solutions can happen due to lack of isolation of development environment for different solution. This can result in unintentional component dependencies between two solutions being developed in same environment. The issue surface in the scenario when both the solutions take dependencies on the other solution and deletion of either solution is not allowed until dependencies are removed. The problem becomes many fold complicated when both solutions are using different publishers.

## Workaround

The workaround to resolve the circular dependencies between the two solutions are:

#### Maintain both solutions by removing the circular dependencies

Circular dependencies between two solutions can be resolved, by working on any one of the solutions involved and updating it to remove dependency. To perform that, remove the dependency on first solution on the second solution (or remove dependency of second solution on the first solution), republish the first solution (or second solution) and import to the target environment again. By doing this, the lifecycle management of the solution becomes healthy and future upgrade or deletion become possible.

##### Example

Solution A and Solution B are two different solutions, both taking dependencies on each other.
Solution A has two components Component 1 and Component 2. Solution B has two components Component 3 and Component 4.
Component 2 from Solution A takes dependency on Component 3 from Solution B. And Component 4 from Solution B takes dependency on Component 1 from Solution A.

To resolve the circular dependencies:

- Either go to the source environment of Solution A, edit Component 2 to remove dependency on Component 3. Export the Solution A as a new version and import to the target environmnet. This will allow to delete Solution B, the other way is not allowed yet, as Solution A still have dependency on Solution B.

- Or go to the source environment of Solution B, edit Component 4 to remove dependency on Component 1. Export the Solution B as a new version and import to the target environmnet. This will allow to delete Solution A, the other way is not allowed yet, as Solution B still have dependency on Solution A.

#### Delete solutions if maintenance of both solutions not needed

If the intent is to remove the dependencies to be able to delete the solution. It can be achieved by removing the dependencies in the active layer and then deleting the solution.

##### Example

To resolve the circular dependencies:

- Either, in the target environment, edit Component 2 and remove dependency on Component 3 which can be done in the active layer. Deletion of Solution B is allowed after this. Once the Solution B is deleted, Solution A can be deleted too.

- Or, in the target environment, edit Component 4 and remove dependency on Component 1 which can be done in the active layer. Deletion of Solution A is allowed after this. Once the Solution A is deleted, Solution B can be deleted too.

>[!TIP]
>To avoid circular dependencies between the two solutions, use different environments for [developing different solutions](/power-platform/alm/organize-solutions#multiple-solution-layering-and-dependencies). Isolation of environment become more critical when using components like data, entitites, etc.
