---
title: Example of Banked Overtime Paycode in Canadian Payroll
description: The article illustrates how to set up a banked overtime pay accrual in Canadian Payroll with the calculation based on Units in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# Example of Banked Overtime Paycode in Canadian Payroll

This article introduces an example of Banked Overtime Paycode in Canadian Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2003424

1. Here's the **BOT** 'banked pay code' setup using a Paycode Applied by Units method. You can also see the REG hourly income pay code.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/bot-banked-pay-code.jpg" alt-text="BOT banked pay code setup":::

2. Here's the employee **test2** that's created to test with:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-employee-example.jpg" alt-text="test with an employee":::

3. When you select the **Control** button on the Employee Maintenance window and you can see the following setup:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/settings-details-of-employee.jpg" alt-text="setting details":::

4. Select the **Paycodes** tab and you will see below paycodes (REG, OT, and BOT) mapped to the employee:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/paycodes-details.jpg" alt-text="paycodes details":::

5. Here are screenprints of each of these paycodes:

    **Hourly**: REG

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/income-paycode-reg.jpg" alt-text="income paycode REG":::

    **Overtime code**: OT

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/income-paycode-ot.jpg" alt-text="income paycode OT":::

    **Banked Overtime**: BOT

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/banked-paycode-bot.jpg" alt-text="banked paycode BOT":::

6. Now you created a batch called **13**: Make sure the batch type and pay periods per year match the employee.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-batch-setup.jpg" alt-text="Payroll batch setup details":::

7. Go to the **Payroll Quick Entry - Canada** window and key a 9 hour transaction for one day at a rate of 25.00 using the **REG** hourly income pay code.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-quick-entry-details.jpg" alt-text="Payroll Quick Entry details":::

8. Then go to **Payroll Generate Overtime - Canada** window and **Generate Overtime** for the batch:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-generate-overtime.jpg" alt-text="Payroll Generate Overtime - Canada":::

9. Next go to the **Payroll Calculate Batch - Canada** window and **Calculate the Payroll Batch**:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-calculate-batch.jpg" alt-text="Payroll Calculate Batch - Canada":::

10. Then go to **Reports** > **Payroll-Canada** > **Transactions** > **Calculation Reports** and select the **Detail Advice Slips** button and print to screen.

    > [!NOTE]
    > The BOT banked overtime code has a 1.00 unit record at 37.50, so all of the overtime is banked.

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/print-to-screen.jpg" alt-text="print the detail advice slips":::

11. Next go to **Payroll Generate Cheques - Canada** and select **Generate Cheques**:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-generate-cheques.jpg" alt-text="Payroll Generate Cheques - Canada":::

12. Then go to **Payroll Create Poster - Canada** and select **Create  Poster File**:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-create-poster.jpg" alt-text="Payroll Create Poster - Canada":::

13. Then go to **Payroll Update Masters - Canada** and **Send Poster To G/L** and **Update Masters with Current Payroll Data**.

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-update-masters.jpg" alt-text="Payroll Update Masters - Canada":::

14. Next, go to **Cards** > **Payroll-Canada** > **Employee**, pull up the **TEST2** Employee ID, and then select the **Banked** button. In the **Payroll Banked Display** window, select **Overtime** as the Banked Pay method. You should see the 1.00 unit entry against the BOT banked paycode:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-banked-display.jpg" alt-text="Payroll Banked Display details":::
