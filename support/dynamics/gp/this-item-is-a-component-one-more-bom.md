---
title: This item is a component on one or more BOM
description: Provides a solution to an error that occurs when you try to delete an inventory item in Manufacturing in Microsoft Dynamics GP.
ms.reviewer: theley, aeckman, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This item is a component on one or more bills of materials" Error message when you try to delete an inventory item in Manufacturing in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to delete an inventory item in Manufacturing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933028

## Symptoms

When you try to delete an inventory item in Manufacturing in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:
> This item is a component on one or more bills of materials. It can't be deleted until you remove it from those bills of materials.

## Cause

This problem occurs if any of the following conditions is true:

- The inventory item has a manufacturing order history. See [Resolution 1](#resolution-1).
- The inventory item is in stock. See [Resolution 2](#resolution-2).
- The inventory item has an inventory history. See [Resolution 3](#resolution-3).
- The inventory item is a component on a bill of materials. See [Resolution 4](#resolution-4).
- The inventory item is a finished good and has a bill of materials. Or, the inventory item is a subassembly on another finished good. See [Resolution 5](#resolution-5).

## Resolution 1

To resolve this problem, locate, close, and then remove the history of the manufacturing orders that include the inventory item that you're trying to delete. To do it, follow these steps:

1. Select **Inquiry**, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **Item Transactions**.
2. Close the manufacturing orders that include the inventory item that you're trying to delete. To do it, use one of the following methods.

    - Method 1

        1. Select **Transactions**, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **MO Close**.
        2. Select a manufacturing order, and then select **Process**.

    - Method 2

        1. Select **Transactions**, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **Edit MO Status**.
        2. Select a manufacturing order, select **Closed** in the **Change MO Status to** list, and then select **Process**.
3. Enter any reverse transactions that you have to process. To do it, select **Transactions**, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **Component Trx Entry**.

    > [!NOTE]
    > This step isn't required.
4. Remove the history of the manufacturing orders. To do it, follow these steps:

    1. On the **Tools** menu, point to **Utilities**, point to **Manufacturing**, and then select **Remove MO**.
    2. In the **From** field and in the **To** field, enter a manufacturing order.
    3. Select the **Canceled Orders** check box.
    4. Select the **Closed Orders** check box, and then select **Process**.

    > [!NOTE]
    > If you want to maintain all the history of the company, create a new company, and then restore the company information in this new company. Then, run the COMPANYID script in the new company to make sure that the IDs are correct. After you run the COMPANYID script, delete the history and the items in the original company. You can use the new company as a reference for the transactions that no longer exist in the original company.

    For more information about the COMPANYID script, see [KB - Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/help/871973).

5. Try to delete the inventory item. If you still receive the error message that is mentioned in the [Symptoms](#symptoms) section, follow the steps in Resolution 2.

## Resolution 2

To resolve this problem, verify that the inventory item isn't in stock. To do it, follow these steps:

1. In the Item Inquiry window, verify that the following fields have a value of zero:

   - **Quantities On Hand**  
   - **Quantities Allocated**  
   - **Quantities Available**
2. If any of these fields doesn't have a value of zero, enter the appropriate transaction to make the value zero.
3. Try to delete the inventory item. If you still receive the error message that is mentioned in the [Symptoms](#symptoms) section, follow the steps in Resolution 3.

## Resolution 3

To resolve this problem, remove the inventory history of the inventory item that you're trying to delete. To do it, follow these steps:

1. On the **Tools** menu, point to **Utilities**, point to **Inventory**, and then select **Remove Transaction History**.
2. In the **From** field and in the **To** field, enter the inventory item.
3. Select the **Remove** check box.
4. Select the **Remove Distributions** check box, and then select **Process**.

    > [!NOTE]
    > If you want to maintain all the history of the company, create a new company, and then restore the company information in this new company. Then, run the COMPANYID script in the new company to make sure that the IDs are correct. After you run the COMPANYID script, delete the history and the items in the original company. You can use the new company as a reference for the transactions that no longer exist in the original company.

    For more information about the COMPANYID script, see [KB - Set up a test company that](https://support.microsoft.com/help/871973).

5. Try to delete the inventory item. If you still receive the error message that is mentioned in the [Symptoms](#symptoms) section, follow the steps in Resolution 4.

## Resolution 4

To resolve this problem, delete the component from all bills of materials. To do it, follow these steps:

1. Select **Inquiry**, point to **Manufacturing**, and then select **BOM View**.
2. Select **Where Used**.
3. In the **Item Number** field, enter the component that you're trying to delete.
4. > [!NOTE]
   > The finished good for all the bills that contain the component.
5. Select **Cards**, point to **Manufacturing**, and then select **Bill of Materials**.
6. In the **Item Number** field, enter a finished good that you noted in step 4.
7. Select the component from the bill, and then select **Remove Item from BOM**. When you're prompted to delete the component, select **Delete**.
8. Repeat step 6 through step 7 until you remove the component from all bills of materials.
9. Try to delete the inventory item. If you still receive the error message that is mentioned in the [Symptoms](#symptoms) section, follow the steps in Resolution 5.

## Resolution 5

To resolve this problem, follow these steps:

1. Select **Inquiry**, point to **Manufacturing**, and then select **BOM View**.
2. Select **Where Used**.
3. In the **Item Number** field, enter the inventory item that you're trying to delete.
4. > [!NOTE]
   > All the bills in which the inventory item is the finished good or a subassembly.
5. Select **Cards**, point to **Manufacturing**, and then select **Bill of Materials**.
6. In the **Item Number** field, enter the finished good or a subassembly that you noted in step 4.
7. Select the component, and then select **Delete**.
8. Repeat step 6 through step 7 until you remove the finished good and the subassemblies from all bills of materials.
9. Try to delete the inventory item. If you still receive the error message that is mentioned in the [Symptoms](#symptoms) section, contact technical support.
