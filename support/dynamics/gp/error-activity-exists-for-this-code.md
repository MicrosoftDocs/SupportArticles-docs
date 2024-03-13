---
title: Error when you select or clear a check box in the Employee Deduction Maintenance window in Microsoft Dynamics GP
description: Describes error messages that you receive when you click to select or click to clear a check box in the TSA Sheltered From area for a deduction in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Activity exists for this code. The Tax Status cannot be changed" error when you click to select or clear a check box in the Employee Deduction Maintenance window in Microsoft Dynamics GP

This article provides resolution for error messages that occur when you click to select or click to clear a check box in the TSA Sheltered From area for a deduction in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939918

## Symptoms

When you click to select a check box or when you click to clear a check box in the **TSA Sheltered From** area in the Employee Deduction Maintenance window, you receive the following error message:

> Activity exists for this code. The Tax Status cannot be changed.

Additionally, when you click to select a check box or click to clear a check box in the **Subject to Taxes** area in the Employee Benefit Maintenance window, you receive the same error message.

## Resolution

To resolve this problem, use the correct tax settings to create a new deduction code and to create a new benefit code.

> [!NOTE]
> If a benefit tax status or a deduction tax status is changed, the federal wages of the 941 report may differ from the federal wages of the payroll summary. Additionally, the reconcile process cannot adjust the difference. Therefore, to meet Generally Accepted Accounting Principles (GAAP) requirements, we recommend that you create a new deduction code or a new benefit code instead of changing the existing code.
>
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.
>
> We recommend that you test the following steps by using a test company.

To create a new deduction code or a new benefit code, use the appropriate method.

### Step 1: Create a new deduction code

1. Create a deduction by following these steps:
    1. Use the appropriate method:
        1. In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then click **Deduction**.
        1. In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **Payroll**, and then click **Deduction**.
    1. In the Deduction Setup window, type a deduction code name in the **Deduction Code** box, and then type a description in the **Description** box.

    1. In the **Start Date** box, type a date.
    1. In the **TSA Sheltered From** area, click the check boxes of the taxes that you want to use.
    1. In the **Method** list, click a method, and then type a value in the **Single** box.
    1. In one or more of the boxes under **Maximum Deduction**, type a value.
    1. In the **Frequency** list, click a frequency.
    1. If the deduction is based on pay codes, add the pay codes in the **Selected** box.
    1. In the **W-2 Box** box, type an appropriate value. In the **W-2 Label** box, type an appropriate value.
    1. Click **Save**.
2. Assign the deduction that you created to an employee by following these steps:

    1. On the **Cards** menu, point to **Payroll**, and then click **Deduction**.
    1. In the Employee Deduction Maintenance window, enter an employee identifier (ID) in the **Employee ID** box.
    1. Click the lookup button next to the **Deduction Code** box.
    1. In the Deductions window, click the deduction that you created in step 1, and then click **Select**.
    1. Complete the required fields.
        > [!NOTE]
        > You may have to override the default value in some fields for the employee.
    1. Click **Save**.
3. Disable the previous deduction code for the employee by following these steps:

    1. On the **Cards** menu, point to **Payroll**, and then click **Deduction**.
    1. In the Employee Deduction Maintenance window, enter an employee ID in the **Employee ID** box.
    1. Click the lookup button next to the **Deduction Code** box.
    1. In the Deductions window, click the deduction code that is no longer used for the employee, and then click **Select**.
    1. Click to select the **Inactivate** check box.
    1. Click **Save**.

### Step 2: Create a new benefit code

1. Create a benefit by following these steps:
    1. Use the appropriate method:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll**, and then click **Benefit**.
        - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **Payroll**, and then click **Benefit**.
    1. In the Benefit Setup window, type a benefit code name in the **Benefit Code** box, and then type a description in the **Description** box.
    1. In the **Start Date** box, type a date.
    1. In the **Subject to Taxes** area, click to select the check boxes of the taxes that you want to use.
    1. In the **Method** list, click a method, and then type a value in the **Single** box.
    1. Under **Maximum Benefit**, type a value in one or more of the boxes.
    1. In the **Frequency** list, click a frequency.
    1. If the benefit is based on pay codes, add the pay codes to the **Selected** box.
    1. In the **W-2 Box** box, type an appropriate value. In the **W-2 Label** box, type an appropriate value.
    1. Click **Save**.
2. Assign the benefit that you created to an employee by following these steps:
    1. On the **Cards** menu, point to **Payroll**, and then click **Benefit**.
    1. In the Employee Benefit Maintenance window, enter an employee ID in the **Employee ID** box.
    1. Click the lookup button next to the **Benefit Code** box.
    1. In the Benefits window, click the benefit code that you created in step 1, and then click **Select**.
    1. Complete the required fields.
        > [!NOTE]
        > You may have to override the default value in some fields for the employee.
    1. Click **Save**.
3. Disable the previous benefit code for the employee by following these steps:

    1. On the **Cards** menu, point to **Payroll**, and then click **Benefit**.
    1. In the Employee Benefit Maintenance window, enter an employee ID in the **Employee ID** box.
    1. Click the lookup button next to the **Benefit Code** box.
    1. In the Benefit window, click the benefit code that is no longer used for the employee, and then click **Select**.
    1. Click to select the **Inactivate** check box.
    1. Click **Save**.
