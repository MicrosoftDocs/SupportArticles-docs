---
title: Error message when you submit a timesheet
description: This article provides a resolution for the problem that occurs when you submit a timesheet in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you submit a timesheet in Microsoft Dynamics GP (Error: [Cause]Entity. Unit of Measure Detail, is not found or Error: [Cause]Entity. Unit of Measure Schedule, is not found)

This article helps you resolve the problem that occurs when you submit a timesheet in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935625  

## Symptoms

When you submit a timesheet in Microsoft Dynamics GP, you may receive one of the following error messages:

- Error message 1

  > Error: [Cause]Entity. Unit of Measure Detail, is not found. [Correction]Supply the correct query parameters for the entity.

- Error message 2

  > Error: [Cause]Entity. Unit of Measure Schedule, is not found. [Correction]Supply the correct query parameters for the entity.

## Cause

This problem occurs if the unit of measure or the unit of measure schedule is not set up in the correct location in Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> In the following steps, when you type Hour in the **U of M** field, make sure that the spelling and capitalization is Hour exactly.

1. Verify that you have a valid unit of measure schedule to use for the timesheet. To do this, follow these steps:
    1. Use the appropriate method:
        - If you use Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Project**, and then click **Unit of Measure Schedule**.
        - If you use Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Project**, and then click **Unit of Measure Schedule**.
    1. In the **U of M Schedule ID** field, enter the schedule that you want to use.
    1. Make sure that the value in the **U of M** field under **Base** is **Hour**.
1. Use the appropriate method:
    - If you use Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Project**, and then click **Project**.
    - If you use Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Project**, and then click **Project**.
1. In the Project Setup window, determine whether the **Use Pay Codes for Unit Cost** check box is selected.
1. If the **Use Pay Codes for Unit Cost** check box is not selected, follow these steps.
    > [!NOTE]
    > If the **Use Pay Codes for Unit Cost** check box is selected, continue to step 5.
    1. On the **Cards** menu, point to **Payroll**, and then click **Employee**.
    1. In the Employee Maintenance window, enter the employee in the **Employee ID** field, and then click **Project**.
    1. In the PA Employee Options window, type Hour in the **Unit of Measure** field.
1. Use the appropriate method:
    - If you use Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Project**, and then click **Timesheets**.
    - If you use Microsoft Dynamics GP 9.0,, point to **Setup** on the **Tools** menu, point to **Project**, and then click **Timesheets**.
1. In the Timesheet Setup window, examine the value in the **Default Pay Codes From** field. Then, follow the appropriate steps, depending on the value:
    - If **Employee** appears in the **Default Pay Codes From** field, follow these steps:
      1. On the **Cards** menu, point to **Payroll**, and then click **Employee**.
      1. In the Employee Maintenance window, enter an employee in the **Employee ID** field, and then click **Project**. Set the **Unit of Measure** value to **Hour**.

      > [!NOTE]
      > If the **Unit of Measure** field is unavailable, run the following script to set the **Unit of Measure** value to **Hour**.</br>`Update PA00601 set PAUnit_of_Measure = 'Hour'`</li></br>
    - If **Cost Category** appears in the **Default Pay Codes From** field, follow these steps:
      1. On the **Cards** menu, point to **Project**, and then click **Cost Category**.
      1. In the Cost Category Maintenance window, enter a timesheet cost category in the **Cost Category ID** field. Make sure that **Hour** is specified in the **Unit of Measure** field and the schedule that you entered in step 1 is specified in the **U of M Schedule** field.

        > [!NOTE]
        > To update all timesheet cost categories to have this information, run the following scripts.</br>`Update PA01001 set PAUnit_of_Measure = 'Hour' where PATU = 1 Update PA01001 set UOMSCHDL = '<XXX>' where PATU = 1`
        >
        > The \<XXX> placeholder represents the unit of measure schedule ID that you specified in step 1.
    - If **Budget** appears in the **Default Pay Codes From** field, follow these steps:
      1. On the **Cards** menu, point to **Project**, and then click **Project**.
      1. In the Project Maintenance window, enter a project in the **Project No.** field, and then click **Budget**.
      1. In the Budget Maintenance window, locate the **Timesheet** cost category. Click the expansion button in the **Cost Category** field to open the Budget Detail Entry window. Make sure that **Hour** appears in the **UofM** field and the schedule that you entered in step 1 is specified in the **U of M Schedule** field.

        > [!NOTE]
        > Starting with SP1 for Business Portal in Microsoft Dyamics GP and including Business Portal for 10.0, you must have a unit of measure assigned in the Budget Maintenance window regardless of the setting for the **Default Pay Codes From** field in the Timesheet Setup window.
    - If you have not yet posted time to this budget, set the value in the **Status** field to **Estimate**, and then enter the schedule that you entered in step 1 in the **U of M Schedule** field. If you have already entered transactions against this project and cost category, update the **U of M Schedule** field and the **U of M** field by using scripts. To update all timesheet cost categories to have this information, run the following scripts.

      `Update PA01301 set PAUnit_of_Measure = 'Hour' where PATU = 1 Update PA01301 set UOMSCHDL = '<XXX>' where PATU = 1`
      > [!NOTE]
      > The \<XXX> placeholder represents the unit of measure schedule ID that you specified in step 1.
1. If you use templates to create new projects, update the unit of measure and the unit of measure schedule in those templates. To do this, run the following scripts.</br>`Update PA40201 set PAUnit_of_Measure = 'Hour' where PATU = 1 Update PA40201 set UOMSCHDL = '<XXX>' where PATU = 1`
    > [!NOTE]
    > The \<XXX> placeholder represents the unit of measure schedule ID that you specified in step 1.
1. If you use timesheet templates to create new timesheet transactions, update the unit of measure and the unit of measure schedule in those templates. To do this, run the following scripts.</br>`Update PDK00301 set PAUnit_of_Measure = 'Hour' Update PDK00301 set UOMSCHDL = '\<XXX>'
    > [!NOTE]
    > The \<XXX> placeholder represents the unit of measure schedule ID that you specified in step 1.
1. If you use rate tables to obtain costs or profit values, update the unit of measure in those rate tables. To do this, run the following scripts.

    `Update PA01403 set PAUnit_of_Measure = 'Hour' Update PA01405 set PAUnit_of_Measure = 'Hour'`
