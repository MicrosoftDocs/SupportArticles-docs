---
title: Error when printing a GL TB detail report
description: Provides a solution to errors that occur when you print a General Ledger Trial Balance (TB) detailed report.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "Divide by zero" Error message when you print a General Ledger Trial Balance detail report in Microsoft Dynamics GP

This article provides a solution to errors that occur when you print a General Ledger Trial Balance (TB) detailed report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 8989851

## Symptoms

When you print a General Ledger Trial Balance (TB) detailed report, you may receive the following error message in Microsoft Dynamics GP:

> [Microsoft][ODBC SQL Server Driver][SQL Server]Divide by zero.

or

> [Microsoft][ODBC SQL Server Driver][SQL Server]Divide by zero error encountered.

After you select **OK**, you receive another error message that is similar to the following message:

> The stored procedure glprinttrialbalancereport returned the following results: DBMS: 8134, Great Plains: 0

## Cause

The following options may be selected for your computer that is running Microsoft SQL Server on the Connections tab in SQL Server Management Studio:

- ANSI Warnings
- Arithmetic Abort

> [!NOTE]
> These options aren't selected be default.

## Resolution

Clear the options that are listed in the [Cause](#cause) section. To do it, follow these steps:

1. Open SQL Server Management Studio and right-click your instance of Microsoft SQL Server in the Object Explorer section, and then select **Properties**.  
2. In the **Select a Page** list, select the **Connections** tab.  
3. Unmark (or set to False) the following two options in the Default Connections Options section:
    - ANSI Warnings
    - Arithmetic Abort
4. Select **OK** to close the window.  
5. In Object Explorer again, expand **Databases** and right-click on the Company database that has the issue and select **Properties**.  
6. Select the **Options** tab.  
7. In the **Miscellaneous** section, make sure the **Arithmetic Abort Enabled** option is set to **False**.  
8. Select **OK** to close the window.  

> [!NOTE]
> Examine the options for the data source that you use with GP. Make sure that the options for the data source on the computer are the same as the options that are required to create a data source for Microsoft Dynamics GP. For more information about how to create a data source for Microsoft Dynamics GP, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/help/870416).
