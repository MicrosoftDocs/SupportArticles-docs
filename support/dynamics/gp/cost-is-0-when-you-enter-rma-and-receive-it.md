---
title: Cost is 0 in Returns Management if enter and receive RMA
description: Describes steps to resolve the issue where the cost is $0.00 on a received RMA in Returns Management in Microsoft Dynamics GP.
ms.reviewer: theley, beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Cost is $0.00 in Returns Management when you enter an RMA and receive it in Microsoft Dynamics GP

This article provides a resolution for the issue that the unit cost is still $0.00 when you enter an RMA and receive it in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2490571

## Symptoms

When you enter an RMA and then receive it, the unit cost is still $0.00.

## Cause

This problem occurs for one or both of the following reasons:

- The item extension does not exist for this item or is damaged.
- A cost does not exist for the item.

## Resolution

The cost on an RMA will be $0.00 until after the RMA Receiving process has been completed. If the cost is still $0.00 after receiving the RMA, follow these steps:

1. If you were using Microsoft Dynamics GP and later added Field Service modules, run the utility to create the item extensions.

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, point to **Service Utilities**, and then select **Create Extension Files**.

    2. Select the **Item Extensions** checkbox.

        > [!NOTE]
        > You may mark the other options as well if you have not created those extensions.

    3. Select **Process**.

    This utility will create the item extension for each item that already exists in your system. If you add new items after you have implemented Field Service, those items will automatically be added for you.

2. If the item extension does exist and you have marked the **Use Current Cost** option in the Item Extensions window, but the cost is still $0.00, then toggle the **Use Current Cost** option.

    1. On the **Cards** menu, point to **Service Call Management**, point to **Extensions**, and then select **Item**.
    2. Select the item where the cost is defaulting as $0.00.
    3. Unmark the option **Use Currenct Cost,** and then select **Save**.
    4. Select the item again.
    5. Mark the option **Use Current Cost,** and then select **Save**.

3. Verify there is a cost available.

    1. On the **Cards** menu, point to **Service Call Management**, point to **Extensions**, and then select **Item**.
    2. Select the item where the cost is defaulting as $0.00.
    3. If the option **Use Current Cost** is not marked, verify an amount is in the **Returned Item Cost** field. This is where the system will look to find the cost on the RMA.
    4. If the **Use Current Cost** field is marked, verify the item has a current cost.
    5. On the **Cards** menu, point to **Inventory**, and then select **Item**.
    6. Select the item and make sure a cost appears in the **Current Cost** field. If the item is FIFO Periodic or LIFO Periodic, make sure there is a cost in the **Standard Cost** field.
