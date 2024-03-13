---
title: No transactions show
description: Describes a problem where the Select Bank Transactions window shows no transactions when you try to reconcile your checkbook in Bank Reconciliation.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# No transactions show when you open the Select Bank Transaction window in Microsoft Dynamics GP

This article provides a solution to an issue where the Select Bank Transactions window shows no transactions when you try to reconcile your checkbook in Bank Reconciliation.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 860314

## Symptoms

The Select Bank Transactions window shows no transactions when you try to reconcile your checkbook in Bank Reconciliation.

## Cause

This problem may occur for any of the following reasons:

- Bank Reconciliation isn't registered or marked in the Registration window.
- The Reconcile Number column (RECONUM) in the CM20200 table doesn't match the Reconcile Number column (RECONUM) in the CM20500 table.
- The transactions have already been reconciled. The specified transactions will now have a value of 1 flagging the transaction as already reconciled in Microsoft Dynamics GP. So it will no longer be pulled into the Select Bank Transactions window when you do reconciliation by selecting **Transactions**, pointing to **Financial**, selecting **Reconcile Bank Statements**, and then selecting **Transactions**.
- The records were in a damaged reconciliation.
- The SQL Sort Order/Collation isn't supported with Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow one of the methods below:

### Method 1

1. Verify that Bank Reconciliation is registered and marked in the Registration window. To do it, select **Tools** under Microsoft Dynamics GP, select **Setup**, select **System**, and select **Registration**. Scroll down in the Registration window and verify that Bank Reconciliation is listed and the checkbox is marked.

### Method 2

1. Verify that the transactions haven't yet been reconciled. To do it, follow these steps:

    1. Select **Inquiry**, select **Financial**, and then select **Checkbook Register**.
    2. Type or select the appropriate checkbook ID.
    3. On the **View** menu, select **by Date**, and then select the **From** field.
    4. Set the **From** field to have a zero value, and then type the date that is used as the bank statement ending date or cutoff date in the Reconcile Bank Statements window.
    5. Select **Redisplay**.
    6. Select **Show Details** to expand the provided information and verify that the **Reconciled** column is set to **Yes**. If the transactions aren't reconciled yet, and you're reconciling, the RECONUM field from the CM20500 table may be the reason that you don't see any transaction in the Select Bank Transactions window.

    In Microsoft Dynamics GP, a specific RECONUM value is assigned to the checkbook when information is entered in the Reconcile Bank Statements window. When a transaction is marked in the Select Bank Transactions window for this checkbook, then the RECONUM column for that transaction in the CM20200 table is populated with that same RECONUM value that is in the CM20500 table. If the RECONUM values in the CM20200 table and the CM20500 table aren't the same, then no transactions will be generated in the Select Bank Transactions window during the reconciliation process.

### Method 3

1. Verify the value of the Reconciliation Number matches between tables. To do it, follow these steps:
    1. Open SQL. To do it, do one of the following steps:
        - For SQL Server 2005, open SQL Server Management Studio, select **New Query**, and select the correct Company database.
        - For SQL Server 2008, open SQL Server Management Studio, select **New Query**, and select the correct Company database.
    2. Verify that the RECONUM field has the same value in the CM20200 table and the CM20500 table by running the following SQL statements.

        ```sql
        SELECT MAX(RECONUM) FROM CM20200 WHERE CHEKBKID = '**XXX**' 
        
        SELECT MAX(RECONUM) FROM CM20500 WHERE CHEKBKID = '**XXX**' 
        
        SELECT RECONUM FROM CM20500 
        WHERE CHEKBKID = '**XXX**' 
        and RECONUM = (select MAX(RECONUM) from CM20200 where CHEKBKID = '**XXX**') 
        ```

        > [!NOTE]
        > In these statements, the *XXX* placeholder represents the checkbook ID.

        Also run this script to see if there's a damaged or stuck recon for the checkbook ID:

        ```sql
        select distinct (RECONUM) from CM20200 where RECONUM not in (select RECONUM from CM20500) and RECONUM <> '0.00000' and CHEKBKID = 'xxx'
        ```

        ---where xxx is the checkbook ID you need

    3. > [!NOTE]
       > The results that are generated from the SQL query in step 2.
    4. Verify that the following statement is true:

        The maximum value of the RECONUM field from the CM20200 table that is generated from the first statement from step 2 is one number less than the maximum value of the RECONUM field from the CM20500 table that is generated from the second statement that is outlined in the same step.

    5. The result that is generated from the third statement that is outlined in step 3 returned with blank results. If statements from the previous step are verified to be true, run the following SQL query to further resolve the issue:

        ```sql
        update CM20500 set RECONUM = (select MAX(RECONUM) from CM20200 where CHEKBKID = '**XXX**') 
        where RECONUM = (select MAX(RECONUM) from CM20500 where CHEKBKID = '**XXX**') 
        ```

        > [!NOTE]
        > In this query, the *XXX* placeholder represents the checkbook ID.

1. Sign in to Microsoft Dynamics GP. Select **Transactions**, select **Financial**, and then select **Reconcile Bank Statements**. Select the checkbook ID, and then select **Transactions**. Verify that the transactions now show correctly in the Select Bank Transactions window.

### Method 4: Run check links

1. Make a backup or do it in a test company first. Under Microsoft Dynamics GP, point to **Maintenance** and select **Check Links**. Select the **Financial Series**. In the Logical Tables list, select **CM Transaction** and select **Insert** so it displays under Selected Tables. Select **OK**. Review the Error Log Report and if you agree with what it did, then you can do it in the live company.

1. Now check to see if the transactions show up in the Bank Reconciliation window.

### Method 5: SQL Collation

1. Run the below script in SQL Server Management Studio to check the SQL Sort Order and SQL Collation. In the results, find the line for the company that you're working with and drag the Status field out so you can read the data in this field. Verify that the Collation and SQLSortOrder are a supported version. (SQL Sort Order should be 50 or 52). The window may not populate if you aren't on a supported version.

    ```sql
    SP_Helpdb
    ```
