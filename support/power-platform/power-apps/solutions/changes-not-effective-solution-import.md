---
title: Changes aren't effective after solution import in Power Apps
description: Works around an issue where importing a solution succeeds but the component runtime behavior isn't consistent with the new solution in Microsoft Power Apps.
ms.reviewer: jdaly
ms.topic: troubleshooting
ms.date: 08/30/2023
author: swatimadhukargit
ms.author: swatim
---
# Changes aren't effective after solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you perform [upgrade or update](/power-apps/maker/data-platform/update-solutions) in the target environment. The runtime behavior doesn't behave as expected by the latest solution.

## Symptoms

When you try to upgrade or update to an existing solution, the component runtime behavior isn't consistent with the expected behavior of the solution.

This issue occurs when the solution component value isn't updated on the top layer for one of the following two causes. To determine if the solution component's top layer is **Active** or **Managed**, [view the solution layers for the component](/power-apps/maker/data-platform/solution-layers#view-the-solution-layers-for-a-component). If the **Layer Status** of top is **Active** then the top layer is **Active**; otherwise, it is **Managed**. [Learn more about solution layering](/power-platform/alm/solution-layers-alm).

## Cause 1: Unmanaged active customization on top

There's an unmanaged active customization on the top layer in the target environment.

### Workaround for Cause 1

Use one of the following workarounds:

- [Remove the active customization](/power-apps/maker/data-platform/solution-layers#remove-an-unmanaged-layer) on the top in the target environment.
- Upgrade the solution again with the [Overwrite Customizations option](/power-apps/maker/data-platform/update-solutions#overwrite-customizations-option). The **Overwrite Customizations** option copies the incoming value to the active layer. The active layer still exists.

The following example scenarios demonstrate what happens to the solution layers in the target environment after an upgrade is done with an active customization on the top layer.

#### Initial state of solution in target for Cause 1

Here, **A**, **B**, and **C** are values of the solution component from Solution 1, Solution 2, and the unmanaged Active layer.

|Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer <br/> (**C**) |Default Publisher|Active|
|2|Solution 2 <br/> (**B**)   |Publisher B|  |
|1|Solution 1 <br/> (**A**)  |Publisher A|  |

#### Upgrade solution without Overwrite Customizations for Cause 1

After importing Solution 2 with a new value **D** without **Overwrite Customizations**. The value **D** isn't effective after the upgrade of Solution 2 from value **B** to **D** because the effective top layer still remains **C**.

|Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer <br/> (**C**) |Default Publisher|Active|
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/> (**A**)  |Publisher A|  |

#### Upgrade solution with Overwrite Customizations for Cause 1

After importing Solution 2 with a new value **D** with **Overwrite Customizations**. The value **D** is effective after the upgrade of Solution 2 from value **B** to **D** because the upgrade with **Overwrite Customizations** copies the value **D** to the Active layer.

|Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer <br/> (**D**) |Default Publisher|Active|
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/> (**A**)  |Publisher A|  |

## Cause 2: Layer from another managed solution on top

Another layer from a managed solution is the top layer.

### Workaround for Cause 2

Go to the source environment of the top managed layer, and then perform one of the following actions:

- Make the required changes in the solution, export the new version of the solution, and then import it again into the target environment.
- Remove the component from the solution, export the new version of the solution, and then import it as an upgrade solution into the target environment.

The following example scenarios demonstrate what happens to the solution layers in target after an upgrade is done with another managed layer on the top.

#### Initial state of solution in target for Cause 2

Here, **A**, **B**, and **C** are values of the solution component from Solution 1, Solution 2, and Solution 3.

|Order   |Solution   |Publisher|
|----------|-----------|------------|
|3|Solution 3 <br/> (**C**) |Publisher C|
|2|Solution 2 <br/> (**B**)   |Publisher B|
|1|Solution 1 <br/> (**A**)  |Publisher A|

#### Upgrade solution without Overwrite Customizations for Cause 2

After importing Solution 2 with a new value **D** without **Overwrite Customizations**. The value **D** isn't effective after the upgrade because the effective top layer remains **C** from Solution 2.

|Order   |Solution   |Publisher|
|----------|-----------|------------|
|3|Solution 3 <br/> (**C**) |Publisher C|
|2|Solution 2 <br/> (**D**)   |Publisher B|
|1|Solution 1 <br/> (**A**)  |Publisher A|

#### Upgrade solution with Overwrite Customizations

After importing Solution 2 with a new value **D** with **Overwrite Customizations**. However, the value **D** isn't effective after the upgrade because **Overwrite Customizations** only copies the value to the top active layer. The value **C** from managed Solution 3 remains the top effective layer.

|Order   |Solution   |Publisher|
|----------|-----------|------------|
|3|Solution 3 <br/> (**C**) |Publisher C|
|2|Solution 2 <br/> (**D**)   |Publisher B|
|1|Solution 1 <br/> (**A**)  |Publisher A|

#### Update the top managed layer matching the upgraded layer

After importing Solution 2 with a new value **D**. To make value **D** the effective top layer, either delete the top layer **C** or modify Solution 3 to have a value of **D**, and then export and import Solution 3.

|Order   |Solution   |Publisher|
|----------|-----------|------------|
|3|Solution 3 <br/> (**D**) |Publisher C|
|2|Solution 2 <br/> (**D**)   |Publisher B|
|1|Solution 1 <br/> (**A**)  |Publisher A|
