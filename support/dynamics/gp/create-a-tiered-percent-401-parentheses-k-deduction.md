---
title: Create a tiered percent 401(k) deduction
description: Describes how to create a tiered percent 401(k) deduction with a matching benefit in Payroll in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create a tiered percent 401(k) deduction with a matching benefit in Payroll in Microsoft Dynamics GP

This article describes how to set up a tiered percent 401(k) deduction that has a matching benefit in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946688

## Introduction

Many employers match an employee's 401(k) contributions up in a tiered manner.

For example, a company may decide to match 100 percent of an employee's 401(k) contribution up to 3 percent of the employee's gross wages. Then, a company may decide to match 50 percent of an employee's 401(k) contribution from 3.1 percent through 5 percent of the employee's gross wages. The employee can decide to withhold more than 5 percent of the gross wages. However, the amount that exceeds 5 percent of the gross wages is not matched by the company.

First, you've to set up the 401(k) deductions. Then, you've to set up the matching benefits.

## Set up the first 401(k) deduction

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Deduction**.

    - In Microsoft Dynamics GP 9.0, and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Payroll**, and then select **Deduction**.

2. In the Deduction Setup window, type the code that you'll use to determine the deduction in the **Deduction Code** field, and then type a description in the **Description** field.

3. In the **Start Date** field, specify the start date. If the deduction has an end date, specify the end date in the **End Date** field.

4. In the **TSA Sheltered From** area, select the appropriate check boxes.

5. In the **Method** list, select **Percent of Gross Wages**.

6. In the **Deduction Tiers** area, select **Single**. In the box next to the **Single** field, type a percent to withhold for the first employee matching tier. For example, assume the employee wants to withhold 5% of the gross wages for the 401(k) deduction. The company will match 100 percent of the employee's contributions up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages. Type 3% for the first tier deduction.

    > [!NOTE]
    > The percentage that you enter in the **Deduction Tiers** area will be the default percentage when you assign the deduction to employees. You can change the percentage when you assign the deduction to the employees.

7. Select the appropriate frequency in the **Frequency** list.

8. If it's required, enter any maximum deduction amounts in the **Maximum Deduction** area.

9. If you want this deduction to be based on only certain pay codes, select **Selected** in the **Based on Pay Codes** area, and then insert the appropriate pay codes from the **Pay Codes** area.

10. Type the appropriate information in the following fields:
    - **W-2 Box**  
    - **W-2 Label**
11. Select **Save**.

## Set up the second 401(k) deduction

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Deduction**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Payroll**, and then select **Deduction**.
2. In the Deduction Setup window, type the code that you'll use to determine the deduction in the **Deduction Code** field, and then type a description in the **Description** field.

3. In the **Start Date** field, specify the start date. If the deduction has an end date, specify the end date in the **End Date** field.

4. In the **TSA Sheltered From** area, select the appropriate check boxes.

5. In the **Method** list, select **Percent of Gross Wages**.

6. In the **Deduction Tiers** area, select **Single**. In the box next to the **Single** field, type a percent to withhold for the second employee matching tier. For example, assume the employee wants to withhold 5% of the gross wages for the 401(k) deduction. The company will match 100 percent of the employee's contribution up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages. Type 2% for the second tier deduction.

    > [!NOTE]
    > The percentage that you enter in the **Deduction Tiers** area will be the default percentage when you assign the deduction to employees. You can change the percentage when you assign the deduction to the employees.

7. Select the appropriate frequency in the **Frequency** list.

8. If it's required, enter any maximum deduction amounts in the **Maximum Deduction** area.

9. If you want this deduction to be based on only certain pay codes, select **Selected** in the **Based on Pay Codes** area, and then insert the appropriate pay codes from the **Pay Codes** area.

10. Type the appropriate information in the following fields:

    - W-2 Box
    - W-2 Label
11. Select **Save**.

## Set up the first matching benefit

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Benefit**.
    - In Microsoft Dynamics GP 9.0, and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Payroll**, and then select **Benefit**.

2. In the Benefit Setup window, type a benefit code in the **Benefits Code** field.

3. In the **Description** field, type a description.

4. In the **Start Date** field, enter the start date.

5. If the benefit has an end date, enter the end date in the **End Date** field.

6. In the **Subject To Taxes** area, select the appropriate check boxes.

7. In the **Method** field, select **Percent of Deduction**.

