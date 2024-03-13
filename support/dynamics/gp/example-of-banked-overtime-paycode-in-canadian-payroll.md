---
title: Example of Banked Overtime Paycode in Canadian Payroll
description: The article illustrates how to set up a banked overtime pay accrual in Canadian Payroll with the calculation based on Units in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Example of Banked Overtime Paycode in Canadian Payroll

This article introduces an example of Banked Overtime Paycode in Canadian Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2003424

1. Here's the **BOT** 'banked pay code' setup using a Paycode Applied by Units method. You can also see the REG hourly income pay code.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/bot-banked-pay-code.png" alt-text="Screenshot of a BOT banked pay code setup and the REG pay code.":::

2. Here's the employee **test2** that's created to test with:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-employee-example.png" alt-text="Screenshot of the Payroll Employee test2 setup.":::

3. When you select the **Control** button on the Employee Maintenance window and you can see the following setup:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/settings-details-of-employee.png" alt-text="Screenshot of the setting details of payroll employee control.":::

4. Select the **Paycodes** tab and you will see below paycodes (REG, OT, and BOT) mapped to the employee:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/paycodes-details.png" alt-text="Screenshot of the Payroll Employee Paycodes detail.":::

5. Here are screenprints of each of these paycodes:

    **Hourly**: REG

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/income-paycode-reg.png" alt-text="Screenshot of the income paycode REG detail.":::

    **Overtime code**: OT

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/income-paycode-ot.png" alt-text="Screenshot of the income paycode OT detail.":::

    **Banked Overtime**: BOT

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/banked-paycode-bot.png" alt-text="Screenshot of the banked paycode BOT detail.":::

6. Now you created a batch called **13**: Make sure the batch type and pay periods per year match the employee.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-batch-setup.png" alt-text="Screenshot of the Payroll batch 13 setup details.":::

7. Go to the **Payroll Quick Entry - Canada** window and key a 9 hour transaction for one day at a rate of 25.00 using the **REG** hourly income pay code.

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-quick-entry-details.png" alt-text="Screenshot of Payroll Quick Entry details.":::

8. Then go to **Payroll Generate Overtime - Canada** window and **Generate Overtime** for the batch:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-generate-overtime.png" alt-text="Screenshot of the Payroll Generate Overtime - Canada window.":::

9. Next go to the **Payroll Calculate Batch - Canada** window and **Calculate the Payroll Batch**:

   :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-calculate-batch.png" alt-text="Screenshot of the Payroll Calculate Batch - Canada window.":::

10. Then go to **Reports** > **Payroll-Canada** > **Transactions** > **Calculation Reports** and select the **Detail Advice Slips** button and print to screen.

    > [!NOTE]
    > The BOT banked overtime code has a 1.00 unit record at 37.50, so all of the overtime is banked.

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/print-to-screen.png" alt-text="Screenshot of the detail advice slips screen output.":::

11. Next go to **Payroll Generate Cheques - Canada** and select **Generate Cheques**:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-generate-cheques.png" alt-text="Screenshot of the Payroll Generate Cheques - Canada window.":::

12. Then go to **Payroll Create Poster - Canada** and select **Create  Poster File**:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-create-poster.png" alt-text="Screenshot of the Payroll Create Poster - Canada window.":::

13. Then go to **Payroll Update Masters - Canada** and **Send Poster To G/L** and **Update Masters with Current Payroll Data**.

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-update-masters.png" alt-text="Screenshot of the Payroll Update Masters - Canada window.":::

14. Next, go to **Cards** > **Payroll-Canada** > **Employee**, pull up the **TEST2** Employee ID, and then select the **Banked** button. In the **Payroll Banked Display** window, select **Overtime** as the Banked Pay method. You should see the 1.00 unit entry against the BOT banked paycode:

    :::image type="content" source="media/example-of-banked-overtime-paycode-in-canadian-payroll/payroll-banked-display.png" alt-text="Screenshot of Payroll Banked Display details.":::
