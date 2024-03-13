---
title: Set up a 401 deduction that has a benefit
description: Describes how to set up a 401(k) deduction that has a matching benefit in Payroll in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up a 401(k) deduction that has a matching benefit in Payroll in Microsoft Dynamics GP

This article describes how to set up a 401(k) deduction that has a matching benefit in Payroll in Microsoft Dynamics GP. This article also describes how to set an employer maximum if an employer maximum is needed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939646

## Introduction

Many employers match a percentage of an employee's 401(k) contributions up to a defined amount of the employee's gross wages.

For example, a company may decide to match 50 percent of an employee's 401(k) contribution up to 4 percent of the employee's gross wages. The employee can decide to withhold more than 4 percent of the gross wages. However, the amount that exceeds 4 percent of the gross wages is not matched by the company.

First, you have to set up the 401(k) deduction. Then, you have to set up the matching benefit.

## Set up the 401(k) deduction

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Deduction**.
2. In the Deduction Setup window, type the code name that you want in the **Deduction Code** field, and enter a description in the **Description** field.
3. Select the **Deduction Type** as **Standard** typically.
4. Specify the **Start Date** and **End Date**.
5. In the **TSA Sheltered From** area, select the appropriate check boxes for taxes to shelter from.
6. In the **Method** list, select **Percent of Gross Wages**.
7. In the **Deduction Tiers** area, select **Single**. In the box next to the **Single** field, type a default percentage. Or, leave the default percentage as **0.00%**.

    > [!NOTE]
    > The percentage that you enter in the **Deduction Tiers** area will be the default percentage when you assign the deduction to employees. You can change the percentage when you assign the deduction to the employees.
8. Select the appropriate frequency in the **Frequency** list.
9. If it's required, enter any maximum deduction amounts in the **Maximum Deduction** area for Pay Period, Calendar Year and/or Lifetime.
10. If you want this deduction to be based on only certain pay codes, select **Selected** in the **Based on Pay Codes** area, and then insert the appropriate pay codes from the **Pay Codes** area.
11. Type the appropriate information in the following fields:
    - **W-2 Box**  
    - **W-2 Label**
12. Select **Save**.

## Set up the matching 401(k) benefit

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Benefit**.
2. In the Benefit Setup window, type a benefit code in the **Benefits Code** field.
3. In the **Description** field, type a description.
4. In the **Start Date** field, enter the start date. If the benefit has an end date, enter the end date in the **End Date** field.
5. In the **Subject To Taxes** area, select the appropriate check boxes.
6. In the **Method** field, select **Percent of Deduction**.
7. In the **Benefit Tiers** area, select **Single**, and then type the percentage that you want to match.

    For example, if the company matches 50 percent of the employee contribution, type **50%**.
8. In the **Frequency** list, select the appropriate frequency.
9. In the **Maximum Benefit** area, enter any maximum benefit amounts.
10. In the **Based on** field, select **Deduction**, and then select **Selected**. Next, insert the deduction that you created into the **Selected** box.

    > [!NOTE]
    > This deduction is the deduction that you created in step 2 in the [Set up the 401(k) deduction](#set-up-the-401k-deduction) section. It's the deduction on which the benefit will be based.
11. In the **Employer Maximum** field, type the maximum percent of the gross wages that you want to match.

    > [!NOTE]
    > This field will be grayed out if the matching deduction is set up as a fixed amount. This field is designed to work with percentages.

    For example, if the company matches up to 4 percent of the employee's gross wages, type **4%**.
12. Type the appropriate information in the following fields:
    - **W-2 Box**  
    - **W-2 Label**
13. Select **Save**.

## Assign the 401(k) deduction to an employee

1. On the **Cards** menu, point to **Payroll**, and then select **Deduction**.
2. In the Employee Deduction Maintenance window, type an employee ID in the **Employee ID** field. In the **Deduction Code** field, type the deduction code that you created.
3. When you're asked whether you want to use the default information from the Deduction Setup window, select **Default**.

    The default entries from the Deduction Setup window will populate specific fields. However, you may want to enter a specific percentage of the gross wages that the employee wants to withhold from each paycheck.
4. Select **Save**.

## Assign the matching benefit to an employee

1. On the **Cards** menu, point to **Payroll**, and then select **Benefit**.
2. In the Employee Benefit Maintenance window, type an employee ID in the **Employee ID** field. In the **Benefit Code** field, type the benefit code that you created.
3. When you're asked whether you want to use the default information from the Benefit Setup window, select **Default**.

    The default entries from the Benefit Setup window will populate specific fields. However, you may want to change the matching benefit as necessary for specific employees.
4. Select **Save**.

## Sample calculations

**Calculation 1**  
Consider the following scenario:

- You want to match 50 percent of the deduction up to 4 percent of gross wages
- The employee wants to withhold 4 percent of gross wages or less on the deduction

In this scenario, the benefit will be 50 percent of the deduction. The benefit is calculated as follows:  
**benefit** = **deduction** × **benefit percentage**  
In this scenario, the specific benefit is calculated as follows:  
 **benefit** = **deduction** × 0.5

**Calculation 2**  
If the employee wants to withhold more than 4 percent of gross wages, the benefit will match 50 percent up to 4 percent of the gross wages. The benefit will be calculated as follows:  
**benefit** = **gross wages** × **employer maximum** × **benefit percentage**  
In this scenario, the specific benefit is calculated as follows:  
 **benefit** = **gross wages** × **0.04** × **0.5**
