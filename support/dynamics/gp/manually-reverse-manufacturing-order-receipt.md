---
title: Manually reverse a manufacturing order receipt in Manufacturing in Microsoft Dynamics GP
description: Describes how to manually reverse a manufacturing order receipt in Manufacturing in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: theley, ttorgers, beckyber
ms.date: 03/13/2024
ms.custom: sap:Manufacturing Series
---
# How to manually reverse a manufacturing order receipt in Manufacturing in Microsoft Dynamics GP

This article describes how to manually reverse a manufacturing order (MO) receipt in Manufacturing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852725

## Reverse the MO receipt

To manually reverse the MO receipt, follow these steps:

1. On the **Inquiry** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MO Activity**. In the **MO Number** field, click the appropriate MO number.

2. In the **Show Document Type** list, click **IV Transaction**. In the table, locate the first transaction that resulted from an MO (manufacturing order) receipt that includes the backflush of materials and the receipt of finished goods.

3. Double-click the value in the **Document Number** field to open the Inventory Transaction Inquiry window.

4. On the **File** menu, click **Print** to print the Transaction Inquiry Report.

5. Repeat step 2 through step 4 for each transaction in the Manufacturing Order Activity window with the value **IV Transaction** in the **Document Type** column.

6. In the Manufacturing Order Activity window, click **Journal Entry** in the **Show Document Type** list. In the table, locate the first transaction that resulted from an MO receipt that includes the backflush of labor costs and material costs, the backflush of materials, for the receipt of finished goods.

7. Double-click the value in the **Document Number** field to open the Inventory Transaction Inquiry window.

8. On the **File** menu, click **Print** to print the Journal Entry Inquiry Report.

9. Repeat step 6 through step 8 for each transaction in the Manufacturing Order Activity window with the value **Journal Entry** in the **Document Type** column.

10. On the **Transactions** menu, point to **Inventory**, and then click **Transaction Entry**. Enter and post reversing transactions for each transaction printed on the report in step 4. Enter reversing transactions by entering positive values or negative values in the **Quantity** field. Attach a note to record details about the correction.

11. On the **Transactions** menu, point to **Financial**, and then click **General**. In the **Transaction Type** area, click **Reversing**. Enter and post reversing transactions for the journal entries printed on the report in step 8.

> [!NOTE]
> If you post transactions for each journal entry printed on the report in step 8, even the journal entries that resulted from inventory adjustments, then you may want to delete the journal entries that result from the posting of the correcting inventory adjustments.

## Close or cancel the MO, and then remove the MO (Optional)

If you want to close or cancel the MO, and then remove the MO, follow these steps:

1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MOP/SOP Xref**. Remove the Sales Order Processing - Manufacturing Order link.

2. Follow one of these steps:

    - On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MO Close**. Close the appropriate MO.

    - On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **Entry**. Click **Canceled** in the **MO Status** field for the appropriate MO.

3. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Manufacturing**, and then click **Remove MO**.

    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Utilities**, point to **Manufacturing**, and then click **Remove MO**.

4. In the **Manufacturing Order** area, select the appropriate MO. In the **Remove** area, click to select the following check boxes:

    - **Canceled Orders**  
    - **Closed Orders**

5. In the **Last Change Date** area, type the date the MO was received. To determine the date the MO was received, view the last day displayed in the Manufacturing Order Activity window.

6. Click **Process**. When you are prompted to print the Completed Manufacturing Order Removal Report, select the appropriate destination, and then click **OK**.

7. Enter a new MO, and process the appropriate transactions.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
