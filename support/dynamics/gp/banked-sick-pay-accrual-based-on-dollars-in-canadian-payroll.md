---
title: Example of Banked Sick Pay Accrual based on Dollars in Canadian Payroll
description: The article shows an example of a Banked Sick paycode accrual based on dollars in CPR.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Example of Banked Sick Pay Accrual based on Dollars in Canadian Payroll

This article shows an example of a Banked Sick paycode accrual based on dollars in Canadian Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2003427

Basically, sick time will be banked. Then you will set up a relief code to use the banked time.

See the below screenshots:

1. Set up a banked sick pay code. (**Tools/setup/Payroll-Canada/Banked Paycodes**). The banked code is what is going to add the accrual information to the banked display window on the employee. So a transaction entered with this code will add a line to the banked display window.

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/set-up-banked-sick-pay-code.png" alt-text="Screenshot of the banked sick pay code entry window. The Description field is set to Banked Sick Pay Accrual.":::

    With this window open, click on **Help**/**About this window**, to learn more about the options in this window.

    *Calculate Based On: Select Dollars or Units. Dollars will use a dollar value, and units will use a percentage.

2. Then set up a relief income code to be used against the banked time. This code will be an Income Code with a reference of Banked Sick Pay. (**Tools**/**Setup**/**Payroll Canada**/**Income Code**) This code will be used to remove time from the banked display window.

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/banked-sick-pay-relief.png" alt-text="Screenshot of the Payroll Income Paycode Setup window. The Description field is Banked Sick Pay Relief. The Reference field is Banked Sick Pay." border="false":::

3. Under **Tools**/**Setup**/**payroll Canada**/**Control**/**Banked**, set up your banked options for either **Stat time**, **Sick Pay**, **Overtime**, or **Leave**:

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/set-up-banked-options.png" alt-text="Screenshot of the Payroll Control Banked window, in which the banked options for Sick Pay are set.":::

4. Under **Cards**/**Payroll-Canada**/**Employee**/**VacSick** tab, you have two options for the employee:

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/two-options-for-the-employee.png" alt-text="Screenshot of the two options for the employee.":::

    These options will accumulate banked sick pay for the employee, and if it should accrue to GL.

5. On the employee's paycode tab, assign the BSICK and BSICKR codes to the employee. Then click on "update" for this code and enter the information. I set my code up to calculate on 'dollars' so the employee will get 1 unit for $20 when he accrues. (If you had selected to calculate on 'units', then the percentage would be used instead.)

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/percentage.png" alt-text="Screenshot of the Payroll Employee Banked window. The Rate field is set to 20 with Units set to 1. The Banked Percentage field shows 5%." border="false":::

6. On the employee's banked tab, this employee does not have any at this point:

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/null-values-on-employee-banked-tab.png" alt-text="Screenshot of the Null values for the employee.":::

7. Then I'll calculate a salary payrun for this salaried employee.
8. Now on the employee's Banked tab, you can see the employee got 1 unit for $20.00.

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/unit-values-on-employee-banked-tab.png" alt-text="Screenshot shows 1 unit for 20 dollars on the employee's Banked tab." border="false":::

9. Since this is a banked code, if I key a quick transaction for 1 unit for $20.00 for 6/1/2017, then it adds it to the banked time and the banked window will show this:

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/quick-transaction-on-employee-banked-tab.png" alt-text="Screenshot shows quick transaction entries on the Banked tab." border="false":::

    > [!NOTE]
    > You can add or delete to the banked code right in this window. (If you are also accruing to GL, then it will not let you add this way.) You can delete a line item in this window

10. To use up the banked time, you can key a transaction against the relief code. So when a user takes the time, it will be entered using the income code. Below I keyed a quick transaction against the BSICKR relief code for $20. But you can see when I did the payrun for it, another accrual processed again for the BSICK code.

    The advice slip shows:

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/advice-slip.png" alt-text="Screenshot of Advice slip, which shows a BSICKR code entry and another BSICK code entry.":::

    So now you can see in the banked window, it took away one line (netted the 6/1/2017 line against the BSICKR used code). Now it added back the new accrual for $20, and still have one remaining line for $20 carried over from before. Unfortunately, it does not track the 'in and out' of the used up transaction (so the 6/1/2017 transaction is removed, but it does show on the advice slip).

    :::image type="content" source="media/banked-sick-pay-accrual-based-on-dollars-in-canadian-payroll/new-banked-window.png" alt-text="Screenshot of the new banked tab with the 6/1/2017 line removed.":::
