---
title: How to use negative deductions to adjust employee records
description: Describes the method to use negative deductions to adjust employee records in Payroll in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use negative deductions to adjust employee records in Payroll in Microsoft Dynamics GP

This article describes how to use negative deductions to adjust employee records in Payroll in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains when a deduction is over-withheld.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968014

To use negative deductions to adjust employee records, follow these steps:

1. If a deduction was entered for an incorrect period, create a negative manual check for the deduction in the Payroll Manual Check-Adjustment Entry window. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Manual Checks**.
    2. In the **Check Type** area, select **Manual Check**.
    3. Leave the **Batch ID** field blank.
    4. Change the date in the **Check Date** field to the check date from the pay run in which the deduction was originally withheld incorrectly.
    5. In the **Check Number** field, use the default check number, or type the check number that you want to use.
    6. In the **Employee ID** field, enter the employee ID.
    7. Select **Transactions**.
    8. In the Payroll Manual Check Transaction Entry window, select **Deduction** in the **Transaction Type** drop-down list, and then enter the deduction code that you want to update in the **Code** field.
    9. In the **Date From** field, enter an appropriate date.
    10. In the **Date To** field, enter an appropriate date.
    11. In the **Amount** field, type the amount that you want to adjust for the deduction.
    12. Select **Save**.
    13. Close the Payroll Manual Check Transaction Entry window.
    14. In the Payroll Manual Check-Adjustment Entry window, select **Post**.

2. Create a second manual check for a positive adjustment by using the posting date in which the deduction should have been taken. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Manual Checks**.
    2. In the **Check Type** area, select **Manual Check**.
    3. In the **Check Date** field, enter the check date in which the deduction should have been taken.
    4. In the **Check Number** field, use the default check number, or type the check number that you want to use.
    5. In the **Employee ID** field, enter the employee ID.
    6. Select **Transactions**.
    7. In the Payroll Manual Check Transaction Entry window, select **Deduction** in the **Transaction Type** drop-down list, and then enter the deduction code that you want to update in the **Code** field.
    8. In the **Date From** field, enter an appropriate date.
    9. In the **Date To** field, enter an appropriate date.
    10. In the **Amount** field, type the amount that you want to adjust for the deduction.
    11. Select **Save**.
    12. Close the Payroll Manual Check Transaction Entry window.
    13. In the Payroll Manual Check-Adjustment Entry window, select **Post**.

For more information about how to correct over-withholding of employee payroll taxes, see [How to correct over-withholding of employee payroll taxes in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-correct-over-withholding-of-employee-payroll-taxes-in-microsoft-dynamics-gp-c51300f3-0762-1ace-a2fa-1c86c103c0ca).
