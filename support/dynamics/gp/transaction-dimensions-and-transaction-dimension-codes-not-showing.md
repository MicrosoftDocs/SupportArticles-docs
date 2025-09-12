---
title: Transaction dimensions and transaction dimension codes not show
description: Describes a problem where transaction dimensions and transaction dimension codes do not display in the Transaction Dimension lookup window in Analytical Accounting in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Analytical Accounting
---
# Transaction dimensions and transaction dimension codes do not display in the Transaction Dimension lookup window in Analytical Accounting

This article provides a resolution for the issue that transaction dimensions and transaction dimension codes don't show in the Transaction Dimension lookup window in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954627

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you select the **Trx Dimension** lookup button in the Account Access to Transaction Dimension Codes window in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0, transaction dimensions and transaction dimension codes don't display.

## Resolution

To resolve this problem, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. Use one of the following methods depending on the program that you're using.

   Method 1: For SQL Server Desktop Engine

   If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

   Method 2: For SQL Server 2000

   If you're using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

   Method 3: For SQL Server 2005

   If you're using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

2. Run the following statement against the company database to see if any dimension IDs are linked to the Accounting Class:

    ```sql
    select * from AAG00202 a join AAG00400 b on a.aaTrxDimID = b.aaTrxDimID
    ```

    If results are returned, dimensions codes are linked to the class ID. Dimension codes must be linked to a Class ID for transaction dimensions and transaction dimension codes to display in the Transaction Dimension lookup window.

3. If no results were returned in step 2, then link the dimension codes to the Class ID in the Accounting Class Link window. To open the Accounting Class Link window, on the **Cards** menu, point to **Financial**, point to **Analytical Accounting**, and then select **Accounting Class Link**. Select a Class ID and mark to link the accounts as appropriate.

4. In the Accounting Class Maintenance window, select an Analysis Type for each Trx Dimension linked to the Class ID. This window is on the **Cards** menu, point to **Financial**, point to **Analytical Accounting**, and then select **Accounting Class**. Select one of the following options for the Analysis Type field:

    - **Required**
    - **Optional**
    - **Fixed**

5. Select **Save**.
