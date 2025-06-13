---
title: Income Tax calculations or discrepancies with the CRA in Canadian Payroll
description: This article provides information on how income taxes are calculated in Canadian Payroll for Microsoft Dynamics GP, and why the tax calculations in GP might be different than other tax calculators from the Canada Revenue Agency (CRA).
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 06/13/2025
ms.custom: sap:Payroll
---
# Income Tax calculations or discrepancies with the CRA in Canadian Payroll for Microsoft Dynamics GP

This article provides information on how income taxes are calculated in Canadian Payroll for Microsoft Dynamics GP, and why the tax calculations in GP might be different than other tax calculators from the Canada Revenue Agency (CRA).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2773319

## Symptoms

This article addresses these questions:

- How are taxes calculated in Microsoft Dynamics GP for Canadian Payroll?
- Why would the tax calculations in Microsoft Dynamics GP differ from the online payroll calculator published by the CRA?
- Is the method used for tax calculations in Microsoft Dynamics GP accepted by the CRA?
- Why would the tax calculations for a new hire differ from an existing employee with the same pay?
- Why would the tax calculations for the same employee differ from a pay run done earlier in the year versus a pay run done later in the year?
- If you calculated taxes for each week separately, and then again as a two-week period, why wouldn't the sum of each week equal what the tax calculations are for the two-week period?
- Why doesn't a new hire with no history match the CRA calculations?

## Cause

The CRA accepts different tax calculation methods, and these are outlined in [T4127 Payroll Deductions Formulas](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas.html). The [Payroll Deductions Online Calculator (PDOC) provided by CRA](https://apps.cra-arc.gc.ca/ebci/rhpd/beta/entry) uses a simple tax calculation method and provides only an estimate, without considering prior pay history.

Microsoft Dynamics GP uses a method called _Cumulative Averaging_ that takes prior pay periods into account, uses a _projected_ annual income established by the date entered, and the number of pay periods that have occurred are factored in. This method does comply within the ranges set by the CRA.

## Resolution

The tax calculations you see in Microsoft Dynamics GP are expected and correct. The tax calculations in Canadian Payroll are complex and take quite a few factors into account. Microsoft Dynamics GP uses a method called _Cumulative Averaging_ that takes into account prior pay periods, the date used, a _projected_ income and how many pay periods have occurred when finding tax amounts.

For instance, previous pay runs for an employee affects the amount of federal tax withheld in Microsoft Dynamics GP. As a result, the tax calculated for a pay run today might differ from the amount calculated six months ago for the same employee. Tax calculations in GP do use _dates_ and will vary depending on the dates of the first pay run for that employee. This is why an existing employee might have different tax amounts than a new hire with the same pay. You can only expect tax calculations to match for employees who started at the same time and have identical year-to-date balances, dates, benefits, and deductions. Otherwise, differences are expected. You'll even see the taxes for a new hire change for each pay run as the year progresses.

The CRA actually defines a _range_ of taxes and not a single number as the tax due. The reason they define a range is because they have more than one method to calculate taxes that is accepted. They use a simpler method that is the same for each period in their calculator, and Microsoft Dynamics GP uses a more complex method that takes past pay history into account.

We have verified with the CRA that the numbers calculated by Microsoft Dynamics GP do comply within their acceptable range. For more information about computer-based tax calculations, see the PDF available at [T4127 Payroll Deductions Formulas](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas.html). To access the PDF, select the link under "Effective January 1, 2025." The method used by Microsoft Dynamics GP, as described in Chapter 6 of the PDF, is similar to [Option 2 - Tax Formula based on cumulative averaging](https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc49).

> [!NOTE]
> For a new hire with no pay history, you must use the date of January 1 in order to match the CRA calculations. For example, in the first pay run for a new employee, the tax calculation will vary if you enter it dated January 1 versus a date later in the year, as pay periods that have occurred are also taken into account.
