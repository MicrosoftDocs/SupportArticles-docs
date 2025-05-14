---
title: Project Status is out of range in script 
description: Provides a solution to an error that occurs when you look up a project number in Project Accounting in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, lmuelle, ppeterso
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Project Accounting
---
# "Index 0 of array '(R) Project Status' is out of range in script 'Project_Lookup_Scrolling_Window SCROLL_FILL'" Error message when you look up a project number in Project Accounting in Microsoft Dynamics GP 9.0

This article provides a solution to an error that occurs when you look up a project number in Project Accounting in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887947

## Symptoms

When you look up a project number in Project Accounting in Microsoft Dynamics GP 9.0, you receive the following error message:
> Unhandled script exception: Index 0 of array '(R) Project Status' is out of range in script 'Project_Lookup_Scrolling_Window SCROLL_FILL'. Script terminated

## Cause

This problem occurs if there's an incorrect value in the PA Status (PASTAT) field in the PA Project Master File table (PA01201).

## Resolution

> [!NOTE]
> You must be an administrator to perform the following procedure.

To resolve this problem, update the PA Status field in the PA Project Master File table. To do it, follow these steps:

1. Have all users exit Microsoft Dynamics GP, and then make a complete backup of Microsoft Dynamics GP.
2. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
3. Sign in to Microsoft SQL Server as the sa user.
4. In the database list, select the Microsoft Dynamics GP company database that you want to update.
5. In the query pane, type the following query:

    ```sql
    select * from PA01201 where PASTAT < '1' or PASTAT > '10'
    ```

6. Select **Execute Query**.
7. Use the correct PASTAT value to update the records that were returned in step 6. To do it, type the following query in the query pane:

    ```sql
    update PA01201 set PASTAT = 'x' where DEX_ROW_ID = 'zz'  
    ```

    > [!NOTE]
    >
    > - The *x* placeholder represents the status of the project. The *zz* placeholder for the `DEX_ROW_ID` value represents the row that you want to change.
    > - To determine the correct PASTAT value to use in the update statement in step 7, point to **Setup** on the **Tools** menu, point to **Project**, and then select **Status** to open the Access the Project Status - Setup Options window. This window lists the status options and the corresponding values that are available for the PA Status field. For example, a status of 1 equals an open status.

8. Select **Execute Query**.
