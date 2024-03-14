---
title: Payroll deductions aren't taken
description: Provides more information about why payroll deductions aren't included when checks are calculated in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# Payroll deductions aren't taken in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865480

## Symptoms

The payroll deductions aren't being subtracted when checks are calculated in Microsoft Dynamics GP.

## Resolution

These are some typical situations that would cause the deductions not to be included:

1. The deduction was marked as **Transaction Required** in the **Employee Deduction Maintenance** window. (**Cards** > **Payroll** > **Deduction**). If so, a transaction must be entered for the deduction in the **Payroll Transaction Entry** window, or the **Transaction Required** field can be unmarked.

2. The date in the **Start Date** field in the **Employee Deduction Maintenance** window hasn't been reached.

3. The deduction wasn't based on a Pay Code that is being included on this check run. The deduction will show on the **Build Check** and **Calculate Check** reports, but the **Calculate Check** report will show the amount as $0.

4. You may not be including the deductions in the **Build Payroll Checks** window. (**Transactions** > **Payroll** > **Build Checks**). This would only apply if the deduction isn't marked as **Transaction Required**.

5. If you have a minimum net pay amount set up for the employee, (**Cards** > **Payroll** > **Employee** > **Additional Information**) and the deductions brings the net pay below the minimum net pay, the deductions that are sequenced last won't be taken.

6. If you have set up the deduction as a tiered deduction and in the **deduction amount** field you have $0.00 entered, the deduction won't be taken.

7. The date in the **End Date** field in the **Employee Deduction Maintenance** window falls before the beginning date of the pay runs the deduction wouldn't be included.

8. If you've reached any of the maximums entered in the **Employee Deduction Maintenance** window, the deduction wouldn't be taken.

9. If the deduction brings the pay to a negative amount, it will not be taken.

10. If the deduction is inactive, it will not be taken.

11. If the Employee has a **Minimum Net Pay** set, the deduction won't be taken if it causes the net pay to fall below this amount. Select **Cards**, point to **Payroll**, and select **Employee Card**. Enter the **Employee ID**. Select the **Additional Information** tab, and review the **Minimum Net Pay** field.

12. Check to see if the tax settings are mismatched between the deduction and the paycodes for the Employee. For example, if the deduction is set to be TSA sheltered from FICA taxes, but the employee doesn't have any paycodes that are subject to having FICA taxes taken on them, then the deduction won't be taken. Review for **Federal Tax**, **FICA Tax**, **State Tax**, and **Local Tax** settings between the deduction and the employee's paycodes used in the payrun.

    > [!NOTE]
    > If a change in the maximum is not being recognized, and/or this is a retirement plan and you have 'Enhancement Retirement Plans' installed from Integrity Data (where you can combine deductions together for one maximum) or any other 3rd party product with payroll deductions, be sure to check the maximums for that product. You will need to reach out to that ISV for further assistance. To contact Integrity Data.

13. Check to see if there's an **Additional Withholding** setup that may be taking up most of the check amount, causing the deduction to drop off.
