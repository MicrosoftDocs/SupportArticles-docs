---
title: Unapproved/Pending change order exist
description: Provides a solution to an error that occurs when you try to bill a cost category in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, Lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# "You cannot bill this line item; Unapproved/Pending change order exist" Error message when you try to bill a cost category in Microsoft Dynamics GP 9.0

This article provides a solution to an error that occurs when you try to bill a cost category in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927697

## Symptoms

When you try to bill a cost category in Microsoft Dynamics GP, you receive the following error message:
> You cannot bill this line item; Unapproved/Pending change order exist

> [!NOTE]
> In this error message, the word "order" is a misspelling for the word "orders."

This problem occurs if the following conditions are true:

- You create a new contract and a new project and then select **Copy Existing Budget** on the **Extras** menu in the Project Maintenance window.
- You copy a project that has an existing approved change order.
- The **Track Change Orders** check box is selected in the Change Order Project Information window.

## Resolution

This issue has been fixed in GP 10.0.

## Workaround

To work around this problem, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

> [!NOTE]
> In the statements, the \<Number> placeholder is a placeholder for the actual number of the project that you copied.

1. Run the following SELECT statement against the company database in SQL Query Analyzer.

    ```sql
    select PACHGORDNO, * from PA23401 where PAPROJNUMBER = '<Number>'
    ```

    > [!NOTE]
    > This statement shows how many valid change orders exist for this project in the PA Change Order Detail Open table.

2. If the statement in step 1 returns no results, run the following statement to determine whether a change order number is incorrectly assigned to the project in any tables.

    ```sql
    select PACHGORDNO, PATU, * from PA01301 where PAPROJNUMBER = '<Number>'
    ```

    > [!NOTE]
    > This statement identifies the cost categories to which change orders are assigned in the PA Budget Master table.
3. If the **PACHGORDNO** field is blank, the cost category is correct. If the **PACHGORDNO** field is populated, you receive the error message that is mentioned in the [Symptoms](#symptoms) section.
    > [!NOTE]
    > The value in the **PATU** field for any rows that return results in the **PACHGORDNO** field. You will use this information later.
4. Clear the value in the **PACHGORDNO** field from this table. To do it, run the following statement.

    ```sql
    update PA01301 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

Additionally, this incorrect change order number may be present in the cost transaction line tables. Use the value in the **PATU** field from step 3 to determine which of the following statements you have to run:

- If the value in the **PATU** field is **1**, view the PA Timesheet Line History table. To do it, run the following statement.

    ```sql
    select PACHGORDNO, * from PA30101 where PAPROJNUMBER = '<Number>
    ```

  - If the **PACHGORDNO** field is populated, run the following statement to clear the value.
  
      ```sql
      update PA30101 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
      ```

- If the value in the **PATU** field is **2**, view the PA Equipment Log Line History table. To do it, run the following statement.

    ```sql
    select PACHGORDNO, * from PA30201 where PAPROJNUMBER = '<Number>'
    ```

    If the **PACHGORDNO** field is populated, run the following statement to clear the value.

    ```sql
    update PA30201 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

- If the value in the **PATU** field is **3**, view the PA Miscellaneous Log Line History table. To do it, run the following statement.

    ```sql
    select PACHGORDNO, * from PA30301 where PAPROJNUMBER = '<Number>'
    ```

    If the **PACHGORDNO** field is populated, run the following statement to clear the value.

    ```sql
    update PA30301 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

- If the value in the **PATU** field is **4**, view the following tables:

  - PA PO Receipt Line History
  - PA Inventory Transfer Line History
  - PA PO Line History

    To do it, run the following statements:

    ```sql
    select PACHGORDNO, * from PA30601 where PAPROJNUMBER = '<Number>'
    ```

    ```sql
    select PACHGORDNO, * from PA31102 where PAPROJNUMBER = '<Number>'
    ```

    ```sql
    select PACHGORDNO, * from PA30901 where PAPROJNUMBER = '<Number>'
    ```

    If the **PACHGORDNO** field is populated in any of these tables, run the appropriate statement to clear the value:

    ```sql
    update PA30601 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

    ```sql
    update PA31102 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

    ```sql
    update PA30901 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

- If the value in the **PATU** field is **5**, view the PA Employee Expense Line History table. To do it, run the following statement.

    ```sql
    select PACHGORDNO, * from PA30501 where PAPROJNUMBER = '<Number>'
    ```

    If the **PACHGORDNO** field is populated, run the following statement to clear the value.

    ```sql
    update PA30501 set PACHGORDNO = '' where PAPROJNUMBER = '<Number>'
    ```

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. A fix for this issue was included in Microsoft Dynamics GP 10.0.
