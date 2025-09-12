---
title: Error in getting the Accounts
description: Provides a solution to an error that occurs when you print the PA Transaction Adjustment Report in Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Project Accounting
---
# "Error in getting the Accounts" Error message when you print the PA Transaction Adjustment Report in Project Accounting in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print the PA Transaction Adjustment Report in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927319

## Symptoms

After you enter an adjustment transaction for an employee expense in Project Accounting in Microsoft Dynamics GP, you receive the following error message when you print the PA Transaction Adjustment Report:
> Error in getting the Accounts.

This problem occurs if you aren't registered for Multicurrency Management in Microsoft Dynamics GP.

> [!NOTE]
> This error message may also occur for the following transaction types:
>
> - Employee Expenses
> - Timesheets
> - Equipment Logs
> - Miscellaneous Logs

## Cause 1

This problem may occur if the **CURNCYID** field is blank in the PA30500 table. This problem may also occur if the **CURRNIDX** field is blank in the PA30500 table or in the PA30501 table. See [Resolution 1](#resolution-1).

## Cause 2

The problem may occur if any of the posting accounts are marked as **Inactive**. See [Resolution 2](#resolution-2).

## Resolution 1

To update the CURNCYID field with the correct value, follow these steps:

1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
2. In the database list, select the company database where you receive the error message.
3. Type the following statements in the Query window.

    ```sql
    select CURNCYID, CURRNIDX,* from PA30500 
    select CURRNIDX,* from PA30501
    ```

4. Select **Execute**.
5. If the fields are blank for the transactions that you're trying to post, type the following statements to update the fields with the correct, functional Currency ID and Currency Index values.

    ```sql
    update PA30500 set CURNCYID = 'Z-US$' 
    update PA30500 set CURRNIDX = '1007'
    update PA30501 set CURRNIDX = '1007' 
    ```

    > [!NOTE]
    > Replace the Z-US$ placeholder with the value in the **FUNLCURR** field in the MC40000 table. Replace the 1007 placeholder with the value in the **FUNCRIDX** field in the MC40000 table. To find these values, run the following statement against the company database.

    ```sql
    select * from MC40000
    ```

6.  Select **Execute.**  

## Resolution 2

To make a posting account active, follow these steps:

1. On the **Cards** menu, post to **Financial**, and then select **Accounts**.
2. Select to clear the **Inactive** check box.
3. Select **Save**.

## More information

If you receive this error message for a transaction type other than an adjustment transaction type, follow the steps that are listed in the "Resolution" section. However, in steps 3 and 5, replace table PA30500 and table PA30501 with the following tables:

- **Timesheet transaction types**  
    Replace the PA30500 table with the PA30100 table. Replace the PA30501 table with the PA30101 table.

- **Equipment Log transaction types**  
    Replace the PA30500 table with the PA30200 table. Replace the PA30501 table with the PA30201 table.

- **Miscellaneous Log transaction types**  
    Replace the PA30500 table with the PA30300 table. Replace the PA30501 table with the PA30301 table.