8. In the **Benefit Tiers** area, select **Single**, and then type the percentage that you want to match. For example, if the company will match 100 percent of the employee's contribution up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages, then type **3%** for the first tier benefit.

9. In the **Frequency** list, select the appropriate frequency.

10. In the **Maximum Benefit** area, enter any maximum benefit amounts.

11. In the **Based on** field, select **Deduction**, and then select **Selected**. Next, insert the first deduction that you created into the **Selected** box.

    > [!NOTE]
    > This deduction is the deduction that you created in the [Set up the first 401(k) deduction](#set-up-the-first-401k-deduction) section. It's the deduction on which the benefit will be based.

12. In the **Employer Maximum** field, type the maximum percent of the gross wages that you want to match. For example, if the company will match 100 percent of the employee's contribution up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages, then type 100% for the first tier benefit.

13. Type the appropriate information in the following fields:

    - **W-2 Box**  
    - **W-2 Label**
14. Select **Save**.

## Set up the second matching benefit

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then select **Benefit**.
    - In Microsoft Dynamics GP 9.0, and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Payroll**, and then select **Benefit**.
2. In the Benefit Setup window, type a benefit code in the **Benefits Code** field.

3. In the **Description** field, type a description.

4. In the **Start Date** field, enter the start date.

5. If the benefit has an end date, enter the end date in the **End Date** field.

6. In the **Subject To Taxes** area, select the appropriate check boxes.
7. In the **Method** field, select **Percent of Deduction**.

8. In the **Benefit Tiers** area, select **Single**, and then type the percentage that you want to match. For example, if the company will match 100 percent of the employee's contribution up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages, then type 2% for the second tier benefit.

9. In the **Frequency** list, select the appropriate frequency.

10. In the **Maximum Benefit** area, enter any maximum benefit amounts.

11. In the **Based on** field, select **Deduction**, and then select **1**. Next, insert the first deduction that you created into the **Selected** box.

    > [!NOTE]
    > This deduction is the deduction that you created in the [Set up the second 401(k) deduction](#set-up-the-second-401k-deduction) section. This is the deduction on which the benefit will be based.

12. In the **Employer Maximum** field, type the maximum percent of the gross wages that you want to match. For example, if the company will match 100 percent of the employee's contribution up to 3 percent of the employee's gross wages, and the company will match 50 percent of the employee's contribution for the next 2 percent of the employee's gross wages, then type 50% for the second tier benefit.

13. Type the appropriate information in the following fields:
    - **W-2 Box**  
    - **W-2 Label**
14. Select **Save**.

## Assign the 401(k) deductions to an employee

1. On the **Cards** menu, point to **Payroll**, and then select **Deduction**.
2. In the Employee Deduction Maintenance window, type an employee ID in the **Employee ID** field. In the **Deduction Code** field, type the first deduction code that you created.
3. When you're asked whether you want to use the default information from the Deduction Setup window, select **Default**. The default entries from the Deduction Setup window will populate specific fields. However, you may want to enter a specific percentage of the gross wages that the employee wants to withhold from each paycheck.
4. Select **Save**.
5. In the **Deduction Code** field, type the second deduction code that you created.
6. Select **Save**.

## Assign the matching benefits to an employee

1. On the **Cards** menu, point to **Payroll**, and then select **Benefit**.
2. In the Employee Benefit Maintenance window, type an employee ID in the **Employee ID** field. In the **Benefit Code** field, type the first benefit code that you created.
3. When you're asked whether you want to use the default information from the Benefit Setup window, select **Default**. The default entries from the Benefit Setup window will populate specific fields. However, you may want to change the matching benefit as necessary for specific employees.
4. Select **Save**.
5. In the **Benefit Code** field, type the second benefit code that you created.
6. Select **Save**.

## Include deductions and benefits when a pay run is processed

1. Create the build in the Build Payroll Checks window. To open the Build Payroll Checks window, on the **Transactions** menu, point to **Payroll**, and then select **Build Checks**.

2. In the **Pay Period Date** area, type dates for the pay period in the **From** field and in the **To** field.

3. In the **Include Pay Periods** area, select the appropriate check boxes.

4. In the **Include Automatic Pay Types** area, select the appropriate check boxes.
5. Select **Include Deductions**.

6. Select the appropriate deductions individually, select **Insert**, and then select **OK**.

7. Select **Include Benefits**.

8. Select the appropriate benefits individually, select **Insert**, and then select **OK**.
9. Select **Select Batches**, select the batches for the pay run, and then select **OK**.

10. Select **Build**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
