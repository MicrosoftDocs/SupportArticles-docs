---
title: You must enter a step/grade value
description: Provides a solution to an error that occurs when you assign a pay code to an employee in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, ryanklev
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# "You must enter a step/grade value before this record can be saved" Error message when you assign a pay code to an employee in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you assign a pay code to an employee in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 947426

## Symptoms

When you assign a pay code to an employee in the Employee Pay Code Maintenance window in Microsoft Dynamics GP, you receive the following error message:
> You must enter a step/grade value before this record can be saved.

## Cause

This problem occurs because the Pay Steps functionality is enabled in Human Resources in Microsoft Dynamics GP.

## Resolution

If you aren't using the Pay Steps functionality, disable the Pay Steps functionality in Human Resources. To do it, use one of the following methods.

### Method 1: You haven't already used the Pay Steps functionality

1. Use the appropriate method:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Human Resources Preferences**.
   - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Human Resources Preferences**.
2. Select to clear the **Use Pay Steps/Grades** check box.
3. Select **OK**.
4. Verify that you can now assign pay codes to your employees in the Employee Pay Code Maintenance window.

To open the Employee Pay Code Maintenance window, point to **Payroll** on the **Cards** menu, and then select **Pay Code**.

### Method 2: You've already used the Pay Steps functionality

> [!NOTE]
> If you plan to use the Pay Steps functionality in Human Resources, do not follow these steps.

1. Have all users exit Microsoft Dynamics GP.
2. Back up the DYNAMICS database.
3. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

4. Run the following scripts against the DYNAMICS database.

    ```sql
    Update SUSPREF set POINTS_I = 0 where IINDEX_I = 7000
    ```

    ```sql
    Update SUSPREF set POINTS_I = 1 where IINDEX_I = 7001
    ```

5. Verify that you can now assign pay codes to your employees in the Employee Pay Code Maintenance window.

    To open the Employee Pay Code Maintenance window, point to **Payroll** on the **Cards** menu, and then select **Pay Code**.
