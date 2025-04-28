---
title: The order in which payroll checks are calculated in Payroll
description: This article describes the order in which payroll checks are calculated in Payroll in Microsoft Dynamics GP.
ms.reviewer: theley, v-amflo
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# Description of the order in which payroll checks are calculated in Payroll in Microsoft Dynamics GP

This article describes the order in which payroll checks are calculated in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933020

## Introduction

This article describes the order in which payroll checks are calculated in Payroll in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

## More information

A typical payroll check is calculated in the following order:

1. Microsoft Dynamics GP calculates the gross pay amount by totaling the amounts for all the pay codes.
2. Microsoft Dynamics GP calculates the value of all the taxable benefits. This calculation does not affect the gross pay or the net pay.
3. Microsoft Dynamics GP then deducts amounts for any tax-sheltered annuities (TSA) that are specified for the employee.
4. Microsoft Dynamics GP calculates the value of any earned-income credit (EIC) payments. This calculation affects the gross pay.
5. Microsoft Dynamics GP deducts taxes in the following order: FICA Social Security, FICA Medicare, federal taxes, state taxes, and local taxes from the gross pay amount.
6. Microsoft Dynamics GP deducts amounts for any sequenced deductions.
7. Microsoft Dynamics GP deducts amounts for any non-sequenced deductions in alphanumeric order.
8. Microsoft Dynamics GP adds or deducts amounts for any nontaxable benefits. This amount does not affect the gross pay or the net pay.
9. Microsoft Dynamics GP deducts amounts for any advance paybacks.
10. The total equals the net pay.

A payroll check is calculated in the following order when an employee has a minimum net pay amount:

1. Microsoft Dynamics GP calculates the gross pay amount by totaling the amounts for all the pay codes.
2. Microsoft Dynamics GP calculates the value of all the taxable benefits. This calculation does not affect the gross pay or the net pay.
3. Microsoft Dynamics GP then deducts amounts for any tax-sheltered annuities that are specified for the employee.
4. Microsoft Dynamics GP calculates the value of any earned-income credit payments. This calculation affects the gross pay.
5. Microsoft Dynamics GP deducts federal income tax, the FICA tax, state taxes, and local taxes from the gross pay amount.</br></br> **Note** At this point, tax-sheltered annuities, and deductions are evaluated against the minimum net pay amount to see how much tax should be included. If there is a tax-sheltered annuity and the whole tax-sheltered annuity cannot be used, the gross pay reductions must be recalculated. The taxes must also be recalculated. All other deductions will be taken down to the minimum net pay amount, in the following order:
    1. Microsoft Dynamics GP deducts amounts for any sequenced deductions.
    1. Microsoft Dynamics GP deducts amounts for any non-sequenced deductions in alphanumeric order.
    1. Microsoft Dynamics GP adds or deducts amounts for any nontaxable benefits. This amount does not affect the gross pay or the net pay.
    1. Microsoft Dynamics GP deducts amounts for any advance paybacks.
    1. The total equals the net pay amount.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
