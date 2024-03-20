---
title: Account assigned to transaction is missing
description: Provides a solution to an error that occurs when you run the General Ledger Year-End Closing routine in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "Account assigned to a transaction is missing" Error message when you run the General Ledger Year-End Closing routine in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run the General Ledger Year-End Closing routine in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855209

## Symptoms

When you run the **Year-End Closing** routine in General Ledger in Microsoft Dynamics GP, you receive the following error message:

> Account assigned to a transaction is missing.

## Cause

The error occurs if there are transactions in the General Ledger Open table (GL20000) that have an account index value that isn't present in the Account Master Table (GL00100).

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you've a complete backup copy of the database that you can restore if a problem occurs.

To resolve the error, follow one of these methods:

### Method 1: Use a query tool to locate the transaction

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    **Method 4**: For SQL Server 2008

    If you're using SQL Server 2008, start SQL Management Studio. to do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.  

2. Run the following statement against the company database.

    ```sql
    select JRNENTRY, ACTINDX from GL20000 where ACTINDX not in (select ACTINDX from GL00100) 
    ```

    This script lists the journal entries that have an **ACTINDX** value that isn't present in the GL00100 (Account Master) table.

3. > [!NOTE]
   > The journal entry (JRNENTRY) numbers that are returned. Then, remove these entries.

### Method 2: Use Report Writer to identify the transaction

To use Report Writer to identify the transaction, follow these steps.

#### Step 1: Create the report

1. Start Report Writer. To do it, follow the steps for your version of the program.
   - Microsoft Dynamics GP 10.0

      On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then select **Report Writer**.
   - Microsoft Dynamics GP 9.0

      On the **Tools** menu, point to **Customize**, and then select **Report Writer**.

2. In the **Product** list, select **Microsoft Dynamics GP**. Then, select **OK**.

3. Select **Reports**, and then select **New**.
4. In the Report Definition window, specify the following settings:
   - **Report Name**: **YTD Transaction Dump**  
   - **Series**: **Financial**  
   - **Main Table**: **Year-to-Date Transaction Open**  
   - **Using Key**: **GL_YTD_TRX_OPEN_Key1**  
   - In the **Format Options** area, select to clear the **Skip Blank Records** check box.

5. In the Report Definition window, select **Tables**.
6. In the **Tables** list, select **Year-to-Date Transaction Open**. Then, select **New**.
7. Double-click **Account Master**.
8. Select **Close** to close the Report Table Relationships window.
9. In the Report Definition window, select **Sort**.
10. In the **Report Table** list, select **Account Master**.
11. In the **Table Fields** list, select **Account Number**, select **Insert**, and then select **OK**.

#### Step 2: Add the new fields to the report

1. Select **Layout**.
2. In the Toolbox window list, select **Year-to-Date Transaction Open**.
3. Drag the **Account Index** field and the **Journal Entry** field to the **Body** (B) section of the report.
4. In the Toolbox window list, select **Account Master**.
5. Drag the **Account Number** field to the **Body** (B) section of the report.

#### Step 3: Save and print the report

1. Close the report layout, and then close the Report Definition window. Select **Save** when you're prompted to save changes.
2. In the **Modified Reports** list, select **YTD Transaction Dump**, and then select **Print**.

    > [!NOTE]
    > The records that print at the top of the report don't have account numbers assigned to them. Note the journal entry numbers. Then, remove these entries.
