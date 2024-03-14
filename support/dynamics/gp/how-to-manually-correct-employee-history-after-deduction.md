---
title: How to manually correct employee history after deduction
description: Discusses how to manually correct employee history after a pay run was processed with incorrect federal and state tax settings for a deduction in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# How to manually correct the employee history after a deduction has been processed through a pay run as 'subject' to federal and state taxes incorrectly resulting in over withheld tax amounts

If an employee receives a paycheck that did not have the correct taxes withheld, you must correct the employee history. This article describes how to manually correct the employee history after a deduction has been processed through a pay run with the incorrect tax markings for federal and state taxes.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929600

## More information

If the following conditions are true in the employee history, you must make manual adjustments to the employee history:

- A deduction is marked subject to taxes.
- The deduction should have been tax-sheltered from federal and state taxes.

### Resolution

To correct the employee history, you must manually calculate the taxes that must be paid back to the employee. Then, you must process the paycheck through a pay run against an expense account pay code. Then you must process manual adjustments to update the withholding amounts and taxable wages.

- Step 1 - Manually calculate the taxes that must be paid back to the employee
- Step 2 - How to reimburse an employee for taxes that were incorrectly deducted

  1. Select **Tools**, point to **Setup**, point to **Payroll**, and then select **Pay Code**.
  2. In the Pay Code Setup window, set up a new expense account pay code. In the **Description** field, type a description, and then select **Business Expense** in the **Pay Type** list. Make sure that the **Report as Wages** check box is not selected, and then select **Save**.
  3. Select **Cards**, point to **Payroll**, and then select **Pay Code**.
  4. Assign this new pay code to the employees that you want to reimburse.
  5. In the **Pay Rate** box, type the total federal and state taxes that you want to reimburse to the employee.
  6. Select **Save**.
  7. Select **Transactions**, point to **Payroll**, and then select **Transaction Entry**.
  8. In the **Batch ID** field, enter a batch ID.
  9. Enter a transaction for each employee that you want to reimburse.
  10. In the **Code** list, select the expense account pay code that you created in step 2. By default, the amount that appears in the **Amount** field is the amount that you typed in step 5.
  11. Process the payroll batch that you created in step 8, and then select **Post**.

- Step 3 - How to create a transaction to decrease the **federal tax** withheld and the federal taxable wages

  1. Select **Transactions**, point to **Payroll**, and then select **Manual Checks**.
  2. In the Payroll Manual Check-Adjustment Entry window, leave the **Batch ID** field blank. In the **Checkbook ID** field, type the checkbook ID, and then type the check number in the **Check Number** field.
  3. In the **Check Date** field, type a date. This date is used to update month-to-date and year-to-date fields throughout the Payroll module.
  4. In the **Posted Date** field, type a date. This date is used to update the General Ledger module.
  5. Type the Employee ID in the **Employee ID** field.
  6. Select **Transactions**.
  7. In the **Transaction Type** list, select **Federal Tax**.
  8. In the **Amount** box, type the federal taxes to be reduced. Type the amount as a negative amount.
  9. In the **Taxable Wage** box, type the federal taxable wages to be reduced. Type the amount as a negative amount, and then select **Save**.
  10. Close the window.
  11. Select **Save** when you are prompted to save changes to this transaction.
  12. Select **Post**. When you are prompted to print reports, select a destination, and then close the Payroll Manual Check-Adjustment Entry window.
  13. Repeat step 1 though step 12 for each employee you want to adjust.

- Step 4 - How to create a transaction that decreases the **state tax** withheld and the state taxable wages

  1. Select **Transactions**, point to **Payroll**, and then select **Manual Checks**.
  2. In the Payroll Manual Check-Adjustment Entry window, leave the **Batch ID** field blank. In the **Checkbook ID** field, type the checkbook ID, and then type the check number in the **Check Number** field.
  3. In the **Check Date** field, type a date. This date is used to update month-to-date and year-to-date fields throughout the Payroll module.
  4. In the **Posted Date** field, type a date. This date is used to update the General Ledger module.
  5. Type the Employee ID in the **Employee ID** field.
  6. Select **Transactions**.
  7. In the **Transaction Type** list, select **State Tax**.
  8. In the **Code** list, select the appropriate state tax code.
  9. In the **Amount** box, type the state taxes to be reduced. Type the amount as a negative amount.
  10. In the **Taxable Wage** box, type the state taxable wages to be reduced. Type the amount as a negative amount, and then select **Save**.
  11. Close the window.
  12. Select **Save** when you are prompted to save changes to this transaction.
  13. Select **Post**. When you are prompted to print reports, select a destination, and then close the Payroll Manual Check-Adjustment Entry window.
  14. Repeat step 1 through step 13 for each employee that you want to adjust.

### Optional Steps

Verify the General Ledger accounts that are affected, and then make adjusting entries if it is required. The **Net Wages** field will be overstated by the expense account pay code. This field is informational and can be manually edited in the Employee Summary window. To do this, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Payroll**, and then select **Payroll**.
2. In the Payroll Setup window, select **Options**.
3. In the **Options** area, make sure that the **Edit Financial Fields** check box is selected.
4. Select **OK** two times.
5. Select **Cards**, point to **Payroll**, and then select **Summary**.
6. In the **Employee** list, select the employee ID, and then type the year in the **Year** field.
7. In the **Net Wages** field, type the correct amount, and then select **Save**.

> [!NOTE]
> This article describes how to correct employee history after a deduction has been processed through a pay run with incorrect tax markings for federal and state taxes. Similar steps can be followed to correct FICA and local taxes.

For more information, also see the steps in [How to correct over-withholding of employee payroll taxes in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-correct-over-withholding-of-employee-payroll-taxes-in-microsoft-dynamics-gp-c51300f3-0762-1ace-a2fa-1c86c103c0ca).
