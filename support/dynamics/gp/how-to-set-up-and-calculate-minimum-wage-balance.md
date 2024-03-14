---
title: How to set up and calculate the minimum wage balance
description: Describes how to set up and calculate the minimum wage balance in Microsoft Dynamics GP.
ms.reviewer: lmuelle, theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# How to set up and calculate the minimum wage balance in Microsoft Dynamics GP

This article describes how to set up and calculate the minimum wage balance in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865588

## More information

To set up and calculate the minimum wage balance, follow these steps:

1. Set up a minimum wage balance pay code.

    On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Payroll**, and then select **Paycode**.

2. Enter or select a pay code, and then enter a description in the **Description** box.
3. In the **Pay Type** list, select **Minimum Wage Balance**.
4. In the **Pay Rate** box, enter a pay rate. The pay rate is the minimum hourly rate the employee must receive.
5. In the **Pay Period** list, select a pay period.
6. In the **Subject to Taxes** section, select the check boxes that are required for the pay code.
7. To save the pay code setup, select **Save**.
8. Set the employee card to use minimum wage balance by taking these steps:

    1. On the **Cards** menu, point to **Payroll**, and then select **Employee**.
    2. In the **Employee Maintenance** window, select **Additional Information**.
    3. In the **Employee Additional Information Maintenance** window, select the **Calculate Minimum Wage Balance** check box.
    4. Select **OK** to save the changes.

9. Assign the pay code to the employee by taking these steps:

   1. On the **Cards** menu, point to **Payroll**, and then select **Pay Code**.
   2. In the **Employee Pay Code Maintenance** window, select or enter the employee ID.
   3. In the **Pay Code** list, select **Minimum Wage Balance**.
   4. Select **Save** to save the changes.

> [!NOTE]
> You may not create a transaction by using the minimum wage balance pay code.

### Examples

For the following examples, the employee is assigned the following:

- The Hourly pay code at a rate of $2.00.
- The Reported Tips pay code.
- The Minimum Wage Balance pay code at a rate of $5.50.

> [!NOTE]
> Business Expense pay isn't included in the minimum wage balance, nor is the retroactive pay calculation.

#### Example 1

An employee receives a pay rate equal to minimum wage during training. The pay rate in the Hourly pay code is set to a wage of $5.50, and therefore no minimum wage balance is calculated or appears on the pay stub.

#### Example 2

An employee has worked 40 hours during the week. A transaction is entered for the Hourly pay code for 40 hours. The build finds that the minimum pay of $220 won't be met by using the transactions that were created. So, the employee pay stub includes the Hourly pay code at $80.00 and the minimum wage balance pay code at $140 ($220-$80). The calculated gross wages for the employee are $220.00.

#### Example 3

An employee has worked 40 hours during the week. The employee received $100 in tips. A transaction is entered for the Hourly pay code at 40 hours, and the Reported Tips pay code at $100.00. The build finds that the minimum pay of $220 won't be met by using the transactions that were created, and it calculates a minimum wage balance of $40. Therefore, the employee pay stub includes the Hourly pay code at $80.00, the Reported Tip pay code at $100.00, and a minimum wage balance of $40. The calculated gross wages for the employee are $120.00 ($80+$40).

#### Example 4

An employee has worked 40 hours during the week. The employee received $200 in tips. A transaction entry is created for the Hourly pay code at 40 hours, and the Reported Tips pay code at $200.00. The build finds that the minimum pay will be met by using the transactions that were created. Therefore, the employee pay stub includes the Hourly pay code at $80.00 and the Reported Tip pay code at $200.00. The calculated gross wages for the employee are $80.00.
