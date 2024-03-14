---
title: Errors occur when printing the Benefit Summary report
description: Describes an issue that occurs when you print the Benefit Summary report in Payroll - US. To resolve this issue, make sure that the benefit code is consistently taxed between employee records.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# You receive error messages when you print the Benefit Summary report in Microsoft Great Plains

This article provides a resolution for the issue that you receive error messages when you try to print the Benefit Summary report in Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 907897

## Symptoms

When you print the Benefit Summary report in Microsoft Business Solutions - Great Plains Payroll - US, you receive the following error message:

> Microsoft ODBC SQL Server Driver SQL Server Violation of PRIMARY KEY constraint PK##2252927. Cannot insert duplicate key in object ##2252927.

When you select **OK**, you receive the following error message:

> The stored procedure uprLoadTempXCmpyBenefitSummary returned the following results DBMS 2627 Great Plains 0

To print the report, select **Reports**, select **Payroll**, choose **Period-End**, and then print the Benefit Summary Report.

## Cause

This issue occurs because a benefit code that has a zero balance is inconsistently taxed between employee records.

## Resolution

To resolve this issue, follow these steps:

1. Determine which employee records have a different tax status setting for the benefit code. To do this, follow these steps to run a SELECT statement on the Benefit Master table (UPR00600):

    1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
    2. Run the following script.

        ```sql
        Select * from UPR00600 where BENEFIT = <BENEFITCODE>
        ```

        > [!NOTE]
        > In this script, **\<BENEFITCODE>** is a placeholder for the name of the specific benefit code.

    3. In the search results, view the TAXABLE field to find the employee records that have a different tax status setting.

        > [!NOTE]
        > A tax status setting of **0** indicates the not-taxable status. A tax status setting of **1** indicates the taxable status.

2. Change the employee records that you found in step 1 to have the same tax status setting that the other employee records have. To do this, follow these steps:

   1. Select **Cards**, select **Payroll**, and then select **Benefit**.
   2. In the **Employee Benefit Maintenance** dialog box, type the employee ID in the **Employee ID** box, type the benefit code in the **Benefit Code** box, and then select the check box for the tax subjects that you want in the **Subject to Taxes** area.
   3. Repeat step b for each employee record that you found in step 1 to make sure that all employee records have the same tax status setting.

## More information

The following example illustrates a benefit code that is inconsistently taxed between employee records.

```console
Employee 0327
Benefit Code: PROFIT
Tax Status: Not Taxable

Employee 0326
Benefit Code: PROFIT
Tax Status: Taxable
```

> [!NOTE]
> For the temporary table that is used in this report, the primary keys are the following:
>
> - Company Name
> - Pay Record Type
> - Pay Code

In this example, the following conditions are true:

- The benefit code is not taxable for employee 0327.
- The benefit code is taxable for employee 0326.
- No amount is posted for either employee.
