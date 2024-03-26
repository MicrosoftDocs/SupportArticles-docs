---
title: Error when you use Benefit Allocation routine in Project Accounting 
description: Provides a solution to an error that occurs when you use the Benefit Allocation routine in Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Error when you use the Benefit Allocation routine in Project Accounting in Microsoft Dynamics GP: "You must create Miscellaneous ID BENEFIT ALLOC to process benefits"

This article provides a solution to an error that occurs when you process benefits by using the Benefit Allocation routine in Project Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 974652

## Symptoms  

When you process benefits by using the Benefit Allocation routine in Project Accounting in Microsoft Dynamics GP 10.0, you receive the following error message:

> You must create Miscellaneous ID BENEFIT ALLOC to process benefits.

> [!NOTE]
> To open the **Benefit Allocation** form, click **Microsoft Dynamics GP**, point to **Routines**, point to **Project**, and then click **Benefit Allocation**.

The Benefit Allocation routine is used to automatically create miscellaneous log transactions that have actual cost values that match what was calculated on the employee's paycheck in Microsoft Dynamics GP Payroll.

## Cause  

This problem occurs because a miscellaneous log ID that is named BENEFIT ALLOC must be created before you can use the benefit allocation feature.

> [!NOTE]
> The benefit allocation feature is added in Microsoft Dynamics GP 10.0 Service Pack 2 (SP2).

## Resolution  

You must create a miscellaneous ID that is named BENEFIT ALLOC to resolve this problem. To do this, follow these steps:

1. On the **Cards** menu, point to **Project**, and then click **Miscellaneous** to open the **Miscellaneous Maintenance** window.
2. Type BENEFIT ALLOC in the **Miscellaneous ID** field.

    > [!NOTE]
    > The value in the **Miscellaneous ID** field should be exactly as mentioned in the [Cause](#cause) section.
3. In the **Name** field, type a name.
4. If it is necessary, enter additional information in the Miscellaneous Maintenance window.
5. Click **Save**.

## More information

The following is a list of additional tips for creating a successful benefit allocation.

- You must assign Benefits to the timesheet cost category by using the Benefit Setup window. To do this, follow these steps:

    1. Open the Benefit Setup window. To do this, click **Cards**, point to **Project**, and then click **Cost Category**.

        > [!NOTE]
        > When you select a timesheet cost category in the Cost Category Maintenance window, the **Go To** list becomes available.
    2. Click **Go To**, and then click **Benefits** to open the **Benefit Setup** window.
    3. In the **Benefit Setup** window, click **Go To**, and then click **Benefits** to open the **Benefit Cost Category Accounts** window.
    4. Click **Accounts**.

        > [!NOTE]
        > You can enter accounts that are specific to that cost category and benefit combination.

- The **Cost Category ID** value and **Misc Log Cost Category ID** value from the Benefit Setup window must both be assigned to your project to have benefits calculated.

    > [!NOTE]
    > The list of Benefit Costs to select will always include **FICA - Medicare**, **FICA - Social Security**, and any active employer-paid benefits that are set up in Payroll.

- You must click to select the **Post to Payroll** check box in Timesheet Setup.
- To use the Post to Payroll option, you must be registered for U.S. Payroll in Microsoft Dynamics GP. If you are not registered, the benefit allocation routine does not calculate any benefits.
- The benefit allocation process works for both hourly and salaried employees.
- To see benefit amounts that are calculated in the Benefit Allocation window, you must print the employee's paycheck, and then process the payroll through Payroll in Microsoft Dynamics GP.
- You cannot edit the amount in the **Allocated** field in the Benefit Allocation window. However when you click **Process**, a Miscellaneous Log transaction is created. Then, you can edit the Miscellaneous Log transaction in Miscellaneous Log Entry.
- Once benefits are processed from the Benefit Allocation window, Microsoft Dynamics GP will not populate the window with those same benefits again.
- The **Benefit Expense Allocation** field has three options:

  - **Option 1: Do not allocate benefits**: No allocation is performed for this cost category.
  - **Option 2: Timesheet - currency amount posted**: The **PAEXTCOST** field in the PA30101 table for the employee is used to determine the amount. The calculation that is used is as follows:
  
      $ posted for 1 project / $ posted for all projects * Benefit Amount
  - **Option 3: Timesheet - hours posted**: The **PABase_QTY** field in the PA303101 table for the employee is used to determine the amount. The calculation that is used is as follows:
  
      Hours posted for 1 project / hours posted for all projects * Benefit amount

- The Miscellaneous Log is created by using the **Check Date** value from Payroll.
