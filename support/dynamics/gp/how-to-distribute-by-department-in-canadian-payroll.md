---
title: How to distribute by Department in Canadian Payroll
description: Introduces how to distribute by department in Canadian Payroll for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to distribute by Department in Canadian Payroll using Microsoft Dynamics GP

This article explains how to distribute by department in Canadian Payroll for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3140977

## Setup to distribute by department

To distribute by department, review the following setup:

1. Check all benefits and Income paycodes and make sure the **Debit account** field is filled in on the Payroll Benefit Paycode Setup -Canada window and Payroll Income Paycode Setup - Canada window. This is a required field.

2. Also on the benefit and income paycode setup, verify the **Distribute** field is set to **Yes**.

3. On the Payroll Employee Setup - Canada window, select the employee and select the **Distribution** tab. List the departments to distribute to and the percent should add up to 100%.

4. Also on the Payroll Employee Setup - Canada window, select the **PAYCODES** tab and select the paycode and select **UPDATE**. Verify if the **Department** field is filled in on the paycode or not. If so remove the department code here.

5. Under Microsoft Dynamics GP > **Tools** > **Setup** > **Payroll - Canada** > **Control** > **Control** button, the **Account Distribution Replacement Mask** field needs to be assigned. Select to mask a segment(s) of your GL account structure.

6. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Payroll-Canada** > **Department**. Make sure the **Replacement G/L Segment Account** field is populated, with the mask showing in the same segment.

7. If you wish for CPP/EI to also be distributed, this setting is at the Employer level. Go to Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Payroll-Canada** and select **Employer**. Verify if the **EI Employer Portion Distribute** field and **CPP Employer Portion Distribute** field are set to **Yes**. Then go to the Payroll Employee Setup-Canada window and verify the Employer Number selected for the employee.

## More information

By design, these types of paycodes won't distribute:

- Vacation - Vacation dollars are distributed when the vacation amounts are *accrued*, not when they're paid out. And on the accrual, only the debit is distributed. The credit books ot the vacation payable account set in the Payroll Control Accounts-Canada window and isn't distributed.
- Banked Sick Relief code - The system won't distribute when paying out the funds. The liability was already distributed when the amount was banked, and so won't distribute again.
- Deduction paycodes - Deductions aren't distributable. The only workaround is to set up extensive deduction codes by department, which isn't ideal.
- The distribution functions for Income Codes with Regular Pay as the pay type, but not for various specialized types such as EI Rebate.
