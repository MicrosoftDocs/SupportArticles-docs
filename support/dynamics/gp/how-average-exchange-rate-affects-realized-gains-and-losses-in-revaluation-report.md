---
title: How average exchange rate affects realized gains and losses
description: Explains where the average exchange rate that appears on a revaluation report comes from and how that rate works with the formula in the revaluation report.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# How the average exchange rate affects the realized gains and the realized losses in a revaluation report in Multicurrency

This article describes how the average exchange rate is determined in Multicurrency in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. This article also describes how the average exchange rate affects the realized gains and the realized losses in a revaluation report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946276

## How the average exchange rate is determined

The average exchange rate is determined by the setup of the account that you are revaluing. To set up the account, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Account Currencies**.
2. In the **Account** list, select the account that you want to revalue.
3. Select the **Revalue Account** check box.
4. Use the appropriate method:
   - In the Select Account Currencies window, select **Period Balances**.
   - In the Select Account Currencies window, select **Net Change**.
5. In the **Select** column, select the check box for the currency ID that you want to use.
6. Select **Save**.

If you decide to calculate the revaluation by using the period balances, the revaluation will use the balance of all the periods to create the average exchange rate that is used in the revaluation process. The average exchange rate is calculated by using the period balance figures. The result is a true-weighted average.

If you decide to calculate the revaluation by using the net change, the period balance of the period that you want to revalue is subtracted from the period balance of the prior period. Then, the average exchange rate is calculated. The result is a true-weighted average.

The average exchange rate is compared to the revaluation rate to determine whether a difference exists in the exchange rate. The average exchange rate is also used to print the exchange rate in a revaluation report or in a revaluation journal.

## How the average exchange rate affects the realized gains and the realized losses in a revaluation report

A revaluation report contains two exchange rates. These exchange rates include the exchange rate that was entered for the revaluation and the average exchange rate that was calculated by the system. (The average exchange rate depends on the period balances or on the net change, as explained earlier.)

A revaluation report displays the realized gain or the realized loss for the account that you want to revalue. The exchange rates determine how Microsoft Dynamics GP determines this number. The following is a sample calculation:

- (Originating amount) × (average exchange rate) = functional amount 1
- (Originating amount) × (exchange rate) = functional amount 2
- Functional amount 1 - functional amount 2 = realized gain or realized loss

The first item in the formula represents the exchange rate that is calculated by the system. This average exchange rate depends on either the period balances or on the net change. The second item in the formula uses the exchange rate that was entered during the revaluation process. Then, the two lines are subtracted to provide the realized gain or the realized loss.
