---
title: Correct differences between federal wages
description: This article discusses why there may be differences in federal wages between Form 941 and the Payroll Summary report. This article also describes how to correct these differences.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Correcting differences between federal wages in Form 941 and in the Payroll Summary report in Microsoft Dynamics GP

This article discusses why there may be differences in federal wages between Form 941 and the Payroll Summary report. This article also describes how to correct these differences in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862929

## Introduction

Form 941 and the Payroll Summary report use information from the tables that are described in this section. To calculate the "Total Wages and Tips" amount, and to calculate other compensation on line 2 of Form 941, Microsoft Dynamics GP does the following calculation:

Total Wages and Tips = A + B - C + D - E

> [!NOTE]
> The 941 pulls detailed figures from the UPR30300 table, which should match the UPR30301 table. The below Summary paths direct you to windows to view the Summary totals by month, and assume they match the UPR30300. Running the Payroll reconcile utility will update the Summary table totals to match the detail.

- Amount A is the **Gross Wage** amount in the Employee Summary window (UPR00900). To open this window, select **Cards**, select **Payroll**, and then select **Summary**.
- Amount B is the **Reported Tips** amount and the **Charged Tips** amount in the Employee Tips Summary window (UPR00901). To open this window, select **Cards**, select **Payroll**, select **Summary**, and then select **Tips**.
- Amount C is the pension wages amount in the Employee Pay Code Summary window (UPR30301). To open this window, select **Cards**, select **Payroll**, select **Pay Code**, and then select **Summary**.

    > [!NOTE]
    > This amount is used only if the pay code has a **Pension Pay** type.
- Amount D is the **Taxable Benefit** amount in the Employee Benefit Summary window (UPR30301). To open this window, select **Cards**, select **Payroll**, select **Benefit**, and then select **Summary**.

- Amount E is the deductions that are sheltered from federal tax in the Employee Deduction Summary window (UPR30301). To open this window, select **Cards**, select **Payroll**, select **Deduction**, and then select **Summary**.

## More information

The federal wages amount in the Payroll Summary report is from the Check History table (UPR30100). The **Federal Wages** field is in the Employee Summary window. To open the Employee Summary window, select **Cards**, select **Payroll**, and then select **Summary**. The federal wages amount is informational. This amount isn't used in the 941 report or in the Payroll Summary report. The amount isn't used during the year-end calculation. Federal wages can be printed in the Detailed Employee list only.

If the federal wages amounts in Form 941 and in the Payroll Summary report are different, follow these steps:

1. Make sure that the amounts in the Check History table are the same as the amounts in the Employee Summary table. To do it, follow these steps:
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Payroll**, and then select **Reconcile**.
        - In Microsoft Dynamics GP 9.0, point to **Utilities** on the **Tools** menu, point to **Payroll**, and then select **Reconcile**.
    2. In the **Year** list, select the year, and then select the **Print Report** check box. Don't select the **Reconcile** check box because you must verify that the amounts are correct in the report before you reconcile.

    3. Print the report. If federal wages aren't displayed in the reconcile report, go to step 2.

2. A deduction, a benefit, or a pay code may have been changed so that it's taxed instead of not being taxed, or vice versa. This change causes a difference in federal wages in Form 941 and in the Payroll Summary report. This change isn't corrected during the reconcile process.

    Consider the following example. In this example, the only checks in Microsoft Dynamics GP are the following checks:

    - A check for the pay runs on January 9. The check contains the following amounts:
        - $15 deduction amount
        - $1,000 gross wages
    - A check for the pay runs on January 23. The check contains the following amounts:
        - $15 deduction amount
        - $1,000 gross wages

    You notice that the tax status for the deduction is set up incorrectly. Then, on January 10, the tax status for the deduction is changed so that the deduction is sheltered from federal taxes. The tax status is changed by updating the UPR00500 table so that the table is sheltered from federal taxes. The following information is displayed in the Check History table (UPR30100) for federal wages. Federal wages are equal to the gross wages minus the tax sheltered deductions:

    - January 9 - $1,000
    - January 23 - $985

    However, on Form 941 for this employee's two checks, federal wages are $1,970. This amount is equal to $985 plus $985. This result occurs because Microsoft Dynamics GP subtracts the following amounts from the gross wages in the Employee Summary window:  
    The deduction amounts that are marked as sheltered from federal taxes at the time that the report is run

    The calculation subtracts both $15 amounts for the deduction. The **Federal Wages** field in the Employee Summary window isn't changed from the original amount. Similar changes to the tax status for benefits and for pay codes cause similar differences in federal wages.

To correct federal wages that are incorrect in the Employee Summary window and in the Check History table, follow these steps:

1. Select **Transactions**, select **Payroll**, and then select **Manual Checks**. Don't include this transaction in a batch, because negative transactions must be posted individually. Select the employee ID for an employee whose information must be changed, and then select **Transactions**.

2. In the **Transaction Type** list, select **Pay Code**, and then open the newly created pay code. Type a negative amount for federal wages that must be adjusted.

3. Save the transaction, and then close the window. Post the employee's transaction in the Payroll Manual Check-Adjustment Entry window.

4. Repeat steps 3 through 5 for each employee whose federal wages must be changed.

    > [!NOTE]
    > If the liability amount will be changed, you may have to manually enter the adjustment transactions in the general ledger. And, you may have to manually post the adjustment transactions in the general ledger.

## References

For more information, see [Incorrect calculations on the Payroll 941 Quarterly Summary Report in Microsoft Dynamics GP](https://support.microsoft.com/help/2249718).
