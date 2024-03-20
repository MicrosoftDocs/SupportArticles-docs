---
title: Error when you drill back to Payables Management document
description: Provides a solution to an error that occurs when you drill back to a Payables Management document in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, kriszree
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Error when you drill back to a Payables Management document in Microsoft Dynamics GP: Unhandled script exception Index 0

This article provides a solution to an error that occurs when you drill back to a Payables Management document in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864598

## Symptoms

When you drill back to a Payables Management document in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> Unhandled script exception Index

## Cause

This problem occurs if the PM Key Master File (PM00400) table contains records that have incorrect Document Type (**DocType**) values.

The following are valid Document Type values in the PM00400 table:

- 1 = Invoice
- 2 = Finance Charge
- 3 = Miscellaneous Charge
- 4 = Return
- 5 = Credit Memo
- 6 = Payment
- 7 = Scheduled Payment

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

        If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

2. Run the following script against the company database to identify records that have an invalid Document Type value:

    ```sql
    Select DEX_ROW_ID, * from PM00400 where DocType < '1' or DocType > '8'
    ```

3. Run the following script against the company database to set the value in the **DocType** field to the correct value:

```sql
Update PM00400 set DOCTYPE = 'value' where DEX_ROW_ID = 'value2'
```

> [!NOTE]
> Replace the *value* placeholder with the appropriate value for the **DocType** field. Replace the *value2* placeholder with the **DEX_ROW_ID** value from step 2.
