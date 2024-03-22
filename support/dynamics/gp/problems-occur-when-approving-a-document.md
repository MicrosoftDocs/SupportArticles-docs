---
title: Problems occur when approving a document
description: Provides solutions to errors that occur when you approve a document in Project Time and Expense if Automatic Processing is enabled in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Problems occur when you approve a document in Project Time and Expense if Automatic Processing is enabled in Microsoft Dynamics GP

This article provides solutions to errors that occur when you approve a document in Project Time and Expense if Automatic Processing is enabled in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952214

## Symptoms

When you approve a timesheet or an employee expense in Project Time and Expense in Microsoft Dynamics GP 10.0, in Microsoft Dynamics GP 9.0, or in Microsoft Business Solutions - Great Plains 8.0, you may receive one of the following error messages or the following unexpected behavior may occur. These problems occur if Automatic Processing is enabled.

## Error messages

- You receive the following error message when the pay rate has four decimal places. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Processing failed for **XYZ** -TS- **MMDDYY** - **X** : Unit cost for this pay code do not match - unit cost cannot be changed.

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

- You receive the following error message when the profit in the rate table has changed since the time that the timesheet was entered. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Total Accrued Revenue does not match sum of lines.

- You receive the following error message when the total cost of the employee expense is rounded to two decimals. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Processing failed for **XYZ** -EE- **MMDDYY** - **X**  

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

- You receive the following error message when the vendor record doesn't have a value in the **Address ID** field in the **Primary Address** area of the Vendor Maintenance window. See [Resolution 1](#resolution-1), [Resolution 2](#resolution-2), or [Resolution 3](#resolution-3).

    > Processing failed for **XYZ** -EE- **MMDDYY** - **X** : Input variable contains an empty value.

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

- You receive the following error message when the currency that is specified in the **Billing Currency ID** field for the project isn't the functional currency. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Processing failed for **XYZ** -TS- **MMDDYY** - **X** : Total Accrued revenue does not match sum of detail lines.

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

- You receive the following error message when the status of the budget is set to Completed. See [Resolution 1](#resolution-1), [Resolution 2](#resolution-2), or [Resolution 4](#resolution-4).

    > Processing failed for **XYZ** -TS- **date** -1 : Budget status is invalid - budget status needs to be open.

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, and *date* is the placeholder for the date.

- You receive the following error message when the employee expense transaction is for a negative quantity. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Processing failed for **XYZ** -EE- **MMDDYY** - **X** : Input variable contains a negative value

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

- You receive the following error message when the Timesheet transaction is for a negative quantity. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

    > Processing failed for *XYZ* -EE- *MMDDYY* - *X* : Input variable (PATACRV) contains a negative value

    > [!NOTE]
    > *XYZ* is the placeholder for the employee, *MMDDYY* is the placeholder for the date, and *X* is the placeholder for the sequence number.

## Unexpected behavior

- The employee expense document posts to the Payables Management module even if the **Post to Payables Management** check box is cleared in the Employee Expense Setup window. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

- Billing notes aren't sent to Project Accounting together with the employee expense transaction. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

- The Timesheet Detail Work table (PA10001) contains records that don't have an associated header record in the Timesheet Header Work (PA10000) table. This problem occurs if you received an error message on one, but not all, of the lines of the timesheet when you approved the timesheet. See [Resolution 1](#resolution-1) or [Resolution 2](#resolution-2).

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Resolution 1

Approve the document by using Personal Data Keeper (PDK).

### Resolution 2

Turn off automatic processing for timesheets or for employee expenses. To do it, follow these steps.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. It includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

2. Run the following statements against the company database:

    ```sql
    Update PmaTimesheetConfig set AutomaticProcessing =0
    ```

    ```sql
    Update PmaExpenseReportConfig set AutomaticProcessing =0 
    ```

3. Approve the document in Project Time and Expense.
4. Process the document to Project Accounting by using PDK.

### Resolution 3

Enter an address for the vendor. To do it, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor** to access the vendor record for this employee.

2. In the **Primary Address** field, type the address in the **Address ID** box.
3. Save the vendor.

### Resolution 4

Change the status of the budget to **Open**, and then leave the status of the project as **Completed**. To do it, follow these steps:

1. On the **Cards** menu, point to **Project**, and then select **Project**.
2. Type the project number, and then select **Budget**.

3. In the Budget Maintenance window, select **Open** in the **Status** list.

4. Select **OK**, and then save the project.
