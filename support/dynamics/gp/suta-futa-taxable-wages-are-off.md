---
title: SUTA or FUTA taxable wages are off
description: Describes a problem in which SUTA or FUTA taxable wages are off by the amount of a TSA deduction for Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# SUTA or FUTA taxable wages are off by the amount of a TSA deduction in Microsoft Dynamics GP

This article provides a solution to an issue where State Unemployment Taxes (SUTA) or Federal Unemployment Taxes (FUTA) taxable wages are off by the amount of a tax sheltered annuity (TSA) deduction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864323

## Symptoms

In Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, State Unemployment Taxes (SUTA) or Federal Unemployment Taxes (FUTA) taxable wages are off by the amount of a tax sheltered annuity (TSA) deduction.

## Resolution

To resolve this problem, follow these steps:

1. Use the appropriate method:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Unemployment Tax**.

   - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Payroll**, and then select **Unemployment Tax**.

2. In the Unemployment Tax Setup window, type the two-digit tax code in the **Tax Code** field.

3. Select the **Tax Sheltered Annuities** check box.

4. Select the **TSA deduction** that the SUTA or FUTA report is off by, and then select **Insert** to insert the TSA deduction as taxable wages.

5. Select **Save** to save the unemployment record.

## More Information

By default, Microsoft Dynamics GP assumes a deduction as tax sheltered from SUTA or from FUTA if the deduction is sheltered from any taxes on the deduction setup. If this deduction shouldn't be sheltered from SUTA or from FUTA, the deduction has to be included as taxable wages in the SUTA setup.
