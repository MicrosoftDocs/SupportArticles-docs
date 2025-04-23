---
title: How to correct over-withholding of employee payroll taxes
description: Describes how to correct over-withholding of employee payroll taxes in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# How to correct over-withholding of employee payroll taxes in Microsoft Dynamics GP

This article describes how to correct over-withholding of employee payroll taxes in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858712

To correct the mistake of over-withholding payroll taxes from an employee in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Pay Code**.
2. Create a new pay code that has a pay type of **Business Expense**. (This is the only pay type that allows you to not include it as wages again.)  To do this, follow these steps.

    > [!NOTE]
    > This pay code will be used to repay the amount that was over-withheld from the employee. If you have an existing pay code that you want to use, you can skip this step.

    1. In the **Subject to Taxes** section, clear all the check boxes that are listed.
    2. Make sure that there is no **Workers Compensation Code** listed.
    3. Clear the **Accrue Vacation** check box and the **Accrue Sick Time** check box.
    4. Clear the **Report Wages** check box. When you clear this check box, the money that you refunded is not added to their gross wages. Additionally, it is not used when taxes are calculated.

3. On the **Cards** menu, point to **Payroll**, and then select **Pay Code**.
4. In the **Employee ID** field, select the employee who had taxes over-withheld.
5. In the **Pay Code** field, select the pay code from step 2.
6. Select **Save**.
7. Complete steps 3 to 6 for each employee who has to be refunded.
8. On the **Transactions** menu, point to **Payroll**, and then select **Transaction Entry**.
9. In the Payroll Transaction Entry window, enter a batch ID in the **Batch ID** field.
10. Enter a transaction for each employee who needs a refund. Make sure that you select **Pay Code** in the **Trx Type** field, and then select the pay code for the business expense type that you created in step 2 in the **Code** field. Enter the amount to refund the employee in the **amount** field.
11. Close the Payroll Transaction Entry window. When you are prompted, print the Payroll Transaction Audit report to verify that everything is correct.
12. If everything is correct on the Payroll Transaction Audit report, build the checks. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Build Checks**.
    2. Specify a date range for the build in the **Pay Period Date** section.
    3. Select **Include Deductions**, select the **None** option, and then select **OK**.
    4. Select **Include Benefits**, select the **None** option, and then select **OK**.
    5. Select **Select Batches**, select the batch ID that you saved the transactions to in step 9, and then select **OK**.
    6. In the Build Payroll Checks window, select **Build**.
    7. Print the Build Check File report to verify that everything is correct and that there are no errors.
13. On the **Transactions** menu, point to **Payroll**, and then select **Calculate Checks**.
14. Select **OK**, and then print the Precheck Report to verify that everything is correct.
15. On the **Transactions** menu, point to **Payroll**, and then select **Print Checks**.
16. Select the **Checks** option, and then select **Print** to create the refund checks for the employees.
17. In the Post Payroll Checks window, select **Process** to post the checks. When you are prompted, print the posting journal reports and verify that nothing was updated other than the amount that the employee is being paid. All other deduction reports and tax reports should display $0.

18. Manually adjust the tax withholding amount and the taxable wage amount in the Payroll Manual Check-Adjustment Entry window. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Manual Checks**.
    2. In the **Check Type** section, select the **Manual Check** option.

        > [!NOTE]
        > Do not enter a batch ID for this transaction.
    3. In the **Employee ID** field, select the employee ID that you want to update, and then select **Transactions**.
    4. In the **Transaction Type** list, select the tax type that has to be adjusted. If it is applicable, select the appropriate code in the **Code** field that corresponds to that tax type.
    5. In the **Amount** field, enter the over-withheld tax amount as a negative amount.

        > [!NOTE]
        > This step reduces the tax withheld amount as necessary.
    6. In the **Taxable Wages** field, enter the taxable wages amount as a negative amount.

       > [!NOTE]
       > This step reduces the taxable wages for the employee.
    7. Select **Save**, and then close the window.
    8. In the Payroll Manual Check-Adjustment Entry window, select **Post**.
    9. Repeat steps 18a to 18h for each employee to be adjusted.

19. Manually adjust the employee net wages in the Payroll Manual Check-Adjustment Entry window. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Manual Checks**.
    2. In the **Check Type** section, select the **Manual Check** option.

        > [!NOTE]
        > Do not enter a batch ID for this transaction.

    3. In the **Employee ID** field, select the employee ID that you want to update, and then select **Transactions**.
    4. In the **Transaction Type** list, select the pay code that has to be adjusted.
    5. In the **Amount** field, enter the amount that was refunded to the employee as a negative number.
    6. Select **Save**, and then close the window.
    7. In the Payroll Manual Check-Adjustment Entry window, select **Post**.
    8. Repeat steps 19a through 19g for each employee to be adjusted.

For more information, also see the steps in [How to manually correct the employee history after a deduction has been processed through a pay run as 'subject' to federal and state taxes incorrectly resulting in over withheld tax amounts in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-how-to-manually-correct-the-employee-history-after-a-deduction-has-been-processed-through-a-pay-run-as-subject-to-federal-and-state-taxes-incorrectly-resulting-in-over-withheld-tax-amounts-in-microsoft-dynamics-gp-fb5ced69-3c43-5463-b363-65dc33cbc564).
