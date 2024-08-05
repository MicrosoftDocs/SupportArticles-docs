---
title: How calculates payment amount for scheduled payments
description: How Microsoft Dynamics GP calculates the payment amount for scheduled payments in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# How Microsoft Dynamics GP calculates the payment amount for scheduled payments in Payables Management

his article describes how Microsoft Dynamics GP calculates the payment amount for scheduled payments in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968050

To view the payment amounts for scheduled payments, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Scheduled Payments**.|
2. In the Payables Scheduled Payments Entry window, create an invoice that you want to use in scheduled payments. For example, you specify the invoice as follows:

    - **Invoice Amount**: $10,130.64
    - **Schedule Interest Rate**: 20%
    - **Payment Frequency**: 60

3. Select **Amortization**. After you do this, some data appears in the Payments Amortization Schedule window. In this example, the data that resembles the data in the following table appears in the Payments Amortization Schedule window:

|Payment|Due Date|Payment Amount|Principal|Interest|Principal Balance|
|---|---|---|---|---|---|
|1|5/12/2007|$268.40|$99.56|$168.84|$10,131.08|
|2|6/12/2007|$268.40|$101.22|$167.18|$9,929.86|
|3|7/12/2007|$268.40|$102.90|$165.50|$9,826.96|
|4|8/12/2007|$268.40|$104.62|$163.78|$9,722.34|
|5|9/12/2007|$268.40|$106.36|$162.04|$9,615.98|

To calculate the payment amount, Microsoft Dynamics GP performs the following steps:

1. Obtain the first payment interest.

    The following formula is used to calculate payment interest:

    Interest = (Schedule Amount x Schedule Interest rate) ÷ Payment frequency

    Therefore, the Interest is calculated as follows:

    Interest = (10130.64 x .2) ÷12 (monthly) = 168.84

2. Obtain the monthly payment amount.

    The following annuity formula is used to calculate the monthly payment amount:A =PV ÷ ((1+i)^n - 1) ÷ (i x (1+i)^n)

    > [!NOTE]
    > In this formula, A represents the payment amount, PV represents the principal, i represents the Interest rate (monthly), and n represents the number of payments.

    In this example, PV is equal to 10130.64, i is equal to 0.016667 (.2 ÷12), and n is equal to 60. Therefore, A is equal to 268.40 (268.3999981).

    > [!NOTE]
    > The last payment amount is performed a decimal adjustment. Therefore, the data in the last line is as follows:

    |Payment|Due Date|Payment Amount|Principal|Interest|Principal Balance|
    |---|---|---|---|---|---|
    |60|4/12/2012|$268.32|$263.92|$4.40|$0.00|

3. Continue calculating the entry for the next line until the last payment is reached.

    For example, the data in the second line is calculated as follows:

    - Principal Balance = 10130.64 - 99.56 = 10031.08
    - Interest = 10031.08 x .2 ÷ 12 = 167.18
    - Principal = 268.40 - 167.18 = 101.22
