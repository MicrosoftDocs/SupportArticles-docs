---
title: Income Tax calculations or discrepancies with the CRA in Canadian Payroll
description: This article provides information on how income taxes are calculated in Canadian Payroll for Microsoft Dynamics GP, and why the tax calculations in GP may be different than other tax calculators from the Canada Revenue Agency (CRA).
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Income Tax calculations or discrepancies with the CRA in Canadian Payroll for Microsoft Dynamics GP

This article provides information on how income taxes are calculated in Canadian Payroll for Microsoft Dynamics GP, and why the tax calculations in GP may be different than other tax calculators from the Canada Revenue Agency (CRA).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2773319

## Symptoms

This article will address these questions:

- How are taxes calculated in Microsoft Dynamics GP for Canadian Payroll?
- Why would the tax calculations in Microsoft Dynamics GP differ from the online payroll calculator published by the CRA?
- Is the method used for tax calculations in Microsoft Dynamics GP accepted by the CRA?
- Why would the tax calculations for a new hire differ from an existing employee with the same pay?
- Why would the tax calculations for the same employee differ from a payrun done earlier in the year versus a payrun done later in the year?
- If you calculated taxes for each week separately, and then again as a two-week period, why wouldn't the sum of each week equal what the tax calculations are for the two-week period?
- Why doesn't a new hire with no history match the CRA calculations?

## Cause

The CRA accepts different tax calculation methods (as outlined in the link below). The CRA online payroll calculator uses a simple tax calculation method. And Wintod (which is program provided by the Canadian government to calculate taxes) does not take prior history into account and is only an 'estimate'. Microsoft Dynamics GP uses a method called Cumulative Averaging that takes prior pay periods into account, uses a 'projected' annual income established by the date entered, and the number of pay periods that have occurred are factored in. This method does comply within the ranges set by the CRA.

## Resolution

What you are seeing is normal in Microsoft Dynamics GP. The tax calculations in Canadian Payroll are complex and take quite a few factors into account. Microsoft Dynamics GP uses a method called Cumulative Averaging that takes into account prior pay periods, the date used, a projected income and how many pay periods have occurred when finding tax amounts.

For instance, the existence of prior pay runs for that employee will affect the amount of Federal Tax that is withheld in Microsoft Dynamics GP. So you will find different tax amounts calculating if you compare a payrun batch for today, versus 6 months ago for the same employee. Tax calculations in GP do use 'dates' and will vary depending on the dates of the first payrun for that employee. So that is why an existing employee would calculate differently than a new hire with the same pay. You could really only compare taxes for employees that started at the same time and have the same YTD balances, dates, benefits/deductions, etc. or else you can expect differences. You will even see the taxes for a new hire change for each payrun as you go later and later into the year.

The CRA actually defines a 'range' of taxes and not a single number as the tax due. The reason they define a range is because they have more than one method to calculate taxes that is accepted. They use a simpler method that is the same for each period in their calculator, and Microsoft Dynamics GP uses a more complex method that takes past history into account. We have verified with the CRA that the numbers calculated by Microsoft Dynamics GP do comply within their acceptable range. There is a pdf published at the site below to explain Computer Tax Calculations. At the bottom of the site below, click on the link under Effective January 1, 2019 to find the pdf. The method Microsoft Dynamics GP uses is similar to [Option 2 - Tax Formula based on cumulative averaging](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc49) in Chapter 6.

[T4127-JAN Payroll Deductions Formulas - 113th Edition - Effective January 1, 2021](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/)

> [!NOTE]
> For a new hire with no history, you must use the date of January 1 in order to match the CRA calculations. For example, in the first payrun for a new employee, the tax calculation will vary if you enter it dated January 1 versus a date later in the year, as pay periods that have occurred are also taken into account.
