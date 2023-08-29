---
title: Changes aren't effective after solution import in Power Apps
description: Works around an issue where importing a solution succeeds but the component runtime behavior isn't consistent with the new solution in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 8/29/2023
author: swatimadhukargit
ms.author: swatim
---
# Changes aren't effective after solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides workarounds for an issue where the component runtime behavior doesn't behave as expected when you [update or upgrade a solution](/power-apps/maker/data-platform/update-solutions) in the target environment in Power Apps.

## Symptoms

When you try to update or upgrade an existing solution, the component runtime behavior isn't consistent with the expected behavior of the solution.

This issue occurs when the solution isn't updated on the top layer for one of the following two reasons.

## Cause 1: There's an unmanaged active customization on the top layer in the target environment

#### Workaround

Use one of the following workarounds:

- Remove the active customization on the top layer in the target environment. 
- Upgrade the solution again by [overwriting the customization](/power-apps/maker/data-platform/update-solutions#overwrite-customizations-option). The overwritten customization copies the incoming value to the active layer. The active layer still exists.

The following example scenarios demonstrate what happens to the solution layers in the target environment after an upgrade is done with an active customization on the top layer.

##### Initial state of the solutions in the target environment

In the following screenshot, **A**, **B**, and **C** are values in the base, middle, and top layers, respectively, coming from Solution 1, Solution 2, and Active.

:::image type="content" source="media/importing-solution-but-not-effective/initial-state.png" alt-text="Screenshot that shows the initial state of the solution with an active layer.":::

##### An upgrade solution without an overwritten customization

After importing Solution 2 with a new value **D**, the previous customization for **B** isn't overwritten. The value **D** isn't effective after the upgrade because the effective top layer remains **C**.

:::image type="content" source="media/importing-solution-but-not-effective/upgrade-without-override-customization.png" alt-text="Screenshot that shows an upgrade solution without an overwritten customization with Active.":::

##### An upgrade solution with an overwritten customization

Solution 2 is imported with a new value **D** that overwrites the previous customization for **B**. After the upgrade, the value **D** becomes effective because the overwritten customization copies it to the Active layer.

:::image type="content" source="media/importing-solution-but-not-effective/upgrade-with-override-customization.png" alt-text="Screenshot that shows an upgrade solution with an overwritten customization with Active.":::

## Cause 2: There's another layer from a managed solution on the top layer

#### Workaround

Go to the source environment of the top managed layer, and then perform one of the following actions:

- Make the required changes to the solution, export the new version of the solution, and then import it again into the target environment.
- Remove that component from the solution, export the new version of the solution, and then import it as an upgrade solution into the target environment.

The following example scenarios demonstrate what happens to the solution layers in the target environment after an upgrade is done with another managed layer on the top layer.

##### Initial state of the solution in the target environment

In the following screenshot, **A**, **B**, and **C** are values in the base, middle, and top layers, respectively, coming from Solution 1, Solution 2, and Solution 3.

:::image type="content" source="media/importing-solution-but-not-effective/initial-state-managed-top-layer.png" alt-text="Screenshot that shows the initial state of the solution with a top managed layer.":::

##### An upgrade solution without an overwritten customization

Solution 2 is imported with a new value **D** without overwriting the customization. The value **D** isn't effective after the upgrade because the effective top layer remains **C** from Solution 2.

:::image type="content" source="media/importing-solution-but-not-effective/upgrade-without-override-another-managed-top.png" alt-text="Screenshot that shows an upgrade solution without an overwritten customization isn't active.":::

##### An upgrade solution with an overwritten customization

Solution 2 is imported with a new value **D** that overwrites the customization. However, the value **D** isn't effective after the upgrade because the overwritten customization only copies the value to the top active layer. As a result, the value **C** from managed Solution 3 remains on the top effective layer.

:::image type="content" source="media/importing-solution-but-not-effective/upgrade-without-override-another-managed-top.png" alt-text="Screenshot that shows an upgrade solution with an overwritten customization isn't active.":::

##### Update the top managed layer to match the upgraded layer

Solution 2 is imported with a new value **D**. To make value **D** effective on the top layer, you can either delete **C** from the top layer or modify Solution 3 to have a value of **D**, and then export and import Solution 3.

:::image type="content" source="media/importing-solution-but-not-effective/upgrade-without-override-another-managed-top.png" alt-text="Screenshot that shows how to update the top managed layer to match the upgraded layer.":::
