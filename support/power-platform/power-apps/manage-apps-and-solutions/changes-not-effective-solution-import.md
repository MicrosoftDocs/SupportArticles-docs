---
title: Changes aren't effective after solution import in Power Apps
description: Works around an issue where importing a solution succeeds but the component runtime behavior isn't consistent with the new solution in Microsoft Power Apps.
ms.reviewer: jdaly
ms.topic: troubleshooting
ms.date: 8/29/2023
author: swatimadhukargit
ms.author: swatim
---
# Changes aren't effective after solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you perform [upgrade or update](/power-apps/maker/data-platform/update-solutions) in the target environment. The runtime behavior doesn't behave as expected by the latest solution.

## Symptoms

When you try to upgrade or update to an existing solution, the component runtime behavior isn't consistent with the expected behavior of the solution.

This issue occurs when the solution isn't updated on the top layer for one of the following two reasons. In order to determine if the solution component's top layer is Active or Managed, go to the Solution, select the Solution Component, from the Advanced drop down from the top panel select "See solution layers". If the Layer Status of top is Active then the top layer is active otherwise it is managed. To learn more about solution layering refer to [solution layers](/power-platform/alm/solution-layers-alm)

## Cause 1: There's an unmanaged active customization on the top layer in the target environment

### Workaround

Use one of the following workarounds:
- Remove the active customization on the top in the target environment.
- Upgrade the solution again with [overwrite customization](/power-apps/maker/data-platform/update-solutions#overwrite-customizations-option). The overwrite customization copies the incoming value to the active layer. The active layer still exists.

The following example scenarios demonstrate what happens to the solution layers in the target environment after an upgrade is done with an active customization on the top layer.

The following example scenarios demonstrate what happens to the solution layers in the target environment after an upgrade is done with an active customization on the top layer.

##### Initial State of solution in target
Here **A**, **B**, **C** are values of the Solution component from Solution 1, Solution 2 and Active unmanaged layer.

|Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer <br/> (**C**) |Default Publisher|Active|
|2|Solution 2 <br/> (**B**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |

##### Upgrade solution without Overwrite Customization
After importing Solution 2 with a new value "D" without overwrite customization. The value **D** isn't effective after the upgrade of Solution 2 from value **B** to **D** because the effective top layer still remains **C**.

Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer <br/> (**C**) |Default Publisher|Active|
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |

##### Upgrade solution with Overwrite Customization
After importing Solution 2 with a new value "D" with overwrite customization. The value **D** is effective after the upgrade of Solution **B** to **D** because upgrade with overwrite customization copies the value of **D** to Active layer.

|Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Unmanaged layer ("D") |Default Publisher|Active|
|2|Solution 2 ("D")   |Publisher B|  |
|1|Solution 1 ("A")  |Publisher A|  |

## Cause 2: There's another layer from a managed solution on the top layer

### Workaround

Go to the source environment of the top managed layer, and then perform one of the following actions:
  - Make the required changes in the solution, export the new version of the solution and then import again into the target environment.
  - Remove the component from the solution,  export the new version of the solution and then import it as an upgrade solution into the target environment.

#### Example Scenarios

The following example scenarios demonstrate what happens to the solution layers in target after an upgrade is done with another managed layer on the top.

##### Initial State of solution in target
Here **A**, **B**, **C** are values of the Solution component from Solution 1, Solution 2 and Solution 3.

Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Solution 3 <br/> (**C**) |Publisher C|  |
|2|Solution 2 <br/> (**B**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |

##### An upgrade solution without Overwrite Customization
After importing Solution 2 with a new value **D** without overwrite customization. The value **D** isn't effective after the upgrade because the effective top layer remains "C" from Solution 2.

Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Solution 3 <br/> (**C**) |Publisher C|  |
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |

##### An upgrade solution with Overwrite Customization
After importing Solution 2 with a new value **D** with overwrite customization. However, the value **D** isn't effective after the upgrade because overwrite customization only copies the value to top active layer. The value "C" from managed Solution 3 remains the top effective layer.

Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Solution 3 <br/> (**C**) |Publisher C|  |
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |

##### Update the top managed layer matching the upgraded layer
After importing Solution 2 with a new value **D**. To make value **D** as effective top layer either delete the top layer **C** or madify Solution 3 to have value as **D**, and then export and import Solution 3.

Order   |Solution   |Publisher|Layer Status|
|----------|-----------|------------|-------|
|3|Solution 3 <br/> (**D**) |Publisher C|  |
|2|Solution 2 <br/> (**D**)   |Publisher B|  |
|1|Solution 1 <br/>(**A**)  |Publisher A|  |
