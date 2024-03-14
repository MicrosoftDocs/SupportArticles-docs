---
title: The standard costs do not change when you roll up
description: This article provides two resolutions for the problem that occurs when you use the incorrect dialog box to roll up and then revalue the standard costs.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Manufacturing Series
---
# The standard costs do not change as expected when you roll up and then revalue standard costs in Manufacturing Order Processing in Microsoft Dynamics GP2010 and GP10.0

This article helps you resolve the problem that occurs when you use the incorrect dialog box to roll up and then revalue the standard costs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912955

## Symptoms

When you roll up and then revalue standard costs in Manufacturing Order Processing in Microsoft Dynamics GP2010 and GP 10.0, the standard costs do not change as expected.

## Cause

This issue occurs when you use the incorrect dialog box to roll up and to then revalue the standard costs.

## Resolution

To resolve this issue, roll up and then revalue costs by using one of the following methods.

### Method 1: Use the "Roll Up and Revalue Inventory" dialog box

1. Enter the revalued costs in the **Standard Item Material Costs** dialog box or in the **Standard Cost Maintenance** dialog box.

    > [!NOTE]
    > You can use the **Standard Item Material Costs** dialog box to revalue items that have the **Replenishment Method** field set to **Buy**. You can use the **Standard Cost Maintenance** dialog box to revalue items that have the **Replenishment Method** field set to **Buy** or to **Make**.

   - To enter the revalued costs in the **Standard Item Material Costs** dialog box, follow these steps:

        1. Click **Cards**, point to **Manufacturing**, point to **Inventory**, and then click **Std Item Mat Costs**.
        2. In the **Standard Item Material Costs** dialog box, enter the revalued costs for the item in the **Pending** area, and then click **Save**.

   - To enter the revalued costs in the **Standard Cost Maintenance** dialog box, follow these steps:

        1. Click **Cards**, point to **Manufacturing**, point to **Inventory**, and then click **Std Cost Maintenance**.
        2. Click to select the **Override** check box.
        3. In the **Override Standard** area, enter the revalued costs for the item, and then click **Save**.

2. Click **Tools**, point to **Routines**, point to **Manufacturing**, and then click **Rollup and Revalue**.
3. Type a date in the **Roll up Date** field.
4. Click **Roll Up**, and then click **Process**.
5. When you receive the following message, click **OK**: Rollup Complete.
6. When you are prompted to print the Item Proposed Cost Revaluation Report, select a print destination, and then click **OK**. If you do not want to print the report, click **Cancel**.
7. Click **Revalue**, and then click **Process**.
8. When you receive the following message, click **OK**: A standard cost revaluation batch was created. Standard unit cost changes will take effect.

### Method 2: Use the "Standard Cost Changes" dialog box

1. Click **Cards**, point to **Manufacturing**, point to **Inventory**, and then click **Standard Cost Changes**.
2. Enter the revalued costs for the item in the **Proposed Standard Cost** column, and then click **Save**.
3. In the **Standard Cost Changes** dialog box, click **Roll Up**.
4. When you are prompted to save changes, click **Save**.
5. When you receive the following message, click **OK**: Rollup Complete.
6. When you are prompted to print the Item Proposed Cost Revaluation Report, select a print destination, and then click **OK**. If you do not want to print the report, click **Cancel**.
7. In the **Standard Cost Changes** dialog box, click **Replace Costs**.
8. When you receive the following message, click **OK**: A standard cost revaluation batch was created. Standard unit cost changes will take effect.
9. When you receive the following message, click **OK**: All proposed costs have been deleted.
