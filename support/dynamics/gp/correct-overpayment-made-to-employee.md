---
title: Correct an overpayment that's made to an employee in Payroll in Microsoft Dynamics GP
description: Provides steps to correct an overpayment that was made to an employee in Payroll in Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to correct an overpayment that is made to an employee in Payroll in Microsoft Dynamics GP

This article describes how to correct an overpayment that is made to an employee in Payroll in Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937245

To correct an overpayment to an employee, use one of the following methods.

## Method 1

Collect a check from the employee for the overpaid amount. Then, enter a negative manual check for the employee pay code that has the overpayment. To do this, follow these steps:

1. Click **Transactions**, point to **Payroll**, and then click **Manual Checks**.
2. In the **Payroll Manual Check-Adjustment Entry** window, click **Manual Check** in the **Check Type** area.
3. Click the lookup button next to the **Checkbook ID** field, and then double-click the payroll checkbook ID.
4. In the **Check Number** field, type a check number.
5. In the **Check Date** field and in the **Posted Date** field, type the appropriate date.
6. In the **Employee ID** list, click an employee ID.
7. Click **Transactions**.
8. In the Payroll Manual Check Transaction Entry window, click the appropriate transaction type in the **Transaction Type** list.

    > [!NOTE]
    > You must select an appropriate transaction type to enter corrections for pay codes, for taxes, and for deductions. Each transaction type requires an entry.
9. Type the date in the **Date From** field and in the **Date To** field. The dates must match the original payroll dates.
10. In the **Amount** field, type the correcting values.

    > [!NOTE]
    > If the code was overpaid, enter the amount as a negative value. If the code was underpaid, enter the amount as a positive value.
11. If you are correcting taxes, type the appropriate correction value in the **Taxable Wage** field for the tax or for the deduction. The correction value should correct the taxable wage amount through the end of the year.
12. Click **Save**.
13. Repeat steps 7 through 11 until all entries have been completed for the employee.
14. Close the Payroll Manual Check Transaction Entry window. Then click **Post**.

## Method 2

Set up a deduction that withholds the overpayment amount for the employee. Then, include that deduction in the next payroll. After you process the payroll together with this deduction, enter a negative manual check for the pay code and for the deductions to correct the employee summary information. To do this, follow these steps:

1. Follow the appropriate step:
   - If you are using Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then click **Deduction**.
   - If you are using Microsoft Dynamics GP 9.0 or an earlier version, point to **Setup** on the **Tools** menu, point to **Payroll**, and then click **Deduction**.
2. Create a deduction code that can be assigned to the employee to withhold the overpayment amount. Then click **Save**.
3. Click **Cards**, point **Payroll**, and then click **Deduction**.
4. Click the lookup button next to the **Employee ID** field, and then double-click the employee who was overpaid.
5. Click the lookup button next to the **Deduction** field, and then double-click the deduction that was created in step 2.
6. Click **Save**.
7. Process the payroll as usual. Include the deduction that you assigned to the employee in the previous steps.

After the payroll is processed, the amount that was overpaid to the employee is withheld because of the deduction. You can now take the following actions:

- Enter a negative manual check to reduce the amount that is taken for the deduction.
- Reduce the original pay code for the overpayment.

To do this, follow these steps:

1. Click **Transactions**, point to **Payroll**, and then click **Manual Checks**.
2. In the Payroll Manual Check-Adjustment Entry window, click **Manual Check** in the **Check Type** area.
3. Click the lookup button next to the **Checkbook ID** field, and then double-click the payroll checkbook ID.
4. In the **Check Number** field, type a check number.
5. In the **Check Date** field and in the **Posted Date** field, type the appropriate date.
6. In the **Employee ID** list, click an employee ID.
7. Click **Transactions**.
8. In the Payroll Manual Check Transaction Entry window, click the appropriate transaction type in the **Transaction Type** list.

    > [!NOTE]
    > You must select an appropriate transaction type to enter corrections for pay codes, for taxes, and for deductions. Each transaction type requires an entry.
9. In the **Date From** field and in the **Date To** field, type the appropriate dates. The dates must match the original payroll dates.
10. In the **Amount** field, type the correcting values.

    > [!NOTE]
    > If the code was overpaid, enter the amount as a negative value. If the code was underpaid, enter the amount as a positive value.
11. If you are correcting taxes, type the appropriate correction value in the **Taxable Wage** field for the tax or for the deduction. The correction value should correct the taxable wage amount through the end of the year.
12. Click **Save**.
13. Repeat steps 2 through 12 until all entries have been made for an employee.
14. Close the Payroll Manual Check Transaction Entry window. Then click **Post**.
