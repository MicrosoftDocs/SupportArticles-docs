---
title: Changes are not effective after solution import in Power Apps
description: Works around the scenario where import solution succeeded but runtime behavior isn't consistent with new solution expected behavior.
ms.reviewer: jdaly
ms.topic: troubleshooting
ms.date: 8/24/2023
author: swatimadhukargit
ms.author: swatim
---

# Changes are not effective after solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you perform update or upgrade of a solution in the target environment. The runtime behavior doesn't behave as expected by the latest solution.

## Symptoms

When you try to update or upgrade to an existing solution, but the runtime behavior isn't consistent with the expected behavior of the solution.

## Cause

This issue occurs when the solution updated isn't the Top layer, which could be result of one of the two scenarios:

- There is unmanaged active customization on the top layer in the target environment.
- There are other layers from managed solution on the top.

## Workaround

### There is unmanaged active customization on the top layer in the target environment.
- Remove the active customization on the top in the target environment.
- Or upgrade the solution again with override customization. The override customization copies the incoming value to the active layer. The active layer still exists.

#### Example Scenarios

The following example scenarios illustrate what happens to the solution layers in target when upgrade is done with active customization on the top layer.

##### Initial State of solution in target
Here "A", "B", "C" are values in base, middle and top layers coming from Solution 1, Solution 2 and Active.

![Initial State of Solution with Active layer.](media/solutions-issues/initial-state.png "Initial State of Solution with Active layer")

##### Upgrade solution without Override Customization
Solution 2 is imported with a new value "D" without override customization. The value "D" isn't effective after the upgrade because the effective top layer still remains "C".

![Upgrade without override customization with Active.](media/solutions-issues/upgrade-without-override-customization.png "Upgrade without override customization with Active")

##### Upgrade solution with Override Customization
Solution 2 is imported with a new value "D" with override customization. The value "D" is effective after the upgrade because override customization copied the value of "D" to Active layer.

![Upgrade with override customization with Active.](media/solutions-issues/upgrade-with-override-customization.png "Upgrade with override customization with Active")

### There's another layer from a managed solution on the top

- Go to the source environment of the top managed layer:
  - Make the required changes in the solution then export the new version of the solution and then import again in the target environment.
  - Or remove that component from the solution, then export the new version of the solution and then import as upgrade in the target environment.

#### Example Scenarios:

The following example scenarios illustrate what happens to the solution layers in target when upgrade is done with another managed layer on the top of upgraded layer.

##### Initial State of solution in target
Here "A", "B", "C" are values in base, middle and top layers coming from Solution 1, Solution 2 and Solution 3.

![Initial State of Solution with top Managed layer.](media/solutions-issues/Initial-state-managed-top-layer.png "Initial State of Solution with top Managed layer")

##### Upgrade solution without Override Customization
Solution 2 is imported with a new value "D" without override customization. The value "D" isn't effective after the upgrade because the effective top layer still remains "C" from Solution 2.

![Upgrade without override customization without Active.](media/solutions-issues/upgrade-without-override-another-managed-top.png "Upgrade without override customization without Active")

##### Upgrade solution with Override Customization
Solution 2 is imported with a new value "D" with override customization. The value "D" isn't effective after the upgrade because override customization copies the value to top active layer only. The value "C" from managed Solution 3 remains the top effective layer.

![Upgrade with override customization without Active.](media/solutions-issues/upgrade-with-override-another-managed-top.png "Upgrade with override customization without Active")

##### Update the top managed layer matching the upgraded layer
Solution 2 is imported with a new value "D". To make value "D" as effective top layer either delete the top layer "C". Or make changes in Solution 3 to have value as "D" and then export/import Solution 3.

![Update top managed layer to match upgraded layer.](media/solutions-issues/update-top-managed-another-managed-top.png "Update top managed layer to match upgraded layer")
