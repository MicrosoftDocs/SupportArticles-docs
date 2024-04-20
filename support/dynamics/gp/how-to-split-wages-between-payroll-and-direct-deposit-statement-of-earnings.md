---
title: How to set up to split wages between payroll check and direct deposit statement of earnings
description: Provides more information about how to set up an employee to split wages between a payroll check and a direct deposit statement of earnings in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# How to set up an employee to split wages between a payroll check and a direct deposit statement of earnings

This article describes how to set up an employee to split wages between a payroll check and a direct deposit statement of earnings in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865437

Follow these steps to set up an employee to split wages between a payroll check and a direct deposit statement of earnings in Microsoft Dynamics GP.

> [!IMPORTANT]
> When you use this workaround, the amount of the linked deduction will not update the Bank Reconciliation module. Because the direct deposit is set up as a deduction, it will not produce an earnings statement. The employee's check stub will show a deduction as part of the payroll. The Payroll module does not treat this as a separate transaction, but as part of the paycheck. Because of this, the direct deposit is not considered income. Rather, it is considered a deduction like any other voluntary withholding the employee has. When you generate the payroll, the direct deposit for the deduction will be included in the ACH file along with the other entries. Only the amount of the check will update Bank Reconciliation. This option is not a good fit if you are using the Bank Reconciliation module. In this scenario, the Bank Reconciliation module will be understated, and you must manually update the Bank Reconciliation module with the amount of the linked deduction each time a payroll is run.
>
> If you post a summary from Direct Deposit to the Bank Reconciliation module, only a withdrawal for the total amount of the direct deposit plus the check is taken. No check will be available to reconcile. To avoid this problem, post by using the Individual Earnings Statements option under Update Bank Reconciliation With in the Direct Deposit Setup window

To set up the deduction, follow these steps:

1. Open the Deduction Setup window. On the Microsoft Dynamics GP menu, select **Tools**, point to **Setup**, point to **Payroll** and select **Deduction**.
2. Set up the direct deposit as you would for any other deduction from the employee's gross wages.
3. If necessary, set a default amount for the deduction.
4. Select **Save**.
5. On the **Tools** menu, point to **Setup**, point to **Payroll** and select **Deduction sequence**. Add the direct deposit deductions to the list of sequenced deductions.
6. Establish a link between deductions and Direct Deposit.

   1. On the Microsoft Dynamics GP menu, select **Tools**, point to **Setup**, point to **Payroll**, select **Direct Deposit** and then select **Links**.
   2. Insert the Direct Deposit deduction.

7. Enroll Individual employees in the deduction direct deposits.
   1. On the **Cards** menu, point to **Payroll**, and then select **Direct Deposit**.
   2. Select the employee you want to set up with a deduction.
   3. Select the **Link deduction** button near the bottom of the window.
   4. Select the deduction you have set up for use with Direct Deposit.

8. Enter bank and account numbers and set the Chk/Svg button. Be sure that the amount or percentage for this amount is correct. This amount will show up as Direct Deposit and the remainder will be in an actual check.

> [!NOTE]
>
> - If an employee is using a deduction direct deposit, the transaction amount can be changed only in the Employee Deduction Maintenance window. To open this window, on the **Cards** menu, point to **Payroll**, and then select **Deduction**.
> - Each deduction direct deposit record you add to the scrolling window on the Employee Direct Deposit Maintenance window is inserted into Line 1 of the scrolling window
> - The remainder of net line number cannot reference a deduction direct deposit link.
> - When you need to have a deduction direct deposit in prenote status, inactivate the account in the Employee Deduction Maintenance window. This prevents the system from deducting the amount with no account to transfer the funds.
