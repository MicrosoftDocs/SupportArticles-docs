---
title: Apply a credit memo from Payables Management to an asset
description: Provides information about the ability to apply a credit memo from Payables Management to an asset in Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Information about the ability to apply a credit memo from Payables Management to an asset in Fixed Asset Management

This article describes the ability to apply a credit memo from Payables Management to an asset in Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859456

By design, invoices are the only document types that integrate from Payables Management to Fixed Asset Management. You cannot apply credit memos from Payables Management to an asset that has already been entered into the system. You must alter the cost basis of an asset after it is entered into the system, and change the value in the **Cost Basis** field in the Asset Book window. To do this, follow these steps:

1. On the **Cards** menu, point to **Fixed Assets**, and then select **Book**.

2. In the **Asset ID** field, enter the appropriate asset ID.

3. In the **Book ID** list, select the appropriate book ID.

4. Reduce the value in the **Cost Basis** field by the credit memo.

5. Select **Save**.

6. Select **Yes** when you are prompted to continue.

7. Because the **Cost Basis** field is a depreciation-sensitive field, select one of the following **Reset** options when you are prompted:

   - **Life**: Calculates depreciation from the date it was put in service through the date that the asset was already depreciated. Adjustments to the depreciation for any period are saved and displayed in the Asset Book window.

   - **Year**: Calculates a new yearly depreciation rate and uses the new rate to recalculate depreciation from the beginning of the current fiscal year as defined in the Book Setup window through the date that the asset was already depreciated. Adjustments to the depreciation for any period are saved and displayed in the Asset Book window.

   - **Recalculate**: Calculates a new yearly depreciation rate as of the beginning of the current fiscal year as defined in the Book Setup window. However, calculations are not based on the new rate until the next time depreciation is taken on the asset. The current year-to-date depreciation amount is not affected.
