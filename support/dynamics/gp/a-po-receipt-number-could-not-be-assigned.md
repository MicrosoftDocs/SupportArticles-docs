---
title: A PO/receipt number could not be assigned
description: Provides a solution to an error that occurs when you select the PO Number field in the Purchase Order Entry window or when you select the Receipt No. field in the Receivings Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# "A unique PO/receipt number couldn't be assigned" Error message when you select the PO Number field in the Purchase Order Entry window or when you select the Receipt No. field in the Receivings Transaction Entry window in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you select the PO Number field in the Purchase Order Entry window or when you select the Receipt No. field in the Receivings Transaction Entry window in Microsoft Dynamics GP.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968056

## Symptoms

When you select the **PO Number** field in the Purchase Order Entry window in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:
> A unique PO number couldn't be assigned. Check the Next Number field in the Purchase Order Processing Setup window.

Or, when you select the **Receipt No.** field in the Receivings Transaction Entry window in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> A unique receipt number couldn't be assigned. Check the Next Number field in the Purchase Order Processing Setup window.

## Cause

This problem has one or more of the following causes:

### Cause 1

The next purchase order number or the next receipt number in the Purchase Order Processing Setup window has already been used. To resolve this problem, see [resolution 1](#resolution-1-increase-the-next-purchase-order-number-or-the-next-receipt-number-by-one).

### Cause 2

The **Next Number** field for purchase orders or for receipts in the Purchase Order Processing Setup window doesn't contain enough leading zeros to increment to the next number. To resolve this problem, see [resolution 1](#resolution-1-increase-the-next-purchase-order-number-or-the-next-receipt-number-by-one) and [resolution 2](#resolution-2-add-leading-zeros-to-the-next-purchase-order-or-receipt-number).

### Cause 3

The regional and language options on the workstation differ from those settings on the server. To resolve this problem, see [resolution 3](#resolution-3-change-the-regional-format-options-and-language).

### Cause 4

The data in the Purchase Order Processing Setup window is damaged. See [resolution 4](#resolution-4-change-the-purchasing-setup-table-table).

## Resolution

To resolve this problem, use one of the following resolutions.

### Resolution 1: Increase the next purchase order number or the next receipt number by one

To use this method, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    **Method 4**: For SQL Server 2008

    If you're using SQL Server 2008, start SQL Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Run the following scripts against the company database to determine the largest purchase order number that is used.

    ```sql
    SELECT max (PONUMBER) as 'max po number: WORK' FROM POP10100
    SELECT max (PONUMBER) as 'max po number: HIST' FROM POP30100
    ```

    Run the following scripts against the company database to determine the largest receipt number that is used.

    ```sql
    SELECT max (POPRCTNM) as 'max receipt number: WORK' FROM POP10300 
    SELECT max (POPRCTNM) as 'max receipt number: HIST' FROM POP30300
    ```

3. Run the following scripts against the company database to determine the next purchase order number.

    ```sql
    SELECT PONUMBER as 'next PO number' FROM POP40100
    ```

    Run the following scripts against the company database to determine the next receipt number.

    ```sql
    SELECT POPRCTNM as 'next receipt number' FROM POP40100
    ```

    > [!NOTE]
    >
    > - Table POP10100 is the Purchase Order Work table.
    > - Table POP30100 is the Purchase Order History table.
    > - Table POP10300 is the Purchasing Receipt Work table.
    > - Table POP30300 is the Purchasing Receipt History table.
    > - Table POP40100 is the Purchasing Setup Table table.

4. In the Purchase Order Processing Setup window, make sure that the next purchase order number or the next receipt number is greater than the value that you obtained in step 2.
5. Use the appropriate method for your version of the program:

    - Microsoft Dynamics GP 10.0

        Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.
    - Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0

        Select **Tools**, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.

### Resolution 2: Add leading zeros to the next purchase order or receipt number

If the purchase order number or the receipt number doesn't increment, add leading zeros to the next purchase order number or to the next receipt number. To do it, follow these steps:

1. Use the appropriate method for your version of the program:

    - Microsoft Dynamics GP 10.0

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.
    - Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0

        On the **Tools** menu, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing.**
2. In the **Next Number** column, enter leading zeros to the values in the following fields:
    - **Purchase Orders**
    - **Receipts**
3. Select **OK**.

### Resolution 3: Change the regional format options and language

Change the regional format options and language so that the settings match the same settings on the server. To do it, follow these steps:

1. On the workstation, select **Start**, and then select **Run**.
2. Type intl.cpl , and then select **OK**.
3. Repeat steps 1 and 2 on the server.
4. Verify that the settings in the **Regional and Language Options** window on the workstation match the same settings on the server.

### Resolution 4: Change the Purchasing Setup Table table

Change the Purchasing Setup Table table to resolve the problem. You can either use the Enable Identity Insert option to avoid duplicate records, or you can re-create the table. To do it, use the appropriate method.

#### Method 1: Avoid duplicate records in the Purchasing Setup Table table (POP40100)

To avoid duplicate records in the Purchasing Setup Table table (POP40100) in the future, select the **Enable Identity Insert** option when you use Data Transformation Services (DTS) or the SQL Server Import and Export Wizard to transfer data from one database to another database.

#### Method 2: Re-create the Purchasing Setup Table table (POP40100)

> [!NOTE]
>
> - Before you use this method, you must have all users log off Microsoft Dynamics GP and Microsoft Great Plains 8.0.
> - Before you use this method, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.To re-create the Purchasing Setup Table table, use one of the following methods.

#### Method 2A: Use the Professional Services Tools Library (PSTL) toolkit

1. Install the PSTL toolkit. To do it, follow these steps:
    1. For more information about the Professional Services Tools Library, use one of the following options:

        Customers:  
        For more information about PSTL, contact your partner of record. If you don't have a partner of record, visit [Microsoft Pinpoint](https://www.microsoft.com/solution-providers/home) to identify a partner.

        Partners:  
        For more information about PSTL, visit [Partner Network](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem).

    2. Copy the Professional Services Tools Library .cnk file to the Microsoft Dynamics GP directory or the Microsoft Great Plains 8.0 directory on the computer that is running Microsoft Dynamics GP or Microsoft Great Plains 8.0.
    3. Sign in to Microsoft Dynamics GP or to Microsoft Great Plains 8.0. When you're prompted to include new code, select **Yes**.
2. Select the PSTL toolkit shortcut on the shortcut bar to initialize the tables.

    > [!NOTE]
    > If the PSTL toolkit shortcut does not appear on the shortcut bar, add the shortcut. To do this, follow these steps:

    1. Use the appropriate method for your version of the program.

        - Microsoft Dynamics GP 10.0

            Select **Layout**. Make sure that the **Navigation Pane** option is selected.
        - Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0

            Select **View**, and then select **Navigation Pane**.

    2. Use the appropriate method for your version of the program.
        - Microsoft Dynamics GP 10.0

            Right-click **Shortcuts**, point to **Add**, and then click **Add Window**.
        - Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0

            Select **Add**, and then select **Other Window**.
    3. Expand **Technical Service Tools**, expand **Project**, select **Professional Services Tools Library**, and then select **Add**.
    4. Select **Done**.
3. When you're prompted to enter utilities registration code, select **OK**.
4. Select **Toolkit**, and then select **Next**.
5. Select **Recreate SQL Objects**, and then select **Next**.
6. In the **Series** list, select **Purchasing**.
7. In the **Table** list, select table POP40100.
8. Select **Recreate Selected Table**.
9. Select the **Recreate data for selected table(s)** check box.
10. Select **Perform Selected Maintenance**.

#### Method 2B: Run the SQL Maintenance function

1. Print the POP Setup List report to obtain the current setup information. To do it, follow these steps:
    1. Select **Reports**, point to **Purchasing**, and then select **Setup/Lists**.
    2. In the Purchasing Setup Reports window, select **Purchase Order Proc Setup** in the **Reports** list, specify the report option, and then select **Print**.
    > [!NOTE]
    > The Purchasing Setup Table table will remain empty until the information is re-entered in the Purchase Order Processing Setup window.
2. Use the appropriate method for your version of the program.

    - Microsoft Dynamics GP 10.0

        Point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **SQL**.
    - Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0

        Point to **Maintenance** on the **File** menu, and then select **SQL**.
3. In the **Database** list, select the company database that you use.
4. In the **Name** column, select **Purchasing Setup Table**.
5. Select the following check boxes:

    - **Recompile**  
    - **Update Statistics**  
    - **Drop Table**  
    - **Create Table**  
    - **Drop Auto Procedure**  
    - **Create Auto Procedure**
6. Select **Process**.
