---
title: How payment amount for scheduled payment is calculated
description: Describes how the system calculates the payment amount for a scheduled payment in Receivables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# Information about how the payment amount for a scheduled payment is calculated in Receivables Management

This article contains information on how the system calculates the payment amount for a scheduled payment in Receivables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968049

## More information

### Information about the scheduled payment

A scheduled payment is created from a posted sales/invoice document, a debit memo document, or a service/repair document in the Receivables Scheduled Payment Entry window. To open this window, on the **Transactions** menu, point to **Sales**, and then select **Scheduled Payments**.

Consider the following example: If you keyed a sales document for $10,130.64, you can make it a scheduled payment in the Receivables Scheduled Payments Entry window by entering this additional information:

- **Interest Type**: Compound
- **Schedule Amount**: $ 10,130.64
- **Schedule Interest Rate**: 20%
- **Payment Frequency**: Monthly
- **Number of Payments**: 60

Select **Calculate** and then select **Amortization** to view the 60 lines in the amortization schedule. The first five lines will be displayed as follows:

|Payment|Due Date|Payment Amount|Principal|Interest|Principal Balance|
|---|---|---|---|---|---|
|1|5/12/2009|$268.40|$99.56|$168.84|$11,131.08|
|2|6/12/2009|$268.40|$101.12|$167.18|$9,929.86|
|3|7/12/2009|$268.40|$102.90|$165.50|$9,826.96|
|4|8/12/2009|$268.40|$104.62|$163.78|$9,722.34|
|5|9/12/2009|$268.40|$106.36|$162.01|$9.615.98|

### First payment interest information

The following equation is used to calculate the first payment interest amount:

```console
Interest amount = schedule amount x schedule interest rate / payment frequency
```

The following example shows how the first payment interest amount is calculated:

```console
Interest = $10,130.64 x .20 /12(monthly)
```

The interest amount in this calculation is $168.84.

### Monthly payment amount

The following equation is used to calculate the monthly payment amount:

```console
Monthly Payment amount = Principal amount 
/ (1 + monthly interest rate) to the N power - 1 
/ monthly interest rate X (1 + monthly interest rate) to the N power.
```

> [!NOTE]
> In this equation, replace the placeholder N with the number of payments.

The following example shows how the monthly payment amount is calculated:

- principal amount: $10,130.64
- monthly interest rate: 0.20/12 = 0.016667
- number of payments: 60

By using the information in this example, the following equation is used to calculate the monthly payment amount.

```console
monthly payment amount = $10,130.64 / (1.016667) to the 60th power - 1 / .01667 x (1.016667) to the 60th power.
```

The payment amount in this calculation is $268.40.

> [!NOTE]
> The last payment will make a decimal adjustment on the Payment Amount if it is needed. In this example the Payment Amount for Payment 60 is $268.32 instead of $268.40. The last payment will also show the Principle Balance as $0.00 as it has been fully paid.
