---
title: Unhandled script exception Value of range error when opening purchase order in the Purchase Order Entry window
description: When you open a purchase order in the Purchase Order Entry window in Microsoft Dynamics GP, you receive an Unhandled script exception. Provides a resolution.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Unhandled script exception: Value of range" error when you open a purchase order in the Purchase Order Entry window

This article provides a resolution for the issue that you can't open a purchase order in the Purchase Order Entry window due to an unhandled script exception in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 934698

## Symptoms

When you open a purchase order in the Purchase Order Entry window in Microsoft Dynamics GP, you receive the following error message:

> Unhandled script exception:  
Value of range.
>
> EXCEPTION_CLASS_SCRIPT_OUT_OF_RANGE  
SCRIPT_CMD_SELECTED

## Cause

This problem occurs if the POTYPE value in either of the following tables is set to 0:

- The POP10100 table
- The POP10110 table

Microsoft Dynamics GP cannot read this value because the only possible POTYPE values are as follows:

- 1 = Standard
- 2 = Drop-ship
- 3 = Blanket
- 4 = Drop-ship blanket

> [!NOTE]
> This problem typically occurs if the purchase order is imported into Microsoft Dynamics GP.

## Resolution

To resolve this problem, update the POTYPE value to a valid number. To do this, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Run the following statements against the company database in SQL Query Analyzer. To start SQL Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

   ```sql
   /*PO Header - work*/ Select * from POP10100 where POTYPE = 0 /*PO Line - work */ Select * from POP10110 where POTYPE = 0
   ```

   > [!NOTE]
   > This script flags all the purchase orders that have a POTYPE value of **0**.

2. Run the following statements against the company database in SQL Query Analyzer.

   ```sql
   /*PO Header - work*/ Select * from POP10100 where PONUMBER = 'purchase order number' /*PO Line - work*/ Select * from POP10110 where PONUMBER = 'purchase order number'
   ```

   > [!NOTE]
   >
   > - This script flags the specific purchase order number that is experiencing the problem.
   > - Replace purchase order number with the purchase order number that is experiencing the problem.
   > - Note the DEX_ROW_ID value that is returned for the POP10100 table. This value will be used in step 3.

3. If the POTYPE value is set to zero, update the POTYPE value. To do this, run the following statements against the company database in SQL Query Analyzer.

   ```sql
   Update POP10100 set POTYPE = POTYPE value where DEX_ROW_ID = DEX_ROW_ID number
   ```

   > [!NOTE]
   >
   > - If the POTYPE value is not set to zero, you can copy the POTYPE value from the Purchase Order Line table (POP10110). Make sure that you set the POTYPE value to the correct value. The possible values are listed in the Cause section. You may receive more error messages if the POTYPE values in the POP10100 table and in the POP10110 table do not match.
   > - Replace DEX_ROW_ID number with the appropriate DEX_ROW_ID value that was returned in step 2.

4. Sign in to Microsoft Dynamics GP by using the sa user account. Then, perform the Check Links procedure on the purchasing transactions in Purchasing in Microsoft Dynamics GP. To do this, follow these steps:

    1. Select **File**, point to **Maintenance**, and then select **Check Links**.
    2. In the **Series** list, select **Purchasing**.
    3. Select **Purchasing Transactions**, select **Insert**, and then select **OK**.
    4. Select the **Screen** check box, and then select **OK**.
    5. Verify that you do not receive the error message that is shown in the Symptoms section.
