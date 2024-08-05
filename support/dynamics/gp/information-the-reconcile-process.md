---
title: Information about the reconcile process
description: Provides information about the tables and fields used during the reconcile process in Payroll in Microsoft Dynamics GP.
ms.reviewer: theley, lmueller
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Information about the reconcile process in Payroll in Microsoft Dynamics GP

This article describes the tables and fields that are used during Payroll reconcile process in Microsoft Dynamic GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874131

## Summary

Fields in the Payroll Check History table (UPR30100) and the Payroll Transaction History table (UPR30300) are used to update the Payroll Employee Summary table (UPR00900) and the Payroll Employee Tips Summary table (UPR00901).

## More information

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

Print the reconcile report before you do the reconcile procedure. To do it, follow these steps:

1. Use one of the following methods, depending on the program that you're using.

    **Method 1**: Microsoft Dynamics GP 10.0 and higher versions  
    On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Payroll**, and then select **Reconcile**.

    **Method 2**: Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0  
    On the **Tools** menu, point to **Utilities**, point to **Payroll**, and then select **Reconcile**.
2. In the Reconcile Employee Information window, select the appropriate year in the **Year** list, select the **Print Report** check box, and then select **Process**.

On the Reconcile Error Report, the amount in the **Before reconciliation** area comes from the Payroll Employee Summary table (UPR00900). The information in the **After Reconciliation** area comes from the Payroll Check History table (UPR30100) and the Payroll Transaction History table (UPR30300). Review the report before you do the reconcile procedure to verify that all information is correct.

### Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 9.0

In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, the reconcile process updates the Payroll Transaction History Header table (UPR30301) by using information in the Payroll Transaction History table (UPR30300). Before you run the reconcile procedure, you must delete the data in the UPR30301 table for each employee that you want to reconcile. The reconcile procedure doesn't update existing records in the UPR30301 table. However, if a record is missing, the reconcile procedure creates the missing record.

To delete records from the UPR30301 table for a specific employee, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

2. Run the following statement against the company database:

    ```sql
    delete UPR30301 where EMPLOYID = 'YY' and YEAR1 = 'ZZZZ'
    ```

    Replace the placeholder *YY* with the employee ID, and replace the s *ZZZZ* with the appropriate year.

### Microsoft Business Solutions - Great Plains 8.0

In Microsoft Business Solutions - Great Plains 8.0, the reconcile procedure doesn't update the Payroll Transaction History table (UPR30301). To correct this table, you must manually correct the information in the UPR30301 table. One method to correct the UPR30301 table is to run an update statement. For more information about how to correct the information in the UPR30301 table, contact your Partner or technical support.

#### More information for Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0

The following table describes the fields and tables that are used during the Payroll reconcile process.

|-|-|-|
|---|---|---|
| Payroll Check History Field | Payroll Transaction History Field | Payroll Employee (Tips) Summary Field |
|Gross Wages less Charged tips|-|Gross Wages|
|Federal Wages|-|Federal Wages|
|Federal Withholding/Pay Run||Federal Tax Withheld|
|FICA/Soc Sec Wages|-|FICA Soc Sec Wages|
|FICA/Social Security Withholding/Pay Run|-|FICA Soc Sec Withheld|
|FICA/Medicare Wages|-|FICA Medicare Wages|
|FICA/Medicare Withholding/Pay Run||FICA Medicare Withheld|
|-|Trx Amount (for Pay Codes and Benefits with Subject to FUTA marked)|FUTA Wages|
|-|Trx Amount (for Pay Codes with aSUTA State)|SUTA Wages|
|Net Wages/Pay Run|-|Net Wages|
|Reported Tips||Reported Tips|
|Reported Receipts|-|Reported Receipts|
|Charged Receipts|-|Charged Receipts|
|Allocated Tips|-|Allocated Tips|
|Federal Tips|-|Federal Tips|
|FICA/SS Tips|-|FICA Soc Sec Tips|
|FICA/Med Tips|-|FICA Medicare Tips|
|Federal Tax on Tips|-|Federal Tax Withheld on Tips|
|FICA/SS Tax on Tips|-|FICA Soc Sec Tax Withheld on Tips|
|FICA/Med Tax on Tips|-|FICA Medicare Tax Withheld on Tips|
|Uncollected FICA/SS Tax/Pay Run|-|FICA Soc Sec Uncollected Tax on Tips|
|Uncollected FICA/Med Tax/Pay Run|-|FICA Medicare Uncollected Tax on Tips|
