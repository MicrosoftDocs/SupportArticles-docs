---
title: Cannot do year-end closing routine in GL
description: Describes a problem where you receive the error message Violation of PRIMARY KEY constraint PK##0671112. Provides a resolution.
ms.reviewer: bwick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Violation of PRIMARY KEY constraint 'PK##0671112'" error when doing year-end closing routine in General Ledger

This article provides a resolution for the issue that you can't do the year-end closing routine in General Ledger in Microsoft Dynamics GP due to the **Violation of PRIMARY KEY constraint 'PK##0671112'** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950019

## Symptoms

When you try to perform the year-end closing routine in General Ledger in Microsoft Dynamics GP, you receive the following error message:

> [Microsoft][ODBC SQL Server Driver][SQL Server]Violation of PRIMARY KEY constraint 'PK##0671112'. Cannot insert duplicate key in object '##0671112'

## Cause

The year-end closing transactions contain a currency that is not assigned to an account.

## Resolution

To resolve this problem, assign the currency to the appropriate account. To do this, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Restore a backup of the company database that was made before you tried to perform the General Ledger year-end closing routine.

3. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    Method 1: For SQL Server Desktop Engine

    If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    Method 2: For SQL Server 2000

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    Method 3: For SQL Server 2005

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

4. Run the following script against the company database:

    ```sql
    Select CURNCYID FROM GL20000
    ```

5. Make note of all currencies displayed in the **CURNCYID** column.
6. Start Microsoft Dynamics GP, and then sign in as user `'sa'`.

7. On the **Cards** menu, point to **Financial**, and then select **Account**.
8. In the **Account** field, type the retained earnings account number.

9. Select **Currency**.
10. In the Select Account Currencies window, select the **Currency ID** check boxes that you noted in step 5.
11. Perform the year-end closing routine in General Ledger.
