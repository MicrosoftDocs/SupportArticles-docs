---
title: Settlement line is wrong in EFT file for Payables Management
description: Settlement line calculates wrongly in the Electronic Funds Transfer (EFT) file for Payables Management in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Settlement line calculates incorrectly in the Electronic Funds Transfer file for Payables Management

This article provides a resolution for the issue that the Settlement line in the Electronic Funds Transfer (EFT) file only shows the amount of the last invoice.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2026313

## Symptoms

The Settlement line in the EFT file only shows the amount of the last invoice, instead of calculating the correct total amount of the whole file.  This is when you have only one settlement line in the EFT file that should display the sum of the whole file.

## Cause

The calculation method for the payment amount field in the settlement line needs to be changed from a Data Field to a Calculation.

## Resolution

Modify the calculation method in the Settlement line by following these steps:

1. On the **Cards** menu, point to **Financial** and select **EFT File Format**.
2. Enter the **EFT Format ID** that needs to be modified.
3. First, select the **Import/Export** button, and save a copy of the existing format to a location of your choice in case you would need to refer back the original setup for any reason.
4. In the EFT File Format Maintenance window, select the Line Type of **Settlement**.
5. For the payment line, select **Calculation** in the **Maps To** column.
6. Then select the **Show Details** button to expand the line.
7. Set the **Calculation Type** to **Total Debit Amount**.
8. If necessary, select the checkbox for **Remove Decimal Places**.
9. Enter **2** for the **Decimal Places**.
10. Select **Save**.
11. Test the file to make sure the total is correct. (The Settlement line typically starts with 627 in the EFT file.)

    > [!NOTE]
    > When the file is correct, select **Import/Export** again and overwrite the old copy of the file with the new file. It is recommended to keep a copy of the correct file in case you would need to import it back in again for any reason.

## More information

This section explains how to populate the Settlement line with the default settings, and have only one Settlement line for the whole file:

1. In the EFT file format, mark the **Generate Auto-Settlement for Each Detail** checkbox to populate the Settlement line with the default settings.
2. **Save** the EFT file format.
3. Then reopen the EFT file format and unmark the **Generate Auto-Settlement for Each Detail**, and select **Save** when prompted **Settlement details exist for this format. Do you want to save or delete the details?** Then select **OK** on the next message. This will retain the mapping for the Settlement line and result in one settlement line for the whole file, that would include a sum total for the whole file. Then follow the steps in the Resolution section to change the Settlement line from a Data Field to a Calculation so it totals correctly.
